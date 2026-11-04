 
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
local u16 = {
    Bump = function() -- Line: 26, Name: Bump
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(0.8, 2, 0.1, 0.3);
        v1.PositionInfluence = Vector3.new(0.08, 0.08, 0.08);
        v1.RotationInfluence = Vector3.new(1, 1, 1);

        return v1;
    end,

    Score = function() -- Line: 33, Name: Score
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(4, 1.5, 0.1, 0.6);
        v2.PositionInfluence = Vector3.new(0.1, 0.1, 0.1);
        v2.RotationInfluence = Vector3.new(1, 1, 1);

        return v2;
    end,

    Dunk = function() -- Line: 40, Name: Dunk
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(6, 2, 0.1, 0.3);
        v3.PositionInfluence = Vector3.new(0.12, 0.12, 0.12);
        v3.RotationInfluence = Vector3.new(1, 1, 1);

        return v3;
    end,

    Ankle = function() -- Line: 47, Name: Ankle
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(3, 2, 0.05, 0.3);
        v4.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v4.RotationInfluence = Vector3.new(1, 1, 1);

        return v4;
    end,

    IgnitePass = function() -- Line: 54, Name: IgnitePass
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(1.5, 3.5, 0.1, 1);
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v5.RotationInfluence = Vector3.new(1, 1, 4);

        return v5;
    end,

    Meteor = function() -- Line: 61, Name: Meteor
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(10, 3, 0.1, 0.6);
        v6.PositionInfluence = Vector3.new(0.12, 0.12, 0.12);
        v6.RotationInfluence = Vector3.new(1, 1, 1);

        return v6;
    end,

    Explosion = function() -- Line: 70, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(5, 10, 0, 1.5);
        v7.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v7.RotationInfluence = Vector3.new(4, 1, 1);

        return v7;
    end,

    FormlessShot = function() -- Line: 77, Name: FormlessShot
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(4, 7, 0, 0.5);
        v8.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v8.RotationInfluence = Vector3.new(4, 1, 1);

        return v8;
    end,

    Earthquake = function() -- Line: 87, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v9.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v9.RotationInfluence = Vector3.new(1, 1, 4);

        return v9;
    end,

    SlotMachine = function() -- Line: 94, Name: SlotMachine
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(0.6, 3.5, 0.1, 5);
        v10.PositionInfluence = Vector3.new(0.3, 0.3, 0.3);
        v10.RotationInfluence = Vector3.new(1, 1, 4);

        return v10;
    end,

    BadTrip = function() -- Line: 102, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v11 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v11.PositionInfluence = Vector3.new(0, 0, 0.15);
        v11.RotationInfluence = Vector3.new(2, 1, 4);

        return v11;
    end,

    HandheldCamera = function() -- Line: 112, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v12 = CameraShakeInstance.new(1, 0.25, 5, 10);
        v12.PositionInfluence = Vector3.new(0, 0, 0);
        v12.RotationInfluence = Vector3.new(1, 0.5, 0.5);

        return v12;
    end,

    Vanish = function() -- Line: 119, Name: Vanish
        -- upvalues: CameraShakeInstance (copy)
        local v13 = CameraShakeInstance.new(0.6, 30, 0.1, 1);
        v13.PositionInfluence = Vector3.new(0.1, 0.15, 0.1);
        v13.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v13;
    end,

    Vibration = function() -- Line: 128, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v14 = CameraShakeInstance.new(0.4, 20, 2, 2);
        v14.PositionInfluence = Vector3.new(0, 0.15, 0);
        v14.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v14;
    end,

    RoughDriving = function() -- Line: 138, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v15 = CameraShakeInstance.new(1, 2, 1, 1);
        v15.PositionInfluence = Vector3.new(0, 0, 0);
        v15.RotationInfluence = Vector3.new(1, 1, 1);

        return v15;
    end
};

return setmetatable({}, {
    __index = function(p17, p18) -- Line: 150, Name: __index
        -- upvalues: u16 (copy)
        local v19 = u16[p18];

        if type(v19) == "function" then
            return v19();
        end;

        error("No preset found with index \"" .. p18 .. "\"");
    end
});