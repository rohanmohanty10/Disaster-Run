 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 21, Name: HeatCheck
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u6 (ref), u5 (ref), Effects (copy), Zones (copy), RunService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u6 = u7.Network;
    u5 = u7.CameraController;

    if not u7:LookingAtNet() then
        u7:ResetCD(1);
        Effects:Popup("Must look towards the hoop to use ability!");

        return;
    end;

    local Magnitude = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude;

    if Magnitude < 30 then
        u7:ResetCD(1);
        Effects:Popup("Move away from the hoop to use Heat Check!");

        return;
    end;

    if not u7.ChuckRange then
        u7.ChuckRange = 105;
    end;

    if u7.ChuckRange < Magnitude then
        u7:ResetCD(1);
        Effects:Popup("Too far away from hoop! Score with ability to increase range", 2, Color3.new(0.505882, 0.505882, 1));

        return;
    end;

    local u8 = 1;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u6.CharValues.InZone then
        u8 = u8 + 0.2;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(2.1 / u8, function() -- Line: 56
        -- upvalues: u2 (ref)
        u2.States.Shooting = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    RunService.Heartbeat:Wait();
    RunService.Heartbeat:Wait();
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    u3:StopAll();
    local v9 = u3:PlayChar("Chuck", "HeatCheck", Enum.AnimationPriority.Action3, true);
    local v10 = u3:PlayBall("Chuck", "HeatCheckBall", Enum.AnimationPriority.Action3, true);
    v9:AdjustSpeed(u8);
    v10:AdjustSpeed(u8);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
    BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    BodyGyro.Parent = HumanoidRootPart;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local u11 = 105;
    local u13 = RunService.Heartbeat:Connect(function(p12) -- Line: 86
        -- upvalues: u11 (ref), u8 (ref), LinearVelocity (copy), LookVector (ref)
        u11 = u11 - p12 * (8 / u8);
        LinearVelocity.VectorVelocity = LookVector * (u11 / u8);

        if u11 <= 15 then
            u11 = 15;
        end;
    end);
    task.delay(0.28 / u8, function() -- Line: 92
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), u11 (ref), LookVector (ref)
        LinearVelocity.Parent = HumanoidRootPart;
        u11 = 28;
        LookVector = -HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.225, 0);
    end);
    task.delay(0.67 / u8, function() -- Line: 98
        -- upvalues: u11 (ref), LookVector (ref), HumanoidRootPart (copy), u13 (ref), LinearVelocity (copy), BodyGyro (copy)
        u11 = 35;
        LookVector = -HumanoidRootPart.CFrame.LookVector - Vector3.new(0, 0.3, 0);
        task.delay(0.25, function() -- Line: 101
            -- upvalues: u13 (ref), LinearVelocity (ref), BodyGyro (ref)
            u13:Disconnect();
            LinearVelocity:Destroy();
            BodyGyro:Destroy();
        end);
    end);
    u1.Ability:Fire("HeatCheck", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u7.AC:Connect(u1.Ability, function(p14) -- Line: 110
        -- upvalues: u7 (copy), Effects (ref), ReplicatedStorage (ref), u4 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        if p14.Fail then
            local v15 = u7;
            v15.ChuckRange = v15.ChuckRange - 20;

            if u7.ChuckRange <= 105 then
                u7.ChuckRange = 105;

                return;
            end;

            Effects:Popup("Got blocked! Ability range reduced!");

            return;
        end;

        if not p14.Success then
            if p14.Shoot then
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                Value.AssemblyLinearVelocity = CalculateBallTrajectory(u4:GetServerBallPosition(), workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 80);
            end;

            return;
        end;

        Effects:Popup("Successful shot! Ability range increased!");
        local v16 = u7;
        v16.ChuckRange = v16.ChuckRange + 10;
    end);
end;