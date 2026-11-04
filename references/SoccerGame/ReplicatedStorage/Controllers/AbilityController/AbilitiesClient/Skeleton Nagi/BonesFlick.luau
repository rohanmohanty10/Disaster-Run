  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;

return function(u1) -- Line: 17
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), StatesController (copy)
    local BonesFlick = AbilityBalancing.BonesFlick;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u2, _, _ = AbilityUtils.getCharacter();
    local ABC = u1.ABC;
    u1:AbilityCooldown(2, BonesFlick.Cooldown);
    u1.AbilityService.Ability:Fire("BonesFlick");
    AnimationController:StopAnims();
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    StatesController.SpeedBoost = 10;
    ABC:Add(function() -- Line: 42
        -- upvalues: StatesController (ref)
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;
        StatesController.States.Ability = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "BonesFlick");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    AnimationController:GetBallTrack("BonesFlickBall"):Play();
    ABC:Add(task.delay(0.45, function() -- Line: 55
        -- upvalues: u1 (copy), ABC (copy), Character (copy), BonesFlick (copy), AbilityUtils (ref), u2 (copy)
        u1.AbilityService.Ability:Fire("BonesFlick", true);
        ABC:Connect(u1.AbilityService.Ability, function(p3, p4) -- Line: 58
            -- upvalues: Character (ref), BonesFlick (ref), u1 (ref), AbilityUtils (ref), u2 (ref), ABC (ref)
            p3.AssemblyLinearVelocity = (Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.75, 0)) * (BonesFlick.TravelDistance + 20);
            u1.BallController:DragBall(p3);
            local v5, v6 = AbilityUtils.FastDashTo(Character, (u2.CFrame * CFrame.new(0, 0, -BonesFlick.TravelDistance)).Position, 2, 0.6);
            ABC:Add(v5);
            ABC:Add(v6);
        end);
    end));
    task.delay(1.5, function() -- Line: 70
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;