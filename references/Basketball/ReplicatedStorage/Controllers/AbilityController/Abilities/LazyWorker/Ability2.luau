 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

function Ability2(u7)
    -- upvalues: LocalPlayer (copy), u6 (ref), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), Essentials (copy), RunService (copy), TweenService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u6 = u7.Network;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    local v8 = u7:HoopDist();

    if v8 > 110 then
        u7:ResetCD(2);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if v8 < 35 then
        u7:ResetCD(2);
        Effects:Popup("Too close to hoop!");

        return;
    end;

    u2.States.Ability = true;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    u7.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    u7.AC:Add(BodyGyro);
    u3:StopAll();
    u3:PlayChar("LazyWorker", "Ability2", Enum.AnimationPriority.Action3);
    u3:PlayBall("LazyWorker", "Ability2Ball", Enum.AnimationPriority.Action3);
    local v9 = Essentials:ReturnRorL(u6.CharValues) == "L" and "Left" or "Right";
    local u10 = Humanoid.MoveDirection:Dot(workspace.CurrentCamera.CFrame.RightVector) > 0.95 and "Right" or (Humanoid.MoveDirection:Dot(workspace.CurrentCamera.CFrame.RightVector) < -0.95 and "Left" or v9);
    u1.Ability:Fire("LazyWorkerAbility2", {
        TimeSent = workspace:GetServerTimeNow(),
        Side = u10
    });
    local u11 = HumanoidRootPart.CFrame.RightVector * (u10 == "Left" and -1 or 1);
    u2.States.AimAssist = true;
    task.wait(0.11666666666666667);
    local u12 = HumanoidRootPart.CFrame.LookVector * -1 * Vector3.new(1, 0, 1);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    u7.AC:Add(NumberValue);
    u7.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 85
        -- upvalues: u12 (ref), HumanoidRootPart (copy), LinearVelocity (copy), NumberValue (copy)
        u12 = HumanoidRootPart.CFrame.LookVector * -1;
        u12 = u12 * Vector3.new(1, 0, 1);
        LinearVelocity.VectorVelocity = u12 * NumberValue.Value;
    end);
    TweenService:Create(NumberValue, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Value = 150
    }):Play();
    task.wait(0.11666666666666667);
    TweenService:Create(NumberValue, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Value = 0
    }):Play();
    task.wait(0.21666666666666667);
    u7.AC:Clean();
    u2.States.NoWalk = true;
    task.delay(0, function() -- Line: 101
        -- upvalues: u3 (ref), u10 (ref), u2 (ref), HumanoidRootPart (copy), RunService (ref), u11 (ref)
        u3:StopAll();
        u3:PlayChar("LazyWorker", `Ability2{u10}`, Enum.AnimationPriority.Action3);
        u3:PlayBall("LazyWorker", `Ability2{u10}Ball`, Enum.AnimationPriority.Action3);
        u2.States.NoWalk = false;
        local u14 = 30;
        local u15 = 0;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BodyVelocityBasketball";
        BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (1 / 0);
        BodyVelocity.Parent = HumanoidRootPart;
        local u16 = Vector3.new(0, 0, 0);
        task.delay(0.25, function() -- Line: 114
            -- upvalues: RunService (ref), u14 (ref), BodyVelocity (copy), u11 (ref), HumanoidRootPart (ref), u10 (ref), u15 (ref), u16 (ref)
            local u17 = tick();
            local u19 = RunService.Heartbeat:Connect(function(p18) -- Line: 117
                -- upvalues: u14 (ref), BodyVelocity (ref), u11 (ref), HumanoidRootPart (ref), u10 (ref), u17 (copy), u15 (ref), u16 (ref)
                if u14 >= 10 and BodyVelocity then
                    u11 = HumanoidRootPart.CFrame.RightVector * (u10 == "Left" and -1 or 1);

                    if u17 + 0.3333333333333333 < tick() then
                        BodyVelocity.Velocity = (u11 + Vector3.new(0, u15, 0)) * u14;
                        u15 = u15 - p18 * 1.75;
                    else
                        BodyVelocity.Velocity = (u11 + Vector3.new(0, 0, 0)) * u14;
                    end;

                    u16 = BodyVelocity.Velocity;
                    u14 = u14 - p18;
                end;
            end);
            task.delay(0.9833333333333333, function() -- Line: 130
                -- upvalues: u19 (ref), BodyVelocity (ref)
                if u19 then
                    u19:Disconnect();
                    u19 = nil;
                end;

                BodyVelocity:Destroy();
            end);
        end);
        task.delay(0.3333333333333333, function() -- Line: 139
            -- upvalues: u15 (ref)
            u15 = 0.75;
        end);
    end);
    u7.AC:Connect(u1.Ability, function() -- Line: 144
        -- upvalues: u7 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u4 (ref), HumanoidRootPart (copy)
        u7.AC:Clean();
        u2.States.AimAssist = false;
        u2.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local v20 = Hoop.Position - Value.Position;
        local v21, v22;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v21 = v20.Magnitude * 0.0455;
            v22 = 1.35;
        else
            v21 = v20.Magnitude * 0.04;
            v22 = 0.5;
        end;

        local math_log_ret = math.log(v22 + v21);
        Value.AssemblyLinearVelocity = v20 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;

return Ability2;