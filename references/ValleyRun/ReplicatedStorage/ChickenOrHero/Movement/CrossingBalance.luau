 

 

local CrossingBalance = require(script.Parent.MovementConfig).CrossingBalance;
local u1 = {};
local u2 = {};

function u1.tuning(p3) -- Line: 8
    -- upvalues: CrossingBalance (copy), u2 (copy)
    if type(p3) ~= "string" or type(CrossingBalance[p3]) ~= "table" then
        return CrossingBalance;
    end;

    local v4 = u2[p3];

    if not v4 then
        local v5 = {};

        for i, v in CrossingBalance do
            if type(v) ~= "table" then
                v5[i] = v;
            end;
        end;

        for i, v in CrossingBalance[p3] do
            v5[i] = v;
        end;

        v4 = table.freeze(v5);
        u2[p3] = v4;
    end;

    return v4;
end;

function u1.calculate(p6, p7, p8) -- Line: 22
    -- upvalues: u1 (copy)
    local v9 = u1.tuning(p8);
    local math_floor_ret = math.floor(p6);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(p7);
    local math_max_ret2 = math.max(0, math_floor_ret2);
    local v10 = math_max_ret + math_max_ret2;
    local v11 = not (v9.Enabled and (math_max_ret > 0 and (math_max_ret2 > 0 and v10 > 2))) and 0 or math.clamp((math_max_ret - 1) / (v10 - 2), 0, 1) ^ v9.PressureExponent;

    return {
        catchers = math_max_ret,
        runners = math_max_ret2,
        pressure = v11,
        runnerScale = 1 + v9.RunnerMaxBonus * v11,
        catcherScale = 1 - v9.CatcherMaxReduction * v11
    };
end;

return table.freeze(u1);