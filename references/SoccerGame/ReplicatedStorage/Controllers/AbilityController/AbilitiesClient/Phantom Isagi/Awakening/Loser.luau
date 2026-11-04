  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);

return function(p1, p2, p3) -- Line: 28
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), RunService (copy)
    local Loser = AbilityBalancing.Loser;
    local v4 = AbilityUtils.rules.enemyTarget(25, true);

    if not (v4 and (AbilityUtils.rules.grounded() and (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(3)))) then
        return;
    end;

    if RunService:IsStudio() then
        v4 = nil;
    end;

    p1.AbilityService.Ability:Fire("Loser", v4);
    AbilityUtils.clientCutsceneSkill(p1, Loser, 18, 3, false);
end;