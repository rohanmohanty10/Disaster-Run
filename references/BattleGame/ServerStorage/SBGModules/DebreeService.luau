--!strict
-- ServerStorage > SBGModules > DebreeService   (ModuleScript, server only)
-- Children: Split, Registry, Stream (ModuleScripts)
--
-- The server side of Debree, JJS-style map destruction. The server decides everything
-- and every client just draws (see ReplicatedStorage.Modules.Debree.DebreeController):
--   * splits block parts into grid cells around a hit (Split),
--   * keeps an invisible-to-clients physics copy ("body") of every piece under the
--     server's camera, so pieces are solid on the server and can be hit again,
--   * launches wall debris along the attacker's look direction and lets ground debris
--     settle in place, streaming positions to clients at Config.PhysicsHz,
--   * puts every part back Config.ResetTime seconds after it was last hit,
--   * sends the whole destroyed state to players who join late.
--
-- Started by ServerScriptService > DebreeInit. Moves call:
--
--   local DebreeService = require(ServerStorage.SBGModules.DebreeService)
--   DebreeService.Destroy(HitCFrame, HitSize, {
--       Shape = "Ball",                       -- "Box" (default) or "Ball"; Enum.PartType works too
--       Mode = "Auto",                        -- "Auto" (default), "Ground" or "Wall"
--       Direction = HumRP.CFrame.LookVector,  -- where wall pieces go (flattened); default: the
--                                             -- attacker's look direction, else away from the hit.
--                                             -- Aimed down (a slam, e.g. Vector3.new(0, -1, 0)):
--                                             -- wall pieces are driven down into what's under them
--       Power = 18, Lift = 1,                 -- wall speed and upward speed (defaults: Config)
--       Bounce = 0,                           -- ground pieces' up speed in studs/s: 0 = crack in
--                                             -- place, > 0 = pop, < 0 = pushed down. When moving, a
--                                             -- floor broken right through drops its pieces (JJS)
--       Outward = false,                      -- true = wall pieces are blown away from the hit's
--                                             -- centre (explosions, slams) instead of along Direction.
--                                             -- With a negative Power they're pulled into it instead
--       GroundOutward = false,                -- true = floor pieces are blown up and away from the
--                                             -- hit's centre too (explosions), instead of cracking in place
--       Destroyed = 0,                        -- share (0-1) of the broken pieces that are removed
--                                             -- completely, no debris: 0.5 = half of them. Fewer pieces,
--                                             -- less lag. They come back at the reset like the rest
--       Hollow = nil,                         -- a size: nothing inside that volume (same shape and
--                                             -- CFrame, smaller than HitSize) breaks, only the shell
--                                             -- around it. After an Erase of the same volume, that's
--                                             -- a crater with a broken rim
--       GridSize = nil,                       -- wall piece size in studs (default Config.GridSize)
--       GroundGridSize = nil,                 -- floor piece size in studs (default Config.GroundGridSize).
--                                             -- A part that's already broken keeps its first size
--                                             -- until it resets, so its pieces stay lined up
--       Attacker = Player,                    -- Player or character Model
--       Silent = false,                       -- true = no debris sounds
--   })
--
--   DebreeService.Erase(HitCFrame, HitSize, { Shape = "Box", GridSize = nil, GroundGridSize = nil })
--       -- obliterates everything in the volume with no debris (ultimates like WhiteBeard's
--       -- Tsunami, JJS's Hollow Purple). Parts partly inside are cut along it. The ground in
--       -- Destroyable.Map.Floor stays (IncludeGround = true: it goes too, a crater down to the
--       -- unbreakable map underneath). Decor that hits leave alone goes too (leaves, bushes;
--       -- CanCollide or CanQuery off). Everything comes back at the usual reset. GridSize and
--       -- GroundGridSize set the grid parts are cut on, so a Destroy right after (a Hollow rim)
--       -- breaks what's left into pieces of that size.
--
-- Rules for what breaks (anything under workspace.World.Map.Destroyable):
--   * Models whose SpecialType attribute is in SPECIAL_TYPES (trees) never split: SpecialDestruction
--     breaks them whole (Erase hides them whole), and they come back after Config.ResetTime.
--   * Block Parts split into pieces. Everything else (MeshParts, Unions, wedges, cylinders)
--     up to Config.LooseMaxSize studs is launched whole as the real part, and put back at
--     the reset; bigger ones, and ground ones, stay intact.
--   * Skipped: unanchored parts, CanCollide-off parts (Config.IgnoreNonCollidable),
--     invisible parts, seats, spawn locations, anything inside a "Throwable"-tagged model,
--     anything in a model with a Humanoid, and parts with a DebreeIgnore attribute.
--   * Mode "Auto": a part is a floor (ground) if it's under Destroyable.Map.Floor, or it's
--     floor-shaped (a slab lying flat, or tilted at most Config.GroundMaxSlope; see
--     IsGroundSlab) or the same layer as a floor right beside it (FlushWithFloor), and the
--     attacker stands on it rather than in front of it (Config.GroundStepUp). Everything
--     else, ramps and stairs included, is a wall.
--   * A sideways hit (any Direction but down) doesn't break wall-type parts or wall debris
--     below the attacker's feet: punching on stairs leaves the step you stand on alone (JJS).
--     Floors still crack, and a slam breaks what's under you.

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local Shared = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Debree")
local Config = require(Shared:WaitForChild("Config"))
local Materials = require(Shared:WaitForChild("Materials"))

local Split = require(script:WaitForChild("Split"))
local Registry = require(script:WaitForChild("Registry"))
local BuildingRemains = require(script:WaitForChild("BuildingRemains"))
local BuildingDebris = require(script:WaitForChild("BuildingDebris"))
local BuildingMotion = require(script:WaitForChild("BuildingMotion"))
local TsunamiDestruction = require(script:WaitForChild("TsunamiDestruction"))
local Stream = require(script:WaitForChild("Stream"))
local SpecialDestruction = require(script.Parent:WaitForChild("SpecialDestruction"))

-- SpecialType models SpecialDestruction breaks instead of Debree. Only types listed here are handed
-- over; every other SpecialType (Bush, Wood Object, Weapon...) keeps breaking the normal Debree way.
local SPECIAL_TYPES: { [string]: boolean } = {
	Tree = true,
	Weapon = true,
	["Weapon Barrel"] = true,
	["Bottle Shelf"] = true,
	
}

type Piece = Registry.Piece
type Group = Registry.Group
type Mode = Registry.Mode

export type Options = {
	Shape: ("Box" | "Ball" | "Oval" | Enum.PartType)?,
	Mode: ("Auto" | "Ground" | "Wall")?,
	Direction: Vector3?,
	Power: number?,
	Lift: number?,
	Bounce: number?,
	GridSize: number?,
	GroundGridSize: number?,
	Attacker: (Player | Model)?,
	Silent: boolean?,
	Outward: boolean?,
	GroundOutward: boolean?,
	Destroyed: number?,
	KeepGround: boolean?, -- true = floors are left alone (anything that would break as Ground, and
	-- rubble from floors broken earlier); walls and props still break
	Hollow: Vector3?,
	IgnoreBuildings: boolean?, -- tsunami checkpoint: handled by SweepBuildingRemains
	IgnoreTrees: boolean?, -- keep the startup shock from invoking the old tree shatter
}

-- A non-block part that was launched whole.
type Loose = { CFrame: CFrame, ResetAt: number, LastLaunch: number }

-- Everything one Destroy call collects. Pieces are launched and sent at the end, once
-- every original touched by the hit is hidden and every new piece exists.
type QueuedLaunch = { Piece: Piece, IsNew: boolean }
type Batch = {
	Created: { Piece },
	Removed: { number },
	Sounded: { number },
	LooseSounds: { BasePart },
	Launches: { QueuedLaunch },
}

local DebreeService = {}

local Started = false
local Destroyable: Instance
local FloorFolder: Instance? -- Destroyable.Map.Floor: everything in it is floor
local Hidden: Folder
local Bodies: Folder
local QueryParams: OverlapParams
local SolidParams: OverlapParams -- everything a launched piece can collide with: the whole map and all pieces
local GhostParams: OverlapParams
local DownRay: RaycastParams
local SolidRay: RaycastParams -- the map and all pieces, solid parts only
local BodyGroup = "Default" -- moving pieces: characters pass through them on the server
local StaticBodyGroup = "Default" -- still pieces: characters stand on them (see Config.StaticBodyCollisionGroup)
local BoxQuery: Part
local BallQuery: Part
local PointQuery: Part -- a tiny ball, for "is this point inside something solid"
local DeepQuery: Part -- a piece shrunk by GHOST_DEPTH, for "what is it deep inside"
local FeetRay: RaycastParams
local FloorRay: RaycastParams -- breakable parts and pieces, for "is there a floor right beside this part"
local FlushFloors: { [BasePart]: boolean } = {} -- parts found flush with a floor during this Destroy call
-- Breakable parts with CanQuery off (tree leaves): spatial queries never find them, so Erase
-- checks these by position instead.
local Unqueryable: { [BasePart]: boolean } = {}
local Rng = Random.new()

local ActiveGroups: { [Group]: boolean } = {}
local GroupsByOriginal = {}
local Moving: { [Piece]: boolean } = {}
local Announcing: { [Piece]: boolean } = {} -- settled pieces whose final position is still being (re)sent
local LooseParts: { [BasePart]: Loose } = {}
local DensityCache: { [Enum.Material]: number } = {}
local LaunchingNow: { [BasePart]: boolean } = {} -- bodies launching in the current Destroy call
local LaunchedFrom: { [Piece]: Vector3 } = {} -- where a wall piece was last launched from (TipOff)
-- Moving pieces whose last record was a normal move record. JJS's client draws those 1.5x as
-- far (Config.MoveOvershoot), so a piece that stops hard is drawn inside whatever stopped it;
-- PhysicsTick sends it its exact spot (a settle-style record) as soon as it stops.
local Overshot: { [Piece]: boolean } = {}
-- Roblox uses the FrictionWeight-weighted average of two touching parts' frictions, and caps
-- FrictionWeight at 100 (a higher value is clamped, with a warning in Output each time). That's
-- Config.BodyWeight too, so a slick piece on another piece slides on the average of the two
-- frictions; the stacking behaviour was measured and tuned that way.
local SLICK_WEIGHT = 100
local Tipped: { [Piece]: number } = {} -- how often a piece that stopped on top of another was tipped off it

local PhysicsClock, ResetClock = 0, 0
local WarnedFull = false
local NO_RESENDS: { number } = {}

------------------------------------------------------------------------
-- Small helpers
------------------------------------------------------------------------

local function TransparencyKey(Transparency: number): string
	return tostring(math.round(Transparency * 1000) / 1000)
end

local function ColorKey(Color: Color3): string
	return `{math.round(Color.R * 255)},{math.round(Color.G * 255)},{math.round(Color.B * 255)}`
end

local function Density(Material: Enum.Material): number
	local Cached = DensityCache[Material]
	if not Cached then
		Cached = PhysicalProperties.new(Material).Density
		DensityCache[Material] = Cached
	end
	return Cached
end

-- A piece's physical properties: its material's density, with the given friction.
local function Physics(Material: Enum.Material, Friction: number): PhysicalProperties
	return PhysicalProperties.new(Density(Material), Friction, Config.BodyElasticity, Config.BodyWeight, Config.BodyWeight)
end

local function Flat(Vector: Vector3): Vector3?
	local Flattened = Vector3.new(Vector.X, 0, Vector.Z)
	if Flattened.Magnitude < 1e-3 then
		return nil
	end
	return Flattened.Unit
end

local function TransformChanged(A: CFrame, B: CFrame): boolean
	if (A.Position - B.Position).Magnitude > Config.MoveEpsilon then
		return true
	end
	-- small-angle rotation difference, measured on the rotated axes
	local Turn = math.max((A.XVector - B.XVector).Magnitude, (A.YVector - B.YVector).Magnitude, (A.ZVector - B.ZVector).Magnitude)
	return Turn > Config.TurnEpsilon
end

local function Unanchor(Body: BasePart)
	Body.Anchored = false
	pcall(Body.SetNetworkOwner, Body, nil) -- the server simulates every piece
end

local function ResolveShape(Shape: any): Split.Shape
	if Shape == "Ball" or Shape == Enum.PartType.Ball then
		return "Ball"
	elseif Shape == "Oval" then
		return "Oval"
	end
	return "Box"
end

-- The launch direction for this call, or nil to push each piece away from the hit (Outward,
-- or no attacker to face along). It's flat, except for a Direction aimed down (a slam), which
-- drives wall pieces straight down.
local function ResolveDirection(Options: Options): Vector3?
	if Options.Outward then
		return nil
	end
	local Requested = Options.Direction
	if Requested then
		if Requested.Magnitude > 1e-3 and Requested.Unit.Y < -0.7 then
			return -Vector3.yAxis
		end
		return Flat(Requested)
	end
	local Attacker = Options.Attacker
	local Character: Instance? = if typeof(Attacker) == "Instance" and Attacker:IsA("Player")
		then (Attacker :: Player).Character
		else Attacker :: any
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if Root and Root:IsA("BasePart") then
		return Flat(Root.CFrame.LookVector)
	end
	return nil
end

-- Erasing = for Erase, which also takes CanCollide-off decor (leaves): it makes no debris of it.
-- Grass uses normal voxel destruction, including non-collidable decoration.
-- The nearest SpecialType attribute on the part or its ancestors decides.
local function IsGrass(Part: BasePart): boolean
	local Current: Instance? = Part
	while Current and Current ~= Destroyable do
		local SpecialType = Current:GetAttribute("SpecialType")
		if SpecialType ~= nil then
			return SpecialType == "Grass"
		end
		Current = Current.Parent
	end
	return false
end

local function ShouldSkip(Part: BasePart, Erasing: boolean?): boolean
	if not Part.Anchored or Part.Transparency >= 1 then
		return true
	end
	if Config.IgnoreNonCollidable and not Part.CanCollide and not Erasing and not IsGrass(Part) then
		return true
	end
	if Part:IsA("Seat") or Part:IsA("VehicleSeat") or Part:IsA("SpawnLocation") then
		return true
	end
	if Part:GetAttribute("DebreeIgnore") or Part:HasTag("Throwable") then
		return true
	end
	local Ancestor = Part.Parent
	while Ancestor and Ancestor ~= Destroyable do
		if Ancestor:HasTag("Throwable") or Ancestor:FindFirstChildOfClass("Humanoid") then
			return true
		end
		Ancestor = Ancestor.Parent
	end
	return false
end

-- The whitelisted SpecialType model a part belongs to (trees are Tree > Trunk/Leaves > parts), or nil.
-- The nearest ancestor with a SpecialType decides: a non-whitelisted one means Debree handles the part.
local function SpecialModelOf(Part: BasePart): Model?
	local Ancestor: Instance? = Part.Parent
	while Ancestor and Ancestor ~= Destroyable do
		local Type = Ancestor:GetAttribute("SpecialType")
		if Type ~= nil then
			if typeof(Type) == "string" and SPECIAL_TYPES[Type] and Ancestor:IsA("Model") then
				return Ancestor :: Model
			end
			return nil
		end
		Ancestor = Ancestor.Parent
	end
	return nil
end

-- SpecialDestruction needs a Player (network owner, camera shake); Debree callers pass a Player or a character.
local function AttackerPlayer(Attacker: any): Player?
	if typeof(Attacker) ~= "Instance" then
		return nil
	end
	if Attacker:IsA("Player") then
		return Attacker
	end
	return Players:GetPlayerFromCharacter(Attacker)
end

-- Hands each special model to SpecialDestruction with Debree's reset time, so it comes back with the
-- map around it. DestroyAll = hide it whole (Erase). Returns how many models were handed over.
local function BreakSpecials(Models: { [Model]: boolean }, HitPosition: Vector3, Attacker: any, DestroyAll: boolean): number
	local Count = 0
	if next(Models) == nil then
		return Count
	end
	local Player = AttackerPlayer(Attacker)
	local Params = if DestroyAll then { DestroyAll = true } else nil
	for Model in Models do
		SpecialDestruction.process(Model, HitPosition, Player, Config.ResetTime, Params)
		Count += 1
	end
	return Count
end

local function IsSplittable(Part: BasePart): boolean
	-- ClassName, not IsA: Seat and SpawnLocation are Parts too
	return Part.ClassName == "Part" and (Part :: Part).Shape == Enum.PartType.Block
end

-- Floor-shaped: a slab whose thinnest side faces up (tilted at most Config.GroundMaxSlope) and
-- that's wide in both other directions: at least Config.GroundMinSpan (and twice its
-- thickness), or, for a thin slab, Config.GroundThinRatio times its thickness (road lines,
-- curbs, planks). Bars and beams stay walls.
local function IsGroundSlab(Part: BasePart): boolean
	local CF, Size = Part.CFrame, Part.Size
	local Directions = { CF.XVector, CF.YVector, CF.ZVector }
	local Lengths = { Size.X, Size.Y, Size.Z }
	local Thin = 1
	for Index = 2, 3 do
		if Lengths[Index] < Lengths[Thin] then
			Thin = Index
		end
	end
	local Thickness = Lengths[Thin]
	if math.abs(Directions[Thin].Y) < math.cos(math.rad(Config.GroundMaxSlope)) or Thickness > Config.GroundMaxThickness then
		return false
	end
	local MinSpan = math.min(math.max(Config.GroundMinSpan, Thickness * 2), Thickness * Config.GroundThinRatio)
	for Index, Length in Lengths do
		if Index ~= Thin and Length < MinSpan then
			return false
		end
	end
	return true
end

-- How high the attacker's feet are: the top of whatever is under them (what they stand on,
-- or the ground below when they're in the air), or where the character's legs end, whichever
-- is higher, so a ray slipping past the edge of the step they're on can't put their feet on
-- the step below. nil if the hit has no attacker.
local function FeetHeight(Options: Options): number?
	local Attacker = Options.Attacker
	local Character: Instance? = if typeof(Attacker) == "Instance" and Attacker:IsA("Player")
		then (Attacker :: Player).Character
		else Attacker :: any
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not (Root and Root:IsA("BasePart")) then
		return nil
	end
	FeetRay.FilterDescendantsInstances = { Character :: Instance }
	local Hit = workspace:Raycast(Root.Position, Vector3.yAxis * -50, FeetRay)
	local Feet = if Hit then Hit.Position.Y else nil
	local Humanoid = (Character :: Instance):FindFirstChildOfClass("Humanoid")
	if Humanoid and Root.CFrame.UpVector.Y > 0.9 then -- upright (not ragdolled)
		local Legs = if Humanoid.RigType == Enum.HumanoidRigType.R6 then 2 else Humanoid.HipHeight
		local LegEnd = Root.Position.Y - Root.Size.Y / 2 - Legs
		Feet = if Feet then math.max(Feet, LegEnd) else LegEnd
	end
	return Feet
end

local function TopOf(Part: BasePart): number
	local CF, Half = Part.CFrame, Part.Size / 2
	return Part.Position.Y + math.abs(CF.XVector.Y) * Half.X + math.abs(CF.YVector.Y) * Half.Y + math.abs(CF.ZVector.Y) * Half.Z
end

-- Is a part (almost) all below the height Above (the attacker's feet, for a sideways hit)?
-- Then the hit leaves it alone, the same rule Split uses for cells.
local function BelowFeet(Part: BasePart, Above: number?): boolean
	if not Above then
		return false
	end
	local Top = TopOf(Part)
	return Top - Above <= 2 * (Top - Part.Position.Y) * Config.BreakOverlap
end

local function InFloorFolder(Thing: Instance): boolean
	return FloorFolder ~= nil and (Thing == FloorFolder or Thing:IsDescendantOf(FloorFolder))
end

local function BottomOf(Part: BasePart): number
	return 2 * Part.Position.Y - TopOf(Part)
end

-- Most parts FlushWithFloor looks through to reach a floor (keeps the search small).
local FLUSH_CHAIN = 12

-- A part too narrow to be a floor by its own shape (the grass strips filling the slanted edge
-- of a garden bed, a floor tile) is still part of the floor when it's the same layer as a floor
-- beside it: lying level, with its top and bottom flush with that floor's, or with another such
-- part that is (the strips of a garden bed's corner touch each other, and only the longest
-- touches the big grass piece). A floor that was already broken counts through its pieces.
local function FlushWithFloor(Part: BasePart, Visiting: { [BasePart]: boolean }?): boolean
	if FlushFloors[Part] then
		return true
	end
	local Path = Visiting or {}
	Path[Part] = true
	local Steps = 0
	for _ in Path do
		Steps += 1
	end
	local CF, Size = Part.CFrame, Part.Size
	local Axes = { CF.XVector, CF.YVector, CF.ZVector }
	local Lengths = { Size.X, Size.Y, Size.Z }
	local Up = 1
	for Index = 2, 3 do
		if math.abs(Axes[Index].Y) > math.abs(Axes[Up].Y) then
			Up = Index
		end
	end
	if math.abs(Axes[Up].Y) < math.cos(math.rad(Config.GroundMaxSlope)) or Lengths[Up] > Config.GroundMaxThickness then
		return false
	end
	local Top, Bottom = TopOf(Part), BottomOf(Part)
	for Index = 1, 3 do
		if Index ~= Up then
			for _, Side in { -1, 1 } do
				-- just past this side, a ray down onto whatever surface is there
				local Beside = Part.Position + Axes[Index] * Side * (Lengths[Index] / 2 + 0.3)
				local Hit = workspace:Raycast(Vector3.new(Beside.X, Top + 0.3, Beside.Z), Vector3.yAxis * -0.6, FloorRay)
				if Hit and math.abs(Hit.Position.Y - Top) <= 0.1 then
					local Piece = Registry.FromBody(Hit.Instance :: BasePart)
					local Other: BasePart = if Piece then Piece.Group.Original else Hit.Instance :: BasePart
					if Other ~= Part and not Path[Other] and math.abs(BottomOf(Other) - Bottom) <= 0.6 then
						local Floor = InFloorFolder(if Piece then Piece.Group.OriginalParent else Other)
							or IsGroundSlab(Other)
							or (Steps < FLUSH_CHAIN and FlushWithFloor(Other, Path))
						if Floor then
							FlushFloors[Part] = true
							return true
						end
					end
				end
			end
		end
	end
	return false
end

-- Is this part a floor? Floors crack in place (and only move with a slam), everything else
-- breaks like a wall: anything in Destroyable.Map.Floor, and any floor-shaped slab, or part of
-- the same layer as a floor beside it, that the attacker stands on.
local function IsFloor(Part: BasePart, Feet: number?): boolean
	if InFloorFolder(Part) then
		return true
	end
	if Feet and TopOf(Part) > Feet + Config.GroundStepUp then
		return false -- clearly above the attacker's feet: in front of them (a stair landing, a window sill), not under them
	end
	return IsGroundSlab(Part) or FlushWithFloor(Part)
end

local function ResolveMode(Part: BasePart, Requested: string?, Feet: number?): Mode
	if Requested == "Ground" or Requested == "Wall" then
		return Requested :: Mode
	end
	return if IsFloor(Part, Feet) then "Ground" else "Wall"
end

-- Target piece size: the move's GridSize (walls) or GroundGridSize (floors), else the part's own
-- GridSize attribute, else Config's.
local function GridFor(Part: BasePart, Options: Options, Mode: Mode): number
	local Requested = if Mode == "Ground" then Options.GroundGridSize else Options.GridSize
	if typeof(Requested) == "number" and Requested > 0 then
		return Requested
	end
	local Own = Part:GetAttribute("GridSize")
	if typeof(Own) == "number" and Own > 0 then
		return Own
	end
	return if Mode == "Ground" then Config.GroundGridSize or Config.GridSize else Config.GridSize
end

------------------------------------------------------------------------
-- Pieces and groups
------------------------------------------------------------------------

-- How much debris cells shrink on each of the part's axes. Wall pieces shrink evenly
-- (JJS: 2 x 3 -> 1.9 x 2.85). Ground pieces only shrink sideways: they keep their full
-- thickness, so their top stays flush with the floor around them and nothing sliding
-- over the cracks catches on a lip.
local function ShrinkFor(Original: BasePart, Mode: Mode): Vector3
	local S = Config.Shrink
	if Mode ~= "Ground" then
		return Vector3.one * S
	end
	local CF = Original.CFrame
	local X, Y, Z = math.abs(CF.XVector.Y), math.abs(CF.YVector.Y), math.abs(CF.ZVector.Y)
	if X >= Y and X >= Z then
		return Vector3.new(1, S, S)
	elseif Y >= Z then
		return Vector3.new(S, 1, S)
	end
	return Vector3.new(S, S, 1)
end

local function NewGroup(Original: BasePart, Mode: Mode, CellSize: Vector3, Now: number): Group
	local Parent = Original.Parent :: Instance
	local PrimaryOf: Model? = nil
	if Parent:IsA("Model") and Parent.PrimaryPart == Original then
		PrimaryOf = Parent
	end
	local Group: Group = {
		Original = Original,
		OriginalParent = Parent,
		PrimaryOf = PrimaryOf,
		Mode = Mode,
		CellSize = CellSize,
		Shrink = ShrinkFor(Original, Mode),
		ResetAt = Now + Config.ResetTime,
		Pieces = {},
		Color = Original.Color,
		Material = Original.Material,
		Variant = Original.MaterialVariant,
		Transparency = Original.Transparency,
		TransparencyKey = TransparencyKey(Original.Transparency),
		MaterialKey = Materials.ToKey(Original.Material, Original.MaterialVariant),
		ColorKey = ColorKey(Original.Color),
	}
	ActiveGroups[Group] = true
	GroupsByOriginal[Original] = Group
	return Group
end

local function NewPiece(Group: Group, Id: number, Kind: Registry.Kind, Transform: CFrame, Size: Vector3): Piece
	local Body = Instance.new("Part")
	Body.Name = tostring(Id)
	Body.Anchored = true
	Body.CanCollide = true
	Body.CanTouch = false
	Body.CanQuery = true
	Body.CastShadow = false
	Body.TopSurface = Enum.SurfaceType.Smooth
	Body.BottomSurface = Enum.SurfaceType.Smooth
	Body.Size = Size
	Body.CFrame = Transform
	Body.Color = Group.Color
	Body.Material = Group.Material
	Body.MaterialVariant = Group.Variant
	Body.Transparency = Group.Transparency
	Body.CustomPhysicalProperties = Physics(Group.Material, Config.BodyFriction)
	Body.CollisionGroup = StaticBodyGroup -- made anchored (still); StartMoving switches it
	Body.Parent = Bodies

	local Piece: Piece = {
		Id = Id,
		Body = Body,
		Kind = Kind,
		Group = Group,
		RestCFrame = Transform,
		StillFor = 0,
		MovingFor = 0,
		LastLaunch = 0,
		SentCFrame = Transform,
		LastSentAt = 0,
		SettledAt = 0,
		ResendIndex = 0,
		Ghosts = {},
		Slick = false,
	}
	Registry.Add(Piece)
	Group.Pieces[Id] = Piece
	return Piece
end

local function RemovePiece(Piece: Piece)
	Moving[Piece] = nil
	Announcing[Piece] = nil
	Tipped[Piece] = nil
	LaunchedFrom[Piece] = nil
	Overshot[Piece] = nil
	Piece.Group.Pieces[Piece.Id] = nil
	Registry.Remove(Piece)
	Piece.Body:Destroy() -- takes its no-collide constraints with it
end

local function ClearGhosts(Piece: Piece)
	for _, Ghost in Piece.Ghosts do
		Ghost:Destroy()
	end
	table.clear(Piece.Ghosts)
end

-- How deep a piece has to be inside something else beside or above it before it may pass
-- through it (FreeFromOverlaps). Shallower overlaps, like rubble resting against rubble, are
-- left to physics, which only nudges them apart: a no-collide there let a re-hit piece slide
-- straight into the one next to it and stop inside it.
local GHOST_DEPTH = 0.25

-- Is Other a wall piece flying off in this same hit?
local function FlyingNow(Other: BasePart): boolean
	local OtherPiece = Registry.FromBody(Other)
	return OtherPiece ~= nil and LaunchingNow[Other] == true and OtherPiece.Group.Mode == "Wall"
end

-- Is the middle of a piece inside something solid that stays put (the map, or a piece that
-- isn't flying off in this hit)? A step built half inside the landing under it, a cell inside
-- a hidden ramp.
local function Buried(Piece: Piece): boolean
	PointQuery.CFrame = CFrame.new(Piece.Body.Position)
	for _, Other in workspace:GetPartsInPart(PointQuery, SolidParams) do
		if Other ~= Piece.Body and not FlyingNow(Other) then
			return true
		end
	end
	return false
end

-- Walls in real maps overlap their frames, pillars, floors and each other, and stairs are often
-- built half inside the landing or hidden ramp under them. A piece cut from an overlapping spot
-- would be shoved out violently or wedged the moment it's unanchored. So before it moves:
--   * sunk a little into something under it: it's lifted out (by up to Config.MaxLift of its
--     height, measured under its corners too, so a sloped surface counts);
--   * sunk deeper, or its middle inside something: it can't come out without popping up, so it
--     stays where it broke, like JJS's stair pieces. Returns false;
--   * deep inside something beside or above it: it passes through that until it has slid clear
--     (PhysicsTick removes each no-collide as soon as they no longer overlap). Never through
--     what's under it, or it falls through the map.
-- A wall piece flying off in the same hit never holds a piece back: sunk deep into one (lattice
-- bars that cross, a gable wall cut where the roof runs through it), it passes through that
-- one instead.
-- Returns true when the piece is free to move.
local function FreeFromOverlaps(Piece: Piece): boolean
	ClearGhosts(Piece)
	local Body = Piece.Body
	local Touching = workspace:GetPartsInPart(Body, SolidParams)
	if #Touching == 0 then
		return true
	end
	if Buried(Piece) then
		return false
	end

	local CF, Half = Body.CFrame, Body.Size / 2
	local VerticalHalf = math.abs(CF.XVector.Y) * Half.X + math.abs(CF.YVector.Y) * Half.Y + math.abs(CF.ZVector.Y) * Half.Z
	local Bottom = Body.Position.Y - VerticalHalf
	local Top = Body.Position.Y + VerticalHalf
	local Points = { Body.Position }
	for _, SX in { -0.9, 0.9 } do
		for _, SY in { -0.9, 0.9 } do
			for _, SZ in { -0.9, 0.9 } do
				table.insert(Points, CF:PointToWorldSpace(Half * Vector3.new(SX, SY, SZ)))
			end
		end
	end
	local MaxRaise = 2 * VerticalHalf * Config.MaxLift + 0.02
	local Beneath: { [BasePart]: boolean } = {}
	local Raise = 0
	for _, Other in Touching do
		if Other ~= Body and Other.CanCollide then
			DownRay.FilterDescendantsInstances = { Other }
			local Needed = 0
			for _, Point in Points do
				local Hit = workspace:Raycast(Vector3.new(Point.X, Top, Point.Z), Vector3.yAxis * -(VerticalHalf * 2), DownRay)
				local Lift = if Hit then Hit.Position.Y - Bottom else 0
				if Lift > 0 and Lift <= VerticalHalf then
					Needed = math.max(Needed, Lift + 0.02)
				end
			end
			-- sunk too deep into a piece that flies off with it: pass through it (a no-collide below)
			if Needed > 0 and (Needed <= MaxRaise or not FlyingNow(Other)) then
				Beneath[Other] = true
				Raise = math.max(Raise, Needed)
			end
		end
	end
	if Raise > MaxRaise then
		return false
	end
	if Raise > 0 then
		Body.CFrame += Vector3.yAxis * Raise
	end
	DeepQuery.Size = (Body.Size - Vector3.one * (2 * GHOST_DEPTH)):Max(Vector3.one * 0.05)
	DeepQuery.CFrame = Body.CFrame
	for _, Other in workspace:GetPartsInPart(DeepQuery, SolidParams) do
		if Other ~= Body and Other.CanCollide and not Beneath[Other] then
			local Ghost = Instance.new("NoCollisionConstraint")
			Ghost.Part0 = Body
			Ghost.Part1 = Other
			Ghost.Parent = Body
			table.insert(Piece.Ghosts, Ghost)
		end
	end
	return true
end

-- Drops the no-collides of a moving piece that has slid clear of what they were for.
local function ReleaseGhosts(Piece: Piece)
	local Others = {}
	for _, Ghost in Piece.Ghosts do
		if Ghost.Part1 then
			table.insert(Others, Ghost.Part1)
		end
	end
	GhostParams.FilterDescendantsInstances = Others
	local Still: { [BasePart]: boolean } = {}
	for _, Other in workspace:GetPartsInPart(Piece.Body, GhostParams) do
		Still[Other] = true
	end
	for Index = #Piece.Ghosts, 1, -1 do
		local Ghost = Piece.Ghosts[Index]
		if not (Ghost.Part1 and Still[Ghost.Part1]) then
			Ghost:Destroy()
			table.remove(Piece.Ghosts, Index)
		end
	end
end

-- What's directly under a piece (within 0.3 studs of its bottom), or nil.
local function Below(Piece: Piece): BasePart?
	local Body = Piece.Body
	local CF, Half = Body.CFrame, Body.Size / 2
	local VerticalHalf = math.abs(CF.XVector.Y) * Half.X + math.abs(CF.YVector.Y) * Half.Y + math.abs(CF.ZVector.Y) * Half.Z
	local Hit = workspace:Raycast(Body.Position, Vector3.yAxis * -(VerticalHalf + 0.3), SolidRay)
	return if Hit then Hit.Instance :: BasePart else nil
end

local function SetSlick(Piece: Piece, Slick: boolean)
	if Piece.Slick ~= Slick then
		Piece.Slick = Slick
		Piece.Body.CustomPhysicalProperties = if Slick
			then PhysicalProperties.new(Density(Piece.Group.Material), Config.StackedFriction, Config.BodyElasticity, SLICK_WEIGHT, Config.BodyWeight)
			else Physics(Piece.Group.Material, Config.BodyFriction)
	end
end

-- A slick piece keeps sliding for as long as it's on top of other wall pieces, moving or
-- stopped, so it slides off them instead of stopping on top. Once it's on the floor or
-- anything else, it gets the landed friction and stops near where it fell.
local function UpdateSlick(Piece: Piece)
	local Under = Below(Piece)
	if not Under then
		return -- in the air: decide when it lands
	end
	local Carrier = Registry.FromBody(Under)
	if not (Carrier and Carrier.Kind == "Debris" and Carrier.Group.Mode == "Wall") then
		SetSlick(Piece, false)
		Piece.Body.CustomPhysicalProperties = Physics(Piece.Group.Material, Config.LandedFriction)
	end
end

-- Queue a settled piece's final position to be sent now and again at Config.SettleResends.
local function Announce(Piece: Piece, Now: number)
	Piece.SettledAt = Now
	Piece.ResendIndex = 0
	Announcing[Piece] = true
end

local function StartMoving(Piece: Piece)
	Unanchor(Piece.Body)
	Piece.Body.CollisionGroup = BodyGroup -- moving: characters pass through it on the server
	Piece.StillFor = 0
	Piece.MovingFor = 0
	Moving[Piece] = true
	Announcing[Piece] = nil
	Tipped[Piece] = nil
end

-- Directions to try tipping a piece toward, best first: off the side it already hangs over,
-- the way it was going, then all the way round in 45 degree steps.
local TIP_TURNS = { 0, 45, -45, 90, -90, 135, -135, 180 }

-- JJS's upper rows end up on the floor, not in neat stacks. A wall piece that flew off and
-- stopped on top of another wall piece is tipped off it toward open space (at most
-- Config.TipTries times). A stack with no room around it stays, and so does a piece that never
-- got out of its slot (a stair hit from the front: JJS leaves those sitting in place).
-- Returns true if the piece was tipped.
local function TipOff(Piece: Piece): boolean
	local Tries = Tipped[Piece] or 0
	if Piece.Group.Mode ~= "Wall" or Tries >= Config.TipTries then
		return false
	end
	local Body = Piece.Body
	local From = LaunchedFrom[Piece]
	if From and (Body.Position - From).Magnitude < 1 then
		return false
	end
	local Under = Below(Piece)
	local Carrier = if Under then Registry.FromBody(Under) else nil
	if not (Carrier and Carrier.Kind == "Debris" and Carrier.Group.Mode == "Wall") then
		return false
	end

	local Preferred: { Vector3 } = {}
	for _, Away in { Body.Position - Carrier.Body.Position, Body.Position - Piece.RestCFrame.Position } do
		local Horizontal = Vector3.new(Away.X, 0, Away.Z)
		if Horizontal.Magnitude > 0.3 then
			table.insert(Preferred, Horizontal.Unit)
		end
	end
	local Directions: { Vector3 } = table.clone(Preferred)
	local Ahead = Preferred[1] or Vector3.xAxis
	for _, Turn in TIP_TURNS do
		table.insert(Directions, CFrame.Angles(0, math.rad(Turn), 0) * Ahead)
	end

	local CF, Size = Body.CFrame, Body.Size
	local CastSize = (Size - Vector3.one * 0.3):Max(Vector3.one * 0.1)
	for _, Direction in Directions do
		-- room for the whole piece beside where it is now
		local Width = math.abs(CF.XVector:Dot(Direction)) * Size.X + math.abs(CF.YVector:Dot(Direction)) * Size.Y + math.abs(CF.ZVector:Dot(Direction)) * Size.Z
		if not workspace:Blockcast(CF, CastSize, Direction * Width, SolidRay) then
			Tipped[Piece] = Tries + 1
			Piece.StillFor = 0
			SetSlick(Piece, true) -- slides off on the low friction; landed friction again once it's down
			Body.AssemblyLinearVelocity = Direction * Config.TipSpeed + Vector3.yAxis
			Body.AssemblyAngularVelocity = Vector3.yAxis:Cross(Direction) * Config.TipSpin -- top goes first
			return true
		end
	end
	return false
end

local function Settle(Piece: Piece, Now: number)
	ClearGhosts(Piece)
	SetSlick(Piece, false)
	Piece.Body.CustomPhysicalProperties = Physics(Piece.Group.Material, Config.BodyFriction)
	Piece.Body.Anchored = true
	Piece.Body.CollisionGroup = StaticBodyGroup -- still again: characters stand on it
	Piece.StillFor = 0
	Piece.MovingFor = 0
	Moving[Piece] = nil
	Overshot[Piece] = nil
	Announce(Piece, Now)
end

-- A random small tilt that keeps the piece's bottom where it was, so it never sinks
-- into the unbreakable floor underneath, plus a little random height.
local function GroundJitter(Rest: CFrame, Size: Vector3): CFrame
	local Tilt = math.rad(Config.GroundTilt)
	local Tilted = Rest * CFrame.Angles(Rng:NextNumber(-Tilt, Tilt), 0, Rng:NextNumber(-Tilt, Tilt))
	local Half = Size / 2
	local function VerticalHalf(Transform: CFrame): number
		return math.abs(Transform.XVector.Y) * Half.X + math.abs(Transform.YVector.Y) * Half.Y + math.abs(Transform.ZVector.Y) * Half.Z
	end
	local Raise = VerticalHalf(Tilted) - VerticalHalf(Rest) + Rng:NextNumber(0, Config.GroundHeightJitter)
	return Tilted + Vector3.yAxis * Raise
end

-- Which way a wall piece goes: the attacker's look direction, or away from the hit. Like
-- JJS, that's the same at any angle: hit a wall at an angle and the pieces are driven into
-- the wall beside them, so they only scrape out a little (physics decides how much). Pieces
-- cut from a solid mass (a stair hit from the front) are driven into the rest of it and stay
-- in their slot, like JJS; a slam drives them down into what's under them.
local function PushFor(Piece: Piece, Direction: Vector3?, HitCenter: Vector3): Vector3
	return Direction or Flat(Piece.Body.Position - HitCenter) or Vector3.new(0, 0, -1)
end

-- Launches a debris piece. IsNew = it was just cut, so its start position goes out in Create.
local function Launch(Piece: Piece, Options: Options, Direction: Vector3?, HitCenter: Vector3, Now: number, IsNew: boolean)
	local Body = Piece.Body
	Piece.LastLaunch = Now

	if Piece.Group.Mode == "Ground" then
		local Bounce = Options.Bounce or 0
		Moving[Piece] = nil -- (re)placed by hand below, or restarted by StartMoving
		Body.Anchored = true
		Body.CollisionGroup = StaticBodyGroup
		Body.CFrame = GroundJitter(Piece.RestCFrame, Body.Size)
		-- GroundOutward: blown up and away from the hit, like the walls of an Outward hit
		if Options.GroundOutward and FreeFromOverlaps(Piece) then
			StartMoving(Piece)
			local Away = Flat(Body.Position - HitCenter) or Vector3.new(Rng:NextNumber(-1, 1), 0, Rng:NextNumber(-1, 1)).Unit
			local Speed = (Options.Power or Config.WallSpeed) * (1 + Rng:NextNumber(-Config.WallJitter, Config.WallJitter))
			Body.AssemblyLinearVelocity = Away * Speed + Vector3.yAxis * ((Options.Lift or Config.WallLift) + Rng:NextNumber(10, 25))
			Body.AssemblyAngularVelocity = Vector3.new(Rng:NextNumber(-6, 6), Rng:NextNumber(-6, 6), Rng:NextNumber(-6, 6))
			return
		end
		-- Bounce > 0 pops the pieces, < 0 pushes them down. Either way a floor broken right
		-- through (an upper storey) drops its pieces to the floor below, like JJS's downslam.
		if Bounce ~= 0 and FreeFromOverlaps(Piece) then
			StartMoving(Piece)
			local Side = Config.GroundSideJitter
			Body.AssemblyLinearVelocity = Vector3.new(Rng:NextNumber(-Side, Side), Bounce, Rng:NextNumber(-Side, Side))
			Body.AssemblyAngularVelocity = Vector3.zero
		elseif IsNew then
			Piece.SentCFrame = Body.CFrame -- the jittered spot goes out in Create
		else
			Announce(Piece, Now) -- an existing piece re-jitters: tween it there with a settle record
		end
		return
	end

	if not FreeFromOverlaps(Piece) then
		return -- sunk deep into something that stays put: it stays where it broke
	end
	local Push = PushFor(Piece, Direction, HitCenter)
	local Speed = (Options.Power or Config.WallSpeed) * (1 + Rng:NextNumber(-Config.WallJitter, Config.WallJitter))
	-- Resting on a piece that's launching too? Then it slides on it and topples off the front.
	local Under = Below(Piece)
	SetSlick(Piece, Under ~= nil and LaunchingNow[Under] == true)
	StartMoving(Piece)
	LaunchedFrom[Piece] = Body.Position
	local Lift = if Push.Y < 0 then 0 else Options.Lift or Config.WallLift
	Body.AssemblyLinearVelocity = Push * Speed + Vector3.yAxis * Lift
	Body.AssemblyAngularVelocity = Vector3.zero
end

-- Turns a split result into pieces of Group. Returns false (and creates nothing) if
-- there aren't enough free IDs.
local function AddPieces(
	Group: Group,
	Result: Split.Result,
	Options: Options,
	Direction: Vector3?,
	HitCenter: Vector3,
	Now: number,
	Batch: Batch
): boolean
	local Needed = #Result.Leftover + #Result.Edge + #Result.Core
	if Registry.Available() < Needed then
		if not WarnedFull then
			WarnedFull = true
			warn(`Debree: {Registry.Count()} pieces are live, the limit of {Config.MaxLivePieces} is reached; skipping new breaks until the map resets`)
		end
		return false
	end

	for _, Box in Result.Leftover do
		local Piece = NewPiece(Group, Registry.Allocate() :: number, "Static", Box.CFrame, Box.Size)
		table.insert(Batch.Created, Piece)
	end
	for _, Box in Result.Edge do
		-- Cells the hit only touches: normally they stay part of the wall (full size, no seams)
		local Piece = if Config.SeamEdgeCells
			then NewPiece(Group, Registry.Allocate() :: number, "Debris", Box.CFrame, Box.Size * Group.Shrink)
			else NewPiece(Group, Registry.Allocate() :: number, "Static", Box.CFrame, Box.Size)
		table.insert(Batch.Created, Piece)
	end
	local Destroyed = Options.Destroyed or 0
	for _, Box in Result.Core do
		if Destroyed > 0 and Rng:NextNumber() < Destroyed then
			continue -- destroyed completely: no piece (the original comes back at the reset)
		end
		local Piece = NewPiece(Group, Registry.Allocate() :: number, "Debris", Box.CFrame, Box.Size * Group.Shrink)
		table.insert(Batch.Launches, { Piece = Piece, IsNew = true })
		table.insert(Batch.Created, Piece)
		table.insert(Batch.Sounded, Piece.Id)
	end
	return true
end

------------------------------------------------------------------------
-- Hitting things
------------------------------------------------------------------------

-- An untouched map block: hide it and replace it with pieces. Above: the attacker's feet for
-- a sideways hit (nothing lower breaks unless it's ground), else nil.
local function BreakOriginal(Part: BasePart, Hit: Split.Hit, Options: Options, Direction: Vector3?, Now: number, Batch: Batch, Feet: number?, Above: number?)
	local Mode = ResolveMode(Part, Options.Mode, Feet)
	local Counts = Split.CountsFor(Part.Size, GridFor(Part, Options, Mode))
	-- Glass: whatever stays is one block, so no join lines show through it
	local Result = Split.Divide(Part.CFrame, Part.Size, Counts, Hit, Config.MaxCellsPerPart, Part.Transparency > 0, Config.BreakOverlap, if Mode == "Wall" then Above else nil)
	if not Result or #Result.Core == 0 then
		return -- the hit only grazes it (or only reaches below the feet): the part stays whole
	end
	local Group = NewGroup(Part, Mode, Result.CellSize, Now)
	if not AddPieces(Group, Result, Options, Direction, Hit.CFrame.Position, Now, Batch) then
		ActiveGroups[Group] = nil
		return
	end
	-- Moving the original out of workspace removes it for every client through normal
	-- replication; the pieces in the Create payload replace it.
	Part.Parent = Hidden
end

-- An existing piece was hit again. Above: as in BreakOriginal.
local function HitPiece(Piece: Piece, Hit: Split.Hit, Options: Options, Direction: Vector3?, Now: number, Batch: Batch, Above: number?)
	local Group = Piece.Group
	local Limit = if Group.Mode == "Wall" then Above else nil

	if Piece.Kind == "Static" then
		-- A leftover box: split it the same way, on the same grid as the cells around it
		local Body = Piece.Body
		local Counts = Split.CountsFromCell(Body.Size, Group.CellSize)
		local Result = Split.Divide(Body.CFrame, Body.Size, Counts, Hit, Config.MaxCellsPerPart, Group.Transparency > 0, Config.BreakOverlap, Limit)
		if Result and #Result.Core == 0 and #Result.Edge == 1 and #Result.Leftover == 0 then
			-- A single cell left at the edge of an earlier hole: the hit only grazes it. It
			-- breaks now, so hitting the same spot again finishes the hole off instead of
			-- leaving the same cells standing every time.
			Result.Core, Result.Edge = Result.Edge, {}
		end
		if not Result or #Result.Core == 0 or Registry.Available() < #Result.Leftover + #Result.Edge + #Result.Core then
			return
		end
		table.insert(Batch.Removed, Piece.Id)
		RemovePiece(Piece)
		AddPieces(Group, Result, Options, Direction, Hit.CFrame.Position, Now, Batch)
		Group.ResetAt = Now + Config.ResetTime
		return
	end

	if Now - Piece.LastLaunch < Config.RehitCooldown or BelowFeet(Piece.Body, Limit) then
		return
	end
	Piece.LastLaunch = Now -- claimed now, launched at the end of Destroy
	table.insert(Batch.Launches, { Piece = Piece, IsNew = false })
	table.insert(Batch.Sounded, Piece.Id)
	Group.ResetAt = Now + Config.ResetTime
end

-- A non-block map part (mesh, union, wedge...): launch the real part whole. Parts bigger
-- than Config.LooseMaxSize (roofs, big unions), ground parts and (Above) parts below the
-- attacker's feet stay where they are.
local function HitLoose(Part: BasePart, Options: Options, Direction: Vector3?, HitCenter: Vector3, Now: number, Batch: Batch, Feet: number?, Above: number?)
	if BelowFeet(Part, Above) then
		return
	end
	local Info = LooseParts[Part]
	if Info then
		if Now - Info.LastLaunch < Config.RehitCooldown then
			return
		end
	else
		local Size = Part.Size
		if math.max(Size.X, Size.Y, Size.Z) > Config.LooseMaxSize or ResolveMode(Part, Options.Mode, Feet) == "Ground" then
			return
		end
		Info = { CFrame = Part.CFrame, ResetAt = 0, LastLaunch = 0 }
		LooseParts[Part] = Info
	end
	local Entry = Info :: Loose
	Entry.LastLaunch = Now
	Entry.ResetAt = Now + Config.ResetTime

	Unanchor(Part)
	local Push = Direction or Flat(Part.Position - HitCenter) or Vector3.new(0, 0, -1)
	local Speed = (Options.Power or Config.WallSpeed) * (1 + Rng:NextNumber(-Config.WallJitter, Config.WallJitter))
	local Lift = if Push.Y < 0 then 0 else Options.Lift or Config.WallLift
	Part.AssemblyLinearVelocity = Push * Speed + Vector3.yAxis * Lift
	table.insert(Batch.LooseSounds, Part)
end

local function RestoreLoose(Part: BasePart, Info: Loose)
	LooseParts[Part] = nil
	if Part.Parent == nil then
		return
	end
	Part.Anchored = true
	Part.AssemblyLinearVelocity = Vector3.zero
	Part.AssemblyAngularVelocity = Vector3.zero
	Part.CFrame = Info.CFrame
end

-- Config.ShowHitboxes: draws the hit volume exactly as Destroy uses it, for a moment.
-- It's made after the hit is resolved and can't be queried, so it never affects breaking.
local function ShowHitbox(Hit: Split.Hit)
	local Box = Instance.new("Part")
	Box.Name = "DebreeHitbox"
	Box.Shape = if Hit.Shape == "Ball" then Enum.PartType.Ball else Enum.PartType.Block
	Box.Size = if Hit.Shape == "Ball" then Vector3.one * math.min(Hit.Size.X, Hit.Size.Y, Hit.Size.Z) else Hit.Size
	if Hit.Shape == "Oval" then
		-- A Ball part can't stretch; a sphere SpecialMesh fills the part's whole size
		local Mesh = Instance.new("SpecialMesh")
		Mesh.MeshType = Enum.MeshType.Sphere
		Mesh.Parent = Box
	end
	Box.CFrame = Hit.CFrame
	Box.Anchored = true
	Box.CanCollide = false
	Box.CanTouch = false
	Box.CanQuery = false
	Box.CastShadow = false
	Box.Material = Enum.Material.ForceField
	Box.Color = Config.HitboxColor
	Box.Transparency = 0.3
	local World = workspace:FindFirstChild("World")
	Box.Parent = (World and World:FindFirstChild("Visuals")) or workspace
	Debris:AddItem(Box, Config.HitboxShowTime)
end

local function PickSome(List: { number }, Count: number): { number }
	local Picked = table.clone(List)
	for Index = 1, math.min(Count, #Picked) do
		local Swap = Rng:NextInteger(Index, #Picked)
		Picked[Index], Picked[Swap] = Picked[Swap], Picked[Index]
	end
	return table.move(Picked, 1, math.min(Count, #Picked), 1, {})
end

------------------------------------------------------------------------
-- Public API
------------------------------------------------------------------------

-- Breaks everything breakable inside the hit volume. Returns how many pieces were
-- launched or bumped. Safe to call before Start (it starts Debree first).
------------------------------------------------------------------------
-- Tsunami checkpoint 1: grounded building remnants, with no flying debris.
------------------------------------------------------------------------
local BuildingStates = {}
local BuildingDirty = {}
local TsunamiFlushStats={Calls=0,TotalMs=0,MaxMs=0}
local BuildingPlanFailures = setmetatable({}, {__mode="k"})
local BuildingOwners = setmetatable({}, { __mode = "k" })

-- Frozen, noninteractive geometry for checkpoint 2. These are preview parts, not physics debris.
local FrozenPreviewCount = 0
local FrozenPreviewRoot: Folder?

local function ClearBuildingPreview(State)
	State.Closed=true
	BuildingDirty[State]=nil
	BuildingMotion.Clear(State)
	FrozenPreviewCount = math.max(0, FrozenPreviewCount - (State.PreviewCreated or 0))
	if State.PreviewFolder then State.PreviewFolder:Destroy() end
	if FrozenPreviewRoot and #FrozenPreviewRoot:GetChildren() == 0 then FrozenPreviewRoot:Destroy(); FrozenPreviewRoot = nil end
	State.PreviewFolder = nil
	State.PreviewQueue = nil
	State.PreviewCreated = 0
end

local function QueueBuildingPreview(State, Entry, Group, Context)
	if Group.Transparency>=1 or Entry.PreDamaged then return end
	BuildingMotion.Queue(State,Entry.ClientBoxes or {},Group,Entry.ServerBoxes or {},Context)
end

local function FlushBuildingWork()
	if next(BuildingDirty)==nil then return end
	local startedAt=os.clock()
	local now=time()
	local motionInterval=require(Shared.BuildingDebrisMotion).MotionFlushInterval or 0.1
	for State in BuildingDirty do
		if State.Closed or State.MotionClosed or now>=State.Expires then BuildingDirty[State]=nil;continue end
		if (State.PendingRemoved and #State.PendingRemoved>0) or (State.PendingCreated and #State.PendingCreated>0) then
			for _,Group in State.Groups do if ActiveGroups[Group] then Group.ResetAt=State.Expires end end
			-- Remains geometry goes out every frame so a hidden original never leaves a hole.
			if State.PendingRemoved and #State.PendingRemoved>0 then Stream.SendProp(State.PendingRemoved) end
			if State.PendingCreated and #State.PendingCreated>0 then Stream.SendCreate(State.PendingCreated) end
			State.PendingRemoved,State.PendingCreated=nil,nil
		end
		-- Debris packets are batched: first contact flushes at once, later parts every motionInterval.
		if not State.NextMotionFlush or now>=State.NextMotionFlush then
			BuildingDirty[State]=nil
			State.NextMotionFlush=now+motionInterval
			BuildingMotion.Flush(State)
		end
	end
	local ms=(os.clock()-startedAt)*1000
	TsunamiFlushStats.Calls+=1;TsunamiFlushStats.TotalMs+=ms;TsunamiFlushStats.MaxMs=math.max(TsunamiFlushStats.MaxMs,ms)
end

local function StepBuildingPreview()
	local Settings = BuildingDebris.Settings
	local Budget = math.max(1, Settings.PreviewPartsPerFrame)
	for _, State in BuildingStates do
		if time() >= State.Expires or not State.Plan.Model.Parent then continue end
		local Queue = State.PreviewQueue
		if not Queue then continue end
		while Budget > 0 and State.PreviewHead <= #Queue do
			local Item = Queue[State.PreviewHead]
			State.PreviewHead += 1
			Budget -= 1
			if FrozenPreviewCount >= Settings.MaxFrozenPreviewParts then
				State.PreviewFolder:SetAttribute("Capped", true)
				continue
			end
			local Box = Item.Box
			local Part = Instance.new("Part")
			Part.Name = Box.Kind
			Part.Size = if Box.Kind == "Voxel" then (Box.Size-Vector3.one*math.max(0,Settings.PreviewGap)):Max(Box.Size*0.95) else Box.Size
			Part.CFrame = Box.CFrame
			Part.Color = Item.Color
			Part.Material = Item.Material
			Part.MaterialVariant = Item.Variant
			Part.Transparency = Item.Transparency
			Part.TopSurface = Enum.SurfaceType.Smooth
			Part.BottomSurface = Enum.SurfaceType.Smooth
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part:SetAttribute("UnscaledSize", Box.Size)
			Part:SetAttribute("BuildingDebrisPreview", true)
			Part.Parent = State.PreviewFolder
			FrozenPreviewCount += 1
			State.PreviewCreated += 1
		end
		if State.PreviewHead > #Queue then
			State.PreviewQueue = nil
		end
		if Budget <= 0 then break end
	end
end



local function BuildingOfBody(Part: BasePart): Model?
	local Piece = Registry.FromBody(Part)
	if Piece then
		return BuildingRemains.BuildingOf(Piece.Group.OriginalParent)
	end
	return BuildingOwners[Part] or BuildingRemains.BuildingOf(Part)
end

local function BuildingState(Model: Model)
	local Now=time()
	local State=BuildingStates[Model]
	if State and Now<State.Expires then return State end
	if State then ClearBuildingPreview(State) end
	local Plan,Reason=TsunamiDestruction.GetPlan(Model)
	if not Plan then
		BuildingPlanFailures[Model]={Reason=Reason,RetryAt=Now+1}
		return nil
	end
	BuildingPlanFailures[Model]=nil
	State={Plan=Plan,Groups={},Expires=Now+Config.ResetTime}
	BuildingStates[Model]=State
	return State
end

local function SurvivingBoxes(Entry, Group)
	-- Existing attack damage is retained. Only intersect the cached base with static leftovers.
	local out={}
	for _,piece in Group.Pieces do
		if piece.Kind~="Static" then continue end
		local p=Entry.CFrame:PointToObjectSpace(piece.Body.Position)
		local lo,hi=p-piece.Body.Size/2,p+piece.Body.Size/2
		for _,box in Entry.Boxes do
			local c=Entry.CFrame:PointToObjectSpace(box.CFrame.Position)
			local low,high=lo:Max(c-box.Size/2),hi:Min(c+box.Size/2)
			local size=high-low
			if math.min(size.X,size.Y,size.Z)>0.06 then table.insert(out,{CFrame=Entry.CFrame*CFrame.new((low+high)/2),Size=size}) end
		end
	end
	return out
end

local function ApplyBuildingEntries(State, Hit: Split.Hit?, MotionContext: any?, SingleEntry: any?): number
	local Now=time()
	if State.Closed or State.MotionClosed or Now>=State.Expires then return 0 end
	local Created,Removed={},{}
	local Count=0
	for _,Entry in SingleEntry and {SingleEntry} or State.Plan.Entries do
		if Entry.Done or Entry.Ignore then continue end
		local Original=Entry.Original
		local ExistingGroup=GroupsByOriginal[Original]
		if not Original.Parent or (not ExistingGroup and not Original:IsDescendantOf(Destroyable)) then continue end
		if Hit and not Split._Intersects(Vector3.zero,Entry.Size/2,Split._ToLocalHit(Entry.CFrame,Hit)) then continue end
		if not ExistingGroup and (Entry.RemovedVolume or 0)<0.0001 then Entry.Done=true;continue end
		local Boxes=if ExistingGroup then SurvivingBoxes(Entry,ExistingGroup) else Entry.Boxes
		local available=Registry.Available()
		if ExistingGroup then for _ in ExistingGroup.Pieces do available+=1 end end
		if available<#Boxes then State.CapacitySkipped=(State.CapacitySkipped or 0)+1;Entry.Done=true;continue end
		Entry.Done=true
		local Group=ExistingGroup
		if Group then
			Entry.PreDamaged=true
			local old={};for _,piece in Group.Pieces do table.insert(old,piece) end
			for _,piece in old do table.insert(Removed,piece.Id);RemovePiece(piece) end
		else
			BuildingOwners[Original]=State.Plan.Model
			Group=NewGroup(Original,"Wall",Vector3.one*BuildingRemains.Settings.SectionWidth,Now)
			Original.Parent=Hidden
		end
		table.insert(State.Groups,Group)
		QueueBuildingPreview(State,Entry,Group,MotionContext)
		for _,Box in Boxes do table.insert(Created,NewPiece(Group,Registry.Allocate(),"Static",Box.CFrame,Box.Size)) end
		Count+=1
	end
	if Count>0 then
		State.Expires=Now+Config.ResetTime
		State.PendingCreated=State.PendingCreated or {};State.PendingRemoved=State.PendingRemoved or {}
		for _,piece in Created do table.insert(State.PendingCreated,piece) end
		for _,id in Removed do table.insert(State.PendingRemoved,id) end
		BuildingDirty[State]=true
	end
	return Count
end

-- Server command-bar testing: .PreviewBuildingRemains(buildingModel).
function DebreeService.PreviewBuildingRemains(Model: Model, MotionContext: any?)
	if not Started then DebreeService.Start() end
	assert(BuildingRemains.BuildingOf(Model) == Model, "Select the outermost model with Building=true")
	local State = BuildingState(Model)
	if not State then return {ChangedParts=0,Skipped=true,Reason=BuildingPlanFailures[Model] and BuildingPlanFailures[Model].Reason} end
	local Count = ApplyBuildingEntries(State, nil, MotionContext)
	return { ChangedParts=Count, GroundY=State.Plan.GroundY, RemainHeight=State.Plan.BaseHeight,
		DetectedFloor=State.Plan.DetectedFloor, RemainingPieces=State.Plan.KeptBoxes,
		UnsupportedRemoved=State.Plan.UnsupportedRemoved, ResetIn=Config.ResetTime,
		Debris=State.DebrisStats, FrozenPreview=BuildingDebris.Settings.FrozenPreview }
end

function DebreeService.SweepBuildingRemains(HitCFrame: CFrame, HitSize: Vector3, MotionContext: any?): number
	if not Started then DebreeService.Start() end
	-- The footprint determines affected buildings, including towers higher than the wave.
	local Hit = { CFrame=CFrame.new(HitCFrame.X, 0, HitCFrame.Z) * HitCFrame.Rotation,
		Size=Vector3.new(HitSize.X, 10000, HitSize.Z), Shape="Box" }
	local Count = 0
	local Map = Destroyable:FindFirstChild("Map")
	if not Map then return 0 end
	for Model,Record in TsunamiDestruction.Buildings() do
		local State = BuildingStates[Model]
		local Low, High
		if State and time() < State.Expires then
			Low, High = State.Plan.Low, State.Plan.High
		else
			Low,High=Record.Low,Record.High
		end
		if not Split._Intersects(Vector3.zero, (High-Low)/2,
			Split._ToLocalHit(CFrame.new((Low+High)/2), Hit)) then continue end
		State = BuildingState(Model)
		if State then Count += ApplyBuildingEntries(State, Hit, MotionContext) end
	end
	return Count
end

function DebreeService.PrepareTsunami(Waves)
	if not Started then DebreeService.Start() end
	return TsunamiDestruction.PrepareCast(Waves)
end
function DebreeService.TsunamiStats()
	local Stats=TsunamiDestruction.Stats()
	Stats.Flush=table.clone(TsunamiFlushStats)
	return Stats
end

local function ApplyTsunamiJob(Cast,Job,Context)
	if Job.Kind=="Building" then
		return ApplyBuildingEntries(Job.State,nil,Context,Job.Entry)
	elseif Job.Kind=="Tree" then
		if not Job.State.Model:IsDescendantOf(Destroyable) then return false end
		return BuildingMotion.PushTree(Job.State,Context,Config.ResetTime)
	end
	local Part=Job.Key
	if not Part:IsDescendantOf(Destroyable) or ShouldSkip(Part,true) then return 0 end
	local Group=NewGroup(Part,"Wall",Part.Size,time())
	local CF,Size=Part.CFrame,Part.Size
	Part.Parent=Hidden
	if not Cast.DecorState or Cast.DecorState.MotionClosed then
		Cast.DecorState={Expires=time()+Config.ResetTime,Groups={},Category="Decor",ClientLimit=require(Shared.BuildingDebrisMotion).ClientDecorPerCast,
			Plan={Seed=Cast.Seed,Low=CF.Position,High=CF.Position}}
	end
	local State=Cast.DecorState
	State.Expires=time()+Config.ResetTime
	table.insert(State.Groups,Group)
	if Cast.ClientDecor<require(Shared.BuildingDebrisMotion).ClientDecorPerCast then
		local Boxes=BuildingDebris.Sample({CFrame=CF,Size=Size},
			math.min(require(Shared.BuildingDebrisMotion).ClientVoxelsPerDecor,require(Shared.BuildingDebrisMotion).ClientDecorPerCast-Cast.ClientDecor),Cast.Seed+Cast.ClientDecor)
		Cast.ClientDecor+=#Boxes
		BuildingMotion.Queue(State,Boxes,Group,nil,Context)
	end
	BuildingDirty[State]=true
	return 1
end


function DebreeService.Destroy(HitCFrame: CFrame, HitSize: Vector3, Options: Options?): number
	if not Started then
		DebreeService.Start()
	end
	local Opts: Options = Options or {}
	local Shape = ResolveShape(Opts.Shape)
	local Size = HitSize:Max(Vector3.one * 0.05):Min(Vector3.one * Config.MaxHitSize)
	local HollowSize = if Opts.Hollow then Opts.Hollow:Max(Vector3.zero):Min(Size) else nil
	local Hit: Split.Hit = { Shape = Shape, CFrame = HitCFrame, Size = Size, Hollow = HollowSize }
	-- Hollow: block parts and leftover boxes keep their cells inside it (Split); debris, whole
	-- parts and special props are left alone when their middle is inside it
	local HollowHit = if HollowSize
		then Split._ToLocalHit(CFrame.identity, { Shape = Shape, CFrame = HitCFrame, Size = HollowSize })
		else nil
	local function InHollow(Part: BasePart): boolean
		return HollowHit ~= nil and Split._ContainsPoint(Part.Position, HollowHit)
	end

	local Query = if Shape == "Ball" then BallQuery else BoxQuery
	Query.Size = if Shape == "Ball" then Vector3.one * math.min(Size.X, Size.Y, Size.Z) else Size
	Query.CFrame = HitCFrame
	local Touched = workspace:GetPartsInPart(Query, QueryParams)

	local Now = time()
	local Direction = ResolveDirection(Opts)
	local Feet = FeetHeight(Opts)
	table.clear(FlushFloors)
	-- A sideways hit doesn't break wall-type parts or wall debris below the attacker's feet, so a
	-- punch on stairs leaves the step you stand on alone (JJS). Floors still crack, and a slam
	-- (Direction aimed down) breaks what's under you.
	local Above = if Direction and Direction.Y < 0 then nil else Feet
	local KeepGround = Opts.KeepGround == true
	local Batch: Batch = { Created = {}, Removed = {}, Sounded = {}, LooseSounds = {}, Launches = {} }
	local Specials: { [Model]: boolean } = {}

	for _, Part in Touched do
		if Options and Options.IgnoreBuildings and BuildingOfBody(Part) then continue end
		local Existing = Registry.FromBody(Part)
		local Special = if Existing or LooseParts[Part] then nil else SpecialModelOf(Part)
		if Opts.IgnoreTrees and Special and Special:GetAttribute("SpecialType")=="Tree" then continue end
		if Existing then
			-- KeepGround: rubble of a floor broken earlier stays put too
			if not (KeepGround and Existing.Group.Mode == "Ground") and (Existing.Kind == "Static" or not InHollow(Part)) then
				HitPiece(Existing, Hit, Opts, Direction, Now, Batch, Above)
			end
		elseif LooseParts[Part] then
			if not InHollow(Part) then
				HitLoose(Part, Opts, Direction, HitCFrame.Position, Now, Batch, Feet, Above)
			end
		elseif Special then
			if not InHollow(Part) then
				Specials[Special] = true -- broken whole by SpecialDestruction below, never split
			end
		elseif not ShouldSkip(Part) and not (KeepGround and ResolveMode(Part, Opts.Mode, Feet) == "Ground") then
			if IsSplittable(Part) then
				BreakOriginal(Part, Hit, Opts, Direction, Now, Batch, Feet, Above)
			elseif not InHollow(Part) then
				HitLoose(Part, Opts, Direction, HitCFrame.Position, Now, Batch, Feet, Above)
			end
		end
	end

	-- Launch now: every original this hit touched is hidden and every new piece exists, so
	-- each piece starts out in the map as it really is after the hit. Like JJS, nothing checks
	-- whether a piece has room to go: everything the hit breaks is launched, and a piece with
	-- something solid in its way just doesn't get far (hit it again to move it).
	for _, Queued in Batch.Launches do
		LaunchingNow[Queued.Piece.Body] = true
	end
	-- Lowest first: a piece lifted out of what it's sunk into (FreeFromOverlaps) then lifts the
	-- piece resting on it as well, instead of being pushed up into it.
	table.sort(Batch.Launches, function(A, B)
		return A.Piece.Body.Position.Y < B.Piece.Body.Position.Y
	end)
	for _, Queued in Batch.Launches do
		Launch(Queued.Piece, Opts, Direction, HitCFrame.Position, Now, Queued.IsNew)
	end
	-- A piece that was lifted got a no-collide with the piece above it, which then lifted itself
	-- clear too. Kept until the next PhysicsTick, it let the top piece fall right into the
	-- bottom one (stairs on the hidden ramp), so drop every no-collide that's no longer needed now.
	for _, Queued in Batch.Launches do
		local Piece = Queued.Piece
		if #Piece.Ghosts > 0 and Piece.Body.Parent then
			ReleaseGhosts(Piece)
		end
	end
	table.clear(LaunchingNow)

	-- Removals first, so a client never draws a re-split box and its replacement together
	if #Batch.Removed > 0 then
		Stream.SendProp(Batch.Removed)
	end
	if #Batch.Created > 0 then
		Stream.SendCreate(Batch.Created)
	end
	if Config.ShowHitboxes then
		ShowHitbox(Hit)
	end
	if not Opts.Silent then
		Stream.SendSound(PickSome(Batch.Sounded, Config.SoundsPerHit))
		if #Batch.LooseSounds > 0 then
			Stream.SendSoundAt(Batch.LooseSounds[1])
		end
	end
	-- After Debree's own sends, so special props can never hold up the rubble
	local SpecialCount = BreakSpecials(Specials, HitCFrame.Position, Opts.Attacker, false)
	return #Batch.Sounded + #Batch.LooseSounds + SpecialCount
end

-- Obliterates everything breakable inside the volume, with no debris: whole parts inside it
-- vanish, parts partly inside are cut along it (the rest stays, whole, as boxes on the part's
-- own grid), and pieces left by earlier hits inside it disappear too. The ground
-- (Destroyable.Map.Floor) stays so nobody falls out of the map, unless IncludeGround (the
-- unbreakable map under it catches players), and so do the parts every hit skips (unanchored,
-- invisible, seats, spawns, Throwable, DebreeIgnore). KeepGround keeps everything that counts as
-- ground, not just that folder (floor slabs, parts flush with a floor) plus rubble from floors
-- broken earlier, the same as Destroy's KeepGround. Everything comes back at the usual reset.
-- For ultimates that wipe out what they pass through (WhiteBeard's Tsunami; JJS's Hollow
-- Purple). Returns how many parts and pieces were erased or cut.
-- WholeParts = true: nothing is cut. Every part and piece the volume touches is hidden whole
-- (no Split, no leftover boxes, nothing sent to Create). Much cheaper; use it where the cut
-- edge can't be seen (under water). Parts and pieces bigger than WholeMaxSize on any side
-- (default: no limit) are still cut the normal way, so one huge slab doesn't pop.
function DebreeService.Erase(
	HitCFrame: CFrame,
	HitSize: Vector3,
	Options: {
		Shape: ("Box" | "Ball" | "Oval" | Enum.PartType)?,
		GridSize: number?,
		GroundGridSize: number?,
		IncludeGround: boolean?, -- true = Destroyable.Map.Floor goes too: a crater in the ground
		KeepGround: boolean?, -- true = nothing that counts as ground goes, and neither does rubble
		-- from floors broken earlier (wins over IncludeGround)
		IgnoreBuildings: boolean?,
		WholeParts: boolean?, -- true = hide whatever is touched whole instead of cutting it
		WholeMaxSize: number?, -- with WholeParts: bigger than this on any side is still cut
	}?
): number
	if not Started then
		DebreeService.Start()
	end
	local Shape = ResolveShape(Options and Options.Shape)
	local Grid: Options = { GridSize = Options and Options.GridSize, GroundGridSize = Options and Options.GroundGridSize }
	local IncludeGround = Options ~= nil and Options.IncludeGround == true
	local KeepGround = Options ~= nil and Options.KeepGround == true
	local WholeParts = Options ~= nil and Options.WholeParts == true
	local WholeMaxSize = if Options and typeof(Options.WholeMaxSize) == "number" then Options.WholeMaxSize else math.huge
	local function TakeWhole(PartSize: Vector3): boolean
		return WholeParts and math.max(PartSize.X, PartSize.Y, PartSize.Z) <= WholeMaxSize
	end
	table.clear(FlushFloors) -- ResolveMode's per-call cache, as in Destroy
	local function KeepsGround(Part: BasePart): boolean
		if KeepGround and ResolveMode(Part, nil, nil) == "Ground" then
			return true
		end
		return not IncludeGround and InFloorFolder(Part)
	end
	local Size = HitSize:Max(Vector3.one * 0.05):Min(Vector3.one * Config.MaxEraseSize)
	local Hit: Split.Hit = { Shape = Shape, CFrame = HitCFrame, Size = Size }
	local Query = if Shape == "Ball" then BallQuery else BoxQuery
	Query.Size = if Shape == "Ball" then Vector3.one * math.min(Size.X, Size.Y, Size.Z) else Size
	Query.CFrame = HitCFrame
	local Touched = workspace:GetPartsInPart(Query, QueryParams)

	local Now = time()
	local WorldHit = Split._ToLocalHit(CFrame.identity, Hit)
	local Removed: { number } = {}
	local Created: { Piece } = {}
	local Specials: { [Model]: boolean } = {}
	local Count = 0

	local function WhollyInside(PartCFrame: CFrame, PartSize: Vector3): boolean
		return Split._Contains(Vector3.zero, PartSize / 2, Split._ToLocalHit(PartCFrame:Orthonormalize(), Hit))
	end
	-- Every cell the volume touches goes (Reach 0, so no grazed cells are left standing at
	-- the cut); what's left of the box stays as static boxes. nil if nothing is cut.
	local function Cut(PartCFrame: CFrame, PartSize: Vector3, Counts: Vector3, Glass: boolean): Split.Result?
		local Result = Split.Divide(PartCFrame, PartSize, Counts, Hit, Config.MaxCellsPerPart, Glass, 0)
		if not Result or #Result.Core == 0 or Registry.Available() < #Result.Leftover + #Result.Edge then
			return nil
		end
		return Result
	end
	local function Keep(Group: Group, Result: Split.Result)
		for _, List in { Result.Leftover, Result.Edge } do
			for _, Box in List do
				table.insert(Created, NewPiece(Group, Registry.Allocate() :: number, "Static", Box.CFrame, Box.Size))
			end
		end
		Group.ResetAt = Now + Config.ResetTime
	end

	for _, Part in Touched do
		if Options and Options.IgnoreBuildings and BuildingOfBody(Part) then continue end
		local Piece = Registry.FromBody(Part)
		local Special = if Piece or LooseParts[Part] then nil else SpecialModelOf(Part)
		if Piece then
			local Group, Body = Piece.Group, Piece.Body
			if KeepGround and Group.Mode == "Ground" then
				-- KeepGround: rubble of a floor broken earlier stays put too
			elseif TakeWhole(Body.Size) then
				-- WholeParts: any piece touched goes, no cut
				table.insert(Removed, Piece.Id)
				RemovePiece(Piece)
				Group.ResetAt = Now + Config.ResetTime
				Count += 1
			elseif Piece.Kind == "Debris" then
				if Split._ContainsPoint(Body.Position, WorldHit) then
					table.insert(Removed, Piece.Id)
					RemovePiece(Piece)
					Group.ResetAt = Now + Config.ResetTime
					Count += 1
				end
			elseif WhollyInside(Body.CFrame, Body.Size) then
				table.insert(Removed, Piece.Id)
				RemovePiece(Piece)
				Group.ResetAt = Now + Config.ResetTime
				Count += 1
			else
				local Result = Cut(Body.CFrame, Body.Size, Split.CountsFromCell(Body.Size, Group.CellSize), Group.Transparency > 0)
				if Result then
					table.insert(Removed, Piece.Id)
					RemovePiece(Piece)
					Keep(Group, Result)
					Count += 1
				end
			end
		elseif Special then
			Specials[Special] = true -- hidden whole by SpecialDestruction below
		elseif (LooseParts[Part] or not ShouldSkip(Part, true)) and not KeepsGround(Part) then
			local Launched = LooseParts[Part]
			if Launched then
				RestoreLoose(Part, Launched) -- back where it belongs first, so it comes back there
			end
			if TakeWhole(Part.Size) then
				-- WholeParts: hidden whole if touched at all, no cut
				NewGroup(Part, "Wall", Part.Size, Now) -- no pieces: it only comes back at the reset
				Part.Parent = Hidden
				Count += 1
			elseif not IsSplittable(Part) then
				-- meshes and unions can't be cut: gone if their middle is inside
				if Split._ContainsPoint(Part.Position, WorldHit) then
					NewGroup(Part, "Wall", Part.Size, Now) -- no pieces: it only comes back at the reset
					Part.Parent = Hidden
					Count += 1
				end
			elseif WhollyInside(Part.CFrame, Part.Size) then
				NewGroup(Part, "Wall", Part.Size, Now)
				Part.Parent = Hidden
				Count += 1
			else
				local Mode = ResolveMode(Part, nil, nil)
				local Result = Cut(Part.CFrame, Part.Size, Split.CountsFor(Part.Size, GridFor(Part, Grid, Mode)), Part.Transparency > 0)
				if Result then
					Keep(NewGroup(Part, Mode, Result.CellSize, Now), Result)
					Part.Parent = Hidden
					Count += 1
				end
			end
		end
	end

	-- Parts with CanQuery off (tree leaves) never show up in the query above: they go whole
	-- when their middle is inside
	local Reach = Size.Magnitude / 2
	for Part in Unqueryable do
		if Options and Options.IgnoreBuildings and BuildingOfBody(Part) then continue end
		if Part.Parent and (Part.Position - HitCFrame.Position).Magnitude <= Reach
			and Split._ContainsPoint(Part.Position, WorldHit)
		then
			local Special = SpecialModelOf(Part)
			if Special then
				Specials[Special] = true
			elseif not ShouldSkip(Part, true) and not KeepsGround(Part) then
				NewGroup(Part, "Wall", Part.Size, Now)
				Part.Parent = Hidden
				Count += 1
			end
		end
	end

	if #Removed > 0 then
		Stream.SendProp(Removed)
	end
	if #Created > 0 then
		Stream.SendCreate(Created)
	end
	if Config.ShowHitboxes then
		ShowHitbox(Hit)
	end
	Count += BreakSpecials(Specials, HitCFrame.Position, nil, true)
	return Count
end

------------------------------------------------------------------------
-- Absorb (Blackbeard's black holes)
------------------------------------------------------------------------

export type AbsorbOptions = {
	IgnoreBuildings: boolean?,
	Shape: ("Box" | "Ball" | "Oval" | Enum.PartType)?,
	Target: Attachment?, -- what the pieces fly into; they follow it while it exists
	Attacker: (Player | Model)?,
	IncludeGround: boolean?, -- true = floors get absorbed too (default: the ground stays)
	GridSize: number?, -- piece size override for intact parts (default: the part's own grid)
	MaxVisual: number?, -- most pieces animated per absorb (default ABSORB_MAX_VISUAL)
	Style: string?, -- how pieces move on clients: "Default", "Fast", "Tumble", "Orbit" or "Sink"
	-- (DebreeController's ABSORB_STYLES; nil = "Default")
	RubbleOnly: boolean?, -- true = only take loose rubble already lying there; walls, props, trees stay
	MaxPieceSize: number?, -- rubble longer than this on any side (studs) is left alone
	TargetId: string?, -- a target clients drive themselves (e.g. Sables' tornado anchor), by name;
	-- wins over Target. See DebreeController.SetTarget.
	MaxTake: number?, -- most rubble pieces taken; the rest is left where it is
	Report: { any }?, -- if given, gets { Color, Material, MaterialVariant, Size } for everything taken
	-- (rubble, cut cells, props, vanished meshes), whether or not it was animated. For color tallies.
}

-- Rubble already on screen is animated first (removing it without an animation would pop);
-- fresh cells past this just vanish with the hole. (tune)
local ABSORB_MAX_VISUAL = 500
-- Groups SpecialDestruction's flung pieces use (broken trees lying in World.Debris)
local ABSORB_DEBRIS_GROUPS: { [string]: boolean } = {
	TouchableDebris = true,
	NotTouchableVisualDestruction = true,
}

-- Like Erase, everything breakable in the volume goes (parts partly inside are cut along it, the
-- rest stays as boxes, it all comes back at the reset), but instead of vanishing it's pulled into
-- Options.Target on every client:
--   * rubble already in the volume: the client takes over the very part it's drawing, by ID, so
--     nothing is swapped and nothing flickers;
--   * intact map parts: the cut cells go out as boxes from the same Split.Divide that made the
--     hole, so they line up with it exactly;
--   * whitelisted special props (trees): hidden whole, the client animates copies of their parts;
--     broken tree pieces lying in the volume are taken too.
-- All of it goes out in one Absorb fire. Meshes and unions inside the volume vanish without an
-- animation (like Erase). The ground stays unless IncludeGround. Returns how much was taken.
function DebreeService.Absorb(HitCFrame: CFrame, HitSize: Vector3, Options: AbsorbOptions?): number
	if not Started then
		DebreeService.Start()
	end
	local Opts: AbsorbOptions = Options or {}
	local Shape = ResolveShape(Opts.Shape)
	local Size = HitSize:Max(Vector3.one * 0.05):Min(Vector3.one * Config.MaxHitSize)
	local Hit: Split.Hit = { Shape = Shape, CFrame = HitCFrame, Size = Size }
	local Query = if Shape == "Ball" then BallQuery else BoxQuery
	Query.Size = if Shape == "Ball" then Vector3.one * math.min(Size.X, Size.Y, Size.Z) else Size
	Query.CFrame = HitCFrame
	local Touched = workspace:GetPartsInPart(Query, QueryParams)

	local Now = time()
	local WorldHit = Split._ToLocalHit(CFrame.identity, Hit)
	local Feet = FeetHeight({ Attacker = Opts.Attacker })
	local GridOptions: Options = { GridSize = Opts.GridSize, GroundGridSize = Opts.GridSize }
	table.clear(FlushFloors)

	local Removed: { number } = {}
	local Created: { Piece } = {}
	local Taken: { number } = {}
	local Boxes: { Stream.AbsorbBox } = {}
	local Parts: { BasePart } = {}
	local Specials: { [Model]: boolean } = {}
	local TakenVolume: { [number]: number } = {}
	local Vanished = 0
	local Report = Opts.Report
	local function Record(Color: Color3, Material: Enum.Material, Variant: string, PieceSize: Vector3)
		if Report then
			table.insert(Report, { Color = Color, Material = Material, MaterialVariant = Variant, Size = PieceSize })
		end
	end

	local function KeepsGround(Mode: Mode): boolean
		return Mode == "Ground" and not Opts.IncludeGround
	end
	local function WhollyInside(PartCFrame: CFrame, PartSize: Vector3): boolean
		return Split._Contains(Vector3.zero, PartSize / 2, Split._ToLocalHit(PartCFrame:Orthonormalize(), Hit))
	end
	-- Every cell the volume touches goes (Reach 0); what's left of the box stays. nil = nothing cut.
	local function Cut(PartCFrame: CFrame, PartSize: Vector3, Counts: Vector3, Glass: boolean): Split.Result?
		local Result = Split.Divide(PartCFrame, PartSize, Counts, Hit, Config.MaxCellsPerPart, Glass, 0)
		if not Result or #Result.Core == 0 or Registry.Available() < #Result.Leftover + #Result.Edge then
			return nil
		end
		return Result
	end
	-- What's left stays as static boxes; the cut cells become absorb boxes, shrunk like debris
	-- so they never share a face with the boxes around them (shared faces z-fight = flicker).
	local function Keep(Group: Group, Result: Split.Result)
		for _, List in { Result.Leftover, Result.Edge } do
			for _, Box in List do
				table.insert(Created, NewPiece(Group, Registry.Allocate() :: number, "Static", Box.CFrame, Box.Size))
			end
		end
		for _, Box in Result.Core do
			table.insert(Boxes, { CFrame = Box.CFrame, Size = Box.Size, Group = Group }) --No * Group.Shrink. Cause we don't want shrink for absorb.
			Record(Group.Color, Group.Material, Group.Variant, Box.Size)
		end
		Group.ResetAt = Now + Config.ResetTime
	end
	local function Take(Piece: Piece)
		local S = Piece.Body.Size
		TakenVolume[Piece.Id] = S.X * S.Y * S.Z
		Record(Piece.Group.Color, Piece.Group.Material, Piece.Group.Variant, S)
		table.insert(Taken, Piece.Id)
		Piece.Group.ResetAt = Now + Config.ResetTime
		RemovePiece(Piece)
	end
	local function Vanish(Part: BasePart)
		NewGroup(Part, "Wall", Part.Size, Now) -- no pieces: it only comes back at the reset
		Record(Part.Color, Part.Material, Part.MaterialVariant, Part.Size)
		Part.Parent = Hidden
		Vanished += 1
	end
	local function TooBig(PieceSize: Vector3): boolean
		return Opts.MaxPieceSize ~= nil and math.max(PieceSize.X, PieceSize.Y, PieceSize.Z) > Opts.MaxPieceSize
	end

	for _, Part in Touched do
		if Opts.IgnoreBuildings and BuildingOfBody(Part) then continue end
		local Piece = Registry.FromBody(Part)
		local Special = if Piece or LooseParts[Part] then nil else SpecialModelOf(Part)
		if Piece then
			local Group, Body = Piece.Group, Piece.Body
			if KeepsGround(Group.Mode) then
				continue
			end
			if Piece.Kind == "Debris" then
				if Split._ContainsPoint(Body.Position, WorldHit) and not TooBig(Body.Size)
					and not (Opts.MaxTake and #Taken >= Opts.MaxTake)
				then
					Take(Piece)
				end
			elseif Opts.RubbleOnly then
				continue -- boxes still standing in a wall aren't rubble
			elseif WhollyInside(Body.CFrame, Body.Size) then
				Take(Piece)
			else
				local Result = Cut(Body.CFrame, Body.Size, Split.CountsFromCell(Body.Size, Group.CellSize), Group.Transparency > 0)
				if Result then
					table.insert(Removed, Piece.Id)
					RemovePiece(Piece)
					Keep(Group, Result)
				end
			end
		elseif Opts.RubbleOnly then
			continue -- intact walls, props and trees stay
		elseif Special then
			Specials[Special] = true
		elseif (LooseParts[Part] or not ShouldSkip(Part, true)) and not InFloorFolder(Part) then
			local Launched = LooseParts[Part]
			if Launched then
				RestoreLoose(Part, Launched) -- back where it belongs first, so it comes back there
			end
			if not IsSplittable(Part) then
				if Split._ContainsPoint(Part.Position, WorldHit) then
					Vanish(Part)
				end
			else
				local Mode = ResolveMode(Part, nil, Feet)
				if not KeepsGround(Mode) then
					local Result = Cut(Part.CFrame, Part.Size, Split.CountsFor(Part.Size, GridFor(Part, GridOptions, Mode)), Part.Transparency > 0)
					if Result then
						Keep(NewGroup(Part, Mode, Result.CellSize, Now), Result)
						Part.Parent = Hidden
					end
				end
			end
		end
	end

	-- CanQuery-off parts (leaves) never show up in the query: checked by position, like Erase
	local Reach = Size.Magnitude / 2
	for Part in Unqueryable do
		if Opts.IgnoreBuildings and BuildingOfBody(Part) then continue end
		if Part.Parent and (Part.Position - HitCFrame.Position).Magnitude <= Reach
			and Split._ContainsPoint(Part.Position, WorldHit)
		then
			local Special = SpecialModelOf(Part)
			if Special then
				Specials[Special] = true
			elseif not ShouldSkip(Part, true) and not InFloorFolder(Part) then
				Vanish(Part)
			end
		end
	end

	-- Special props: collect what's visible BEFORE hiding it (process() saves each part's look in
	-- __OrigTrans, which the client copies read)
	local Player = AttackerPlayer(Opts.Attacker)
	for Model in Specials do
		if not Model:GetAttribute("IsDestroyed") then
			for _, Descendant in Model:GetDescendants() do
				if Descendant:IsA("BasePart") and Descendant.Transparency < 1 then
					table.insert(Parts, Descendant)
				end
			end
		end
		SpecialDestruction.process(Model, HitCFrame.Position, Player, Config.ResetTime, { DestroyAll = true })
	end
	-- Broken tree pieces lying around: CanQuery is off on them, so they're checked by position
	local World = workspace:FindFirstChild("World")
	local DebrisFolder = World and World:FindFirstChild("Debris")
	if DebrisFolder then
		for _, Descendant in DebrisFolder:GetDescendants() do
			if Descendant:IsA("BasePart") and ABSORB_DEBRIS_GROUPS[Descendant.CollisionGroup]
				and Descendant.Transparency < 1 and Split._ContainsPoint(Descendant.Position, WorldHit)
				and not TooBig(Descendant.Size)
			then
				if Descendant:GetAttribute("__OrigTrans") == nil then
					Descendant:SetAttribute("__OrigTrans", Descendant.Transparency)
				end
				Descendant.Transparency = 1
				Descendant.CanCollide = false
				table.insert(Parts, Descendant)
			end
		end
	end

	for _, Prop in Parts do
		Record(Prop.Color, Prop.Material, Prop.MaterialVariant, Prop.Size)
	end

	-- Cap what gets animated
	local MaxVisual = Opts.MaxVisual or ABSORB_MAX_VISUAL
	if #Taken > MaxVisual then
		table.sort(Taken, function(A, B)
			return TakenVolume[A] > TakenVolume[B]
		end)
	end
	while #Taken > MaxVisual do
		table.insert(Removed, table.remove(Taken) :: number)
	end
	local Room = MaxVisual - #Taken
	if #Boxes > Room then
		for Index = 1, Room do
			local Swap = Rng:NextInteger(Index, #Boxes)
			Boxes[Index], Boxes[Swap] = Boxes[Swap], Boxes[Index]
		end
		for Index = #Boxes, Room + 1, -1 do
			Boxes[Index] = nil
		end
	end

	if #Removed > 0 or #Created > 0 or #Taken > 0 or #Boxes > 0 or #Parts > 0 then
		local Target = Opts.Target
		Stream.SendAbsorb({
			Removed = Removed,
			Created = Created,
			Taken = Taken,
			Boxes = Boxes,
			Parts = Parts,
			Target = Target,
			Style = Opts.Style,
			TargetId = Opts.TargetId,
			Center = if Target and Target.Parent then Target.WorldPosition else HitCFrame.Position,
		})
	end
	if Config.ShowHitboxes then
		ShowHitbox(Hit)
	end
	return #Taken + #Boxes + #Parts + Vanished
end

-- The folder holding the server's physics copies of all pieces (under the server camera).
-- Add it to a RaycastParams / OverlapParams filter if a server system needs to hit rubble.
function DebreeService.GetBodiesFolder(): Folder
	if not Started then
		DebreeService.Start()
	end
	return Bodies
end

-- How many pieces are live right now.
function DebreeService.GetPieceCount(): number
	return Registry.Count()
end

------------------------------------------------------------------------
-- Every frame: physics streaming and resets
------------------------------------------------------------------------

local function PhysicsTick(Interval: number)
	local Now = time()
	local FallenY = workspace.FallenPartsDestroyHeight + Config.FallenMargin
	local Lost: { Piece } = {}
	local Moves: { Piece } = {}
	local Entries: { Stream.PhysicsEntry } = {}

	for Piece in Moving do
		local Body = Piece.Body
		if Body.Parent == nil or Body.Position.Y < FallenY then
			table.insert(Lost, Piece)
			continue
		end
		Piece.MovingFor += Interval
		if #Piece.Ghosts > 0 then
			ReleaseGhosts(Piece)
		end
		if Piece.Slick then
			UpdateSlick(Piece)
		end
		local Still = Body.AssemblyLinearVelocity.Magnitude < Config.SleepSpeed
			and Body.AssemblyAngularVelocity.Magnitude < Config.SleepAngularSpeed
		Piece.StillFor = if Still then Piece.StillFor + Interval else 0
		if Still and TipOff(Piece) then
			continue -- it's on its way off whatever it stopped on
		elseif Piece.StillFor >= Config.SleepTime or Piece.MovingFor >= Config.MaxMoveTime then
			Settle(Piece, Now)
		elseif TransformChanged(Piece.SentCFrame, Body.CFrame) or (Overshot[Piece] and Body.AssemblyLinearVelocity.Magnitude < 1) then
			table.insert(Moves, Piece)
		end
	end

	-- Settled positions first: they're the ones that must arrive. They go over the reliable
	-- Settle remote, so one send is enough; without it they're resent over Physics.
	local Resends = if Stream.HasReliableSettle() then NO_RESENDS else Config.SettleResends
	for Piece in Announcing do
		local Due = if Piece.ResendIndex == 0 then Piece.SettledAt else Piece.SettledAt + Resends[Piece.ResendIndex]
		if Now >= Due then
			table.insert(Entries, { Id = Piece.Id, Transform = Piece.Body.CFrame, Settled = true })
			Piece.SentCFrame = Piece.Body.CFrame
			Piece.LastSentAt = Now
			Piece.ResendIndex += 1
			if Piece.ResendIndex > #Resends then
				Announcing[Piece] = nil
			end
		end
	end

	-- Then moving pieces, the longest-waiting first, up to the budget. One that has (nearly)
	-- stopped gets a settle-style record: the client tweens it to exactly that spot instead of
	-- 1.5x past it, which would leave it drawn inside whatever stopped it (see Overshot).
	table.sort(Moves, function(A, B)
		return A.LastSentAt < B.LastSentAt
	end)
	for _, Piece in Moves do
		if #Entries >= Config.RecordsPerTick then
			break
		end
		local Transform = Piece.Body.CFrame
		local Exact = Piece.Body.AssemblyLinearVelocity.Magnitude < 1
		table.insert(Entries, { Id = Piece.Id, Transform = Transform, Settled = Exact })
		Overshot[Piece] = if Exact then nil else true
		Piece.SentCFrame = Transform
		Piece.LastSentAt = Now
	end

	if #Entries > 0 then
		Stream.SendPhysics(Entries)
	end

	if #Lost > 0 then
		local Ids = table.create(#Lost)
		for Index, Piece in Lost do
			Ids[Index] = Piece.Id
			RemovePiece(Piece)
		end
		Stream.SendProp(Ids)
	end

	-- Whole parts that fell out of the map go back now instead of being destroyed
	for Part, Info in LooseParts do
		if Part.Parent and Part.Position.Y < FallenY then
			RestoreLoose(Part, Info)
		end
	end
end

local function ResetGroup(Group: Group, Ids: { number })
	ActiveGroups[Group] = nil
	GroupsByOriginal[Group.Original] = nil
	for _, Piece in Group.Pieces do
		table.insert(Ids, Piece.Id)
		RemovePiece(Piece)
	end
	local Original, Parent = Group.Original, Group.OriginalParent
	if Parent.Parent ~= nil then -- the model it came from still exists
		Original.Parent = Parent
		local Model = Group.PrimaryOf
		if Model and Model.Parent and Model.PrimaryPart == nil then
			Model.PrimaryPart = Original
		end
	end
end

local function ResetTick()
	local Now = time()
	for Model, State in BuildingStates do
		if Now >= State.Expires or not Model.Parent then
			ClearBuildingPreview(State)
			BuildingStates[Model] = nil
		end
	end
	local Ids: { number } = {}
	for Group in ActiveGroups do
		if Now >= Group.ResetAt then
			ResetGroup(Group, Ids)
		end
	end
	if #Ids > 0 then
		Stream.SendProp(Ids)
		WarnedFull = false
	end
	for Part, Info in LooseParts do
		if Now >= Info.ResetAt then
			RestoreLoose(Part, Info)
		end
	end
end

local function Step(DeltaTime: number)
	FlushBuildingWork()
	StepBuildingPreview()
	PhysicsClock += DeltaTime
	local Period = 1 / Config.PhysicsHz
	if PhysicsClock >= Period then
		local Interval = PhysicsClock
		PhysicsClock = 0
		PhysicsTick(Interval)
	end
	ResetClock += DeltaTime
	if ResetClock >= Config.ResetCheckInterval then
		ResetClock = 0
		ResetTick()
	end
end

-- Everything currently broken, to one player who just became ready.
local function SendSnapshot(Player: Player)
	local List: { Piece } = {}
	for _, Piece in Registry.All() do
		table.insert(List, Piece)
	end
	if #List > 0 then
		Stream.SendCreateTo(Player, List, true)
	end
	BuildingMotion.Snapshot(Player)
end

------------------------------------------------------------------------
-- Start
------------------------------------------------------------------------

-- Sets Debree up. Called by ServerScriptService > DebreeInit; safe to call more than once.
function DebreeService.Start()
	if Started then
		return
	end
	assert(RunService:IsServer(), "DebreeService runs on the server only")
	Started = true

	-- Arena place only: swap in ServerStorage.ArenaMap before the map is referenced below.
	-- Does nothing in Demon Fruits.
	local ArenaFolder = game:GetService("ServerScriptService"):FindFirstChild("Arena")
	local ArenaMapLoader = ArenaFolder and ArenaFolder:FindFirstChild("ArenaMapLoader")
	if ArenaMapLoader then
		local ok, err = pcall(function()
			require(ArenaMapLoader).Load()
		end)
		if not ok then
			warn("[Arena] Map swap failed:", err)
		end
	end

	local Map = workspace:WaitForChild("World"):WaitForChild("Map")
	Destroyable = Map:WaitForChild("Destroyable")
	local MapFolder = Destroyable:FindFirstChild("Map")
	FloorFolder = if MapFolder then MapFolder:FindFirstChild("Floor") else nil
	BuildingRemains.PrepareFloor(FloorFolder)

	-- Parts leave Destroyable while broken (in Hidden) and come back at the reset
	local function Track(Thing: Instance)
		if Thing:IsA("BasePart") and not Thing.CanQuery then
			Unqueryable[Thing] = true
		end
	end
	for _, Thing in Destroyable:GetDescendants() do
		Track(Thing)
	end
	Destroyable.DescendantAdded:Connect(Track)
	Destroyable.DescendantRemoving:Connect(function(Thing)
		Unqueryable[Thing :: BasePart] = nil
	end)

	Hidden = Instance.new("Folder")
	Hidden.Name = "DebreeHidden"
	Hidden.Parent = ServerStorage

	-- Children of the server's camera are simulated and found by spatial queries on the
	-- server, but never replicate to clients (the same trick ShatterBox uses).
	local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera", 10)
	if not Camera then
		warn("Debree: the server has no workspace.CurrentCamera; rubble won't be solid on the server")
	end
	Bodies = Instance.new("Folder")
	Bodies.Name = "DebreeBodies"
	Bodies.Parent = Camera

	QueryParams = OverlapParams.new()
	QueryParams.FilterType = Enum.RaycastFilterType.Include
	QueryParams.FilterDescendantsInstances = { Destroyable, Bodies }

	SolidParams = OverlapParams.new()
	SolidParams.FilterType = Enum.RaycastFilterType.Include
	SolidParams.FilterDescendantsInstances = { Map, Bodies }
	SolidParams.RespectCanCollide = true
	GhostParams = OverlapParams.new()
	GhostParams.FilterType = Enum.RaycastFilterType.Include
	DownRay = RaycastParams.new()
	DownRay.FilterType = Enum.RaycastFilterType.Include
	SolidRay = RaycastParams.new()
	SolidRay.FilterType = Enum.RaycastFilterType.Include
	SolidRay.FilterDescendantsInstances = { Map, Bodies }
	SolidRay.RespectCanCollide = true
	FeetRay = RaycastParams.new()
	FeetRay.FilterType = Enum.RaycastFilterType.Exclude
	FeetRay.RespectCanCollide = true
	FloorRay = RaycastParams.new()
	FloorRay.FilterType = Enum.RaycastFilterType.Include
	FloorRay.FilterDescendantsInstances = { Destroyable, Bodies }
	FloorRay.RespectCanCollide = true

	-- The server's physics copies: a group that collides with everything except players
	local Registered = pcall(function()
		if not PhysicsService:IsCollisionGroupRegistered(Config.BodyCollisionGroup) then
			PhysicsService:RegisterCollisionGroup(Config.BodyCollisionGroup)
		end
		for _, Other in Config.BodyIgnoresGroups do
			if PhysicsService:IsCollisionGroupRegistered(Other) then
				PhysicsService:CollisionGroupSetCollidable(Config.BodyCollisionGroup, Other, false)
			end
		end
	end)
	BodyGroup = if Registered then Config.BodyCollisionGroup else "Default"

	-- Still pieces: a group that collides with everything, characters included
	local StaticRegistered = pcall(function()
		if not PhysicsService:IsCollisionGroupRegistered(Config.StaticBodyCollisionGroup) then
			PhysicsService:RegisterCollisionGroup(Config.StaticBodyCollisionGroup)
		end
	end)
	StaticBodyGroup = if StaticRegistered then Config.StaticBodyCollisionGroup else BodyGroup

	local function MakeQuery(Shape: Enum.PartType): Part
		local Query = Instance.new("Part")
		Query.Name = "DebreeQuery"
		Query.Shape = Shape
		Query.Anchored = true
		Query.CanCollide = false
		Query.CanTouch = false
		Query.CanQuery = false
		return Query -- never parented: GetPartsInPart works with an unparented part
	end
	BoxQuery = MakeQuery(Enum.PartType.Block)
	BallQuery = MakeQuery(Enum.PartType.Ball)
	PointQuery = MakeQuery(Enum.PartType.Ball)
	PointQuery.Size = Vector3.one * 0.1
	DeepQuery = MakeQuery(Enum.PartType.Block)

	Registry.MaxId = Config.MaxLivePieces
	BuildingMotion.Start()
	Stream.Start(SendSnapshot)
	TsunamiDestruction.Start(Destroyable,FloorFolder,{BuildingState=BuildingState,Apply=ApplyTsunamiJob})
	RunService.Heartbeat:Connect(Step)
end

return DebreeService

