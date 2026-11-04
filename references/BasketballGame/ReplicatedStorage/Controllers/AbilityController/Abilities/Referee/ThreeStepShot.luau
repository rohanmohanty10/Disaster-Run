 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u5) -- Line: 18
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), Effects (copy), RunService (copy), TweenService (copy), ReplicatedStorage (copy)
    u1 = u5.MovementController;
    u2 = u5.BallController;
    u3 = u5.AbilityService;
    u4 = u5.Animations;
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    local v6 = u5:HoopDist();

    if v6 > 150 then
        Effects:Popup("Too far away from hoop!");
        u5:ResetCD(3);

        return;
    end;

    if v6 < 50 then
        Effects:Popup("Too close to hoop!");
        u5:ResetCD(3);

        return;
    end;

    u1.States.Ability = true;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local CFrame_new_ret = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z)));
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.MaxTorque = (1 / 0);
    AlignOrientation.Responsiveness = 80;
    AlignOrientation.CFrame = CFrame_new_ret;
    AlignOrientation.Parent = HumanoidRootPart;
    local u7 = Vector3.new(0, 0, 0);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = math.clamp(v6 - 110, 0, 40) + 20;
    u5.AC:Add(LinearVelocity);
    u5.AC:Add(AlignOrientation);
    u5.AC:Add(NumberValue);
    u4:StopAll();
    u4:PlayChar("Referee", "ThreeStepShot", Enum.AnimationPriority.Action3);
    u4:PlayBall("Referee", "ThreeStepShotBall", Enum.AnimationPriority.Action3);
    u3.Ability:Fire("3-Step Shot", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u1.States.Ability = true;
    u1.States.AimAssist = true;
    u5.AC:Connect(RunService.Heartbeat, function() -- Line: 75
        -- upvalues: u7 (ref), LinearVelocity (copy), NumberValue (copy)
        if u7.Magnitude > 0 then
            LinearVelocity.VectorVelocity = u7.Unit * NumberValue.Value;
        end;
    end);
    u7 = CFrame_new_ret.LookVector * Vector3.new(1, 0, 1) + -CFrame_new_ret.RightVector * Vector3.new(1, 0, 1);
    task.wait(0.25);
    u7 = CFrame_new_ret.LookVector * Vector3.new(1, 0, 1) + CFrame_new_ret.RightVector * Vector3.new(1, 0, 1);
    task.wait(0.25);
    u7 = CFrame_new_ret.LookVector * Vector3.new(1, 0, 1) + -CFrame_new_ret.RightVector * Vector3.new(1, 0, 1);
    task.wait(0.25);
    u7 = CFrame_new_ret.LookVector * Vector3.new(1, 0, 1) + CFrame_new_ret.RightVector * Vector3.new(1, 0, 1);
    task.wait(0.25);
    u7 = -CFrame_new_ret.LookVector * Vector3.new(1, 0, 1);
    NumberValue.Value = 5;
    TweenService:Create(NumberValue, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    u5.AC:Connect(u3.Ability, function() -- Line: 101
        -- upvalues: u5 (copy), u1 (ref), ReplicatedStorage (ref), u2 (ref), Hoop (copy), HumanoidRootPart (copy)
        u5.AC:Clean();
        u1.States.AimAssist = false;
        u1.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u2:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local v8 = Hoop.Position - Value.Position;
        local v9, v10;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v9 = v8.Magnitude * 0.0455;
            v10 = 1.35;
        else
            v9 = v8.Magnitude * 0.04;
            v10 = 0.5;
        end;

        local math_log_ret = math.log(v10 + v9);
        Value.AssemblyLinearVelocity = v8 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;