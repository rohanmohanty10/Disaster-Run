  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local ScissorKicks = require(ReplicatedStorage.AbilityBalancing).ScissorKicks;

return function() -- Line: 25
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), StatesController (copy), AnimationController (copy), ScissorKicks (copy)
    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    interface:AbilityCooldown(2, 1);
    local ABC = interface.ABC;
    local _, u1, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "ScissorKicks"):Play();
    AnimationController:GetBallTrack("ScissorKicksBall"):Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u1;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    game:GetService("Debris"):AddItem(BodyVelocity, 1.5);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = u1;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    game:GetService("Debris"):AddItem(BodyGyro, 1.5);
    task.spawn(function() -- Line: 54
        -- upvalues: BodyVelocity (copy), u1 (copy)
        while BodyVelocity do
            BodyVelocity.Velocity = u1.CFrame.LookVector * 60;
            task.wait();
        end;
    end);
    ABC:Add(function() -- Line: 61
        -- upvalues: BodyVelocity (copy), BodyGyro (copy), ABC (copy), StatesController (ref)
        BodyVelocity:Destroy();
        BodyGyro:Destroy();
        ABC:Destroy();
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
    end);
    task.delay(1.5, function() -- Line: 70
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
    interface.ScissorShot = true;
    interface.AbilityService.Ability:Fire("ScissorKicks");
    task.delay(2.5, function() -- Line: 78
        -- upvalues: interface (ref), ScissorKicks (ref)
        if interface.ScissorShot == true then
            interface.ScissorShot = false;
            interface:AbilityCooldown(2, ScissorKicks.Cooldown);
        end;
    end);
end;