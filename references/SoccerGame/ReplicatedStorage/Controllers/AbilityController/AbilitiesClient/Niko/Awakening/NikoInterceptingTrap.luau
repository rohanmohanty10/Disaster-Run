  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 11
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local NikoInterceptingTrap = AbilityBalancing.NikoInterceptingTrap;

    if AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.looseBall(LocalPlayer, NikoInterceptingTrap.BallRange) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.slotReady(3) and AbilityUtils.rules.isAwakened(LocalPlayer)))) then
        interface.AbilityService.Ability:Fire(script.Name);
        interface:AbilityCooldown(3, NikoInterceptingTrap.Cooldown);
        AbilityUtils.clientCutsceneSkill(interface, NikoInterceptingTrap, 8, nil, false);

        return true;
    end;
end;