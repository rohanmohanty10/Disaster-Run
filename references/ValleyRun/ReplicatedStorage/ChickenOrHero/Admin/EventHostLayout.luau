 

 

return table.freeze({
    panel = function(p1, p2, p3) -- Line: 2, Name: panel
        if p3 and p3 > 0 then
            p2 = math.min(p2, p3);
        end;

        local math_min_ret = math.min(680, p1 * 0.9);
        local math_max_ret = math.max(1, math_min_ret);
        local v4 = math.min(760, p2 * 0.92) * 0.7;
        local math_max_ret2 = math.max(1, v4);

        if math_max_ret >= 560 then
            return math_max_ret, math_max_ret2, p2, 2;
        end;

        return math_max_ret, math_max_ret2, p2, 1;
    end,

    toast = function(p5, p6) -- Line: 10, Name: toast
        return math.min(760, p5 * 0.92), math.clamp(p6 * 0.18, 84, 144) * 0.7;
    end
});