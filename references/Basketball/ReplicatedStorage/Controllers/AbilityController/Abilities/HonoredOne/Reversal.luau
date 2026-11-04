 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u8) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Effects (copy), CameraShaker (copy), TweenService (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u8.AbilityService;
    u2 = u8.MovementController;
    u3 = u8.CameraController;
    u4 = u8.BallController;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Network;

    if u6.CharValues.HasBall then
        if u6.CharValues.InAwakening and LocalPlayer.Style.Value ~= "Thief" then
            local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
            local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
            local v9 = Vector3_new_ret - HumanoidRootPart.Position;

            if v9:Dot(v9) < 8100 then
                u8:ResetCD(2);
                Effects:Popup("Too close to hoop!", 1);

                return;
            end;

            if v9:Dot(v9) > 22500 then
                u8:ResetCD(2);
                Effects:Popup("Too far away from hoop!", 1);

                return;
            end;

            u2.States.Shooting = true;
            u2.States.Ability = true;
            task.delay(3.1166666666666667, function() -- Line: 57
                -- upvalues: u2 (ref)
                u2.States.Shooting = false;
                u2.States.Ability = false;
            end);
            u5:StopAll();
            u5:PlayChar("HonoredOne", "HollowShot", Enum.AnimationPriority.Action3);
            u5:PlayBall("HonoredOne", "HollowShotBall", Enum.AnimationPriority.Action3);
            task.delay(2.3, function() -- Line: 66
                -- upvalues: u3 (ref), CameraShaker (ref)
                u3.CamShake:Shake(CameraShaker.Presets.Ankle);
            end);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(2.1333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                FieldOfView = 30
            }):Play();
            task.delay(2.1333333333333333, function() -- Line: 71
                -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 90
                }):Play();
            end);
            u1.Ability:Fire("Reversal", {
                State = "Shot",
                TimeSent = workspace:GetServerTimeNow()
            });
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = (1 / 0);
            LinearVelocity.Parent = HumanoidRootPart;
            u8.AC:Add(LinearVelocity);
            TweenService:Create(LinearVelocity, TweenInfo.new(2.1333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = Vector3.new(0, 10, 0)
            }):Play();
            task.wait(2.3);
            LinearVelocity:Destroy();

            if not u8.Network.CharValues.HasBall then
                return;
            end;

            u8.AC:Connect(u1.Ability, function(p10) -- Line: 94
                -- upvalues: u8 (copy), ReplicatedStorage (ref), u2 (ref), u4 (ref), Vector3_new_ret (copy), Hoop (copy), HumanoidRootPart (copy)
                u8.AC:Clean();

                if not p10 or p10.State ~= "Hollow Shot" then
                    return;
                end;

                local Value = ReplicatedStorage.Basketball.Value;
                u2.States.Shooting = false;
                u2.States.Ability = false;
                local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();
                Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Vector3_new_ret);
                local _ = Value.Position;
                local v11 = Hoop.Position - Value.Position;
                local v12;

                if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
                    v12 = v11.Magnitude * 0.0455;
                else
                    v12 = v11.Magnitude * 0.04;
                end;

                local math_log_ret = math.log(v12);
                Value.AssemblyLinearVelocity = v11 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
            end);

            return;
        end;

        if u2.States.PumpFake then
            u8:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            u8:ResetCD(2);
            Effects:Popup("Not usable in air");

            return;
        end;

        u5:StopAll();
        u5:PlayChar("HonoredOne", "DribbleRed", Enum.AnimationPriority.Action3);
        u5:PlayBall("HonoredOne", "DribbleRedBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Reversal", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow()
        });
        local NumberValue = Instance.new("NumberValue", HumanoidRootPart);
        NumberValue.Value = 0;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(400000, 0, 400000);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(NumberValue);
        u8.AC:Add(LinearVelocity);
        u2.States.Ability = true;
        task.delay(2.2666666666666666, function() -- Line: 159
            -- upvalues: u8 (copy), u2 (ref)
            u8.AC:Clean();
            u2.States.Ability = false;
        end);
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 164
            -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy)
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value;
        end);
        task.wait(0.35);
        NumberValue.Value = 50;
        task.wait(1.1666666666666667);
        NumberValue.Value = 250;
        task.wait(0.08333333333333333);
        NumberValue.Value = 50;
        TweenService:Create(NumberValue, TweenInfo.new(0.8833333333333333, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        u8:ResetCD(2);
        Effects:Popup("Not usable in air");

        return;
    end;

    u5:StopAll();
    u5:PlayChar("HonoredOne", "DashPurple", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Reversal", {
        State = "Dash",
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.Parent = HumanoidRootPart;
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(BodyGyro);
    u2.States.Ability = true;
    task.delay(1.75, function() -- Line: 210
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u8.AC:Add(task.delay(1.75, function() -- Line: 213
        -- upvalues: u8 (copy)
        u8.AC:Clean();
    end));
    task.wait(1.25);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    LinearVelocity.VectorVelocity = LookVector * (u6.CharValues.HasBall and 500 or 750);
    local u13 = TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    });
    u13:Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    tick();
    local u14 = nil;
    u14 = RunService.RenderStepped:Connect(function() -- Line: 230
        -- upvalues: HumanoidRootPart (copy), LookVector (copy), RaycastParams_new_ret (copy), u14 (ref), u13 (copy), LinearVelocity (copy), RunService (ref)
        local v15 = workspace:Raycast(HumanoidRootPart.Position, LookVector.Unit * 5, RaycastParams_new_ret);

        if v15 and not v15.Instance.Parent:FindFirstChild("Humanoid") then
            u14:Disconnect();

            if u13 then
                u13:Cancel();
            end;

            if LinearVelocity then
                LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
                RunService.Heartbeat:Wait();
                LinearVelocity:Destroy();
            end;
        end;
    end);
    task.wait(0.5);
    u14:Disconnect();
end;