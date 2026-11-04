  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local SnuffyCutsceneRules = require(ReplicatedStorage.Shared.SnuffyCutsceneRules);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 10
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), SnuffyCutsceneRules (copy), interface (copy)
    local SnuffyRationalPerfectDefense = AbilityBalancing.SnuffyRationalPerfectDefense;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.isAwakened(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.slotReady(1) and SnuffyCutsceneRules.ballFor(LocalPlayer, SnuffyRationalPerfectDefense.BallRange, true))))) then
        return false;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    interface:AbilityCooldown(1, SnuffyRationalPerfectDefense.Cooldown);
    AbilityUtils.clientCutsceneSkill(interface, SnuffyRationalPerfectDefense, SnuffyRationalPerfectDefense.Duration + 3, nil, false);

    return true;
end;