 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 21
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u3 = u8.AbilityService;
    u5 = u8.Animations;
    u4 = u8.MovementController;
    u6 = u8.BallController;
    u7 = u8.CameraController;
    u1 = u8.Network;
    u2 = u8.BallService;

    if u4.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u8:ResetCD(2);

        return;
    end;

    u4.States.Ability = true;
    u3.Ability:Fire("Laugh Breaker", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local CFrame = HumanoidRootPart.CFrame;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    BodyGyro.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(BodyGyro);
    task.delay(1.4166666666666667, function() -- Line: 61
        -- upvalues: u8 (copy), u4 (ref)
        u8.AC:Clean();
        u4.States.Ability = false;
    end);
    u5:StopAll();
    u5:PlayChar("Joker", "LaughBreaker", Enum.AnimationPriority.Action3);
    u5:PlayBall("Joker", "LaughBreakerBall", Enum.AnimationPriority.Action3);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (CFrame.LookVector * 50 + CFrame.RightVector * -50) * Vector3.new(1, 0, 1)
    }):Play();
    task.wait(0.18333333333333332);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = (CFrame.LookVector * 100 + CFrame.RightVector * 100) * Vector3.new(1, 0, 1)
    }):Play();
    task.wait(0.3);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.wait(0.35);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (CFrame.LookVector * 50 + CFrame.RightVector * -50) * Vector3.new(1, 0, 1)
    }):Play();
    task.wait(0.23333333333333334);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
end;