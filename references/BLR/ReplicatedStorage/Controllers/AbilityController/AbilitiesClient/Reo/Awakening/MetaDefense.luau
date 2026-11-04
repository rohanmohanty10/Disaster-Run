  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 13
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local MetaDefense = AbilityBalancing.MetaDefense;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.ballHolderInRange(LocalPlayer, MetaDefense.EnemyRange) and AbilityUtils.rules.slotReady(2)))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    interface.MetaDefenseUsed = true;
    AbilityUtils.clientCutsceneSkill(interface, MetaDefense, 8, 2, false);
end;