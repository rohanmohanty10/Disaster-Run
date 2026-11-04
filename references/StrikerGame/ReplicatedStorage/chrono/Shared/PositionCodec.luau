 

 

local u22 = {
    COMPACT_BYTES = 8,
    FLOAT_BYTES = 12,
    COMPACT_FLAG = 8,

    canEncode = function(p1: vector) -- Line: 13, Name: canEncode
        local X = p1.X;
        local Y = p1.Y;
        local Z = p1.Z;
        local v2;

        if X == X and (Y == Y and (Z == Z and (X >= -8192 and (X < 8192 and (Z >= -8192 and (Z < 8192 and Y >= -2048)))))) then
            v2 = Y < 2048;
        else
            v2 = false;
        end;

        return v2;
    end,

    writeCompact = function(p3: buffer, p4: number, p5: vector) -- Line: 21, Name: writeCompact
        local math_clamp_ret = math.clamp(p5.X, -8192, 8191.99609375);
        local math_clamp_ret2 = math.clamp(p5.Y, -2048, 2047.99609375);
        local math_clamp_ret3 = math.clamp(p5.Z, -8192, 8191.99609375);
        local v6 = math_clamp_ret // 256;
        local v7 = math_clamp_ret2 // 256;
        local v8 = math_clamp_ret3 // 256;
        local bit32_band_ret = bit32.band(v6 + 32, 63);
        local bit32_band_ret2 = bit32.band(v7 + 8, 15);
        local bit32_lshift_ret = bit32.lshift(bit32_band_ret2, 6);
        local bit32_band_ret3 = bit32.band(v8 + 32, 63);
        local bit32_lshift_ret2 = bit32.lshift(bit32_band_ret3, 10);
        local bit32_bor_ret = bit32.bor(bit32_band_ret, bit32_lshift_ret, bit32_lshift_ret2);
        buffer.writeu16(p3, p4, bit32_bor_ret);
        local math_floor_ret = math.floor((math_clamp_ret - v6 * 256) * 256);
        local math_clamp_ret4 = math.clamp(math_floor_ret, 0, 65535);
        buffer.writeu16(p3, p4 + 2, math_clamp_ret4);
        local math_floor_ret2 = math.floor((math_clamp_ret2 - v7 * 256) * 256);
        local math_clamp_ret5 = math.clamp(math_floor_ret2, 0, 65535);
        buffer.writeu16(p3, p4 + 4, math_clamp_ret5);
        local math_floor_ret3 = math.floor((math_clamp_ret3 - v8 * 256) * 256);
        local math_clamp_ret6 = math.clamp(math_floor_ret3, 0, 65535);
        buffer.writeu16(p3, p4 + 6, math_clamp_ret6);

        return p4 + 8;
    end,

    readCompact = function(p9: buffer, p10: number) -- Line: 40, Name: readCompact
        local buffer_readu16_ret = buffer.readu16(p9, p10);
        local v11 = bit32.band(buffer_readu16_ret, 63) - 32;
        local bit32_rshift_ret = bit32.rshift(buffer_readu16_ret, 6);
        local v12 = bit32.band(bit32_rshift_ret, 15) - 8;
        local bit32_rshift_ret2 = bit32.rshift(buffer_readu16_ret, 10);
        local v13 = bit32.band(bit32_rshift_ret2, 63) - 32;
        local v14 = v11 * 256 + buffer.readu16(p9, p10 + 2) / 256;
        local v15 = v12 * 256 + buffer.readu16(p9, p10 + 4) / 256;
        local v16 = v13 * 256 + buffer.readu16(p9, p10 + 6) / 256;

        return Vector3.new(v14, v15, v16), p10 + 8;
    end,

    writeFloat = function(p17: buffer, p18: number, p19: vector) -- Line: 52, Name: writeFloat
        buffer.writef32(p17, p18, p19.X);
        buffer.writef32(p17, p18 + 4, p19.Y);
        buffer.writef32(p17, p18 + 8, p19.Z);

        return p18 + 12;
    end,

    readFloat = function(p20: buffer, p21: number) -- Line: 59, Name: readFloat
        local buffer_readf32_ret = buffer.readf32(p20, p21);
        local buffer_readf32_ret2 = buffer.readf32(p20, p21 + 4);
        local buffer_readf32_ret3 = buffer.readf32(p20, p21 + 8);

        return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3), p21 + 12;
    end
};

function u22.write(p23: buffer, p24: number, p25: vector, p26: boolean) -- Line: 63
    -- upvalues: u22 (copy)
    if p26 then
        return u22.writeCompact(p23, p24, p25);
    end;

    return u22.writeFloat(p23, p24, p25);
end;

function u22.read(p27: buffer, p28: number, p29: boolean) -- Line: 70
    -- upvalues: u22 (copy)
    if p29 then
        return u22.readCompact(p27, p28);
    end;

    return u22.readFloat(p27, p28);
end;

return u22;