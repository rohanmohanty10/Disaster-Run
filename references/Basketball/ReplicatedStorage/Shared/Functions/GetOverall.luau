 
 

local StatsSettings = require(script.Parent.Parent.Tables.StatsSettings);

return function(p1) -- Line: 3
    -- upvalues: StatsSettings (copy)
    local v2 = 50;

    for i, v in pairs(StatsSettings.CalculateOVR) do
        v2 = v2 + (p1[i] or 0) / v.OnePoint / math.clamp(((p1.Matches or 0) + 1) / 15, 1, v.MatchFactor);
    end;

    local math_min_ret = math.min(v2, 100);

    return math.ceil(math_min_ret);
end;