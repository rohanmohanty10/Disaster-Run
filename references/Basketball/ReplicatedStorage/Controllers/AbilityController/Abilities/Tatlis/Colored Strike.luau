 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
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

return function(u8) -- Line: 22, Name: ColoredStrike
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u3 = u8.AbilityService;
    u5 = u8.Animations;
    u4 = u8.MovementController;
    u6 = u8.BallController;
    u7 = u8.CameraController;
    u1 = u8.Network;
    u2 = u8.BallService;

    if u1.CharValues.HasBall then
        if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
            u8:ResetCD(2);
            Effects:Popup("Can\'t use in air!");

            return;
        end;

        u4.States.Ability = true;
        u5:StopAll();
        u5:PlayChar("Tatlis", "ColoredStrikeOn", Enum.AnimationPriority.Action3, false);
        u5:PlayBall("Tatlis", "ColoredStrikeOnBall", Enum.AnimationPriority.Action3, false);
        u3.Ability:Fire("Colored Strike", {
            TimeSent = workspace:GetServerTimeNow()
        });
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        local CFrame2 = HumanoidRootPart.CFrame;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
        BodyGyro.CFrame = CFrame.new(CFrame2.LookVector);
        u8.AC:Add(BodyGyro);
        u8.AC:Add(LinearVelocity);
        u8.AC:Add(task.delay(1.25, function() -- Line: 69
            -- upvalues: u4 (ref), u8 (copy)
            u4.States.Ability = false;
            u8.AC:Clean();
        end));
        task.wait(0.35);
        local NumberValue = Instance.new("NumberValue");
        u8.AC:Add(NumberValue);
        NumberValue.Value = 200;
        game:GetService("TweenService"):Create(NumberValue, TweenInfo.new(0.65, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
            Value = 0
        }):Play();
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 83
            -- upvalues: u1 (ref), u4 (ref), u8 (copy), LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy)
            if u1.CharValues.HasBall then
                LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * NumberValue.Value;

                return;
            end;

            u4.States.Ability = false;
            u4.States.PumpFake = false;
            u8.AC:Clean();
        end);
        u8.AC:Add(task.delay(0.5, function() -- Line: 94
            -- upvalues: u4 (ref)
            u4.States.PumpFake = true;
        end));

        return;
    end;

    if ReplicatedStorage.Cooldowns.ColoredStrikeCD.Value > workspace:GetServerTimeNow() then
        local v9 = ReplicatedStorage.Cooldowns.ColoredStrikeCD.Value - workspace:GetServerTimeNow();
        Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v9)} seconds`, 2);
        u8:ResetCD(2);

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        u8:ResetCD(2);
        Effects:Popup("Can\'t use in air!");

        return;
    end;

    Effects:Popup("GUARANTEEED STEAL!");
    u4.States.Ability = true;
    u5:StopAll();
    local u10 = u5:PlayChar("Tatlis", "ColoredStrikeOff", Enum.AnimationPriority.Action3, true);
    u10:AdjustSpeed(1.35);
    u3.Ability:Fire("Colored Strike", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = CFrame.new(HumanoidRootPart.CFrame.LookVector);
    u8.AC:Add(BodyGyro);
    u8.AC:Add(LinearVelocity);
    local u11 = 0;
    local u12 = 0;
    local u13 = 0;
    u8.AC:Add(task.delay(3.9385185185185185, function() -- Line: 139
        -- upvalues: u4 (ref), u8 (copy)
        u4.States.Ability = false;
        u8.AC:Clean();
    end));
    u8.AC:Connect(RunService.Heartbeat, function(p14) -- Line: 144
        -- upvalues: BodyGyro (copy), HumanoidRootPart (copy), u12 (ref), u11 (ref), u13 (ref), LinearVelocity (copy)
        BodyGyro.CFrame = CFrame.new(HumanoidRootPart.CFrame.LookVector);

        if tick() <= u12 and u11 > 0 then
            local v15 = u11 * 1.35 * ((u12 - tick()) / u13);
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * v15;
        end;
    end);
    u8.AC:Add(task.spawn(function() -- Line: 152
        -- upvalues: u1 (ref), u10 (copy), u8 (copy), u4 (ref)
        while task.wait() do
            if u1.CharValues.HasBall or u1.CharValues.Stunned then
                u10:Stop();
                u8.AC:Clean();
                u4.States.Ability = false;

                return;
            end;
        end;
    end));
    task.wait(0.30864197530864196);
    u11 = 80;
    u13 = 0.4938271604938271;
    u12 = tick() + 0.4938271604938271;
    task.wait(0.7407407407407407);
    u11 = 60;
    u13 = 0.19753086419753085;
    u12 = tick() + 0.19753086419753085;
    task.wait(0.24691358024691354);
    u11 = 60;
    u13 = 0.24691358024691354;
    u12 = tick() + 0.24691358024691354;
    task.wait(0.2716049382716049);
    u11 = 60;
    u13 = 0.2716049382716049;
    u12 = tick() + 0.2716049382716049;
    task.wait(0.5802469135802468);
    u11 = 90;
    u13 = 0.32098765432098764;
    u12 = tick() + 0.32098765432098764;
    task.wait(0.32098765432098764);
    task.wait(0.7407407407407407);
    u11 = 90;
    u13 = 0.4938271604938271;
    u12 = tick() + 0.4938271604938271;
end;