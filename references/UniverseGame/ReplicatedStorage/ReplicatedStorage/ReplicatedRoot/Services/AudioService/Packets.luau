  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local ByteNet = require(ReplicatedRoot.Libraries.Networking.ByteNet);
require(ReplicatedRoot.Libraries.Networking.ByteNet.types);

return ByteNet.defineNamespace("AudioService", function() -- Line: 7
    -- upvalues: ByteNet (copy)
    local v1 = ByteNet.struct({
        SoundId = ByteNet.optional(ByteNet.string),
        Volume = ByteNet.optional(ByteNet.float32),
        PlaybackSpeed = ByteNet.optional(ByteNet.float32),
        PlaybackRegionsEnabled = ByteNet.optional(ByteNet.bool),
        PlaybackRegion0 = ByteNet.optional(ByteNet.float32),
        PlaybackRegion1 = ByteNet.optional(ByteNet.float32),
        Looped = ByteNet.optional(ByteNet.bool),
        LoopRegion0 = ByteNet.optional(ByteNet.float32),
        LoopRegion1 = ByteNet.optional(ByteNet.float32),
        RollOffMinDistance = ByteNet.optional(ByteNet.float32),
        RollOffMaxDistance = ByteNet.optional(ByteNet.float32),
        SoundGroup = ByteNet.optional(ByteNet.string),
        Cleanup = ByteNet.optional(ByteNet.bool),
        Transformer = ByteNet.optional(ByteNet.inst),
        Parent = ByteNet.optional(ByteNet.inst),
        Position = ByteNet.optional(ByteNet.vec3)
    });
    local v2 = ByteNet.struct({
        Key = ByteNet.inst,
        ExtraData = ByteNet.optional(v1)
    });

    return {
        SpawnFromDataReliable = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = v1
        }),
        SpawnFromDataUnreliable = ByteNet.definePacket({
            reliabilityType = "unreliable",
            value = v1
        }),
        SpawnFromKeyReliable = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = v2
        }),
        SpawnFromKeyUnreliable = ByteNet.definePacket({
            reliabilityType = "unreliable",
            value = v2
        })
    };
end);