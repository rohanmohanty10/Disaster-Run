  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 19
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local DarkHorse = AbilityBalancing.DarkHorse;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.ballHolderInRange(LocalPlayer, DarkHorse.StealRange) and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    interface.DarkHorseUsed = true;
    AbilityUtils.clientCutsceneSkill(interface, DarkHorse, 12, 2, false);
end;