  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;

return function(u1) -- Line: 22
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy)
    local VelocityShot = AbilityBalancing.VelocityShot;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    local Attribute = Character:GetAttribute("VelocityShotPower");
    u1.StatesController.NoJump = true;
    u1.StatesController.States.Ability = true;
    u1:AbilityCooldown(2, VelocityShot.Cooldown);
    Character:SetAttribute("VelocityShot", nil);
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "VelocityShotNEW");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    AnimationController:GetBallTrack("LokiVelocityShot"):Play();
    local ABC = u1.ABC;
    u1.AbilityService.Ability:Fire("VelocityShot");
    ABC:Connect(u1.AbilityService.Ability, function(p2) -- Line: 56
        -- upvalues: u1 (copy), VelocityShot (copy), Attribute (copy)
        print("Received");
        u1.StatesController.NoJump = false;
        u1.StatesController.States.Ability = false;
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
        local Y = VelocityShot.ShotTiltVector.Y;

        if LookVector.Y < Y then
            LookVector = Vector3.new(LookVector.X, Y, LookVector.Z);
        end;

        p2.AssemblyLinearVelocity = LookVector * math.lerp(VelocityShot.ShotPower, VelocityShot.ShotPowerMax, Attribute);
        u1.BallController:DragBall(p2);
    end);
    ABC:Add(function() -- Line: 76
        -- upvalues: u1 (copy), Track (copy)
        print("Cleaning");
        u1.StatesController.NoJump = false;
        u1.StatesController.States.Ability = false;
        Track:Stop();
    end);
    task.delay(2, function() -- Line: 83
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;