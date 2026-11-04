  

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
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy)
    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        local BeeFlick = AbilityBalancing.BeeFlick;
        interface:AbilityCooldown(1, BeeFlick.Cooldown);
        local ABC = interface.ABC;
        local Character, u1, v2, _ = AbilityUtils.getCharacter();
        local Unit = v2.MoveDirection.Unit;

        if Unit.Magnitude <= 0 or u1.Velocity.Magnitude <= 0.1 then
            Unit = u1.CFrame.LookVector;
        end;

        StatesController.States.Ability = true;
        StatesController.OwnWalkState = true;
        local Track = AnimationController:GetTrack("Abilities", "BeeFlick");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        interface.AbilityService.Ability:Fire("BeeFlick");
        ABC:Add(function() -- Line: 61
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
            StatesController.OwnWalkState = false;
        end);
        task.wait(0.2);
        interface.AbilityService.Ability:Fire("BeeFlick", true);
        ABC:Connect(interface.AbilityService.Ability, function(p3, p4) -- Line: 71
            -- upvalues: Unit (ref), BeeFlick (copy), BallController (ref), u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            Unit = Vector3.new(Unit.X, 0, Unit.Z);
            local v5 = -Unit;
            p3.AssemblyLinearVelocity = (-v5 + Vector3.new(0, 0.5, 0)) * (BeeFlick.TravelDistance + 30);
            BallController:DragBall(p3);
            Unit = Vector3.new(Unit.X, 0, Unit.Z);
            local v6, v7 = AbilityUtils.FastDashTo(Character, u1.Position + v5 * -BeeFlick.TravelDistance, 2, 0.5);
            ABC:Add(v6);
            ABC:Add(v7);
            task.wait(0.5);
            ABC:Clean();
        end);
        ABC:Add(task.delay(1, function() -- Line: 94
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;