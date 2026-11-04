  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 14
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), AbilityBalancing (copy), interface (copy), AnimationController (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(2) and AbilityUtils.rules.onball(LocalPlayer, true))) then
        return;
    end;

    local ButterflyRoulette = AbilityBalancing.ButterflyRoulette;
    local v1 = AbilityUtils.rules.enemyTarget(ButterflyRoulette.ActivationRangePlayer);

    if not v1 then
        return;
    end;

    interface:AbilityCooldown(2, 1.5);
    local _ = interface.ABC;
    local _, _, _, _ = AbilityUtils.getCharacter();
    interface.AbilityUsed = tick() + 1;
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "ButterflyRoulette"):Play();
    AnimationController:GetBallTrack("ButterflyRouletteBall"):Play();
    interface.AbilityService.Ability:Fire("ButterflyRoulette", v1);
    interface.ButterflyLift = true;
    task.delay(3, function() -- Line: 41
        -- upvalues: interface (ref), ButterflyRoulette (copy)
        if interface.ButterflyLift then
            interface:AbilityCooldown(2, ButterflyRoulette.Cooldown);
            interface.ButterflyLift = nil;
        end;
    end);
end;