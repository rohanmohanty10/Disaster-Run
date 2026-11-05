  

 

local bufferWriter = require(script.Parent.Parent.process.bufferWriter);
require(script.Parent.Parent.types);
local f32NoAlloc = bufferWriter.f32NoAlloc;
local alloc = bufferWriter.alloc;
local u14 = {
    read = function(p1, p2) -- Line: 9, Name: read
        local v3 = buffer.readf32(p1, p2);
        local v4 = buffer.readf32(p1, p2 + 4);
        local v5 = buffer.readf32(p1, p2 + 8);
        local v6 = buffer.readf32(p1, p2 + 12);
        local v7 = buffer.readf32(p1, p2 + 16);
        local v8 = buffer.readf32(p1, p2 + 20);
        local v9 = Vector3.new(v6, v7, v8);

        return CFrame.fromAxisAngle(v9 == Vector3.new(0, 0, 0) and Vector3.new(1, 0, 0) or v9, v9.Magnitude) + Vector3.new(v3, v4, v5), 24;
    end,

    write = function(p10) -- Line: 27, Name: write
        -- upvalues: alloc (copy), f32NoAlloc (copy)
        local X = p10.X;
        local Y = p10.Y;
        local Z = p10.Z;
        local v11, v12 = p10:ToAxisAngle();
        local v13 = v11 * v12;
        local X2 = v13.X;
        local Y2 = v13.Y;
        local Z2 = v13.Z;
        alloc(24);
        f32NoAlloc(X);
        f32NoAlloc(Y);
        f32NoAlloc(Z);
        f32NoAlloc(X2);
        f32NoAlloc(Y2);
        f32NoAlloc(Z2);
    end
};

return function() -- Line: 47
    -- upvalues: u14 (copy)
    return u14;
end;