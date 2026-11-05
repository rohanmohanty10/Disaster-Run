--!strict
-- Server entry point. Every service gets Init() (register requests, set up state) in order,
-- then Start() (connect events, begin work). Add new services to SERVICES.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local Services = script.Services

local SERVICES = {
	"Requests",
	"DataService",
	"ProgressionService", -- levels, XP, reward granting
	"QuestService", -- daily quests + daily login reward
	"InventoryService",
	"GachaService",
	"MonetizationService",
	"ShopService", -- rotating Divine Shard shop
	-- Combat core
	"StatusEffectService",
	"RagdollService",
	"KnockbackService",
	"HitboxService",
	"CombatService",
	"MovementService", -- server-side stamina + speed checks
	"ShoveService", -- everyone's shoulder-shove (F)
	"FogService", -- fog of war (off unless FogConfig.Enabled)
	"AbilityService",
	"DestructionService", -- cover health, shattering, roof collapse
	"MapService",
	"RoundService",
	"TestAreaService", -- dev test area: try Runner / God kits without a match
	"DevTestService", -- test dummies + /test commands (Studio / creator only)
	"AdminService", -- admin panel: equip any kit, give spins, test tools
}

Remotes.CreateAll()

local loaded = {}
for _, name in SERVICES do
	loaded[name] = require(Services:FindFirstChild(name) :: ModuleScript) :: any
end

for _, name in SERVICES do
	local service = loaded[name]
	if service.Init then
		service.Init()
	end
end

for _, name in SERVICES do
	local service = loaded[name]
	if service.Start then
		task.spawn(service.Start)
	end
end
