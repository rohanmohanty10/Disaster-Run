  

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
local PhantomDirectShot = require(ReplicatedStorage.AbilityBalancing).PhantomDirectShot;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(p1, p2, p3) -- Line: 27
    -- upvalues: AbilityUtils (copy), AnimationController (copy), PhantomDirectShot (copy), StatesController (copy)
    if not (AbilityUtils.rules.grounded(p2) and (AbilityUtils.rules.onball(p2) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = p1.ABC;

    if ABC then
        ABC:Clean();
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "PhantomDirectShot"):Play();
    p1:AbilityCooldown(1, PhantomDirectShot.Cooldown);
    StatesController.States.Ability = true;
    p1.AbilityService.Ability:Fire("PhantomDirectShot");
    ABC:Add(AbilityUtils.execute.shot(PhantomDirectShot));
    ABC:Add(function() -- Line: 50
        -- upvalues: ABC (copy), StatesController (ref)
        print("Cleaned");
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(1, function() -- Line: 56
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;