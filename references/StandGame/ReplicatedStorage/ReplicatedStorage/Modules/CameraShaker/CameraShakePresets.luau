 

 

local l__CameraShakeInstance__1 = require(script.Parent.CameraShakeInstance);
local u8 = {
    Bump = function() --[[ Name: Bump, Line 26 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v1 = l__CameraShakeInstance__1.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v1.RotationInfluence = Vector3.new(1, 1, 1);
        return v1;
    end,
    Explosion = function() --[[ Name: Explosion, Line 36 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v2 = l__CameraShakeInstance__1.new(5, 10, 0, 1.5);
        v2.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v2.RotationInfluence = Vector3.new(4, 1, 1);
        return v2;
    end,
    Earthquake = function() --[[ Name: Earthquake, Line 46 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v3 = l__CameraShakeInstance__1.new(0.6, 3.5, 2, 10);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v3.RotationInfluence = Vector3.new(1, 1, 4);
        return v3;
    end,
    BadTrip = function() --[[ Name: BadTrip, Line 56 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v4 = l__CameraShakeInstance__1.new(10, 0.15, 5, 10);
        v4.PositionInfluence = Vector3.new(0, 0, 0.15);
        v4.RotationInfluence = Vector3.new(2, 1, 4);
        return v4;
    end,
    HandheldCamera = function() --[[ Name: HandheldCamera, Line 66 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v5 = l__CameraShakeInstance__1.new(1, 0.25, 5, 10);
        v5.PositionInfluence = Vector3.new(0, 0, 0);
        v5.RotationInfluence = Vector3.new(1, 0.5, 0.5);
        return v5;
    end,
    Vibration = function() --[[ Name: Vibration, Line 76 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v6 = l__CameraShakeInstance__1.new(0.4, 20, 2, 2);
        v6.PositionInfluence = Vector3.new(0, 0.15, 0);
        v6.RotationInfluence = Vector3.new(1.25, 0, 4);
        return v6;
    end,
    RoughDriving = function() --[[ Name: RoughDriving, Line 86 ]]
        -- upvalues: l__CameraShakeInstance__1 (copy)
        local v7 = l__CameraShakeInstance__1.new(1, 2, 1, 1);
        v7.PositionInfluence = Vector3.new(0, 0, 0);
        v7.RotationInfluence = Vector3.new(1, 1, 1);
        return v7;
    end
};
return setmetatable({}, {
    __index = function(_, p9) --[[ Name: __index, Line 98 ]]
        -- upvalues: u8 (copy)
        local v10 = u8[p9];
        if type(v10) == "function" then
            return v10();
        end;
        error("No preset found with index \"" .. p9 .. "\"");
    end
});