 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6, p7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), RunService (copy), TweenService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.Network;
    local Closest = p7.Closest;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    local u8 = u3:PlayChar("Cyber", "Reach", Enum.AnimationPriority.Action3, true);
    u1.Ability:Fire("Implant", {
        State = "Reach",
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u6.AC:Add(BodyGyro);
    local Shiftlock = u6.CameraController.Shiftlock;
    u6.CameraController:SetShiftlock(false);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 275;
    u6.AC:Add(NumberValue);
    local Position = Closest.HumanoidRootPart.Position;
    local Unit = (Position + Closest.HumanoidRootPart.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
    local u9 = Position;
    local u10 = false;

    local function EndAbility() -- Line: 73
        -- upvalues: u8 (copy), u6 (copy), u2 (ref), Shiftlock (copy)
        u8:Stop(0.5);
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;

        if not u6.CameraController.Shiftlock then
            u6.CameraController:SetShiftlock(Shiftlock);
        end;
    end;

    u6.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 83
        -- upvalues: Closest (copy), u8 (copy), u6 (copy), u2 (ref), Shiftlock (copy), Position (ref), Unit (ref), HumanoidRootPart (copy), u9 (ref), BodyGyro (copy), u10 (ref), LinearVelocity (copy), NumberValue (copy)
        if not Closest then
            u8:Stop(0.5);
            u6.AC:Clean();
            u2.States.Ability = false;
            u2.States.NoWalk = false;

            if not u6.CameraController.Shiftlock then
                u6.CameraController:SetShiftlock(Shiftlock);
            end;
        end;

        Position = Closest.HumanoidRootPart.Position;
        Unit = (Position + Closest.HumanoidRootPart.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
        u9 = Position;
        BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, u9);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(u9.X, HumanoidRootPart.Position.Y, u9.Z)));

        if u10 then
            LinearVelocity.VectorVelocity = Unit * NumberValue.Value * Vector3.new(1, 0, 1);

            if (HumanoidRootPart.Position - Position).Magnitude < 8 then
                u8:Stop(0.5);
                u6.AC:Clean();
                u2.States.Ability = false;
                u2.States.NoWalk = false;

                if not u6.CameraController.Shiftlock then
                    u6.CameraController:SetShiftlock(Shiftlock);
                end;
            end;
        end;
    end);
    task.wait(0.8333333333333334);
    u10 = true;
    TweenService:Create(NumberValue, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine), {
        Value = 1
    }):Play();
    u6.AC:Add(task.delay(0.6666666666666666, EndAbility));
end;