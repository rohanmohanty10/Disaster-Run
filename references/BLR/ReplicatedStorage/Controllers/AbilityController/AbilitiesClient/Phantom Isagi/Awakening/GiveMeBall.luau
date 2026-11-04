  

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
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);

return function(p1, p2, p3) -- Line: 28
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), RunService (copy)
    local GiveMeBall = AbilityBalancing.GiveMeBall;
    local v4 = AbilityUtils.rules.enemyTarget(25, true);

    if not (v4 and (AbilityUtils.rules.grounded() and (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(1)))) then
        return;
    end;

    if AnimationController:GetTrack("Abilities", "PhantomStep").IsPlaying then
        return;
    end;

    if RunService:IsStudio() then
        v4 = nil;
    end;

    p1.AbilityService.Ability:Fire("GiveMeBall", v4);
    AbilityUtils.clientCutsceneSkill(p1, GiveMeBall, 18, 1, true, workspace.CurrentCamera.CFrame.LookVector);
end;