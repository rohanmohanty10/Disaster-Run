  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
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

return function(p1, p2, p3) -- Line: 27
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy)
    local SkeletonImprisonment = AbilityBalancing.SkeletonImprisonment;

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.looseBall(p2, 50) and (AbilityUtils.rules.slotReady(1) and AbilityUtils.rules.isAwakened(p2)))) then
        return;
    end;

    p1.AbilityService.Ability:Fire("SkeletonImprisonment");
    AbilityUtils.clientCutsceneSkill(p1, SkeletonImprisonment, 20, 1, true, workspace.CurrentCamera.CFrame.LookVector);
end;