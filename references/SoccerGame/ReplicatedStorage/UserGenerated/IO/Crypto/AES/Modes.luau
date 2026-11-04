  

local bit32_bxor = bit32.bxor;
local buffer_copy = buffer.copy;
local buffer_create = buffer.create;
local buffer_len = buffer.len;
local buffer_readu8 = buffer.readu8;
local buffer_readu32 = buffer.readu32;
local _ = buffer.tostring;
local buffer_writestring = buffer.writestring;
local buffer_writeu8 = buffer.writeu8;
local buffer_writeu32 = buffer.writeu32;
local _ = math.floor;
local math_random = math.random;
local string_pack = string.pack;
local u1 = buffer_create(16);

local function addByteCtr(p2: buffer, p3: number, p4: number, p5: number, p6: boolean) -- Line: 44
    -- upvalues: buffer_readu8 (copy), buffer_writeu8 (copy)
    local v7 = 0;

    while true do
        if v7 == 0 then
            v7 = -1;

            if not p6 then
                local v8 = buffer_readu8(p2, p5) + p3;
                buffer_writeu8(p2, p5, v8);

                if v8 >= 256 then
                    for i = p5 - 1, p4, -1 do
                        local v9 = buffer_readu8(p2, i) + 1;
                        buffer_writeu8(p2, i, v9);

                        if v9 < 256 then
                            break;
                        end;

                        local _ = i;
                    end;
                end;

                v7 = 1;
                continue;
            end;

            local v10 = buffer_readu8(p2, p4) + p3;
            buffer_writeu8(p2, p4, v10);

            if v10 >= 256 then
                for i = p4 + 1, p5 do
                    local v11 = buffer_readu8(p2, i) + 1;
                    buffer_writeu8(p2, i, v11);

                    if v11 < 256 then
                        v7 = 1;
                        break;
                    end;

                    local _ = i;
                end;

                if v7 ~= -1 then
                    continue;
                end;

                return;
            end;

            v7 = 1;
            continue;
        elseif v7 == 1 then
            v7 = -1;
            break;
        else
            break;
        end;
    end;
end;

local v22 = {
    ECB = {
        FwdMode = function(p12, p13, p14, p15) -- Line: 81, Name: FwdMode
            -- upvalues: buffer_len (copy)
            local v16 = buffer_len(p14) - 16;
            assert(v16 % 16 == 0, "Input length must be a multiple of 16 bytes");

            for i = 0, v16, 16 do
                p12(p14, i, p15, i);
                local _ = i;
            end;
        end,

        InvMode = function(p17, p18, p19, p20) -- Line: 88, Name: InvMode
            -- upvalues: buffer_len (copy)
            local v21 = buffer_len(p19) - 16;
            assert(v21 % 16 == 0, "Input length must be a multiple of 16 bytes");

            for i = 0, v21, 16 do
                p18(p19, i, p20, i);
                local _ = i;
            end;
        end
    }
};
table.freeze(v22.ECB);
v22.CBC = {
    FwdMode = function(p23, p24, p25, p26, p27, p28) -- Line: 105, Name: FwdMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v29 = buffer_len(p25) - 16;
        assert(v29 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v30 = p28 or u1;
        local v31 = buffer_len(v30) == 16;
        assert(v31, "Initialization vector must be 16 bytes long");
        buffer_writeu32(p26, 0, (bit32_bxor(buffer_readu32(p25, 0), (buffer_readu32(v30, 0)))));
        buffer_writeu32(p26, 4, (bit32_bxor(buffer_readu32(p25, 4), (buffer_readu32(v30, 4)))));
        buffer_writeu32(p26, 8, (bit32_bxor(buffer_readu32(p25, 8), (buffer_readu32(v30, 8)))));
        buffer_writeu32(p26, 12, (bit32_bxor(buffer_readu32(p25, 12), (buffer_readu32(v30, 12)))));
        p23(p26, 0, p26, 0);

        for i = 16, v29, 16 do
            buffer_writeu32(p26, i, (bit32_bxor(buffer_readu32(p25, i), (buffer_readu32(p26, i - 16)))));
            buffer_writeu32(p26, i + 4, (bit32_bxor(buffer_readu32(p25, i + 4), (buffer_readu32(p26, i - 12)))));
            buffer_writeu32(p26, i + 8, (bit32_bxor(buffer_readu32(p25, i + 8), (buffer_readu32(p26, i - 8)))));
            buffer_writeu32(p26, i + 12, (bit32_bxor(buffer_readu32(p25, i + 12), (buffer_readu32(p26, i - 4)))));
            p23(p26, i, p26, i);
            local _ = i;
        end;
    end,

    InvMode = function(p32, p33, p34, p35, p36, p37) -- Line: 123, Name: InvMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v38 = buffer_len(p34) - 16;
        assert(v38 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v39 = p37 or u1;
        local v40 = buffer_len(v39) == 16;
        assert(v40, "Initialization vector must be 16 bytes long");
        local v41 = buffer_readu32(p34, 0);
        local v42 = buffer_readu32(p34, 4);
        local v43 = buffer_readu32(p34, 8);
        local v44 = buffer_readu32(p34, 12);
        p33(p34, 0, p35, 0);
        buffer_writeu32(p35, 0, (bit32_bxor(buffer_readu32(p35, 0), (buffer_readu32(v39, 0)))));
        buffer_writeu32(p35, 4, (bit32_bxor(buffer_readu32(p35, 4), (buffer_readu32(v39, 4)))));
        buffer_writeu32(p35, 8, (bit32_bxor(buffer_readu32(p35, 8), (buffer_readu32(v39, 8)))));
        buffer_writeu32(p35, 12, (bit32_bxor(buffer_readu32(p35, 12), (buffer_readu32(v39, 12)))));

        for i = 16, v38, 16 do
            local v45 = buffer_readu32(p34, i);
            local v46 = buffer_readu32(p34, i + 4);
            local v47 = buffer_readu32(p34, i + 8);
            local v48 = buffer_readu32(p34, i + 12);
            p33(p34, i, p35, i);
            buffer_writeu32(p35, i, (bit32_bxor(buffer_readu32(p35, i), v41)));
            buffer_writeu32(p35, i + 4, (bit32_bxor(buffer_readu32(p35, i + 4), v42)));
            buffer_writeu32(p35, i + 8, (bit32_bxor(buffer_readu32(p35, i + 8), v43)));
            buffer_writeu32(p35, i + 12, (bit32_bxor(buffer_readu32(p35, i + 12), v44)));
            v41 = v45;
            v44 = v48;
            v43 = v47;
            v42 = v46;
            local _ = i;
        end;
    end
};
table.freeze(v22.CBC);
v22.PCBC = {
    FwdMode = function(p49, p50, p51, p52, p53, p54) -- Line: 161, Name: FwdMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v55 = buffer_len(p51) - 16;
        assert(v55 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v56 = p54 or u1;
        local v57 = buffer_len(v56) == 16;
        assert(v57, "Initialization vector must be 16 bytes long");
        local v58 = buffer_readu32(p51, 0);
        local v59 = buffer_readu32(p51, 4);
        local v60 = buffer_readu32(p51, 8);
        local v61 = buffer_readu32(p51, 12);
        buffer_writeu32(p52, 0, (bit32_bxor(v58, (buffer_readu32(v56, 0)))));
        buffer_writeu32(p52, 4, (bit32_bxor(v59, (buffer_readu32(v56, 4)))));
        buffer_writeu32(p52, 8, (bit32_bxor(v60, (buffer_readu32(v56, 8)))));
        buffer_writeu32(p52, 12, (bit32_bxor(v61, (buffer_readu32(v56, 12)))));
        p49(p52, 0, p52, 0);

        for i = 16, v55, 16 do
            local v62 = buffer_readu32(p51, i);
            local v63 = buffer_readu32(p51, i + 4);
            local v64 = buffer_readu32(p51, i + 8);
            local v65 = buffer_readu32(p51, i + 12);
            buffer_writeu32(p52, i, (bit32_bxor(v58, v62, (buffer_readu32(p52, i - 16)))));
            buffer_writeu32(p52, i + 4, (bit32_bxor(v59, v63, (buffer_readu32(p52, i - 12)))));
            buffer_writeu32(p52, i + 8, (bit32_bxor(v60, v64, (buffer_readu32(p52, i - 8)))));
            buffer_writeu32(p52, i + 12, (bit32_bxor(v61, v65, (buffer_readu32(p52, i - 4)))));
            p49(p52, i, p52, i);
            v59 = v63;
            v58 = v62;
            v61 = v65;
            v60 = v64;
            local _ = i;
        end;
    end,

    InvMode = function(p66, p67, p68, p69, p70, p71) -- Line: 189, Name: InvMode
        -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
        local v72 = buffer_len(p68) - 16;
        assert(v72 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v73 = p71 or u1;
        local v74 = buffer_len(v73) == 16;
        assert(v74, "Initialization vector must be 16 bytes long");
        local v75 = buffer_readu32(p68, 0);
        local v76 = buffer_readu32(p68, 4);
        local v77 = buffer_readu32(p68, 8);
        local v78 = buffer_readu32(p68, 12);
        p67(p68, 0, p69, 0);
        local v79 = bit32_bxor(buffer_readu32(p69, 0), (buffer_readu32(v73, 0)));
        local v80 = bit32_bxor(buffer_readu32(p69, 4), (buffer_readu32(v73, 4)));
        local v81 = bit32_bxor(buffer_readu32(p69, 8), (buffer_readu32(v73, 8)));
        local v82 = bit32_bxor(buffer_readu32(p69, 12), (buffer_readu32(v73, 12)));
        buffer_writeu32(p69, 0, v79);
        buffer_writeu32(p69, 4, v80);
        buffer_writeu32(p69, 8, v81);
        buffer_writeu32(p69, 12, v82);
        local v83 = 12;
        local v84 = 0;
        local v85 = 4;
        local v86 = 8;

        for i = 16, v72, 16 do
            v84 = v84 + 16;
            v85 = v85 + 16;
            v86 = v86 + 16;
            v83 = v83 + 16;
            local v87 = buffer_readu32(p68, v84);
            local v88 = buffer_readu32(p68, v85);
            local v89 = buffer_readu32(p68, v86);
            local v90 = buffer_readu32(p68, v83);
            p67(p68, i, p69, i);
            v79 = bit32_bxor(v75, v79, (buffer_readu32(p69, v84)));
            v80 = bit32_bxor(v76, v80, (buffer_readu32(p69, v85)));
            v81 = bit32_bxor(v77, v81, (buffer_readu32(p69, v86)));
            v82 = bit32_bxor(v78, v82, (buffer_readu32(p69, v83)));
            buffer_writeu32(p69, v84, v79);
            buffer_writeu32(p69, v85, v80);
            buffer_writeu32(p69, v86, v81);
            buffer_writeu32(p69, v83, v82);
            v77 = v89;
            v78 = v90;
            v76 = v88;
            v75 = v87;
            local _ = i;
        end;
    end
};
table.freeze(v22.PCBC);

local function cfbFwd(p91: any, p92: any, p93: any, p94: any, p95: table, p96: any) -- Line: 243
    -- upvalues: buffer_len (copy), u1 (copy), buffer_create (copy), buffer_readu8 (copy), bit32_bxor (copy), buffer_writeu8 (copy), buffer_copy (copy)
    local SegmentSize = p95.SegmentSize;
    local v97 = buffer_len(p93);
    assert(v97 % SegmentSize == 0, "Input length must be a multiple of segment size");
    local v98 = p96 or u1;
    local v99 = buffer_len(v98) == 16;
    assert(v99, "Initialization vector must be 16 bytes long");
    local v100 = p95.CommonTemp or buffer_create(31);

    if v97 == SegmentSize then
        p91(v98, 0, v100, 0);

        for i = 0, SegmentSize - 1 do
            buffer_writeu8(p94, i, (bit32_bxor(buffer_readu8(p93, i), (buffer_readu8(v100, i)))));
            local _ = i;
        end;

        return;
    end;

    local v101 = v97 - SegmentSize;
    local v102 = 16 - SegmentSize;
    p91(v98, 0, v100, 0);

    for i = 0, SegmentSize - 1 do
        buffer_writeu8(p94, i, (bit32_bxor(buffer_readu8(p93, i), (buffer_readu8(v100, i)))));
        local _ = i;
    end;

    buffer_copy(v100, 0, v98, SegmentSize, v102);
    buffer_copy(v100, v102, p94, 0, SegmentSize);

    for i = SegmentSize, v101 - SegmentSize, SegmentSize do
        buffer_copy(v100, 16, v100, SegmentSize, v102);
        p91(v100, 0, v100, 0);
        local v103 = 0;

        for i2 = i, i + SegmentSize - 1 do
            buffer_writeu8(p94, i2, (bit32_bxor(buffer_readu8(p93, i2), (buffer_readu8(v100, v103)))));
            v103 = v103 + 1;
            local _ = i2;
        end;

        buffer_copy(v100, 0, v100, 16, v102);
        buffer_copy(v100, v102, p94, i, SegmentSize);
    end;

    p91(v100, 0, v100, 0);
    local v104 = 0;

    for i = v101, v97 - 1 do
        buffer_writeu8(p94, i, (bit32_bxor(buffer_readu8(p93, i), (buffer_readu8(v100, v104)))));
        v104 = v104 + 1;
        local _ = i;
    end;
end;

local function cfbInv(p105: any, p106: any, p107: any, p108: any, p109: table, p110: any) -- Line: 284
    -- upvalues: buffer_len (copy), u1 (copy), buffer_create (copy), buffer_readu8 (copy), bit32_bxor (copy), buffer_writeu8 (copy), buffer_copy (copy)
    local v111 = buffer_len(p107);
    local SegmentSize = p109.SegmentSize;
    assert(v111 % SegmentSize == 0, "Input length must be a multiple of segment size");
    local v112 = p110 or u1;
    local v113 = buffer_len(v112) == 16;
    assert(v113, "Initialization vector must be 16 bytes long");
    local v114 = p109.CommonTemp or buffer_create(31);

    if v111 == SegmentSize then
        p105(v112, 0, v114, 0);

        for i = 0, SegmentSize - 1 do
            buffer_writeu8(p108, i, (bit32_bxor(buffer_readu8(p107, i), (buffer_readu8(v114, i)))));
            local _ = i;
        end;

        return;
    end;

    local v115 = v111 - SegmentSize;
    local v116 = 16 - SegmentSize;
    p105(v112, 0, v114, 0);

    for i = 0, SegmentSize - 1 do
        buffer_writeu8(p108, i, (bit32_bxor(buffer_readu8(p107, i), (buffer_readu8(v114, i)))));
        local _ = i;
    end;

    buffer_copy(v114, 0, v112, SegmentSize, v116);
    buffer_copy(v114, v116, p107, 0, SegmentSize);

    for i = SegmentSize, v115 - SegmentSize, SegmentSize do
        buffer_copy(v114, 16, v114, SegmentSize, v116);
        p105(v114, 0, v114, 0);
        local v117 = 0;

        for i2 = i, i + SegmentSize - 1 do
            buffer_writeu8(p108, i2, (bit32_bxor(buffer_readu8(p107, i2), (buffer_readu8(v114, v117)))));
            v117 = v117 + 1;
            local _ = i2;
        end;

        buffer_copy(v114, 0, v114, 16, v116);
        buffer_copy(v114, v116, p107, i, SegmentSize);
    end;

    p105(v114, 0, v114, 0);
    local v118 = 0;

    for i = v115, v111 - 1 do
        buffer_writeu8(p108, i, (bit32_bxor(buffer_readu8(p107, i), (buffer_readu8(v114, v118)))));
        v118 = v118 + 1;
        local _ = i;
    end;
end;

local function ofbMode(p119: any, p120: any, p121: buffer, p122: buffer, p123: any, p124: buffer) -- Line: 334
    -- upvalues: buffer_len (copy), u1 (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy)
    local v125 = buffer_len(p121) - 16;
    assert(v125 % 16 == 0, "Input length must be a multiple of 16 bytes");
    local v126 = p124 or u1;
    local v127 = buffer_len(v126) == 16;
    assert(v127, "Initialization vector must be 16 bytes long");
    local v128 = buffer_readu32(p121, 0);
    local v129 = buffer_readu32(p121, 4);
    local v130 = buffer_readu32(p121, 8);
    local v131 = buffer_readu32(p121, 12);
    p119(v126, 0, p122, 0);
    local v132 = bit32_bxor(v128, (buffer_readu32(p122, 0)));
    local v133 = bit32_bxor(v129, (buffer_readu32(p122, 4)));
    local v134 = bit32_bxor(v130, (buffer_readu32(p122, 8)));
    local v135 = bit32_bxor(v131, (buffer_readu32(p122, 12)));

    for i = 16, v125, 16 do
        local v136 = buffer_readu32(p121, i);
        local v137 = buffer_readu32(p121, i + 4);
        local v138 = buffer_readu32(p121, i + 8);
        local v139 = buffer_readu32(p121, i + 12);
        p119(p122, i - 16, p122, i);
        buffer_writeu32(p122, i - 16, v132);
        buffer_writeu32(p122, i - 12, v133);
        buffer_writeu32(p122, i - 8, v134);
        buffer_writeu32(p122, i - 4, v135);
        v132 = bit32_bxor(v136, (buffer_readu32(p122, i)));
        v133 = bit32_bxor(v137, (buffer_readu32(p122, i + 4)));
        v134 = bit32_bxor(v138, (buffer_readu32(p122, i + 8)));
        v135 = bit32_bxor(v139, (buffer_readu32(p122, i + 12)));
        local _ = i;
    end;

    buffer_writeu32(p122, v125, v132);
    buffer_writeu32(p122, v125 + 4, v133);
    buffer_writeu32(p122, v125 + 8, v134);
    buffer_writeu32(p122, v125 + 12, v135);
end;

v22.OFB = {
    FwdMode = ofbMode,
    InvMode = ofbMode
};
table.freeze(v22.OFB);

local function ctrMode(p140: any, p141: any, p142: any, p143: any, p144: table) -- Line: 391
    -- upvalues: buffer_len (copy), buffer_writestring (copy), buffer_readu32 (copy), bit32_bxor (copy), buffer_writeu32 (copy), addByteCtr (copy)
    local v145 = buffer_len(p142) - 16;
    assert(v145 % 16 == 0, "Input length must be a multiple of 16 bytes");
    local CommonTemp = p144.CommonTemp;
    local InitValue = p144.InitValue;
    local Prefix = p144.Prefix;
    local Suffix = p144.Suffix;
    local Step = p144.Step;
    local LittleEndian = p144.LittleEndian;
    local v146 = #Prefix;
    local v147 = v146 + #InitValue - 1;
    buffer_writestring(CommonTemp, 0, Prefix);
    buffer_writestring(CommonTemp, v146, InitValue);
    buffer_writestring(CommonTemp, v147 + 1, Suffix);
    local v148 = buffer_readu32(p142, 0);
    local v149 = buffer_readu32(p142, 4);
    local v150 = buffer_readu32(p142, 8);
    local v151 = buffer_readu32(p142, 12);
    p140(CommonTemp, 0, p143, 0);
    buffer_writeu32(p143, 0, (bit32_bxor(buffer_readu32(p143, 0), v148)));
    buffer_writeu32(p143, 4, (bit32_bxor(buffer_readu32(p143, 4), v149)));
    buffer_writeu32(p143, 8, (bit32_bxor(buffer_readu32(p143, 8), v150)));
    buffer_writeu32(p143, 12, (bit32_bxor(buffer_readu32(p143, 12), v151)));

    for i = 16, v145, 16 do
        local v152 = buffer_readu32(p142, i);
        local v153 = buffer_readu32(p142, i + 4);
        local v154 = buffer_readu32(p142, i + 8);
        local v155 = buffer_readu32(p142, i + 12);
        addByteCtr(CommonTemp, Step, v146, v147, LittleEndian);
        p140(CommonTemp, 0, p143, i);
        buffer_writeu32(p143, i, (bit32_bxor(v152, (buffer_readu32(p143, i)))));
        buffer_writeu32(p143, i + 4, (bit32_bxor(v153, (buffer_readu32(p143, i + 4)))));
        buffer_writeu32(p143, i + 8, (bit32_bxor(v154, (buffer_readu32(p143, i + 8)))));
        buffer_writeu32(p143, i + 12, (bit32_bxor(v155, (buffer_readu32(p143, i + 12)))));
        local _ = i;
    end;
end;

local v158 = {
    __index = function(p156: any, p157: string) -- Line: 442, Name: __index
        -- upvalues: cfbFwd (copy), cfbInv (copy), buffer_create (copy), ctrMode (copy), string_pack (copy), math_random (copy)
        return p157 == "CFB" and {
            SegmentSize = 16,
            FwdMode = cfbFwd,
            InvMode = cfbInv,
            CommonTemp = buffer_create(31)
        } or (p157 == "CTR" and {
            Prefix = "",
            Suffix = "",
            Step = 1,
            LittleEndian = false,
            FwdMode = ctrMode,
            InvMode = ctrMode,
            InitValue = string_pack("I2I2I2I2I2I2I2I2", math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535), math_random(0, 65535)),
            CommonTemp = buffer_create(16)
        } or nil);
    end,

    __newindex = function() -- Line: 472, Name: __newindex
    end
};
setmetatable(v22, v158);
v22.CFB = {};
v22.CTR = {};
table.freeze(v22);
v158.__metatable = "This metatable is locked";

return v22;