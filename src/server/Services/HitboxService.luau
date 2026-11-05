--!strict
-- Server-validated spatial hitboxes (FRAMEWORK_PLAN.md Section 2).
-- Structure from the SorceryGame reference (one hitbox object, Box / Sphere shapes, sorting,
-- max targets, per-target hit once, optional velocity offset), with our target filters on top.
--
--   local hitbox = HitboxService.new({
--       Shape = "Sphere", Size = 12,                     -- Box: Size is a Vector3; Sphere: radius
--       CFrame = target,                                  -- or Adornee = rootPart, Offset = CFrame.new(0, 0, -4)
--       Caster = player,                                  -- Player or character
--       Filter = "HostileToRunners",
--   })
--   hitbox.Hit:Connect(function(character) CombatService.Afflict(player, character, {...}) end)
--   hitbox:Start(0.2)   -- check every frame for 0.2s (nil duration = one check)

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local TargetFilterMode = require(ReplicatedStorage.Shared.Enums.TargetFilterMode)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

export type Params = {
	Shape: ("Box" | "Sphere")?,
	Size: (Vector3 | number)?,
	CFrame: CFrame?, -- fixed position
	Adornee: BasePart?, -- follows this part (with Offset)
	Offset: CFrame?,
	Caster: (Player | Model)?,
	Filter: TargetFilterMode.TargetFilterMode?,
	MaxTargets: number?,
	Sorting: ("Nearest" | "Furthest" | "None")?,
	VelocityOffset: number?, -- push the box ahead along the adornee's velocity (divide factor, ~15)
	Visualize: boolean?,
}

local HitboxService = {}

local Hitbox = {}
Hitbox.__index = Hitbox

local active: { [any]: boolean } = {}
local debugFolder: Folder? = nil

local function showHitboxes(params: Params): boolean
	return params.Visualize == true or workspace:GetAttribute(CombatConfig.ShowHitboxesAttribute) == true
end

local function visualize(shape: string, cframe: CFrame, size: Vector3 | number)
	if not debugFolder or not debugFolder.Parent then
		local folder = Instance.new("Folder")
		folder.Name = "HitboxDebug"
		folder.Parent = workspace
		debugFolder = folder
	end
	local part = Instance.new("Part")
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Material = Enum.Material.ForceField
	part.Color = Color3.fromRGB(255, 60, 60)
	part.Transparency = 0.4
	if shape == "Sphere" then
		part.Shape = Enum.PartType.Ball
		part.Size = Vector3.one * (size :: number) * 2
	else
		part.Size = size :: Vector3
	end
	part.CFrame = cframe
	part.Parent = debugFolder
	Debris:AddItem(part, 0.12)
end

-- Is `character` a valid target for this filter?
local function passesFilter(filter: string, casterCharacter: Model?, character: Model): boolean
	if not Characters.IsAlive(character) then
		return false
	end
	if filter == TargetFilterMode.SelfOnly then
		return character == casterCharacter
	end
	if character == casterCharacter then
		return false
	end
	if filter == TargetFilterMode.All then
		return true
	end
	-- HostileToRunners and RunnersPvP both only ever hit Runners.
	return Characters.GetRole(character) == "Runner"
end

function HitboxService.new(params: Params)
	local self = setmetatable({}, Hitbox)
	self.Params = params
	self.Shape = params.Shape or "Box"
	self.Filter = params.Filter or TargetFilterMode.HostileToRunners
	self.CasterCharacter = Characters.Resolve(params.Caster)
	self.MaxTargets = params.MaxTargets or CombatConfig.DefaultMaxTargets
	self.HitTargets = {} :: { [Model]: boolean }
	self.HitCover = {} :: { [BasePart]: boolean }
	self.HitCount = 0
	self.Alive = true
	self.Hit = Signal.new() -- (character) once per character per Start()
	self.CoverHit = Signal.new() -- (part) DestructibleCover parts, only with the "All" filter
	self.Ended = Signal.new()
	self.EndThread = nil :: thread?
	self.Collect = nil :: ((Model) -> ())?

	local overlap = OverlapParams.new()
	overlap.FilterType = Enum.RaycastFilterType.Exclude
	local exclude = {}
	if debugFolder then
		table.insert(exclude, debugFolder)
	end
	overlap.FilterDescendantsInstances = exclude
	self.Overlap = overlap
	return self
end

function Hitbox.GetCFrame(self: any): CFrame
	local params: Params = self.Params
	local base = if params.Adornee then params.Adornee.CFrame else params.CFrame or CFrame.identity
	local cframe = base * (params.Offset or CFrame.identity)
	if params.VelocityOffset and params.Adornee then
		local velocity = params.Adornee.AssemblyLinearVelocity
		cframe = cframe + velocity / params.VelocityOffset
	end
	return cframe
end

-- One overlap check. Fires Hit for each new valid target.
function Hitbox.Detect(self: any)
	if not self.Alive then
		return
	end
	local params: Params = self.Params
	if params.Adornee and not params.Adornee.Parent then
		self:Stop()
		return
	end
	local cframe = self:GetCFrame()
	local parts: { BasePart }
	if self.Shape == "Sphere" then
		local radius = if type(params.Size) == "number" then params.Size else 6
		parts = workspace:GetPartBoundsInRadius(cframe.Position, radius, self.Overlap)
		if showHitboxes(params) then
			visualize("Sphere", cframe, radius)
		end
	else
		local size = if typeof(params.Size) == "Vector3" then params.Size else Vector3.one * 6
		parts = workspace:GetPartBoundsInBox(cframe, size, self.Overlap)
		if showHitboxes(params) then
			visualize("Box", cframe, size)
		end
	end

	local found: { Model } = {}
	local seen: { [Model]: boolean } = {}
	for _, part in parts do
		local character = Characters.FromPart(part)
		if character then
			if not seen[character] and not self.HitTargets[character] and passesFilter(self.Filter, self.CasterCharacter, character) then
				seen[character] = true
				table.insert(found, character)
			end
		elseif self.Filter == TargetFilterMode.All and not self.HitCover[part] then
			local cover = if CollectionService:HasTag(part, "DestructibleCover") then part else nil
			if cover then
				self.HitCover[cover] = true
				self.CoverHit:Fire(cover)
			end
		end
	end

	local sorting = params.Sorting or "Nearest"
	if sorting ~= "None" and #found > 1 then
		local origin = cframe.Position
		table.sort(found, function(a, b)
			local ra, rb = Characters.GetRoot(a), Characters.GetRoot(b)
			local da = if ra then (ra.Position - origin).Magnitude else math.huge
			local db = if rb then (rb.Position - origin).Magnitude else math.huge
			return if sorting == "Furthest" then da > db else da < db
		end)
	end

	for _, character in found do
		if self.HitCount >= self.MaxTargets then
			break
		end
		self.HitTargets[character] = true
		self.HitCount += 1
		if self.Collect then
			self.Collect(character)
		end
		self.Hit:Fire(character)
	end
end

-- Starts checking. duration = seconds to keep checking every frame; nil = a single check.
function Hitbox.Start(self: any, duration: number?)
	if not self.Alive then
		return
	end
	table.clear(self.HitTargets)
	table.clear(self.HitCover)
	self.HitCount = 0
	if duration == nil then
		self:Detect()
		self:Stop()
		return
	end
	active[self] = true
	self:Detect()
	self.EndThread = task.delay(duration, function()
		self.EndThread = nil
		self:Stop()
	end)
end

function Hitbox.Stop(self: any)
	if not self.Alive then
		return
	end
	active[self] = nil
	if self.EndThread and coroutine.status(self.EndThread) == "suspended" then
		task.cancel(self.EndThread)
	end
	self.EndThread = nil
	self.Alive = false
	self.Ended:Fire()
end

-- One-shot query: returns every valid target in the area, nearest first.
function HitboxService.Query(params: Params): { Model }
	local hitbox = HitboxService.new(params)
	local hits = {}
	-- Signal handlers run in new threads, so collect synchronously instead.
	hitbox.Collect = function(character: Model)
		table.insert(hits, character)
	end
	hitbox:Start()
	return hits
end

function HitboxService.Init() end

function HitboxService.Start()
	RunService.PostSimulation:Connect(function()
		for hitbox in active do
			hitbox:Detect()
		end
	end)
end

return HitboxService
