--!strict
-- Client entry point. Every controller gets Init() in order, then Start() in its own thread.
-- Add new controllers to CONTROLLERS.

local Controllers = script:WaitForChild("Controllers")

local CONTROLLERS = {
	"DataController",
	"UIController",
	"VaultController",
	"CombatController",
	"MovementController",
	"GodController",
	"AbilityController",
	"FxController",
	"MatchHUDController",
	"AdminController",
}

local loaded = {}
for _, name in CONTROLLERS do
	loaded[name] = require(Controllers:WaitForChild(name) :: ModuleScript) :: any
end

for _, name in CONTROLLERS do
	local controller = loaded[name]
	if controller.Init then
		controller.Init()
	end
end

for _, name in CONTROLLERS do
	local controller = loaded[name]
	if controller.Start then
		task.spawn(controller.Start)
	end
end
