 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
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

return function(p6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), TweenService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.Network;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("Cyber", "Dash Through", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("OGImplant", {
        State = "Dash Through",
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    p6.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    p6.AC:Add(BodyGyro);
    task.wait(0.8333333333333334);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    LinearVelocity.VectorVelocity = LookVector * 500 * Vector3.new(1, 0, 1);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine), {
        VectorVelocity = LookVector * 1 * Vector3.new(1, 0, 1)
    }):Play();
    task.wait(0.6666666666666666);
    p6.AC:Clean();
    u2.States.Ability = false;
    u2.States.NoWalk = false;
end;