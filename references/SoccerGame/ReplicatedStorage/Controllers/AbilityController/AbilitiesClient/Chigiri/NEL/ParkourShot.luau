  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local AbilityUtils2 = require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29
    -- upvalues: AbilityUtils (copy), AbilityUtils2 (copy), Popup (copy), LocalPlayer (copy), interface (copy), AbilityBalancing (copy), StatesController (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    if not AbilityUtils2.findNearestPlayer({
        distance = 20,
        includeGK = false,
        team = "Enemy",
        onBall = false
    }) then
        Popup.Popup(LocalPlayer, "Must be near an enemy player");

        return;
    end;

    if interface.AbilityThree - tick() < 3 then
        interface:AbilityCooldown(3, 3);
    end;

    local ParkourShot = AbilityBalancing.ParkourShot;
    interface.FlashyShot = false;
    StatesController.States.Ability = true;
    interface.ParkourShot = true;
    interface:AbilityCooldown(1, ParkourShot.Cooldown);
    local ABC = interface.ABC;
    local _, _, v1, _ = AbilityUtils.getCharacter();
    local _ = v1.MoveDirection.Unit;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "ParkourShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("ParkourShotBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("ParkourShot");
    ABC:Add(AbilityUtils.execute.shot(ParkourShot));
    ABC:Add(function() -- Line: 78
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 82
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;