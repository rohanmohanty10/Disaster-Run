--!strict
-- CharacterVFX.luau
-- Clones YOUR per-part VFX templates onto the character while exposed, then
-- destroys them on cover. A template can be a ParticleEmitter, an Attachment
-- (with any number of emitters), or a Part (welded to the limb).

local Config = require(script.Parent.Config)
local Types = require(script.Parent.Types)

local CharacterVFX = {}
CharacterVFX.__index = CharacterVFX

type Spawned = { root: Instance, emitters: { ParticleEmitter } }

export type CharacterVFX = typeof(setmetatable(
	{} :: {
		_character: Model?,
		_spawned: { Spawned },
		_gen: number,
		_state: Types.RainState,
	},
	CharacterVFX
	))

function CharacterVFX.new(): CharacterVFX
	local self = setmetatable({}, CharacterVFX) :: CharacterVFX
	self._spawned = {}
	self._gen = 0
	self._state = "Exposed"
	return self
end

-- Size-relative placement on the limb.
local function anchorOffset(part: BasePart, anchor: string?): Vector3
	if anchor == "Top" then
		return Vector3.new(0, part.Size.Y / 2, 0)
	elseif anchor == "Bottom" then
		return Vector3.new(0, -part.Size.Y / 2, 0)
	end
	return Vector3.zero
end

local function gatherEmitters(root: Instance): { ParticleEmitter }
	local list: { ParticleEmitter } = {}
	if root:IsA("ParticleEmitter") then
		table.insert(list, root)
	end
	for _, d in root:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			table.insert(list, d)
		end
	end
	return list
end

-- Clone a template onto a limb, handling each supported template type.
local function attach(template: Instance, part: BasePart, anchor: string?): Instance?
	local clone = template:Clone()

	if clone:IsA("Attachment") then
		if anchor then
			clone.Position = anchorOffset(part, anchor)
		end
		clone.Parent = part
		return clone
	elseif clone:IsA("ParticleEmitter") then
		clone.Parent = part -- emits from the limb's volume (anchor not used)
		return clone
	elseif clone:IsA("BasePart") then
		-- Weld the host part to the limb so it follows the animation.
		clone.Anchored = false
		clone.CanCollide = false
		clone.CanQuery = false
		clone.CanTouch = false
		clone.Massless = true
		clone.CFrame = part.CFrame * CFrame.new(if anchor then anchorOffset(part, anchor) else Vector3.zero)
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = part
		weld.Part1 = clone
		weld.Parent = clone
		clone.Parent = part
		return clone
	else
		clone:Destroy()
		warn(`[CharacterVFX] template must be a ParticleEmitter, Attachment, or BasePart (got {clone.ClassName}).`)
		return nil
	end
end

function CharacterVFX._despawn(self: CharacterVFX)
	for _, s in self._spawned do
		s.root:Destroy() -- removes welds + all child emitters
	end
	table.clear(self._spawned)
end

function CharacterVFX._spawn(self: CharacterVFX)
	self:_despawn()
	local character = self._character
	if not character then
		return
	end

	for _, effect in Config.VFX.Effects do
		local template = effect.template
		if not template then
			warn("[CharacterVFX] an effect has no template — skipping.")
			continue
		end
		for _, partName in effect.parts do
			local part = character:FindFirstChild(partName)
			if part and part:IsA("BasePart") then
				local root = attach(template, part, effect.anchor)
				if root then
					local emitters = gatherEmitters(root)
					for _, e in emitters do
						e.Enabled = true
					end
					table.insert(self._spawned, { root = root, emitters = emitters })
				end
			end
		end
	end
end

function CharacterVFX.setCharacter(self: CharacterVFX, character: Model?)
	self._character = character
	table.clear(self._spawned) -- old clones died with the old character
	if self._state == "Exposed" and character then
		self:_spawn()
	end
end

function CharacterVFX.setState(self: CharacterVFX, state: Types.RainState)
	self._state = state
	self._gen += 1
	local myGen = self._gen

	if state == "Exposed" then
		if #self._spawned == 0 then
			self:_spawn()
		else
			for _, s in self._spawned do
				for _, e in s.emitters do
					e.Enabled = true
				end
			end
		end
	else
		local dryTime = Config.VFX.DryTime
		if dryTime <= 0 then
			self:_despawn()
		else
			task.delay(dryTime, function()
				if self._gen == myGen then
					self:_despawn()
				end
			end)
		end
	end
end

function CharacterVFX.stop(self: CharacterVFX)
	self._gen += 1
	self:_despawn()
	self._state = "Exposed"
end

return CharacterVFX