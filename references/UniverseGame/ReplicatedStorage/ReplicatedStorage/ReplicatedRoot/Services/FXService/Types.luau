  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local ByteNet = require(ReplicatedRoot.Libraries.Networking.ByteNet);

return {
    Array = ByteNet.array,
    Bool = ByteNet.bool,
    Optional = ByteNet.optional,
    UInt8 = ByteNet.uint8,
    UInt16 = ByteNet.uint16,
    UInt32 = ByteNet.uint32,
    Int8 = ByteNet.int8,
    Int16 = ByteNet.int16,
    Int32 = ByteNet.int32,
    Float32 = ByteNet.float32,
    Float64 = ByteNet.float64,
    CFrame = ByteNet.cframe,
    String = ByteNet.string,
    Vector2 = ByteNet.vec2,
    Vector3 = ByteNet.vec3,
    Buffer = ByteNet.buff,

    Struct = function(p1) -- Line: 6, Name: Struct
        if typeof(p1) == "table" then
            setmetatable(p1, {
                struct = true
            });
        end;

        return p1;
    end,

    Map = ByteNet.map,
    Instance = ByteNet.inst,
    Unknown = ByteNet.unknown,
    Nothing = ByteNet.nothing
};