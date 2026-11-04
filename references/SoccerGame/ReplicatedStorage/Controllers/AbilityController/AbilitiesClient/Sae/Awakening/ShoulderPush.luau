  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 19
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local ShoulderPush = AbilityBalancing.ShoulderPush;

    if not (AbilityUtils.rules.isAwakened(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.ballHolderInRange(LocalPlayer, ShoulderPush.EnemyRange) and AbilityUtils.rules.slotReady(1))))) then
        return;
    end;

    local v1 = AbilityUtils.findBallHolderInRange(LocalPlayer.Character, ShoulderPush.EnemyRange);

    if not v1 then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name, v1);
    AbilityUtils.clientCutsceneSkill(interface, ShoulderPush, 8, 1, false);
end;