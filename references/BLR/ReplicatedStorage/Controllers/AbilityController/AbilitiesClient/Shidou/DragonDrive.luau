  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, u3, p4) -- Line: 18, Name: DragonDrive
    -- upvalues: ReplicatedStorage (copy)
    local Humanoid = u3.Humanoid;

    if ReplicatedStorage.Football.Value.IFrame.Value > workspace:GetServerTimeNow() and p4 ~= "CR" then
        return;
    end;

    if p4 == "CR" then
        local v5 = tick() + 1;

        while tick() < v5 and u3.Values.HasBall.Value == false do
            task.wait();
        end;

        if u3.Values.HasBall.Value == false then
            return;
        end;
    else
        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            return;
        end;

        if u3.Values.HasBall.Value == false then
            return;
        end;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.AbilityUsed = tick() + 4;
    u1:AbilityCooldown("1", 50);
    u1.Animations:StopAnims();
    local u6 = false;
    u1.StatesController.States.Ability = true;
    task.delay(5, function() -- Line: 45
        -- upvalues: u6 (ref), u1 (copy)
        if u6 == false then
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
    u1.AbilityService.Ability:Fire("DragonDrive", p4);
    local _ = u1.Camera.Shiftlock;
    local _ = u3.HumanoidRootPart.CFrame.LookVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7) -- Line: 67
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
        p7.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 150;
        u1.BallController:DragBall(p7);
    end);
    u1.ABC:Add(function() -- Line: 74
        -- upvalues: u1 (copy), u6 (ref), u3 (copy)
        u1:AutoCharacterRotateToCamera(false);
        u6 = true;
        u3.HumanoidRootPart.Anchored = false;
        u1.StatesController.States.Ability = false;
    end);
end;