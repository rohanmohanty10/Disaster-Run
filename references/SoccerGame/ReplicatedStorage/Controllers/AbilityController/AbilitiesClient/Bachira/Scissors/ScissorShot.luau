  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
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
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local ScissorShot = require(ReplicatedStorage.AbilityBalancing).ScissorShot;

return function() -- Line: 29
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy), ScissorShot (copy), StatesController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "ScissorShot"):Play();
    interface.ScissorShot = false;
    interface:AbilityCooldown(2, ScissorShot.Cooldown);
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("ScissorShot");
    ABC:Add(AbilityUtils.execute.shot(ScissorShot));
    ABC:Add(function() -- Line: 54
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(1, function() -- Line: 59
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;