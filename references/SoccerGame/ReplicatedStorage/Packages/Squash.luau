  

local function tryrealloc(p1: table, p2: number) -- Line: 31
    local Buf = p1.Buf;
    local Pos = p1.Pos;
    local buffer_len_ret = buffer.len(Buf);

    if buffer_len_ret < Pos + p2 then
        local math_log_ret = math.log((p2 + Pos) / buffer_len_ret, 1.5);
        local math_ceil_ret = math.ceil(math_log_ret);
        local buffer_create_ret = buffer.create(buffer_len_ret * 1.5 ^ math_ceil_ret);
        buffer.copy(buffer_create_ret, 0, Buf, 0);
        p1.Buf = buffer_create_ret;
    end;
end;

local function pushu1(p3: table, p4: number) -- Line: 43
    buffer.writeu8(p3.Buf, p3.Pos, p4);
    p3.Pos = p3.Pos + 1;
end;

local function popu1(p5: table) -- Line: 48
    p5.Pos = p5.Pos - 1;

    return buffer.readu8(p5.Buf, p5.Pos);
end;

local function pushu2(p6: table, p7: number) -- Line: 53
    buffer.writeu16(p6.Buf, p6.Pos, p7);
    p6.Pos = p6.Pos + 2;
end;

local function popu2(p8: table) -- Line: 58
    p8.Pos = p8.Pos - 2;

    return buffer.readu16(p8.Buf, p8.Pos);
end;

local function pushu3(p9: table, p10: number) -- Line: 63
    buffer.writeu8(p9.Buf, p9.Pos, p10);
    buffer.writeu16(p9.Buf, p9.Pos + 1, p10 // 256);
    p9.Pos = p9.Pos + 3;
end;

local function popu3(p11: table) -- Line: 69
    p11.Pos = p11.Pos - 3;

    return buffer.readu8(p11.Buf, p11.Pos) + buffer.readu16(p11.Buf, p11.Pos + 1) * 256;
end;

local function pushu4(p12: table, p13: number) -- Line: 76
    buffer.writeu32(p12.Buf, p12.Pos, p13);
    p12.Pos = p12.Pos + 4;
end;

local function popu4(p14: table) -- Line: 81
    p14.Pos = p14.Pos - 4;

    return buffer.readu32(p14.Buf, p14.Pos);
end;

local function pushu5(p15: table, p16: number) -- Line: 86
    buffer.writeu8(p15.Buf, p15.Pos, p16);
    buffer.writeu32(p15.Buf, p15.Pos + 1, p16 // 256);
    p15.Pos = p15.Pos + 5;
end;

local function popu5(p17: table) -- Line: 92
    p17.Pos = p17.Pos - 5;

    return buffer.readu8(p17.Buf, p17.Pos) + buffer.readu32(p17.Buf, p17.Pos + 1) * 256;
end;

local function pushu6(p18: table, p19: number) -- Line: 99
    buffer.writeu16(p18.Buf, p18.Pos, p19);
    buffer.writeu32(p18.Buf, p18.Pos + 2, p19 // 65536);
    p18.Pos = p18.Pos + 6;
end;

local function popu6(p20: table) -- Line: 105
    p20.Pos = p20.Pos - 6;

    return buffer.readu16(p20.Buf, p20.Pos) + buffer.readu32(p20.Buf, p20.Pos + 2) * 65536;
end;

local function pushu7(p21: table, p22: number) -- Line: 112
    buffer.writeu8(p21.Buf, p21.Pos, p22);
    buffer.writeu16(p21.Buf, p21.Pos + 1, p22 // 256);
    buffer.writeu32(p21.Buf, p21.Pos + 3, p22 // 16777216);
    p21.Pos = p21.Pos + 7;
end;

local function popu7(p23: table) -- Line: 119
    p23.Pos = p23.Pos - 7;
    local buffer_readu8_ret = buffer.readu8(p23.Buf, p23.Pos);
    local buffer_readu16_ret = buffer.readu16(p23.Buf, p23.Pos + 1);
    local buffer_readu32_ret = buffer.readu32(p23.Buf, p23.Pos + 3);

    return buffer_readu8_ret + buffer_readu16_ret * 256 + buffer_readu32_ret * 16777216;
end;

local function pushu8(p24: table, p25: number) -- Line: 127
    buffer.writeu32(p24.Buf, p24.Pos, p25);
    buffer.writeu32(p24.Buf, p24.Pos + 4, p25 // 4294967296);
    p24.Pos = p24.Pos + 8;
end;

local function popu8(p26: table) -- Line: 133
    p26.Pos = p26.Pos - 8;

    return buffer.readu32(p26.Buf, p26.Pos) + buffer.readu32(p26.Buf, p26.Pos + 4) * 4294967296;
end;

local function pushi1(p27: table, p28: number) -- Line: 140
    buffer.writei8(p27.Buf, p27.Pos, p28);
    p27.Pos = p27.Pos + 1;
end;

local function popi1(p29: table) -- Line: 145
    p29.Pos = p29.Pos - 1;

    return buffer.readi8(p29.Buf, p29.Pos);
end;

local function pushi2(p30: table, p31: number) -- Line: 150
    buffer.writei16(p30.Buf, p30.Pos, p31);
    p30.Pos = p30.Pos + 2;
end;

local function popi2(p32: table) -- Line: 155
    p32.Pos = p32.Pos - 2;

    return buffer.readi16(p32.Buf, p32.Pos);
end;

local function pushi3(p33, p34) -- Line: 160
    local v35;

    if p34 >= 0 then
        v35 = p34 * 2;
    else
        v35 = -p34 * 2 - 1;
    end;

    buffer.writeu8(p33.Buf, p33.Pos, v35 % 256);
    buffer.writeu16(p33.Buf, p33.Pos + 1, v35 // 256);
    p33.Pos = p33.Pos + 3;
end;

local function popi3(p36) -- Line: 167
    p36.Pos = p36.Pos - 3;
    local v37 = buffer.readu8(p36.Buf, p36.Pos) + buffer.readu16(p36.Buf, p36.Pos + 1) * 256;

    if v37 % 2 == 0 then
        return v37 // 2;
    end;

    return -((v37 + 1) // 2);
end;

local function pushi4(p38: table, p39: number) -- Line: 175
    buffer.writei32(p38.Buf, p38.Pos, p39);
    p38.Pos = p38.Pos + 4;
end;

local function popi4(p40: table) -- Line: 180
    p40.Pos = p40.Pos - 4;

    return buffer.readi32(p40.Buf, p40.Pos);
end;

local function pushi5(p41: table, p42: number) -- Line: 185
    local v43;

    if p42 >= 0 then
        v43 = p42 * 2;
    else
        v43 = -p42 * 2 - 1;
    end;

    buffer.writeu8(p41.Buf, p41.Pos, v43);
    buffer.writeu32(p41.Buf, p41.Pos + 1, v43 // 256);
    p41.Pos = p41.Pos + 5;
end;

local function popi5(p44: table) -- Line: 192
    p44.Pos = p44.Pos - 5;
    local v45 = buffer.readu8(p44.Buf, p44.Pos) + buffer.readu32(p44.Buf, p44.Pos + 1) * 256;

    if v45 % 2 == 0 then
        return v45 // 2;
    end;

    return -((v45 + 1) // 2);
end;

local function pushi6(p46: table, p47: number) -- Line: 200
    local v48;

    if p47 >= 0 then
        v48 = p47 * 2;
    else
        v48 = -p47 * 2 - 1;
    end;

    buffer.writeu16(p46.Buf, p46.Pos, v48);
    buffer.writeu32(p46.Buf, p46.Pos + 2, v48 // 65536);
    p46.Pos = p46.Pos + 6;
end;

local function popi6(p49: table) -- Line: 207
    p49.Pos = p49.Pos - 6;
    local v50 = buffer.readu16(p49.Buf, p49.Pos) + buffer.readu32(p49.Buf, p49.Pos + 2) * 65536;

    if v50 % 2 == 0 then
        return v50 // 2;
    end;

    return -((v50 + 1) // 2);
end;

local function pushi7(p51: table, p52: number) -- Line: 215
    local v53;

    if p52 >= 0 then
        v53 = p52 * 2;
    else
        v53 = -p52 * 2 - 1;
    end;

    buffer.writeu8(p51.Buf, p51.Pos, v53);
    buffer.writeu16(p51.Buf, p51.Pos + 1, v53 // 256);
    buffer.writeu32(p51.Buf, p51.Pos + 3, v53 // 16777216);
    p51.Pos = p51.Pos + 7;
end;

local function popi7(p54: table) -- Line: 223
    p54.Pos = p54.Pos - 7;
    local buffer_readu8_ret = buffer.readu8(p54.Buf, p54.Pos);
    local buffer_readu16_ret = buffer.readu16(p54.Buf, p54.Pos + 1);
    local buffer_readu32_ret = buffer.readu32(p54.Buf, p54.Pos + 3);
    local v55 = buffer_readu8_ret + buffer_readu16_ret * 256 + buffer_readu32_ret * 16777216;

    if v55 % 2 == 0 then
        return v55 // 2;
    end;

    return -((v55 + 1) // 2);
end;

local function pushi8(p56: table, p57: number) -- Line: 232
    local v58;

    if p57 >= 0 then
        v58 = p57 * 2;
    else
        v58 = -p57 * 2 - 1;
    end;

    buffer.writeu32(p56.Buf, p56.Pos, v58);
    buffer.writeu32(p56.Buf, p56.Pos + 4, v58 // 4294967296);
    p56.Pos = p56.Pos + 8;
end;

local function popi8(p59: table) -- Line: 239
    p59.Pos = p59.Pos - 8;
    local v60 = buffer.readu32(p59.Buf, p59.Pos) + buffer.readu32(p59.Buf, p59.Pos + 4) * 4294967296;

    if v60 % 2 == 0 then
        return v60 // 2;
    end;

    return -((v60 + 1) // 2);
end;

local function pushf4(p61: table, p62: number) -- Line: 247
    buffer.writef32(p61.Buf, p61.Pos, p62);
    p61.Pos = p61.Pos + 4;
end;

local function popf4(p63: table) -- Line: 252
    p63.Pos = p63.Pos - 4;

    return buffer.readf32(p63.Buf, p63.Pos);
end;

local function pushf8(p64: table, p65: number) -- Line: 257
    buffer.writef64(p64.Buf, p64.Pos, p65);
    p64.Pos = p64.Pos + 8;
end;

local function popf8(p66: table) -- Line: 262
    p66.Pos = p66.Pos - 8;

    return buffer.readf64(p66.Buf, p66.Pos);
end;

local function pushbool(p67: table, p68: boolean, p69: boolean?, p70: boolean?, p71: boolean?, p72: boolean?, p73: boolean?, p74: boolean?, p75: boolean?) -- Line: 267
    buffer.writeu8(p67.Buf, p67.Pos, (p68 and 1 or 0) + (p69 and 2 or 0) + (p70 and 4 or 0) + (p71 and 8 or 0) + (p72 and 16 or 0) + (p73 and 32 or 0) + (p74 and 64 or 0) + (p75 and 128 or 0));
    p67.Pos = p67.Pos + 1;
end;

local function pushvlqrealloc(p76: table, p77: number) -- Line: 302
    -- upvalues: tryrealloc (copy)
    local v78 = p77 >= 562949953421312 and 8 or (p77 >= 4398046511104 and 7 or (p77 >= 34359738368 and 6 or (p77 >= 268435456 and 5 or (p77 >= 2097152 and 4 or (p77 >= 16384 and 3 or (p77 >= 128 and 2 or 1))))));
    tryrealloc(p76, v78);
    local v79 = p77 // 4294967296;
    local v80 = p77 - v79 * 4294967296;
    buffer.writeu8(p76.Buf, p76.Pos, v80 % 128);
    p76.Pos = p76.Pos + 1;

    if v78 >= 2 then
        v80 = v79 % 128 * 33554432 + v80 // 128;
        v79 = v79 // 128;
        buffer.writeu8(p76.Buf, p76.Pos, v80 % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;

    if v78 >= 3 then
        v80 = v79 % 128 * 33554432 + v80 // 128;
        v79 = v79 // 128;
        buffer.writeu8(p76.Buf, p76.Pos, v80 % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;

    if v78 >= 4 then
        v80 = v79 % 128 * 33554432 + v80 // 128;
        v79 = v79 // 128;
        buffer.writeu8(p76.Buf, p76.Pos, v80 % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;

    if v78 >= 5 then
        v80 = v79 % 128 * 33554432 + v80 // 128;
        v79 = v79 // 128;
        buffer.writeu8(p76.Buf, p76.Pos, v80 % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;

    if v78 >= 6 then
        v80 = v79 % 128 * 33554432 + v80 // 128;
        v79 = v79 // 128;
        buffer.writeu8(p76.Buf, p76.Pos, v80 % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;

    if v78 >= 7 then
        v80 = v79 % 128 * 33554432 + v80 // 128;
        v79 = v79 // 128;
        buffer.writeu8(p76.Buf, p76.Pos, v80 % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;

    if v78 == 8 then
        buffer.writeu8(p76.Buf, p76.Pos, (v79 % 128 * 33554432 + v80 // 128) % 128 + 128);
        p76.Pos = p76.Pos + 1;
    end;
end;

local function popvlq(p81: table) -- Line: 382
    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret = buffer.readu8(p81.Buf, p81.Pos);
    local v82 = buffer_readu8_ret % 128;

    if buffer_readu8_ret < 128 then
        return v82;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret2 = buffer.readu8(p81.Buf, p81.Pos);
    local v83 = v82 * 128 + buffer_readu8_ret2 % 128;

    if buffer_readu8_ret2 < 128 then
        return v83;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret3 = buffer.readu8(p81.Buf, p81.Pos);
    local v84 = v83 * 128 + buffer_readu8_ret3 % 128;

    if buffer_readu8_ret3 < 128 then
        return v84;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret4 = buffer.readu8(p81.Buf, p81.Pos);
    local v85 = v84 * 128 + buffer_readu8_ret4 % 128;

    if buffer_readu8_ret4 < 128 then
        return v85;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret5 = buffer.readu8(p81.Buf, p81.Pos);
    local v86 = v85 * 128 + buffer_readu8_ret5 % 128;

    if buffer_readu8_ret5 < 128 then
        return v86;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret6 = buffer.readu8(p81.Buf, p81.Pos);
    local v87 = v86 * 128 + buffer_readu8_ret6 % 128;

    if buffer_readu8_ret6 < 128 then
        return v87;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret7 = buffer.readu8(p81.Buf, p81.Pos);
    local v88 = v87 * 128 + buffer_readu8_ret7 % 128;

    if buffer_readu8_ret7 < 128 then
        return v88;
    end;

    p81.Pos = p81.Pos - 1;
    local buffer_readu8_ret8 = buffer.readu8(p81.Buf, p81.Pos);

    return v88 * 128 + buffer_readu8_ret8 % 128;
end;

local function pushstr(p89: table, p90: string, p91: number?) -- Line: 431
    -- upvalues: pushvlqrealloc (ref)
    local v92 = p91 or #p90;
    buffer.writestring(p89.Buf, p89.Pos, p90);
    p89.Pos = p89.Pos + v92;

    if not p91 then
        pushvlqrealloc(p89, v92);
    end;
end;

local function popstr(p93: table, p94: number?) -- Line: 441
    -- upvalues: popvlq (ref)
    local v95 = p94 or popvlq(p93);
    p93.Pos = p93.Pos - v95;

    return buffer.readstring(p93.Buf, p93.Pos, v95);
end;

local function pushbuf(p96: table, p97: buffer, p98: number?) -- Line: 447
    -- upvalues: pushvlqrealloc (ref)
    local v99 = p98 or buffer.len(p97);
    buffer.copy(p96.Buf, p96.Pos, p97, 0, v99);
    p96.Pos = p96.Pos + v99;

    if not p98 then
        pushvlqrealloc(p96, v99);
    end;
end;

local function popbuf(p100: table, p101: number?) -- Line: 457
    -- upvalues: popvlq (ref)
    local v102 = p101 or popvlq(p100);
    p100.Pos = p100.Pos - v102;
    local buffer_create_ret = buffer.create(v102);
    buffer.copy(buffer_create_ret, 0, p100.Buf, p100.Pos, v102);

    return buffer_create_ret;
end;

local v115 = {
    print = function(p103: table) -- Line: 465, Name: printcursor
        local v104 = {};
        local buffer_tostring_ret = buffer.tostring(p103.Buf);
        v104[1] = string.byte(buffer_tostring_ret, 1, -1);
        local v105 = 7;

        for i = 1, p103.Pos do
            local v106 = v104[i];
            local v107;

            if v106 == 0 then
                v107 = 1;
            else
                local math_log10_ret = math.log10(1 + v106);
                v107 = math.ceil(math_log10_ret);
            end;

            v105 = v105 + (v107 + 1);
            local _ = i;
        end;

        local v108 = v104[p103.Pos + 1];

        if v108 then
            local v109;

            if v108 == 0 then
                v109 = 1;
            else
                local math_log10_ret = math.log10(1 + v108);
                v109 = math.ceil(math_log10_ret);
            end;

            v105 = v105 + v109 // 2;
        end;

        if #v104 == 0 or p103.Pos == buffer.len(p103.Buf) then
            table.insert(v104, " ");
        end;

        print((`Pos: {p103.Pos} / {buffer.len(p103.Buf)}\nBuf: \{ {table.concat(v104, " ")} }\n{string.rep(" ", v105)}^`));
    end,

    cursor = function(p110: number?, p111: number?) -- Line: 11, Name: newcursor
        return {
            Buf = buffer.create(p110 or 8),
            Pos = p111 or 0
        };
    end,

    frombuffer = function(p112: buffer) -- Line: 18, Name: frombuffer
        return {
            Buf = p112,
            Pos = buffer.len(p112)
        };
    end,

    tobuffer = function(p113: table) -- Line: 25, Name: tobuffer
        local buffer_create_ret = buffer.create(p113.Pos);
        buffer.copy(buffer_create_ret, 0, p113.Buf, 0, p113.Pos);

        return buffer_create_ret;
    end,

    tryrealloc = tryrealloc,

    T = function(p114: table) -- Line: 500, Name: T
        return p114;
    end
};
local u126 = {
    ser = function(p116: table, p117: any, p118: any, p119: any, p120: any, p121: any, p122: any, p123: any, p124: any) -- Line: 507, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p116, 1);
        buffer.writeu8(p116.Buf, p116.Pos, (p117 and 1 or 0) + (p118 and 2 or 0) + (p119 and 4 or 0) + (p120 and 8 or 0) + (p121 and 16 or 0) + (p122 and 32 or 0) + (p123 and 64 or 0) + (p124 and 128 or 0));
        p116.Pos = p116.Pos + 1;
    end,

    des = function(p125: table) -- Line: 291, Name: popbool
        p125.Pos = p125.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p125.Buf, p125.Pos);

        return buffer_readu8_ret % 2 >= 1, buffer_readu8_ret % 4 >= 2, buffer_readu8_ret % 8 >= 4, buffer_readu8_ret % 16 >= 8, buffer_readu8_ret % 32 >= 16, buffer_readu8_ret % 64 >= 32, buffer_readu8_ret % 128 >= 64, buffer_readu8_ret % 256 >= 128;
    end
};

function v115.boolean() -- Line: 513
    -- upvalues: u126 (ref)
    return u126;
end;

local u127 = {};

function v115.uint(u128: number) -- Line: 520
    -- upvalues: u127 (copy), pushu1 (copy), popu1 (copy), pushu2 (copy), popu2 (copy), pushu3 (copy), popu3 (copy), pushu4 (copy), popu4 (copy), pushu5 (copy), popu5 (copy), pushu6 (copy), popu6 (copy), pushu7 (copy), popu7 (copy), pushu8 (copy), popu8 (copy), tryrealloc (copy)
    if u127[u128] then
        return u127[u128];
    end;

    local u129 = nil;
    local v130 = nil;

    if u128 == 1 then
        u129 = pushu1;
        v130 = popu1;
    elseif u128 == 2 then
        u129 = pushu2;
        v130 = popu2;
    elseif u128 == 3 then
        u129 = pushu3;
        v130 = popu3;
    elseif u128 == 4 then
        u129 = pushu4;
        v130 = popu4;
    elseif u128 == 5 then
        u129 = pushu5;
        v130 = popu5;
    elseif u128 == 6 then
        u129 = pushu6;
        v130 = popu6;
    elseif u128 == 7 then
        u129 = pushu7;
        v130 = popu7;
    elseif u128 == 8 then
        u129 = pushu8;
        v130 = popu8;
    else
        error((`uint bytes must be integer between [1, 8], got {u128}`));
    end;

    local v133 = {
        ser = function(p131, p132) -- Line: 547, Name: ser
            -- upvalues: tryrealloc (ref), u128 (copy), u129 (ref)
            tryrealloc(p131, u128);
            u129(p131, p132);
        end,

        des = v130
    };
    u127[u128] = v133;

    return v133;
end;

local u134 = {};

function v115.int(u135: number) -- Line: 560
    -- upvalues: u134 (copy), pushi1 (copy), popi1 (copy), pushi2 (copy), popi2 (copy), pushi3 (copy), popi3 (copy), pushi4 (copy), popi4 (copy), pushi5 (copy), popi5 (copy), pushi6 (copy), popi6 (copy), pushi7 (copy), popi7 (copy), pushi8 (copy), popi8 (copy), tryrealloc (copy)
    if u134[u135] then
        return u134[u135];
    end;

    local u136 = nil;
    local v137 = nil;

    if u135 == 1 then
        u136 = pushi1;
        v137 = popi1;
    elseif u135 == 2 then
        u136 = pushi2;
        v137 = popi2;
    elseif u135 == 3 then
        u136 = pushi3;
        v137 = popi3;
    elseif u135 == 4 then
        u136 = pushi4;
        v137 = popi4;
    elseif u135 == 5 then
        u136 = pushi5;
        v137 = popi5;
    elseif u135 == 6 then
        u136 = pushi6;
        v137 = popi6;
    elseif u135 == 7 then
        u136 = pushi7;
        v137 = popi7;
    elseif u135 == 8 then
        u136 = pushi8;
        v137 = popi8;
    else
        error((`int bytes must be integer between [1, 8], got {u135}`));
    end;

    local v140 = {
        ser = function(p138, p139) -- Line: 587, Name: ser
            -- upvalues: tryrealloc (ref), u135 (copy), u136 (ref)
            tryrealloc(p138, u135);
            u136(p138, p139);
        end,

        des = v137
    };
    u134[u135] = v140;

    return v140;
end;

local u141 = {};

function v115.number(u142: number) -- Line: 600
    -- upvalues: u141 (copy), pushf4 (copy), popf4 (copy), pushf8 (copy), popf8 (copy), tryrealloc (copy)
    if u141[u142] then
        return u141[u142];
    end;

    local u143 = nil;
    local v144 = nil;

    if u142 == 4 then
        u143 = pushf4;
        v144 = popf4;
    elseif u142 == 8 then
        u143 = pushf8;
        v144 = popf8;
    else
        error((`number bytes must be integer 4 or 8, got {u142}`));
    end;

    local v147 = {
        ser = function(p145, p146) -- Line: 615, Name: ser
            -- upvalues: tryrealloc (ref), u142 (copy), u143 (ref)
            tryrealloc(p145, u142);
            u143(p145, p146);
        end,

        des = v144
    };
    u141[u142] = v147;

    return v147;
end;

local u148 = {};

function v115.range(u149: number, p150: number) -- Line: 629
    -- upvalues: u148 (copy), pushu1 (copy), popu1 (copy), pushu2 (copy), popu2 (copy), pushu3 (copy), popu3 (copy), pushu4 (copy), popu4 (copy), pushu5 (copy), popu5 (copy), pushu6 (copy), popu6 (copy), pushu7 (copy), popu7 (copy), pushu8 (copy), popu8 (copy), tryrealloc (copy)
    local v151 = `{u149}_{p150}`;
    local v152 = u148[v151];

    if v152 then
        return v152;
    end;

    local v153;

    if u149 == u149 // 1 and p150 == p150 // 1 then
        v153 = u149 < p150;
    else
        v153 = false;
    end;

    assert(v153, "min and max must be integers, and min < max");
    local v154 = p150 - u149;
    local u155, u156, u157;

    if v154 < 256 then
        u155 = pushu1;
        u156 = popu1;
        u157 = 1;
    elseif v154 < 65536 then
        u155 = pushu2;
        u156 = popu2;
        u157 = 2;
    elseif v154 < 16777216 then
        u155 = pushu3;
        u156 = popu3;
        u157 = 3;
    elseif v154 < 4294967296 then
        u155 = pushu4;
        u156 = popu4;
        u157 = 4;
    elseif v154 < 1099511627776 then
        u155 = pushu5;
        u156 = popu5;
        u157 = 5;
    elseif v154 < 281474976710656 then
        u155 = pushu6;
        u156 = popu6;
        u157 = 6;
    elseif v154 < 7.205759403792794e16 then
        u155 = pushu7;
        u156 = popu7;
        u157 = 7;
    else
        u155 = pushu8;
        u156 = popu8;
        u157 = 8;
    end;

    local v161 = {
        ser = function(p158, p159) -- Line: 658, Name: ser
            -- upvalues: tryrealloc (ref), u157 (ref), u155 (ref), u149 (copy)
            tryrealloc(p158, u157);
            u155(p158, p159 - u149);
        end,

        des = function(p160) -- Line: 662, Name: des
            -- upvalues: u156 (ref), u149 (copy)
            return u156(p160) + u149;
        end
    };
    u148[v151] = v161;

    return v161;
end;

local u165 = {
    ser = function(p162, p163) -- Line: 674, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref)
        tryrealloc(p162, #p163);
        local v164 = #p163;
        buffer.writestring(p162.Buf, p162.Pos, p163);
        p162.Pos = p162.Pos + v164;
        pushvlqrealloc(p162, v164);
    end,

    des = popstr
};
local u166 = {};
local v175 = {
    __call = function(p167: any, u168: number?) -- Line: 683, Name: __call
        -- upvalues: u165 (copy), u166 (copy), tryrealloc (copy), pushvlqrealloc (ref), popstr (copy)
        if not u168 then
            return u165;
        end;

        if u166[u168] then
            return u166[u168];
        end;

        local v174 = {
            ser = function(p169, p170) -- Line: 693, Name: ser
                -- upvalues: tryrealloc (ref), u168 (copy), pushvlqrealloc (ref)
                tryrealloc(p169, u168);
                local v171 = u168;
                local v172 = v171 or #p170;
                buffer.writestring(p169.Buf, p169.Pos, p170);
                p169.Pos = p169.Pos + v172;

                if not v171 then
                    pushvlqrealloc(p169, v172);
                end;
            end,

            des = function(p173) -- Line: 698, Name: des
                -- upvalues: popstr (ref), u168 (copy)
                return popstr(p173, u168);
            end
        };
        u166[u168] = v174;

        return v174;
    end
};
local table_create_ret = table.create(256);
local v191 = {
    convert = function(p176: string, p177: string, p178: string) -- Line: 707, Name: convert
        local v179 = {};

        for i = 1, #p177 do
            v179[string.byte(p177, i)] = i - 1;
            local _ = i;
        end;

        local v180 = {};

        for i = 1, #p178 do
            v180[i - 1] = string.byte(p178, i);
            local _ = i;
        end;

        local v181 = {};

        for i = 1, #p176 do
            local v182 = v179[string.byte(p176, i)];
            table.insert(v181, v182);
            local _ = i;
        end;

        local v183 = #p177;
        local v184 = #p178;
        local v185 = {};

        while #v181 > 0 do
            local v186 = 0;

            for i = 1, #v181 do
                local v187 = v181[i] + v186 * v183;
                v181[i] = math.floor(v187 / v184);
                v186 = v187 % v184;
                local _ = i;
            end;

            while #v181 > 0 and v181[1] == 0 do
                table.remove(v181, 1);
            end;

            local string_char_ret = string.char(v180[v186]);
            table.insert(v185, 1, string_char_ret);
        end;

        return table.concat(v185);
    end,

    alphabet = function(p188: string) -- Line: 745, Name: alphabet
        local table_create_ret2 = table.create(#p188);
        local v189 = {};

        for i = 1, #p188 do
            local string_sub_ret = string.sub(p188, i, i);
            local v190;

            if v189[string_sub_ret] then
                v190 = i;
            else
                v189[string_sub_ret] = true;
                table.insert(table_create_ret2, string_sub_ret);
                v190 = i;
            end;
        end;

        table.sort(table_create_ret2);

        return table.concat(table_create_ret2);
    end,

    binary = "01",
    octal = "01234567",
    decimal = "0123456789",
    duodecimal = "0123456789AB",
    hexadecimal = "0123456789ABCDEF"
};

for i = 0, 255 do
    table_create_ret[i + 1] = string.char(i);
    local _ = i;
end;

v191.utf8 = table.concat(table_create_ret);
v191.lower = "abcdefghijklmnopqrstuvwxyz";
v191.upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
v191.letters = v191.lower .. v191.upper;
v191.punctuation = " .,?!:;\'\"-_";
v191.english = v191.letters .. v191.punctuation;
v191.filepath = v191.letters .. ":/";
v191.datastore = " !#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~";
v115.string = setmetatable(v191, v175);
local u192 = {};
local u193 = {};

function v115.opt(u194: table) -- Line: 784
    -- upvalues: u193 (copy), tryrealloc (copy), u192 (ref)
    if u193[u194] then
        return u193[u194];
    end;

    local v198 = {
        ser = function(p195, p196) -- Line: 790, Name: ser
            -- upvalues: tryrealloc (ref), u194 (copy)
            if p196 == nil then
                tryrealloc(p195, 1);
                buffer.writeu8(p195.Buf, p195.Pos, 0);
                p195.Pos = p195.Pos + 1;

                return;
            end;

            u194.ser(p195, p196);
            tryrealloc(p195, 1);
            buffer.writeu8(p195.Buf, p195.Pos, 1);
            p195.Pos = p195.Pos + 1;
        end,

        des = function(p197) -- Line: 801, Name: des
            -- upvalues: u194 (copy)
            p197.Pos = p197.Pos - 1;

            if buffer.readu8(p197.Buf, p197.Pos) == 1 then
                return u194.des(p197);
            end;

            return nil;
        end
    };
    u193[u194] = v198;
    u192[v198] = u194;

    return v198;
end;

local u201 = {
    ser = function(p199, p200) -- Line: 817, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref)
        tryrealloc(p199, buffer.len(p200));
        local buffer_len_ret = buffer.len(p200);
        buffer.copy(p199.Buf, p199.Pos, p200, 0, buffer_len_ret);
        p199.Pos = p199.Pos + buffer_len_ret;
        pushvlqrealloc(p199, buffer_len_ret);
    end,

    des = popbuf
};
local u202 = {};

function v115.buffer(u203: number?) -- Line: 824
    -- upvalues: u201 (copy), u202 (copy), tryrealloc (copy), pushvlqrealloc (ref), popvlq (ref)
    if not u203 then
        return u201;
    end;

    if u202[u203] then
        return u202[u203];
    end;

    local v210 = {
        ser = function(p204, p205) -- Line: 834, Name: ser
            -- upvalues: tryrealloc (ref), u203 (copy), pushvlqrealloc (ref)
            tryrealloc(p204, u203);
            local v206 = u203;
            local v207 = v206 or buffer.len(p205);
            buffer.copy(p204.Buf, p204.Pos, p205, 0, v207);
            p204.Pos = p204.Pos + v207;

            if not v206 then
                pushvlqrealloc(p204, v207);
            end;
        end,

        des = function(p208) -- Line: 839, Name: des
            -- upvalues: u203 (copy), popvlq (ref)
            local v209 = u203 or popvlq(p208);
            p208.Pos = p208.Pos - v209;
            local buffer_create_ret = buffer.create(v209);
            buffer.copy(buffer_create_ret, 0, p208.Buf, p208.Pos, v209);

            return buffer_create_ret;
        end
    };
    u202[u203] = v210;

    return v210;
end;

local u211 = {
    ser = pushvlqrealloc,
    des = popvlq
};

function v115.vlq() -- Line: 853
    -- upvalues: u211 (copy)
    return u211;
end;

local function serbitarr(p212: table, p213: table, p214: number?) -- Line: 860
    local v215 = p214 or #p213;

    if v215 == 0 then
        return;
    end;

    local v216 = v215 % 8;
    local v217 = v215 - v216;

    for i = 0, v217 - 1, 8 do
        buffer.writeu8(p212.Buf, p212.Pos, (p213[i + 1] and 1 or 0) + (p213[i + 2] and 2 or 0) + (p213[i + 3] and 4 or 0) + (p213[i + 4] and 8 or 0) + (p213[i + 5] and 16 or 0) + (p213[i + 6] and 32 or 0) + (p213[i + 7] and 64 or 0) + (p213[i + 8] and 128 or 0));
        p212.Pos = p212.Pos + 1;
        local _ = i;
    end;

    if v216 == 1 then
        buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + 0 + 0 + 0 + 0 + 0 + 0 + 0);
        p212.Pos = p212.Pos + 1;

        return;
    end;

    if v216 == 2 then
        buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + (p213[v217 + 2] and 2 or 0) + 0 + 0 + 0 + 0 + 0 + 0);
        p212.Pos = p212.Pos + 1;

        return;
    end;

    if v216 == 3 then
        buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + (p213[v217 + 2] and 2 or 0) + (p213[v217 + 3] and 4 or 0) + 0 + 0 + 0 + 0 + 0);
        p212.Pos = p212.Pos + 1;

        return;
    end;

    if v216 == 4 then
        buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + (p213[v217 + 2] and 2 or 0) + (p213[v217 + 3] and 4 or 0) + (p213[v217 + 4] and 8 or 0) + 0 + 0 + 0 + 0);
        p212.Pos = p212.Pos + 1;

        return;
    end;

    if v216 == 5 then
        buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + (p213[v217 + 2] and 2 or 0) + (p213[v217 + 3] and 4 or 0) + (p213[v217 + 4] and 8 or 0) + (p213[v217 + 5] and 16 or 0) + 0 + 0 + 0);
        p212.Pos = p212.Pos + 1;

        return;
    end;

    if v216 ~= 6 then
        if v216 == 7 then
            buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + (p213[v217 + 2] and 2 or 0) + (p213[v217 + 3] and 4 or 0) + (p213[v217 + 4] and 8 or 0) + (p213[v217 + 5] and 16 or 0) + (p213[v217 + 6] and 32 or 0) + (p213[v217 + 7] and 64 or 0) + 0);
            p212.Pos = p212.Pos + 1;
        end;

        return;
    end;

    buffer.writeu8(p212.Buf, p212.Pos, (p213[v217 + 1] and 1 or 0) + (p213[v217 + 2] and 2 or 0) + (p213[v217 + 3] and 4 or 0) + (p213[v217 + 4] and 8 or 0) + (p213[v217 + 5] and 16 or 0) + (p213[v217 + 6] and 32 or 0) + 0 + 0);
    p212.Pos = p212.Pos + 1;
end;

local function desbitarr(p218: table, p219: number) -- Line: 892
    if p219 == 0 then
        return {};
    end;

    local table_create_ret2 = table.create(p219);
    local v220 = p219 // 8;
    local v221 = v220 * 8;
    local v222 = p219 % 8;

    if v222 > 0 then
        p218.Pos = p218.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p218.Buf, p218.Pos);
        local v223 = buffer_readu8_ret % 4 >= 2;
        local v224 = buffer_readu8_ret % 8 >= 4;
        local v225 = buffer_readu8_ret % 16 >= 8;
        local v226 = buffer_readu8_ret % 32 >= 16;
        local v227 = buffer_readu8_ret % 64 >= 32;
        local v228 = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        table_create_ret2[v221 + 1] = buffer_readu8_ret % 2 >= 1;

        if v222 <= 1 then
            v223 = nil;
        end;

        table_create_ret2[v221 + 2] = v223;

        if v222 <= 2 then
            v224 = nil;
        end;

        table_create_ret2[v221 + 3] = v224;

        if v222 <= 3 then
            v225 = nil;
        end;

        table_create_ret2[v221 + 4] = v225;

        if v222 <= 4 then
            v226 = nil;
        end;

        table_create_ret2[v221 + 5] = v226;

        if v222 <= 5 then
            v227 = nil;
        end;

        table_create_ret2[v221 + 6] = v227;

        if v222 <= 6 then
            v228 = nil;
        end;

        table_create_ret2[v221 + 7] = v228;
    end;

    for i = v220 - 1, 0, -1 do
        local v229 = i * 8;
        p218.Pos = p218.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p218.Buf, p218.Pos);
        table_create_ret2[v229 + 1] = buffer_readu8_ret % 2 >= 1;
        table_create_ret2[v229 + 2] = buffer_readu8_ret % 4 >= 2;
        table_create_ret2[v229 + 3] = buffer_readu8_ret % 8 >= 4;
        table_create_ret2[v229 + 4] = buffer_readu8_ret % 16 >= 8;
        table_create_ret2[v229 + 5] = buffer_readu8_ret % 32 >= 16;
        table_create_ret2[v229 + 6] = buffer_readu8_ret % 64 >= 32;
        table_create_ret2[v229 + 7] = buffer_readu8_ret % 128 >= 64;
        table_create_ret2[v229 + 8] = buffer_readu8_ret % 256 >= 128;
        local _ = i;
    end;

    return table_create_ret2;
end;

local u230 = {};

function v115.array(u231: table, u232: any) -- Line: 924
    -- upvalues: u230 (copy), u126 (ref), serbitarr (copy), pushvlqrealloc (ref), popvlq (ref), desbitarr (copy), u192 (ref), tryrealloc (copy)
    local v233 = u230[u231];
    local v234 = u232 or 0;

    if v233 then
        if v233[v234] then
            return v233[v234];
        end;
    else
        v233 = {};
        u230[u231] = v233;
    end;

    if u231 == u126 then
        local v240 = {
            ser = function(p235, p236) -- Line: 938, Name: ser
                -- upvalues: u232 (copy), serbitarr (ref), pushvlqrealloc (ref)
                local v237;

                if type(u232) == "number" then
                    v237 = u232;
                else
                    v237 = #p236;
                end;

                serbitarr(p235, p236, v237);

                if u232 then
                    if type(u232) ~= "number" then
                        u232.ser(p235, v237);
                    end;

                    return;
                end;

                pushvlqrealloc(p235, v237);
            end,

            des = function(p238) -- Line: 947, Name: des
                -- upvalues: u232 (copy), popvlq (ref), desbitarr (ref)
                local v239;

                if u232 then
                    if type(u232) == "number" then
                        v239 = u232;
                    else
                        v239 = u232.des(p238);
                    end;
                else
                    v239 = popvlq(p238);
                end;

                return desbitarr(p238, v239);
            end
        };
        v233[v234] = v240;

        return v240;
    end;

    if not u192[u231] then
        local v246 = {
            ser = function(p241, p242) -- Line: 1051, Name: ser
                -- upvalues: u231 (copy), u232 (copy), pushvlqrealloc (ref)
                local ser = u231.ser;
                local v243;

                if type(u232) == "number" then
                    v243 = u232;
                else
                    v243 = #p242;
                end;

                for i = 1, v243 do
                    ser(p241, p242[i]);
                    local _ = i;
                end;

                if u232 then
                    if type(u232) ~= "number" then
                        u232.ser(p241, v243);
                    end;

                    return;
                end;

                pushvlqrealloc(p241, v243);
            end,

            des = function(p244) -- Line: 1064, Name: des
                -- upvalues: u231 (copy), u232 (copy), popvlq (ref)
                local des = u231.des;
                local v245;

                if u232 then
                    if type(u232) == "number" then
                        v245 = u232;
                    else
                        v245 = u232.des(p244);
                    end;
                else
                    v245 = popvlq(p244);
                end;

                local table_create_ret2 = table.create(v245);

                for i = v245, 1, -1 do
                    table_create_ret2[i] = des(p244);
                    local _ = i;
                end;

                return table_create_ret2;
            end
        };
        v233[v234] = v246;

        return v246;
    end;

    local u247 = u192[u231];

    if u247 == u126 then
        local v259 = {
            ser = function(p248, p249) -- Line: 958, Name: ser
                -- upvalues: u232 (copy), tryrealloc (ref), serbitarr (ref), pushvlqrealloc (ref)
                local v250;

                if type(u232) == "number" then
                    v250 = u232;
                else
                    v250 = table.maxn(p249);
                end;

                local table_create_ret2 = table.create(v250);
                local table_create_ret3 = table.create(v250);

                for i = 1, v250 do
                    local v251 = p249[i];
                    local v252;

                    if v251 == nil then
                        table_create_ret3[i] = false;
                        v252 = i;
                    else
                        table.insert(table_create_ret2, v251);
                        table_create_ret3[i] = true;
                        v252 = i;
                    end;
                end;

                tryrealloc(p248, #table_create_ret2 // 8 + 1 + (1 + v250 // 8));
                serbitarr(p248, table_create_ret2);
                serbitarr(p248, table_create_ret3);

                if u232 then
                    if type(u232) ~= "number" then
                        u232.ser(p248, v250);
                    end;

                    return;
                end;

                pushvlqrealloc(p248, v250);
            end,

            des = function(p253) -- Line: 983, Name: des
                -- upvalues: u232 (copy), popvlq (ref), desbitarr (ref)
                local v254;

                if u232 then
                    if type(u232) == "number" then
                        v254 = u232;
                    else
                        v254 = u232.des(p253);
                    end;
                else
                    v254 = popvlq(p253);
                end;

                local v255 = desbitarr(p253, v254);
                local v256 = 0;

                for _, v in v255 do
                    v256 = v256 + (v and 1 or 0);
                end;

                local v257 = desbitarr(p253, v256);
                local table_create_ret2 = table.create(v254);
                local v258 = 1;

                for i, v in v255 do
                    if v then
                        table_create_ret2[i] = v257[v258];
                        v258 = v258 + 1;
                    end;
                end;

                return table_create_ret2;
            end
        };
        v233[v234] = v259;

        return v259;
    end;

    local v269 = {
        ser = function(p260: any, p261: table) -- Line: 1008, Name: ser
            -- upvalues: u247 (copy), u232 (copy), tryrealloc (ref), serbitarr (ref), pushvlqrealloc (ref)
            local ser = u247.ser;
            local v262;

            if type(u232) == "number" then
                v262 = u232;
            else
                v262 = table.maxn(p261);
            end;

            local table_create_ret2 = table.create(v262);

            for i = 1, v262 do
                local v263 = p261[i];
                local v264;

                if v263 == nil then
                    table_create_ret2[i] = false;
                    v264 = i;
                else
                    ser(p260, v263);
                    table_create_ret2[i] = true;
                    v264 = i;
                end;
            end;

            tryrealloc(p260, 1 + v262 // 8);
            serbitarr(p260, table_create_ret2);

            if u232 then
                if type(u232) ~= "number" then
                    u232.ser(p260, v262);
                end;

                return;
            end;

            pushvlqrealloc(p260, v262);
        end,

        des = function(p265) -- Line: 1031, Name: des
            -- upvalues: u247 (copy), u232 (copy), popvlq (ref), desbitarr (ref)
            local des = u247.des;
            local v266;

            if u232 then
                if type(u232) == "number" then
                    v266 = u232;
                else
                    v266 = u232.des(p265);
                end;
            else
                v266 = popvlq(p265);
            end;

            local v267 = desbitarr(p265, v266);
            local table_create_ret2 = table.create(v266);

            for i = v266, 1, -1 do
                local v268;

                if v267[i] then
                    table_create_ret2[i] = des(p265);
                    v268 = i;
                else
                    v268 = i;
                end;
            end;

            return table_create_ret2;
        end
    };
    v233[v234] = v269;

    return v269;
end;

function v115.tuple(...) -- Line: 1082
    local u270 = { ... };
    local u271 = #u270;

    return u271 ~= 1 and {
        ser = function(p272, ...) -- Line: 1090, Name: ser
            -- upvalues: u270 (copy)
            for i, v in { ... } do
                u270[i].ser(p272, v);
            end;
        end,

        des = function(p273) -- Line: 1096, Name: des
            -- upvalues: u271 (copy), u270 (copy)
            local table_create_ret2 = table.create(u271);

            for i = u271, 1, -1 do
                table_create_ret2[i] = u270[i].des(p273);
                local _ = i;
            end;

            return table.unpack(table_create_ret2);
        end
    } or u270[1];
end;

function v115.record(u274) -- Line: 1110
    -- upvalues: u192 (ref), u126 (ref), tryrealloc (copy), serbitarr (copy), desbitarr (copy)
    local u275 = {};
    local u276 = {};
    local u277 = {};
    local u278 = {};

    for i, v in u274 do
        if type(i) == "string" then
            local v279 = u192[v];

            if v279 == u126 then
                table.insert(u275, i);
            elseif v279 then
                table.insert(u276, i);
            elseif v == u126 then
                table.insert(u277, i);
            else
                table.insert(u278, i);
            end;
        end;
    end;

    local u280 = #u278;
    table.sort(u278);
    local u281 = #u277;

    if u281 > 0 then
        table.sort(u277);
    end;

    local u282 = #u276;
    local u283 = {};

    if u282 > 0 then
        table.sort(u276);

        for i, v in u276 do
            u283[i] = u192[u274[v]];
        end;
    end;

    local u284 = #u275;

    if u284 > 0 then
        table.sort(u275);
    end;

    return {
        ser = function(p285, p286) -- Line: 1153, Name: ser
            -- upvalues: u278 (copy), u274 (copy), u281 (copy), u284 (copy), u277 (copy), u282 (copy), u275 (copy), u276 (copy), u283 (copy), tryrealloc (ref), serbitarr (ref)
            for _, v in u278 do
                u274[v].ser(p285, p286[v]);
            end;

            local table_create_ret2 = table.create(u281 + u284);

            for i, v in u277 do
                table_create_ret2[i] = p286[v];
            end;

            local v287 = u281;
            local table_create_ret3 = table.create(u284 + u282);

            for i, v in u275 do
                local v288 = p286[v];

                if v288 == nil then
                    table_create_ret3[i] = false;
                else
                    v287 = v287 + 1;
                    table_create_ret2[v287] = v288;
                    table_create_ret3[i] = true;
                end;
            end;

            for i, v in u276 do
                local v289 = i + u284;
                local v290 = p286[v];

                if v290 == nil then
                    table_create_ret3[v289] = false;
                else
                    u283[i].ser(p285, v290);
                    table_create_ret3[v289] = true;
                end;
            end;

            tryrealloc(p285, v287 + u284 + u282);
            serbitarr(p285, table_create_ret2, v287);
            serbitarr(p285, table_create_ret3, u284 + u282);
        end,

        des = function(p291) -- Line: 1195, Name: des
            -- upvalues: desbitarr (ref), u284 (copy), u282 (copy), u281 (copy), u277 (copy), u275 (copy), u276 (copy), u274 (copy), u283 (copy), u280 (copy), u278 (copy)
            local v292 = desbitarr(p291, u284 + u282);
            local v293 = u281;
            local v294 = {};

            for i = 1, u284 do
                v293 = v293 + (v292[i] and 1 or 0);
                local _ = i;
            end;

            local v295 = desbitarr(p291, v293);

            for i, v in u277 do
                v294[v] = v295[i];
            end;

            for i = u284, 1, -1 do
                local v296;

                if v292[i] then
                    v294[u275[i]] = v295[v293];
                    v293 = v293 - 1;
                    v296 = i;
                else
                    v296 = i;
                end;
            end;

            for i = u282, 1, -1 do
                local v297;

                if v292[i + u284] then
                    local v298 = u276[i];
                    local _ = u274[v298];
                    v294[v298] = u283[i].des(p291);
                    v297 = i;
                else
                    v297 = i;
                end;
            end;

            for i = u280, 1, -1 do
                local v299 = u278[i];
                v294[v299] = u274[v299].des(p291);
                local _ = i;
            end;

            return v294;
        end
    };
end;

function v115.map(u300: table, u301: table, u302: any) -- Line: 1243
    -- upvalues: pushvlqrealloc (ref), popvlq (ref)
    return {
        ser = function(p303, p304) -- Line: 1245, Name: ser
            -- upvalues: u301 (copy), u300 (copy), u302 (copy), pushvlqrealloc (ref)
            local v305 = 0;

            for i, v in p304 do
                u301.ser(p303, v);
                u300.ser(p303, i);
                v305 = v305 + 1;
            end;

            if u302 then
                if type(u302) ~= "number" then
                    u302.ser(p303, v305);
                end;

                return;
            end;

            pushvlqrealloc(p303, v305);
        end,

        des = function(p306) -- Line: 1259, Name: des
            -- upvalues: u302 (copy), popvlq (ref), u300 (copy), u301 (copy)
            local v307 = {};
            local v308;

            if u302 then
                if type(u302) == "number" then
                    v308 = u302;
                else
                    v308 = u302.des(p306);
                end;
            else
                v308 = popvlq(p306);
            end;

            for i = 1, v308 do
                v307[u300.des(p306)] = u301.des(p306);
                local _ = i;
            end;

            return v307;
        end
    };
end;

function v115.literal(...) -- Line: 1277
    -- upvalues: tryrealloc (copy)
    local u309 = { ... };
    local u310 = {};

    for i, v in u309 do
        u310[v] = i - 1;
    end;

    return {
        ser = function(p311, p312) -- Line: 1286, Name: ser
            -- upvalues: tryrealloc (ref), u310 (copy)
            tryrealloc(p311, 1);
            buffer.writeu8(p311.Buf, p311.Pos, u310[p312]);
            p311.Pos = p311.Pos + 1;
        end,

        des = function(p313) -- Line: 1291, Name: des
            -- upvalues: u309 (copy)
            p313.Pos = p313.Pos - 1;

            return u309[buffer.readu8(p313.Buf, p313.Pos) + 1];
        end
    };
end;

function v115.table(u314: table, u315: any) -- Line: 1299
    -- upvalues: tryrealloc (copy), pushvlqrealloc (ref), popvlq (ref)
    local u316 = {};
    local u317 = {};

    for i in u314 do
        local v318 = #u316 + 1;
        u316[v318] = i;
        u317[i] = v318;
    end;

    return {
        ser = function(p319, p320) -- Line: 1310, Name: ser
            -- upvalues: u314 (copy), u317 (copy), tryrealloc (ref), u315 (copy), pushvlqrealloc (ref)
            local v321 = 0;

            for i, v in p320 do
                local v322 = typeof(v);
                local v323 = u314[v322];

                if v323 then
                    local v324 = typeof(i);
                    local v325 = u314[v324];

                    if v325 then
                        v323.ser(p319, v);
                        local v326 = u317[v322] or error("");
                        tryrealloc(p319, 1);
                        buffer.writeu8(p319.Buf, p319.Pos, v326 - 1);
                        p319.Pos = p319.Pos + 1;
                        v325.ser(p319, i);
                        local v327 = u317[v324] or error("");
                        tryrealloc(p319, 1);
                        buffer.writeu8(p319.Buf, p319.Pos, v327 - 1);
                        p319.Pos = p319.Pos + 1;
                        v321 = v321 + 1;
                    end;
                end;
            end;

            if u315 then
                if type(u315) ~= "number" then
                    u315.ser(p319, v321);
                end;

                return;
            end;

            pushvlqrealloc(p319, v321);
        end,

        des = function(p328) -- Line: 1345, Name: des
            -- upvalues: u315 (copy), popvlq (ref), u316 (copy), u314 (copy)
            local v329 = {};
            local v330;

            if u315 then
                if type(u315) == "number" then
                    v330 = u315;
                else
                    v330 = u315.des(p328);
                end;
            else
                v330 = popvlq(p328);
            end;

            for i = 1, v330 do
                p328.Pos = p328.Pos - 1;
                local v331 = u314[u316[buffer.readu8(p328.Buf, p328.Pos) + 1]].des(p328);
                p328.Pos = p328.Pos - 1;
                v329[v331] = u314[u316[buffer.readu8(p328.Buf, p328.Pos) + 1]].des(p328);
                local _ = i;
            end;

            return v329;
        end
    };
end;

local u344 = {
    ser = function(p332, p333) -- Line: 1369, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p332, 2);
        buffer.writeu8(p332.Buf, p332.Pos, (p333.Back and 1 or 0) + (p333.Bottom and 2 or 0) + (p333.Front and 4 or 0) + (p333.Left and 8 or 0) + (p333.Right and 16 or 0) + (p333.Top and 32 or 0) + 0 + 0);
        p332.Pos = p332.Pos + 1;
        buffer.writeu8(p332.Buf, p332.Pos, (p333.X and 1 or 0) + (p333.Y and 2 or 0) + (p333.Z and 4 or 0) + 0 + 0 + 0 + 0 + 0);
        p332.Pos = p332.Pos + 1;
    end,

    des = function(p334) -- Line: 1375, Name: des
        p334.Pos = p334.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p334.Buf, p334.Pos);
        local v335 = buffer_readu8_ret % 2 >= 1;
        local v336 = buffer_readu8_ret % 4 >= 2;
        local v337 = buffer_readu8_ret % 8 >= 4;
        local _ = buffer_readu8_ret % 16 >= 8;
        local _ = buffer_readu8_ret % 32 >= 16;
        local _ = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        p334.Pos = p334.Pos - 1;
        local buffer_readu8_ret2 = buffer.readu8(p334.Buf, p334.Pos);
        local v338 = buffer_readu8_ret2 % 2 >= 1;
        local v339 = buffer_readu8_ret2 % 4 >= 2;
        local v340 = buffer_readu8_ret2 % 8 >= 4;
        local v341 = buffer_readu8_ret2 % 16 >= 8;
        local v342 = buffer_readu8_ret2 % 32 >= 16;
        local v343 = buffer_readu8_ret2 % 64 >= 32;
        local _ = buffer_readu8_ret2 % 128 >= 64;
        local _ = buffer_readu8_ret2 % 256 >= 128;

        if v335 then
            v335 = Enum.Axis.X;
        end;

        if v336 then
            v336 = Enum.Axis.Y;
        end;

        if v337 then
            v337 = Enum.Axis.Z;
        end;

        if v338 then
            v338 = Enum.NormalId.Back;
        end;

        if v339 then
            v339 = Enum.NormalId.Bottom;
        end;

        if v340 then
            v340 = Enum.NormalId.Front;
        end;

        if v341 then
            v341 = Enum.NormalId.Left;
        end;

        if v342 then
            v342 = Enum.NormalId.Right;
        end;

        if v343 then
            v343 = Enum.NormalId.Top;
        end;

        return Axes.new(v335, v336, v337, v338, v339, v340, v341, v342, v343);
    end
};

function v115.Axes() -- Line: 1391
    -- upvalues: u344 (copy)
    return u344;
end;

local u348 = {
    ser = function(p345, p346) -- Line: 1398, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p345, 2);
        buffer.writeu16(p345.Buf, p345.Pos, p346.Number);
        p345.Pos = p345.Pos + 2;
    end,

    des = function(p347) -- Line: 1403, Name: des
        p347.Pos = p347.Pos - 2;
        local buffer_readu16_ret = buffer.readu16(p347.Buf, p347.Pos);

        return BrickColor.new(buffer_readu16_ret);
    end
};

function v115.BrickColor() -- Line: 1408
    -- upvalues: u348 (copy)
    return u348;
end;

local u349 = {};

function v115.EnumItem(p350: userdata) -- Line: 1416
    -- upvalues: u349 (copy), pushvlqrealloc (ref), popvlq (ref)
    if u349[p350] then
        return u349[p350];
    end;

    local EnumItems = p350:GetEnumItems();
    table.sort(EnumItems, function(p351, p352) -- Line: 1422
        return p351.Value < p352.Value;
    end);
    local table_create_ret2 = table.create(#EnumItems);
    local u353 = {};

    for i, v in EnumItems do
        u353[v] = i;
        table_create_ret2[i] = v;
    end;

    local v357 = {
        ser = function(p354, p355) -- Line: 1434, Name: ser
            -- upvalues: pushvlqrealloc (ref), u353 (copy)
            pushvlqrealloc(p354, u353[p355]);
        end,

        des = function(p356) -- Line: 1438, Name: des
            -- upvalues: popvlq (ref), table_create_ret2 (copy)
            return table_create_ret2[popvlq(p356)];
        end
    };
    u349[p350] = v357;

    return v357;
end;

local EnumItem = v115.EnumItem;
local u366 = {
    ser = function(p358, p359) -- Line: 1452, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref), EnumItem (ref)
        tryrealloc(p358, #p359.CreatorName + 10 + #p359.SearchKeyword);
        buffer.writeu8(p358.Buf, p358.Pos, (p359.IncludeOffSale and 1 or 0) + 0 + 0 + 0 + 0 + 0 + 0 + 0);
        p358.Pos = p358.Pos + 1;
        buffer.writeu8(p358.Buf, p358.Pos, p359.Limit);
        p358.Pos = p358.Pos + 1;
        buffer.writeu32(p358.Buf, p358.Pos, p359.MinPrice);
        p358.Pos = p358.Pos + 4;
        buffer.writeu32(p358.Buf, p358.Pos, p359.MaxPrice);
        p358.Pos = p358.Pos + 4;
        local CreatorName = p359.CreatorName;
        local v360 = #CreatorName;
        buffer.writestring(p358.Buf, p358.Pos, CreatorName);
        p358.Pos = p358.Pos + v360;
        pushvlqrealloc(p358, v360);
        local SearchKeyword = p359.SearchKeyword;
        local v361 = #SearchKeyword;
        buffer.writestring(p358.Buf, p358.Pos, SearchKeyword);
        p358.Pos = p358.Pos + v361;
        pushvlqrealloc(p358, v361);
        EnumItem(Enum.CatalogSortType).ser(p358, p359.SortType);
        EnumItem(Enum.CatalogSortAggregation).ser(p358, p359.SortAggregation);
        EnumItem(Enum.CatalogCategoryFilter).ser(p358, p359.CategoryFilter);
        EnumItem(Enum.SalesTypeFilter).ser(p358, p359.SalesTypeFilter);

        for _, v in p359.AssetTypes do
            EnumItem(Enum.AssetType).ser(p358, v);
        end;

        pushvlqrealloc(p358, #p359.AssetTypes);
    end,

    des = function(p362) -- Line: 1470, Name: des
        -- upvalues: popvlq (ref), EnumItem (ref)
        local CatalogSearchParams_new_ret = CatalogSearchParams.new();
        local v363 = popvlq(p362);
        local table_create_ret2 = table.create(v363);

        for i = v363, 1, -1 do
            table_create_ret2[i] = EnumItem(Enum.AssetType).des(p362);
            local _ = i;
        end;

        CatalogSearchParams_new_ret.AssetTypes = table_create_ret2;
        CatalogSearchParams_new_ret.SalesTypeFilter = EnumItem(Enum.SalesTypeFilter).des(p362);
        CatalogSearchParams_new_ret.CategoryFilter = EnumItem(Enum.CatalogCategoryFilter).des(p362);
        CatalogSearchParams_new_ret.SortAggregation = EnumItem(Enum.CatalogSortAggregation).des(p362);
        CatalogSearchParams_new_ret.SortType = EnumItem(Enum.CatalogSortType).des(p362);
        local v364 = popvlq(p362);
        p362.Pos = p362.Pos - v364;
        CatalogSearchParams_new_ret.SearchKeyword = buffer.readstring(p362.Buf, p362.Pos, v364);
        local v365 = popvlq(p362);
        p362.Pos = p362.Pos - v365;
        CatalogSearchParams_new_ret.CreatorName = buffer.readstring(p362.Buf, p362.Pos, v365);
        p362.Pos = p362.Pos - 4;
        CatalogSearchParams_new_ret.MaxPrice = buffer.readu32(p362.Buf, p362.Pos);
        p362.Pos = p362.Pos - 4;
        CatalogSearchParams_new_ret.MinPrice = buffer.readu32(p362.Buf, p362.Pos);
        p362.Pos = p362.Pos - 1;
        CatalogSearchParams_new_ret.Limit = buffer.readu8(p362.Buf, p362.Pos);
        p362.Pos = p362.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p362.Buf, p362.Pos);
        local _ = buffer_readu8_ret % 4 >= 2;
        local _ = buffer_readu8_ret % 8 >= 4;
        local _ = buffer_readu8_ret % 16 >= 8;
        local _ = buffer_readu8_ret % 32 >= 16;
        local _ = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        CatalogSearchParams_new_ret.IncludeOffSale = buffer_readu8_ret % 2 >= 1;

        return CatalogSearchParams_new_ret;
    end
};

function v115.CatalogSearchParams() -- Line: 1492
    -- upvalues: u366 (copy)
    return u366;
end;

local function cframeLookupEntries() -- Line: 1499
    return {
        CFrame.Angles(0, 0, 0),
        CFrame.Angles(1.5707963267948966, 0, 0),
        CFrame.Angles(0, 3.141592653589793, 3.141592653589793),
        CFrame.Angles(-1.5707963267948966, 0, 0),
        CFrame.Angles(0, 3.141592653589793, 1.5707963267948966),
        CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
        CFrame.Angles(0, 0, 1.5707963267948966),
        CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
        CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0),
        CFrame.Angles(0, -1.5707963267948966, 0),
        CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0),
        CFrame.Angles(0, 1.5707963267948966, 3.141592653589793),
        CFrame.Angles(0, -1.5707963267948966, 3.141592653589793),
        CFrame.Angles(0, 3.141592653589793, 0),
        CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0),
        CFrame.Angles(0, 0, 3.141592653589793),
        CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
        CFrame.Angles(0, 0, -1.5707963267948966),
        CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966),
        CFrame.Angles(0, -3.141592653589793, -1.5707963267948966),
        CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966),
        CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0),
        CFrame.Angles(0, 1.5707963267948966, 0),
        CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
    };
end;

local function cframeSpecialCaseLookup(p367: table) -- Line: 1528
    local v368 = {};

    for i, v in p367 do
        v368[Vector3.new(v:ToOrientation())] = i;
    end;

    return v368;
end;

local u369 = nil;
local u370 = nil;

local function rotser(p371: any, p372) -- Line: 1541
    -- upvalues: u369 (ref), cframeLookupEntries (copy), u370 (ref), cframeSpecialCaseLookup (copy), tryrealloc (copy)
    u369 = u369 or cframeLookupEntries();
    u370 = u370 or cframeSpecialCaseLookup(u369);
    local v373 = u370[Vector3.new(p372:ToOrientation())];

    if v373 then
        tryrealloc(p371, 1);
        buffer.writeu8(p371.Buf, p371.Pos, v373);
        p371.Pos = p371.Pos + 1;

        return;
    end;

    local v374, v375 = p372:ToAxisAngle();
    local v376 = v374 * math.sin(v375 / 2);
    tryrealloc(p371, 7);
    local math_round_ret = math.round((v376.Z + 1) * 32768 - 1);
    local math_round_ret2 = math.round((v376.Y + 1) * 32768 - 1);
    local math_round_ret3 = math.round((v376.X + 1) * 32768 - 1);
    buffer.writeu16(p371.Buf, p371.Pos, math_round_ret);
    p371.Pos = p371.Pos + 2;
    buffer.writeu16(p371.Buf, p371.Pos, math_round_ret2);
    p371.Pos = p371.Pos + 2;
    buffer.writeu16(p371.Buf, p371.Pos, math_round_ret3);
    p371.Pos = p371.Pos + 2;
    buffer.writeu8(p371.Buf, p371.Pos, 0);
    p371.Pos = p371.Pos + 1;
end;

local function rotdes(p377) -- Line: 1564
    -- upvalues: u369 (ref), cframeLookupEntries (copy), u370 (ref), cframeSpecialCaseLookup (copy)
    p377.Pos = p377.Pos - 1;
    local buffer_readu8_ret = buffer.readu8(p377.Buf, p377.Pos);

    if buffer_readu8_ret ~= 0 then
        u369 = u369 or cframeLookupEntries();
        u370 = u370 or cframeSpecialCaseLookup(u369);

        return u369[buffer_readu8_ret];
    end;

    p377.Pos = p377.Pos - 2;
    local v378 = (buffer.readu16(p377.Buf, p377.Pos) + 1) * 0.000030517578125 - 1;
    p377.Pos = p377.Pos - 2;
    local v379 = (buffer.readu16(p377.Buf, p377.Pos) + 1) * 0.000030517578125 - 1;
    p377.Pos = p377.Pos - 2;
    local v380 = (buffer.readu16(p377.Buf, p377.Pos) + 1) * 0.000030517578125 - 1;
    local v381 = 1 - math.clamp(v378 * v378 + v379 * v379 + v380 * v380, 0, 1);
    local math_sqrt_ret = math.sqrt(v381);

    return CFrame.new(0, 0, 0, v378, v379, v380, math_sqrt_ret);
end;

local u382 = {
    ser = rotser,
    des = rotdes
};

function v115.rotation() -- Line: 1584
    -- upvalues: u382 (copy)
    return u382;
end;

local u383 = {};

function v115.CFrame(p384: table) -- Line: 1592
    -- upvalues: u383 (copy), rotser (ref), rotdes (ref)
    if u383[p384] then
        return u383[p384];
    end;

    local ser = p384.ser;
    local des = p384.des;
    local v391 = {
        ser = function(p385, p386) -- Line: 1600, Name: ser
            -- upvalues: rotser (ref), ser (copy)
            rotser(p385, p386);
            local Position = p386.Position;
            ser(p385, Position.Z);
            ser(p385, Position.Y);
            ser(p385, Position.X);
        end,

        des = function(p387) -- Line: 1609, Name: des
            -- upvalues: des (copy), rotdes (ref)
            local v388 = des(p387);
            local v389 = des(p387);
            local v390 = des(p387);

            return rotdes(p387) + Vector3.new(v388, v389, v390);
        end
    };
    u383[p384] = v391;

    return v391;
end;

local CFrame2 = v115.CFrame;

local function pushcolor3(p392, p393) -- Line: 1621
    buffer.writeu8(p392.Buf, p392.Pos, p393.B * 255);
    p392.Pos = p392.Pos + 1;
    buffer.writeu8(p392.Buf, p392.Pos, p393.G * 255);
    p392.Pos = p392.Pos + 1;
    buffer.writeu8(p392.Buf, p392.Pos, p393.R * 255);
    p392.Pos = p392.Pos + 1;
end;

local function popcolor3(p394) -- Line: 1626
    local Color3_fromRGB = Color3.fromRGB;
    p394.Pos = p394.Pos - 1;
    local buffer_readu8_ret = buffer.readu8(p394.Buf, p394.Pos);
    p394.Pos = p394.Pos - 1;
    local buffer_readu8_ret2 = buffer.readu8(p394.Buf, p394.Pos);
    p394.Pos = p394.Pos - 1;

    return Color3_fromRGB(buffer_readu8_ret, buffer_readu8_ret2, (buffer.readu8(p394.Buf, p394.Pos)));
end;

local u397 = {
    ser = function(p395, p396) -- Line: 1631, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p395, 3);
        buffer.writeu8(p395.Buf, p395.Pos, p396.B * 255);
        p395.Pos = p395.Pos + 1;
        buffer.writeu8(p395.Buf, p395.Pos, p396.G * 255);
        p395.Pos = p395.Pos + 1;
        buffer.writeu8(p395.Buf, p395.Pos, p396.R * 255);
        p395.Pos = p395.Pos + 1;
    end,

    des = popcolor3
};

function v115.Color3() -- Line: 1637
    -- upvalues: u397 (copy)
    return u397;
end;

local function pushcolorsequencekeypoint(p398, p399) -- Line: 1642
    local Value = p399.Value;
    buffer.writeu8(p398.Buf, p398.Pos, Value.B * 255);
    p398.Pos = p398.Pos + 1;
    buffer.writeu8(p398.Buf, p398.Pos, Value.G * 255);
    p398.Pos = p398.Pos + 1;
    buffer.writeu8(p398.Buf, p398.Pos, Value.R * 255);
    p398.Pos = p398.Pos + 1;
    buffer.writeu8(p398.Buf, p398.Pos, p399.Time * 255);
    p398.Pos = p398.Pos + 1;
end;

local u403 = {
    ser = function(p400, p401) -- Line: 1651, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p400, 4);
        local Value = p401.Value;
        buffer.writeu8(p400.Buf, p400.Pos, Value.B * 255);
        p400.Pos = p400.Pos + 1;
        buffer.writeu8(p400.Buf, p400.Pos, Value.G * 255);
        p400.Pos = p400.Pos + 1;
        buffer.writeu8(p400.Buf, p400.Pos, Value.R * 255);
        p400.Pos = p400.Pos + 1;
        buffer.writeu8(p400.Buf, p400.Pos, p401.Time * 255);
        p400.Pos = p400.Pos + 1;
    end,

    des = function(p402) -- Line: 1646, Name: popcolorsequencekeypoint
        -- upvalues: popcolor3 (copy)
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        p402.Pos = p402.Pos - 1;

        return ColorSequenceKeypoint_new(buffer.readu8(p402.Buf, p402.Pos) / 255, popcolor3(p402));
    end
};

function v115.ColorSequenceKeypoint() -- Line: 1657
    -- upvalues: u403 (copy)
    return u403;
end;

local u408 = {
    ser = function(p404, p405) -- Line: 1664, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref)
        tryrealloc(p404, #p405.Keypoints * 4);

        for _, v in p405.Keypoints do
            local Value = v.Value;
            buffer.writeu8(p404.Buf, p404.Pos, Value.B * 255);
            p404.Pos = p404.Pos + 1;
            buffer.writeu8(p404.Buf, p404.Pos, Value.G * 255);
            p404.Pos = p404.Pos + 1;
            buffer.writeu8(p404.Buf, p404.Pos, Value.R * 255);
            p404.Pos = p404.Pos + 1;
            buffer.writeu8(p404.Buf, p404.Pos, v.Time * 255);
            p404.Pos = p404.Pos + 1;
        end;

        pushvlqrealloc(p404, #p405.Keypoints);
    end,

    des = function(p406) -- Line: 1672, Name: des
        -- upvalues: popvlq (ref), popcolor3 (copy)
        local v407 = popvlq(p406);
        local table_create_ret2 = table.create(v407);

        for i = v407, 1, -1 do
            local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
            p406.Pos = p406.Pos - 1;
            table_create_ret2[i] = ColorSequenceKeypoint_new(buffer.readu8(p406.Buf, p406.Pos) / 255, popcolor3(p406));
            local _ = i;
        end;

        return ColorSequence.new(table_create_ret2);
    end
};

function v115.ColorSequence() -- Line: 1681
    -- upvalues: u408 (copy)
    return u408;
end;

local u412 = {
    ser = function(p409, p410) -- Line: 1688, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p409, 6);
        local UnixTimestampMillis = p410.UnixTimestampMillis;
        buffer.writeu16(p409.Buf, p409.Pos, UnixTimestampMillis);
        buffer.writeu32(p409.Buf, p409.Pos + 2, UnixTimestampMillis // 65536);
        p409.Pos = p409.Pos + 6;
    end,

    des = function(p411) -- Line: 1692, Name: des
        local DateTime_fromUnixTimestampMillis = DateTime.fromUnixTimestampMillis;
        p411.Pos = p411.Pos - 6;

        return DateTime_fromUnixTimestampMillis(buffer.readu16(p411.Buf, p411.Pos) + buffer.readu32(p411.Buf, p411.Pos + 2) * 65536);
    end
};

function v115.DateTime() -- Line: 1696
    -- upvalues: u412 (copy)
    return u412;
end;

local u422 = {
    ser = function(p413, p414) -- Line: 1703, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p413, 1);
        buffer.writeu8(p413.Buf, p413.Pos, (p414.Back and 1 or 0) + (p414.Bottom and 2 or 0) + (p414.Front and 4 or 0) + (p414.Left and 8 or 0) + (p414.Right and 16 or 0) + (p414.Top and 32 or 0) + 0 + 0);
        p413.Pos = p413.Pos + 1;
    end,

    des = function(p415) -- Line: 1708, Name: des
        p415.Pos = p415.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p415.Buf, p415.Pos);
        local v416 = buffer_readu8_ret % 2 >= 1;
        local v417 = buffer_readu8_ret % 4 >= 2;
        local v418 = buffer_readu8_ret % 8 >= 4;
        local v419 = buffer_readu8_ret % 16 >= 8;
        local v420 = buffer_readu8_ret % 32 >= 16;
        local v421 = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;

        if v416 then
            v416 = Enum.NormalId.Back;
        end;

        if v417 then
            v417 = Enum.NormalId.Bottom;
        end;

        if v418 then
            v418 = Enum.NormalId.Front;
        end;

        if v419 then
            v419 = Enum.NormalId.Left;
        end;

        if v420 then
            v420 = Enum.NormalId.Right;
        end;

        if v421 then
            v421 = Enum.NormalId.Top;
        end;

        return Faces.new(v416, v417, v418, v419, v420, v421);
    end
};

function v115.Faces() -- Line: 1720
    -- upvalues: u422 (copy)
    return u422;
end;

local u426 = {
    ser = function(p423, p424) -- Line: 1727, Name: ser
        -- upvalues: EnumItem (ref), tryrealloc (copy)
        EnumItem(Enum.KeyInterpolationMode).ser(p423, p424.Interpolation);
        tryrealloc(p423, 8);
        buffer.writef32(p423.Buf, p423.Pos, p424.Value);
        p423.Pos = p423.Pos + 4;
        buffer.writef32(p423.Buf, p423.Pos, p424.Time);
        p423.Pos = p423.Pos + 4;
    end,

    des = function(p425) -- Line: 1734, Name: des
        -- upvalues: EnumItem (ref)
        local FloatCurveKey_new = FloatCurveKey.new;
        p425.Pos = p425.Pos - 4;
        local buffer_readf32_ret = buffer.readf32(p425.Buf, p425.Pos);
        p425.Pos = p425.Pos - 4;

        return FloatCurveKey_new(buffer_readf32_ret, buffer.readf32(p425.Buf, p425.Pos), (EnumItem(Enum.KeyInterpolationMode).des(p425)));
    end
};

function v115.FloatCurveKey() -- Line: 1738
    -- upvalues: u426 (copy)
    return u426;
end;

local u435 = {
    ser = function(p427, p428) -- Line: 1745, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref), EnumItem (ref)
        local v429 = string.match(p428.Family, "rbxasset://fonts/families/(.+).json") or error((`Invalid font family {p428.Family}`));
        tryrealloc(p427, #v429 + 1);
        local v430 = #v429;
        buffer.writestring(p427.Buf, p427.Pos, v429);
        p427.Pos = p427.Pos + v430;
        pushvlqrealloc(p427, v430);
        buffer.writeu8(p427.Buf, p427.Pos, (p428.Bold and 1 or 0) + 0 + 0 + 0 + 0 + 0 + 0 + 0);
        p427.Pos = p427.Pos + 1;
        EnumItem(Enum.FontWeight).ser(p427, p428.Weight);
        EnumItem(Enum.FontStyle).ser(p427, p428.Style);
    end,

    des = function(p431) -- Line: 1754, Name: des
        -- upvalues: EnumItem (ref), popvlq (ref)
        local v432 = EnumItem(Enum.FontStyle).des(p431);
        local v433 = EnumItem(Enum.FontWeight).des(p431);
        p431.Pos = p431.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p431.Buf, p431.Pos);
        local _ = buffer_readu8_ret % 4 >= 2;
        local _ = buffer_readu8_ret % 8 >= 4;
        local _ = buffer_readu8_ret % 16 >= 8;
        local _ = buffer_readu8_ret % 32 >= 16;
        local _ = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        local v434 = popvlq(p431);
        p431.Pos = p431.Pos - v434;
        local buffer_readstring_ret = buffer.readstring(p431.Buf, p431.Pos, v434);
        local Font_new_ret = Font.new(`rbxasset://fonts/families/{buffer_readstring_ret}.json`, v433, v432);
        Font_new_ret.Bold = buffer_readu8_ret % 2 >= 1;

        return Font_new_ret;
    end
};

function v115.Font() -- Line: 1764
    -- upvalues: u435 (copy)
    return u435;
end;

local u436 = {};

function v115.NumberRange(p437: table) -- Line: 1771
    -- upvalues: u436 (copy)
    if u436[p437] then
        return u436[p437];
    end;

    local ser = p437.ser;
    local des = p437.des;
    local v441 = {
        ser = function(p438, p439) -- Line: 1779, Name: ser
            -- upvalues: ser (copy)
            ser(p438, p439.Max);
            ser(p438, p439.Min);
        end,

        des = function(p440) -- Line: 1784, Name: des
            -- upvalues: des (copy)
            return NumberRange.new(des(p440), des(p440));
        end
    };
    u436[p437] = v441;

    return v441;
end;

local u442 = {};

function v115.NumberSequenceKeypoint(p443: table) -- Line: 1796
    -- upvalues: u442 (copy), tryrealloc (copy)
    if u442[p443] then
        return u442[p443];
    end;

    local ser = p443.ser;
    local des = p443.des;
    local v449 = {
        ser = function(p444, p445) -- Line: 1804, Name: ser
            -- upvalues: ser (copy), tryrealloc (ref)
            ser(p444, p445.Value);
            ser(p444, p445.Envelope);
            tryrealloc(p444, 4);
            buffer.writef32(p444.Buf, p444.Pos, p445.Time);
            p444.Pos = p444.Pos + 4;
        end,

        des = function(p446) -- Line: 1811, Name: des
            -- upvalues: des (copy)
            p446.Pos = p446.Pos - 4;
            local buffer_readf32_ret = buffer.readf32(p446.Buf, p446.Pos);
            local v447 = des(p446);
            local v448 = des(p446);

            return NumberSequenceKeypoint.new(buffer_readf32_ret, v448, v447);
        end
    };
    u442[p443] = v449;

    return v449;
end;

local NumberSequenceKeypoint2 = v115.NumberSequenceKeypoint;
local u450 = {};

function v115.NumberSequence(p451: table) -- Line: 1826
    -- upvalues: u450 (copy), NumberSequenceKeypoint2 (ref), pushvlqrealloc (ref), popvlq (ref)
    if u450[p451] then
        return u450[p451];
    end;

    local ser = NumberSequenceKeypoint2(p451).ser;
    local des = NumberSequenceKeypoint2(p451).des;
    local v457 = {
        ser = function(p452, p453) -- Line: 1834, Name: ser
            -- upvalues: ser (copy), pushvlqrealloc (ref)
            local v454 = ser;

            for _, v in p453.Keypoints do
                v454(p452, v);
            end;

            pushvlqrealloc(p452, #p453.Keypoints);
        end,

        des = function(p455) -- Line: 1842, Name: des
            -- upvalues: popvlq (ref), des (copy)
            local v456 = popvlq(p455);
            local table_create_ret2 = table.create(v456);

            for i = v456, 1, -1 do
                table_create_ret2[i] = des(p455);
                local _ = i;
            end;

            return NumberSequence.new(table_create_ret2);
        end
    };
    u450[p451] = v457;

    return v457;
end;

local u463 = {
    ser = function(p458, p459) -- Line: 1860, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref), EnumItem (ref)
        tryrealloc(p458, #p459.CollisionGroup + 3);
        buffer.writeu8(p458.Buf, p458.Pos, (p459.BruteForceAllSlow and 1 or 0) + (p459.RespectCanCollide and 2 or 0) + 0 + 0 + 0 + 0 + 0 + 0);
        p458.Pos = p458.Pos + 1;
        buffer.writeu16(p458.Buf, p458.Pos, p459.MaxParts);
        p458.Pos = p458.Pos + 2;
        local CollisionGroup = p459.CollisionGroup;
        local v460 = #CollisionGroup;
        buffer.writestring(p458.Buf, p458.Pos, CollisionGroup);
        p458.Pos = p458.Pos + v460;
        pushvlqrealloc(p458, v460);
        EnumItem(Enum.RaycastFilterType).ser(p458, p459.FilterType);
    end,

    des = function(p461) -- Line: 1868, Name: des
        -- upvalues: EnumItem (ref), popvlq (ref)
        local OverlapParams_new_ret = OverlapParams.new();
        OverlapParams_new_ret.FilterType = EnumItem(Enum.RaycastFilterType).des(p461);
        local v462 = popvlq(p461);
        p461.Pos = p461.Pos - v462;
        OverlapParams_new_ret.CollisionGroup = buffer.readstring(p461.Buf, p461.Pos, v462);
        p461.Pos = p461.Pos - 2;
        OverlapParams_new_ret.MaxParts = buffer.readu16(p461.Buf, p461.Pos);
        p461.Pos = p461.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p461.Buf, p461.Pos);
        local _ = buffer_readu8_ret % 8 >= 4;
        local _ = buffer_readu8_ret % 16 >= 8;
        local _ = buffer_readu8_ret % 32 >= 16;
        local _ = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        OverlapParams_new_ret.BruteForceAllSlow = buffer_readu8_ret % 2 >= 1;
        OverlapParams_new_ret.RespectCanCollide = buffer_readu8_ret % 4 >= 2;

        return OverlapParams_new_ret;
    end
};

function v115.OverlapParams() -- Line: 1877
    -- upvalues: u463 (copy)
    return u463;
end;

local u469 = {
    ser = function(p464, p465) -- Line: 1884, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref), EnumItem (ref)
        tryrealloc(p464, #p465.CollisionGroup + 1);
        buffer.writeu8(p464.Buf, p464.Pos, (p465.BruteForceAllSlow and 1 or 0) + (p465.RespectCanCollide and 2 or 0) + (p465.IgnoreWater and 4 or 0) + 0 + 0 + 0 + 0 + 0);
        p464.Pos = p464.Pos + 1;
        local CollisionGroup = p465.CollisionGroup;
        local v466 = #CollisionGroup;
        buffer.writestring(p464.Buf, p464.Pos, CollisionGroup);
        p464.Pos = p464.Pos + v466;
        pushvlqrealloc(p464, v466);
        EnumItem(Enum.RaycastFilterType).ser(p464, p465.FilterType);
    end,

    des = function(p467) -- Line: 1891, Name: des
        -- upvalues: EnumItem (ref), popvlq (ref)
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = EnumItem(Enum.RaycastFilterType).des(p467);
        local v468 = popvlq(p467);
        p467.Pos = p467.Pos - v468;
        RaycastParams_new_ret.CollisionGroup = buffer.readstring(p467.Buf, p467.Pos, v468);
        p467.Pos = p467.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p467.Buf, p467.Pos);
        local _ = buffer_readu8_ret % 16 >= 8;
        local _ = buffer_readu8_ret % 32 >= 16;
        local _ = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        RaycastParams_new_ret.BruteForceAllSlow = buffer_readu8_ret % 2 >= 1;
        RaycastParams_new_ret.RespectCanCollide = buffer_readu8_ret % 4 >= 2;
        RaycastParams_new_ret.IgnoreWater = buffer_readu8_ret % 8 >= 4;

        return RaycastParams_new_ret;
    end
};

function v115.RaycastParams() -- Line: 1899
    -- upvalues: u469 (copy)
    return u469;
end;

local u470 = {};

function v115.Vector3(p471: table) -- Line: 1906
    -- upvalues: u470 (copy)
    if u470[p471] then
        return u470[p471];
    end;

    local ser = p471.ser;
    local des = p471.des;
    local v477 = {
        ser = function(p472, p473) -- Line: 1914, Name: ser
            -- upvalues: ser (copy)
            ser(p472, p473.Z);
            ser(p472, p473.Y);
            ser(p472, p473.X);
        end,

        des = function(p474) -- Line: 1920, Name: des
            -- upvalues: des (copy)
            local v475 = des(p474);
            local v476 = des(p474);

            return Vector3.new(v475, v476, des(p474));
        end
    };
    u470[p471] = v477;

    return v477;
end;

local u478 = {};

function v115.PathWaypoint(p479: table) -- Line: 1932
    -- upvalues: u478 (copy), tryrealloc (copy), pushvlqrealloc (ref), EnumItem (ref), popstr (copy)
    if u478[p479] then
        return u478[p479];
    end;

    local ser = p479.ser;
    local des = p479.des;
    local v486 = {
        ser = function(p480, p481) -- Line: 1940, Name: ser
            -- upvalues: tryrealloc (ref), pushvlqrealloc (ref), EnumItem (ref), ser (copy)
            tryrealloc(p480, #p481.Label);
            local Label = p481.Label;
            local v482 = #Label;
            buffer.writestring(p480.Buf, p480.Pos, Label);
            p480.Pos = p480.Pos + v482;
            pushvlqrealloc(p480, v482);
            EnumItem(Enum.PathWaypointAction).ser(p480, p481.Action);
            ser(p480, p481.Position.Z);
            ser(p480, p481.Position.Y);
            ser(p480, p481.Position.X);
        end,

        des = function(p483) -- Line: 1949, Name: des
            -- upvalues: des (copy), EnumItem (ref), popstr (ref)
            local PathWaypoint_new = PathWaypoint.new;
            local v484 = des(p483);
            local v485 = des(p483);

            return PathWaypoint_new(Vector3.new(v484, v485, des(p483)), EnumItem(Enum.PathWaypointAction).des(p483), popstr(p483));
        end
    };
    u478[p479] = v486;

    return v486;
end;

local u490 = {
    ser = function(p487, p488) -- Line: 1964, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p487, 20);
        buffer.writef32(p487.Buf, p487.Pos, p488.ElasticityWeight);
        p487.Pos = p487.Pos + 4;
        buffer.writef32(p487.Buf, p487.Pos, p488.FrictionWeight);
        p487.Pos = p487.Pos + 4;
        buffer.writef32(p487.Buf, p487.Pos, p488.Elasticity);
        p487.Pos = p487.Pos + 4;
        buffer.writef32(p487.Buf, p487.Pos, p488.Friction);
        p487.Pos = p487.Pos + 4;
        buffer.writef32(p487.Buf, p487.Pos, p488.Density);
        p487.Pos = p487.Pos + 4;
    end,

    des = function(p489) -- Line: 1973, Name: des
        local PhysicalProperties_new = PhysicalProperties.new;
        p489.Pos = p489.Pos - 4;
        local buffer_readf32_ret = buffer.readf32(p489.Buf, p489.Pos);
        p489.Pos = p489.Pos - 4;
        local buffer_readf32_ret2 = buffer.readf32(p489.Buf, p489.Pos);
        p489.Pos = p489.Pos - 4;
        local buffer_readf32_ret3 = buffer.readf32(p489.Buf, p489.Pos);
        p489.Pos = p489.Pos - 4;
        local buffer_readf32_ret4 = buffer.readf32(p489.Buf, p489.Pos);
        p489.Pos = p489.Pos - 4;

        return PhysicalProperties_new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3, buffer_readf32_ret4, (buffer.readf32(p489.Buf, p489.Pos)));
    end
};

function v115.PhysicalProperties() -- Line: 1977
    -- upvalues: u490 (copy)
    return u490;
end;

local u491 = {};

function v115.Ray(p492: table) -- Line: 1984
    -- upvalues: u491 (copy)
    if u491[p492] then
        return u491[p492];
    end;

    local ser = p492.ser;
    local des = p492.des;
    local v500 = {
        ser = function(p493, p494) -- Line: 1992, Name: ser
            -- upvalues: ser (copy)
            ser(p493, p494.Direction.Z);
            ser(p493, p494.Direction.Y);
            ser(p493, p494.Direction.X);
            ser(p493, p494.Origin.Z);
            ser(p493, p494.Origin.Y);
            ser(p493, p494.Origin.X);
        end,

        des = function(p495) -- Line: 2001, Name: des
            -- upvalues: des (copy)
            local Ray_new = Ray.new;
            local v496 = des(p495);
            local v497 = des(p495);
            local Vector3_new_ret = Vector3.new(v496, v497, des(p495));
            local v498 = des(p495);
            local v499 = des(p495);

            return Ray_new(Vector3_new_ret, (Vector3.new(v498, v499, des(p495))));
        end
    };
    u491[p492] = v500;

    return v500;
end;

local u501 = {};

function v115.RaycastResult(p502: table) -- Line: 2019
    -- upvalues: u501 (copy), tryrealloc (copy), EnumItem (ref)
    if u501[p502] then
        return u501[p502];
    end;

    local ser = p502.ser;
    local des = p502.des;
    local v511 = {
        ser = function(p503: any, p504) -- Line: 2027, Name: ser
            -- upvalues: tryrealloc (ref), ser (copy), EnumItem (ref)
            tryrealloc(p503, 4);
            buffer.writef32(p503.Buf, p503.Pos, p504.Distance);
            p503.Pos = p503.Pos + 4;
            ser(p503, p504.Position.Z);
            ser(p503, p504.Position.Y);
            ser(p503, p504.Position.X);
            ser(p503, p504.Normal.Z);
            ser(p503, p504.Normal.Y);
            ser(p503, p504.Normal.X);
            EnumItem(Enum.Material).ser(p503, p504.Material);
        end,

        des = function(p505) -- Line: 2039, Name: des
            -- upvalues: EnumItem (ref), des (copy)
            local v506 = {
                Instance = nil,
                Material = EnumItem(Enum.Material).des(p505)
            };
            local v507 = des(p505);
            local v508 = des(p505);
            v506.Normal = Vector3.new(v507, v508, des(p505));
            local v509 = des(p505);
            local v510 = des(p505);
            v506.Position = Vector3.new(v509, v510, des(p505));
            p505.Pos = p505.Pos - 4;
            v506.Distance = buffer.readf32(p505.Buf, p505.Pos);

            return v506;
        end
    };
    u501[p502] = v511;

    return v511;
end;

local u512 = {};

function v115.Vector2(p513: table) -- Line: 2057
    -- upvalues: u512 (copy)
    if u512[p513] then
        return u512[p513];
    end;

    local ser = p513.ser;
    local des = p513.des;
    local v517 = {
        ser = function(p514, p515) -- Line: 2065, Name: ser
            -- upvalues: ser (copy)
            ser(p514, p515.Y);
            ser(p514, p515.X);
        end,

        des = function(p516) -- Line: 2070, Name: des
            -- upvalues: des (copy)
            return Vector2.new(des(p516), des(p516));
        end
    };
    u512[p513] = v517;

    return v517;
end;

local u518 = {};

function v115.Rect(p519: table) -- Line: 2082
    -- upvalues: u518 (copy)
    if u518[p519] then
        return u518[p519];
    end;

    local ser = p519.ser;
    local des = p519.des;
    local v523 = {
        ser = function(p520, p521) -- Line: 2090, Name: ser
            -- upvalues: ser (copy)
            ser(p520, p521.Max.Y);
            ser(p520, p521.Max.X);
            ser(p520, p521.Min.Y);
            ser(p520, p521.Min.X);
        end,

        des = function(p522) -- Line: 2097, Name: des
            -- upvalues: des (copy)
            return Rect.new(des(p522), des(p522), des(p522), des(p522));
        end
    };
    u518[p519] = v523;

    return v523;
end;

local u524 = {};

function v115.Region3(p525: table) -- Line: 2108
    -- upvalues: u524 (copy)
    if u524[p525] then
        return u524[p525];
    end;

    local ser = p525.ser;
    local des = p525.des;
    local v534 = {
        ser = function(p526, p527) -- Line: 2116, Name: ser
            -- upvalues: ser (copy)
            local Size = p527.Size;
            ser(p526, Size.Z);
            ser(p526, Size.Y);
            ser(p526, Size.X);
            local Position = p527.CFrame.Position;
            ser(p526, Position.Z);
            ser(p526, Position.Y);
            ser(p526, Position.X);
        end,

        des = function(p528) -- Line: 2127, Name: des
            -- upvalues: des (copy)
            local v529 = des(p528);
            local v530 = des(p528);
            local Vector3_new_ret = Vector3.new(v529, v530, des(p528));
            local v531 = des(p528);
            local v532 = des(p528);
            local v533 = Vector3.new(v531, v532, des(p528)) * 0.5;

            return Region3.new(Vector3_new_ret - v533, Vector3_new_ret + v533);
        end
    };
    u524[p525] = v534;

    return v534;
end;

local u540 = {
    ser = function(p535, p536) -- Line: 2140, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p535, 12);
        local Max = p536.Max;
        buffer.writei16(p535.Buf, p535.Pos, Max.Z);
        p535.Pos = p535.Pos + 2;
        buffer.writei16(p535.Buf, p535.Pos, Max.Y);
        p535.Pos = p535.Pos + 2;
        buffer.writei16(p535.Buf, p535.Pos, Max.X);
        p535.Pos = p535.Pos + 2;
        local Min = p536.Min;
        buffer.writei16(p535.Buf, p535.Pos, Min.Z);
        p535.Pos = p535.Pos + 2;
        buffer.writei16(p535.Buf, p535.Pos, Min.Y);
        p535.Pos = p535.Pos + 2;
        buffer.writei16(p535.Buf, p535.Pos, Min.X);
        p535.Pos = p535.Pos + 2;
    end,

    des = function(p537) -- Line: 2152, Name: des
        local Vector3int16_new = Vector3int16.new;
        p537.Pos = p537.Pos - 2;
        local buffer_readi16_ret = buffer.readi16(p537.Buf, p537.Pos);
        p537.Pos = p537.Pos - 2;
        local buffer_readi16_ret2 = buffer.readi16(p537.Buf, p537.Pos);
        p537.Pos = p537.Pos - 2;
        local v538 = Vector3int16_new(buffer_readi16_ret, buffer_readi16_ret2, (buffer.readi16(p537.Buf, p537.Pos)));
        local Vector3int16_new2 = Vector3int16.new;
        p537.Pos = p537.Pos - 2;
        local buffer_readi16_ret3 = buffer.readi16(p537.Buf, p537.Pos);
        p537.Pos = p537.Pos - 2;
        local buffer_readi16_ret4 = buffer.readi16(p537.Buf, p537.Pos);
        p537.Pos = p537.Pos - 2;
        local v539 = Vector3int16_new2(buffer_readi16_ret3, buffer_readi16_ret4, (buffer.readi16(p537.Buf, p537.Pos)));

        return Region3int16.new(v538, v539);
    end
};

function v115.Region3int16() -- Line: 2158
    -- upvalues: u540 (copy)
    return u540;
end;

local u541 = {};

function v115.RotationCurveKey(p542: table) -- Line: 2165
    -- upvalues: u541 (copy), CFrame2 (ref), EnumItem (ref), tryrealloc (copy)
    if u541[p542] then
        return u541[p542];
    end;

    local ser = CFrame2(p542).ser;
    local des = CFrame2(p542).des;
    local v546 = {
        ser = function(p543, p544) -- Line: 2173, Name: ser
            -- upvalues: EnumItem (ref), ser (copy), tryrealloc (ref)
            EnumItem(Enum.KeyInterpolationMode).ser(p543, p544.Interpolation);
            ser(p543, p544.Value);
            tryrealloc(p543, 4);
            buffer.writef32(p543.Buf, p543.Pos, p544.Time);
            p543.Pos = p543.Pos + 4;
        end,

        des = function(p545) -- Line: 2180, Name: des
            -- upvalues: des (copy), EnumItem (ref)
            local RotationCurveKey_new = RotationCurveKey.new;
            p545.Pos = p545.Pos - 4;

            return RotationCurveKey_new(buffer.readf32(p545.Buf, p545.Pos), des(p545), (EnumItem(Enum.KeyInterpolationMode).des(p545)));
        end
    };
    u541[p542] = v546;

    return v546;
end;

local u553 = {
    ser = function(p547, p548) -- Line: 2195, Name: ser
        -- upvalues: tryrealloc (copy), pushvlqrealloc (ref), EnumItem (ref)
        tryrealloc(p547, 9);
        buffer.writef32(p547.Buf, p547.Pos, p548.DelayTime);
        p547.Pos = p547.Pos + 4;
        buffer.writef32(p547.Buf, p547.Pos, p548.Time);
        p547.Pos = p547.Pos + 4;
        buffer.writeu8(p547.Buf, p547.Pos, (p548.Reverses and 1 or 0) + 0 + 0 + 0 + 0 + 0 + 0 + 0);
        p547.Pos = p547.Pos + 1;
        pushvlqrealloc(p547, p548.RepeatCount);
        EnumItem(Enum.EasingDirection).ser(p547, p548.EasingDirection);
        EnumItem(Enum.EasingStyle).ser(p547, p548.EasingStyle);
    end,

    des = function(p549) -- Line: 2205, Name: des
        -- upvalues: EnumItem (ref), popvlq (ref)
        local v550 = EnumItem(Enum.EasingStyle).des(p549);
        local v551 = EnumItem(Enum.EasingDirection).des(p549);
        local v552 = popvlq(p549);
        p549.Pos = p549.Pos - 1;
        local buffer_readu8_ret = buffer.readu8(p549.Buf, p549.Pos);
        local _ = buffer_readu8_ret % 4 >= 2;
        local _ = buffer_readu8_ret % 8 >= 4;
        local _ = buffer_readu8_ret % 16 >= 8;
        local _ = buffer_readu8_ret % 32 >= 16;
        local _ = buffer_readu8_ret % 64 >= 32;
        local _ = buffer_readu8_ret % 128 >= 64;
        local _ = buffer_readu8_ret % 256 >= 128;
        p549.Pos = p549.Pos - 4;
        local buffer_readf32_ret = buffer.readf32(p549.Buf, p549.Pos);
        p549.Pos = p549.Pos - 4;
        local buffer_readf32_ret2 = buffer.readf32(p549.Buf, p549.Pos);

        return TweenInfo.new(buffer_readf32_ret, v550, v551, v552, buffer_readu8_ret % 2 >= 1, buffer_readf32_ret2);
    end
};

function v115.TweenInfo() -- Line: 2215
    -- upvalues: u553 (copy)
    return u553;
end;

local u554 = {};

function v115.UDim(p555: table) -- Line: 2222
    -- upvalues: u554 (copy)
    if u554[p555] then
        return u554[p555];
    end;

    local ser = p555.ser;
    local des = p555.des;
    local v559 = {
        ser = function(p556, p557) -- Line: 2230, Name: ser
            -- upvalues: ser (copy)
            ser(p556, p557.Offset);
            ser(p556, p557.Scale);
        end,

        des = function(p558) -- Line: 2235, Name: des
            -- upvalues: des (copy)
            return UDim.new(des(p558), des(p558));
        end
    };
    u554[p555] = v559;

    return v559;
end;

local u560 = {};

function v115.UDim2(p561: table) -- Line: 2247
    -- upvalues: u560 (copy)
    if u560[p561] then
        return u560[p561];
    end;

    local ser = p561.ser;
    local des = p561.des;
    local v565 = {
        ser = function(p562, p563) -- Line: 2255, Name: ser
            -- upvalues: ser (copy)
            ser(p562, p563.Y.Offset);
            ser(p562, p563.Y.Scale);
            ser(p562, p563.X.Offset);
            ser(p562, p563.X.Scale);
        end,

        des = function(p564) -- Line: 2262, Name: des
            -- upvalues: des (copy)
            return UDim2.new(des(p564), des(p564), des(p564), des(p564));
        end
    };
    u560[p561] = v565;

    return v565;
end;

local u569 = {
    ser = function(p566, p567) -- Line: 2274, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p566, 4);
        buffer.writei16(p566.Buf, p566.Pos, p567.Y);
        p566.Pos = p566.Pos + 2;
        buffer.writei16(p566.Buf, p566.Pos, p567.X);
        p566.Pos = p566.Pos + 2;
    end,

    des = function(p568) -- Line: 2280, Name: des
        local Vector2int16_new = Vector2int16.new;
        p568.Pos = p568.Pos - 2;
        local buffer_readi16_ret = buffer.readi16(p568.Buf, p568.Pos);
        p568.Pos = p568.Pos - 2;

        return Vector2int16_new(buffer_readi16_ret, (buffer.readi16(p568.Buf, p568.Pos)));
    end
};

function v115.Vector2int16() -- Line: 2284
    -- upvalues: u569 (copy)
    return u569;
end;

local u573 = {
    ser = function(p570, p571) -- Line: 2291, Name: ser
        -- upvalues: tryrealloc (copy)
        tryrealloc(p570, 6);
        buffer.writei16(p570.Buf, p570.Pos, p571.Z);
        p570.Pos = p570.Pos + 2;
        buffer.writei16(p570.Buf, p570.Pos, p571.Y);
        p570.Pos = p570.Pos + 2;
        buffer.writei16(p570.Buf, p570.Pos, p571.X);
        p570.Pos = p570.Pos + 2;
    end,

    des = function(p572) -- Line: 2298, Name: des
        local Vector3int16_new = Vector3int16.new;
        p572.Pos = p572.Pos - 2;
        local buffer_readi16_ret = buffer.readi16(p572.Buf, p572.Pos);
        p572.Pos = p572.Pos - 2;
        local buffer_readi16_ret2 = buffer.readi16(p572.Buf, p572.Pos);
        p572.Pos = p572.Pos - 2;

        return Vector3int16_new(buffer_readi16_ret, buffer_readi16_ret2, (buffer.readi16(p572.Buf, p572.Pos)));
    end
};

function v115.Vector3int16() -- Line: 2302
    -- upvalues: u573 (copy)
    return u573;
end;

return v115;