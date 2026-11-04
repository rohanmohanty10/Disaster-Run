 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
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
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 19, Name: Shammgod
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), TweenService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.CameraController;
    local _ = p6.Network;
    local v7 = p6:CheckInfront(25);

    if v7 == nil then
        p6:ResetCD(2);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if p6.MovementController.States.PumpFake then
        p6:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if not p6.Shammgod then
        p6.Shammgod = 2;
    end;

    p6.Shammgod = p6.Shammgod - 1;
    u2.States.Ability = true;
    u3:StopAll();
    u3:PlayChar("BasketballGod", "Shammgod", Enum.AnimationPriority.Action3);
    u3:PlayBall("BasketballGod", "ShammgodBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Shammgod", {
        TimeSent = workspace:GetServerTimeNow(),
        OtherChar = v7,
        Number = p6.Shammgod
    });

    if p6.Shammgod > 0 then
        if LocalPlayer.Style.Value == "BasketballGod" then
            p6:ResetCD(2);
            Effects:Popup("One more use left!");
        end;
    else
        p6.Shammgod = 2;
    end;

    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000);
    BodyGyro.Parent = HumanoidRootPart;
    p6.AC:Add(LinearVelocity);
    p6.AC:Add(BodyGyro);
    local v8 = HumanoidRootPart.CFrame.RightVector / 1.25;
    local Unit = (v7.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit;
    local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);
    LinearVelocity.VectorVelocity = (Vector3_new_ret + v8) * 50;
    task.wait(0.3);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = (Vector3_new_ret + v8) * 25
    }):Play();
    task.wait(0.3);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = -v8 * 250
    }):Play();
    task.wait(0.2);
    p6.AC:Clean();
    u2.States.Ability = false;
end;