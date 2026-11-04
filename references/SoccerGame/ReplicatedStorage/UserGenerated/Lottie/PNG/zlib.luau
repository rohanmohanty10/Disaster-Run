  

local u1 = { 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258 };
local u2 = {};
local u3 = {};
local u4 = { 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0 };
local u5 = {};
local u6 = { 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577 };

local function createHuffmanTable(p7: table) -- Line: 56
    local table_create_ret = table.create(15, 0);
    table_create_ret[0] = 0;

    for _, v in p7 do
        if v > 0 then
            table_create_ret[v] = (table_create_ret[v] or 0) + 1;
        end;
    end;

    local table_create_ret2 = table.create(15);
    local v8 = 1;

    for i = 1, 15 do
        v8 = bit32.lshift(v8 + table_create_ret[i - 1], 1);
        table_create_ret2[i] = v8;
        local _ = i;
    end;

    local v9 = {};
    local v10 = {};
    local v11 = {};

    for i, v in p7 do
        if v > 0 then
            v9[table_create_ret2[v]] = i - 1;
            v10[i - 1] = bit32.extract(table_create_ret2[v], 0, v);
            v11[i - 1] = v;
            table_create_ret2[v] = table_create_ret2[v] + 1;
        end;
    end;

    return v9, v10, v11;
end;

local v12 = { 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8 };
local u13 = { 16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15 };
local u14 = { 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13 };

for i = 3, 258 do
    local v15 = i;
    local v16 = nil;

    for i2 = #u1, 1, -1 do
        if u1[i2] <= v15 then
            v16 = i2;
            break;
        end;

        local _ = i2;
    end;

    u2[v15] = 256 + v16;
    u3[v15] = v15 - u1[v16];
    u5[v15] = u4[v16 - 8] or 0;
end;

local u17 = {};

for i = 1, 1024 do
    local v18 = i;
    local v19 = nil;

    for i2 = #u6, 1, -1 do
        if u6[i2] <= v18 then
            v19 = i2;
            break;
        end;

        local _ = i2;
    end;

    u17[v18] = v19;
end;

local u20, u21, u22 = createHuffmanTable(v12);
local u23, u24, u25 = createHuffmanTable(table.create(32, 5));

local function getStoreSize(p26: number) -- Line: 118
    return math.ceil(p26 / 32768) * 5 + p26;
end;

local function getDistIdx(p27: number) -- Line: 122
    -- upvalues: u17 (copy)
    return p27 >= 1025 and (p27 < 1537 and 21 or (p27 < 2049 and 22 or (p27 < 3073 and 23 or (p27 < 4097 and 24 or (p27 < 6145 and 25 or (p27 < 8193 and 26 or (p27 < 12289 and 27 or (p27 < 16385 and 28 or (p27 < 24577 and 29 or 30))))))))) or u17[p27];
end;

local function adler32(p28: buffer, p29: number, p30: number) -- Line: 139
    local v31 = 1;
    local v32 = 0;
    local v33 = 0;

    for i = p29, p29 + p30 - 1 do
        v31 = v31 + buffer.readu8(p28, i);
        v32 = v32 + v31;
        v33 = v33 + 1;
        local v34;

        if v33 == 8400000 then
            v31 = v31 % 65521;
            v32 = v32 % 65521;
            v34 = i;
            v33 = 0;
        else
            v34 = i;
        end;
    end;

    local bit32_lshift_ret = bit32.lshift(v32 % 65521, 16);

    return bit32.bor(bit32_lshift_ret, v31 % 65521);
end;

return {
    inflate = function(u35: buffer, p36: buffer) -- Line: 156, Name: inflate
        -- upvalues: u20 (copy), u23 (copy), u13 (copy), createHuffmanTable (copy), u1 (copy), u4 (copy), u6 (copy), u14 (copy), adler32 (copy)
        local u37, u38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50;
        local v51 = 0;

        while true do
            if v51 == 0 then
                v51 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, 0);
                local buffer_readu8_ret2 = buffer.readu8(u35, 1);
                local v52 = bit32.extract(buffer_readu8_ret, 0, 4) == 8;
                assert(v52, "invalid zlib comp method");
                local v53 = bit32.extract(buffer_readu8_ret, 4, 4) <= 7;
                assert(v53, "invalid zlib window size");
                local v54 = bit32.extract(buffer_readu8_ret2, 5, 1) == 0;
                assert(v54, "preset dictionary is not allowed");
                local bit32_lshift_ret = bit32.lshift(buffer_readu8_ret, 8);
                local v55 = bit32.bor(bit32_lshift_ret, buffer_readu8_ret2) % 31 == 0;
                assert(v55, "zlib header sum mismatch");
                u37 = 2;
                u38 = 0;

                local function readBit() -- Line: 167
                    -- upvalues: u35 (copy), u37 (ref), u38 (ref)
                    local buffer_readu8_ret3 = buffer.readu8(u35, u37);
                    local bit32_extract_ret = bit32.extract(buffer_readu8_ret3, u38);
                    u38 = u38 + 1;

                    if u38 == 8 then
                        u38 = 0;
                        u37 = u37 + 1;
                    end;

                    return bit32_extract_ret;
                end;

                local function readBits(p56: number) -- Line: 177
                    -- upvalues: u35 (copy), u37 (ref), u38 (ref)
                    local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, p56);
                    u38 = u38 + p56;
                    u37 = u37 + bit32.rshift(u38, 3);
                    u38 = bit32.band(u38, 7);

                    return buffer_readbits_ret;
                end;

                local function readHuffmanTable(p57: table) -- Line: 185
                    -- upvalues: u35 (copy), u37 (ref), u38 (ref)
                    local buffer_readu8_ret3 = buffer.readu8(u35, u37);
                    local bit32_extract_ret = bit32.extract(buffer_readu8_ret3, u38);
                    u38 = u38 + 1;

                    if u38 == 8 then
                        u38 = 0;
                        u37 = u37 + 1;
                    end;

                    local v58 = 2 + bit32_extract_ret;

                    while not p57[v58] do
                        local buffer_readu8_ret4 = buffer.readu8(u35, u37);
                        local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret4, u38);
                        u38 = u38 + 1;

                        if u38 == 8 then
                            u38 = 0;
                            u37 = u37 + 1;
                        end;

                        v58 = 2 * v58 + bit32_extract_ret2;
                    end;

                    return p57[v58];
                end;

                v39 = 0;
                v51 = 1;
                continue;
            elseif v51 == 1 then
                v51 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, u37);
                v41 = bit32.extract(buffer_readu8_ret, u38);
                u38 = u38 + 1;

                if u38 == 8 then
                    u38 = 0;
                    u37 = u37 + 1;
                end;

                v40 = buffer.readbits(u35, u37 * 8 + u38, 2);
                u38 = u38 + 2;
                u37 = u37 + bit32.rshift(u38, 3);
                u38 = bit32.band(u38, 7);
                assert(v40 ~= 3, "reserved btype");

                if v40 ~= 0 then
                    v51 = 3;
                    continue;
                end;

                if u38 > 0 then
                    u37 = u37 + 1;
                    u38 = 0;
                end;

                local buffer_readu16_ret = buffer.readu16(u35, u37);
                local buffer_readu16_ret2 = buffer.readu16(u35, u37 + 2);
                local v59 = bit32.bxor(buffer_readu16_ret, buffer_readu16_ret2) == 65535;
                assert(v59, "len ~= nlen");
                u37 = u37 + 4;
                buffer.copy(p36, v39, u35, u37, buffer_readu16_ret);
                v39 = v39 + buffer_readu16_ret;
                u37 = u37 + buffer_readu16_ret;
                v51 = 2;
                continue;
            elseif v51 == 2 then
                v51 = -1;

                if v41 == 1 then
                    if u38 > 0 then
                        u38 = 0;
                        u37 = u37 + 1;
                    end;

                    local v60 = adler32(p36, 0, buffer.len(p36));
                    local buffer_readu32_ret = buffer.readu32(u35, u37);
                    local v61 = v60 == bit32.byteswap(buffer_readu32_ret);
                    assert(v61, "adler-32 checksum mismatch");

                    return v39;
                end;

                v51 = 1;
                continue;
            elseif v51 == 3 then
                v51 = -1;
                v42 = u20;
                v43 = u23;

                if v40 ~= 2 then
                    v51 = 4;
                    continue;
                end;

                v51 = 5;
                continue;
            elseif v51 == 4 then
                v51 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, u37);
                local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u38);
                u38 = u38 + 1;

                if u38 == 8 then
                    u38 = 0;
                    u37 = u37 + 1;
                end;

                v44 = 2 + bit32_extract_ret;
                v51 = 8;
                continue;
            elseif v51 == 5 then
                v51 = -1;
                local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 5);
                u38 = u38 + 5;
                u37 = u37 + bit32.rshift(u38, 3);
                u38 = bit32.band(u38, 7);
                v45 = buffer_readbits_ret + 257;
                local buffer_readbits_ret2 = buffer.readbits(u35, u37 * 8 + u38, 5);
                u38 = u38 + 5;
                u37 = u37 + bit32.rshift(u38, 3);
                u38 = bit32.band(u38, 7);
                v47 = buffer_readbits_ret2 + 1;
                local buffer_readbits_ret3 = buffer.readbits(u35, u37 * 8 + u38, 4);
                u38 = u38 + 4;
                u37 = u37 + bit32.rshift(u38, 3);
                u38 = bit32.band(u38, 7);
                local table_create_ret = table.create(19, 0);

                for i = 1, buffer_readbits_ret3 + 4 do
                    local v62 = u13[i] + 1;
                    local buffer_readbits_ret4 = buffer.readbits(u35, u37 * 8 + u38, 3);
                    u38 = u38 + 3;
                    u37 = u37 + bit32.rshift(u38, 3);
                    u38 = bit32.band(u38, 7);
                    table_create_ret[v62] = buffer_readbits_ret4;
                    local _ = i;
                end;

                v46 = createHuffmanTable(table_create_ret);
                v49 = table.create(v45);
                v48 = nil;
                v51 = 6;
                continue;
            elseif v51 == 6 then
                v51 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, u37);
                local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u38);
                u38 = u38 + 1;

                if u38 == 8 then
                    u38 = 0;
                    u37 = u37 + 1;
                end;

                local v63 = 2 + bit32_extract_ret;

                while not v46[v63] do
                    local buffer_readu8_ret2 = buffer.readu8(u35, u37);
                    local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u38);
                    u38 = u38 + 1;

                    if u38 == 8 then
                        u38 = 0;
                        u37 = u37 + 1;
                    end;

                    v63 = 2 * v63 + bit32_extract_ret2;
                end;

                local v64 = v46[v63];
                local v65 = 1;

                if v64 <= 15 then
                    v48 = v64;
                elseif v64 == 16 then
                    local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 2);
                    u38 = u38 + 2;
                    u37 = u37 + bit32.rshift(u38, 3);
                    u38 = bit32.band(u38, 7);
                    v65 = buffer_readbits_ret + 3;
                elseif v64 == 17 then
                    v48 = 0;
                    local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 3);
                    u38 = u38 + 3;
                    u37 = u37 + bit32.rshift(u38, 3);
                    u38 = bit32.band(u38, 7);
                    v65 = buffer_readbits_ret + 3;
                elseif v64 == 18 then
                    v48 = 0;
                    local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 7);
                    u38 = u38 + 7;
                    u37 = u37 + bit32.rshift(u38, 3);
                    u38 = bit32.band(u38, 7);
                    v65 = buffer_readbits_ret + 11;
                end;

                for i = 1, v65 do
                    table.insert(v49, v48);
                    local _ = i;
                end;

                if v45 <= #v49 then
                    local v66, v67;
                    local v68 = 0;

                    while true do
                        if v68 == 0 then
                            v68 = -1;
                            v42 = createHuffmanTable(v49);
                            v66 = table.create(v47);
                            v67 = nil;
                            v68 = 1;
                            continue;
                        elseif v68 == 1 then
                            v68 = -1;
                            local buffer_readu8_ret2 = buffer.readu8(u35, u37);
                            local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u38);
                            u38 = u38 + 1;

                            if u38 == 8 then
                                u38 = 0;
                                u37 = u37 + 1;
                            end;

                            local v69 = 2 + bit32_extract_ret2;

                            while not v46[v69] do
                                local buffer_readu8_ret3 = buffer.readu8(u35, u37);
                                local bit32_extract_ret3 = bit32.extract(buffer_readu8_ret3, u38);
                                u38 = u38 + 1;

                                if u38 == 8 then
                                    u38 = 0;
                                    u37 = u37 + 1;
                                end;

                                v69 = 2 * v69 + bit32_extract_ret3;
                            end;

                            local v70 = v46[v69];
                            local v71 = 1;

                            if v70 <= 15 then
                                v67 = v70;
                            elseif v70 == 16 then
                                local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 2);
                                u38 = u38 + 2;
                                u37 = u37 + bit32.rshift(u38, 3);
                                u38 = bit32.band(u38, 7);
                                v71 = buffer_readbits_ret + 3;
                            elseif v70 == 17 then
                                v67 = 0;
                                local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 3);
                                u38 = u38 + 3;
                                u37 = u37 + bit32.rshift(u38, 3);
                                u38 = bit32.band(u38, 7);
                                v71 = buffer_readbits_ret + 3;
                            elseif v70 == 18 then
                                v67 = 0;
                                local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, 7);
                                u38 = u38 + 7;
                                u37 = u37 + bit32.rshift(u38, 3);
                                u38 = bit32.band(u38, 7);
                                v71 = buffer_readbits_ret + 11;
                            end;

                            for i = 1, v71 do
                                table.insert(v66, v67);
                                local _ = i;
                            end;

                            if v47 <= #v66 then
                                v43 = createHuffmanTable(v66);
                                v51 = 4;
                                break;
                            end;

                            v68 = 1;
                            continue;
                        else
                            break;
                        end;
                    end;

                    if v51 ~= -1 then
                        continue;
                    end;
                end;

                v51 = 6;
                continue;
            elseif v51 == 7 then
                v51 = -1;
                local buffer_readu8_ret = buffer.readu8(u35, u37);
                local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u38);
                u38 = u38 + 1;

                if u38 == 8 then
                    u38 = 0;
                    u37 = u37 + 1;
                end;

                v44 = 2 * v44 + bit32_extract_ret;
                v51 = 8;
                continue;
            elseif v51 == 8 then
                v51 = -1;

                if v42[v44] then
                    v51 = 9;
                    continue;
                else
                    v51 = 7;
                    continue;
                end;

                v51 = 9;
                continue;
            elseif v51 == 9 then
                v51 = -1;
                v50 = v42[v44];

                if v50 < 256 then
                    buffer.writeu8(p36, v39, v50);
                    v39 = v39 + 1;
                elseif v50 > 256 then
                    local v72 = u1[v50 - 256];

                    if v50 > 268 then
                        local v73 = u4[v50 - 264];
                        local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, v73);
                        u38 = u38 + v73;
                        u37 = u37 + bit32.rshift(u38, 3);
                        u38 = bit32.band(u38, 7);
                        v72 = v72 + buffer_readbits_ret;
                    elseif v50 > 264 then
                        local buffer_readu8_ret = buffer.readu8(u35, u37);
                        local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u38);
                        u38 = u38 + 1;

                        if u38 == 8 then
                            u38 = 0;
                            u37 = u37 + 1;
                        end;

                        v72 = v72 + bit32_extract_ret;
                    end;

                    local buffer_readu8_ret = buffer.readu8(u35, u37);
                    local bit32_extract_ret = bit32.extract(buffer_readu8_ret, u38);
                    u38 = u38 + 1;

                    if u38 == 8 then
                        u38 = 0;
                        u37 = u37 + 1;
                    end;

                    local v74 = 2 + bit32_extract_ret;

                    while not v43[v74] do
                        local buffer_readu8_ret2 = buffer.readu8(u35, u37);
                        local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u38);
                        u38 = u38 + 1;

                        if u38 == 8 then
                            u38 = 0;
                            u37 = u37 + 1;
                        end;

                        v74 = 2 * v74 + bit32_extract_ret2;
                    end;

                    local v75 = v43[v74];
                    local v76 = u6[v75 + 1];

                    if v75 > 5 then
                        local v77 = u14[v75];
                        local buffer_readbits_ret = buffer.readbits(u35, u37 * 8 + u38, v77);
                        u38 = u38 + v77;
                        u37 = u37 + bit32.rshift(u38, 3);
                        u38 = bit32.band(u38, 7);
                        v76 = v76 + buffer_readbits_ret;
                    elseif v75 > 3 then
                        local buffer_readu8_ret2 = buffer.readu8(u35, u37);
                        local bit32_extract_ret2 = bit32.extract(buffer_readu8_ret2, u38);
                        u38 = u38 + 1;

                        if u38 == 8 then
                            u38 = 0;
                            u37 = u37 + 1;
                        end;

                        v76 = v76 + bit32_extract_ret2;
                    end;

                    if v72 <= v76 then
                        buffer.copy(p36, v39, p36, v39 - v76, v72);
                        v39 = v39 + v72;
                    else
                        repeat
                            local math_min_ret = math.min(v72, v76);
                            buffer.copy(p36, v39, p36, v39 - v76, math_min_ret);
                            v39 = v39 + math_min_ret;
                            v72 = v72 - math_min_ret;
                            v76 = v76 + math_min_ret;
                        until v72 == 0;
                    end;

                    v51 = 10;
                    continue;
                end;

                v51 = 10;
                continue;
            elseif v51 == 10 then
                v51 = -1;

                if v50 == 256 then
                    v51 = 2;
                    continue;
                end;

                v51 = 4;
                continue;
            else
                break;
            end;
        end;
    end,

    deflate = function(p78: buffer) -- Line: 322, Name: deflate
        -- upvalues: u21 (copy), u22 (copy), u2 (copy), u3 (copy), u5 (copy), getDistIdx (copy), u24 (copy), u25 (copy), u6 (copy), u14 (copy), adler32 (copy)
        local buffer_len_ret = buffer.len(p78);
        local buffer_create_ret = buffer.create(math.ceil(buffer_len_ret / 32768) * 5 + buffer_len_ret + 6);
        buffer.writeu16(buffer_create_ret, 0, 24184);
        local u79 = 2;
        local u80 = 0;

        local function writeBits(p81: number, p82: number) -- Line: 333
            -- upvalues: buffer_create_ret (copy), u79 (ref), u80 (ref)
            buffer.writebits(buffer_create_ret, u79 * 8 + u80, p82, p81);
            u80 = u80 + p82;
            u79 = u79 + bit32.rshift(u80, 3);
            u80 = bit32.band(u80, 7);
        end;

        local function writeHuffmanBits(p83: number, p84: number) -- Line: 341
            -- upvalues: buffer_create_ret (copy), u79 (ref), u80 (ref)
            local bit32_rshift_ret = bit32.rshift(p83, 1);
            local bit32_band_ret = bit32.band(bit32_rshift_ret, 1431655765);
            local bit32_lshift_ret = bit32.lshift(p83, 1);
            local bit32_band_ret2 = bit32.band(bit32_lshift_ret, 2863311530);
            local bit32_bor_ret = bit32.bor(bit32_band_ret, bit32_band_ret2);
            local bit32_rshift_ret2 = bit32.rshift(bit32_bor_ret, 2);
            local bit32_band_ret3 = bit32.band(bit32_rshift_ret2, 858993459);
            local bit32_lshift_ret2 = bit32.lshift(bit32_bor_ret, 2);
            local bit32_band_ret4 = bit32.band(bit32_lshift_ret2, 3435973836);
            local bit32_bor_ret2 = bit32.bor(bit32_band_ret3, bit32_band_ret4);
            local bit32_rshift_ret3 = bit32.rshift(bit32_bor_ret2, 4);
            local bit32_band_ret5 = bit32.band(bit32_rshift_ret3, 252645135);
            local bit32_lshift_ret3 = bit32.lshift(bit32_bor_ret2, 4);
            local bit32_band_ret6 = bit32.band(bit32_lshift_ret3, 4042322160);
            local bit32_bor_ret3 = bit32.bor(bit32_band_ret5, bit32_band_ret6);
            local bit32_rshift_ret4 = bit32.rshift(bit32_bor_ret3, 8);
            local bit32_band_ret7 = bit32.band(bit32_rshift_ret4, 16711935);
            local bit32_lshift_ret4 = bit32.lshift(bit32_bor_ret3, 8);
            local bit32_band_ret8 = bit32.band(bit32_lshift_ret4, 4278255360);
            local bit32_bor_ret4 = bit32.bor(bit32_band_ret7, bit32_band_ret8);
            local bit32_rshift_ret5 = bit32.rshift(bit32_bor_ret4, 16);
            local bit32_lshift_ret5 = bit32.lshift(bit32_bor_ret4, 16);
            local bit32_bor_ret5 = bit32.bor(bit32_rshift_ret5, bit32_lshift_ret5);
            local bit32_rshift_ret6 = bit32.rshift(bit32_bor_ret5, 32 - p84);
            local v85 = bit32.lshift(1, p84) - 1;
            local bit32_band_ret9 = bit32.band(bit32_rshift_ret6, v85);
            buffer.writebits(buffer_create_ret, u79 * 8 + u80, p84, bit32_band_ret9);
            u80 = u80 + p84;
            u79 = u79 + bit32.rshift(u80, 3);
            u80 = bit32.band(u80, 7);
        end;

        local function writeLitOrLen(p86: number) -- Line: 351
            -- upvalues: writeHuffmanBits (copy), u21 (ref), u22 (ref)
            writeHuffmanBits(u21[p86], u22[p86]);
        end;

        local function writeBackRef(p87: number, p88: number) -- Line: 355
            -- upvalues: u2 (ref), writeHuffmanBits (copy), u21 (ref), u22 (ref), u3 (ref), u5 (ref), buffer_create_ret (copy), u79 (ref), u80 (ref), getDistIdx (ref), u24 (ref), u25 (ref), u6 (ref), u14 (ref)
            local v89 = u2[p88];
            writeHuffmanBits(u21[v89], u22[v89]);

            if p88 > 10 then
                local v90 = u5[p88];
                buffer.writebits(buffer_create_ret, u79 * 8 + u80, v90, u3[p88]);
                u80 = u80 + v90;
                u79 = u79 + bit32.rshift(u80, 3);
                u80 = bit32.band(u80, 7);
            end;

            local v91 = getDistIdx(p87);
            writeHuffmanBits(u24[v91 - 1], u25[v91 - 1]);

            if v91 > 3 then
                local v92 = u14[v91 - 1];
                buffer.writebits(buffer_create_ret, u79 * 8 + u80, v92, p87 - u6[v91]);
                u80 = u80 + v92;
                u79 = u79 + bit32.rshift(u80, 3);
                u80 = bit32.band(u80, 7);
            end;
        end;

        local function getLitOrLenSize(p93: number) -- Line: 367
            -- upvalues: u22 (ref)
            return u22[p93];
        end;

        local function getBackRefSize(p94: number, p95: number) -- Line: 371
            -- upvalues: getDistIdx (ref), u2 (ref), u22 (ref), u5 (ref), u25 (ref), u14 (ref)
            local v96 = getDistIdx(p94);

            return u22[u2[p95]] + u5[p95] + u25[v96 - 1] + (u14[v96 - 1] or 0);
        end;

        local u97 = {};
        local u98 = {};
        local u99 = {};
        local u100 = 0;

        local function insertNode(p101: number, p102: number) -- Line: 384
            -- upvalues: u100 (ref), u97 (copy), u98 (copy)
            u100 = u100 + 1;
            u97[u100] = p101;
            u98[u100] = p102;

            return u100;
        end;

        local function clearTables() -- Line: 391
            -- upvalues: u97 (copy), u98 (copy), u99 (copy), u100 (ref)
            table.clear(u97);
            table.clear(u98);
            table.clear(u99);
            u100 = 0;
        end;

        for i = 0, buffer_len_ret - 1, 32768 do
            local math_min_ret = math.min(buffer_len_ret, i + 32768);
            local v103 = i;
            local v104 = v103;
            local v105 = v103;
            v103 = v104;
            v105 = v104;
            local v106 = {};
            local v107 = 0;

            while v104 < math_min_ret - 3 do
                local buffer_readu32_ret = buffer.readu32(p78, v104);
                local bit32_band_ret = bit32.band(buffer_readu32_ret, 16777215);
                local v108 = u99[bit32_band_ret] or 0;
                u100 = u100 + 1;
                u97[u100] = v104;
                u98[u100] = v108;
                local v109 = u100;
                u99[bit32_band_ret] = v109;
                local v110 = u98[v109];
                local v111 = -1;
                local v112 = 0;
                local v113 = 0;
                local v114, v115;

                while true do
                    if not (v110 and ((u97[v110] or (-1 / 0)) >= v104 - 32510 and (v112 < 12 and v113 < 96))) then
                        v114 = v111;
                        v115 = v113;
                        break;
                    end;

                    v115 = 3;
                    v114 = u97[v110];
                    local v116;

                    if math.min(math_min_ret, v104 + 258) > v104 + v113 and buffer.readu8(p78, v114 + v113) ~= buffer.readu8(p78, v104 + v113) then
                        v116 = true;
                    else
                        v116 = false;
                    end;

                    while not (v116 or (v115 >= 258 or (v104 + v115 >= math_min_ret or buffer.readu8(p78, v114 + v115) ~= buffer.readu8(p78, v104 + v115)))) do
                        v115 = v115 + 1;
                    end;

                    if v113 < v115 then
                        if v115 >= 258 then
                            break;
                        end;
                    else
                        v114 = v111;
                        v115 = v113;
                    end;

                    v110 = u98[v110];
                    v112 = v112 + 1;
                    v113 = v115;
                    v111 = v114;
                end;

                if v115 == 0 then
                    local buffer_readu8_ret = buffer.readu8(p78, v104);
                    v107 = v107 + u22[buffer_readu8_ret];
                    local vector_create_ret = vector.create(0, buffer_readu8_ret);
                    table.insert(v106, vector_create_ret);
                    v104 = v104 + 1;
                else
                    local v117 = getDistIdx(v104 - v114);
                    v107 = v107 + (u22[u2[v115]] + u5[v115] + u25[v117 - 1] + (u14[v117 - 1] or 0));
                    local vector_create_ret = vector.create(1, v104 - v114, v115);
                    table.insert(v106, vector_create_ret);

                    for i2 = v104 + 1, math.min(v104 + v115 - 1, math_min_ret - 4) do
                        local buffer_readu32_ret2 = buffer.readu32(p78, i2);
                        local bit32_band_ret2 = bit32.band(buffer_readu32_ret2, 16777215);
                        local v118 = u99[bit32_band_ret2] or 0;
                        u100 = u100 + 1;
                        u97[u100] = i2;
                        u98[u100] = v118;
                        u99[bit32_band_ret2] = u100;
                        local _ = i2;
                    end;

                    v104 = v104 + v115;
                end;
            end;

            while v104 < math_min_ret do
                local buffer_readu8_ret = buffer.readu8(p78, v104);
                v107 = v107 + u22[buffer_readu8_ret];
                local vector_create_ret = vector.create(0, buffer_readu8_ret);
                table.insert(v106, vector_create_ret);
                v104 = v104 + 1;
            end;

            local v119 = v107 + u22[256];
            table.insert(v106, Vector3.new(0, 256, 0));

            if math_min_ret == buffer_len_ret then
                buffer.writebits(buffer_create_ret, u79 * 8 + u80, 1, 1);
                u80 = u80 + 1;
                u79 = u79 + bit32.rshift(u80, 3);
                u80 = bit32.band(u80, 7);
            else
                buffer.writebits(buffer_create_ret, u79 * 8 + u80, 1, 0);
                u80 = u80 + 1;
                u79 = u79 + bit32.rshift(u80, 3);
                u80 = bit32.band(u80, 7);
            end;

            local v120 = math_min_ret - v103;

            if math.ceil(v119 / 8) + 1 < math.ceil(v120 / 32768) * 5 + v120 then
                buffer.writebits(buffer_create_ret, u79 * 8 + u80, 2, 1);
                u80 = u80 + 2;
                u79 = u79 + bit32.rshift(u80, 3);
                u80 = bit32.band(u80, 7);

                for _, v in v106 do
                    if v.x == 0 then
                        local y = v.y;
                        writeHuffmanBits(u21[y], u22[y]);
                    else
                        writeBackRef(v.y, v.z);
                    end;
                end;
            else
                buffer.writebits(buffer_create_ret, u79 * 8 + u80, 2, 0);
                u80 = u80 + 2;
                u79 = u79 + bit32.rshift(u80, 3);
                u80 = bit32.band(u80, 7);

                if u80 > 0 then
                    u79 = u79 + 1;
                    u80 = 0;
                end;

                buffer.writeu16(buffer_create_ret, u79, v120);
                local bit32_bxor_ret = bit32.bxor(65535, v120);
                buffer.writeu16(buffer_create_ret, u79 + 2, bit32_bxor_ret);
                buffer.copy(buffer_create_ret, u79 + 4, p78, v103, v120);
                u79 = u79 + (v120 + 4);
            end;

            if u100 > 50000 then
                table.clear(u97);
                table.clear(u98);
                table.clear(u99);
                u100 = 0;
            end;
        end;

        if u80 > 0 then
            u79 = u79 + 1;
        end;

        local v121 = adler32(p78, 0, buffer.len(p78));
        local bit32_byteswap_ret = bit32.byteswap(v121);
        buffer.writeu32(buffer_create_ret, u79, bit32_byteswap_ret);

        return buffer_create_ret, u79 + 4;
    end
};