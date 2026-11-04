  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 21
    -- upvalues: AbilityBalancing (copy), RunService (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local FastShot = AbilityBalancing.FastShot;

    if RunService:IsStudio() then
        print("[FastShot][client] B pressed — running FastShot fn; onball =", AbilityUtils.checks.onball(LocalPlayer), "| slotReady =", AbilityUtils.rules.slotReady(3));
    end;

    if not (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, FastShot, 12, 3, true, workspace.CurrentCamera.CFrame.LookVector);
end;