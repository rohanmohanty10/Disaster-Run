 

 

local u24 = {
    speed = function(p1, p2) -- Line: 2, Name: speed
        return 20 + 60 * ((p1 - 1) / (p2 - 1)) ^ 1.35;
    end,

    interval = function(p3, p4) -- Line: 5, Name: interval
        local v5 = math.max(1.4, 90 / p4) + p3 % 3 * 0.15;

        if p3 >= 16 then
            v5 = v5 / 1.15 or v5;
        end;

        return v5;
    end,

    position = function(p6, p7, p8, p9, p10) -- Line: 10, Name: position
        local v11 = p7.x + math.max(0, p8 - p7.born) * p6.speed * p6.direction;
        local math_clamp_ret = math.clamp((v11 + p9) / (2 * p9) * 20, 0, 20);
        local math_floor_ret = math.floor(math_clamp_ret);
        local math_min_ret = math.min(19, math_floor_ret);
        local v12 = p6.center + p10 * v11;

        return Vector3.new(v12.X, p6.samples[math_min_ret + 1].Y + (p6.samples[math_min_ret + 2].Y - p6.samples[math_min_ret + 1].Y) * (math_clamp_ret - math_min_ret) + 3, v12.Z), v11;
    end,

    contact = function(p13, p14, p15, p16, p17) -- Line: 18, Name: contact
        local v18 = p13 - p15;
        local v19 = p14 - p16 - v18;
        local v20;

        if v19:Dot(v19) > 0 then
            local v21 = -v18:Dot(v19) / v19:Dot(v19);
            v20 = math.clamp(v21, 0, 1) or 0;
        else
            v20 = 0;
        end;

        return (v18 + v19 * v20).Magnitude <= p17;
    end,

    finite = function(p22) -- Line: 24, Name: finite
        local v23;

        if type(p22) == "number" and p22 == p22 then
            v23 = math.abs(p22) < 1000000000000;
        else
            v23 = false;
        end;

        return v23;
    end
};

function u24.vector(p25) -- Line: 27
    -- upvalues: u24 (copy)
    local v26;

    if typeof(p25) == "Vector3" then
        v26 = u24.finite(p25.X) and u24.finite(p25.Y) and u24.finite(p25.Z);
    else
        v26 = false;
    end;

    return v26;
end;

return u24;