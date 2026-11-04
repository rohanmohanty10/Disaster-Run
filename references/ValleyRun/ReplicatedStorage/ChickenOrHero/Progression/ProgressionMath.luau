 

 

local ProgressionConfig = require(script.Parent.ProgressionConfig);
local u9 = {
    crossing = function(p1, p2, p3) -- Line: 4, Name: crossing
        -- upvalues: ProgressionConfig (copy)
        local v4 = p3 or ProgressionConfig;

        return (p1 <= 0 or p2 <= 0) and 0 or math.round(v4.CrossingBaseXP + v4.CrossingPressureXP * p1 / (p1 + p2));
    end,

    totalForLevel = function(p5, p6) -- Line: 9, Name: totalForLevel
        -- upvalues: ProgressionConfig (copy)
        local v7 = p6 or ProgressionConfig;
        local v8 = math.floor(p5) - 1;
        local math_max_ret = math.max(0, v8);

        return math_max_ret * v7.FirstLevelXP + v7.LevelStepXP * math_max_ret * (math_max_ret - 1) / 2;
    end
};

function u9.state(p10, p11) -- Line: 14
    -- upvalues: ProgressionConfig (copy), u9 (copy)
    local v12 = p11 or ProgressionConfig;
    local v13;

    if type(p10) == "number" and p10 == p10 then
        local math_floor_ret = math.floor(p10);
        v13 = math.clamp(math_floor_ret, 0, 9000000000000000) or 0;
    else
        v13 = 0;
    end;

    local FirstLevelXP = v12.FirstLevelXP;
    local LevelStepXP = v12.LevelStepXP;
    local v14;

    if LevelStepXP == 0 then
        v14 = math.floor(v13 / FirstLevelXP);
    else
        local v15 = 2 * FirstLevelXP - LevelStepXP;
        local v16 = (-v15 + math.sqrt(v15 * v15 + 8 * LevelStepXP * v13)) / (2 * LevelStepXP);
        v14 = math.floor(v16);
    end;

    local math_max_ret = math.max(1, v14 + 1);

    while u9.totalForLevel(math_max_ret + 1, v12) <= v13 do
        math_max_ret = math_max_ret + 1;
    end;

    while v13 < u9.totalForLevel(math_max_ret, v12) do
        math_max_ret = math_max_ret - 1;
    end;

    local v17 = FirstLevelXP + LevelStepXP * (math_max_ret - 1);
    local v18 = v13 - u9.totalForLevel(math_max_ret, v12);

    return {
        total = v13,
        level = math_max_ret,
        earned = v18,
        needed = v17,
        ratio = v18 / v17
    };
end;

return u9;