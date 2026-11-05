  

 

local ByteNet = require(game.ReplicatedStorage.ReplicatedRoot.Libraries.Networking.ByteNet);

return ByteNet.defineNamespace("Input", function() -- Line: 4
    -- upvalues: ByteNet (copy)
    local v1 = ByteNet.struct({
        Groups = ByteNet.map(ByteNet.string, ByteNet.map(ByteNet.string, ByteNet.bool)),
        Delta = ByteNet.vec3,
        KeyCode = ByteNet.uint16,
        UserInputType = ByteNet.uint8,
        UserInputState = ByteNet.uint8,
        GameProcessed = ByteNet.bool
    });
    local v2 = ByteNet.struct({
        Groups = ByteNet.map(ByteNet.string, ByteNet.array(ByteNet.string)),
        InputTypes = ByteNet.array(ByteNet.uint8),
        KeyCodes = ByteNet.array(ByteNet.uint16)
    });

    return {
        Send = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = v1
        }),
        SendUnreliable = ByteNet.definePacket({
            reliabilityType = "unreliable",
            value = v1
        }),
        SendState = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = v2
        }),
        Register = ByteNet.definePacket({
            reliabilityType = "reliable",
            value = ByteNet.bool
        })
    };
end);