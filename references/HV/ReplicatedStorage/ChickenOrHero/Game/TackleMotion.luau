 

 

local u7 = {
    distance = function(p1, p2) -- Line: 3, Name: distance
        local math_max_ret = math.max(p1.Duration, 0.01);
        local math_min_ret = math.min(p1.MotionBlendIn or 0.02, math_max_ret * 0.25);
        local math_min_ret2 = math.min(p1.MotionBrake or 0.12, math_max_ret * 0.45);
        local v3 = p1.EntrySpeed or 0;
        local v4 = p1.Distance / math.max(math_min_ret, 0.001);
        local math_clamp_ret = math.clamp(v3, 0, v4);
        local math_max_ret2 = math.max(0, (p1.Distance - math_clamp_ret * math_min_ret / 2) / (math_max_ret - (math_min_ret + math_min_ret2) / 2));
        local math_clamp_ret2 = math.clamp(p2, 0, math_max_ret);

        if math_clamp_ret2 <= math_min_ret then
            return math_clamp_ret * math_clamp_ret2 + (math_max_ret2 - math_clamp_ret) * math_clamp_ret2 * math_clamp_ret2 / (math_min_ret * 2);
        end;

        local v5 = (math_clamp_ret + math_max_ret2) * math_min_ret / 2;

        if math_clamp_ret2 <= math_max_ret - math_min_ret2 then
            return v5 + math_max_ret2 * (math_clamp_ret2 - math_min_ret);
        end;

        local v6 = math_clamp_ret2 - (math_max_ret - math_min_ret2);

        return v5 + math_max_ret2 * (math_max_ret - math_min_ret2 - math_min_ret) + math_max_ret2 * v6 - math_max_ret2 * v6 * v6 / (math_min_ret2 * 2);
    end
};

function u7.speed(p8, p9, p10) -- Line: 17
    -- upvalues: u7 (copy)
    if p10 <= 0 then
        return 0;
    end;

    local v11 = (u7.distance(p8, p9 + p10) - u7.distance(p8, p9)) / p10;

    return math.max(0, v11);
end;

return table.freeze(u7);