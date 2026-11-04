 

 

local u1 = require("./Snapshots");

return {
    defaultConfig = function() -- Line: 103, Name: defaultConfig
        return {
            tickRate = 0.016666666666666666,
            minBuffer = 0.05,
            maxBuffer = 0.5,
            fullRotation = true,
            snapshotCount = 64,
            tickAhead = 3,
            teleportTimeout = 1,
            lockCharacters = false,
            setterTeleports = true,
            sendUnchanged = false
        };
    end,

    newEntity = function(p2: number, p3: userdata?, p4: userdata?, p5: userdata?, p6: userdata?, p7, p8: boolean, p9: number) -- Line: 118, Name: newEntity
        -- upvalues: u1 (copy)
        return {
            id = p2,
            model = p3,
            root = p4,
            player = p5,
            owner = p6,
            cframe = p7,
            tick = 0,
            time = 0,
            snapshots = u1.new(p9),
            fullRotation = p8,
            destroyed = false,
            locker = nil,
            teleportAt = nil,
            teleportedAt = nil,
            clientSnapAt = nil,
            velocity = Vector3.new(0, 0, 0),
            ping = 0,
            published = false,
            clientVelocity = nil,
            clientVelocityTime = nil,
            clientVelocityClock = nil,
            guardSamples = {},
            guardedVelocity = nil,
            velocityClampStart = nil,
            lagEpochStart = nil,
            lagMinCurrent = 0,
            lagMinPrevious = 0,
            lagUntil = nil,
            lagReason = nil,
            offset = nil,
            offsetAt = 0,
            peak = 0,
            peakAt = 0,
            interval = 0,
            lastSample = nil,
            renderAt = nil,
            pendingAck = false,
            snapPending = false,
            held = false,
            settle = 0,
            lastSent = nil,
            lastSentAt = nil,
            anchored = false,
            copy = nil
        };
    end
};