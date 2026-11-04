  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
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
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local StingerShot = require(ReplicatedStorage.AbilityBalancing).StingerShot;
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 30
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), AnimationController (copy), StingerShot (copy), StatesController (copy)
    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "StingerShot"):Play();
    AnimationController:GetBallTrack("MonsterShotBall"):Play();
    interface:AbilityCooldown(1, StingerShot.Cooldown);
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("StingerShot");
    ABC:Add(AbilityUtils.execute.shot(StingerShot));
    ABC:Add(function() -- Line: 53
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(1, function() -- Line: 58
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end));
end;