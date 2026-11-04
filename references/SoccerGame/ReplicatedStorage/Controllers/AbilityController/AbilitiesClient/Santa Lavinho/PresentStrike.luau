  

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
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: LocalPlayer (copy), AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy)
    if LocalPlayer.Character.Values.InCutscene.Value then
        return;
    end;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        local PresentStrike = AbilityBalancing.PresentStrike;
        interface:AbilityCooldown(1, PresentStrike.Cooldown);
        local ABC = interface.ABC;
        local _, _, v1, _ = AbilityUtils.getCharacter();
        local _ = v1.MoveDirection.Unit;
        StatesController.States.Ability = true;
        AnimationController:StopAnims();
        local Track = AnimationController:GetTrack("Abilities", "PresentStrike");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("PresentStrikeBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("PresentStrike");
        ABC:Add(AbilityUtils.execute.shot(PresentStrike));
        ABC:Add(function() -- Line: 65
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(1, function() -- Line: 69
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;

    print("Returned Here");
end;