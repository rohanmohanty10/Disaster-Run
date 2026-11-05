  

 

local bufferWriter = require(script.Parent.Parent.process.bufferWriter);
local readRefs = require(script.Parent.Parent.process.readRefs);
require(script.Parent.Parent.types);
local reference = bufferWriter.reference;
local alloc = bufferWriter.alloc;

return function() -- Line: 8
    -- upvalues: alloc (copy), reference (copy), readRefs (copy)
    return {
        write = function(p1) -- Line: 10, Name: write
            -- upvalues: alloc (ref), reference (ref)
            alloc(1);
            reference(p1);
        end,

        read = function(p2, p3) -- Line: 15, Name: read
            -- upvalues: readRefs (ref)
            local v4 = readRefs.get();

            if not v4 then
                return nil, 1;
            end;

            local v5 = v4[buffer.readu8(p2, p3)];

            if typeof(v5) == "Instance" then
                return v5, 1;
            end;

            return nil, 1;
        end
    };
end;