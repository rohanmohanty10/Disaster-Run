  

 

require(script.Parent.Parent.types);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;

return {
    alloc = function(p6) -- Line: 27, Name: alloc
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 > u3 + p6 then
            return;
        end;

        u2 = math.floor(u2 * 1.5);
        local v7 = buffer.create(u2);
        buffer.copy(v7, 0, u4);
        u4 = v7;
    end,

    dyn_alloc = function(p8) -- Line: 40, Name: dyn_alloc
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        while u2 <= u3 + p8 do
            u2 = math.floor(u2 * 1.5);
        end;

        local v9 = buffer.create(u2);
        buffer.copy(v9, 0, u4);
        u4 = v9;
    end,

    u8 = function(p10) -- Line: 56, Name: u8
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 1 then
            u2 = math.floor(u2 * 1.5);
            local v11 = buffer.create(u2);
            buffer.copy(v11, 0, u4);
            u4 = v11;
        end;

        buffer.writeu8(u4, u3, p10);
        u3 = u3 + 1;
    end,

    u8NoAlloc = function(p12) -- Line: 62, Name: u8NoAlloc
        -- upvalues: u4 (ref), u3 (ref)
        buffer.writeu8(u4, u3, p12);
        u3 = u3 + 1;
    end,

    i8 = function(p13) -- Line: 67, Name: i8
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 1 then
            u2 = math.floor(u2 * 1.5);
            local v14 = buffer.create(u2);
            buffer.copy(v14, 0, u4);
            u4 = v14;
        end;

        buffer.writei8(u4, u3, p13);
        u3 = u3 + 1;
    end,

    reference = function(p15) -- Line: 74, Name: reference
        -- upvalues: u5 (ref), u4 (ref), u3 (ref)
        table.insert(u5, p15);
        buffer.writeu8(u4, u3, #u5);
        u3 = u3 + 1;
    end,

    u16 = function(p16) -- Line: 82, Name: u16
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 2 then
            u2 = math.floor(u2 * 1.5);
            local v17 = buffer.create(u2);
            buffer.copy(v17, 0, u4);
            u4 = v17;
        end;

        buffer.writeu16(u4, u3, p16);
        u3 = u3 + 2;
    end,

    i16 = function(p18) -- Line: 88, Name: i16
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 2 then
            u2 = math.floor(u2 * 1.5);
            local v19 = buffer.create(u2);
            buffer.copy(v19, 0, u4);
            u4 = v19;
        end;

        buffer.writeu16(u4, u3, p18);
        u3 = u3 + 2;
    end,

    u32 = function(p20) -- Line: 94, Name: u32
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 4 then
            u2 = math.floor(u2 * 1.5);
            local v21 = buffer.create(u2);
            buffer.copy(v21, 0, u4);
            u4 = v21;
        end;

        buffer.writeu32(u4, u3, p20);
        u3 = u3 + 4;
    end,

    writestring = function(p22) -- Line: 100, Name: writestring
        -- upvalues: u4 (ref), u3 (ref)
        buffer.writestring(u4, u3, p22);
        u3 = u3 + string.len(p22);
    end,

    i32 = function(p23) -- Line: 105, Name: i32
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 4 then
            u2 = math.floor(u2 * 1.5);
            local v24 = buffer.create(u2);
            buffer.copy(v24, 0, u4);
            u4 = v24;
        end;

        buffer.writei32(u4, u3, p23);
        u3 = u3 + 4;
    end,

    f32NoAlloc = function(p25) -- Line: 111, Name: f32NoAlloc
        -- upvalues: u4 (ref), u3 (ref)
        buffer.writef32(u4, u3, p25);
        u3 = u3 + 4;
    end,

    f64NoAlloc = function(p26) -- Line: 116, Name: f64NoAlloc
        -- upvalues: u4 (ref), u3 (ref)
        buffer.writef64(u4, u3, p26);
        u3 = u3 + 4;
    end,

    f32 = function(p27) -- Line: 121, Name: f32
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 4 then
            u2 = math.floor(u2 * 1.5);
            local v28 = buffer.create(u2);
            buffer.copy(v28, 0, u4);
            u4 = v28;
        end;

        buffer.writef32(u4, u3, p27);
        u3 = u3 + 4;
    end,

    f64 = function(p29) -- Line: 127, Name: f64
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 8 then
            u2 = math.floor(u2 * 1.5);
            local v30 = buffer.create(u2);
            buffer.copy(v30, 0, u4);
            u4 = v30;
        end;

        buffer.writef64(u4, u3, p29);
        u3 = u3 + 8;
    end,

    copy = function(p31) -- Line: 133, Name: copy
        -- upvalues: u4 (ref), u3 (ref)
        buffer.copy(u4, u3, p31);
        u3 = u3 + buffer.len(p31);
    end,

    bool = function(p32) -- Line: 138, Name: bool
        -- upvalues: u3 (ref), u2 (ref), u4 (ref)
        if u2 <= u3 + 1 then
            u2 = math.floor(u2 * 1.5);
            local v33 = buffer.create(u2);
            buffer.copy(v33, 0, u4);
            u4 = v33;
        end;

        buffer.writeu8(u4, u3, p32 and 1 or 0);
        u3 = u3 + 1;
    end,

    load = function(p34) -- Line: 144, Name: load
        -- upvalues: u1 (ref), u2 (ref), u3 (ref), u5 (ref), u4 (ref)
        u1 = p34;
        u2 = p34.size;
        u3 = p34.cursor;
        u5 = p34.references;
        u4 = p34.buff;
    end,

    export = function() -- Line: 152, Name: export
        -- upvalues: u1 (ref), u2 (ref), u3 (ref), u5 (ref), u4 (ref)
        u1.size = u2;
        u1.cursor = u3;
        u1.references = u5;
        u1.buff = u4;

        return u1;
    end
};