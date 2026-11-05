  

 

local bufferWriter = require(script.Parent.Parent.process.bufferWriter);
require(script.Parent.Parent.types);
local f32NoAlloc = bufferWriter.f32NoAlloc;
local alloc = bufferWriter.alloc;
local u7 = {
    read = function(p1, p2) -- Line: 11, Name: read
        local v3 = buffer.readf32(p1, p2);
        local v4 = buffer.readf32(p1, p2 + 4);
        local v5 = buffer.readf32(p1, p2 + 8);

        return Vector3.new(v3, v4, v5), 12;
    end,

    write = function(p6) -- Line: 15, Name: write
        -- upvalues: alloc (copy), f32NoAlloc (copy)
        alloc(12);
        f32NoAlloc(p6.X);
        f32NoAlloc(p6.Y);
        f32NoAlloc(p6.Z);
    end
};

return function() -- Line: 23
    -- upvalues: u7 (copy)
    return u7;
end;