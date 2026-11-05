--!strict
-- ReplicatedStorage > Modules > Debree > DebreeController   (ModuleScript, CLIENT only)
--
-- The client side of Debree. It draws every piece the server tells it about, using a
-- pool of DebreeRef copies, and never decides anything itself.
-- Started once by StarterPlayer > StarterPlayerScripts > DebreeClient.
--
-- Behavior is the same as JJS's FXController (its DebreeService client), rewritten:
--   Create   pieces from the three buffers of each group; one BulkMoveTo per payload
--   Physics  0.2 s linear tween to Lerp(target, 1.5) while moving, 0.4 s Quad Out when
--            settled; pieces not marked for interpolation snap
--   Settle   the same records for pieces that came to rest, over a reliable remote (our addition)
--   Prop     pieces go back to the pool
--   Sound    a material debris sound within 300 studs (Manhattan)
--   A background loop marks anchored moving-type pieces for interpolation, 20 per frame.
-- Deliberate differences from JJS:
--   * no break smoke;
--   * interpolation is always on (JJS's "Destruction Interpolation" setting isn't used);
--   * MaterialVariant comes through the material key ("8|StylizedConBrick");
--   * sounds come from this game's Assets.Sounds.Enviroment folders, picked through
--     MaterialFolder below; unmapped materials and empty folders fall back to StoneImpact.
--
-- Other client code can also call DebreeController.DustBreak(...) for JJS's cosmetic dust.

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local Shared = script.Parent
local Config = require(Shared:WaitForChild("Config"))
local Materials = require(Shared:WaitForChild("Materials"))
local Records = require(Shared:WaitForChild("Records"))

type Entry = {
	Part: BasePart,
	Interpolate: boolean,
	Tween: Tween?,
}

local DebreeController = {}

-- Every piece this client is drawing, by ID. Read it; don't modify it.
DebreeController.Voxels = {} :: { [number]: Entry }
local Voxels = DebreeController.Voxels

local Started = false
local Template: BasePart
local PoolFolder: Instance
local DustFolder: Instance
local DustParams: RaycastParams
local SoundGroup: SoundGroup?

-- Sounds by folder name under Assets.Sounds.Enviroment, filled in Start
local SoundsByFolder: { [string]: { Sound } } = {}

-- Used for any material not listed below, and when a material's folder has no sounds
local FALLBACK_FOLDER = "StoneImpact"

-- Which Enviroment folder each material's debris plays
local MaterialFolder: { [Enum.Material]: string } = {
	-- Stone
	[Enum.Material.Concrete] = "StoneImpact",
	[Enum.Material.Limestone] = "StoneImpact",
	[Enum.Material.Slate] = "StoneImpact",
	[Enum.Material.Granite] = "StoneImpact",
	[Enum.Material.Marble] = "StoneImpact",
	[Enum.Material.Rock] = "StoneImpact",
	[Enum.Material.Basalt] = "StoneImpact",
	[Enum.Material.Sandstone] = "StoneImpact",
	[Enum.Material.Cobblestone] = "StoneImpact",
	[Enum.Material.Pebble] = "StoneImpact",
	[Enum.Material.Pavement] = "StoneImpact",
	[Enum.Material.Asphalt] = "StoneImpact",
	[Enum.Material.CrackedLava] = "StoneImpact",
	[Enum.Material.Salt] = "StoneImpact",

	-- Brick and fired clay
	[Enum.Material.Brick] = "BrickImpact",
	[Enum.Material.Plaster] = "BrickImpact",
	[Enum.Material.CeramicTiles] = "BrickImpact",
	[Enum.Material.ClayRoofTiles] = "BrickImpact",
	[Enum.Material.RoofShingles] = "BrickImpact",

	-- Glass and ice
	[Enum.Material.Glass] = "GlassImpact",
	[Enum.Material.Ice] = "GlassImpact",
	[Enum.Material.Glacier] = "GlassImpact",
	[Enum.Material.ForceField] = "GlassImpact",

	-- Soft ground and cloth
	[Enum.Material.Grass] = "GrassImpact",
	[Enum.Material.LeafyGrass] = "GrassImpact",
	[Enum.Material.Ground] = "GrassImpact",
	[Enum.Material.Mud] = "GrassImpact",
	[Enum.Material.Sand] = "GrassImpact",
	[Enum.Material.Snow] = "GrassImpact",
	[Enum.Material.Fabric] = "GrassImpact",
	[Enum.Material.Carpet] = "GrassImpact",

	-- Metal
	[Enum.Material.Metal] = "MetalImpact",
	[Enum.Material.DiamondPlate] = "MetalImpact",
	[Enum.Material.CorrodedMetal] = "MetalImpact",
	[Enum.Material.Foil] = "MetalImpact",

	-- Neon
	[Enum.Material.Neon] = "NeonImpact",

	-- Wood
	[Enum.Material.Wood] = "WoodImpact",
	[Enum.Material.WoodPlanks] = "WoodImpact",
	[Enum.Material.Cardboard] = "WoodImpact",
}

local MoveTween = TweenInfo.new(Config.MoveTweenTime, Enum.EasingStyle.Linear)
local SettleTween = TweenInfo.new(Config.SettleTweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local FlyingFade = TweenInfo.new(Config.FlyingFadeTime)
local DustFade = TweenInfo.new(Config.DustFadeTime)

local function Manhattan(A: Vector3, B: Vector3): number
	return math.abs(A.X - B.X) + math.abs(A.Y - B.Y) + math.abs(A.Z - B.Z)
end

local function CameraPosition(): Vector3
	local Camera = workspace.CurrentCamera
	return if Camera then Camera.CFrame.Position else Vector3.zero
end

------------------------------------------------------------------------
-- Part pool (JJS's PartCache: made up front, parked far away, never destroyed)
------------------------------------------------------------------------

local Open: { BasePart } = {}
local InUse: { [BasePart]: boolean } = {}

local function MakePart(): BasePart
	local Part = Template:Clone()
	Part.CFrame = Config.ParkCFrame
	Part.Anchored = true
	Part.Parent = PoolFolder
	return Part
end

local function GetPart(): BasePart
	if #Open == 0 then
		for _ = 1, Config.PoolGrow do
			table.insert(Open, MakePart())
		end
	end
	local Part = table.remove(Open) :: BasePart
	InUse[Part] = true
	return Part
end

local function ReturnPart(Part: BasePart)
	if not InUse[Part] then
		return
	end
	InUse[Part] = nil
	if not Part.Parent then
		return -- destroyed by something else; the pool just forgets it
	end
	Part.Anchored = true
	Part.CFrame = Config.ParkCFrame
	Part.AssemblyLinearVelocity = Vector3.zero
	Part.AssemblyAngularVelocity = Vector3.zero
	table.insert(Open, Part)
end

------------------------------------------------------------------------
-- Create
------------------------------------------------------------------------

local ColorCache: { [string]: Color3 } = {}

local function ParseColor(Key: string): Color3
	local Cached = ColorCache[Key]
	if not Cached then
		local R, G, B = string.match(Key, "^(%d+),(%d+),(%d+)$")
		Cached = Color3.fromRGB(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255)
		ColorCache[Key] = Cached
	end
	return Cached
end

local function Dress(Part: BasePart, Size: Vector3, Color: Color3, Material: Enum.Material, Variant: string, Transparency: number)
	Part.Size = Size
	Part.Color = Color
	Part.Material = Material
	Part.MaterialVariant = Variant
	Part.Transparency = Transparency
end

local function OnCreate(Groups: any, _Silent: any)
	if typeof(Groups) ~= "table" then
		return
	end
	local Camera = CameraPosition()
	local Parts: { BasePart } = {}
	local CFrames: { CFrame } = {}

	for TransparencyKey, ByMaterial in Groups do
		local Transparency = tonumber(TransparencyKey) or 0
		for MaterialKey, ByColor in ByMaterial do
			local Material, Variant = Materials.FromKey(tostring(MaterialKey))
			for ColorKey, Buffers in ByColor do
				local Color = ParseColor(tostring(ColorKey))
				local StaticBuffer, MovedBuffer, FlyingBuffer = Buffers[1], Buffers[2], Buffers[3]

				-- staticBuf: resting pieces (leftovers). Not dynamic, casts shadows, never moves.
				if typeof(StaticBuffer) == "buffer" then
					for Index = 1, Records.Count(StaticBuffer, Records.PIECE_SIZE) do
						local Transform, Size, Id = Records.ReadPiece(StaticBuffer, Index)
						if not Voxels[Id] then
							local Part = GetPart()
							Dress(Part, Size, Color, Material, Variant, Transparency)
							Part.Anchored = true
							Part.Locked = false -- JJS's marker for "static"
							Part.CastShadow = true
							Voxels[Id] = { Part = Part, Interpolate = false }
							table.insert(Parts, Part)
							table.insert(CFrames, Transform)
						end
					end
				end

				-- movedBuf: pieces the server moves through Physics. Interpolated when the
				-- group's first new piece is near the camera.
				if typeof(MovedBuffer) == "buffer" then
					local Near = false
					for Index = 1, Records.Count(MovedBuffer, Records.PIECE_SIZE) do
						local Transform, Size, Id = Records.ReadPiece(MovedBuffer, Index)
						if not Voxels[Id] then
							if Index == 1 then
								Near = Manhattan(Camera, Transform.Position) < Config.NearDistance
							end
							local Part = GetPart()
							Dress(Part, Size, Color, Material, Variant, Transparency)
							Part.Anchored = true
							Part.Locked = true -- JJS's marker for "dynamic"
							Part.CastShadow = false
							Voxels[Id] = { Part = Part, Interpolate = Near }
							table.insert(Parts, Part)
							table.insert(CFrames, Transform)
						end
					end
				end

				-- flyingBuf: debris this client simulates itself; only drawn near the camera,
				-- fades out after a few seconds. (Debree's server leaves it empty.)
				if typeof(FlyingBuffer) == "buffer" then
					local Draw = false
					for Index = 1, Records.Count(FlyingBuffer, Records.FLYING_SIZE) do
						local Transform, Size, Id, Linear, Angular = Records.ReadFlying(FlyingBuffer, Index)
						if not Voxels[Id] then
							if Index == 1 then
								Draw = Manhattan(Camera, Transform.Position) < Config.FlyingDistance
							end
							if Draw then
								local Part = GetPart()
								Dress(Part, Size, Color, Material, Variant, Transparency)
								Part.Anchored = false
								Part.Locked = true
								Part.CastShadow = false
								Part.AssemblyLinearVelocity = Linear
								Part.AssemblyAngularVelocity = Angular
								local New: Entry = { Part = Part, Interpolate = false }
								Voxels[Id] = New
								table.insert(Parts, Part)
								table.insert(CFrames, Transform)
								task.delay(Config.FlyingFadeDelay, function()
									if Voxels[Id] ~= New then
										return -- already removed (and maybe reused)
									end
									local Fade = TweenService:Create(Part, FlyingFade, { Transparency = 1 })
									Fade:Play()
									New.Tween = Fade
								end)
							end
						end
					end
				end
			end
		end
	end

	if #Parts > 0 then
		workspace:BulkMoveTo(Parts, CFrames, Enum.BulkMoveMode.FireCFrameChanged)
	end
end

------------------------------------------------------------------------
-- Physics
------------------------------------------------------------------------

local function OnPhysics(Payload: any)
	if typeof(Payload) ~= "buffer" then
		return
	end
	for Index = 1, Records.Count(Payload, Records.PHYSICS_SIZE) do
		local Target, Id, Settled = Records.ReadPhysics(Payload, Index)
		local Entry = Voxels[Id]
		if Entry and Entry.Part.Locked ~= false then
			local Part = Entry.Part
			if Entry.Interpolate then
				if Entry.Tween then
					Entry.Tween:Cancel()
				end
				local Tween = if Settled
					then TweenService:Create(Part, SettleTween, { CFrame = Target })
					else TweenService:Create(Part, MoveTween, { CFrame = Part.CFrame:Lerp(Target, Config.MoveOvershoot) })
				Tween:Play()
				Entry.Tween = Tween
			else
				Part.CFrame = Target
			end
		end
	end
end

-- JJS's background loop: every anchored moving-type piece gets marked for interpolation,
-- a few per frame so it never causes a spike.
local function MarkLoop()
	while true do
		task.wait()
		local Ids = {}
		for Id in Voxels do
			table.insert(Ids, Id)
		end
		local Marked = 0
		for _, Id in Ids do
			local Entry = Voxels[Id]
			if Entry and Entry.Part.Locked ~= false and Entry.Part.Anchored ~= false then
				Entry.Interpolate = true
				Marked += 1
				if Marked > Config.InterpolateMarkPerFrame then
					task.wait()
					Marked = 0
				end
			end
		end
	end
end

------------------------------------------------------------------------
-- Prop
------------------------------------------------------------------------

local function OnProp(Ids: any)
	if typeof(Ids) ~= "table" then
		return
	end
	for _, Id in Ids do
		local Entry = Voxels[Id]
		if Entry then
			Voxels[Id] = nil
			if Entry.Tween then
				Entry.Tween:Cancel()
			end
			ReturnPart(Entry.Part)
		end
	end
end

------------------------------------------------------------------------
-- Sound
------------------------------------------------------------------------

local function SoundsFor(Material: Enum.Material): { Sound }
	local List = SoundsByFolder[MaterialFolder[Material] or FALLBACK_FOLDER]
	if List and #List > 0 then
		return List
	end
	return SoundsByFolder[FALLBACK_FOLDER] or {}
end

local function DebreeSound(Target: Instance)
	if not Target:IsA("BasePart") then
		return
	end
	if Manhattan(CameraPosition(), Target.Position) > Config.SoundDistance then
		return
	end
	local List = SoundsFor(Target.Material)
	if #List == 0 then
		return
	end
	local Sound = List[math.random(1, #List)]:Clone()
	Sound.SoundGroup = SoundGroup
	Sound.Parent = Target
	Sound:Play()
	Sound.Ended:Once(function()
		Sound:Destroy()
	end)
	Debris:AddItem(Sound, 10) -- in case Ended never fires (asset failed to load)
end

local function OnSound(Payload: any)
	if not Payload then
		return
	end
	if typeof(Payload) == "buffer" then
		for _, Id in Records.ReadIds(Payload) do
			local Entry = Voxels[Id]
			if Entry then
				DebreeSound(Entry.Part)
			end
		end
	elseif typeof(Payload) == "number" then
		local Entry = Voxels[Payload]
		if Entry then
			DebreeSound(Entry.Part)
		end
	elseif typeof(Payload) == "Instance" then
		DebreeSound(Payload)
	end
end

------------------------------------------------------------------------
-- DustBreak (JJS's cosmetic dust; purely local, never networked)
------------------------------------------------------------------------

-- JJS's "Physics VFX" setting is this game's existing "Destruction Physics" setting.
local function DustEnabled(): boolean
	local Configuration = Players.LocalPlayer:FindFirstChild("Configuration")
	local Setting = Configuration and Configuration:FindFirstChild("Destruction Physics")
	if Setting and Setting:IsA("BoolValue") then
		return Setting.Value
	end
	return true
end

-- Kicks up Count small chips from the surface around Position (facing Normal), within
-- Radius, each MinSize..MaxSize per axis and colored like the surface they came from.
function DebreeController.DustBreak(
	Position: Vector3,
	Normal: Vector3,
	Radius: number,
	Count: number,
	MinSize: number,
	MaxSize: number,
	RayLength: number?
)
	if not Started then
		return
	end
	if Manhattan(CameraPosition(), Position) > Config.DustDistance or not DustEnabled() then
		return
	end
	local Origin = CFrame.new(Position, Position + Normal)
	local SizeMin, SizeMax = math.floor(MinSize * 10), math.floor(MaxSize * 10)
	local Side, Spin = Config.DustSideSpeed, Config.DustSpin
	for _ = 1, Count do
		-- JJS: a random whole-radian turn (0..3) and a random distance out to Radius
		local Point = (Origin * CFrame.Angles(0, 0, math.random(0, 3)) * CFrame.new(math.random(0, math.floor(Radius * 10)) / 10, 0, 0)).Position
		local Result = workspace:Raycast(Point, Origin.LookVector * -(RayLength or Config.DustRayLength), DustParams)
		if Result and Result.Instance:IsA("BasePart") then
			local Surface = Result.Instance :: BasePart
			local Chip = Template:Clone()
			Chip.Color = Surface.Color
			Chip.Material = Surface.Material
			Chip.MaterialVariant = Surface.MaterialVariant
			Chip.Transparency = Surface.Transparency
			Chip.Size = Vector3.new(
				math.random(SizeMin, SizeMax) / 10,
				math.random(SizeMin, SizeMax) / 10,
				math.random(SizeMin, SizeMax) / 10
			)
			Chip.Position = Result.Position
			Chip.CollisionGroup = Config.DustCollisionGroup
			Chip.Anchored = false
			Chip.Parent = DustFolder
			Chip.AssemblyLinearVelocity = Vector3.new(
				math.random(-Side, Side),
				math.random(Config.DustUpSpeedMin, Config.DustUpSpeedMax),
				math.random(-Side, Side)
			)
			Chip.AssemblyAngularVelocity = Vector3.new(math.random(-Spin, Spin), math.random(-Spin, Spin), math.random(-Spin, Spin))
			task.delay(Config.DustLifetime, function()
				TweenService:Create(Chip, DustFade, { Transparency = 1 }):Play()
				Debris:AddItem(Chip, Config.DustFadeTime)
			end)
		end
	end
end

------------------------------------------------------------------------
-- Absorb (Blackbeard): the server's DebreeService.Absorb, one fire per absorb. It all happens
-- in OnAbsorb, in this order, so the hole and the moving pieces appear in the same frame:
--   1. Taken: pieces this client is already drawing are taken out of Debree's hands by ID.
--      They're the same parts, so nothing is swapped and nothing flickers.
--   2. Removed / Create: the hole's other rubble goes, the boxes left around it appear.
--   3. Boxes: the cells cut out of intact parts come from the pool, at full cell size.
--   4. Parts: special props (trees) are copied from the hidden originals.
-- Then they move the way the absorb's Style says (ABSORB_STYLES) and go back to the pool.
-- Pool parts are never destroyed.
------------------------------------------------------------------------

local ABSORB_DRAW_DISTANCE = 300 -- Manhattan studs from the camera; farther absorbs aren't animated
local ABSORB_MAX_ACTIVE = 450 -- most absorb pieces moving at once, across all absorbs (tune)
local ABSORB_MIN_SCALE = 0.03

-- How pieces move, per move (Options.Style on the server), copied from each move's old
-- ClientEffects absorb. "Pull" styles fly into the target; "Sink" slides toward it and sinks.
--   Pull, ClosePull: studs/s^2 toward the target, plus extra that grows as a piece gets close
--   Swirl: sideways start speed (spiral in); Tumble x SpinScale: how fast pieces turn
--   WaveTime: the farthest piece starts this much after the nearest; MaxTime: hard end (s)
--   Shrink "Radius": shrinks inside ShrinkRadius, and dissolves after DissolveDelay if set
--   Shrink "Progress": shrinks with how far along its trip it is, gone at KillScale
--     (FadeStart: the scale where fading starts; without it, it fades as it shrinks)
type AbsorbStyle = { [string]: any }
local ABSORB_STYLES: { [string]: AbsorbStyle } = {
	-- Ability2: the black hole at Blackbeard's feet
	Default = {
		Motion = "Pull", WaveTime = 0.3, Pull = 150, ClosePull = 200, MaxSpeed = 110, Damping = 1.4,
		Swirl = 20, Tumble = 16, SpinScale = math.rad(4), ConsumeRadius = 1.5, MaxTime = 2,
		Shrink = "Radius", ShrinkRadius = 6, MinShrink = 0, DissolveDelay = 1, DissolveTime = 0.6,
	},
	-- Ability1: the vortex in front, fast and direct
	Fast = {
		Motion = "Pull", WaveTime = 0.18, Pull = 150, ClosePull = 150, MaxSpeed = 95, Damping = 1.5,
		Swirl = 9, Tumble = 16, SpinScale = 1, ConsumeRadius = 1.5, MaxTime = 0.9,
		Shrink = "Radius", ShrinkRadius = 5, MinShrink = 0.05,
	},
	-- Ability3, Ability4 and Liberation's sky ball: tumbling, shrinking along the trip
	Tumble = {
		Motion = "Pull", WaveTime = 0.18, Pull = 150, ClosePull = 150, MaxSpeed = 95, Damping = 1.5,
		Swirl = 9, Tumble = 16, SpinScale = 1, ConsumeRadius = 1.5, MaxTime = 0.9,
		Shrink = "Progress", OffsetDecay = 0.96, KillScale = 0.15, FadeStart = 0.45,
	},
	-- Not used by a move right now: the orbit from the old Ability4 client module (circles first)
	Orbit = {
		Motion = "Pull", WaveTime = 0.5, Pull = 35, ClosePull = 90, MaxSpeed = 120, Damping = 0.6,
		Swirl = 40, Tumble = 24, SpinScale = 1, ConsumeRadius = 1, MaxTime = 4,
		Shrink = "Progress", OffsetDecay = 0.96, KillScale = ABSORB_MIN_SCALE,
	},
	-- Liberation's ground hole: slide toward the middle and sink into the ground (sizes never change)
	Sink = {
		Motion = "Sink", WaveTime = 0.35, StartJitter = 0.2, SinkAccel = { 60, 120 }, SinkMax = { 60, 100 },
		InSpeed = { 10, 45 }, InDecay = 0.4, Tumble = 3, HopChance = 0.3, HopSpeed = { 8, 14 },
		FadeDelay = 1, FadeDepth = 4, MaxTime = 4,
	},
	-- Sables' tornado: pieces spiral up around the moving tornado, then get tossed out. Tossed pieces
	-- fly with real physics (they land on the map and rubble, never hit players), lie there ThrownLife
	-- seconds, then shrink and fade away. Everything still spinning is flung out together when the
	-- tornado dissipates (its named target is unregistered).
	Funnel = {
		Motion = "Funnel", WaveTime = 0.08, MaxTime = 4,
		RadiusMin = 4, RadiusMax = 12, -- orbit radius around the tornado's axis (studs)
		HeightMin = 3, HeightMax = 17, -- orbit height above the tornado's base (studs)
		OrbitSpeedMin = 6, OrbitSpeedMax = 10, -- radians/s around the axis (6.3 = one turn a second)
		PullIn = 5, -- how fast a piece reaches its orbit radius (higher = snappier)
		RiseRate = 2.5, -- how fast it climbs to its orbit height (higher = faster)
		Tumble = 10, SpinScale = 1, -- how fast each piece turns over
		LifeMin = 0.6, LifeMax = 1.4, -- seconds spinning before it's tossed out
		TossOut = 30, TossUp = 25, -- toss speed outward / upward (studs/s)
		TossSwirl = 0.5, -- how much of its orbit speed a tossed piece keeps sideways
		ReleaseOut = 45, ReleaseUp = 50, -- the fling when the tornado dissipates
		ThrowSpin = 12, -- random tumble when tossed (radians/s, +/-)
		ThrownLife = 3, -- seconds a tossed piece lies around before it starts to vanish
		ShrinkTime = 0.8, -- seconds it then takes to shrink and fade away
	},
	-- Zoro's Tatsumaki: a much bigger Funnel around Zoro. Pieces spiral up a tall cone and keep
	-- spinning until the final slash unregisters the target, which bursts them all outward. A few
	-- get flung out early (LifeMin/LifeMax) so the column doesn't look static.
	Tatsumaki = {
		Motion = "Funnel", WaveTime = 0.3, MaxTime = 6,
		RadiusMin = 8, RadiusMax = 26,
		HeightMin = 6, HeightMax = 85,
		OrbitSpeedMin = 4, OrbitSpeedMax = 7.5,
		PullIn = 2.5,
		RiseRate = 0.9,
		Tumble = 14, SpinScale = 1,
		LifeMin = 2.2, LifeMax = 5,
		TossOut = 55, TossUp = 30,
		TossSwirl = 0.5,
		ReleaseOut = 90, ReleaseUp = 45,
		ThrowSpin = 14,
		ThrownLife = 2.5,
		ShrinkTime = 0.7,
	},
	-- WhiteBeard's Tsunami: pieces torn off by the wave front ride along with it (thrown forward
	-- and up along the wave's direction, tumbling), then drop and sink out of sight in the water.
	-- The direction is the Target attachment's look direction (the server points it along the wave).
	Wave = {
		Motion = "Carry", WaveTime = 0.1, StartJitter = 0.15, MaxTime = 2.4,
		Speed = { 70, 115 }, -- studs/s along the wave (the wave itself moves at 120)
		Up = { 18, 42 }, -- upward start speed (studs/s)
		Side = 12, -- sideways start speed, +/- (studs/s)
		Gravity = 55, -- studs/s^2 while riding
		Tumble = 10, SpinScale = 1, -- how fast each piece turns over
		CarryTime = { 0.5, 1.1 }, -- seconds riding before it sinks
		Drag = 1.2, -- how fast it loses forward speed once dropped
		SinkSpeed = 35, -- studs/s down once dropped
		FadeTime = 0.45, -- seconds to fade out once dropped
	},
}

type Flyer = {
	Part: BasePart,
	Pooled: boolean, -- pool part (goes back to the pool) or a prop copy (destroyed)
	CanCollide: boolean,
	CanQuery: boolean,
	CollisionGroup: string,
	Transform: CFrame,
	Velocity: Vector3,
	Started: boolean,
	StartAt: number,
	StartDistance: number,
	Offset: Vector3,
	SpinAxis: Vector3,
	SpinRate: number,
	BaseSize: Vector3,
	BaseTransparency: number,
	LastScale: number,
	Shrink: number,
	
	-- Sink only
	SinkV: number,
	SinkAccel: number,
	SinkMax: number,
	InSpeed: number,
	GroundY: number,
	FadeDepth: number,
	FadeArmed: boolean,
	LastFade: number,
	
	-- Funnel only
	Angle: number,
	Radius: number,
	Height: number,
	GoalRadius: number,
	GoalHeight: number,
	OrbitSpeed: number,
	TossAt: number,
	Tossed: boolean,
	TossStart: number,
}

local ActiveFlyers = 0

-- Targets a client drives itself, by name (the server's Absorb TargetId). Sables registers its
-- local tornado anchor here, because the server can't send that part (it only exists here).
-- Weak values: a destroyed, never-unregistered part doesn't linger.
local NamedTargets: { [string]: BasePart } = setmetatable({}, { __mode = "v" }) :: any

-- Register (or with nil, unregister) a named target. Unregistering releases its Funnel pieces.
function DebreeController.SetTarget(Id: string, Part: BasePart?)
	NamedTargets[Id] = Part :: any
end

local function PointOf(Target: Instance?): Vector3?
	if Target and Target.Parent then
		if Target:IsA("Attachment") then
			return Target.WorldPosition
		elseif Target:IsA("BasePart") then
			return Target.Position
		end
	end
	return nil
end

-- Takes a piece this client is drawing away from Debree. The server has already forgotten it,
-- so later Physics or Prop for its ID are ignored. nil if this client wasn't drawing it.
local function Detach(Id: number): BasePart?
	local Entry = Voxels[Id]
	if not Entry then
		return nil
	end
	Voxels[Id] = nil
	if Entry.Tween then
		Entry.Tween:Cancel()
	end
	return Entry.Part
end

local function NewFlyer(Part: BasePart, Pooled: boolean, Transform: CFrame): Flyer
	local Flyer: Flyer = {
		Part = Part,
		Pooled = Pooled,
		CanCollide = Part.CanCollide,
		CanQuery = Part.CanQuery,
		CollisionGroup = Part.CollisionGroup,
		Transform = Transform,
		Velocity = Vector3.zero,
		Started = false,
		StartAt = 0,
		StartDistance = 1,
		Offset = Vector3.new(math.random(-15, 15), math.random(-10, 10), math.random(-15, 15)) / 10,
		SpinAxis = Vector3.yAxis,
		SpinRate = 0,
		BaseSize = Part.Size,
		BaseTransparency = Part.Transparency,
		LastScale = 1,
		Shrink = 1,
		SinkV = 0,
		SinkAccel = 0,
		SinkMax = 0,
		InSpeed = 0,
		GroundY = Transform.Position.Y,
		FadeDepth = 1,
		FadeArmed = false,
		LastFade = 0,
		Angle = 0,
		Radius = 0,
		Height = 0,
		GoalRadius = 0,
		GoalHeight = 0,
		OrbitSpeed = 0,
		TossAt = 0,
		Tossed = false,
		TossStart = 0,
	}
	Part.CanCollide = false -- nobody trips over a piece being absorbed
	Part.CanQuery = false
	ActiveFlyers += 1
	return Flyer
end

local function EndFlyer(Flyer: Flyer)
	ActiveFlyers -= 1
	if Flyer.Pooled then
		-- the pool reuses it as solid rubble later (Dress resets Size/Transparency, not these)
		Flyer.Part.CanCollide = Flyer.CanCollide
		Flyer.Part.CanQuery = Flyer.CanQuery
		Flyer.Part.CollisionGroup = Flyer.CollisionGroup
		ReturnPart(Flyer.Part) -- re-anchors it and clears its velocity
	else
		Flyer.Part:Destroy()
	end
end

-- A visible copy of a hidden special-prop part (SpecialDestruction saved its look in __OrigTrans).
local function CopyProp(Source: BasePart): BasePart
	local Copy = Source:Clone()
	local Saved = Copy:GetAttribute("__OrigTrans")
	Copy.Transparency = if typeof(Saved) == "number" then Saved else 0
	Copy:RemoveTag("WindShake")
	for _, Descendant in Copy:GetDescendants() do
		if Descendant:IsA("JointInstance") or Descendant:IsA("WeldConstraint") or Descendant:IsA("Constraint") then
			Descendant:Destroy() -- a weld to the hidden original would drag it along
		elseif Descendant:IsA("Texture") or Descendant:IsA("Decal") then
			local Orig = Descendant:GetAttribute("__OrigTrans")
			if typeof(Orig) == "number" then
				Descendant.Transparency = Orig
			end
		else
			Descendant:RemoveTag("WindShake")
		end
	end
	Copy.Anchored = true
	Copy.CanTouch = false
	Copy.CastShadow = false
	Copy.Parent = DustFolder
	return Copy
end

local function RandomIn(Range: { number }): number
	return Range[1] + (Range[2] - Range[1]) * math.random()
end

-- One frame of a "Pull" piece. true = it's done (eaten or faded out).
local function StepPull(Flyer: Flyer, Point: Vector3, Now: number, DeltaTime: number, Style: AbsorbStyle): boolean
	local Position = Flyer.Transform.Position
	if not Flyer.Started then
		Flyer.Started = true
		local Inward = Point - Position
		local Normal = if Inward.Magnitude > 1e-3 then Inward.Unit else Vector3.yAxis
		local Tangent = Normal:Cross(Vector3.yAxis)
		Tangent = if Tangent.Magnitude > 1e-3 then Tangent.Unit else Normal:Cross(Vector3.xAxis).Unit
		Flyer.Velocity = Tangent * Style.Swirl
	end

	local ToPoint = (Point + Flyer.Offset) - Position
	local Distance = ToPoint.Magnitude
	local Age = Now - Flyer.StartAt
	local Scale, Fade
	if Style.Shrink == "Progress" then
		-- smaller as it nears the target OR as its time runs out, never grows back
		local ByDistance = math.clamp(Distance / Flyer.StartDistance, 0, 1)
		local ByTime = math.clamp(1 - Age / (Style.MaxTime * 0.9), 0, 1)
		Scale = math.min(Flyer.Shrink, ByDistance, ByTime)
		Flyer.Shrink = Scale
		Flyer.Offset *= Style.OffsetDecay
		Fade = if Style.FadeStart
			then math.clamp((Style.FadeStart - Scale) / (Style.FadeStart - Style.KillScale), 0, 1)
			else 1 - Scale
	else
		Scale = 1
		if Distance < Style.ShrinkRadius then
			Scale = math.max(Distance / Style.ShrinkRadius, Style.MinShrink)
			Flyer.Offset *= 0.9 -- let it actually reach the middle
		end
		if Style.DissolveDelay and Age > Style.DissolveDelay then
			Scale = math.min(Scale, math.clamp(1 - (Age - Style.DissolveDelay) / Style.DissolveTime, 0, 1))
		end
		Fade = 1 - Scale
	end

	if Distance < Style.ConsumeRadius or Scale <= (Style.KillScale or ABSORB_MIN_SCALE) then
		return true
	end
	-- Size/Transparency writes are the expensive part: only when the scale moved enough
	if math.abs(Flyer.LastScale - Scale) > 0.07 then
		Flyer.LastScale = Scale
		Flyer.Part.Size = Flyer.BaseSize * math.max(Scale, ABSORB_MIN_SCALE)
		Flyer.Part.Transparency = Flyer.BaseTransparency + (1 - Flyer.BaseTransparency) * Fade
	end

	local Pull = if Distance > 1e-3
		then ToPoint / Distance * (Style.Pull + Style.ClosePull / math.max(Distance, 1))
		else Vector3.zero
	local Velocity = (Flyer.Velocity + Pull * DeltaTime) * math.max(0, 1 - Style.Damping * DeltaTime)
	if Velocity.Magnitude > Style.MaxSpeed then
		Velocity = Velocity.Unit * Style.MaxSpeed
	end
	Flyer.Velocity = Velocity
	Flyer.Transform = (Flyer.Transform + Velocity * DeltaTime) * CFrame.fromAxisAngle(Flyer.SpinAxis, Flyer.SpinRate * DeltaTime)
	return false
end

-- One frame of a "Sink" piece (Liberation's ground hole). true = it's done (fully under).
local function StepSink(Flyer: Flyer, Point: Vector3, Now: number, DeltaTime: number, Style: AbsorbStyle): boolean
	if Now > Flyer.StartAt + Style.MaxTime then
		return true
	end
	local Position = Flyer.Transform.Position
	-- accelerating sink (starts negative for pieces that hop up first)
	Flyer.SinkV = math.min(Flyer.SinkV + Flyer.SinkAccel * DeltaTime, Flyer.SinkMax)
	-- slide toward the hole's column, dying off over time
	local Inward = Vector3.zero
	if Flyer.InSpeed > 0.5 then
		local ToColumn = Vector3.new(Point.X - Position.X, 0, Point.Z - Position.Z)
		local Distance = ToColumn.Magnitude
		if Distance > 1 then
			-- capped so fast pieces land on the column instead of jittering across it
			Inward = ToColumn.Unit * math.min(Flyer.InSpeed, Distance / DeltaTime)
		end
		Flyer.InSpeed *= math.max(0, 1 - Style.InDecay * DeltaTime)
	end
	Flyer.Transform = (Flyer.Transform + (Inward + Vector3.new(0, -Flyer.SinkV, 0)) * DeltaTime)
		* CFrame.fromAxisAngle(Flyer.SpinAxis, Flyer.SpinRate * DeltaTime)

	-- fades with depth below where it started sinking; gone once fully under
	if not Flyer.FadeArmed then
		if Now - Flyer.StartAt >= Style.FadeDelay then
			Flyer.FadeArmed = true
			Flyer.GroundY = math.min(Flyer.GroundY, Flyer.Transform.Position.Y)
		end
	else
		local Fade = math.clamp((Flyer.GroundY - Flyer.Transform.Position.Y) / Flyer.FadeDepth, 0, 1)
		if Fade >= 1 then
			return true
		end
		if math.abs(Flyer.LastFade - Fade) > 0.07 then
			Flyer.LastFade = Fade
			Flyer.Part.Transparency = Flyer.BaseTransparency + (1 - Flyer.BaseTransparency) * Fade
		end
	end
	return false
end

-- One frame of a "Carry" piece (WhiteBeard's Tsunami). true = it's done (sunk and faded).
-- TossAt is when the wave drops it; TossStart is when it started sinking.
local function StepCarry(Flyer: Flyer, Now: number, DeltaTime: number, Style: AbsorbStyle): boolean
	if Now > Flyer.StartAt + Style.MaxTime then
		return true
	end
	local Velocity = Flyer.Velocity
	if Now < Flyer.TossAt then
		-- riding the wave: keeps its forward speed, arcs up and over
		Velocity = Vector3.new(Velocity.X, Velocity.Y - Style.Gravity * DeltaTime, Velocity.Z)
	else
		if not Flyer.FadeArmed then
			Flyer.FadeArmed = true
			Flyer.TossStart = Now
		end
		-- dropped: slows down and sinks under the water, fading out
		local Keep = math.max(0, 1 - Style.Drag * DeltaTime)
		Velocity = Vector3.new(Velocity.X * Keep, -Style.SinkSpeed, Velocity.Z * Keep)
		local Fade = math.clamp((Now - Flyer.TossStart) / Style.FadeTime, 0, 1)
		if Fade >= 1 then
			return true
		end
		if math.abs(Flyer.LastFade - Fade) > 0.07 then
			Flyer.LastFade = Fade
			Flyer.Part.Transparency = Flyer.BaseTransparency + (1 - Flyer.BaseTransparency) * Fade
		end
	end
	Flyer.Velocity = Velocity
	Flyer.Transform = (Flyer.Transform + Velocity * DeltaTime) * CFrame.fromAxisAngle(Flyer.SpinAxis, Flyer.SpinRate * DeltaTime)
	return false
end

-- Hands a tossed piece to this client's physics: it flies, lands on the map and rubble (its
-- collision group never hits players), lies there ThrownLife seconds, then shrinks and fades away.
local function Throw(Flyer: Flyer, Velocity: Vector3, Style: AbsorbStyle)
	local Part = Flyer.Part
	Part.CanCollide = true
	Part.CollisionGroup = Config.DustCollisionGroup
	Part.Anchored = false
	Part.AssemblyLinearVelocity = Velocity
	local Spin = Style.ThrowSpin
	Part.AssemblyAngularVelocity = Vector3.new(RandomIn({ -Spin, Spin }), RandomIn({ -Spin, Spin }), RandomIn({ -Spin, Spin }))
	task.delay(Style.ThrownLife, function()
		if not Part.Parent then
			EndFlyer(Flyer)
			return
		end
		local Tween = TweenService:Create(Part, TweenInfo.new(Style.ShrinkTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = Flyer.BaseSize * 0.05,
			Transparency = 1,
		})
		Tween:Play()
		task.delay(Style.ShrinkTime, function()
			Tween:Destroy()
			EndFlyer(Flyer)
		end)
	end)
end

-- One frame of a "Funnel" piece (Sables' tornado). false = still spinning; "Thrown" = tossed and
-- handed to physics (Throw looks after it from here).
local function StepFunnel(Flyer: Flyer, Point: Vector3, Now: number, DeltaTime: number, Style: AbsorbStyle, Released: boolean): any
	if not Flyer.Tossed then
		local Position = Flyer.Transform.Position
		if not Flyer.Started then
			-- start the orbit from wherever the piece is, so there's no jump
			Flyer.Started = true
			local Offset = Position - Point
			Flyer.Angle = math.atan2(Offset.Z, Offset.X)
			Flyer.Radius = Vector3.new(Offset.X, 0, Offset.Z).Magnitude
			Flyer.Height = Offset.Y
		end
		if Released or Now >= Flyer.TossAt then
			local Outward = Vector3.new(math.cos(Flyer.Angle), 0, math.sin(Flyer.Angle))
			local Tangent = Vector3.new(-math.sin(Flyer.Angle), 0, math.cos(Flyer.Angle))
			local Out = if Released then Style.ReleaseOut else Style.TossOut
			local Up = if Released then Style.ReleaseUp else Style.TossUp
			Flyer.Velocity = Tangent * (Flyer.OrbitSpeed * Flyer.Radius * Style.TossSwirl)
				+ Outward * Out * (0.7 + 0.6 * math.random())
				+ Vector3.yAxis * Up * (0.7 + 0.6 * math.random())
			Flyer.Tossed = true
			Flyer.TossStart = Now
			Throw(Flyer, Flyer.Velocity, Style)
			return "Thrown"
		else
			Flyer.Radius += (Flyer.GoalRadius - Flyer.Radius) * (1 - math.exp(-Style.PullIn * DeltaTime))
			Flyer.Height += (Flyer.GoalHeight - Flyer.Height) * (1 - math.exp(-Style.RiseRate * DeltaTime))
			Flyer.Angle += Flyer.OrbitSpeed * DeltaTime
			local NewPosition = Point + Vector3.new(math.cos(Flyer.Angle) * Flyer.Radius, Flyer.Height, math.sin(Flyer.Angle) * Flyer.Radius)
			Flyer.Transform = CFrame.new(NewPosition) * Flyer.Transform.Rotation * CFrame.fromAxisAngle(Flyer.SpinAxis, Flyer.SpinRate * DeltaTime)
			return false
		end
	end
	return "Thrown"
end

local function Animate(Flyers: { Flyer }, Target: Instance?, Center: Vector3, Style: AbsorbStyle, Released: (() -> boolean)?)
	local Sink = Style.Motion == "Sink"
	local Funnel = Style.Motion == "Funnel"
	local Carry = Style.Motion == "Carry"
	local Origin = PointOf(Target) or Center
	-- Carry: the wave's direction, from the Target attachment's look direction
	local CarryDir: Vector3? = nil
	if Carry and Target and Target:IsA("Attachment") and Target.Parent then
		local Look = (Target :: Attachment).WorldCFrame.LookVector
		local Flat = Vector3.new(Look.X, 0, Look.Z)
		if Flat.Magnitude > 1e-3 then
			CarryDir = Flat.Unit
		end
	end
	local Farthest = 1
	for _, Flyer in Flyers do
		Farthest = math.max(Farthest, (Flyer.Transform.Position - Origin).Magnitude)
	end
	local T0 = os.clock()
	for _, Flyer in Flyers do
		local Distance = (Flyer.Transform.Position - Origin).Magnitude
		Flyer.StartDistance = math.max(Distance, 1)
		Flyer.StartAt = T0 + Distance / Farthest * Style.WaveTime + math.random() * (Style.StartJitter or 0)
		if Funnel then
			Flyer.GoalRadius = RandomIn({ Style.RadiusMin, Style.RadiusMax })
			Flyer.GoalHeight = RandomIn({ Style.HeightMin, Style.HeightMax })
			Flyer.OrbitSpeed = RandomIn({ Style.OrbitSpeedMin, Style.OrbitSpeedMax })
			Flyer.TossAt = Flyer.StartAt + RandomIn({ Style.LifeMin, Style.LifeMax })
			local T = Style.Tumble
			local Spin = Vector3.new((math.random() * 2 - 1) * T, (math.random() * 2 - 1) * T, (math.random() * 2 - 1) * T)
			Flyer.SpinAxis = if Spin.Magnitude > 1e-3 then Spin.Unit else Vector3.yAxis
			Flyer.SpinRate = Spin.Magnitude * Style.SpinScale
		elseif Sink then
			Flyer.SinkV = if math.random() < Style.HopChance then -RandomIn(Style.HopSpeed) else 0
			Flyer.SinkAccel = RandomIn(Style.SinkAccel)
			Flyer.SinkMax = RandomIn(Style.SinkMax)
			Flyer.InSpeed = RandomIn(Style.InSpeed)
			Flyer.FadeDepth = Flyer.BaseSize.Y * 0.5 + Style.FadeDepth
			local Axis = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
			Flyer.SpinAxis = if Axis.Magnitude > 1e-3 then Axis.Unit else Vector3.yAxis
			Flyer.SpinRate = (0.3 + math.random() * 0.7) * Style.Tumble
		elseif Carry then
			-- without the attachment (not replicated yet), carry it away from the middle of the hit
			local Away = Flyer.Transform.Position - Origin
			Away = Vector3.new(Away.X, 0, Away.Z)
			local Dir = CarryDir or (if Away.Magnitude > 1e-3 then Away.Unit else Vector3.xAxis)
			local SideDir = Dir:Cross(Vector3.yAxis)
			Flyer.Velocity = Dir * RandomIn(Style.Speed)
				+ Vector3.yAxis * RandomIn(Style.Up)
				+ SideDir * RandomIn({ -Style.Side, Style.Side })
			Flyer.TossAt = Flyer.StartAt + RandomIn(Style.CarryTime)
			local Axis = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
			Flyer.SpinAxis = if Axis.Magnitude > 1e-3 then Axis.Unit else Vector3.yAxis
			Flyer.SpinRate = (0.4 + math.random() * 0.6) * Style.Tumble * Style.SpinScale
		else
			local T = Style.Tumble
			local Spin = Vector3.new((math.random() * 2 - 1) * T, (math.random() * 2 - 1) * T, (math.random() * 2 - 1) * T)
			if Spin.Magnitude < 1e-3 then
				Spin = Vector3.yAxis * T
			end
			Flyer.SpinAxis = Spin.Unit
			Flyer.SpinRate = Spin.Magnitude * Style.SpinScale
		end
	end
	local EndAfter = Style.WaveTime + (Style.StartJitter or 0) + Style.MaxTime

	local MoveParts: { BasePart } = {}
	local MoveCFrames: { CFrame } = {}
	local Connection: RBXScriptConnection
	Connection = RunService.Heartbeat:Connect(function(DeltaTime: number)
		local Now = os.clock()
		if Now - T0 > EndAfter then
			for _, Flyer in Flyers do
				EndFlyer(Flyer)
			end
			table.clear(Flyers)
		end
		if #Flyers == 0 then
			Connection:Disconnect()
			return
		end

		local Point = PointOf(Target) or Center
		local IsReleased = Released ~= nil and Released()
		table.clear(MoveParts)
		table.clear(MoveCFrames)
		for Index = #Flyers, 1, -1 do
			local Flyer = Flyers[Index]
			if Now < Flyer.StartAt then
				continue
			end
			local Done = if Funnel
				then StepFunnel(Flyer, Point, Now, DeltaTime, Style, IsReleased)
				elseif Carry then StepCarry(Flyer, Now, DeltaTime, Style)
				elseif Sink then StepSink(Flyer, Point, Now, DeltaTime, Style)
				else StepPull(Flyer, Point, Now, DeltaTime, Style)
			if Done == "Thrown" then
				-- physics has it now; Throw ends it later
				Flyers[Index] = Flyers[#Flyers]
				Flyers[#Flyers] = nil
				continue
			elseif Done then
				EndFlyer(Flyer)
				Flyers[Index] = Flyers[#Flyers]
				Flyers[#Flyers] = nil
				continue
			end
			table.insert(MoveParts, Flyer.Part)
			table.insert(MoveCFrames, Flyer.Transform)
		end
		if #MoveParts > 0 then
			workspace:BulkMoveTo(MoveParts, MoveCFrames, Enum.BulkMoveMode.FireCFrameChanged)
		end
	end)
end

local function OnAbsorb(Payload: any)
	if typeof(Payload) ~= "table" then
		return
	end
	-- 1. Take over the handed-over pieces first, before anything below could reuse their IDs
	local Handed: { BasePart } = {}
	if typeof(Payload.Taken) == "buffer" then
		for _, Id in Records.ReadIds(Payload.Taken) do
			local Part = Detach(Id)
			if Part then
				table.insert(Handed, Part)
			end
		end
	end
	-- 2. The hole (both ignore nil)
	OnProp(Payload.Removed)
	OnCreate(Payload.Create)

	local Style = ABSORB_STYLES[if typeof(Payload.Style) == "string" then Payload.Style else "Default"]
		or ABSORB_STYLES.Default
	local Center: Vector3 = if typeof(Payload.Center) == "Vector3" then Payload.Center else Vector3.zero
	local Target: Instance? = nil
	local Released: (() -> boolean)? = nil
	if typeof(Payload.Target) == "Instance" and Payload.Target:IsA("Attachment") then
		Target = Payload.Target
	end
	-- A named target (a part this client drives, like Sables' tornado anchor) wins. Funnel pieces
	-- are released when it's unregistered (the tornado dissipating).
	if typeof(Payload.TargetId) == "string" then
		local Named = NamedTargets[Payload.TargetId]
		if Named and Named.Parent then
			Target = Named
			local Id = Payload.TargetId
			Released = function()
				return NamedTargets[Id] ~= Named
			end
		end
	end

	-- Too far to see, or too many already moving: handed pieces just go, nothing new spawns
	local Visible = Manhattan(CameraPosition(), Center) <= ABSORB_DRAW_DISTANCE
	local Flyers: { Flyer } = {}
	for _, Part in Handed do
		if Visible and ActiveFlyers < ABSORB_MAX_ACTIVE then
			table.insert(Flyers, NewFlyer(Part, true, Part.CFrame))
		else
			ReturnPart(Part)
		end
	end
	if not Visible then
		return
	end

	-- 3. Cells cut out of intact parts, from the pool, dressed like Create does
	if typeof(Payload.Boxes) == "table" then
		local Parts: { BasePart } = {}
		local CFrames: { CFrame } = {}
		for TransparencyKey, ByMaterial in Payload.Boxes do
			local Transparency = tonumber(TransparencyKey) or 0
			for MaterialKey, ByColor in ByMaterial do
				local Material, Variant = Materials.FromKey(tostring(MaterialKey))
				for ColorKey, Buffers in ByColor do
					local Buffer = Buffers[1]
					if typeof(Buffer) ~= "buffer" then
						continue
					end
					local Color = ParseColor(tostring(ColorKey))
					for Index = 1, Records.Count(Buffer, Records.PIECE_SIZE) do
						if ActiveFlyers >= ABSORB_MAX_ACTIVE then
							break
						end
						local Transform, Size = Records.ReadPiece(Buffer, Index)
						local Part = GetPart()
						Dress(Part, Size, Color, Material, Variant, Transparency)
						Part.Anchored = true
						Part.Locked = true
						Part.CastShadow = false
						table.insert(Parts, Part)
						table.insert(CFrames, Transform)
						table.insert(Flyers, NewFlyer(Part, true, Transform))
					end
				end
			end
		end
		if #Parts > 0 then
			workspace:BulkMoveTo(Parts, CFrames, Enum.BulkMoveMode.FireCFrameChanged)
		end
	end

	-- 4. Special props: copies of the hidden originals. A part that isn't streamed in on this
	--    client never arrives (the server sends them keyed, so it's simply missing) and is skipped.
	if typeof(Payload.Parts) == "table" then
		for _, Source in Payload.Parts do
			if ActiveFlyers >= ABSORB_MAX_ACTIVE then
				break
			end
			if typeof(Source) == "Instance" and Source:IsA("BasePart") then
				local Copy = CopyProp(Source)
				table.insert(Flyers, NewFlyer(Copy, false, Copy.CFrame))
			end
		end
	end

	if #Flyers > 0 then
		Animate(Flyers, Target, Center, Style, Released)
	end
end

------------------------------------------------------------------------
-- Test hook: lets a self-test feed payloads straight to the handlers without remotes.
-- Not used by the game.
------------------------------------------------------------------------

DebreeController._Test = {
	Create = OnCreate,
	Physics = OnPhysics,
	Prop = OnProp,
	Sound = OnSound,
	UsePool = function(NewTemplate: BasePart, NewFolder: Instance)
		Template, PoolFolder = NewTemplate, NewFolder
	end,
	OpenCount = function(): number
		return #Open
	end,
}

------------------------------------------------------------------------
-- Start
------------------------------------------------------------------------

-- Builds the pool, connects the remotes, then tells the server this client is ready
-- (the server answers with everything that is currently broken). Safe to call twice.
function DebreeController.Start()
	if Started then
		return
	end
	assert(RunService:IsClient(), "DebreeController runs on the client only")
	Started = true

	local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Debree")
	Template = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Debree"):WaitForChild("DebreeRef") :: BasePart
	local World = workspace:WaitForChild("World")
	PoolFolder = World:WaitForChild("Voxel")
	DustFolder = World:WaitForChild("Debris")

	DustParams = RaycastParams.new()
	DustParams.FilterType = Enum.RaycastFilterType.Include
	DustParams.FilterDescendantsInstances = { World:WaitForChild("Map"), PoolFolder }

	local Group = SoundService:FindFirstChild("Sounds")
	SoundGroup = if Group and Group:IsA("SoundGroup") then Group else nil

	-- One list per Enviroment subfolder; folders no material maps to (e.g. Long) are never played
	local SoundFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Sounds"):WaitForChild("Impact"):WaitForChild("Enviroment")
	for _, Folder in SoundFolder:GetChildren() do
		local List: { Sound } = {}
		for _, Sound in Folder:GetDescendants() do
			if Sound:IsA("Sound") then
				table.insert(List, Sound)
			end
		end
		SoundsByFolder[Folder.Name] = List
	end
	if not SoundsByFolder[FALLBACK_FOLDER] or #SoundsByFolder[FALLBACK_FOLDER] == 0 then
		warn(`[DebreeController] {FALLBACK_FOLDER} has no sounds; unmapped materials will be silent`)
	end

	-- The whole pool up front, like JJS, so breaking never has to create parts
	for _ = 1, Config.PoolSize do
		table.insert(Open, MakePart())
	end

	-- Listeners first, then Ready: the server's snapshot must find them connected
	local CreateRemote = Remotes:WaitForChild("Create") :: RemoteEvent
	local PropRemote = Remotes:WaitForChild("Prop") :: RemoteEvent
	local PhysicsRemote = Remotes:WaitForChild("Physics") :: UnreliableRemoteEvent
	local SoundRemote = Remotes:WaitForChild("Sound") :: UnreliableRemoteEvent
	local SettleRemote = Remotes:WaitForChild("Settle", 5) :: RemoteEvent?
	local ReadyRemote = Remotes:WaitForChild("Ready") :: RemoteEvent
	CreateRemote.OnClientEvent:Connect(OnCreate)
	PropRemote.OnClientEvent:Connect(OnProp)
	PhysicsRemote.OnClientEvent:Connect(OnPhysics)
	if SettleRemote then
		SettleRemote.OnClientEvent:Connect(OnPhysics) -- same records, just reliable
	end
	SoundRemote.OnClientEvent:Connect(OnSound)
	local AbsorbRemote = Remotes:WaitForChild("Absorb", 10) :: RemoteEvent?
	if AbsorbRemote then
		AbsorbRemote.OnClientEvent:Connect(OnAbsorb)
	else
		warn("[DebreeController] Remotes.Debree.Absorb is missing; absorbs won't animate")
	end

	require(Shared:WaitForChild("BuildingDebrisController")).Start()
	task.spawn(MarkLoop)
	ReadyRemote:FireServer()
end

return DebreeController

