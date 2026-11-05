--!strict
-- OcclusionDetector.luau
-- Decides whether the player is under a real roof by firing a Blockcast straight
-- up from the character. Runs on a slow 0.5s loop that exists ONLY while active,
-- and ignores small parts (wires, props) so they can't be mistaken for cover.

local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.Config)
local Types = require(script.Parent.Types)
local Maid = require(script.Parent.Maid)

local OcclusionDetector = {}
OcclusionDetector.__index = OcclusionDetector

export type OcclusionDetector = typeof(setmetatable(
	{} :: {
		_maid: Maid.Maid,
		_running: boolean,
		_state: Types.RainState,
		_character: Model?,
		_onChanged: Types.StateChangedHandler?,
	},
	OcclusionDetector
	))

function OcclusionDetector.new(): OcclusionDetector
	local self = setmetatable({}, OcclusionDetector) :: OcclusionDetector
	self._maid = Maid.new()
	self._running = false
	self._state = "Exposed"
	self._character = nil
	self._onChanged = nil
	return self
end

function OcclusionDetector.setCharacter(self: OcclusionDetector, character: Model?)
	self._character = character
end

function OcclusionDetector.onStateChanged(self: OcclusionDetector, handler: Types.StateChangedHandler)
	self._onChanged = handler
end

function OcclusionDetector.getState(self: OcclusionDetector): Types.RainState
	return self._state
end

-- Size filtering (requirement 2): a hit only qualifies as a roof if it is large
-- enough to actually shelter the player. This rejects 1x1x1 detail, thin wires,
-- railings, etc. A roof can also be a thin-but-WIDE slab (low volume), so we
-- additionally accept anything whose two broadest dimensions are large.
local function isValidRoof(instance: Instance): boolean
	if not instance:IsA("BasePart") then
		return false
	end
	local s = instance.Size
	local volume = s.X * s.Y * s.Z
	if volume >= Config.Occlusion.MinVolume then
		return true
	end
	local dims = { s.X, s.Y, s.Z }
	table.sort(dims) -- ascending; dims[1] is the thinnest axis
	return dims[2] >= Config.Occlusion.MinWidth and dims[3] >= Config.Occlusion.MinWidth
end

function OcclusionDetector._castUp(self: OcclusionDetector): RaycastResult?
	local character = self._character
	if not character then
		return nil
	end
	local root = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not root then
		return nil
	end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { character }
	params.IgnoreWater = true
	params.RespectCanCollide = false -- a CanCollide-off roof still shelters you

	local probe = Config.Occlusion.ProbeSize
	local origin = root.Position + Vector3.new(0, Config.Occlusion.HeadOffset, 0)
	local remaining = Config.Occlusion.MaxDistance

	-- Cast up. If we hit something too small, exclude it and resume the cast just
	-- above it — so a wire directly beneath a real roof doesn't read as "exposed".
	for _ = 1, Config.Occlusion.MaxIterations do
		if remaining <= 0 then
			break
		end
		local result = Workspace:Blockcast(CFrame.new(origin), probe, Vector3.new(0, remaining, 0), params)
		if not result then
			return nil -- open sky within range
		end
		if isValidRoof(result.Instance) then
			return result -- a genuine roof
		end
		params:AddToFilter(result.Instance)
		remaining -= (result.Distance + 0.1)
		origin = result.Position + Vector3.new(0, 0.1, 0)
	end

	return nil
end

function OcclusionDetector._evaluate(self: OcclusionDetector)
	local hit = self:_castUp()
	local newState: Types.RainState = if hit then "Protected" else "Exposed"
	if newState ~= self._state then
		self._state = newState
		local handler = self._onChanged
		if handler then
			handler(newState, hit)
		end
	end
end

function OcclusionDetector.start(self: OcclusionDetector)
	if self._running then
		return
	end
	self._running = true

	-- Conditional, slow loop: it exists only while running and ticks every 0.5s.
	local thread = task.spawn(function()
		while self._running do
			self:_evaluate()
			task.wait(Config.Occlusion.Interval)
		end
	end)
	self._maid:give(thread)
end

function OcclusionDetector.stop(self: OcclusionDetector)
	self._running = false
	self._maid:clean()
	self._state = "Exposed"
end

return OcclusionDetector