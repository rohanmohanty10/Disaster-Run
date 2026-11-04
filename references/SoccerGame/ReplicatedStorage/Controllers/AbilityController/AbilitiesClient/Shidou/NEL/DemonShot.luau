  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
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
local DemonShot = require(ReplicatedStorage.AbilityBalancing).DemonShot;
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 31
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), AnimationController (copy), DemonShot (copy), StatesController (copy)
    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "DemonShot"):Play();
    local BallTrack = AnimationController:GetBallTrack("DemonShotBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface:AbilityCooldown(3, DemonShot.Cooldown);
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("DemonShot");
    ABC:Add(AbilityUtils.execute.shot(DemonShot));
    ABC:Add(function() -- Line: 58
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(1, function() -- Line: 63
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;