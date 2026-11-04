  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 11
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local TwoStepsBehindShot = AbilityBalancing.TwoStepsBehindShot;

    if not (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, TwoStepsBehindShot, 12, 3, true, workspace.CurrentCamera.CFrame.LookVector);
end;