 
 

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
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Mouse = LocalPlayer:GetMouse();

return function(u6) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), TweenService (copy), Mouse (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        local v7 = Mouse.Target and Mouse.Target:FindFirstAncestorOfClass("Model");

        if not (v7 and (v7:FindFirstChild("Humanoid") and v7:FindFirstChild("HumanoidRootPart"))) then
            v7 = nil;
        end;

        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if PlayerPossessingBall and (PlayerPossessingBall.Team ~= LocalPlayer.Team and (PlayerPossessingBall.Character and (PlayerPossessingBall.Character:FindFirstChild("HumanoidRootPart") and (PlayerPossessingBall.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 50))) then
            v7 = PlayerPossessingBall.Character;
        end;

        u1.Ability:Fire("Flag Slam", {
            State = "Slam",
            TimeSent = workspace:GetServerTimeNow(),
            Target = v7,
            Position = Mouse.Hit.Position
        });
        u2.States.Ability = true;
        task.delay(0.5333333333333333, function() -- Line: 108
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(1);

        return;
    end;

    u1.Ability:Fire("Flag Slam", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Valentine", "FlagBreaker", Enum.AnimationPriority.Action3);
    u4:PlayBall("Valentine", "FlagBreakerBall", Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 46
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u6.AC:Add(task.delay(1.5833333333333333, function() -- Line: 50
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 25;
    local NumberValue2 = Instance.new("NumberValue");
    NumberValue2.Value = 0;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(NumberValue);
    u6.AC:Add(NumberValue2);
    u6.AC:Add(LinearVelocity);
    u6.AC:Connect(RunService.Heartbeat, function() -- Line: 70
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy), NumberValue2 (copy)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value + HumanoidRootPart.CFrame.RightVector * NumberValue2.Value;
    end);
    TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 50
    }):Play();
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = -30
    }):Play();
    task.wait(0.13333333333333333);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    task.wait(0.03333333333333333);
    TweenService:Create(NumberValue2, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 45
    }):Play();
    task.wait(0.23333333333333334);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    task.wait(0.1);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = -45
    }):Play();
    task.wait(0.13333333333333333);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    task.wait(0.03333333333333333);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 30
    }):Play();
    TweenService:Create(NumberValue, TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 15
    }):Play();
    task.wait(0.13333333333333333);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    task.wait(0.25);
    NumberValue.Value = 250;
    TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 50
    }):Play();
end;