  

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

return function(p1) -- Line: 27
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), RunService (copy)
    local ScarletOrbit = AbilityBalancing.ScarletOrbit;
    local v2 = AbilityUtils.rules.enemyTarget(25, false);

    if not (v2 and (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)))) then
        return;
    end;

    if RunService:IsStudio() then
        v2 = nil;
    end;

    p1.AbilityService.Ability:Fire("ScarletOrbit", v2);
    ScarletOrbit.ShotDirection = workspace.CurrentCamera.CFrame.LookVector;
    AbilityUtils.clientCutsceneSkill(p1, ScarletOrbit, 20, 3, true);
end;