 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u8) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Effects (copy), TweenService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), CameraShaker (copy), Essentials (copy), workspace_CurrentCamera (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u8.BallController;
    u2 = u8.CameraController;
    u3 = u8.MovementController;
    u4 = u8.AbilityService;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Pass;

    if not u6.CharValues.HasBall then
        u3.States.Ability = true;
        u5:StopAll();
        local u9 = u5:PlayChar("BasketballUnc", "WheelchairDash", Enum.AnimationPriority.Action3, true);
        u4.Ability:Fire("Wheelchair Dash", {
            Task = "Activate",
            TimeSent = workspace:GetServerTimeNow()
        });
        local FieldOfView = workspace_CurrentCamera.FieldOfView;
        local u10 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 110
        });
        local u11 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.5), {
            FieldOfView = FieldOfView
        });
        u10:Play();
        task.delay(0.25, function() -- Line: 149
            -- upvalues: u11 (ref)
            if u11 then
                u11:Play();
            end;
        end);
        local _ = ReplicatedStorage.Basketball.Value;
        local ServerBallPosition = u1:GetServerBallPosition();
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 150;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * NumberValue.Value;
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(NumberValue);
        TweenService:Create(NumberValue, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 30
        }):Play();
        u8.AC:Add(function() -- Line: 172
            -- upvalues: u4 (ref), u3 (ref), u10 (ref), u11 (ref), u9 (copy), LinearVelocity (copy), NumberValue (copy), RunService (ref)
            u4.Ability:Fire("Wheelchair Dash", {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow()
            });
            u3.States.Ability = false;

            if u10 then
                u10:Pause();
                u10 = nil;
            end;

            if u11 then
                u11:Pause();
                u11 = nil;
            end;

            if u9.TimePosition < 1.5 then
                u9.TimePosition = 1.5;
            end;

            LinearVelocity.VectorVelocity = LinearVelocity.VectorVelocity.Unit * math.min(NumberValue.Value, 50);
            RunService.Heartbeat:Wait();
            LinearVelocity:Destroy();
        end);
        u8.AC:Connect(RunService.Heartbeat, function(p12) -- Line: 196
            -- upvalues: ServerBallPosition (ref), u1 (ref), LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy), u8 (copy)
            ServerBallPosition = u1:GetServerBallPosition();
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * NumberValue.Value;

            if (HumanoidRootPart.Position - ServerBallPosition).Magnitude < 15 then
                u8.AC:Clean();
            end;
        end);
        u8.AC:Connect(ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"), function() -- Line: 205
            -- upvalues: u6 (ref), u8 (copy)
            if u6.CharValues.HasBall then
                u8.AC:Clean();
            end;
        end);
        u8.AC:Add(task.delay(1.5, function() -- Line: 211
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));

        return;
    end;

    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local Gamemode = u6.Gamemode;
    local v13 = 0;

    for _, v in LocalPlayer.Team:GetPlayers() do
        if LocalPlayer ~= v then
            v13 = v13 + 1;
        end;
    end;

    if Gamemode ~= "Match-1v1" and v13 ~= 0 then
        local LookingAt = u7.LookingAt;

        if not LookingAt then
            u8:ResetCD(2);
            Effects:Popup("Must be looking at team-mate!");

            return;
        end;

        u2.CamShake:Shake(CameraShaker.Presets.Dunk);
        u4.Ability:Fire("Wheelchair Dash", {
            Task = "UncRelay",
            TimeSent = workspace:GetServerTimeNow(),
            PassingTo = LookingAt
        });
        local math_random_ret = math.random(1, 2);
        u5:PlayChar("Passes", `Pass{math_random_ret}{Essentials:ReturnRorL(u6.CharValues)}`, Enum.AnimationPriority.Action2);
        u5:PlayBall("Passes", `Pass{math_random_ret}{Essentials:ReturnRorL(u6.CharValues)}`, Enum.AnimationPriority.Action2);

        return;
    end;

    local v14 = u8:HoopDist();

    if v14 < 20 then
        Effects:Popup("You are too close to the hoop!");
        u8:ResetCD(2);

        return;
    end;

    if v14 >= 75 then
        Effects:Popup("You are too far away from the hoop!");
        u8:ResetCD(2);

        return;
    end;

    local v15 = u8:HoopDist();

    if v15 < 20 then
        Effects:Popup("You are too close to the hoop!");
        u8:ResetCD(2);

        return;
    end;

    if v15 >= 75 then
        Effects:Popup("You are too far away from the hoop!");
        u8:ResetCD(2);

        return;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u5:StopAll();
    u5:PlayChar("Playmaker", "Layup", Enum.AnimationPriority.Action3);
    u5:PlayBall("Playmaker", "LayupBall", Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    local Unit = (Position - HumanoidRootPart.Position).Unit;
    local u16 = 85 * (Unit.Z > 0 and 1 or -1);
    LinearVelocity.VectorVelocity = Unit * (v15 * 1.8) * Vector3.new(1, 0, 1);
    TweenService:Create(LinearVelocity, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.delay(0.36666666666666664, function() -- Line: 95
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), u16 (copy)
        LinearVelocity.Enabled = false;
        task.wait();
        local v17 = HumanoidRootPart;
        v17.AssemblyLinearVelocity = v17.AssemblyLinearVelocity + (Vector3.new(0, 35, u16) + LinearVelocity.VectorVelocity * Vector3.new(0.9, 0, 0));
    end);
    u8.AC:Add(task.delay(2, function() -- Line: 101
        -- upvalues: u8 (copy), u3 (ref)
        u8.AC:Clean();
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end));
    u8.AC:Connect(u4.Ability, function() -- Line: 107
        -- upvalues: u8 (copy), u3 (ref), ReplicatedStorage (ref), CalculateBallTrajectory (ref), Position (copy)
        u8.AC:Clean();
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Position, 70, 1 * workspace.Gravity);
    end);
    u4.Ability:Fire("Wheelchair Dash", {
        Task = "Layup",
        TimeSent = workspace:GetServerTimeNow()
    });
end;