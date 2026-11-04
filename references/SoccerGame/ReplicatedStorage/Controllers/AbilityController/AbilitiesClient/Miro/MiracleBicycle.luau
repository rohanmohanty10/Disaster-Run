  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    print("Here");
    local MiracleBicycle = AbilityBalancing.MiracleBicycle;
    interface.FlashyShot = false;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(3, MiracleBicycle.Cooldown);
    local ABC = interface.ABC;
    local _, _, v1, _ = AbilityUtils.getCharacter();
    local _ = v1.MoveDirection.Unit;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "MiracleBicycle");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("MiracleBicycleBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("MiracleBicycle");
    ABC:Add(AbilityUtils.execute.shot(MiracleBicycle));
    ABC:Add(function() -- Line: 64
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 68
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;