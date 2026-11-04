 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
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
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), RunService (copy), TweenService (copy)
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

    Effects:Popup("Dribble past and bench nearby opponents when in range.");
    u4.States.Ability = true;
    u3.Ability:Fire("Bench", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local u9 = Vector3.new(0, 0, 0);
    local NumberValue = Instance.new("NumberValue");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(NumberValue);
    u8.AC:Add(LinearVelocity);
    task.delay(1.6666666666666667, function() -- Line: 58
        -- upvalues: u8 (copy), u4 (ref)
        u8.AC:Clean();
        u4.States.Ability = false;
    end);
    u8.AC:Connect(RunService.Heartbeat, function() -- Line: 63
        -- upvalues: u9 (ref), LinearVelocity (copy), NumberValue (copy)
        if u9.Magnitude > 0 then
            LinearVelocity.VectorVelocity = u9.Unit * NumberValue.Value;
        end;
    end);
    u5:StopAll();
    u5:PlayChar("Referee", "Bench", Enum.AnimationPriority.Action3);
    u5:PlayBall("Referee", "BenchBall", Enum.AnimationPriority.Action3);
    u9 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);
    NumberValue.Value = 45;
    TweenService:Create(NumberValue, TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Value = 90
    }):Play();
    task.wait(0.36666666666666664);
    u9 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) + HumanoidRootPart.CFrame.RightVector * Vector3.new(1, 0, 1);
    TweenService:Create(NumberValue, TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 5
    }):Play();
    task.wait(0.36666666666666664);
    u9 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) + -HumanoidRootPart.CFrame.RightVector * Vector3.new(5, 0, 5);
    NumberValue.Value = 90;
    TweenService:Create(NumberValue, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Value = 5
    }):Play();
    task.wait(0.3333333333333333);
    u9 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) + HumanoidRootPart.CFrame.RightVector * Vector3.new(0.5, 0, 0.5);
    NumberValue.Value = 135;
    TweenService:Create(NumberValue, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 5
    }):Play();
end;