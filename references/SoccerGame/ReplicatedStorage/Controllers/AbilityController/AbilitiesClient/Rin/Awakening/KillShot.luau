  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 18
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local KillShot = AbilityBalancing.KillShot;

    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, v1 = AbilityUtils.getCharacter();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v2 = workspace_CurrentCamera and workspace_CurrentCamera.CFrame.LookVector;

    if not v2 then
        if v1 then
            v2 = v1.CFrame.LookVector;
        else
            v2 = v1;
        end;
    end;

    if not (Character and (v1 and (v2 and v2.Magnitude >= 0.001))) then
        return;
    end;

    local Unit = v2.Unit;
    interface.AbilityService.Ability:Fire(script.Name, Unit);
    AbilityUtils.clientCutsceneSkill(interface, KillShot, 15, 1, true, Unit);
end;