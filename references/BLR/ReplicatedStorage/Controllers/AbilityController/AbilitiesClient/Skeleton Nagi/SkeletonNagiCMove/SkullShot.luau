  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local SkullShot = require(ReplicatedStorage.AbilityBalancing).SkullShot;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(p1, p2, p3) -- Line: 27
    -- upvalues: AbilityUtils (copy), SkullShot (copy), StatesController (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball(p2) and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    local ABC = p1.ABC;

    if ABC then
        ABC:Clean();
    end;

    p1:AbilityCooldown("1", SkullShot.Cooldown);
    StatesController.States.Ability = true;
    p1.Animations:StopAnims();
    AnimationController:GetTrack("Abilities", "SkullShot"):Play();
    AnimationController:GetBallTrack("SkullShotBall"):Play();
    p1.AbilityService.Ability:Fire("SkullShot");
    ABC:Add(AbilityUtils.execute.shot(SkullShot));
    ABC:Add(function() -- Line: 47
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(1, function() -- Line: 52
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;