--!strict
-- The ability framework (ROADMAP step 2). Every skill of every kit goes through here:
--   input (Ability remote) -> checks (role, alive, can cast, cooldown, energy) -> behaviour.
-- Numbers come from Kits.luau; behaviours from src/server/Abilities.
--
-- Replicated state (player attributes, read by the HUDs):
--   Cooldown<i>  server time when skill i is ready again
--   Energy / MaxEnergy  (Gods)
--   Charging     index of the skill being held, or nil

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local RoundConfig = require(ReplicatedStorage.Shared.Config.RoundConfig)
local TestAreaConfig = require(ReplicatedStorage.Shared.Config.TestAreaConfig)
local TestAreaService = require(script.Parent.TestAreaService)
local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local StatusEffectService = require(script.Parent.StatusEffectService)
local InventoryService = require(script.Parent.InventoryService)
local CombatService = require(script.Parent.CombatService)

local Abilities = script.Parent.Parent.Abilities
local Common = require(Abilities.Common)
local GodSkills = require(Abilities.GodSkills)
local RunnerSkills = require(Abilities.RunnerSkills)

local AbilityService = {}

type Charge = { Index: number, Started: number, Released: boolean }

type PlayerState = {
	Charge: Charge?,
	Aim: Vector3?,
	CastCount: number, -- for Aftershock
	Discount: number, -- Four Arms: next cost multiplier
	LastInput: number,
	SlideReady: number,
}

local states: { [Player]: PlayerState } = {}

local function now(): number
	return workspace:GetServerTimeNow()
end

local function getState(player: Player): PlayerState
	local state = states[player]
	if not state then
		state = { Charge = nil, Aim = nil, CastCount = 0, Discount = 1, LastInput = 0, SlideReady = 0 }
		states[player] = state
	end
	return state
end

local function validVector(value: any): boolean
	return typeof(value) == "Vector3" and value.X == value.X and value.Y == value.Y and value.Z == value.Z and value.Magnitude < 1e5
end

-- The kit a player is using right now, or nil if they have no role.
function AbilityService.GetKit(player: Player): (string?, Kits.Kit?)
	local role = player:GetAttribute("Role")
	if role ~= "God" and role ~= "Runner" then
		return nil, nil
	end
	local kitId = InventoryService.GetEquipped(player, role)
	return role, Kits.Get(role, kitId)
end

-- Sets up attributes when a player's role or kit changes (called by RoundService and on spawn).
function AbilityService.Prepare(player: Player)
	local role, kit = AbilityService.GetKit(player)
	for i = 1, 5 do
		player:SetAttribute(`Cooldown{i}`, nil)
	end
	player:SetAttribute("Charging", nil)
	player:SetAttribute("Passive_AutonomousReflex", nil)
	player:SetAttribute("Passive_FlowState", nil)
	if role == "God" then
		player:SetAttribute("MaxEnergy", RoundConfig.GodEnergy.Max)
		player:SetAttribute("Energy", RoundConfig.GodEnergy.Start)
	else
		player:SetAttribute("MaxEnergy", nil)
		player:SetAttribute("Energy", nil)
	end
	if kit and kit.Passive then
		if kit.Passive.Name == "Autonomous Reflex" then
			player:SetAttribute("Passive_AutonomousReflex", true)
		elseif kit.Passive.Name == "Flow State" then
			player:SetAttribute("Passive_FlowState", true)
		end
	end
	local character = player.Character
	if character then
		character:SetAttribute("TracksHistory", kit ~= nil and kit.Id == "TimeLord" or nil)
	end
	local state = getState(player)
	state.Charge = nil
	state.CastCount = 0
	state.Discount = 1
end

local function costFor(state: PlayerState, kit: Kits.Kit, skill: Kits.Skill): number
	local cost = skill.Cost
	if kit.Passive and kit.Passive.Name == "Four Arms" then
		cost = math.floor(cost * state.Discount + 0.5)
	end
	return cost
end

local function canUse(player: Player, character: Model, index: number): (boolean, Kits.Kit?, Kits.Skill?, string?)
	local role, kit = AbilityService.GetKit(player)
	if not role or not kit then
		return false, nil, nil, nil
	end
	local skill = kit.Skills[index]
	if not skill then
		return false, nil, nil, nil
	end
	if not Characters.IsAlive(character) or not StatusEffectService.CanCast(character) then
		return false, kit, skill, nil
	end
	local ready = player:GetAttribute(`Cooldown{index}`)
	if type(ready) == "number" and ready > now() then
		return false, kit, skill, nil
	end
	if role == "God" and not TestAreaService.FreeCasts(player) then
		local energy = (player:GetAttribute("Energy") :: number?) or 0
		if energy < costFor(getState(player), kit, skill) then
			return false, kit, skill, "Not enough energy!"
		end
	end
	return true, kit, skill, nil
end

local function spend(player: Player, kit: Kits.Kit, skill: Kits.Skill, index: number)
	local state = getState(player)
	if TestAreaService.FreeCasts(player) then
		-- Dev test area, no-cooldown mode: nothing is spent, only a short anti-spam delay.
		player:SetAttribute(`Cooldown{index}`, now() + TestAreaConfig.NoCooldownDelay)
		return
	end
	player:SetAttribute(`Cooldown{index}`, now() + skill.Cooldown)
	if player:GetAttribute("Role") == "God" then
		local energy = (player:GetAttribute("Energy") :: number?) or 0
		player:SetAttribute("Energy", math.max(energy - costFor(state, kit, skill), 0))
		state.Discount = if kit.Passive and kit.Passive.Name == "Four Arms" then 0.85 else 1
	elseif skill.Cost > 0 then
		-- Runner stamina lives on the client; tell it to pay.
		Remotes.Event("Stamina"):FireClient(player, -skill.Cost, "Skill")
	end
end

-- Runs a God behaviour.
local function castGod(player: Player, kit: Kits.Kit, skill: Kits.Skill, target: Vector3, direction: Vector3, charge: number)
	local state = getState(player)
	local behavior = skill.Behavior
	local template = (GodSkills :: any)[behavior.T]
	if not template then
		warn(`[Abilities] No God template "{behavior.T}" for {skill.Name}`)
		return
	end
	local ground = Common.Ground(target)
	local ctx: GodSkills.Context = {
		Player = player,
		Skill = skill,
		Behavior = behavior,
		Target = ground,
		Direction = Common.Flat(direction),
		Charge = charge,
		GetAim = function()
			return if state.Aim then Common.Ground(state.Aim) else ground
		end,
		IsHeld = function()
			local c = state.Charge
			return c ~= nil and not c.Released
		end,
	}
	state.CastCount += 1
	if kit.Passive and kit.Passive.Name == "Aftershock" and state.CastCount % 3 == 0 then
		task.spawn(GodSkills.Aftershock, player, ground)
	end
	template(ctx)
end

-- Runs a Runner behaviour.
local function castRunner(player: Player, character: Model, skill: Kits.Skill, data: { [string]: any })
	local behavior = skill.Behavior
	local template = (RunnerSkills :: any)[behavior.T]
	if not template then
		warn(`[Abilities] No Runner template "{behavior.T}" for {skill.Name}`)
		return
	end
	local root = Characters.GetRoot(character)
	if not root then
		return
	end
	local look = Common.Flat(if validVector(data.Direction) then data.Direction else nil, root.CFrame.LookVector)
	local move = Common.Flat(if validVector(data.Move) and (data.Move :: Vector3).Magnitude > 0.1 then data.Move else nil, look)
	local ctx: RunnerSkills.Context = {
		Player = player,
		Character = character,
		Root = root,
		Skill = skill,
		Behavior = behavior,
		Look = look,
		Move = move,
		Aim = if validVector(data.Target) then data.Target else nil,
	}
	template(ctx)
end

local function onAbility(player: Player, action: any, index: any, data: any)
	if type(index) ~= "number" or index % 1 ~= 0 or index < 1 or index > 5 then
		return
	end
	if type(data) ~= "table" then
		data = {}
	end
	local character = player.Character
	if not character then
		return
	end
	local state = getState(player)
	local t = os.clock()

	-- The slide is a movement action, not a kit skill: the client moves, the server grants iframes.
	if action == "Slide" then
		if player:GetAttribute("Role") ~= "God" and t >= state.SlideReady and StatusEffectService.CanMove(character) then
			state.SlideReady = t + MovementConfig.Slide.Cooldown - 0.1
			CombatService.GiveIFrames(character, MovementConfig.Slide.IFrames)
		end
		return
	end

	if action == "Press" and t - state.LastInput < 0.05 then
		return -- input flood guard
	end
	state.LastInput = t

	if action == "Release" then
		local charge = state.Charge
		if not charge or charge.Index ~= index or charge.Released then
			return
		end
		charge.Released = true
		return
	end
	if action ~= "Press" then
		return
	end
	if state.Charge and not state.Charge.Released then
		return -- already holding another skill
	end

	local ok, kit, skill, message = canUse(player, character, index)
	if not ok or not kit or not skill then
		if message then
			Common.FxTo(player, { Kind = "Toast", Text = message })
		end
		return
	end

	local role = player:GetAttribute("Role")
	local behavior = skill.Behavior
	spend(player, kit, skill, index)

	if role == "Runner" then
		task.spawn(castRunner, player, character, skill, data)
		return
	end

	-- God: aimed at the reticle. Charge skills wait for release (or max charge).
	local target = if validVector(data.Target) then data.Target :: Vector3 else (Characters.GetRoot(character) :: BasePart).Position
	local direction = if validVector(data.Direction) then data.Direction :: Vector3 else Vector3.new(0, 0, -1)
	state.Aim = target
	local maxCharge = behavior.Charge or (if behavior.T == "Rain" then behavior.Duration else nil)
	if not maxCharge then
		task.spawn(castGod, player, kit, skill, target, direction, 0)
		return
	end

	local charge: Charge = { Index = index, Started = os.clock(), Released = false }
	state.Charge = charge
	player:SetAttribute("Charging", index)
	task.spawn(function()
		if behavior.T == "Rain" then
			-- Rain starts right away and lasts while held.
			castGod(player, kit, skill, target, direction, 1)
		else
			while not charge.Released and os.clock() - charge.Started < maxCharge do
				task.wait()
			end
			charge.Released = true
			local fraction = math.clamp((os.clock() - charge.Started) / maxCharge, 0, 1)
			player:SetAttribute("Charging", nil)
			castGod(player, kit, skill, state.Aim or target, direction, fraction)
		end
		if state.Charge == charge then
			state.Charge = nil
		end
		player:SetAttribute("Charging", nil)
	end)
end

function AbilityService.Init()
	RunnerSkills.Init()
	Remotes.Event("Ability").OnServerEvent:Connect(onAbility)
	Remotes.Unreliable("Aim").OnServerEvent:Connect(function(player: Player, point: any)
		if validVector(point) then
			getState(player).Aim = point
		end
	end)
end

function AbilityService.Start()
	RunnerSkills.Start()
	-- God energy regeneration.
	RunService.Heartbeat:Connect(function(dt)
		for _, player in Players:GetPlayers() do
			if player:GetAttribute("Role") == "God" then
				local energy = (player:GetAttribute("Energy") :: number?) or 0
				local max = (player:GetAttribute("MaxEnergy") :: number?) or RoundConfig.GodEnergy.Max
				if energy < max then
					player:SetAttribute("Energy", math.min(max, energy + RoundConfig.GodEnergy.Regen * dt))
				end
			end
		end
	end)
	-- Refresh cooldowns / passives when a role or kit changes.
	local function watch(player: Player)
		player:GetAttributeChangedSignal("Role"):Connect(function()
			AbilityService.Prepare(player)
		end)
		for _, role in Kits.Roles do
			player:GetAttributeChangedSignal(`Equipped{role}Kit`):Connect(function()
				if player:GetAttribute("Role") == role then
					AbilityService.Prepare(player)
				end
			end)
		end
		player.CharacterAdded:Connect(function()
			task.defer(AbilityService.Prepare, player)
		end)
	end
	for _, player in Players:GetPlayers() do
		watch(player)
	end
	Players.PlayerAdded:Connect(watch)
	Players.PlayerRemoving:Connect(function(player)
		states[player] = nil
	end)
end

return AbilityService
