  

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
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local FrostShot = require(ReplicatedStorage.AbilityBalancing).FrostShot;
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function() -- Line: 30
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy), FrostShot (copy), StatesController (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    interface.FrostShot = nil;
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "FrostShot"):Play();
    AnimationController:GetBallTrack("FrostShotBall"):Play();
    interface:AbilityCooldown(1, FrostShot.Cooldown);
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("FrostShot");
    ABC:Add(AbilityUtils.execute.shot(FrostShot));
    ABC:Add(function() -- Line: 55
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(2, function() -- Line: 60
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;