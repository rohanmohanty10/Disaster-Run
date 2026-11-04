  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 19
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local EffortlessMiracle = AbilityBalancing.EffortlessMiracle;

    if not (AbilityUtils.rules.airBall(LocalPlayer) and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    interface.UsedEffortless = true;
    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, EffortlessMiracle, 16, 2, true, workspace.CurrentCamera.CFrame.LookVector);
end;