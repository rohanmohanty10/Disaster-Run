 

 

local u4 = {
    Skins = table.freeze({
        Football = table.freeze({
            Key = "Truck",
            Remote = "TruckAbilityEvent",
            ReadyAt = "TruckAbilityReadyAt",
            Until = "TruckUntil",
            Cooldown = 25,
            Label = "Truck",
            ActiveLabel = "Trucking",
            Hint = "Shoulder",
            TouchHint = "Tap before a hit",
            ActiveHint = "Brace!",
            Accent = Color3.fromRGB(255, 178, 96),
            AccentDark = Color3.fromRGB(140, 82, 38),
            Base = Color3.fromRGB(178, 112, 52),
            HintColor = Color3.fromRGB(255, 205, 150),
            TrackColor = Color3.fromRGB(78, 50, 26)
        }),
        Futbol = table.freeze({
            Key = "StepOver",
            Remote = "StepOverEvent",
            ReadyAt = "StepOverReadyAt",
            Until = "StepOverUntil",
            Cooldown = 30,
            Label = "Step Over",
            ActiveLabel = "Stepping",
            Hint = "Juke",
            TouchHint = "Tap to juke",
            ActiveHint = "Go!",
            Accent = Color3.fromRGB(96, 200, 120),
            AccentDark = Color3.fromRGB(34, 96, 52),
            Base = Color3.fromRGB(52, 140, 78),
            HintColor = Color3.fromRGB(180, 240, 190),
            TrackColor = Color3.fromRGB(26, 64, 38)
        }),
        AlbiesCutlass = table.freeze({
            Key = "Cannon",
            Remote = "CannonAbilityEvent",
            ReadyAt = "CannonReadyAt",
            Until = "CannonUntil",
            Cooldown = 25,
            Label = "Cannon",
            ActiveLabel = "Airborne",
            Hint = "Fire in the hole",
            TouchHint = "Tap to launch",
            ActiveHint = "Fire!",
            Accent = Color3.fromRGB(66, 157, 255),
            AccentDark = Color3.fromRGB(24, 62, 122),
            Base = Color3.fromRGB(40, 100, 190),
            HintColor = Color3.fromRGB(170, 210, 255),
            TrackColor = Color3.fromRGB(20, 44, 84)
        })
    }),

    allows = function(p1, p2) -- Line: 64, Name: allows
        local v3;

        if p1 == nil or p2 ~= "Runner" and p2 ~= "Catcher" then
            v3 = false;
        else
            v3 = p1.Roles == nil and true or p1.Roles[p2] == true;
        end;

        return v3;
    end,

    StepOver = table.freeze({
        FakeDistance = 4,
        FakeTime = 0.42,
        BigDistance = 12,
        BigTime = 0.36,
        DashClipTime = 0.5,
        Forward = 1,
        CarrySeconds = 0.6,
        FakeTowardInput = true,
        Credit = 16
    }),
    Cannon = table.freeze({
        Distance = 15,
        Flight = 0.7,
        CarrySeconds = 0.5,
        Behind = 3.5,
        BlastRadius = 8,
        BlastSpeed = 26,
        BlastTime = 0.3,
        Credit = 21,
        MaxMomentum = 32,
        Spins = 1,
        PropScale = 0.75
    })
};

function u4.cannonLaunch() -- Line: 106
    -- upvalues: u4 (copy)
    return workspace.Gravity * u4.Cannon.Flight / 2;
end;

function u4.cannonMomentum(p5, p6) -- Line: 111
    -- upvalues: u4 (copy)
    if typeof(p5) ~= "Vector3" or typeof(p6) ~= "Vector3" then
        return 0;
    end;

    local v7 = (p5 * Vector3.new(1, 0, 1)):Dot(p6);

    return math.clamp(v7, 0, u4.Cannon.MaxMomentum);
end;

function u4.forSkin(p8) -- Line: 117
    -- upvalues: u4 (copy)
    return type(p8) == "string" and u4.Skins[p8] or nil;
end;

function u4.stepOverTime() -- Line: 121
    -- upvalues: u4 (copy)
    return u4.StepOver.FakeTime + u4.StepOver.DashClipTime;
end;

function u4.stepOverBurstSpeed() -- Line: 125
    -- upvalues: u4 (copy)
    return u4.StepOver.BigDistance / u4.StepOver.BigTime * 1.5;
end;

return table.freeze(u4);