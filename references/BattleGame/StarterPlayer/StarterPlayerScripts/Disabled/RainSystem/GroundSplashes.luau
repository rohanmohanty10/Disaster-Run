--!strict
-- GroundSplashes.luau
-- Pooled, reusable splash bursts. Random downward rays around the camera find
-- the ground; each hit fires a quick bright droplet burst. Zero per-frame
-- allocation — the pool is built once and recycled round-robin.

local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.Config)
local Maid = require(script.Parent.Maid)

local GroundSplashes = {}
GroundSplashes.__index = GroundSplashes

type Splash = { part: BasePart, emitter: ParticleEmitter }

export type GroundSplashes = typeof(setmetatable(
	{} :: {
		_maid: Maid.Maid,
		_camera: Camera,
		_pool: { Splash },
		_next: number,
		_active: boolean,
		_character: Model?,
	},
	GroundSplashes
	))

function GroundSplashes.new(camera: Camera): GroundSplashes
	local self = setmetatable({}, GroundSplashes) :: GroundSplashes
	self._maid = Maid.new()
	self._camera = camera
	self._pool = {}
	self._next = 0
	self._active = false
	return self
end

-- Build a CFrame whose UP axis is the surface normal, so the burst shoots away
-- from sloped ground correctly (rotation about the normal is irrelevant here).
local function cframeFromNormal(position: Vector3, normal: Vector3): CFrame
	local up = if normal.Magnitude > 0 then normal.Unit else Vector3.yAxis
	local reference = if math.abs(up.Y) < 0.99 then Vector3.yAxis else Vector3.xAxis
	local right = reference:Cross(up).Unit
	local look = up:Cross(right).Unit
	return CFrame.fromMatrix(position, right, up, look)
end

local function makeSplashEmitter(parent: Attachment): ParticleEmitter
	local e = Instance.new("ParticleEmitter")
	e.Texture = Config.Splash.DropletTexture
	e.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	e.LightEmission = 1
	e.LightInfluence = 0
	e.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.1),
		NumberSequenceKeypoint.new(0.7, 0.3),
		NumberSequenceKeypoint.new(1, 1),
	})
	-- Tiny burst that pops outward then collapses — the bright "spark" look.
	e.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.1),
		NumberSequenceKeypoint.new(0.3, 0.4),
		NumberSequenceKeypoint.new(1, 0),
	})
	e.Speed = NumberRange.new(6, 14)
	e.SpreadAngle = Vector2.new(70, 70) -- fan outward, biased up
	e.Acceleration = Vector3.new(0, -60, 0) -- droplets arc back down
	e.Lifetime = NumberRange.new(0.18, 0.34)
	e.EmissionDirection = Enum.NormalId.Top
	e.Rate = 0 -- emitted in bursts via :Emit()
	e.LockedToPart = false
	e.Parent = parent
	return e
end

function GroundSplashes.setCharacter(self: GroundSplashes, character: Model?)
	self._character = character
end

function GroundSplashes.setActive(self: GroundSplashes, active: boolean)
	self._active = active
end

function GroundSplashes._spawn(self: GroundSplashes, position: Vector3, normal: Vector3)
	self._next += 1
	if self._next > #self._pool then
		self._next = 1
	end
	local splash = self._pool[self._next]
	splash.part.CFrame = cframeFromNormal(position + normal * 0.05, normal)
	splash.emitter:Emit(Config.Splash.DropletsPerSplash)
end

function GroundSplashes._tick(self: GroundSplashes)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = if self._character then { self._character } else {}
	params.IgnoreWater = true

	local camPos = self._camera.CFrame.Position
	local down = Vector3.new(0, -(Config.Splash.RayHeight + Config.Splash.RayDepth), 0)

	for _ = 1, Config.Splash.RaysPerTick do
		local angle = math.random() * math.pi * 2
		local dist = math.sqrt(math.random()) * Config.Splash.Radius -- uniform over the disc
		local origin = camPos + Vector3.new(math.cos(angle) * dist, Config.Splash.RayHeight, math.sin(angle) * dist)
		local result = Workspace:Raycast(origin, down, params)
		if result then
			self:_spawn(result.Position, result.Normal)
		end
	end
end

function GroundSplashes.start(self: GroundSplashes)
	local folder = Instance.new("Folder")
	folder.Name = "RainSplashes"
	folder.Parent = Workspace
	self._maid:give(folder)

	for i = 1, Config.Splash.PoolSize do
		local part = Instance.new("Part")
		part.Name = "Splash" .. i
		part.Size = Vector3.new(0.2, 0.2, 0.2)
		part.Transparency = 1
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false -- never let our downward rays hit a splash part
		part.CanTouch = false
		part.CastShadow = false
		part.Parent = folder

		local att = Instance.new("Attachment")
		att.Parent = part
		table.insert(self._pool, { part = part, emitter = makeSplashEmitter(att) })
	end

	local thread = task.spawn(function()
		while true do
			if self._active then
				self:_tick()
			end
			task.wait(Config.Splash.Interval)
		end
	end)
	self._maid:give(thread)
end

function GroundSplashes.stop(self: GroundSplashes)
	self._active = false
	self._maid:clean()
	table.clear(self._pool)
	self._next = 0
end

return GroundSplashes