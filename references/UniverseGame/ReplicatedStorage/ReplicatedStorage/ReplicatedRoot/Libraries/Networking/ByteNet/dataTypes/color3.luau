  

 

local bufferWriter = require(script.Parent.Parent.process.bufferWriter);
require(script.Parent.Parent.types);
local u8NoAlloc = bufferWriter.u8NoAlloc;
local alloc = bufferWriter.alloc;
local u4 = {
    write = function(p1) -- Line: 8, Name: write
        -- upvalues: alloc (copy), u8NoAlloc (copy)
        alloc(3);
        u8NoAlloc(p1.R * 255);
        u8NoAlloc(p1.G * 255);
        u8NoAlloc(p1.B * 255);
    end,

    read = function(p2, p3) -- Line: 14, Name: read
        return Color3.fromRGB(buffer.readu8(p2, p3), buffer.readu8(p2, p3 + 1), (buffer.readu8(p2, p3 + 2))), 3;
    end
};

return function() -- Line: 19
    -- upvalues: u4 (copy)
    return u4;
end;