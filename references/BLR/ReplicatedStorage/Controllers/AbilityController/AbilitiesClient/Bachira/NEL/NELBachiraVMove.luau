  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
local Popup = require(ReplicatedStorage.Shared.Popup);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local script_ButterflyRoulette = require(script.ButterflyRoulette);
local script_ButterflyLift = require(script.ButterflyLift);

return function(p1, p2, p3) -- Line: 29
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), script_ButterflyLift (copy), Popup (copy), script_ButterflyRoulette (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(2) and AbilityUtils.rules.onball(p2, true))) then
        return;
    end;

    if p3:GetAttribute("ButterflyLift") then
        local v4 = AbilityUtils.findNearestPlayer({
            team = "Enemy",
            distance = AbilityBalancing.ButterflyLift.ActivationRangePlayer
        });

        if v4 then
            return script_ButterflyLift(p1, p2, p3, v4);
        end;

        Popup.Popup(p2, "Must be facing enemy player!");

        return;
    end;

    local v5 = AbilityUtils.findNearestPlayer({
        team = "Enemy",
        distance = AbilityBalancing.ButterflyRoulette.ActivationRangePlayer
    });

    if v5 then
        return script_ButterflyRoulette(p1, p2, p3, v5);
    end;

    Popup.Popup(p2, "Must be facing enemy player!");
end;