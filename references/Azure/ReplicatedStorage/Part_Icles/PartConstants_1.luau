 
 

local u2 = {
    resolveLinkCFrame = function(p1) -- Line: 13, Name: resolveLinkCFrame
        if p1:IsA("Bone") then
            return p1.TransformedWorldCFrame;
        end;

        if p1:IsA("Attachment") then
            return p1.WorldCFrame;
        end;

        if p1:IsA("Model") then
            return p1:GetPivot();
        end;

        return p1.CFrame;
    end
};

function u2.placeOnLink(p3, p4) -- Line: 23
    -- upvalues: u2 (copy)
    local v5 = u2.resolveLinkCFrame(p3);

    if p4 then
        return v5:PointToWorldSpace(p4);
    end;

    return v5.Position;
end;

function u2.playOrigin(p6, p7) -- Line: 34
    local v8 = nil;

    if p7 then
        if p7.EventOriginResolver then
            v8 = p7.EventOriginResolver();
        end;

        v8 = v8 or p7.EventOriginCF;
    end;

    if not v8 then
        return p6, true;
    end;

    if p7.UseFullOrigin then
        return v8, false;
    end;

    return CFrame.new(v8.Position) * p6.Rotation, false;
end;

function u2.getParentScaleFactor(p9, p10, p11, p12) -- Line: 59
    local v13 = 1;

    while p9 do
        local v14 = true;

        if p12 == "motion" then
            v14 = p9.ScaleMotion ~= false;
        elseif p12 == "rotation" then
            v14 = p9.ScaleRotation == true;
        end;

        if v14 then
            local Owner = p9.Owner;
            local v15;

            if Owner then
                v15 = Owner._ownScale;
            else
                v15 = Owner;
            end;

            if not v15 then
                if Owner and Owner._staticScale then
                    v15 = Owner._staticScale;
                elseif Owner and (Owner.Graphs and Owner.Graphs.Scale) then
                    local math_clamp_ret = math.clamp((p10 - Owner.StartTime) / Owner.LifeTime, 0, 1);
                    v15 = p11.QueryPointsWithTime(math_clamp_ret, Owner.Graphs.Scale, Owner.Seeds.Scale);
                else
                    v15 = 1;
                end;
            end;

            v13 = v13 * math.max(0.001, v15);
        end;

        p9 = p9.Parent;
    end;

    return v13;
end;

function u2.composeRotation(p16, p17, p18, p19) -- Line: 91
    local CFrame_Angles_ret = CFrame.Angles(math.rad(p17), 0, 0);
    local CFrame_Angles_ret2 = CFrame.Angles(0, math.rad(p18), 0);
    local CFrame_Angles_ret3 = CFrame.Angles(0, 0, (math.rad(p19)));

    if p16 == "LocalXYZ" then
        return CFrame_Angles_ret * CFrame_Angles_ret2 * CFrame_Angles_ret3;
    end;

    if p16 == "LocalXZY" then
        return CFrame_Angles_ret * CFrame_Angles_ret3 * CFrame_Angles_ret2;
    end;

    if p16 == "LocalYXZ" then
        return CFrame_Angles_ret2 * CFrame_Angles_ret * CFrame_Angles_ret3;
    end;

    if p16 == "LocalYZX" then
        return CFrame_Angles_ret2 * CFrame_Angles_ret3 * CFrame_Angles_ret;
    end;

    if p16 == "LocalZXY" then
        return CFrame_Angles_ret3 * CFrame_Angles_ret * CFrame_Angles_ret2;
    end;

    if p16 == "LocalZYX" then
        return CFrame_Angles_ret3 * CFrame_Angles_ret2 * CFrame_Angles_ret;
    end;

    return CFrame_Angles_ret2 * CFrame_Angles_ret * CFrame_Angles_ret3;
end;

u2.DirectionVectors = {
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
};
u2.shapeFunctions = {
    [Enum.ParticleEmitterShape.Box] = function(p20, p21) -- Line: 116
        local v22 = (math.random() * 2 - 1) * p20.Size.X / 2;
        local v23 = (math.random() * 2 - 1) * p20.Size.Y / 2;
        local v24 = (math.random() * 2 - 1) * p20.Size.Z / 2;
        local Vector3_new_ret = Vector3.new(v22, v23, v24);
        local v25 = Vector3_new_ret.Magnitude > 0.0001 and (Vector3_new_ret.Unit or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);

        return Vector3_new_ret, Vector3_new_ret.Magnitude > 0.0001 and CFrame.lookAt(Vector3.new(), -v25) or CFrame.new(), v25;
    end,

    [Enum.ParticleEmitterShape.Sphere] = function(p26, p27) -- Line: 126
        local v28 = p26.Size.X / 2;
        local v29 = v28 * p27.ShapePartial;
        local v30 = (math.random() * (v28 ^ 3 - v29 ^ 3) + v29 ^ 3) ^ 0.3333333333333333;
        local v31 = math.random() * 2 * 3.141592653589793;
        local v32 = math.random() * 2 - 1;
        local math_acos_ret = math.acos(v32);
        local v33 = math.sin(math_acos_ret) * math.cos(v31);
        local v34 = math.sin(math_acos_ret) * math.sin(v31);
        local math_cos_ret = math.cos(math_acos_ret);
        local Vector3_new_ret = Vector3.new(v33, v34, math_cos_ret);

        return Vector3_new_ret * v30, CFrame.lookAt(Vector3.new(), -Vector3_new_ret), Vector3_new_ret;
    end,

    [Enum.ParticleEmitterShape.Cylinder] = function(p35, p36) -- Line: 139
        local v37 = p35.Size.X / 2;
        local Y = p35.Size.Y;
        local math_clamp_ret = math.clamp(p36.ShapePartial, 0, 1);
        local v38 = math.random() * (1 - math_clamp_ret * math_clamp_ret) + math_clamp_ret * math_clamp_ret;
        local math_sqrt_ret = math.sqrt(v38);
        local v39 = math.random() * 2 * 3.141592653589793;
        local v40 = math_sqrt_ret * v37 * math.cos(v39);
        local v41 = (math.random() * 2 - 1) * (Y / 2);
        local v42 = math_sqrt_ret * v37 * math.sin(v39);
        local Vector3_new_ret = Vector3.new(v40, v41, v42);
        local v43;

        if math.abs(v41) > Y / 2 - 0.01 then
            local math_sign_ret = math.sign(v41);
            v43 = Vector3.new(0, math_sign_ret, 0);
        else
            local Vector3_new_ret2 = Vector3.new(v40, 0, v42);
            v43 = Vector3_new_ret2.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret2.Unit;
        end;

        return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -v43), v43;
    end,

    [Enum.ParticleEmitterShape.Disc] = function(p44, p45) -- Line: 163
        local v46 = p44.Size.X / 2;
        local math_clamp_ret = math.clamp(p45.ShapePartial, 0, 1);
        local v47 = math.random() * (1 - math_clamp_ret * math_clamp_ret) + math_clamp_ret * math_clamp_ret;
        local math_sqrt_ret = math.sqrt(v47);
        local v48 = math.random() * 2 * 3.141592653589793;
        local v49 = math_sqrt_ret * v46 * math.cos(v48);
        local v50 = math_sqrt_ret * v46 * math.sin(v48);
        local Vector3_new_ret = Vector3.new(v49, 0, v50);

        if Vector3_new_ret.Magnitude < 0.0001 then
            return Vector3_new_ret, CFrame.new(), Vector3.new(0, 1, 0);
        end;

        local Unit = Vector3_new_ret.Unit;

        return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -Unit), Unit;
    end
};

function u2.applyPositionOffset(p51, p52, p53, p54, p55, p56, p57, p58, p59) -- Line: 184
    -- upvalues: u2 (copy)
    local v60, v61, v62;

    if p56 and p52.AxisLinks then
        local v63 = p56.sampleRangeAxes(p52, p52.AxisLinks, { "PosX", "PosY", "PosZ" }, p55, p57);
        v60 = v63.PosX;
        v61 = v63.PosY;
        v62 = v63.PosZ;
    else
        v60 = p55.RandomValueFromRange(p52.PosX or NumberRange.new(0));
        v61 = p55.RandomValueFromRange(p52.PosY or NumberRange.new(0));
        v62 = p55.RandomValueFromRange(p52.PosZ or NumberRange.new(0));
    end;

    if p59 and p59 ~= 1 then
        v60 = v60 * p59;
        v61 = v61 * p59;
        v62 = v62 * p59;
    end;

    if v60 == 0 and (v61 == 0 and v62 == 0) then
        return p51;
    end;

    local v64 = p52.PosMode or "Local";

    if v64 == "Local" then
        return p51 * CFrame.new(v60, v61, v62);
    end;

    local Vector3_new_ret = Vector3.new(v60, v61, v62);

    if v64 ~= "Global" then
        local v65;

        if p53 then
            v65 = u2.resolveLinkCFrame(p53);
        elseif p54:IsA("Attachment") then
            v65 = p54.WorldCFrame;
        elseif p54:IsA("Model") then
            v65 = p54:GetPivot();
        else
            v65 = p54.CFrame;
        end;

        Vector3_new_ret = v65:VectorToWorldSpace(Vector3_new_ret);
    end;

    if p58 then
        Vector3_new_ret = p58:VectorToObjectSpace(Vector3_new_ret) or Vector3_new_ret;
    end;

    return CFrame.new(p51.Position + Vector3_new_ret) * p51.Rotation;
end;

function u2.resolveDisplacement(p66, p67, p68, p69, p70, p71, p72) -- Line: 245
    if p67 ~= "Global" then
        if p67 == "RigidLocal" then
            p66 = p69:VectorToWorldSpace(p66);
        else
            p66 = p68:VectorToWorldSpace(p66);
        end;
    end;

    if p70 then
        return p70 * p66.X + p71 * p66.Y + p72 * p66.Z;
    end;

    return p66;
end;

u2.TURNING_DISPLACEMENT = "Rotating";

function u2.midRotation(p73, p74, p75, p76, p77, p78, p79) -- Line: 266
    -- upvalues: u2 (copy)
    return u2.composeRotation(p73, (p74 + p77) * 0.5, (p75 + p78) * 0.5, (p76 + p79) * 0.5);
end;

function u2.applyContactAccel(p80, p81, p82) -- Line: 277
    if not (p81._settleEngaged and p81._lastHitNormal) then
        return p80;
    end;

    local _lastHitNormal = p81._lastHitNormal;

    if _lastHitNormal.Magnitude < 0.0001 then
        return p80;
    end;

    local v83 = p80:Dot(_lastHitNormal);

    if v83 >= 0 then
        return p80;
    end;

    if math.abs(v83) < 10 then
        return p80;
    end;

    local v84 = p80 - v83 * _lastHitNormal;
    local v85 = p81.Events and p81.Events.OnHit and (p81.Events.OnHit.Friction or 0.2) or 0.2;
    local v86;

    if p81._accelVel then
        local _accelVel = p81._accelVel;
        v86 = _accelVel - _accelVel:Dot(_lastHitNormal) * _lastHitNormal;
    else
        v86 = Vector3.new(0, 0, 0);
    end;

    local Magnitude = v86.Magnitude;
    local v87 = v85 * math.abs(v83);

    if Magnitude <= 0.0001 then
        return v84.Magnitude <= v87 and Vector3.new(0, 0, 0) or v84 - v84.Unit * v87;
    end;

    local v88 = -v86.Unit * v87;

    if Magnitude < v87 * (p82 or 0.016666666666666666) then
        v88 = -v86 / (p82 or 0.016666666666666666);
    end;

    return v84 + v88;
end;

return u2;