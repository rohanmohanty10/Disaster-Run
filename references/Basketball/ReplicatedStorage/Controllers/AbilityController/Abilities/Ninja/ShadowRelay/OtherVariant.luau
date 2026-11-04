 
 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("@game/ReplicatedStorage/Shared/Utility/Essentials");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/CameraShaker");
local u3 = require("@game/ReplicatedStorage/Shared/Functions/CalculateBallTrajectory");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IncludeInstances = { workspace.Barriers };

return function(u4) -- Line: 17
    -- upvalues: LocalPlayer (copy), u1 (copy), u2 (copy), TweenService (copy), workspace_CurrentCamera (copy), RunService (copy), RaycastParams_new_ret (copy), ReplicatedStorage (copy), u3 (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Animations = u4.Animations;
    local AbilityService = u4.AbilityService;
    local CameraController = u4.CameraController;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local v5 = u1:ReturnRorL(u4.Network.CharValues) == "R" and "Right" or "Left";
    HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    local v6 = HumanoidRootPart.CFrame.RightVector * (v5 == "Right" and 1 or -1);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Vector2_new_ret = Vector2.new(v6.X, v6.Z);
    local Vector2_new_ret2 = Vector2.new(LookVector.X, LookVector.Z);
    u4.AC:Add(task.delay(1.1, function() -- Line: 39
        -- upvalues: u4 (copy)
        u4.AC:Clean();
    end));
    Animations:StopAll();
    Animations:PlayChar("Ninja", `{v5}Slide`, Enum.AnimationPriority.Action3);
    Animations:PlayBall("Ninja", `{v5}SlideBall`, Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    u4.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u4.AC:Add(BodyGyro);
    AbilityService.Ability:Fire("ShadowRelay", {
        Other = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    CameraController.CamShake:Shake(u2.Presets.Bump);
    u4.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 45
    }), "Cancel"):Play();
    local u7 = u4.AC:Add(Instance.new("NumberValue"));
    u7.Value = 400;
    local u8 = u4.AC:Add(Instance.new("NumberValue"));
    u8.Value = 0;
    TweenService:Create(u7, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Quart), {
        Value = 0
    }):Play();
    TweenService:Create(u8, TweenInfo.new(0.20833333333333334, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, 0, true), {
        Value = -100
    }):Play();
    u4.AC:Add(task.delay(0.6, function() -- Line: 84
        -- upvalues: HumanoidRootPart (copy), u8 (copy)
        local v9 = HumanoidRootPart;
        v9.AssemblyLinearVelocity = v9.AssemblyLinearVelocity + Vector3.new(0, 32.5, 0);
        u8.Value = -66;
    end));

    local function GetVectorVelocity() -- Line: 92
        -- upvalues: u7 (copy), u8 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy)
        local v10 = u7 ~= nil and u7.Value or 0;
        local v11 = u8 == nil and 0 or (u8.Value or 0);
        local Vector2_zero = Vector2.zero;

        if v10 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret * v10;
        end;

        if v11 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret2 * v11;
        end;

        return Vector2_zero;
    end;

    u4.AC:Add(RunService.Heartbeat:Connect(function(p12) -- Line: 109
        -- upvalues: LinearVelocity (copy), u7 (copy), u8 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy), HumanoidRootPart (copy), RaycastParams_new_ret (ref)
        if LinearVelocity.Enabled == false then
            return;
        end;

        local v13 = u7 ~= nil and u7.Value or 0;
        local v14 = u8 == nil and 0 or (u8.Value or 0);
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
    u4.AC:Add(AbilityService.Ability:Connect(function(p16) -- Line: 125
        -- upvalues: CameraController (copy), u2 (ref), u4 (copy), TweenService (ref), workspace_CurrentCamera (ref), ReplicatedStorage (ref), u3 (ref), Position (copy)
        CameraController.CamShake:Shake(u2.Presets.Ankle);
        u4.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 90
        }), "Cancel"):Play();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.AssemblyLinearVelocity = u3(Value.Position, Position, 80);
    end));
end;