  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 20
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local StealthKillShot = AbilityBalancing.StealthKillShot;

    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    AbilityUtils.clientCutsceneSkill(interface, StealthKillShot, 24.666666666666668, 1, true, workspace.CurrentCamera.CFrame.LookVector);
    interface.AbilityService.Ability:Fire(script.Name);
end;