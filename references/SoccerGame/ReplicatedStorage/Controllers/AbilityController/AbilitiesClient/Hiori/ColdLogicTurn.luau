  

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
    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface:AbilityCooldown(1, 3);
    local ABC = interface.ABC;
    local Character, u1, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    AnimationController:GetTrack("Abilities", "ColdLogicTurn"):Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u1;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    game:GetService("Debris"):AddItem(BodyVelocity, 0.7);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = u1;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    game:GetService("Debris"):AddItem(BodyGyro, 0.7);
    local u2 = true;
    task.spawn(function() -- Line: 57
        -- upvalues: BodyVelocity (copy), u2 (ref), u1 (copy)
        while BodyVelocity and u2 do
            BodyVelocity.Velocity = u1.CFrame.LookVector * 50;
            task.wait();
        end;
    end);
    ABC:Add(task.delay(0.7, function() -- Line: 64
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v3, v4 = AbilityUtils.FastDashTo(Character, u1.Position + u1.CFrame.RightVector * 30, 2, 0.4);
        ABC:Add(v3);
        ABC:Add(v4);
    end));
    ABC:Add(task.delay(1.8, function() -- Line: 76
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v5, v6 = AbilityUtils.FastDashTo(Character, u1.Position + -u1.CFrame.RightVector * 30, 2, 0.3);
        ABC:Add(v5);
        ABC:Add(v6);
    end));
    ABC:Add(function() -- Line: 88
        -- upvalues: BodyVelocity (copy), BodyGyro (copy), ABC (copy), u2 (ref), StatesController (ref)
        BodyVelocity:Destroy();
        BodyGyro:Destroy();
        ABC:Destroy();
        u2 = false;
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
    end);
    interface.LinkPass = true;
    interface.AbilityService.Ability:Fire("ColdLogicTurn");
    ABC:Add(task.delay(2.85, function() -- Line: 102
        -- upvalues: interface (ref), u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        interface.AbilityService.Ability:Fire("ColdLogicTurn", true);
        local v7, v8 = AbilityUtils.FastDashTo(Character, u1.Position + u1.CFrame.LookVector * 30, 2, 0.15);
        ABC:Add(v7);
        ABC:Add(v8);
    end));
    ABC:Add(task.delay(3, function() -- Line: 116
        -- upvalues: ABC (copy), interface (ref), ScissorKicks (ref)
        ABC:Clean();
        task.wait(2);

        if interface.LinkPass == true then
            interface.LinkPass = false;
            interface:AbilityCooldown(1, ScissorKicks.Cooldown);
        end;
    end));
end;