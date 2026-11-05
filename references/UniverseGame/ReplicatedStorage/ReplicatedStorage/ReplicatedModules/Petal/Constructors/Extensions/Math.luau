  

 

local v11 = setmetatable({
    Pi = 3.141592653589793,
    Tau = 6.283185307179586,
    _loadOrder = 1,
    Abs = math.abs,
    Max = math.max,
    Min = math.min,
    Clamp = math.clamp,
    Cos = math.cos,
    Sin = math.sin,
    Tan = math.tan,
    Acos = math.acos,
    Asin = math.asin,
    Atan = math.atan,
    Atan2 = math.atan2,

    Rng = function(p1, p2) -- Line: 19, Name: Rng
        return Random.new():NextNumber(p1 or 0, p2 or 1);
    end,

    Round = function(p3) -- Line: 22, Name: Round
        return math.floor(p3 + 0.5);
    end,

    Diff = function(p4, p5) -- Line: 25, Name: Diff
        return math.abs(p4 - p5);
    end,

    Lerp = function(p6, p7, p8) -- Line: 28, Name: Lerp
        return p6 + (p7 - p6) * p8;
    end,

    Sqrt = function(p9, p10) -- Line: 31, Name: Sqrt
        return p9 ^ (1 / ((p10 == nil or not p10) and 2 or p10));
    end
}, {});

function GetFromKey(p12, p13)
    if math[p13:lower()] == nil then
        return rawget(p12, p13) or nil;
    end;

    return math[p13:lower()];
end;

getmetatable(v11).__index = GetFromKey;
getmetatable(v11).__call = GetFromKey;

return v11;