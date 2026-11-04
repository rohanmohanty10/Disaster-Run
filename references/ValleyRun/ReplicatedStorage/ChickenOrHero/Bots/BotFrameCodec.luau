 

 

local u1 = {
    Scale = 16,
    Header = 9,
    Entry = 11,
    MaxEntries = 81,
    Flags = {
        Grounded = 1,
        Boosting = 2,
        Dashing = 4,
        Tackling = 8,
        Ragdolled = 16,
        Locked = 32
    }
};

local function fixed(p2) -- Line: 15
    local math_round_ret = math.round(p2 * 16);

    return math.clamp(math_round_ret, -32768, 32767);
end;

function u1.yaw(p3) -- Line: 19
    return math.atan2(-p3.X, -p3.Z);
end;

function u1.new(p4) -- Line: 23
    -- upvalues: u1 (copy)
    local buffer_create_ret = buffer.create(u1.Header + p4 * u1.Entry);
    buffer.writeu8(buffer_create_ret, 8, p4);

    return buffer_create_ret;
end;

function u1.stamp(p5, p6) -- Line: 29
    buffer.writef64(p5, 0, p6);
end;

function u1.put(p7, p8, p9, p10, p11, p12, p13) -- Line: 33
    -- upvalues: u1 (copy)
    local v14 = u1.Header + (p8 - 1) * u1.Entry;
    buffer.writeu16(p7, v14, p9);
    local math_round_ret = math.round(p10.X * 16);
    local math_clamp_ret = math.clamp(math_round_ret, -32768, 32767);
    buffer.writei16(p7, v14 + 2, math_clamp_ret);
    local math_round_ret2 = math.round(p10.Y * 16);
    local math_clamp_ret2 = math.clamp(math_round_ret2, -32768, 32767);
    buffer.writei16(p7, v14 + 4, math_clamp_ret2);
    local math_round_ret3 = math.round(p10.Z * 16);
    local math_clamp_ret3 = math.clamp(math_round_ret3, -32768, 32767);
    buffer.writei16(p7, v14 + 6, math_clamp_ret3);
    local v15 = math.round(p11 % 6.283185307179586 / 6.283185307179586 * 256) % 256;
    buffer.writeu8(p7, v14 + 8, v15);
    local math_round_ret4 = math.round(p12 * 4);
    local math_clamp_ret4 = math.clamp(math_round_ret4, 0, 255);
    buffer.writeu8(p7, v14 + 9, math_clamp_ret4);
    buffer.writeu8(p7, v14 + 10, p13);
end;

function u1.putFixed(p16, p17, p18, p19, p20, p21, p22, p23, p24) -- Line: 45
    -- upvalues: u1 (copy)
    local v25 = u1.Header + (p17 - 1) * u1.Entry;
    buffer.writeu16(p16, v25, p18);
    buffer.writei16(p16, v25 + 2, p19);
    buffer.writei16(p16, v25 + 4, p20);
    buffer.writei16(p16, v25 + 6, p21);
    buffer.writeu8(p16, v25 + 8, p22);
    buffer.writeu8(p16, v25 + 9, p23);
    buffer.writeu8(p16, v25 + 10, p24);
end;

function u1.read(p26, p27) -- Line: 58
    -- upvalues: u1 (copy)
    if typeof(p26) ~= "buffer" or buffer.len(p26) < u1.Header then
        return nil;
    end;

    local buffer_readu8_ret = buffer.readu8(p26, 8);

    if buffer.len(p26) ~= u1.Header + buffer_readu8_ret * u1.Entry then
        return nil;
    end;

    for i = 0, buffer_readu8_ret - 1 do
        local v28 = u1.Header + i * u1.Entry;
        p27(buffer.readu16(p26, v28), buffer.readi16(p26, v28 + 2) / 16, buffer.readi16(p26, v28 + 4) / 16, buffer.readi16(p26, v28 + 6) / 16, buffer.readu8(p26, v28 + 8) / 256 * 6.283185307179586, buffer.readu8(p26, v28 + 9) / 4, (buffer.readu8(p26, v28 + 10)));
        local _ = i;
    end;

    return buffer.readf64(p26, 0);
end;

return u1;