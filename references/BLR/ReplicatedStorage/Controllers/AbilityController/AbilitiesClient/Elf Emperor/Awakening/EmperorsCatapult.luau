  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 32
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), RunService (copy), interface (copy)
    local EmperorsCatapult = AbilityBalancing.EmperorsCatapult;
    local v1 = AbilityUtils.rules.enemyTarget(EmperorsCatapult.StealRange, true);

    if not (v1 and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer) and AbilityUtils.rules.slotReady(2)))) then
        return;
    end;

    if RunService:IsStudio() then
        v1 = nil;
    end;

    interface.AbilityService.Ability:Fire("EmperorsCatapult", v1);
    AbilityUtils.clientCutsceneSkill(interface, EmperorsCatapult, 20, 2, false);
end;