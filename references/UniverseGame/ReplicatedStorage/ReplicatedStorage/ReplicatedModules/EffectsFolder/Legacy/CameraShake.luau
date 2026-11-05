  

 

local LocalPlayer = game.Players.LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CameraShakeInstance = require(ReplicatedStorage.ClientModules.CameraShaker.CameraShakeInstance);
local CurrentCamera = workspace.CurrentCamera;
local u2 = require(ReplicatedStorage.ClientModules:WaitForChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 6
    -- upvalues: CurrentCamera (copy)
    CurrentCamera.CFrame = CustomCamPart and CustomCamPart.CFrame or CurrentCamera.CFrame * p1;
end);
u2:Start();

return function(p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) -- Line: 10
    -- upvalues: LocalPlayer (copy), CameraShakeInstance (copy), u2 (copy)
    if LocalPlayer.Settings.CameraShake.Value == false then
        return;
    end;

    if p12 and (p11 and (LocalPlayer.Character and p12 < (LocalPlayer.Character.HumanoidRootPart.Position - p11).Magnitude)) then
        print((LocalPlayer.Character.HumanoidRootPart.Position - p11).Magnitude);

        return;
    end;

    local v34 = {
        OldBump = function() -- Line: 16
            -- upvalues: CameraShakeInstance (ref)
            local v13 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75);
            v13.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
            v13.RotationInfluence = Vector3.new(1, 1, 1);

            return v13;
        end,

        SmallerBump = function() -- Line: 22
            -- upvalues: CameraShakeInstance (ref)
            local v14 = CameraShakeInstance.new(1, 10, 0.2, 0.1);
            v14.PositionInfluence = Vector3.new(0, 0.4, 0);
            v14.RotationInfluence = Vector3.new(0, 2, 0);

            return v14;
        end,

        Bump = function() -- Line: 28
            -- upvalues: CameraShakeInstance (ref)
            local v15 = CameraShakeInstance.new(1.5, 20, 0.1, 0.75);
            v15.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
            v15.RotationInfluence = Vector3.new(1, 1, 1);

            return v15;
        end,

        Vibration = function() -- Line: 34
            -- upvalues: CameraShakeInstance (ref)
            local v16 = CameraShakeInstance.new(0.4, 20, 0.1, 0.75);
            v16.PositionInfluence = Vector3.new(0, 0.15, 0);
            v16.RotationInfluence = Vector3.new(1.25, 0, 4);

            return v16;
        end,

        ViolentShake = function() -- Line: 40
            -- upvalues: CameraShakeInstance (ref)
            local v17 = CameraShakeInstance.new(10, 10, 0.1, 0.75);
            v17.PositionInfluence = Vector3.new(0, 0.15, 0);
            v17.RotationInfluence = Vector3.new(1.25, 0, 4);

            return v17;
        end,

        LongViolentShake = function() -- Line: 46
            -- upvalues: CameraShakeInstance (ref)
            local v18 = CameraShakeInstance.new(10, 10, 0.1, 4);
            v18.PositionInfluence = Vector3.new(0, 0.15, 0);
            v18.RotationInfluence = Vector3.new(1.25, 0, 4);

            return v18;
        end,

        LongViolentShake2 = function() -- Line: 52
            -- upvalues: CameraShakeInstance (ref)
            local v19 = CameraShakeInstance.new(5, 10, 3, 10);
            v19.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);
            v19.RotationInfluence = Vector3.new(4.5, 1.5, 1.5);

            return v19;
        end,

        IntensifyingShake = function() -- Line: 58
            -- upvalues: CameraShakeInstance (ref)
            local v20 = CameraShakeInstance.new(5, 8, 4, 0.1);
            v20.PositionInfluence = Vector3.new(0.1, 0.1, 0.1);
            v20.RotationInfluence = Vector3.new(1.5, 1.5, 1.5);

            return v20;
        end,

        Explosion = function() -- Line: 64
            -- upvalues: CameraShakeInstance (ref)
            local v21 = CameraShakeInstance.new(5, 10, 0, 1.5);
            v21.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
            v21.RotationInfluence = Vector3.new(4, 1, 1);

            return v21;
        end,

        Explosion2 = function() -- Line: 70
            -- upvalues: CameraShakeInstance (ref)
            local v22 = CameraShakeInstance.new(4, 7, 0, 1);
            v22.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);
            v22.RotationInfluence = Vector3.new(4, 1, 1);

            return v22;
        end,

        IntenseExplosion = function() -- Line: 76
            -- upvalues: CameraShakeInstance (ref)
            local v23 = CameraShakeInstance.new(10, 15, 0, 1);
            v23.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);
            v23.RotationInfluence = Vector3.new(4.5, 1.5, 1.5);

            return v23;
        end,

        LongerExplosion = function() -- Line: 82
            -- upvalues: CameraShakeInstance (ref)
            local v24 = CameraShakeInstance.new(10, 15, 0, 2.7);
            v24.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);
            v24.RotationInfluence = Vector3.new(4.5, 4.5, 4.5);

            return v24;
        end,

        LongerExplosion2 = function() -- Line: 88
            -- upvalues: CameraShakeInstance (ref)
            local v25 = CameraShakeInstance.new(10, 15, 0, 2);
            v25.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);
            v25.RotationInfluence = Vector3.new(4.5, 1.5, 1.5);

            return v25;
        end,

        Earthquake = function() -- Line: 94
            -- upvalues: CameraShakeInstance (ref)
            local v26 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
            v26.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
            v26.RotationInfluence = Vector3.new(1, 1, 4);

            return v26;
        end,

        [""] = function() -- Line: 100
            -- upvalues: CameraShakeInstance (ref)
            local v27 = CameraShakeInstance.new(10, 0.15, 5, 10);
            v27.PositionInfluence = Vector3.new(0, 0, 0.15);
            v27.RotationInfluence = Vector3.new(2, 1, 4);

            return v27;
        end,

        HandheldCamera = function() -- Line: 106
            -- upvalues: CameraShakeInstance (ref)
            local v28 = CameraShakeInstance.new(1, 0.25, 5, 10);
            v28.PositionInfluence = Vector3.new(0, 0, 0);
            v28.RotationInfluence = Vector3.new(1, 0.5, 0.5);

            return v28;
        end,

        RoughDriving = function() -- Line: 112
            -- upvalues: CameraShakeInstance (ref)
            local v29 = CameraShakeInstance.new(1, 2, 1, 1);
            v29.PositionInfluence = Vector3.new(0, 0, 0);
            v29.RotationInfluence = Vector3.new(1, 1, 1);

            return v29;
        end,

        Medium = function() -- Line: 118
            -- upvalues: CameraShakeInstance (ref)
            local v30 = CameraShakeInstance.new(1.5, 20, 0.1, 0.75);
            v30.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
            v30.RotationInfluence = Vector3.new(1, 1, 1);

            return v30;
        end,

        Normal = function() -- Line: 124
            -- upvalues: CameraShakeInstance (ref)
            local v31 = CameraShakeInstance.new(0.4, 20, 0.1, 0.75);
            v31.PositionInfluence = Vector3.new(0, 0.15, 0);
            v31.RotationInfluence = Vector3.new(1.25, 0, 4);

            return v31;
        end,

        Extreme = function() -- Line: 130
            -- upvalues: CameraShakeInstance (ref)
            local v32 = CameraShakeInstance.new(10, 10, 0.1, 0.75);
            v32.PositionInfluence = Vector3.new(0, 0.15, 0);
            v32.RotationInfluence = Vector3.new(1.25, 0, 4);

            return v32;
        end,

        ExtremeExtended = function() -- Line: 136
            -- upvalues: CameraShakeInstance (ref)
            local v33 = CameraShakeInstance.new(10, 10, 0.1, 4);
            v33.PositionInfluence = Vector3.new(0, 0.15, 0);
            v33.RotationInfluence = Vector3.new(1.25, 0, 4);

            return v33;
        end
    };
    CustomCamPart = p10;

    if p9 then
        u2:ShakeOnce(p3, p4, p5, p6, p7, p8);

        return;
    end;

    local v35;

    if type(p3) == "string" then
        v35 = v34[p3]();
    elseif type(p4) == "string" then
        v35 = v34[p4]();
    else
        v35 = CameraShakeInstance.new(p3, p4, p5, p6);
    end;

    u2:Shake(v35);
end;