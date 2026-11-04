 
 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = require("@game/ReplicatedStorage/Shared/Utility/CameraShaker");
local u2 = {
    {
        Frame = 0,
        Offset = CFrame.identity
    },
    {
        Frame = 27,
        Still = true,
        Offset = CFrame.identity
    },
    {
        Frame = 33,
        Offset = CFrame.new(-7.75662231, 7.66495705, -0.791290283)
    },
    {
        Frame = 40,
        Still = true,
        Offset = CFrame.new(-5.4773407, 24.6917267, 0.125793457)
    },
    {
        Frame = 45,
        Offset = CFrame.new(-5.55641174, 23.910099, 0.268882751)
    },
    {
        Frame = 54,
        Offset = CFrame.new(-3.10940552, 8.86270905, -1.68132019)
    },
    {
        Frame = 61,
        Still = true,
        Offset = CFrame.new(-4.99131775, 2.71909094, 0.598152161)
    },
    {
        Frame = 66,
        Offset = CFrame.new(-7.70536804, 9.08920002, 2.02994537)
    },
    {
        Frame = 76,
        Still = true,
        Offset = CFrame.new(-7.40484619, 21.6741333, -2.1447525)
    },
    {
        Frame = 83,
        Offset = CFrame.new(-0.385696411, 21.9635849, 0.693878174)
    },
    {
        Frame = 91,
        Offset = CFrame.new(-4.95848083, 20.5037384, -6.79560089)
    },
    {
        Frame = 115,
        Hoop = true,
        Offset = CFrame.new(-2, 2, 0),
        Easing = Enum.EasingStyle.Cubic,
        Direction = Enum.EasingDirection.Out
    }
};

local function Resolve(p3: table) -- Line: 24
    local Frame = p3.Frame;
    local v4 = Frame.Offset or CFrame.identity;

    if Frame.Hoop == true then
        return (p3.HoopPart.CFrame * v4).Position;
    end;

    return (p3.Origin * v4).Position;
end;

local function Tangent(p5: table) -- Line: 34
    -- upvalues: u2 (copy)
    local Index = p5.Index;

    if u2[Index].Still == true or (Index == 1 or Index == #u2) then
        return Vector3.new(0, 0, 0);
    end;

    local v6 = u2[Index - 1];
    local v7 = u2[Index + 1];
    local v8 = {
        Frame = v6,
        Origin = p5.Origin,
        HoopPart = p5.HoopPart
    };
    local Frame = v8.Frame;
    local v9 = Frame.Offset or CFrame.identity;
    local v10;

    if Frame.Hoop == true then
        v10 = (v8.HoopPart.CFrame * v9).Position;
    else
        v10 = (v8.Origin * v9).Position;
    end;

    local v11 = {
        Frame = v7,
        Origin = p5.Origin,
        HoopPart = p5.HoopPart
    };
    local Frame2 = v11.Frame;
    local v12 = Frame2.Offset or CFrame.identity;
    local v13;

    if Frame2.Hoop == true then
        v13 = (v11.HoopPart.CFrame * v12).Position;
    else
        v13 = (v11.Origin * v12).Position;
    end;

    return (v13 - v10) / ((v7.Frame - v6.Frame) / 60);
end;

local function Sample(p14: table) -- Line: 46
    -- upvalues: u2 (copy), TweenService (copy), Tangent (copy)
    local Time = p14.Time;
    local v15 = u2[1];
    local v16 = u2[#u2];

    if Time <= v15.Frame / 60 then
        local v17 = {
            Frame = v15,
            Origin = p14.Origin,
            HoopPart = p14.HoopPart
        };
        local Frame = v17.Frame;
        local v18 = Frame.Offset or CFrame.identity;

        if Frame.Hoop == true then
            return (v17.HoopPart.CFrame * v18).Position;
        end;

        return (v17.Origin * v18).Position;
    end;

    if v16.Frame / 60 > Time then
        for i = 2, #u2 do
            local v19 = u2[i];
            local v20 = v19.Frame / 60;

            if Time <= v20 then
                local v21 = u2[i - 1];
                local v22 = v21.Frame / 60;
                local v23 = (Time - v22) / (v20 - v22);
                local v24 = {
                    Frame = v21,
                    Origin = p14.Origin,
                    HoopPart = p14.HoopPart
                };
                local Frame = v24.Frame;
                local v25 = Frame.Offset or CFrame.identity;
                local v26;

                if Frame.Hoop == true then
                    v26 = (v24.HoopPart.CFrame * v25).Position;
                else
                    v26 = (v24.Origin * v25).Position;
                end;

                local v27 = {
                    Frame = v19,
                    Origin = p14.Origin,
                    HoopPart = p14.HoopPart
                };
                local Frame2 = v27.Frame;
                local v28 = Frame2.Offset or CFrame.identity;
                local v29;

                if Frame2.Hoop == true then
                    v29 = (v27.HoopPart.CFrame * v28).Position;
                else
                    v29 = (v27.Origin * v28).Position;
                end;

                if v19.Easing ~= nil then
                    return v26:Lerp(v29, (TweenService:GetValue(v23, v19.Easing, v19.Direction or Enum.EasingDirection.InOut)));
                end;

                local v30 = v20 - v22;
                local v31 = Tangent({
                    Index = i - 1,
                    Origin = p14.Origin,
                    HoopPart = p14.HoopPart
                }) * v30;
                local v32 = Tangent({
                    Index = i,
                    Origin = p14.Origin,
                    HoopPart = p14.HoopPart
                }) * v30;
                local v33 = v23 * v23;
                local v34 = v33 * v23;

                return v26 * (2 * v34 - 3 * v33 + 1) + v31 * (v34 - 2 * v33 + v23) + v29 * (3 * v33 - 2 * v34) + v32 * (v34 - v33);
            end;

            local _ = i;
        end;

        return v16.Offset;
    end;

    local v35 = {
        Frame = v16,
        Origin = p14.Origin,
        HoopPart = p14.HoopPart
    };
    local Frame = v35.Frame;
    local v36 = Frame.Offset or CFrame.identity;

    if Frame.Hoop == true then
        return (v35.HoopPart.CFrame * v36).Position;
    end;

    return (v35.Origin * v36).Position;
end;

return function(u37) -- Line: 80
    -- upvalues: LocalPlayer (copy), TweenService (copy), workspace_CurrentCamera (copy), u1 (copy), RunService (copy), Sample (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local AbilityService = u37.AbilityService;
    local Animations = u37.Animations;
    local _ = u37.MovementController;
    local _ = u37.Network;
    local CameraController = u37.CameraController;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Position = Hoop.Position;
    Animations:StopAll();
    local u38 = Animations:PlayChar("Ninja", "Ability2Dunk", Enum.AnimationPriority.Action3, true);
    local v39 = Animations:PlayBall("Ninja", "Ability2DunkBall", Enum.AnimationPriority.Action4, true);
    u37.AC:Add(u38, "Stop");
    u37.AC:Add(v39, "Stop");
    HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u37.AC:Add(BodyGyro);
    local CFrame2 = HumanoidRootPart.CFrame;
    AbilityService.Ability:Fire("ShadowRelay", {
        Dunk = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    u37.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.45), {
        FieldOfView = 40
    }), "Cancel"):Play();
    u37.AC:Add(task.delay(0.45, function() -- Line: 115
        -- upvalues: CameraController (copy), u1 (ref), u37 (copy), TweenService (ref), workspace_CurrentCamera (ref)
        CameraController.CamShake:Shake(u1.Presets.Bump);
        u37.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.21666666666666667), {
            FieldOfView = 100
        }), "Cancel"):Play();
        u37.AC:Add(task.delay(0.21666666666666667, function() -- Line: 119
            -- upvalues: u37 (ref), TweenService (ref), workspace_CurrentCamera (ref)
            u37.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }), "Cancel"):Play();
        end));
    end));
    u37.AC:Add(task.delay(1.0166666666666666, function() -- Line: 124
        -- upvalues: CameraController (copy), u1 (ref)
        CameraController.CamShake:Shake(u1.Presets.Bump);
    end));
    local u40 = u37.AC:Add(Instance.new("AlignPosition"));
    u40.Mode = Enum.PositionAlignmentMode.OneAttachment;
    u40.Attachment0 = HumanoidRootPart.RootAttachment;
    u40.MaxForce = (1 / 0);
    u40.MaxVelocity = (1 / 0);
    u40.Responsiveness = 200;
    u40.Position = CFrame2.Position;
    u40.Parent = HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    Humanoid.PlatformStand = true;
    u37.AC:Add(function() -- Line: 140
        -- upvalues: Humanoid (copy)
        Humanoid.PlatformStand = false;
    end);
    u37.AC:Add(RunService.PreSimulation:Connect(function(p41: number) -- Line: 144
        -- upvalues: u38 (copy), Sample (ref), CFrame2 (copy), Hoop (copy), u40 (copy)
        u40.Position = Sample({
            Time = u38.TimePosition,
            Origin = CFrame2,
            HoopPart = Hoop
        });
    end));
    u37.AC:Add(task.delay(2.033333333333333, function() -- Line: 150
        -- upvalues: u37 (copy)
        u37.AC:Clean();
    end));
end;