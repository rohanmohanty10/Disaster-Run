  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local ByteNet = require(Core.ReplicatedLibraries.Networking.ByteNet);
local u1 = {
    Time = "float64",
    CFrame = "cframe",
    Velocity = "vec3",
    MoveDirection = "vec3",
    MouseHit = "cframe",
    CameraCFrame = "cframe",
    MouseTarget = "inst",
    IsGrounded = "bool",
    TorsoCFrame = "cframe",
    IsMobile = "bool",
    IsSprinting = "bool",
    SprintEnabled = "bool"
};

return ByteNet.defineNamespace("PingService", function() -- Line: 19
    -- upvalues: u1 (copy), ByteNet (copy)
    local v2 = {};

    for i, v in pairs(u1) do
        v2[i] = ByteNet.optional(ByteNet[v]);
    end;

    return {
        Ping = ByteNet.definePacket({
            reliabilityType = "unreliable",
            value = ByteNet.struct(v2)
        })
    };
end);