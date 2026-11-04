 

 

return table.freeze({
    select = function(p1, p2, p3) -- Line: 3, Name: select
        local v4 = p2 / math.max(p3, 0.01);
        local math_clamp_ret = math.clamp(v4, 0, 1);
        local v5 = p1.Variants[1];

        for _, v in p1.Variants do
            if v.MinSpeedRatio <= math_clamp_ret then
                v5 = v;
            end;
        end;

        local table_clone_ret = table.clone(p1);

        for i, v in v5 do
            table_clone_ret[i] = v;
        end;

        table_clone_ret.EntrySpeed = math.clamp(p2, 0, p3);
        table_clone_ret.SpeedRatio = math_clamp_ret;
        local math_max_ret = math.max(v5.Distance * (p1.DistanceMultiplier or 1), table_clone_ret.EntrySpeed * table_clone_ret.Duration * (p1.RunDistanceMultiplier or 1));
        local Duration = table_clone_ret.Duration;
        local math_min_ret = math.min(table_clone_ret.MotionBlendIn or 0.02, Duration * 0.25);
        local v6 = Duration - (math_min_ret + math.min(table_clone_ret.MotionBrake or 0.12, Duration * 0.45)) / 2;
        local EntrySpeed = table_clone_ret.EntrySpeed;
        local v7 = math_max_ret / math.max(math_min_ret, 0.001);
        local math_clamp_ret2 = math.clamp(EntrySpeed, 0, v7);
        local math_max_ret2 = math.max(0, (math_max_ret - math_clamp_ret2 * math_min_ret / 2) / v6);
        local math_clamp_ret3 = math.clamp(p1.BoostStrength or 1, 0, 1);
        local v8 = math.min(math_max_ret2, math_clamp_ret2) + math.max(0, math_max_ret2 - math_clamp_ret2) * math_clamp_ret3;
        local v9 = math_clamp_ret2 * math_min_ret / 2 + v8 * v6;
        table_clone_ret.Distance = math.min(v9, p1.MaxDistance or (1 / 0));
        local v10 = v9 > 0 and (table_clone_ret.Distance / v9 or 1) or 1;
        local Duration2 = table_clone_ret.Duration;
        table_clone_ret.Duration = Duration2 * v10;
        table_clone_ret.MotionBlendIn = (table_clone_ret.MotionBlendIn or 0.02) * v10;
        table_clone_ret.MotionBrake = (table_clone_ret.MotionBrake or 0.12) * v10;
        table_clone_ret.Recovery = table_clone_ret.Recovery + (Duration2 - table_clone_ret.Duration);

        return table_clone_ret;
    end
});