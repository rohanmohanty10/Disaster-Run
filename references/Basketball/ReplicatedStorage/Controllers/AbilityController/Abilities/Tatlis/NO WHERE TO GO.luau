 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
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

return function(u8) -- Line: 22, Name: NoNameYet
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
    local u9 = u8:CheckInfront(70);

    if not u9 then
        Effects:Popup("Need someone close infront of you!");
        u8:ResetCD(4);

        return;
    end;

    if (u9.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < 30 then
        Effects:Popup("Player is too close!");
        u8:ResetCD(4);

        return;
    end;

    if u8.PaintUses then
        if u8.PaintUses >= 2 then
            Effects:Popup("No more uses!", 4);

            return;
        end;
    else
        u8.PaintUses = 0;
    end;

    if not u9 then
        Effects:Popup("No enemy near you!", 4);
        u8:ResetCD(4);

        return;
    end;

    u4.States.Ability = true;
    u5:StopAll();
    u8.PaintUses = u8.PaintUses + 1;
    Effects:Popup((`{2 - u8.PaintUses} USES LEFT`));

    if u8.PaintUses >= 2 then
        task.delay(40, function() -- Line: 65
            -- upvalues: u8 (copy)
            u8.PaintUses = 0;
        end);
    else
        u8:ResetCD(4);
    end;

    u4.Boost = 10;
    task.delay(2, function() -- Line: 74
        -- upvalues: u4 (ref)
        u4.Boost = 0;
    end);
    u8.AC:Add(function() -- Line: 78
        -- upvalues: u4 (ref)
        u4.States.Boost = 0;
    end);

    if u1.CharValues.HasBall then
        u4.States.Ability = true;
        u4.States.NoWalk = true;
        u5:StopAll();
        u5:PlayChar("Tatlis", "Snap", Enum.AnimationPriority.Action3);
        u5:PlayBall("Tatlis", "SnapBall", Enum.AnimationPriority.Action3);
        u3.Ability:Fire("NO WHERE TO GO", {
            TimeSent = workspace:GetServerTimeNow(),
            Closest = u9
        });
        task.delay(0.5, function() -- Line: 93
            -- upvalues: u4 (ref)
            u4.States.Ability = false;
            u4.States.NoWalk = false;
        end);

        return;
    end;

    u4.Boost = 10;
    u8.AC:Add(function() -- Line: 102
        -- upvalues: u4 (ref)
        u4.States.Boost = 0;
    end);
    local Unit = (u9.HumanoidRootPart.Position + u9.HumanoidRootPart.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
    local Position = u9.HumanoidRootPart.Position;
    local u10 = 160;
    local u11 = u10 * Vector3.new(1, 0, 1);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "BodyGyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.P = 1250;
    BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, Position);
    BodyGyro.Parent = HumanoidRootPart;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(BodyGyro);
    u3.Ability:Fire("NO WHERE TO GO", {
        TimeSent = workspace:GetServerTimeNow(),
        Closest = u9
    });

    local function End() -- Line: 131
        -- upvalues: u8 (copy), u5 (ref), HumanoidRootPart (copy), u4 (ref)
        u8.AC:Clean();
        u5:PlayChar("Tatlis", "NoNameYet", Enum.AnimationPriority.Action3);
        local LinearVelocity2 = Instance.new("LinearVelocity");
        LinearVelocity2.MaxForce = (1 / 0);
        LinearVelocity2.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity2.Parent = HumanoidRootPart;
        LinearVelocity2.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -80 + Vector3.new(0, 140, 0);
        game:GetService("TweenService"):Create(LinearVelocity2, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.5);
        LinearVelocity2:Destroy();
        u4.States.Ability = false;

        if u8.PaintUses >= 3 then
            return;
        end;

        u8:ResetCD(4);
    end;

    u8.AC:Add(task.delay(1.5, function() -- Line: 151
        -- upvalues: u8 (copy), u4 (ref)
        u8.AC:Clean();
        u4.States.Ability = false;

        if u8.PaintUses >= 3 then
            return;
        end;

        u8:ResetCD(4);
    end));
    u8.AC:Connect(RunService.Heartbeat, function(p12) -- Line: 160
        -- upvalues: Unit (ref), u9 (copy), HumanoidRootPart (copy), BodyGyro (copy), Position (ref), u10 (ref), TweenService (ref), u11 (ref), LinearVelocity (copy), End (copy)
        Unit = (u9.HumanoidRootPart.Position + u9.HumanoidRootPart.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
        BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, Position);
        Position = u9.HumanoidRootPart.Position;
        u10 = u10 - p12 * TweenService:GetValue(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 25;
        u11 = u10 * Vector3.new(1, 0, 1);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
        LinearVelocity.VectorVelocity = Unit * u11;

        if (HumanoidRootPart.Position - u9.HumanoidRootPart.Position).Magnitude < 10 then
            End();
        end;
    end);
end;