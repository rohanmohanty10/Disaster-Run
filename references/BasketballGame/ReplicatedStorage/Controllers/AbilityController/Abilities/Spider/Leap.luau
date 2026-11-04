 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local PositionIsInTwoPointZone = require(ReplicatedStorage.Shared.Functions.PositionIsInTwoPointZone);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 21, Name: Leap
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), Effects (copy), PositionIsInTwoPointZone (copy), TweenService (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u7.Network;
    u2 = u7.AbilityService;
    u4 = u7.Animations;
    u3 = u7.MovementController;
    u5 = u7.BallController;
    u6 = u7.CameraController;

    if not u5:LocalPlayerPossessesBall() then
        u7.RollAway = nil;
        Effects:Popup("Shot sense activated for 3 seconds!");
        u2.Ability:Fire("SpiderLeap", {
            Ability = "ShotSense",
            TimeSent = workspace:GetServerTimeNow()
        });
        local u8 = nil;
        u8 = u2.Ability:Connect(function(p9) -- Line: 163
            -- upvalues: u8 (ref), u4 (ref), u3 (ref)
            if p9.Stolen then
                u8:Disconnect();
                u4:StopAll();
                local v10 = u4:PlayChar("Spider", "ShotSense", Enum.AnimationPriority.Action3, true);
                local v11 = u4:PlayBall("Spider", "ShotSenseBall", Enum.AnimationPriority.Action3, true);
                v10:AdjustSpeed(1.65);
                v11:AdjustSpeed(1.65);
                u3.States.Ability = true;
                u3.States.NoWalk = true;
                task.delay(0.7676767676767677, function() -- Line: 176
                    -- upvalues: u3 (ref)
                    u3.States.NoWalk = false;
                    u3.States.Ability = false;
                end);
            end;
        end);
        task.delay(4, function() -- Line: 183
            -- upvalues: u8 (ref)
            if u8 then
                u8:Disconnect();
            end;
        end);

        return;
    end;

    u2.Ability:Fire("SpiderLeap", {
        Ability = "RollAway",
        TimeSent = workspace:GetServerTimeNow()
    });

    if not u7.RollAway then
        u7.RollAway = 2;
    end;

    u7.RollAway = u7.RollAway - 1;
    Effects:Popup((`{u7.RollAway} Use{u7.RollAway == 1 and "" or "s"} remaining!`));
    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u4:StopAll();
    local v12 = u4:PlayChar("Spider", "Dash", Enum.AnimationPriority.Action3, true);
    local v13 = u4:PlayBall("Spider", "DashBall", Enum.AnimationPriority.Action3, true);
    v12:AdjustSpeed(1.2);
    v13:AdjustSpeed(1.2);

    if u7.RollAway <= 0 then
        u7.RollAway = nil;
    else
        u7.CDS[1] = tick();
    end;

    PositionIsInTwoPointZone((u1.Gamemode == "Match-2v2" or u1.Gamemode == "Match-1v1") and "Ranked" or LocalPlayer.Team.Name, HumanoidRootPart.Position);
    u7.AC:Add(task.delay(5, function() -- Line: 75
    end));
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Name = "LinearVelocityBasketball";
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
    local v14 = "Left";
    local v15;

    if Humanoid.MoveDirection:Dot(workspace.CurrentCamera.CFrame.RightVector) > 0.95 then
        v15 = HumanoidRootPart.CFrame.LookVector.X < 0 and "Left" or "Right";
    else
        v15 = Humanoid.MoveDirection:Dot(workspace.CurrentCamera.CFrame.RightVector) < -0.95 and (HumanoidRootPart.CFrame.LookVector.X < 0 and "Right" or "Left") or v14;
    end;

    task.wait(0.06944444444444445);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, (v15 == "Right" and 1 or -1) * 170);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.5555555555555556, Enum.EasingStyle.Sine), {
        VectorVelocity = Vector3.new(0, 0, (v15 == "Right" and 1 or -1) * 34)
    }):Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };
    local u16 = false;
    u7.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 115
        -- upvalues: BodyGyro (copy), HumanoidRootPart (copy), LinearVelocity (copy), RaycastParams_new_ret (copy), u16 (ref)
        BodyGyro.CFrame = HumanoidRootPart.CFrame;
        local v18 = workspace:Raycast(HumanoidRootPart.Position, LinearVelocity.VectorVelocity.Unit * 5, RaycastParams_new_ret);

        if v18 and (v18.Instance and not u16) then
            u16 = true;

            if LinearVelocity then
                LinearVelocity:Destroy();
            end;
        end;
    end);
    task.wait(0.462962962962963);

    if u7:HoopDist() > 65 then
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        u7.AC:Clean();
    else
        u7.AC:Clean();
        local math_random_ret = math.random(1, 3);
        u4:PlayChar("Spider", `SpiderLeapDunk{math_random_ret}`, Enum.AnimationPriority.Action3);
        u4:PlayBall("Spider", `SpiderLeapDunk{math_random_ret}Ball`, Enum.AnimationPriority.Action3);
        u2.Ability:Fire("SpiderLeap", {
            Ability = "DUNK",
            TimeSent = workspace:GetServerTimeNow()
        });
        u7.AC:Add(function() -- Line: 146
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
            u3.States.NoWalk = false;
        end);
        u7.AC:Add(task.delay(2, function() -- Line: 151
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
    end;
end;