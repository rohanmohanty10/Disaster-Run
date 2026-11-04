  

require(script.Parent.Parent.types);
local config = require(script.Parent.Parent.config);
local intermediate = require(script.Parent.Parent.utils.intermediate);

local function configure(p1) -- Line: 8
    -- upvalues: config (copy)
    local v2 = p1.mass or 1;
    local v3 = p1.tension or config.spring.default.tension;
    local v4 = p1.friction or config.spring.default.friction;

    if p1.frequency or p1.damping then
        local v5 = p1.frequency or 0.5;
        v3 = (6.283185307179586 / v5) ^ 2 * v2;
        v4 = 12.566370614359172 * (p1.damping or 1) * v2 / v5;
    end;

    return {
        mass = v2,
        tension = v3,
        friction = v4,
        position = p1.position,
        velocity = p1.velocity,
        impulse = p1.impulse,
        restingVelocity = p1.restingVelocity or 0.001,
        restingPosition = p1.restingPosition or 0.0001
    };
end;

return function(p6, p7) -- Line: 32, Name: spring
    -- upvalues: configure (copy), intermediate (copy)
    local u8 = configure(p7 or {});
    local u9 = intermediate.to(p6);
    local u10 = true;

    return function(p11, p12, p13) -- Line: 37
        -- upvalues: intermediate (ref), u9 (copy), u10 (ref), u8 (copy)
        local v14 = intermediate.index(u9, p11);

        if not v14 then
            return false;
        end;

        if u10 then
            u10 = false;
            p12.value = u8.position or (p12.value or 0);
            p12.velocity = (u8.velocity or (p12.velocity or 0)) + (u8.impulse or 0);
        end;

        local value = p12.value;
        local v15 = p12.velocity or 0;
        local math_ceil_ret = math.ceil(p13 * 1000 / 1);

        for i = 1, math.min(math_ceil_ret, 100) do
            v15 = v15 + (-u8.tension * 1e-6 * (value - v14) + -u8.friction * 0.001 * v15) / u8.mass * 1;
            value = value + v15 * 1;
            local _ = i;
        end;

        if math.abs(v15) >= u8.restingVelocity or math.abs(value - v14) >= u8.restingPosition then
            p12.value = value;
            p12.velocity = v15;

            return;
        end;

        p12.complete = true;
        p12.value = v14;
        p12.velocity = 0;
    end;
end;