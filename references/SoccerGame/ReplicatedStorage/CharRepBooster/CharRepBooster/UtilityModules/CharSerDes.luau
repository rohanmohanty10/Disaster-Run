  

local u1 = {
    DEFAULTS = {
        RAD_MULTIPLIER = 5000,
        VECTOR_DECIMAL_PRECISION = 1
    },
    WARN_ON_BOUNDS_EXCEEDED = false,
    BOUND_BEHAVIOR = "USE_RAW"
};

function u1.ClampForInt16(p2: any, p3: string) -- Line: 43
    -- upvalues: u1 (copy)
    local math_clamp_ret = math.clamp(p2, -32768, 32767);
    local v4;

    if math_clamp_ret == p2 then
        v4 = false;
    elseif u1.WARN_ON_BOUNDS_EXCEEDED then
        warn("Component exceeded bounds and has been clamped:", p2, " | ", p3);
        v4 = true;
    else
        v4 = true;
    end;

    return math_clamp_ret, v4;
end;

function u1.SerializeVector3(p5: vector, p6: number?) -- Line: 55
    -- upvalues: u1 (copy)
    local v7 = 10 ^ (p6 or u1.DEFAULTS.VECTOR_DECIMAL_PRECISION);
    local v8, v9 = u1.ClampForInt16(p5.X * v7, "X");
    local v10, v11 = u1.ClampForInt16(p5.Y * v7, "Y");
    local v12, v13 = u1.ClampForInt16(p5.Z * v7, "Z");

    if (v9 or (v11 or v13)) and u1.BOUND_BEHAVIOR == "USE_RAW" then
        return p5;
    end;

    return Vector3int16.new(v8, v10, v12);
end;

function u1.DeserializeVector3(p14: any, p15: number?) -- Line: 71
    -- upvalues: u1 (copy)
    if typeof(p14) ~= "Vector3int16" then
        return p14;
    end;

    local v16 = 10 ^ (p15 or u1.DEFAULTS.VECTOR_DECIMAL_PRECISION);

    return Vector3.new(p14.X / v16, p14.Y / v16, p14.Z / v16);
end;

local function _normalizeAngle(p17) -- Line: 86
    local math_deg_ret = math.deg(p17);

    while math_deg_ret > 180 do
        math_deg_ret = math_deg_ret - 360;
    end;

    while math_deg_ret <= -180 do
        math_deg_ret = math_deg_ret + 360;
    end;

    return math.rad(math_deg_ret);
end;

local function _normalizeCFrameOrientation(p18) -- Line: 92
    local v19, v20, v21 = p18:ToEulerAnglesXYZ();
    local math_deg_ret = math.deg(v19);

    while math_deg_ret > 180 do
        math_deg_ret = math_deg_ret - 360;
    end;

    while math_deg_ret <= -180 do
        math_deg_ret = math_deg_ret + 360;
    end;

    local math_rad_ret = math.rad(math_deg_ret);
    local math_deg_ret2 = math.deg(v20);

    while math_deg_ret2 > 180 do
        math_deg_ret2 = math_deg_ret2 - 360;
    end;

    while math_deg_ret2 <= -180 do
        math_deg_ret2 = math_deg_ret2 + 360;
    end;

    local math_rad_ret2 = math.rad(math_deg_ret2);
    local math_deg_ret3 = math.deg(v21);

    while math_deg_ret3 > 180 do
        math_deg_ret3 = math_deg_ret3 - 360;
    end;

    while math_deg_ret3 <= -180 do
        math_deg_ret3 = math_deg_ret3 + 360;
    end;

    local math_rad_ret3 = math.rad(math_deg_ret3);
    local v22 = math.abs(math_rad_ret) - 3.141592653589793;

    if math.abs(v22) < 0.000017453292519943296 then
        local math_deg_ret4 = math.deg(math_rad_ret3 + 3.141592653589793);
        math_rad_ret = 0;

        while math_deg_ret4 > 180 do
            math_deg_ret4 = math_deg_ret4 - 360;
        end;

        while math_deg_ret4 <= -180 do
            math_deg_ret4 = math_deg_ret4 + 360;
        end;

        math_rad_ret3 = math.rad(math_deg_ret4);
    end;

    local v23 = math.abs(math_rad_ret3) - 3.141592653589793;

    if math.abs(v23) < 0.000017453292519943296 then
        local math_deg_ret4 = math.deg(math_rad_ret + 3.141592653589793);
        math_rad_ret3 = 0;

        while math_deg_ret4 > 180 do
            math_deg_ret4 = math_deg_ret4 - 360;
        end;

        while math_deg_ret4 <= -180 do
            math_deg_ret4 = math_deg_ret4 + 360;
        end;

        math_rad_ret = math.rad(math_deg_ret4);
    end;

    return CFrame.Angles(math_rad_ret, math_rad_ret2, math_rad_ret3);
end;

function u1.SmartSerializeRootCFrame(p24, p25: number?) -- Line: 119
    -- upvalues: _normalizeCFrameOrientation (copy), u1 (copy)
    local v26, _, v27 = _normalizeCFrameOrientation(p24):ToEulerAnglesXYZ();
    local math_deg_ret = math.deg(v26);

    if math.abs(math_deg_ret) < 1 then
        local math_deg_ret2 = math.deg(v27);

        if math.abs(math_deg_ret2) < 1 then
            return u1.SerializeRootCFrame(p24, p25);
        end;
    end;

    return u1.SerializeCFrame(p24, p25);
end;

function u1.SmartDeserializeRootCFrame(p28: any, p29: any, p30: number?) -- Line: 129
    -- upvalues: u1 (copy)
    if typeof(p28) == "CFrame" then
        return p28;
    end;

    if typeof(p28) == "Vector3int16" then
        return u1.DeserializeCFrame(p28, p29, p30);
    end;

    if typeof(p28) == "Vector2int16" then
        return u1.DeserializeRootCFrame(p28, p29, p30);
    end;

    error("Unrecognized type " .. (typeof(p28) or "?"));
end;

function u1.SerializeRootCFrame(p31, p32: number?) -- Line: 142
    -- upvalues: u1 (copy)
    local LookVector = p31.LookVector;
    local math_atan2_ret = math.atan2(-LookVector.X, -LookVector.Z);
    local math_deg_ret = math.deg(math_atan2_ret);

    if math_deg_ret < 0 then
        math_deg_ret = math_deg_ret + 360;
    end;

    local math_rad_ret = math.rad(math_deg_ret);
    local Position = p31.Position;
    local v33 = 10 ^ (p32 or u1.DEFAULTS.VECTOR_DECIMAL_PRECISION);
    local RAD_MULTIPLIER = u1.DEFAULTS.RAD_MULTIPLIER;
    local v34, v35 = u1.ClampForInt16(Position.X * v33, "X");
    local v36, v37 = u1.ClampForInt16(Position.Y * v33, "Y");
    local v38, v39 = u1.ClampForInt16(Position.Z * v33, "Z");
    local v40, v41 = u1.ClampForInt16(math_rad_ret * RAD_MULTIPLIER, "Yaw");

    if (v35 or (v37 or (v39 or v41))) and u1.BOUND_BEHAVIOR == "USE_RAW" then
        return p31;
    end;

    return Vector2int16.new(v34, v36), Vector2int16.new(v38, v40);
end;

function u1.DeserializeRootCFrame(p42: userdata, p43: userdata, p44: number?) -- Line: 170
    -- upvalues: u1 (copy)
    local v45 = 10 ^ (p44 or u1.DEFAULTS.VECTOR_DECIMAL_PRECISION);
    local RAD_MULTIPLIER = u1.DEFAULTS.RAD_MULTIPLIER;
    local Vector3_new_ret = Vector3.new(p42.X / v45, p42.Y / v45, p43.X / v45);
    local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ(0, p43.Y / RAD_MULTIPLIER, 0);

    return CFrame.new(Vector3_new_ret) * CFrame_fromEulerAnglesXYZ_ret;
end;

function u1.SerializeCFrame(p46, p47: number?) -- Line: 186
    -- upvalues: u1 (copy)
    local v48, v49, v50 = p46:ToEulerAnglesXYZ();
    local Position = p46.Position;
    local v51 = 10 ^ (p47 or u1.DEFAULTS.VECTOR_DECIMAL_PRECISION);
    local RAD_MULTIPLIER = u1.DEFAULTS.RAD_MULTIPLIER;
    local v52, v53 = u1.ClampForInt16(Position.X * v51, "X");
    local v54, v55 = u1.ClampForInt16(Position.Y * v51, "Y");
    local v56, v57 = u1.ClampForInt16(Position.Z * v51, "Z");
    local v58, v59 = u1.ClampForInt16(v48 * RAD_MULTIPLIER, "Yaw");
    local v60, v61 = u1.ClampForInt16(v49 * RAD_MULTIPLIER, "Pitch");
    local v62, v63 = u1.ClampForInt16(v50 * RAD_MULTIPLIER, "Roll");

    if (v53 or (v55 or (v57 or (v59 or (v61 or v63))))) and u1.BOUND_BEHAVIOR == "USE_RAW" then
        return p46;
    end;

    return Vector3int16.new(v52, v54, v56), Vector3int16.new(v58, v60, v62);
end;

function u1.DeserializeCFrame(p64: userdata, p65: userdata, p66: number?) -- Line: 213
    -- upvalues: u1 (copy)
    local v67 = 10 ^ (p66 or u1.DEFAULTS.VECTOR_DECIMAL_PRECISION);
    local RAD_MULTIPLIER = u1.DEFAULTS.RAD_MULTIPLIER;
    local Vector3_new_ret = Vector3.new(p64.X / v67, p64.Y / v67, p64.Z / v67);
    local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ(p65.X / RAD_MULTIPLIER, p65.Y / RAD_MULTIPLIER, p65.Z / RAD_MULTIPLIER);

    return CFrame.new(Vector3_new_ret) * CFrame_fromEulerAnglesXYZ_ret;
end;

return u1;