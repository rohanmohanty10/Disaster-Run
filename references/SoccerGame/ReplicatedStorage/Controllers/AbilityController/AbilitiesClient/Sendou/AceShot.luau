  

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
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), interface (copy), AbilityBalancing (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage (copy)
    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        interface:AbilityCooldown(1, 40);
        local _ = AbilityBalancing.AceShot;
        interface.FlashyShot = false;
        StatesController.States.Ability = true;
        local ABC = interface.ABC;
        local _, _, v1, _ = AbilityUtils.getCharacter();
        local _ = v1.MoveDirection.Unit;
        AnimationController:StopAnims();
        local Track = AnimationController:GetTrack("Abilities", "AceShot");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        interface.AbilityService.Ability:Fire("AceShot");
        ABC:Connect(interface.AbilityService.Ability, function(p2, p3) -- Line: 61
            -- upvalues: ABC (copy), AbilityBalancing (ref), BallController (ref), ReplicatedStorage (ref)
            print("Here");
            ABC:Clean();
            p2.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.1, 0)) * AbilityBalancing.AceShot.ShotPower;
            BallController:DragBall(ReplicatedStorage.Football.Value);
        end);
        ABC:Add(function() -- Line: 76
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(2, function() -- Line: 80
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;