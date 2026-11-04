  

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
local script_CrowElusion = require(script.CrowElusion);
local script_LunarAxis = require(script.LunarAxis);

return function(p1, p2, p3) -- Line: 26
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), script_CrowElusion (copy), Popup (copy), script_LunarAxis (copy)
    local v4 = AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    if not v4 then
        return script_LunarAxis(p1, p2, p3);
    end;

    local v5 = AbilityUtils.findNearestPlayer({
        distance = AbilityBalancing.CrowElusion.ActivationRangePlayer
    });

    if v5 then
        return script_CrowElusion(p1, p2, p3, v5);
    end;

    Popup.Popup(p2, "Must be facing enemy player!");
end;