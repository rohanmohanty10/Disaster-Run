  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 12
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), AbilityUtils (copy), interface (copy)
    local NikoLionShot = AbilityBalancing.NikoLionShot;
    local Attribute = LocalPlayer:GetAttribute("GrantedNikoLionShotUntil");

    if not (LocalPlayer:GetAttribute("GrantedNikoLionShot") and (typeof(Attribute) == "number" and (Attribute >= workspace:GetServerTimeNow() and (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(3))))) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.LookVector;
    end;

    if workspace_CurrentCamera then
        interface.AbilityService.Ability:Fire(script.Name);
        AbilityUtils.clientCutsceneSkill(interface, NikoLionShot, 9, nil, true, workspace_CurrentCamera);

        return true;
    end;
end;