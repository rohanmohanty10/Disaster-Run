 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IncludeInstances = { workspace.Barriers };

return function(u6) -- Line: 21
    -- upvalues: u1 (ref), u2 (ref), u4 (ref), u5 (ref), u3 (ref), LocalPlayer (copy), TweenService (copy), RunService (copy), RaycastParams_new_ret (copy), ReplicatedStorage (copy), Effects (copy)
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u4 = u6.Animations;
    u5 = u6.Network;
    u3 = u6.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

    if not u5.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.CutTheLightsCD.Value > workspace:GetServerTimeNow() then
            u6:ResetCD(1);
            local v7 = ReplicatedStorage.Cooldowns.CutTheLightsCD.Value - workspace:GetServerTimeNow();
            Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v7)} seconds`, 2);

            return;
        end;

        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if PlayerPossessingBall == nil then
            u6:ResetCD(4);
            Effects:Popup("An enemy must be holding the ball!");

            return;
        end;

        if not RunService:IsStudio() and PlayerPossessingBall.Team == LocalPlayer.Team then
            u6:ResetCD(4);
            Effects:Popup("An enemy must be holding the ball!");

            return;
        end;

        local Character = PlayerPossessingBall.Character;

        if Character == nil then
            u6:ResetCD(4);
            Effects:Popup("An enemy must be holding the ball!");

            return;
        end;

        local HumanoidRootPart2 = Character.HumanoidRootPart;
        local Vector3_new_ret = Vector3.new(HumanoidRootPart2.Position.X - HumanoidRootPart.Position.X, 0, HumanoidRootPart2.Position.Z - HumanoidRootPart.Position.Z);

        if Vector3_new_ret:Dot(Vector3_new_ret) <= 10000 then
            u1.Ability:Fire("Cut The Lights", {
                Task = "Cut The Lights",
                TimeSent = workspace:GetServerTimeNow()
            });

            return;
        end;

        u6:ResetCD(4);
        Effects:Popup("The enemy is too far away!");

        return;
    end;

    local RightVector = HumanoidRootPart.CFrame.RightVector;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Vector2_new_ret = Vector2.new(RightVector.X, RightVector.Z);
    local Vector2_new_ret2 = Vector2.new(LookVector.X, LookVector.Z);
    u1.Ability:Fire("Cut The Lights", {
        Task = "Fear Aura",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u6.AC:Add(function() -- Line: 43
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    u6.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u6.AC:Add(BodyGyro);
    u6.AC:Add(task.delay(1, function() -- Line: 66
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local u8 = u6.AC:Add(Instance.new("NumberValue"));
    u8.Value = -80;
    local u9 = u6.AC:Add(Instance.new("NumberValue"));
    u9.Value = 120;
    TweenService:Create(u8, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Value = 20
    }):Play();
    TweenService:Create(u9, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Value = 40
    }):Play();
    task.delay(0.5, function() -- Line: 84
        -- upvalues: u8 (copy), u9 (copy), TweenService (ref)
        u8.Value = 80;
        u9.Value = 120;
        TweenService:Create(u8, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Value = 20
        }):Play();
        TweenService:Create(u9, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Value = 40
        }):Play();
    end);

    local function GetVectorVelocity() -- Line: 97
        -- upvalues: u8 (copy), u9 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy)
        local v10 = u8 ~= nil and u8.Value or 0;
        local v11 = u9 == nil and 0 or (u9.Value or 0);
        local Vector2_zero = Vector2.zero;

        if v10 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret * v10;
        end;

        if v11 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret2 * v11;
        end;

        return Vector2_zero;
    end;

    u6.AC:Add(RunService.Heartbeat:Connect(function(p12) -- Line: 114
        -- upvalues: LinearVelocity (copy), u8 (copy), u9 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy), HumanoidRootPart (copy), RaycastParams_new_ret (ref)
        if LinearVelocity.Enabled == false then
            return;
        end;

        local v13 = u8 ~= nil and u8.Value or 0;
        local v14 = u9 == nil and 0 or (u9.Value or 0);
        local Vector2_zero = Vector2.zero;

        if v13 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret * v13;
        end;

        if v14 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret2 * v14;
        end;

        local v15 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(Vector2_zero.X, 0, Vector2_zero.Y).Unit, RaycastParams_new_ret);

        if v15 and v15.Instance then
            LinearVelocity.PlaneVelocity = Vector2.zero;

            return;
        end;

        LinearVelocity.PlaneVelocity = Vector2_zero;
    end));
end;