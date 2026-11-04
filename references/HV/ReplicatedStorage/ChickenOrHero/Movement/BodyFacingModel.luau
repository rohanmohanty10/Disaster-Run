 

 

local u1 = {};

local function wrap(p2) -- Line: 3
    local math_sin_ret = math.sin(p2);
    local math_cos_ret = math.cos(p2);

    return math.atan2(math_sin_ret, math_cos_ret);
end;

local function yaw(p3) -- Line: 4
    return math.atan2(-p3.X, -p3.Z);
end;

local function smooth(p4) -- Line: 5
    local math_clamp_ret = math.clamp(p4, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.angle(p5, p6) -- Line: 6
    if p5.Magnitude < 0.001 or p6.Magnitude < 0.001 then
        return 0;
    end;

    local v7 = p5.Unit:Dot(p6.Unit);
    local math_clamp_ret = math.clamp(v7, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret);

    return math.deg(math_acos_ret);
end;

function u1.speedMultiplier(p8, p9, p10) -- Line: 10
    -- upvalues: u1 (copy)
    if not (p10.Enabled and p10.SpeedPenaltyEnabled) then
        return 1;
    end;

    local v11 = u1.angle(p8, p9);
    local math_clamp_ret = math.clamp(p10.SideSpeedMultiplier, 0.1, 1);
    local math_clamp_ret2 = math.clamp(p10.BackSpeedMultiplier, 0.1, math_clamp_ret);

    if v11 > 90 then
        local math_clamp_ret3 = math.clamp((v11 - 90) / 90, 0, 1);

        return math_clamp_ret + (math_clamp_ret2 - math_clamp_ret) * (math_clamp_ret3 * math_clamp_ret3 * (3 - 2 * math_clamp_ret3));
    end;

    local v12 = (v11 - p10.SlowdownStartsAt) / math.max(1, 90 - p10.SlowdownStartsAt);
    local math_clamp_ret3 = math.clamp(v12, 0, 1);

    return 1 + (math_clamp_ret - 1) * (math_clamp_ret3 * math_clamp_ret3 * (3 - 2 * math_clamp_ret3));
end;

function u1.step(p13, p14, p15, p16, p17, p18) -- Line: 20
    local math_atan2_ret = math.atan2(-p15.X, -p15.Z);
    local v19 = p14.Magnitude >= p18.MovementThreshold;
    local v20;

    if v19 then
        local v21 = math.atan2(-p14.X, -p14.Z) - math_atan2_ret;
        local math_sin_ret = math.sin(v21);
        local math_cos_ret = math.cos(v21);
        v20 = math.atan2(math_sin_ret, math_cos_ret) or 0;
    else
        v20 = 0;
    end;

    local math_rad_ret = math.rad(p18.MaxTravelYaw);
    local v22;

    if math.abs(v20) > 1.5707963267948966 then
        v22 = math.sign(v20) * (3.141592653589793 - math.abs(v20));
    else
        v22 = v20;
    end;

    local v23 = math_atan2_ret + math.clamp(v22, -math_rad_ret, math_rad_ret);
    local v24 = v19 and p18.BodyFollowRate or p18.IdleFollowRate;
    p13.worldYaw = p13.worldYaw or math_atan2_ret;
    local worldYaw = p13.worldYaw;
    local v25 = v23 - p13.worldYaw;
    local math_sin_ret = math.sin(v25);
    local math_cos_ret = math.cos(v25);
    local math_atan2_ret2 = math.atan2(math_sin_ret, math_cos_ret);
    local v26 = -v24 * math.clamp(p17, 0, 0.1);
    p13.worldYaw = worldYaw + math_atan2_ret2 * (1 - math.exp(v26));
    local v27 = p13.worldYaw - math_atan2_ret;
    local math_sin_ret2 = math.sin(v27);
    local math_cos_ret2 = math.cos(v27);
    local math_atan2_ret3 = math.atan2(math_sin_ret2, math_cos_ret2);
    local math_clamp_ret = math.clamp(math_atan2_ret3, -math_rad_ret, math_rad_ret);
    p13.worldYaw = math_atan2_ret + math_clamp_ret;
    local v28 = math_clamp_ret * p18.TorsoLookShare;
    local v29 = -math.rad(p18.MaxHipTwist);
    local math_rad_ret2 = math.rad(p18.MaxHipTwist);
    local math_clamp_ret2 = math.clamp(v28, v29, math_rad_ret2);
    local v30 = math_clamp_ret - math_clamp_ret2;
    local v31 = -math.rad(p18.MaxHeadYaw);
    local math_rad_ret3 = math.rad(p18.MaxHeadYaw);
    local v32 = {
        torso = v30,
        hip = math_clamp_ret2,
        head = math.clamp(-v30, v31, math_rad_ret3)
    };
    local v33 = -math.rad(p18.MaxHeadPitch);
    local math_rad_ret4 = math.rad(p18.MaxHeadPitch);
    v32.pitch = math.clamp(p16, v33, math_rad_ret4);
    local math_abs_ret = math.abs(v20);
    v32.angle = math.deg(math_abs_ret);
    v32.gait = v19 and (math.abs(v20) > 1.5707963267948966 and "Backward" or "Forward") or "Idle";

    return v32;
end;

return u1;