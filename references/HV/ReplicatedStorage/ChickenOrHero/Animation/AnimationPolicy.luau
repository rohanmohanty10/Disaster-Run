 

 

local u1 = {};

local function smooth(p2) -- Line: 3
    local math_clamp_ret = math.clamp(p2, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.angle(p3, p4) -- Line: 4
    if p3.Magnitude < 0.01 or p4.Magnitude < 0.01 then
        return 0;
    end;

    local Y = p4:Cross(p3).Y;
    local v5 = p4:Dot(p3);
    local math_atan2_ret = math.atan2(Y, v5);

    return math.deg(math_atan2_ret);
end;

function u1.poseScale(p6) -- Line: 8
    local v7 = (math.abs(p6) - 90) / 45;
    local math_clamp_ret = math.clamp(v7, 0, 1);

    return 1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.weights(p8, p9, p10, p11) -- Line: 11
    -- upvalues: u1 (copy)
    local math_abs_ret = math.abs(p9);
    local v12 = math_abs_ret - (math_abs_ret <= 90 and math_abs_ret and math_abs_ret or 180 - math_abs_ret) * u1.poseScale(p9);
    local math_max_ret = math.max(0, v12);
    local math_clamp_ret = math.clamp((math_max_ret - 90) / 90, 0, 1);
    local v13 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
    local v14;

    if math_max_ret <= 90 then
        local math_clamp_ret2 = math.clamp(math_max_ret / 90, 0, 1);
        v14 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2) or 1 - v13;
    else
        v14 = 1 - v13;
    end;

    local math_max_ret2 = math.max(0, 1 - v14 - v13);
    local math_clamp_ret2 = math.clamp((p8 - 0.2) / 1.8, 0, 1);
    local v15 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2);
    local math_clamp_ret3 = math.clamp((p8 / p10 - p11.RunBlendStart) / (p11.RunBlendEnd - p11.RunBlendStart), 0, 1);
    local v16 = math_clamp_ret3 * math_clamp_ret3 * (3 - 2 * math_clamp_ret3);

    return {
        Idle = 1 - v15,
        Walk = v15 * math_max_ret2 * (1 - v16),
        Run = v15 * math_max_ret2 * v16,
        Left = p9 >= 0 and (v15 * v14 or 0) or 0,
        Right = p9 < 0 and (v15 * v14 or 0) or 0,
        Back = v15 * v13
    };
end;

return u1;