  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local SnuffyCutsceneRules = require(ReplicatedStorage.Shared.SnuffyCutsceneRules);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 10
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), SnuffyCutsceneRules (copy), interface (copy)
    local SnuffyPhoenixIntercept = AbilityBalancing.SnuffyPhoenixIntercept;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.isAwakened(LocalPlayer) and (AbilityUtils.rules.slotReady(2) and SnuffyCutsceneRules.airBall(LocalPlayer, SnuffyPhoenixIntercept.BallRange)))) then
        return false;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    interface:AbilityCooldown(2, SnuffyPhoenixIntercept.Cooldown);
    AbilityUtils.clientCutsceneSkill(interface, SnuffyPhoenixIntercept, SnuffyPhoenixIntercept.Duration + 3, nil, false);

    return true;
end;