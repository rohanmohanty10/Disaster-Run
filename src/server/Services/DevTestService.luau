--!strict
-- Combat testing tools. Only active in Studio, or for the game's creator in a live server.
--   * Test dummies (Role = "Runner") that respawn after dying.
--   * "/test" chat commands that run the combat pipeline. Type "/test" for the list.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")

local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local Requests = require(script.Parent.Requests)
local CombatService = require(script.Parent.CombatService)
local HitboxService = require(script.Parent.HitboxService)
local StatusEffectService = require(script.Parent.StatusEffectService)
local RagdollService = require(script.Parent.RagdollService)
local KnockbackService = require(script.Parent.KnockbackService)
local RoundService = require(script.Parent.RoundService)

local DevTestService = {}

local dummies: { [number]: Model } = {}
local dummyFolder: Folder? = nil

local function isAllowed(player: Player): boolean
	if RunService:IsStudio() then
		return true
	end
	return game.CreatorType == Enum.CreatorType.User and player.UserId == game.CreatorId
end

local function dummiesEnabled(): boolean
	return RunService:IsStudio() or workspace:GetAttribute("SpawnTestDummies") == true
end

-- ------------------------------------------------------------------ dummies
local function spawnDummy(index: number)
	local folder = dummyFolder
	if not folder then
		return
	end
	local old = dummies[index]
	if old then
		old:Destroy()
	end
	local ok, dummy = pcall(function()
		return Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R6)
	end)
	if not ok or not dummy then
		warn(`[DevTest] Couldn't create test dummy: {dummy}`)
		return
	end
	local model = dummy :: Model
	model.Name = `Test Dummy {index}`
	model:SetAttribute("Role", "Runner")
	local humanoid = model:FindFirstChildOfClass("Humanoid") :: Humanoid
	humanoid.MaxHealth = CombatConfig.RunnerMaxHealth
	humanoid.Health = CombatConfig.RunnerMaxHealth
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
	humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
	local cfg = CombatConfig.TestDummies
	local position = cfg.Origin + Vector3.new((index - (cfg.Count + 1) / 2) * cfg.Spacing, 0, 0)
	model:PivotTo(CFrame.lookAt(position, position + Vector3.new(0, 0, 1)))
	model.Parent = folder
	dummies[index] = model
	local root = Characters.GetRoot(model)
	if root and root:CanSetNetworkOwnership() then
		root:SetNetworkOwner(nil)
	end
	RagdollService.Prepare(model)
	humanoid.Died:Once(function()
		task.wait(cfg.RespawnTime)
		if dummies[index] == model then
			spawnDummy(index)
		end
	end)
end

function DevTestService.SpawnDummies()
	if not dummyFolder then
		local folder = Instance.new("Folder")
		folder.Name = "TestDummies"
		folder.Parent = workspace
		dummyFolder = folder
	end
	for i = 1, CombatConfig.TestDummies.Count do
		spawnDummy(i)
	end
end

-- ------------------------------------------------------------------ commands
local HELP = [[/test smite | stun | slow | shove | barrage | void
/test me ragdoll | stun | slow | iframes | knockback | heal
/test role runner | god | none   /test hitboxes   /test dummies
/test round start | end | god | runner   (god/runner = your role in a solo Studio match)]]

local function front(player: Player, distance: number): CFrame?
	local character = player.Character
	local root = character and Characters.GetRoot(character)
	if not root then
		return nil
	end
	return root.CFrame * CFrame.new(0, 0, -distance)
end

-- A hitbox in front of the player that afflicts everything it finds with `args`.
local function strike(player: Player, shape: "Box" | "Sphere", size: Vector3 | number, distance: number, filter: string, args: CombatService.AfflictArgs, hits: number?)
	local at = front(player, distance)
	if not at then
		return "No character."
	end
	local cast = CombatService.NewCast()
	local results: { string } = {}
	for _ = 1, hits or 1 do
		local targets = HitboxService.Query({
			Shape = shape,
			Size = size,
			CFrame = at,
			Caster = player,
			Filter = filter :: any,
			Visualize = true,
		})
		for _, victim in targets do
			local copy = table.clone(args)
			copy.Cast = cast
			local _, reason = CombatService.Afflict(player, victim, copy)
			table.insert(results, `{victim.Name}: {reason}`)
		end
		if (hits or 1) > 1 then
			task.wait(0.15)
		end
	end
	if #results == 0 then
		return "Missed — nothing in range (stand facing a dummy, ~10 studs away)."
	end
	return table.concat(results, ", ")
end

local function run(player: Player, words: { string }): string
	local command = words[1]
	local character = player.Character
	if command == nil or command == "help" then
		return HELP
	elseif command == "smite" then
		return strike(player, "Sphere", 10, 12, "HostileToRunners", {
			Damage = 35,
			Ragdoll = 2,
			Knockback = { From = (front(player, 12) :: CFrame).Position, Power = 35, Lift = 55, Duration = 0.2 },
		})
	elseif command == "stun" then
		return strike(player, "Box", Vector3.new(10, 8, 10), 8, "HostileToRunners", { Damage = 10, Stun = 1.5 })
	elseif command == "slow" then
		return strike(player, "Sphere", 12, 10, "HostileToRunners", { Damage = 5, Slow = { Factor = 0.5, Duration = 3 } })
	elseif command == "shove" then
		local root = character and Characters.GetRoot(character)
		return strike(player, "Box", Vector3.new(6, 6, 8), 5, "RunnersPvP", {
			Stun = 0.3,
			Knockback = { Direction = if root then root.CFrame.LookVector else nil, Power = 70, Lift = 10, Duration = 0.25 },
		})
	elseif command == "barrage" then
		-- Five 20-damage hits in one cast: the per-cast cap stops it at 60.
		return strike(player, "Sphere", 10, 10, "HostileToRunners", { Damage = 20 }, 5)
	elseif command == "void" then
		return strike(player, "Sphere", 25, 0, "All", { InfiniteVoid = 2 })
	elseif command == "me" then
		if not character then
			return "No character."
		end
		local effect = words[2]
		if effect == "ragdoll" then
			RagdollService.Ragdoll(character, 2)
		elseif effect == "stun" then
			StatusEffectService.Apply(character, "Stunned", 2, { Force = true })
		elseif effect == "slow" then
			StatusEffectService.Apply(character, "Slowed", 3, { Factor = 0.4, Force = true })
		elseif effect == "iframes" then
			CombatService.GiveIFrames(character, 3)
		elseif effect == "knockback" then
			local root = Characters.GetRoot(character)
			KnockbackService.Apply(character, { Direction = if root then -root.CFrame.LookVector else nil, Power = 60, Lift = 40 })
		elseif effect == "heal" then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = humanoid.MaxHealth
			end
		else
			return "Unknown effect. " .. HELP
		end
		return `Applied {effect} to you.`
	elseif command == "role" then
		local role = words[2]
		if role == "runner" then
			player:SetAttribute("Role", "Runner")
		elseif role == "god" then
			player:SetAttribute("Role", "God")
		else
			player:SetAttribute("Role", nil)
		end
		return `Role: {player:GetAttribute("Role") or "none"}`
	elseif command == "hitboxes" then
		local attribute = CombatConfig.ShowHitboxesAttribute
		workspace:SetAttribute(attribute, not workspace:GetAttribute(attribute))
		return `Hitboxes {if workspace:GetAttribute(attribute) then "shown" else "hidden"}.`
	elseif command == "round" then
		local option = words[2]
		if option == "start" then
			RoundService.ForceStart()
			return "Starting the match now."
		elseif option == "end" then
			RoundService.ForceEnd()
			return "Ending the round / match."
		elseif option == "god" or option == "runner" then
			game:GetService("ReplicatedStorage"):SetAttribute("ForceSoloRole", if option == "god" then "God" else "Runner")
			return `Solo matches will make you a {option}. Use /test round start.`
		end
		return HELP
	elseif command == "dummies" then
		DevTestService.SpawnDummies()
		return "Dummies respawned."
	end
	return "Unknown command. " .. HELP
end

local function handle(player: Player, text: string)
	if not isAllowed(player) then
		return
	end
	local words = string.split(string.lower(text), " ")
	if words[1] ~= "/test" then
		return
	end
	table.remove(words, 1)
	local cleaned = {}
	for _, word in words do
		if word ~= "" then
			table.insert(cleaned, word)
		end
	end
	local ok, result = pcall(run, player, cleaned)
	Requests.Notify(player, if ok then result else `Error: {result}`, if ok then nil else Color3.fromRGB(255, 120, 120))
end

local function setupCommands()
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		local command = Instance.new("TextChatCommand")
		command.Name = "DevTestCommand"
		command.PrimaryAlias = "/test"
		command.Triggered:Connect(function(source: TextSource, text: string)
			local player = Players:GetPlayerByUserId(source.UserId)
			if player then
				handle(player, text)
			end
		end)
		command.Parent = TextChatService
	else
		local function onPlayer(player: Player)
			player.Chatted:Connect(function(message)
				handle(player, message)
			end)
		end
		for _, player in Players:GetPlayers() do
			onPlayer(player)
		end
		Players.PlayerAdded:Connect(onPlayer)
	end
end

-- Runs a /test command for the admin panel (AdminService checks admin rights first).
function DevTestService.RunCommand(player: Player, text: string): string
	local words = {}
	for _, word in string.split(string.lower(text), " ") do
		if word ~= "" then
			table.insert(words, word)
		end
	end
	local ok, result = pcall(run, player, words)
	return if ok then result else `Error: {result}`
end

function DevTestService.Init() end

function DevTestService.Start()
	setupCommands()
	if dummiesEnabled() then
		DevTestService.SpawnDummies()
	end
end

return DevTestService
