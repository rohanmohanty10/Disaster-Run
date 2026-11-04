  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 16
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), AbilityBalancing (copy), interface (copy), AnimationController (copy), StatesController (copy), BallController (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(2) and AbilityUtils.rules.onball(LocalPlayer, true))) then
        return;
    end;

    local ButterflyLift = AbilityBalancing.ButterflyLift;
    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    interface.ButterflyLift = nil;
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "ButterflyLift"):Play();
    AnimationController:GetBallTrack("ButterflyLiftBall"):Play();
    interface:AbilityCooldown(2, ButterflyLift.Cooldown);
    StatesController.OwnWalkState = true;
    StatesController.States.Ability = true;
    StatesController.SpeedBoost = ButterflyLift.MoveSpeedValue;
    interface.AbilityService.Ability:Fire("ButterflyLift");
    ABC:Connect(interface.AbilityService.Ability, function(p2, p3) -- Line: 42
        -- upvalues: u1 (copy), ButterflyLift (copy), BallController (ref), AbilityUtils (ref), Character (copy), ABC (copy)
        local LookVector = u1.CFrame.LookVector;
        p2.AssemblyLinearVelocity = (LookVector + Vector3.new(0, 0.75, 0)) * ButterflyLift.ShotPower;
        BallController:DragBall(p2);
        local v4, v5 = AbilityUtils.FastDashTo(Character, u1.Position + LookVector * ButterflyLift.TravelDistance, 2, 0.6);
        ABC:Add(v4);
        ABC:Add(v5);
        task.wait(0.6);
        ABC:Clean();
    end);
    ABC:Add(function() -- Line: 63
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
    end);
    task.delay(1, function() -- Line: 70
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;