 

 

local u4 = {
    totalForTier = function(p1, p2) -- Line: 4, Name: totalForTier
        local v3 = math.min(p2.MaxTier, p1) - 1;
        local math_max_ret = math.max(0, v3);

        return math_max_ret * p2.FirstTierXP + p2.TierStepXP * math_max_ret * (math_max_ret - 1) / 2;
    end
};

function u4.state(p5, p6) -- Line: 8
    -- upvalues: u4 (copy)
    local math_floor_ret = math.floor(p5 or 0);
    local math_max_ret = math.max(0, math_floor_ret);
    local v7 = 1;

    while v7 < p6.MaxTier and u4.totalForTier(v7 + 1, p6) <= math_max_ret do
        v7 = v7 + 1;
    end;

    local v8 = u4.totalForTier(v7, p6);
    local v9 = v7 < p6.MaxTier and (u4.totalForTier(v7 + 1, p6) - v8 or 0) or 0;

    return {
        tier = v7,
        earned = math_max_ret - v8,
        needed = v9,
        ratio = v9 > 0 and math.clamp((math_max_ret - v8) / v9, 0, 1) or 1,
        complete = v7 == p6.MaxTier
    };
end;

return u4;