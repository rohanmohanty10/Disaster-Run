 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), Essentials (copy), CameraShaker (copy), TweenService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

    if (HumanoidRootPart.Position - Position).Magnitude > 120 then
        u7:ResetCD(1);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u7:ResetCD(1);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(1.8333333333333333, function() -- Line: 50
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u1.Ability:Fire("Redline", {
        State = "Start",
        TimeSent = workspace:GetServerTimeNow()
    });
    u5:StopAll();
    u5:PlayChar("KingOfNYC", "Redline", Enum.AnimationPriority.Action3);
    u5:PlayBall("KingOfNYC", "RedlineBall", Enum.AnimationPriority.Action3);
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local v10 = RunService.Heartbeat:Connect(function(p9) -- Line: 72
        -- upvalues: FieldOfView (ref), Essentials (ref), u8 (ref), LinearVelocity (copy), workspace_CurrentCamera (ref)
        FieldOfView = Essentials:Lerp(FieldOfView, (u8 and (LinearVelocity.VectorVelocity.Magnitude > 0 and LinearVelocity.VectorVelocity.Magnitude or 60) or 15) + 25, p9 * 5);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    task.wait(0.8833333333333333);
    local v11 = Humanoid.MoveDirection:Dot(HumanoidRootPart.CFrame.RightVector);
    local v12 = v11 > 0 and "R" or (v11 < 0 and "L" or (math.random(1, 2) == 1 and "R" or "L"));
    u5:StopAll();
    u5:PlayChar("KingOfNYC", `Redline{v12}`, Enum.AnimationPriority.Action3);
    u5:PlayBall("KingOfNYC", `Redline{v12}Ball`, Enum.AnimationPriority.Action3);
    task.wait(0.2);
    u1.Ability:Fire("Redline", {
        State = "End",
        TimeSent = workspace:GetServerTimeNow(),
        CFrame = HumanoidRootPart.CFrame,
        Side = v12
    });
    u8 = true;
    u4.CamShake:Shake(CameraShaker.Presets.Bump);
    LinearVelocity.VectorVelocity = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z))).RightVector * (v12 == "R" and 1 or -1) * 60;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = LinearVelocity.VectorVelocity.Unit * 120
    }):Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    RaycastParams_new_ret.CollisionGroup = "Player";
    tick();
    local u13 = nil;
    u13 = RunService.Heartbeat:Connect(function(p14) -- Line: 104
        -- upvalues: HumanoidRootPart (copy), LinearVelocity (copy), RaycastParams_new_ret (copy), u13 (ref)
        local v15 = workspace:Raycast(HumanoidRootPart.Position, LinearVelocity.VectorVelocity.Unit * 4, RaycastParams_new_ret);

        if v15 and not v15.Instance.Parent:FindFirstChild("Humanoid") then
            u13:Disconnect();
            LinearVelocity:Destroy();
        end;
    end);
    task.wait(0.25);
    LinearVelocity:Destroy();
    u13:Disconnect();
    v10:Disconnect();
    u4.CamShake:Shake(CameraShaker.Presets.Dunk);
    local u16 = 30;
    local u17 = 0.75;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BodyVelocityBasketball";
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(0, inf, 0);
    local u18 = tick();
    local u20 = RunService.Heartbeat:Connect(function(p19) -- Line: 130
        -- upvalues: u16 (ref), u18 (copy), BodyVelocity (copy), u17 (ref)
        if u16 >= 10 then
            if u18 + 0.125 < tick() then
                BodyVelocity.Velocity = Vector3.new(0, u17, 0) * u16;
                u17 = u17 - p19 * 1.75;
            end;

            u16 = u16 - p19;
        end;
    end);
    task.delay(0.5, function() -- Line: 140
        -- upvalues: u20 (ref), BodyVelocity (copy)
        if u20 then
            u20:Disconnect();
        end;

        BodyVelocity:Destroy();
    end);
    u7.AC:Connect(u1.Ability, function() -- Line: 148
        -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        u7.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
    end);
end;