  

 

local bufferWriter = require(script.Parent.Parent.process.bufferWriter);
require(script.Parent.Parent.types);
local u16 = bufferWriter.u16;
local copy = bufferWriter.copy;
local dyn_alloc = bufferWriter.dyn_alloc;
local u7 = {
    read = function(p1, p2) -- Line: 9, Name: read
        local v3 = buffer.readu16(p1, p2);
        local v4 = buffer.create(v3);
        buffer.copy(v4, 0, p1, p2 + 2, v3);

        return v4, v3 + 2;
    end,

    write = function(p5) -- Line: 18, Name: write
        -- upvalues: u16 (copy), dyn_alloc (copy), copy (copy)
        local v6 = buffer.len(p5);
        u16(v6);
        dyn_alloc(v6);
        copy(p5);
    end
};

return function() -- Line: 29
    -- upvalues: u7 (copy)
    return u7;
end;