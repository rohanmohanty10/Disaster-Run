  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.AbilityUtils);
local DemonicShot = require(ReplicatedStorage.AbilityBalancing).DemonicShot;

return function(u1, p2, u3) -- Line: 16, Name: DemonicShot
    -- upvalues: DemonicShot (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    local _ = u3.HumanoidRootPart;
    u1:AbilityCooldown("1", DemonicShot.Cooldown);
    u3:SetAttribute("DemonicDribble", nil);
    u1.Animations:StopAnims();
    local u4 = false;
    u1.StatesController.States.Ability = true;
    task.delay(5, function() -- Line: 30
        -- upvalues: u4 (ref), u1 (copy)
        if u4 == false then
            u1.StatesController.States.Ability = false;
        end;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Ball.ShidouDrive.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ShidouDrive:Play();
    u1.Animations.Ball.ShidouDrive:AdjustSpeed(0.8);
    u1.Animations.Abilities.ShidouDrive.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ShidouDrive:Play();
    u1.Animations.Abilities.ShidouDrive:AdjustSpeed(0.8);
    u1:AutoCharacterRotateToCamera(true);
    u1.AbilityService.Ability:Fire("DemonicShot");
    local _ = u1.Camera.Shiftlock;
    local _ = u3.HumanoidRootPart.CFrame.LookVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 53
        -- upvalues: u1 (copy), DemonicShot (ref)
        u1.ABC:Clean();
        p5.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + DemonicShot.ShotTiltVector) * DemonicShot.ShotPower;
        u1.BallController:DragBall(p5);
    end);
    u1.ABC:Add(function() -- Line: 60
        -- upvalues: u1 (copy), u4 (ref), u3 (copy)
        u1:AutoCharacterRotateToCamera(false);
        u4 = true;
        u3.HumanoidRootPart.Anchored = false;
        u1.StatesController.States.Ability = false;
    end);
end;