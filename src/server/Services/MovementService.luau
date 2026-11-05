--!strict
-- Server-side Runner movement: authoritative stamina and speed checks (GAME_PLAN.md Section 2B,
-- ROADMAP "Runner stamina is tracked on the client: move it server-side").
--
-- Stamina: the server watches how fast each Runner actually moves. Moving faster than their walk
-- speed counts as sprinting and drains stamina; standing / walking regenerates it after a delay.
-- Skill and slide costs are paid here, and refunds (near misses, skills) are added here. The value
-- is mirrored to the player attribute "Stamina"; the client predicts locally and snaps to it.
--
-- Speed checks: every SampleInterval the server compares how far a Runner moved with how far they
-- could have moved. Repeated violations pull them back to their last good position. Knockbacks,
-- dashes, ragdolls and server teleports call MoveGrace (shared/Util/MoveGrace.luau) so they're
-- never counted. IsTrusted() lets RoundService refuse finishes from a player who was just flagged.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local MoveGrace = require(ReplicatedStorage.Shared.Util.MoveGrace)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local MovementService = {}

-- (player, distance, allowed) whenever a pull-back happens.
MovementService.PulledBack = Signal.new()

type State = {
	Stamina: number,
	LastDrain: number,
	EmptyAt: number, -- os.clock() stamina last hit 0
	Character: Model?,
	LastPosition: Vector3?,
	LastTrusted: Vector3?,
	LastTeleport: number,
	SampleTimer: number,
	SampleDistance: number,
	Strikes: { number },
	PulledBackAt: number,
	ReplicatedValue: number,
	Sprinting: boolean,
	-- Sprint detection averages over a short window: positions reach the server in bursts, so
	-- one frame's movement says nothing about speed.
	SprintWindowTime: number,
	SprintWindowDistance: number,
}

local states: { [Player]: State } = {}

local SPRINT_WINDOW = 0.2 -- seconds of movement averaged to decide "sprinting"

local function newState(): State
	return {
		Stamina = MovementConfig.Stamina.Max,
		LastDrain = 0,
		EmptyAt = -math.huge,
		Character = nil,
		LastPosition = nil,
		LastTrusted = nil,
		LastTeleport = 0,
		SampleTimer = 0,
		SampleDistance = 0,
		Strikes = {},
		PulledBackAt = -math.huge,
		ReplicatedValue = -1,
		Sprinting = false,
		SprintWindowTime = 0,
		SprintWindowDistance = 0,
	}
end

local function getState(player: Player): State
	local state = states[player]
	if not state then
		state = newState()
		states[player] = state
	end
	return state
end

local function replicate(player: Player, state: State, force: boolean?)
	local rounded = math.floor(state.Stamina + 0.5)
	if force or rounded ~= state.ReplicatedValue then
		state.ReplicatedValue = rounded
		player:SetAttribute("Stamina", rounded)
	end
end

local function setStamina(player: Player, state: State, value: number)
	local max = MovementConfig.Stamina.Max
	local old = state.Stamina
	state.Stamina = math.clamp(value, 0, max)
	if state.Stamina < old then
		state.LastDrain = os.clock()
	end
	if state.Stamina <= 0 and old > 0 then
		state.EmptyAt = os.clock()
	end
	replicate(player, state)
end

-- ------------------------------------------------------------------ stamina API
function MovementService.GetStamina(player: Player): number
	return getState(player).Stamina
end

-- Adds (or with a negative amount, removes) stamina. notifyClient sends the change to the client
-- straight away so its bar reacts before the next attribute update.
function MovementService.AddStamina(player: Player, amount: number, reason: string?, notifyClient: boolean?)
	local state = getState(player)
	setStamina(player, state, state.Stamina + amount)
	if notifyClient ~= false then
		Remotes.Event("Stamina"):FireClient(player, amount, reason or "Server")
	end
end

-- Pays a cost if the player can afford it. Returns false (and charges nothing) otherwise.
function MovementService.SpendStamina(player: Player, amount: number, notifyClient: boolean?): boolean
	if amount <= 0 then
		return true
	end
	local state = getState(player)
	if state.Stamina + 0.5 < amount then
		return false
	end
	setStamina(player, state, state.Stamina - amount)
	if notifyClient then
		Remotes.Event("Stamina"):FireClient(player, -amount, "Skill")
	end
	return true
end

function MovementService.ResetStamina(player: Player)
	local state = getState(player)
	state.Stamina = MovementConfig.Stamina.Max
	state.EmptyAt = -math.huge
	replicate(player, state, true)
end

-- ------------------------------------------------------------------ trust
-- False for a few seconds after a speed violation or pull-back.
function MovementService.IsTrusted(player: Player): boolean
	local state = states[player]
	if not state then
		return true
	end
	local now = os.clock()
	if now - state.PulledBackAt < 3 then
		return false
	end
	local window = MovementConfig.AntiCheat.StrikeWindow
	for _, t in state.Strikes do
		if now - t < window then
			return false
		end
	end
	return true
end

-- ------------------------------------------------------------------ per frame
local function speedLimits(character: Model): (number, number)
	local multiplier = (character:GetAttribute("SpeedMultiplier") :: number?) or 1
	local boost = (character:GetAttribute("SpeedBoost") :: number?) or 1
	-- Slows never lower the limit below normal walking (we only care about going too fast).
	local scale = math.max(multiplier, 1) * math.max(boost, 1)
	return MovementConfig.WalkSpeed * scale, MovementConfig.SprintSpeed * scale
end

local function resetTracking(state: State, position: Vector3?)
	state.LastPosition = position
	state.LastTrusted = position
	state.SampleTimer = 0
	state.SampleDistance = 0
	state.SprintWindowTime = 0
	state.SprintWindowDistance = 0
	state.Sprinting = false
end

local function pullBack(player: Player, state: State, character: Model, root: BasePart, distance: number, allowed: number)
	local target = state.LastTrusted
	state.PulledBackAt = os.clock()
	table.clear(state.Strikes)
	if target then
		root.AssemblyLinearVelocity = Vector3.zero
		MoveGrace.Teleport(character, CFrame.new(target) * root.CFrame.Rotation)
		resetTracking(state, target)
	end
	warn(`[MovementService] Pulled back {player.Name}: moved {math.floor(distance)} studs, allowed {math.floor(allowed)}`)
	MovementService.PulledBack:Fire(player, distance, allowed)
end

local function step(dt: number)
	local cfg = MovementConfig.AntiCheat
	local stamina = MovementConfig.Stamina
	local now = os.clock()
	for _, player in Players:GetPlayers() do
		local state = getState(player)
		local character = player.Character
		local root = character and Characters.GetRoot(character)
		if not character or not root or not Characters.IsAlive(character) or player:GetAttribute("Role") == "God" or root.Anchored then
			state.Character = nil
			state.LastPosition = nil
			continue
		end

		-- New character or a server teleport: start tracking fresh.
		local teleportedAt = character:GetAttribute("TeleportedAt")
		local teleported = type(teleportedAt) == "number" and teleportedAt ~= state.LastTeleport
		if state.Character ~= character or teleported or state.LastPosition == nil then
			if state.Character ~= character then
				state.Stamina = stamina.Max
				state.EmptyAt = -math.huge
				replicate(player, state, true)
			end
			state.Character = character
			if teleported then
				state.LastTeleport = teleportedAt :: number
			end
			resetTracking(state, root.Position)
			continue
		end

		local position = root.Position
		local last = state.LastPosition :: Vector3
		local moved = Vector3.new(position.X - last.X, 0, position.Z - last.Z).Magnitude
		state.LastPosition = position
		local grace = MoveGrace.Active(character)
		local walkLimit, sprintLimit = speedLimits(character)
		local freeSprint = character:GetAttribute("FreeSprint") == true

		-- Stamina: moving faster than walking (outside a grace window) is sprinting. Uses the real
		-- multipliers (slows included), so a slowed Runner who sprints still pays for it.
		state.SprintWindowTime += dt
		state.SprintWindowDistance += moved
		if state.SprintWindowTime >= SPRINT_WINDOW then
			local speed = state.SprintWindowDistance / state.SprintWindowTime
			local actualWalk = MovementConfig.WalkSpeed
				* ((character:GetAttribute("SpeedMultiplier") :: number?) or 1)
				* ((character:GetAttribute("SpeedBoost") :: number?) or 1)
			state.Sprinting = speed > actualWalk * 1.15 + 1
			state.SprintWindowTime = 0
			state.SprintWindowDistance = 0
		end
		local sprinting = state.Sprinting and not grace and not freeSprint
		if sprinting then
			setStamina(player, state, state.Stamina - stamina.SprintDrain * dt)
		elseif now - state.LastDrain >= stamina.RegenDelay and state.Stamina < stamina.Max then
			setStamina(player, state, state.Stamina + stamina.Regen * dt)
		end

		-- Speed check, sampled.
		if not cfg.Enabled then
			continue
		end
		if grace then
			state.SampleTimer = 0
			state.SampleDistance = 0
			state.LastTrusted = position
			continue
		end
		state.SampleTimer += dt
		state.SampleDistance += moved
		if state.SampleTimer < cfg.SampleInterval then
			continue
		end
		-- Sprinting is allowed with stamina left (plus a second of slack for client/server drift).
		local canSprint = freeSprint or state.Stamina > 0 or now - state.EmptyAt < 1
		local limit = if canSprint then sprintLimit else walkLimit
		local allowed = limit * state.SampleTimer * cfg.SpeedTolerance + cfg.ExtraStuds
		local distance = state.SampleDistance
		state.SampleTimer = 0
		state.SampleDistance = 0
		if distance <= allowed then
			state.LastTrusted = position
		else
			table.insert(state.Strikes, now)
			local recent = 0
			for i = #state.Strikes, 1, -1 do
				if now - state.Strikes[i] < cfg.StrikeWindow then
					recent += 1
				else
					table.remove(state.Strikes, i)
				end
			end
			-- One giant jump (a teleport) is pulled back at once.
			if recent >= cfg.Strikes or distance > allowed * 4 then
				pullBack(player, state, character, root, distance, allowed)
			end
		end
	end
end

function MovementService.Init() end

function MovementService.Start()
	RunService.Heartbeat:Connect(step)
	Players.PlayerRemoving:Connect(function(player)
		states[player] = nil
	end)
end

return MovementService
