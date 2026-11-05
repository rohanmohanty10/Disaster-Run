 
local v0 = require(script.Parent.CameraShakeInstance);
local v17 = {
    Bump = function() --[[ Line: 26 ]] --[[ Name: Bump ]]
        -- upvalues: v0 (copy)
        local v1 = v0.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
        v1.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v1;
    end, 
    BigBump = function() --[[ Line: 33 ]] --[[ Name: BigBump ]]
        -- upvalues: v0 (copy)
        local v2 = v0.new(2.5, 4, 0.1, 0.75);
        v2.PositionInfluence = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929, 0);
        v2.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v2;
    end, 
    SmallBump = function() --[[ Line: 40 ]] --[[ Name: SmallBump ]]
        -- upvalues: v0 (copy)
        local v3 = v0.new(2.5, 4, 0.1, 0.75);
        v3.PositionInfluence = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0);
        v3.RotationInfluence = Vector3.new(0.5, 0.5, 0.5, 0);
        return v3;
    end, 
    SmallestBump = function() --[[ Line: 47 ]] --[[ Name: SmallestBump ]]
        -- upvalues: v0 (copy)
        local v4 = v0.new(1.25, 2, 0.05, 0.405);
        v4.PositionInfluence = Vector3.new(0.004999999888241291, 0.004999999888241291, 0.004999999888241291, 0);
        v4.RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        return v4;
    end, 
    Loop = function() --[[ Line: 54 ]] --[[ Name: Loop ]]
        -- upvalues: v0 (copy)
        local v5 = v0.new(0.5, 1, 0.05, 0.35);
        v5.PositionInfluence = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0);
        v5.RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        return v5;
    end, 
    Explosion = function() --[[ Line: 63 ]] --[[ Name: Explosion ]]
        -- upvalues: v0 (copy)
        local v6 = v0.new(5, 10, 0, 1.5);
        v6.PositionInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        v6.RotationInfluence = Vector3.new(4, 1, 1, 0);
        return v6;
    end, 
    BumpRemaked = function() --[[ Line: 70 ]] --[[ Name: BumpRemaked ]]
        -- upvalues: v0 (copy)
        local v7 = v0.new(2, 5, 0, 1);
        v7.PositionInfluence = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224, 0);
        v7.RotationInfluence = Vector3.new(3, 1, 1, 0);
        return v7;
    end, 
    BigExplosion = function() --[[ Line: 77 ]] --[[ Name: BigExplosion ]]
        -- upvalues: v0 (copy)
        local v8 = v0.new(20, 40, 0, 2);
        v8.PositionInfluence = Vector3.new(0.550000011920929, 0.550000011920929, 0.550000011920929, 0);
        v8.RotationInfluence = Vector3.new(5, 2, 2, 0);
        return v8;
    end, 
    ReallyBigExplosion = function() --[[ Line: 84 ]] --[[ Name: ReallyBigExplosion ]]
        -- upvalues: v0 (copy)
        local v9 = v0.new(30, 50, 0, 1.5);
        v9.PositionInfluence = Vector3.new(1, 1, 1, 0);
        v9.RotationInfluence = Vector3.new(5, 2, 2, 0);
        return v9;
    end, 
    SmallExplosion = function() --[[ Line: 91 ]] --[[ Name: SmallExplosion ]]
        -- upvalues: v0 (copy)
        local v10 = v0.new(5, 10, 0, 1.5);
        v10.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
        v10.RotationInfluence = Vector3.new(4, 1, 1, 0);
        return v10;
    end, 
    ExplosionNormal = function() --[[ Line: 98 ]] --[[ Name: ExplosionNormal ]]
        -- upvalues: v0 (copy)
        local v11 = v0.new(5, 10, 0, 1.5);
        v11.PositionInfluence = Vector3.new(3, 3, 3, 0);
        v11.RotationInfluence = Vector3.new(4, 1, 1, 0);
        return v11;
    end, 
    Earthquake = function() --[[ Line: 106 ]] --[[ Name: Earthquake ]]
        -- upvalues: v0 (copy)
        local v12 = v0.new(0.6, 3.5, 2, 10);
        v12.PositionInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        v12.RotationInfluence = Vector3.new(1, 1, 4, 0);
        return v12;
    end, 
    BadTrip = function() --[[ Line: 116 ]] --[[ Name: BadTrip ]]
        -- upvalues: v0 (copy)
        local v13 = v0.new(10, 0.15, 5, 10);
        v13.PositionInfluence = Vector3.new(0, 0, 0.15000000596046448, 0);
        v13.RotationInfluence = Vector3.new(2, 1, 4, 0);
        return v13;
    end, 
    HandheldCamera = function() --[[ Line: 126 ]] --[[ Name: HandheldCamera ]]
        -- upvalues: v0 (copy)
        local v14 = v0.new(1, 0.25, 5, 10);
        v14.PositionInfluence = Vector3.new(0, 0, 0, 0);
        v14.RotationInfluence = Vector3.new(1, 0.5, 0.5, 0);
        return v14;
    end, 
    Vibration = function() --[[ Line: 136 ]] --[[ Name: Vibration ]]
        -- upvalues: v0 (copy)
        local v15 = v0.new(0.4, 20, 2, 2);
        v15.PositionInfluence = Vector3.new(0, 0.15000000596046448, 0, 0);
        v15.RotationInfluence = Vector3.new(1.25, 0, 4, 0);
        return v15;
    end, 
    RoughDriving = function() --[[ Line: 146 ]] --[[ Name: RoughDriving ]]
        -- upvalues: v0 (copy)
        local v16 = v0.new(1, 2, 1, 1);
        v16.PositionInfluence = Vector3.new(0, 0, 0, 0);
        v16.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v16;
    end
};
return (setmetatable({}, {
    __index = function(_, v19) --[[ Line: 158 ]] --[[ Name: __index ]]
        -- upvalues: v17 (copy)
        local v20 = v17[v19];
        if type(v20) == "function" then
            return v20();
        else
            error("No preset found with index \"" .. v19 .. "\"");
            return;
        end;
    end
}));