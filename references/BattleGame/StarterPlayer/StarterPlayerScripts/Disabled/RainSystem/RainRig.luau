--!strict
-- RainRig.luau
-- Sky-accurate local rain. Instead of one player-centred emitter (which rains
-- through roofs and vanishes indoors), it lays a GRID of rain cells around the
-- player. Each cell fires a ray straight up: roof above → that cell's rain is
-- off; open sky → on. So rain only falls in columns open to the sky.

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.Config)
local Maid = require(script.Parent.Maid)

local RainRig = {}
RainRig.__index = RainRig

type Cell = { host: BasePart, emitter: ParticleEmitter }

export type RainRig = typeof(setmetatable(
	{} :: {
		_maid: Maid.Maid,
		_character: Model?,
		_cells: { Cell },
		_floor: BasePart?,
		_floorEmitter: ParticleEmitter?,
		_rayParams: RaycastParams,
		_accum: number,
		_active: boolean,
		_running: boolean,
	},
	RainRig
	))

function RainRig.new(): RainRig
	local self = setmetatable({}, RainRig) :: RainRig
	self._maid = Maid.new()
	self._cells = {}
	self._accum = 0
	self._active = true
	self._running = false
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.IgnoreWater = true
	self._rayParams = params
	return self
end

function RainRig.setCharacter(self: RainRig, character: Model?)
	self._character = character
end

-- Global weather on/off (NOT player-occlusion — the grid self-gates per cell).
function RainRig.setActive(self: RainRig, active: boolean)
	self._active = active
	if not active then
		for _, cell in self._cells do
			cell.emitter.Enabled = false
		end
		if self._floorEmitter then
			self._floorEmitter.Enabled = false
		end
	end
end

function RainRig._update(self: RainRig)
	local character = self._character
	local hrp = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not (character and hrp and self._active) then
		for _, cell in self._cells do cell.emitter.Enabled = false end
		if self._floorEmitter then self._floorEmitter.Enabled = false end
		return
	end

	self._rayParams.FilterDescendantsInstances = { character }

	local cs = Config.Rig.CellSize
	local n = Config.Rig.GridRadius
	local scanTop = Config.Rig.ScanTop
	local down = Vector3.new(0, -(scanTop + Config.Rig.ScanBottom), 0)
	local layer = Config.Rig.LayerHeight
	local baseY = hrp.Position.Y
	local originX = math.round(hrp.Position.X / cs) * cs
	local originZ = math.round(hrp.Position.Z / cs) * cs

	local centerSurface: Vector3?, centerNormal: Vector3? = nil, nil
	local idx = 0
	for i = -n, n do
		for j = -n, n do
			idx += 1
			local cell = self._cells[idx]
			local x, z = originX + i * cs, originZ + j * cs
			-- First hit going down = the topmost surface open to the sky.
			local hit = Workspace:Raycast(Vector3.new(x, baseY + scanTop, z), down, self._rayParams)
			if hit then
				cell.emitter.Enabled = true
				cell.host.Position = Vector3.new(x, hit.Position.Y + layer, z)
				if i == 0 and j == 0 then
					centerSurface, centerNormal = hit.Position, hit.Normal
				end
			else
				cell.emitter.Enabled = false -- void below → nothing to rain on
			end
		end
	end

	-- Feet splash: only when the player is actually standing in the open
	-- (topmost surface is below them, not a roof overhead).
	local floor, floorE = self._floor, self._floorEmitter
	if floor and floorE then
		local exposed = centerSurface ~= nil and centerSurface.Y < hrp.Position.Y
		floorE.Enabled = exposed
		if exposed and centerSurface and centerNormal then
			local pos = centerSurface + centerNormal * 0.05
			if Config.Rig.OrientFloorToSurface then
				local upn = centerNormal
				local right = (if math.abs(upn.Y) < 0.99 then Vector3.yAxis else Vector3.xAxis):Cross(upn).Unit
				floor.CFrame = CFrame.fromMatrix(pos, right, upn)
			else
				floor.CFrame = CFrame.new(pos)
			end
		end
	end
end

function RainRig.start(self: RainRig)
	if self._running then
		return
	end

	local template = Config.Rig.TemplateParent:FindFirstChild(Config.Rig.TemplateName)
	if not template then
		warn(`[RainRig] '{Config.Rig.TemplateName}' not found in {Config.Rig.TemplateParent:GetFullName()}`)
		return
	end
	local rig = template:Clone()

	local sky = rig:FindFirstChild("Sky")
	local floor = rig:FindFirstChild("Floor")
	if not (sky and sky:IsA("BasePart") and floor and floor:IsA("BasePart")) then
		warn("[RainRig] Rig must contain BaseParts named 'Sky' and 'Floor'.")
		rig:Destroy()
		return
	end
	local emitterTemplate = sky:FindFirstChildOfClass("ParticleEmitter")
	if not emitterTemplate then
		warn("[RainRig] 'Sky' needs a ParticleEmitter to use as the rain template.")
		rig:Destroy()
		return
	end

	local folder = Instance.new("Folder")
	folder.Name = "RainRigRuntime"
	folder.Parent = Workspace
	self._maid:give(folder)

	-- Floor host
	floor.Anchored = true
	floor.CanCollide = false
	floor.CanQuery = false
	floor.CanTouch = false
	floor.Massless = true
	floor.Parent = folder
	self._floor = floor
	self._floorEmitter = floor:FindFirstChildOfClass("ParticleEmitter")

	-- Build the grid (order here must match the iteration order in _update).
	local n = Config.Rig.GridRadius
	for _ = -n, n do
		for _ = -n, n do
			local host = Instance.new("Part")
			host.Name = "RainCell"
			host.Size = Vector3.new(Config.Rig.CellSize, 1, Config.Rig.CellSize)
			host.Transparency = 1
			host.Anchored = true
			host.CanCollide = false
			host.CanQuery = false
			host.CanTouch = false
			host.Massless = true
			host.Parent = folder
			local emitter = emitterTemplate:Clone()
			emitter.Enabled = false
			emitter.Parent = host
			table.insert(self._cells, { host = host, emitter = emitter })
		end
	end

	rig:Destroy() -- only needed Sky as a template holder

	self._maid:give(RunService.Heartbeat:Connect(function(dt)
		self._accum += dt
		if self._accum >= Config.Rig.UpdateInterval then
			self._accum = 0
			self:_update()
		end
	end))

	self._running = true
end

function RainRig.stop(self: RainRig)
	self._running = false
	self._active = false
	self._maid:clean()
	table.clear(self._cells)
	self._floor = nil
	self._floorEmitter = nil
end

return RainRig