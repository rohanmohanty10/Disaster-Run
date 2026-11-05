  

 

local CameraShakeInstance = require(script.Parent.CameraShakeInstance);
local u30 = {
    OldBump = function() -- Line: 26, Name: OldBump
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);

        return v1;
    end,

    SmallerBump = function() -- Line: 33, Name: SmallerBump
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(4, 8, 0, 0.5);
        v2.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);

        return v2;
    end,

    Ride = function() -- Line: 40, Name: Ride
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(0.6, 2.5, 1, 1);
        v3.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);

        return v3;
    end,

    Bump = function() -- Line: 47, Name: Bump
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(1.5, 20, 0.1, 0.75);
        v4.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);

        return v4;
    end,

    LongerBump = function() -- Line: 54, Name: LongerBump
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(2, 20, 0.1, 4.7);
        v5.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);

        return v5;
    end,

    Vibration = function() -- Line: 63, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(0.4, 20, 0.1, 0.75);
        v6.PositionInfluence = Vector3.new(0, 0.15, 0);

        return v6;
    end,

    ViolentShake = function() -- Line: 72, Name: ViolentShake
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(10, 10, 0.1, 0.75);
        v7.PositionInfluence = Vector3.new(0, 0.15, 0);

        return v7;
    end,

    LongViolentShake = function() -- Line: 79, Name: LongViolentShake
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(10, 10, 0.1, 4);
        v8.PositionInfluence = Vector3.new(0, 0.15, 0);

        return v8;
    end,

    LongViolentShake2 = function() -- Line: 86, Name: LongViolentShake2
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(5, 10, 3, 10);
        v9.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);

        return v9;
    end,

    Explosion = function() -- Line: 95, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(5, 10, 0, 1.5);
        v10.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);

        return v10;
    end,

    Explosion2 = function() -- Line: 102, Name: Explosion2
        -- upvalues: CameraShakeInstance (copy)
        local v11 = CameraShakeInstance.new(4, 7, 0, 1);
        v11.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);

        return v11;
    end,

    IntenseExplosion = function() -- Line: 109, Name: IntenseExplosion
        -- upvalues: CameraShakeInstance (copy)
        local v12 = CameraShakeInstance.new(10, 15, 0, 1);
        v12.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);

        return v12;
    end,

    LongerExplosion = function() -- Line: 116, Name: LongerExplosion
        -- upvalues: CameraShakeInstance (copy)
        local v13 = CameraShakeInstance.new(10, 15, 0, 2.7);
        v13.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);

        return v13;
    end,

    LongerExplosion3 = function() -- Line: 123, Name: LongerExplosion3
        -- upvalues: CameraShakeInstance (copy)
        local v14 = CameraShakeInstance.new(10, 15, 0, 4);
        v14.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);

        return v14;
    end,

    LongerExplosion2 = function() -- Line: 130, Name: LongerExplosion2
        -- upvalues: CameraShakeInstance (copy)
        local v15 = CameraShakeInstance.new(10, 15, 0, 2);
        v15.PositionInfluence = Vector3.new(0.45, 0.45, 0.45);

        return v15;
    end,

    Earthquake = function() -- Line: 140, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v16 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v16.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);

        return v16;
    end,

    BadTrip = function() -- Line: 150, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v17 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v17.PositionInfluence = Vector3.new(0, 0, 0.15);

        return v17;
    end,

    HandheldCamera = function() -- Line: 160, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v18 = CameraShakeInstance.new(1, 0.25, 5, 0.75);
        v18.PositionInfluence = Vector3.new(0, 0, 0);

        return v18;
    end,

    RoughDriving = function() -- Line: 169, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v19 = CameraShakeInstance.new(1, 2, 1, 1);
        v19.PositionInfluence = Vector3.new(0, 0, 0);

        return v19;
    end,

    Slam = function() -- Line: 176, Name: Slam
        -- upvalues: CameraShakeInstance (copy)
        local v20 = CameraShakeInstance.new(4, 12, 0, 0.5);
        v20.PositionInfluence = Vector3.new(0, 0, 0);

        return v20;
    end,

    LightCharge = function() -- Line: 183, Name: LightCharge
        -- upvalues: CameraShakeInstance (copy)
        local v21 = CameraShakeInstance.new(1, 4.5, 0, 0.5);
        v21.PositionInfluence = Vector3.new(1, 1, 1);

        return v21;
    end,

    MediumCharge = function() -- Line: 190, Name: MediumCharge
        -- upvalues: CameraShakeInstance (copy)
        local v22 = CameraShakeInstance.new(2, 9, 0, 1);
        v22.PositionInfluence = Vector3.new(1, 1, 1);

        return v22;
    end,

    MediumSlam = function() -- Line: 197, Name: MediumSlam
        -- upvalues: CameraShakeInstance (copy)
        local v23 = CameraShakeInstance.new(12, 12, 0, 0.75);
        v23.PositionInfluence = Vector3.new(1, 1, 1);

        return v23;
    end,

    ViolentCharge = function() -- Line: 204, Name: ViolentCharge
        -- upvalues: CameraShakeInstance (copy)
        local v24 = CameraShakeInstance.new(4, 18, 0, 1);
        v24.PositionInfluence = Vector3.new(1, 1, 1);

        return v24;
    end,

    ViolentSlam = function() -- Line: 211, Name: ViolentSlam
        -- upvalues: CameraShakeInstance (copy)
        local v25 = CameraShakeInstance.new(24, 24, 0, 0.75);
        v25.PositionInfluence = Vector3.new(1, 1, 1);

        return v25;
    end,

    Wind = function() -- Line: 218, Name: Wind
        -- upvalues: CameraShakeInstance (copy)
        local v26 = CameraShakeInstance.new(2, 6, 0, 0.5);
        v26.PositionInfluence = Vector3.new(0, 0, 0);

        return v26;
    end,

    LongerSlam = function() -- Line: 225, Name: LongerSlam
        -- upvalues: CameraShakeInstance (copy)
        local v27 = CameraShakeInstance.new(2, 20, 0.1, 2.7);
        v27.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);

        return v27;
    end,

    Lightning = function() -- Line: 232, Name: Lightning
        -- upvalues: CameraShakeInstance (copy)
        local v28 = CameraShakeInstance.new(2, 4.5, 0, 0.35);
        v28.PositionInfluence = Vector3.new(0, 0, 0);

        return v28;
    end,

    Explosion3 = function() -- Line: 239, Name: Explosion3
        -- upvalues: CameraShakeInstance (copy)
        local v29 = CameraShakeInstance.new(2, 3.5, 0, 1);
        v29.PositionInfluence = Vector3.new(0.5, 0.5, 0.5);

        return v29;
    end
};

return setmetatable({}, {
    __index = function(p31, p32) -- Line: 249, Name: __index
        -- upvalues: u30 (copy)
        local v33 = u30[p32];

        if type(v33) == "function" then
            return v33();
        end;

        error("No preset found with index \"" .. p32 .. "\"");
    end
});