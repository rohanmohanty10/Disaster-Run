 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=1461025953

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Camera Shake Presets
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShakePresets.Bump
	CameraShakePresets.Explosion
	CameraShakePresets.Earthquake
	CameraShakePresets.BadTrip
	CameraShakePresets.HandheldCamera
	CameraShakePresets.Vibration
	CameraShakePresets.RoughDriving
	
--]]



local CameraShakeInstance = require(script.Parent.CameraShakeInstance)

local CameraShakePresets = {
	
	
	-- A high-magnitude, short, yet smooth shake.
	-- Should happen once.
	Bump = function()
		local c = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)
		c.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		c.RotationInfluence = Vector3.new(1, 1, 1)
		return c
	end;
	
	
	-- An intense and rough shake.
	-- Should happen once.
	Explosion = function()
		local c = CameraShakeInstance.new(5, 10, 0, 1.5)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end;
	
	
	-- A continuous, rough shake
	-- Sustained.
	Earthquake = function()
		local c = CameraShakeInstance.new(0.6, 3.5, 2, 10)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(1, 1, 4)
		return c
	end;
	
	
	-- A bizarre shake with a very high magnitude and low roughness.
	-- Sustained.
	BadTrip = function()
		local c = CameraShakeInstance.new(10, 0.15, 5, 10)
		c.PositionInfluence = Vector3.new(0, 0, 0.15)
		c.RotationInfluence = Vector3.new(2, 1, 4)
		return c
	end;
	
	
	-- A subtle, slow shake.
	-- Sustained.
	HandheldCamera = function()
		local c = CameraShakeInstance.new(1, 0.25, 5, 10)
		c.PositionInfluence = Vector3.new(0, 0, 0)
		c.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return c
	end;
	
	
	-- A very rough, yet low magnitude shake.
	-- Sustained.
	Vibration = function()
		local c = CameraShakeInstance.new(0.4, 20, 2, 2)
		c.PositionInfluence = Vector3.new(0, 0.15, 0)
		c.RotationInfluence = Vector3.new(1.25, 0, 4)
		return c
	end;
	
	
	-- A slightly rough, medium magnitude shake.
	-- Sustained.
	RoughDriving = function()
		local c = CameraShakeInstance.new(1, 2, 1, 1)
		c.PositionInfluence = Vector3.new(0, 0, 0)
		c.RotationInfluence = Vector3.new(1, 1, 1)
		return c
	end;
	
	
}


return setmetatable({}, {
	__index = function(t, i)
		local f = CameraShakePresets[i]
		if (type(f) == "function") then
			return f()
		end
		error("No preset found with index \"" .. i .. "\"")
	end;
})
]=]

 

local CameraShakeInstance = require(script.Parent.CameraShakeInstance);
local u11 = {
    Bump = function() -- Line: 26, Name: Bump
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v1.RotationInfluence = Vector3.new(1, 1, 1);

        return v1;
    end,

    Hit = function() -- Line: 33, Name: Hit
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(5, 7, 0.1, 0.5);
        v2.PositionInfluence = Vector3.new(0.2, 0.2, 0.2);
        v2.RotationInfluence = Vector3.new(1, 1, 1);

        return v2;
    end,

    SmallShake = function() -- Line: 40, Name: SmallShake
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(4.5, 10, 0, 0.4);
        v3.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v3.RotationInfluence = Vector3.new(0, 0, 0);

        return v3;
    end,

    BigShake = function() -- Line: 47, Name: BigShake
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(5.5, 10, 0, 0.5);
        v4.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v4.RotationInfluence = Vector3.new(0, 0, 0);

        return v4;
    end,

    Explosion = function() -- Line: 57, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(5, 10, 0, 1.5);
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v5.RotationInfluence = Vector3.new(4, 1, 1);

        return v5;
    end,

    Earthquake = function() -- Line: 67, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v6.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v6.RotationInfluence = Vector3.new(1, 1, 4);

        return v6;
    end,

    BadTrip = function() -- Line: 77, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v7.PositionInfluence = Vector3.new(0, 0, 0.15);
        v7.RotationInfluence = Vector3.new(2, 1, 4);

        return v7;
    end,

    HandheldCamera = function() -- Line: 87, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(1, 0.25, 5, 10);
        v8.PositionInfluence = Vector3.new(0, 0, 0);
        v8.RotationInfluence = Vector3.new(1, 0.5, 0.5);

        return v8;
    end,

    Vibration = function() -- Line: 97, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(0.4, 20, 2, 2);
        v9.PositionInfluence = Vector3.new(0, 0.15, 0);
        v9.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v9;
    end,

    RoughDriving = function() -- Line: 107, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(1, 2, 1, 1);
        v10.PositionInfluence = Vector3.new(0, 0, 0);
        v10.RotationInfluence = Vector3.new(1, 1, 1);

        return v10;
    end
};

return setmetatable({}, {
    __index = function(p12, p13) -- Line: 119, Name: __index
        -- upvalues: u11 (copy)
        local v14 = u11[p13];

        if type(v14) == "function" then
            return v14();
        end;

        error("No preset found with index \"" .. p13 .. "\"");
    end
});