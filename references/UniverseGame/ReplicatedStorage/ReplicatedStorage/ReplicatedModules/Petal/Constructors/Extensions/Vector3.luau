  

 

local u1 = Vector3;
local atan2 = math.atan2;
local v6 = setmetatable({
    Zero = Vector3.new(0, 0, 0),
    Huge = Vector3.new(inf, inf, inf),
    _loadOrder = 2,
    Up = u1.yAxis,
    Down = -u1.yAxis,
    Left = u1.xAxis,
    Right = -u1.xAxis,
    Front = u1.zAxis,
    Back = -u1.zAxis,

    Angle = function(p2, p3) -- Line: 21, Name: Angle
        -- upvalues: atan2 (copy)
        local v4 = p2:VectorToObjectSpace(p3) * Vector3.new(1, 0, 1);

        return atan2(v4.Z, v4.X);
    end,

    Plane = function(p5) -- Line: 28, Name: Plane
        return typeof(p5) == "Vector3" and p5 * Vector3.new(1, 0, 1) or p5.Position * Vector3.new(1, 0, 1);
    end
}, {});

function GetFromKey(p7, p8)
    -- upvalues: u1 (copy)
    if u1[p8:lower()] == nil then
        return rawget(p7, p8) or nil;
    end;

    return u1[p8:lower()];
end;

getmetatable(v6).__index = GetFromKey;
getmetatable(v6).__call = GetFromKey;

return v6;