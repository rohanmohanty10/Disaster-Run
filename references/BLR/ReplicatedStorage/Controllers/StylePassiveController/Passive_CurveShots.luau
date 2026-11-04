  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Shared.utils.FindCurveDirection);
require(ReplicatedStorage.Controllers.BallController);
require(ReplicatedStorage.Controllers.AbilityController);
local _ = game.Players.LocalPlayer;
require(ReplicatedStorage.ClientModules.getCurrentStyle);
local v1 = {};
({})["Destructive Impulses"] = 2.75;
({})["NEL Rin"] = 3.5;

function v1.hook(p2) -- Line: 25
    -- upvalues: StatesController (copy), Trove (copy)
    local _ = StatesController.CharacterEvents;

    return Trove.new();
end;

return v1;