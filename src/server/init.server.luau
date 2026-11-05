--!strict
-- Server entry point. Every service gets Init() (register requests, set up state) in order,
-- then Start() (connect events, begin work). Add new services to SERVICES.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local Services = script.Services

local SERVICES = {
	"Requests",
	"DataService",
	"InventoryService",
	"GachaService",
	"MonetizationService",
	-- Combat core
	"StatusEffectService",
	"RagdollService",
	"KnockbackService",
	"HitboxService",
	"CombatService",
	"DevTestService", -- test dummies + /test commands (Studio / creator only)
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
