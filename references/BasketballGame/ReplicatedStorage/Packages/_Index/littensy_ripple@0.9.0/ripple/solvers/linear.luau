 
 

require(script.Parent.Parent.types);
local config = require(script.Parent.Parent.config);
local intermediate = require(script.Parent.Parent.utils.intermediate);

local function configure(p1) -- Line: 5
    -- upvalues: config (copy)
    if type(p1) == "table" then
        p1 = p1.speed;
    end;

    return {
        speed = p1 or config.linear.default.speed
    };
end;

return function(p2, p3) -- Line: 13, Name: linear
    -- upvalues: config (copy), intermediate (copy)
    if type(p3) == "table" then
        p3 = p3.speed;
    end;

    local u4 = {
        speed = p3 or config.linear.default.speed
    };
    local u5 = intermediate.to(p2);

    return function(p6, p7, p8) -- Line: 17
        -- upvalues: intermediate (ref), u5 (copy), u4 (copy)
        local v9 = intermediate.index(u5, p6);

        if not v9 then
            return false;
        end;

        local v10 = u4.speed * p8 * math.sign(v9 - p7.value);

        if math.abs(v10) < math.abs(v9 - p7.value) then
            p7.value = p7.value + v10;
            p7.velocity = v10;

            return;
        end;

        p7.complete = true;
        p7.value = v9;
        p7.velocity = 0;
    end;
end;