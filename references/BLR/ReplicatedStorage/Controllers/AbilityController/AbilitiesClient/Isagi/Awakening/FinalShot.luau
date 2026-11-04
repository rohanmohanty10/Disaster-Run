  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 11
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), AbilityUtils (copy), interface (copy)
    local FinalShot = AbilityBalancing.FinalShot;

    if LocalPlayer.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, FinalShot, 20, 3, true, LookVector);
end;