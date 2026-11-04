 
 

local u37 = {
    resolveLinkCFrame = function(p1) -- Line: 11, Name: resolveLinkCFrame
        if p1:IsA("Attachment") then
            return p1.WorldCFrame;
        end;

        if p1:IsA("Model") then
            return p1:GetPivot();
        end;

        if p1:IsA("Bone") then
            return p1.TransformedWorldCFrame;
        end;

        return p1.CFrame;
    end,

    composeRotation = function(p2, p3, p4, p5) -- Line: 23, Name: composeRotation
        local CFrame_Angles_ret = CFrame.Angles(math.rad(p3), 0, 0);
        local CFrame_Angles_ret2 = CFrame.Angles(0, math.rad(p4), 0);
        local CFrame_Angles_ret3 = CFrame.Angles(0, 0, (math.rad(p5)));

        if p2 == "LocalXYZ" then
            return CFrame_Angles_ret * CFrame_Angles_ret2 * CFrame_Angles_ret3;
        end;

        if p2 == "LocalXZY" then
            return CFrame_Angles_ret * CFrame_Angles_ret3 * CFrame_Angles_ret2;
        end;

        if p2 == "LocalYXZ" then
            return CFrame_Angles_ret2 * CFrame_Angles_ret * CFrame_Angles_ret3;
        end;

        if p2 == "LocalYZX" then
            return CFrame_Angles_ret2 * CFrame_Angles_ret3 * CFrame_Angles_ret;
        end;

        if p2 == "LocalZXY" then
            return CFrame_Angles_ret3 * CFrame_Angles_ret * CFrame_Angles_ret2;
        end;

        if p2 == "LocalZYX" then
            return CFrame_Angles_ret3 * CFrame_Angles_ret2 * CFrame_Angles_ret;
        end;

        return CFrame_Angles_ret2 * CFrame_Angles_ret * CFrame_Angles_ret3;
    end,

    DirectionVectors = {
        [Enum.NormalId.Top] = {
            vector = "UpVector",
            multiplier = 1
        },
        [Enum.NormalId.Bottom] = {
            vector = "UpVector",
            multiplier = -1
        },
        [Enum.NormalId.Front] = {
            vector = "LookVector",
            multiplier = 1
        },
        [Enum.NormalId.Back] = {
            vector = "LookVector",
            multiplier = -1
        },
        [Enum.NormalId.Left] = {
            vector = "RightVector",
            multiplier = -1
        },
        [Enum.NormalId.Right] = {
            vector = "RightVector",
            multiplier = 1
        }
    },
    shapeFunctions = {
        [Enum.ParticleEmitterShape.Box] = function(p6, p7) -- Line: 48
            local v8 = (math.random() * 2 - 1) * p6.Size.X / 2;
            local v9 = (math.random() * 2 - 1) * p6.Size.Y / 2;
            local v10 = (math.random() * 2 - 1) * p6.Size.Z / 2;
            local Vector3_new_ret = Vector3.new(v8, v9, v10);
            local v11 = Vector3_new_ret.Magnitude > 0.0001 and (Vector3_new_ret.Unit or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);

            return Vector3_new_ret, Vector3_new_ret.Magnitude > 0.0001 and CFrame.lookAt(Vector3.new(), -v11) or CFrame.new(), v11;
        end,

        [Enum.ParticleEmitterShape.Sphere] = function(p12, p13) -- Line: 58
            local v14 = p12.Size.X / 2;
            local v15 = v14 * p13.ShapePartial;
            local v16 = (math.random() * (v14 ^ 3 - v15 ^ 3) + v15 ^ 3) ^ 0.3333333333333333;
            local v17 = math.random() * 2 * 3.141592653589793;
            local v18 = math.random() * 2 - 1;
            local math_acos_ret = math.acos(v18);
            local v19 = math.sin(math_acos_ret) * math.cos(v17);
            local v20 = math.sin(math_acos_ret) * math.sin(v17);
            local math_cos_ret = math.cos(math_acos_ret);
            local Vector3_new_ret = Vector3.new(v19, v20, math_cos_ret);

            return Vector3_new_ret * v16, CFrame.lookAt(Vector3.new(), -Vector3_new_ret), Vector3_new_ret;
        end,

        [Enum.ParticleEmitterShape.Cylinder] = function(p21, p22) -- Line: 71
            local v23 = p21.Size.X / 2;
            local Y = p21.Size.Y;
            local math_clamp_ret = math.clamp(p22.ShapePartial, 0, 1);
            local v24 = math.random() * (1 - math_clamp_ret * math_clamp_ret) + math_clamp_ret * math_clamp_ret;
            local math_sqrt_ret = math.sqrt(v24);
            local v25 = math.random() * 2 * 3.141592653589793;
            local v26 = math_sqrt_ret * v23 * math.cos(v25);
            local v27 = (math.random() * 2 - 1) * (Y / 2);
            local v28 = math_sqrt_ret * v23 * math.sin(v25);
            local Vector3_new_ret = Vector3.new(v26, v27, v28);
            local v29;

            if math.abs(v27) > Y / 2 - 0.01 then
                local math_sign_ret = math.sign(v27);
                v29 = Vector3.new(0, math_sign_ret, 0);
            else
                local Vector3_new_ret2 = Vector3.new(v26, 0, v28);
                v29 = Vector3_new_ret2.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret2.Unit;
            end;

            return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -v29), v29;
        end,

        [Enum.ParticleEmitterShape.Disc] = function(p30, p31) -- Line: 95
            local v32 = p30.Size.X / 2;
            local math_clamp_ret = math.clamp(p31.ShapePartial, 0, 1);
            local v33 = math.random() * (1 - math_clamp_ret * math_clamp_ret) + math_clamp_ret * math_clamp_ret;
            local math_sqrt_ret = math.sqrt(v33);
            local v34 = math.random() * 2 * 3.141592653589793;
            local v35 = math_sqrt_ret * v32 * math.cos(v34);
            local v36 = math_sqrt_ret * v32 * math.sin(v34);
            local Vector3_new_ret = Vector3.new(v35, 0, v36);

            if Vector3_new_ret.Magnitude < 0.0001 then
                return Vector3_new_ret, CFrame.new(), Vector3.new(0, 1, 0);
            end;

            local Unit = Vector3_new_ret.Unit;

            return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -Unit), Unit;
        end
    }
};

function u37.applyPositionOffset(p38, p39, p40, p41, p42, p43, p44, p45) -- Line: 116
    -- upvalues: u37 (copy)
    local v46, v47, v48;

    if p43 and p39.AxisLinks then
        local v49 = p43.sampleRangeAxes(p39, p39.AxisLinks, { "PosX", "PosY", "PosZ" }, p42, p44);
        v46 = v49.PosX;
        v47 = v49.PosY;
        v48 = v49.PosZ;
    else
        v46 = p42.RandomValueFromRange(p39.PosX or NumberRange.new(0));
        v47 = p42.RandomValueFromRange(p39.PosY or NumberRange.new(0));
        v48 = p42.RandomValueFromRange(p39.PosZ or NumberRange.new(0));
    end;

    if v46 == 0 and (v47 == 0 and v48 == 0) then
        return p38;
    end;

    local v50 = p39.PosMode or "Local";

    if v50 == "Local" then
        return p38 * CFrame.new(v46, v47, v48);
    end;

    local Vector3_new_ret = Vector3.new(v46, v47, v48);

    if v50 ~= "Global" then
        local v51;

        if p40 then
            v51 = u37.resolveLinkCFrame(p40);
        elseif p41:IsA("Attachment") then
            v51 = p41.WorldCFrame;
        elseif p41:IsA("Model") then
            v51 = p41:GetPivot();
        else
            v51 = p41.CFrame;
        end;

        Vector3_new_ret = v51:VectorToWorldSpace(Vector3_new_ret);
    end;

    if p45 then
        Vector3_new_ret = p45:VectorToObjectSpace(Vector3_new_ret) or Vector3_new_ret;
    end;

    return CFrame.new(p38.Position + Vector3_new_ret) * p38.Rotation;
end;

function u37.resolveDisplacement(p52, p53, p54, p55, p56, p57, p58) -- Line: 171
    if p53 ~= "Global" then
        if p53 == "RigidLocal" then
            p52 = p55:VectorToWorldSpace(p52);
        else
            p52 = p54:VectorToWorldSpace(p52);
        end;
    end;

    if p56 then
        return p56 * p52.X + p57 * p52.Y + p58 * p52.Z;
    end;

    return p52;
end;

function u37.applyContactAccel(p59, p60, p61) -- Line: 193
    if not (p60._settleEngaged and p60._lastHitNormal) then
        return p59;
    end;

    local _lastHitNormal = p60._lastHitNormal;

    if _lastHitNormal.Magnitude < 0.0001 then
        return p59;
    end;

    local v62 = p59:Dot(_lastHitNormal);

    if v62 >= 0 then
        return p59;
    end;

    if math.abs(v62) < 10 then
        return p59;
    end;

    local v63 = p59 - v62 * _lastHitNormal;
    local v64 = p60.Events and p60.Events.OnHit and (p60.Events.OnHit.Friction or 0.2) or 0.2;
    local v65;

    if p60._accelVel then
        local _accelVel = p60._accelVel;
        v65 = _accelVel - _accelVel:Dot(_lastHitNormal) * _lastHitNormal;
    else
        v65 = Vector3.new(0, 0, 0);
    end;

    local Magnitude = v65.Magnitude;
    local v66 = v64 * math.abs(v62);

    if Magnitude <= 0.0001 then
        return v63.Magnitude <= v66 and Vector3.new(0, 0, 0) or v63 - v63.Unit * v66;
    end;

    local v67 = -v65.Unit * v66;

    if Magnitude < v66 * (p61 or 0.016666666666666666) then
        v67 = -v65 / (p61 or 0.016666666666666666);
    end;

    return v63 + v67;
end;

return u37;