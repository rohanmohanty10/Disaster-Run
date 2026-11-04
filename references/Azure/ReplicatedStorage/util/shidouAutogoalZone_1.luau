 
 

local CFrame_new_ret = CFrame.new(-5, 0, -17);
local u3 = {
    getZoneCFrame = function(p1: userdata) -- Line: 14, Name: getZoneCFrame
        -- upvalues: CFrame_new_ret (copy)
        return p1.CFrame * CFrame_new_ret;
    end,

    getGroundCFrame = function(p2: userdata) -- Line: 18, Name: getGroundCFrame
        -- upvalues: CFrame_new_ret (copy)
        return p2.CFrame * CFrame_new_ret * CFrame.new(0, -2.931, 0);
    end,

    getZoneSize = function() -- Line: 22, Name: getZoneSize
        return Vector3.new(45, 50, 45);
    end,

    getGroundSize = function() -- Line: 26, Name: getGroundSize
        return Vector3.new(45, 0.15, 45);
    end
};

function u3.isWithinHighlightRange(p4: vector, p5: userdata) -- Line: 30
    -- upvalues: u3 (copy)
    local v6 = u3.getZoneCFrame(p5):PointToObjectSpace(p4);
    local math_clamp_ret = math.clamp(v6.X, -22.5, 22.5);
    local math_clamp_ret2 = math.clamp(v6.Y, -25, 25);
    local math_clamp_ret3 = math.clamp(v6.Z, -22.5, 22.5);

    return (v6 - Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3)).Magnitude <= 50;
end;

return u3;