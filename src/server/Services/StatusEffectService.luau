--!strict
-- Authoritative crowd-control and iframe states for every character (FRAMEWORK_PLAN.md Section 1).
-- Built on NumberStack (SorceryGame reference), so effects stack instead of overwriting:
-- a character is stunned until *every* stun on them has run out.
-- Each state is mirrored to a character attribute of the same name for clients and other scripts.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local StatusEffectType = require(ReplicatedStorage.Shared.Enums.StatusEffectType)
local NumberStack = require(ReplicatedStorage.Shared.Util.NumberStack)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

type Slow = { Factor: number, Expires: number }

type State = {
	Character: Model,
	Humanoid: Humanoid,
	Stacks: { [string]: NumberStack.NumberStack },
	Slows: { [Slow]: boolean },
	Connections: { RBXScriptConnection },
}

local StatusEffectService = {}

-- Fires (character, effectName, isOn) whenever an effect turns on or off.
StatusEffectService.Changed = Signal.new()

local states: { [Model]: State } = {}

-- Effects that stop movement entirely.
local MOVEMENT_LOCKS = { "Stunned", "Rooted", "Ragdolled", "InfiniteVoid" }
-- Effects that stop casting.
local CAST_LOCKS = { "Stunned", "Silenced", "Ragdolled", "InfiniteVoid" }

local function isOn(state: State, effect: string): boolean
	local stack = state.Stacks[effect]
	return stack ~= nil and stack:IsOn()
end

local function strongestSlow(state: State): number
	local now = os.clock()
	local factor = 1
	for slow in state.Slows do
		if slow.Expires <= now then
			state.Slows[slow] = nil
		elseif slow.Factor < factor then
			factor = slow.Factor
		end
	end
	return factor
end

-- Recomputes WalkSpeed / JumpPower from the active effects.
-- Base values come from the character attributes BaseWalkSpeed / BaseJumpPower when set
-- (the movement system will set them for sprinting), otherwise CombatConfig.
local function applyMovement(state: State)
	local humanoid = state.Humanoid
	if humanoid.Health <= 0 then
		return
	end
	local character = state.Character
	local baseSpeed = (character:GetAttribute("BaseWalkSpeed") :: number?) or CombatConfig.BaseWalkSpeed
	local baseJump = (character:GetAttribute("BaseJumpPower") :: number?) or CombatConfig.BaseJumpPower

	local locked = false
	for _, effect in MOVEMENT_LOCKS do
		if isOn(state, effect) then
			locked = true
			break
		end
	end
	local multiplier = if locked then 0 else strongestSlow(state)
	character:SetAttribute("SpeedMultiplier", multiplier)
	character:SetAttribute("MovementLocked", locked)

	humanoid.UseJumpPower = true
	humanoid.WalkSpeed = baseSpeed * multiplier
	humanoid.JumpPower = if locked then 0 else baseJump
end

local function getState(character: Model): State?
	local existing = states[character]
	if existing then
		return existing
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end

	local state: State = {
		Character = character,
		Humanoid = humanoid,
		Stacks = {},
		Slows = {},
		Connections = {},
	}
	for effect in StatusEffectType do
		local stack = NumberStack.new()
		state.Stacks[effect] = stack
		stack.Changed:Connect(function(on: boolean)
			if states[character] ~= state then
				return
			end
			character:SetAttribute(effect, on or nil)
			applyMovement(state)
			StatusEffectService.Changed:Fire(character, effect, on)
		end)
	end
	table.insert(state.Connections, humanoid.Died:Connect(function()
		StatusEffectService.Clear(character)
	end))
	table.insert(state.Connections, character.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			StatusEffectService.Clear(character)
		end
	end))
	-- Re-apply when the movement system changes the base speed (e.g. sprinting).
	table.insert(state.Connections, character:GetAttributeChangedSignal("BaseWalkSpeed"):Connect(function()
		applyMovement(state)
	end))
	states[character] = state
	return state
end

-- A handle that removes one applied effect early.
export type Handle = { Remove: (self: Handle) -> () }

local NOOP_HANDLE: Handle = { Remove = function() end }

--[[
	Applies an effect for `duration` seconds (nil = until removed with the returned handle).
	Options:
	  Factor   (Slowed only) speed multiplier 0-1, e.g. 0.6 = 40% slower
	  Force    ignore Invulnerable / StunImmunity (use for self-buffs and scripted moments)
	Returns a handle, or nil if the effect was refused (iframes, stun immunity, dead).
]]
function StatusEffectService.Apply(character: Model, effect: StatusEffectType.StatusEffectType, duration: number?, options: { Factor: number?, Force: boolean? }?): Handle?
	assert(StatusEffectType[effect], `Unknown status effect {effect}`)
	local state = getState(character)
	if not state then
		return nil
	end
	local force = options and options.Force
	local hostile = effect ~= "Invulnerable" and effect ~= "StunImmunity"
	if hostile and not force and isOn(state, "Invulnerable") then
		return nil
	end
	if (effect == "Stunned" or effect == "InfiniteVoid") and not force and isOn(state, "StunImmunity") then
		return nil
	end

	local stack = state.Stacks[effect]
	local slow: Slow? = nil
	if effect == "Slowed" then
		local factor = math.clamp(options and options.Factor or 0.5, 0, 1)
		slow = { Factor = factor, Expires = if duration then os.clock() + duration else math.huge }
		state.Slows[slow :: Slow] = true
	end

	if duration then
		stack:Add(duration)
		applyMovement(state)
		if slow then
			-- Re-check speed when this slow ends even if another slow keeps the state on.
			task.delay(duration, function()
				if states[character] == state then
					applyMovement(state)
				end
			end)
		end
		return NOOP_HANDLE -- timed effects end on their own
	end

	stack:Add()
	applyMovement(state)
	local removed = false
	return {
		Remove = function()
			if removed or states[character] ~= state then
				return
			end
			removed = true
			if slow then
				state.Slows[slow] = nil
			end
			stack:Remove()
			applyMovement(state)
		end,
	}
end

function StatusEffectService.Has(character: Model, effect: StatusEffectType.StatusEffectType): boolean
	local state = states[character]
	return state ~= nil and isOn(state, effect)
end

function StatusEffectService.IsInvulnerable(character: Model): boolean
	return StatusEffectService.Has(character, "Invulnerable")
end

-- True when the character may cast abilities right now.
function StatusEffectService.CanCast(character: Model): boolean
	local state = states[character]
	if not state then
		return true
	end
	for _, effect in CAST_LOCKS do
		if isOn(state, effect) then
			return false
		end
	end
	return true
end

-- True when the character may move right now.
function StatusEffectService.CanMove(character: Model): boolean
	local state = states[character]
	if not state then
		return true
	end
	for _, effect in MOVEMENT_LOCKS do
		if isOn(state, effect) then
			return false
		end
	end
	return true
end

-- Removes every effect of one type (e.g. a cleanse), or everything when effect is nil.
function StatusEffectService.Cleanse(character: Model, effect: StatusEffectType.StatusEffectType?)
	local state = states[character]
	if not state then
		return
	end
	for name, stack in state.Stacks do
		if effect == nil or name == effect then
			stack:Reset()
			if name == "Slowed" then
				table.clear(state.Slows)
			end
		end
	end
	applyMovement(state)
end

-- Forgets a character (death / despawn). Attributes are cleared too.
function StatusEffectService.Clear(character: Model)
	local state = states[character]
	if not state then
		return
	end
	states[character] = nil
	for _, connection in state.Connections do
		connection:Disconnect()
	end
	for effect, stack in state.Stacks do
		stack:Reset()
		character:SetAttribute(effect, nil)
	end
end

function StatusEffectService.Init() end

function StatusEffectService.Start() end

return StatusEffectService
