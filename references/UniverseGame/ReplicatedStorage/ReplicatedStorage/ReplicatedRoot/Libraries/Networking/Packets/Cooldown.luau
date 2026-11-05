  

 

local ByteNet = require(game.ReplicatedStorage.ReplicatedRoot.Libraries.Networking.ByteNet);

return ByteNet.defineNamespace("Cooldown", function() -- Line: 4
    -- upvalues: ByteNet (copy)
    local v1 = ByteNet.struct({
        Character = ByteNet.inst,
        Name = ByteNet.string,
        MoveName = ByteNet.string,
        Time = ByteNet.float32,
        Length = ByteNet.float32,
        ServerCreated = ByteNet.float64
    });

    return {
        SetCooldown = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = v1
        }),
        ClearCooldown = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = ByteNet.struct({
                Character = ByteNet.inst,
                Name = ByteNet.string
            })
        })
    };
end);