  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 19
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local v1 = AbilityBalancing["44PantherShot"];

    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, v1, 38, 1, true, workspace.CurrentCamera.CFrame.LookVector);
end;