  

local string_byte = string.byte;
local string_char = string.char;
local string_find = string.find;
local string_gsub = string.gsub;
local string_sub = string.sub;
local table_concat = table.concat;
local table_sort = table.sort;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = {};
local u14 = { 16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15 };
local u15 = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0 };
local u16 = {};
local u17 = { 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258 };
local u18 = { 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577 };
local u19 = { 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13 };
local u20 = {};
local u21 = {};
local u22 = {};

for i = 0, 255 do
    u1[i] = string_char(i);
    local _ = i;
end;

local v23 = 1;

for i = 0, 32 do
    u2[i] = v23;
    v23 = v23 * 2;
    local _ = i;
end;

for i = 1, 9 do
    u3[i] = {};
    local v24 = i;

    for i2 = 0, u2[i + 1] - 1 do
        local v25 = i2;
        local v26 = v25;
        local v27 = v25;
        v25 = v26;
        v27 = v26;
        local v28 = 0;

        for i3 = 1, v24 do
            local v29 = v28 - v28 % 2 + ((v28 % 2 == 1 or v26 % 2 == 1) and 1 or 0);
            v26 = (v26 - v26 % 2) / 2;
            v28 = v29 * 2;
            local _ = i3;
        end;

        u3[v24][v25] = (v28 - v28 % 2) / 2;
    end;
end;

local v30 = 1;
local v31 = 18;
local v32 = 16;
local v33 = 265;

for i = 3, 258 do
    local v34;

    if i <= 10 then
        u5[i] = i + 254;
        u6[i] = 0;
        v34 = i;
    elseif i == 258 then
        u5[i] = 285;
        u6[i] = 0;
        v34 = i;
    else
        if v31 < i then
            v31 = v31 + v32;
            v32 = v32 * 2;
            v33 = v33 + 4;
            v30 = v30 + 1;
        end;

        local v35 = i - v31 - 1 + v32 / 2;
        u5[i] = (v35 - v35 % (v32 / 8)) / (v32 / 8) + v33;
        u6[i] = v30;
        u4[i] = v35 % (v32 / 8);
        v34 = i;
    end;
end;

u7[1] = 0;
u7[2] = 1;
u8[1] = 0;
u8[2] = 0;
local v36 = 4;
local v37 = 3;
local v38 = 2;
local v39 = 0;

for i = 3, 256 do
    if v36 < i then
        v37 = v37 * 2;
        v36 = v36 * 2;
        v38 = v38 + 2;
        v39 = v39 + 1;
    end;

    u7[i] = i <= v37 and v38 and v38 or v38 + 1;
    u8[i] = v39 < 0 and 0 or v39;
    local v40;

    if v36 >= 8 then
        u9[i] = (i - v36 / 2 - 1) % (v36 / 4);
        v40 = i;
    else
        v40 = i;
    end;
end;

function u13.Adler32(p41: table, p42: string) -- Line: 444
    -- upvalues: string_byte (copy)
    if type(p42) ~= "string" then
        error(("Usage: LibDeflate:Adler32(str): \'str\' - string expected got \'%s\'."):format((type(p42))), 2);
    end;

    local v43 = #p42;
    local v44 = 1;
    local v45 = 1;
    local v46 = 0;

    while v44 <= v43 - 15 do
        local v47, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62 = string_byte(p42, v44, v44 + 15);
        v46 = (v46 + v45 * 16 + v47 * 16 + 15 * v48 + 14 * v49 + 13 * v50 + 12 * v51 + 11 * v52 + 10 * v53 + 9 * v54 + 8 * v55 + 7 * v56 + 6 * v57 + 5 * v58 + 4 * v59 + 3 * v60 + 2 * v61 + v62) % 65521;
        v45 = (v45 + v47 + v48 + v49 + v50 + v51 + v52 + v53 + v54 + v55 + v56 + v57 + v58 + v59 + v60 + v61 + v62) % 65521;
        v44 = v44 + 16;
    end;

    while v44 <= v43 do
        v45 = (v45 + string_byte(p42, v44, v44)) % 65521;
        v46 = (v46 + v45) % 65521;
        v44 = v44 + 1;
    end;

    return (v46 * 65536 + v45) % 4294967296;
end;

local function IsEqualAdler32(p63: number, p64: number) -- Line: 502
    return p63 % 4294967296 == p64 % 4294967296;
end;

function u13.CreateDictionary(p65: table, p66: string, p67: number, p68: number) -- Line: 548
    -- upvalues: string_byte (copy)
    if type(p66) ~= "string" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string expected got \'%s\'."):format((type(p66))), 2);
    end;

    if type(p67) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' - number expected got \'%s\'."):format((type(p67))), 2);
    end;

    if type(p68) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' - number expected got \'%s\'."):format((type(p68))), 2);
    end;

    if p67 ~= #p66 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' does not match the actual length of \'str\'. \'strlen\': %u, \'#str\': %u . Please check if \'str\' is modified unintentionally."):format(p67, #p66));
    end;

    if p67 == 0 then
        error(
            "Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - Empty string is not allowed.",
            2
        );
    end;

    if p67 > 32768 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string longer than 32768 bytes is not allowed. Got %d bytes."):format(p67), 2);
    end;

    local v69 = p65:Adler32(p66);

    if p68 % 4294967296 ~= v69 % 4294967296 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' does not match the actual adler32 of \'str\'. \'adler32\': %u, \'Adler32(str)\': %u . Please check if \'str\' is modified unintentionally."):format(p68, v69));
    end;

    local v70 = {
        adler32 = p68,
        hash_tables = {},
        string_table = {},
        strlen = p67
    };
    local string_table = v70.string_table;
    local hash_tables = v70.hash_tables;
    string_table[1] = string_byte(p66, 1, 1);
    string_table[2] = string_byte(p66, 2, 2);

    if p67 >= 3 then
        local v71 = string_table[1] * 256 + string_table[2];
        local v72 = 1;

        while v72 <= p67 - 2 - 3 do
            local v73, v74, v75, v76 = string_byte(p66, v72 + 2, v72 + 5);
            string_table[v72 + 2] = v73;
            string_table[v72 + 3] = v74;
            string_table[v72 + 4] = v75;
            string_table[v72 + 5] = v76;
            local v77 = (v71 * 256 + v73) % 16777216;
            local v78 = hash_tables[v77];

            if not v78 then
                v78 = {};
                hash_tables[v77] = v78;
            end;

            v78[#v78 + 1] = v72 - p67;
            local v79 = v72 + 1;
            local v80 = (v77 * 256 + v74) % 16777216;
            local v81 = hash_tables[v80];

            if not v81 then
                v81 = {};
                hash_tables[v80] = v81;
            end;

            v81[#v81 + 1] = v79 - p67;
            local v82 = v79 + 1;
            local v83 = (v80 * 256 + v75) % 16777216;
            local v84 = hash_tables[v83];

            if not v84 then
                v84 = {};
                hash_tables[v83] = v84;
            end;

            v84[#v84 + 1] = v82 - p67;
            local v85 = v82 + 1;
            v71 = (v83 * 256 + v76) % 16777216;
            local v86 = hash_tables[v71];

            if not v86 then
                v86 = {};
                hash_tables[v71] = v86;
            end;

            v86[#v86 + 1] = v85 - p67;
            v72 = v85 + 1;
        end;

        while v72 <= p67 - 2 do
            local v87 = string_byte(p66, v72 + 2);
            string_table[v72 + 2] = v87;
            v71 = (v71 * 256 + v87) % 16777216;
            local v88 = hash_tables[v71];

            if not v88 then
                v88 = {};
                hash_tables[v71] = v88;
            end;

            v88[#v88 + 1] = v72 - p67;
            v72 = v72 + 1;
        end;
    end;

    return v70;
end;

local function IsValidDictionary(p89: table?) -- Line: 674
    if p89 == nil or type(p89) ~= "table" then
        return false, ("\'dictionary\' - table expected got \'%s\'."):format((type(p89)));
    end;

    if type(p89.adler32) == "number" and (type(p89.string_table) == "table" and (type(p89.strlen) == "number" and (p89.strlen > 0 and (p89.strlen <= 32768 and (p89.strlen == #p89.string_table and type(p89.hash_tables) == "table"))))) then
        return true, "";
    end;

    return false, ("\'%s\' - corrupted dictionary."):format((type(p89)));
end;

local u90 = {
    [0] = { false, nil, 0, 0, 0 },
    [1] = { false, nil, 4, 8, 4 },
    [2] = { false, nil, 5, 18, 8 },
    [3] = { false, nil, 6, 32, 32 },
    [4] = { true, 4, 4, 16, 16 },
    [5] = { true, 8, 16, 32, 32 },
    [6] = { true, 8, 16, 128, 128 },
    [7] = { true, 8, 32, 128, 256 },
    [8] = { true, 32, 128, 258, 1024 },
    [9] = { true, 32, 258, 258, 4096 }
};

local function IsValidArguments(p91: string, p92: boolean?, p93: table?, p94: boolean?, p95: table?) -- Line: 754
    -- upvalues: IsValidDictionary (copy), u90 (copy)
    if type(p91) ~= "string" then
        return false, ("\'str\' - string expected got \'%s\'."):format((type(p91)));
    end;

    if p92 then
        local v96, v97 = IsValidDictionary(p93);

        if not v96 then
            return false, v97;
        end;
    end;

    if p94 then
        local v98 = type(p95);

        if v98 ~= "nil" and v98 ~= "table" then
            return false, ("\'configs\' - nil or table expected got \'%s\'."):format((type(p95)));
        end;

        if v98 == "table" then
            assert(p95);

            for i, v in pairs(p95) do
                if i ~= "level" and i ~= "strategy" then
                    return false, ("\'configs\' - unsupported table key in the configs: \'%s\'."):format(i);
                end;

                if i == "level" and not u90[v] then
                    return false, ("\'configs\' - unsupported \'level\': %s."):format((tostring(v)));
                end;

                if i == "strategy" and (v ~= "fixed" and (v ~= "huffman_only" and v ~= "dynamic")) then
                    return false, ("\'configs\' - unsupported \'strategy\': \'%s\'."):format((tostring(v)));
                end;
            end;
        end;
    end;

    return true, "";
end;

local function CreateWriter() -- Line: 817
    -- upvalues: u2 (copy), u1 (copy), string_char (copy), table_concat (copy)
    local u99 = 0;
    local u100 = 0;
    local u101 = 0;
    local u102 = 0;
    local u103 = {};
    local u104 = {};

    return function(p105: number, p106: number) -- Line: 830, Name: WriteBits
        -- upvalues: u100 (ref), u2 (ref), u101 (ref), u102 (ref), u99 (ref), u103 (ref), u1 (ref)
        u100 = u100 + p105 * u2[u101];
        u101 = u101 + p106;
        u102 = u102 + p106;

        if u101 >= 32 then
            u99 = u99 + 1;
            u103[u99] = u1[u100 % 256] .. u1[(u100 - u100 % 256) / 256 % 256] .. u1[(u100 - u100 % 65536) / 65536 % 256] .. u1[(u100 - u100 % 16777216) / 16777216 % 256];
            local v107 = u2[32 - u101 + p106];
            u100 = (p105 - p105 % v107) / v107;
            u101 = u101 - 32;
        end;
    end, function(p108: string) -- Line: 850, Name: WriteString
        -- upvalues: u101 (ref), u99 (ref), u103 (ref), u100 (ref), string_char (ref), u102 (ref)
        for i = 1, u101, 8 do
            u99 = u99 + 1;
            u103[u99] = string_char(u100 % 256);
            u100 = (u100 - u100 % 256) / 256;
            local _ = i;
        end;

        u101 = 0;
        u99 = u99 + 1;
        u103[u99] = p108;
        u102 = u102 + #p108 * 8;
    end, function(p109: number) -- Line: 869, Name: FlushWriter
        -- upvalues: u102 (ref), u101 (ref), u100 (ref), u2 (ref), u99 (ref), u103 (ref), u1 (ref), table_concat (ref), u104 (copy)
        if p109 == 3 then
            return u102, nil;
        end;

        if p109 == 1 or p109 == 2 then
            local v110 = (8 - u101 % 8) % 8;

            if u101 > 0 then
                u100 = u100 - u2[u101] + u2[u101 + v110];

                for i = 1, u101, 8 do
                    u99 = u99 + 1;
                    u103[u99] = u1[u100 % 256];
                    u100 = (u100 - u100 % 256) / 256;
                    local _ = i;
                end;

                u100 = 0;
                u101 = 0;
            end;

            if p109 == 2 then
                u102 = u102 + v110;

                return u102, nil;
            end;
        end;

        local v111 = table_concat(u103);
        u103 = {};
        u99 = 0;
        u104[#u104 + 1] = v111;

        if p109 == 0 then
            return u102, nil;
        end;

        return u102, table_concat(u104);
    end;
end;

local function MinHeapPush(p112: table, p113: table, p114: number) -- Line: 922
    local v115 = p114 + 1;
    p112[v115] = p113;
    local v116 = (v115 - v115 % 2) / 2;

    while v116 >= 1 and p113[1] < p112[v116][1] do
        local v117 = p112[v116];
        p112[v116] = p113;
        p112[v115] = v117;
        v115 = v116;
        v116 = (v116 - v116 % 2) / 2;
    end;
end;

local function MinHeapPop(p118: table, p119: number) -- Line: 943
    local v120 = p118[1];
    local v121 = p118[p119];
    local v122 = v121[1];
    p118[1] = v121;
    p118[p119] = v120;
    local v123 = p119 - 1;
    local v124 = 1;
    local v125 = v124 * 2;
    local v126 = v125 + 1;

    while v125 <= v123 do
        local v127 = p118[v125];
        local v128;

        if v126 <= v123 and p118[v126][1] < v127[1] then
            local v129 = p118[v126];

            if v129[1] >= v122 then
                break;
            end;

            p118[v126] = v121;
            p118[v124] = v129;
            v128 = v126 * 2;
            v125 = v126;
            v126 = v128 + 1;
        else
            if v127[1] >= v122 then
                break;
            end;

            p118[v125] = v121;
            p118[v124] = v127;
            v128 = v125 * 2;
            v126 = v128 + 1;
        end;

        v124 = v125;
        v125 = v128;
    end;

    return v120;
end;

local function GetHuffmanCodeFromBitlen(p130: table, p131: table, p132: number, p133: number) -- Line: 992
    -- upvalues: u3 (copy)
    local v134 = 0;
    local v135 = {};
    local v136 = {};

    for i = 1, p133 do
        v134 = (v134 + (p130[i - 1] or 0)) * 2;
        v135[i] = v134;
        local _ = i;
    end;

    for i = 0, p132 do
        local v137 = p131[i];
        local v138;

        if v137 then
            local v139 = v135[v137];
            v135[v137] = v139 + 1;

            if v137 <= 9 then
                v136[i] = u3[v137][v139];
                v138 = i;
            else
                v138 = i;
                local v140 = 0;

                for i2 = 1, v137 do
                    local v141 = v140 - v140 % 2 + ((v140 % 2 == 1 or v139 % 2 == 1) and 1 or 0);
                    v139 = (v139 - v139 % 2) / 2;
                    v140 = v141 * 2;
                    local _ = i2;
                end;

                v136[v138] = (v140 - v140 % 2) / 2;
            end;
        else
            v138 = i;
        end;
    end;

    return v136;
end;

local function SortByFirstThenSecond(p142: table, p143: table) -- Line: 1034
    local v144;

    if p142[1] < p143[1] then
        v144 = true;
    elseif p142[1] == p143[1] then
        v144 = p142[2] < p143[2];
    else
        v144 = false;
    end;

    return v144;
end;

local function GetHuffmanBitlenAndCode(p145: table, p146: number, p147: number) -- Line: 1049
    -- upvalues: table_sort (copy), SortByFirstThenSecond (copy), MinHeapPop (copy), MinHeapPush (copy), GetHuffmanCodeFromBitlen (copy)
    local v148 = 0;
    local v149 = {};
    local v150 = {};
    local v151 = {};
    local v152 = -1;
    local v153 = {};
    local v154 = {};

    for i, v in pairs(p145) do
        v148 = v148 + 1;
        v149[v148] = { v, i };
    end;

    if v148 == 0 then
        return {}, {}, -1;
    end;

    if v148 == 1 then
        local v155 = v149[1][2];
        v151[v155] = 1;
        v154[v155] = 0;

        return v151, v154, v155;
    end;

    table_sort(v149, SortByFirstThenSecond);

    for i = 1, v148 do
        v150[i] = v149[i];
        local _ = i;
    end;

    while v148 > 1 do
        local v156 = MinHeapPop(v150, v148);
        local v157 = v148 - 1;
        local v158 = MinHeapPop(v150, v157);
        local v159 = v157 - 1;
        MinHeapPush(v150, {
            v156[1] + v158[1],
            -1,
            v156,
            v158
        }, v159);
        v148 = v159 + 1;
    end;

    local v160 = {
        v150[1],
        {},
        {},
        {}
    };
    v150[1][1] = 0;
    local v161 = 1;
    local v162 = 1;
    local v163 = 0;

    while v161 <= v162 do
        local v164 = v160[v161];
        local v165 = v164[1];
        local v166 = v164[2];
        local v167 = v164[3];
        local v168 = v164[4];

        if v167 then
            v162 = v162 + 1;
            v160[v162] = v167;
            v167[1] = v165 + 1;
        end;

        if v168 then
            v162 = v162 + 1;
            v160[v162] = v168;
            v168[1] = v165 + 1;
        end;

        v161 = v161 + 1;

        if p146 < v165 then
            v163 = v163 + 1;
            v165 = p146;
        end;

        if v166 >= 0 then
            v151[v166] = v165;

            if v152 < v166 then
                v152 = v166 or v152;
            end;

            v153[v165] = (v153[v165] or 0) + 1;
        end;
    end;

    if v163 > 0 then
        repeat
            local v169 = p146 - 1;

            while (v153[v169] or 0) == 0 do
                v169 = v169 - 1;
            end;

            v153[v169] = v153[v169] - 1;
            v153[v169 + 1] = (v153[v169 + 1] or 0) + 2;
            v153[p146] = v153[p146] - 1;
            v163 = v163 - 2;
        until v163 <= 0;

        local v170 = 1;

        for i = p146, 1, -1 do
            local v171 = v153[i] or 0;
            local v172 = i;

            while v171 > 0 do
                v151[v149[v170][2]] = v172;
                v171 = v171 - 1;
                v170 = v170 + 1;
            end;
        end;
    end;

    return v151, GetHuffmanCodeFromBitlen(v153, v151, p147, p146), v152;
end;

local function RunLengthEncodeHuffmanBitlen(p173: table, p174: number, p175: table, p176: number) -- Line: 1187
    local v177 = p174 + (p176 < 0 and 0 or p176) + 1;
    local v178 = 0;
    local v179 = {};
    local v180 = 0;
    local v181 = {};
    local v182 = nil;
    local v183 = 0;
    local v184 = {};

    for i = 0, v177 + 1 do
        local v185;

        if i <= p174 then
            v185 = p173[i] or 0;
        else
            v185 = i <= v177 and (p175[i - p174 - 1] or 0) or nil;
        end;

        local v186;

        if v185 == v182 then
            v178 = v178 + 1;

            if v185 == 0 or v178 ~= 6 then
                if v185 == 0 and v178 == 138 then
                    v183 = v183 + 1;
                    v179[v183] = 18;
                    v180 = v180 + 1;
                    v184[v180] = 127;
                    v181[18] = (v181[18] or 0) + 1;
                    v186 = i;
                    v178 = 0;
                else
                    v186 = i;
                end;
            else
                v183 = v183 + 1;
                v179[v183] = 16;
                v180 = v180 + 1;
                v184[v180] = 3;
                v181[16] = (v181[16] or 0) + 1;
                v186 = i;
                v178 = 0;
            end;
        else
            if v178 == 1 then
                assert(v182);
                v183 = v183 + 1;
                v179[v183] = v182;
                v181[v182] = (v181[v182] or 0) + 1;
            elseif v178 == 2 then
                assert(v182);
                local v187 = v183 + 1;
                v179[v187] = v182;
                v183 = v187 + 1;
                v179[v183] = v182;
                v181[v182] = (v181[v182] or 0) + 2;
            elseif v178 >= 3 then
                v183 = v183 + 1;
                local v188 = v182 == 0 and (v178 <= 10 and 17 or 18) or 16;
                v179[v183] = v188;
                v181[v188] = (v181[v188] or 0) + 1;
                v180 = v180 + 1;
                v184[v180] = v178 <= 10 and v178 - 3 or v178 - 11;
            end;

            if v185 and v185 ~= 0 then
                v183 = v183 + 1;
                v179[v183] = v185;
                v181[v185] = (v181[v185] or 0) + 1;
                v182 = v185;
                v186 = i;
                v178 = 0;
            else
                v182 = v185;
                v186 = i;
                v178 = 1;
            end;
        end;
    end;

    return v179, v184, v181;
end;

local function LoadStringToTable(p189: string, p190: any, p191: number, p192: number, p193: number) -- Line: 1272
    -- upvalues: string_byte (copy)
    local v194 = p191 - p193;

    while v194 <= p192 - 15 - p193 do
        local v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209, v210 = string_byte(p189, v194 + p193, v194 + 15 + p193);
        p190[v194] = v195;
        p190[v194 + 1] = v196;
        p190[v194 + 2] = v197;
        p190[v194 + 3] = v198;
        p190[v194 + 4] = v199;
        p190[v194 + 5] = v200;
        p190[v194 + 6] = v201;
        p190[v194 + 7] = v202;
        p190[v194 + 8] = v203;
        p190[v194 + 9] = v204;
        p190[v194 + 10] = v205;
        p190[v194 + 11] = v206;
        p190[v194 + 12] = v207;
        p190[v194 + 13] = v208;
        p190[v194 + 14] = v209;
        p190[v194 + 15] = v210;
        v194 = v194 + 16;
    end;

    while v194 <= p192 - p193 do
        p190[v194] = string_byte(p189, v194 + p193, v194 + p193);
        v194 = v194 + 1;
    end;

    return p190;
end;

local function GetBlockLZ77Result(p211: number, p212: table, p213: table, p214: number, p215: number, p216: number, p217: table?) -- Line: 1328
    -- upvalues: u90 (copy), u5 (copy), u6 (copy), u7 (copy), u9 (copy), u8 (copy), u4 (copy)
    local v218 = u90[p211];
    local v219 = v218[1];
    local v220 = v218[2];
    local v221 = v218[3];
    local v222 = v218[4];
    local v223 = v218[5];
    local v224 = (v219 or not v221) and 2147483646 or v221;
    local v225 = v223 - v223 % 4 / 4;
    local v226, v227, v228;

    if p217 then
        v226 = p217.hash_tables;
        v227 = p217.string_table;
        v228 = p217.strlen;
        assert(p214 == 1);

        if p214 <= p215 and v228 >= 2 then
            local v229 = v227[v228 - 1] * 65536 + v227[v228] * 256 + p212[1];
            local v230 = p213[v229];

            if not v230 then
                v230 = {};
                p213[v229] = v230;
            end;

            v230[#v230 + 1] = -1;
        end;

        if p214 + 1 <= p215 and v228 >= 1 then
            local v231 = v227[v228] * 65536 + p212[1] * 256 + p212[2];
            local v232 = p213[v231];

            if not v232 then
                v232 = {};
                p213[v231] = v232;
            end;

            v232[#v232 + 1] = 0;
        end;
    else
        v228 = 0;
        v226 = {};
        v227 = {};
    end;

    local v233 = v228 + 3;
    local v234 = (p212[p214 - p216] or 0) * 256 + (p212[p214 + 1 - p216] or 0);
    local v235 = p215 + (v219 and 1 or 0);
    local v236 = 0;
    local v237 = 0;
    local v238 = {};
    local v239 = {};
    local v240 = false;
    local v241 = 0;
    local v242 = {};
    local v243 = {};
    local v244 = 0;
    local v245 = {};
    local v246 = 0;
    local v247 = 0;
    local v248 = {};

    while true do
        if p214 > v235 then
            v243[v246 + 1] = 256;
            v239[256] = (v239[256] or 0) + 1;

            return v243, v242, v239, v248, v238, v245;
        end;

        local v249 = p214 - p216;
        local v250 = p216 - 3;
        local v251 = 0;
        v234 = (v234 * 256 + (p212[v249 + 2] or 0)) % 16777216;
        local v252 = nil;
        local v253 = p213[v234];
        local v254, v255;

        if v253 then
            v254 = #v253;
            v252 = v253;
            v255 = v254;
        else
            v254 = 0;
            v253 = {};
            p213[v234] = v253;

            if v226 then
                v252 = v226[v234];
                v255 = v252 and (#v252 or 0) or 0;
            else
                v255 = 0;
            end;
        end;

        if p214 <= p215 then
            v253[v254 + 1] = p214;
        end;

        local v256, v257;

        if v255 > 0 and (p214 + 2 <= p215 and (not v219 or v236 < v221)) then
            local v258;

            if v219 and (v220 <= v236 and v225) then
                v258 = v225;
            else
                v258 = v223;
            end;

            local v259 = p215 - p214;
            local v260 = (v259 >= 257 and 257 or v259) + v249;
            local v261 = v249 + 3;
            v256 = v237;

            while true do
                if v255 < 1 or v258 <= 0 then
                    v257 = v251;
                    break;
                end;

                local v262 = v252[v255];

                if p214 - v262 > 32768 then
                    v257 = v251;
                    break;
                end;

                local v263;

                if v262 < p214 then
                    if v262 >= -257 then
                        local v264 = v262 - v250;
                        v263 = v261;

                        while v261 <= v260 and p212[v264] == p212[v261] do
                            v261 = v261 + 1;
                            v264 = v264 + 1;
                        end;
                    else
                        local v265 = v233 + v262;
                        v263 = v261;

                        while v261 <= v260 and v227[v265] == p212[v261] do
                            v261 = v261 + 1;
                            v265 = v265 + 1;
                        end;
                    end;

                    v257 = v261 - v249;

                    if v251 < v257 then
                        v256 = p214 - v262;
                    else
                        v257 = v251;
                    end;

                    if v222 <= v257 then
                        break;
                    end;
                else
                    v263 = v261;
                    v257 = v251;
                end;

                v255 = v255 - 1;
                v258 = v258 - 1;

                if v255 == 0 and (v262 > 0 and v226) then
                    v252 = v226[v234];
                    v255 = v252 and (#v252 or 0) or 0;
                end;

                v261 = v263;
                v251 = v257;
            end;
        else
            v256 = v237;
            v257 = v251;
        end;

        if not v219 then
            v236 = v257;
            v237 = v256;
        end;

        if (not v219 or v240) and ((v236 > 3 or v236 == 3 and v237 < 4096) and v257 <= v236) then
            local v266 = u5[v236];
            local v267 = u6[v236];
            local v268, v269, v270;

            if v237 <= 256 then
                v268 = u7[v237];
                v269 = u9[v237];
                v270 = u8[v237];
            else
                v270 = 7;
                local v271 = 384;
                local v272 = 512;
                v268 = 16;

                while true do
                    if v237 <= v271 then
                        v269 = (v237 - v272 / 2 - 1) % (v272 / 4);
                    end;

                    if v237 <= v272 then
                        v269 = (v237 - v272 / 2 - 1) % (v272 / 4);
                        v268 = v268 + 1;
                    end;

                    v268 = v268 + 2;
                    v270 = v270 + 1;
                    v271 = v271 * 2;
                    v272 = v272 * 2;
                end;
            end;

            v246 = v246 + 1;
            v243[v246] = v266;
            v239[v266] = (v239[v266] or 0) + 1;
            v244 = v244 + 1;
            v248[v244] = v268;
            v245[v268] = (v245[v268] or 0) + 1;

            if v267 > 0 then
                v241 = v241 + 1;
                v242[v241] = u4[v236];
            end;

            if v270 > 0 then
                v247 = v247 + 1;
                v238[v247] = v269;
            end;

            for i = p214 + 1, p214 + v236 - (v219 and 2 or 1) do
                v234 = (v234 * 256 + (p212[i - p216 + 2] or 0)) % 16777216;
                local v273;

                if v236 <= v224 then
                    local v274 = p213[v234];

                    if not v274 then
                        v274 = {};
                        p213[v234] = v274;
                    end;

                    v274[#v274 + 1] = i;
                    v273 = i;
                else
                    v273 = i;
                end;
            end;

            p214 = p214 + v236 - (v219 and 1 or 0);
            v240 = false;
        elseif v219 and not v240 then
            p214 = p214 + 1;
            v240 = true;
        else
            if v219 then
                v249 = v249 - 1 or v249;
            end;

            local v275 = p212[v249];
            v246 = v246 + 1;
            v243[v246] = v275;
            v239[v275] = (v239[v275] or 0) + 1;
            p214 = p214 + 1;
        end;

        v237 = v256;
        v236 = v257;
    end;
end;

local function GetBlockDynamicHuffmanHeader(p276: table, p277: table) -- Line: 1582
    -- upvalues: GetHuffmanBitlenAndCode (copy), RunLengthEncodeHuffmanBitlen (copy), u14 (copy)
    local v278, v279, v280 = GetHuffmanBitlenAndCode(p276, 15, 285);
    local v281, v282, v283 = GetHuffmanBitlenAndCode(p277, 15, 29);
    local v284, v285, v286 = RunLengthEncodeHuffmanBitlen(v278, v280, v281, v283);
    local v287, v288 = GetHuffmanBitlenAndCode(v286, 7, 18);
    local v289 = 0;

    for i = 1, 19 do
        local v290;

        if (v287[u14[i]] or 0) == 0 then
            v290 = i;
        else
            v289 = i;
            v290 = v289;
            local v291 = v289;
            v289 = v290;
            v291 = v290;
        end;
    end;

    local v292 = v283 + 1 - 1;

    return v280 + 1 - 257, v292 < 0 and 0 or v292, v289 - 4, v287, v288, v284, v285, v278, v279, v281, v282;
end;

local function GetDynamicHuffmanBlockSize(p293: table, p294: table, p295: number, p296: table, p297: table, p298: table, p299: table) -- Line: 1644
    -- upvalues: u15 (copy)
    local v300 = 17 + (p295 + 4) * 3;

    for i = 1, #p297 do
        local v301 = p297[i];
        v300 = v300 + p296[v301];
        local v302;

        if v301 >= 16 then
            v300 = v300 + (v301 == 16 and 2 or (v301 == 17 and 3 or 7));
            v302 = i;
        else
            v302 = i;
        end;
    end;

    local v303 = 0;

    for i = 1, #p293 do
        local v304 = p293[i];
        v300 = v300 + p298[v304];
        local v305;

        if v304 > 256 then
            v303 = v303 + 1;

            if v304 > 264 and v304 < 285 then
                v300 = v300 + u15[v304 - 256];
            end;

            local v306 = p294[v303];
            v300 = v300 + p299[v306];

            if v306 > 3 then
                v300 = v300 + ((v306 - v306 % 2) / 2 - 1);
                v305 = i;
            else
                v305 = i;
            end;
        else
            v305 = i;
        end;
    end;

    return v300;
end;

local function CompressDynamicHuffmanBlock(p307, p308, p309, p310, p311, p312, p313, p314, p315, p316, p317, p318, p319, p320, p321, p322, p323) -- Line: 1690
    -- upvalues: u14 (copy), u15 (copy)
    p307(p308 and 1 or 0, 1);
    p307(2, 2);
    p307(p313, 5);
    p307(p314, 5);
    p307(p315, 4);

    for i = 1, p315 + 4 do
        p307(p316[u14[i]] or 0, 3);
        local _ = i;
    end;

    local v324 = 1;

    for i = 1, #p318 do
        local v325 = p318[i];
        p307(p317[v325], p316[v325]);
        local v326;

        if v325 >= 16 then
            p307(p319[v324], v325 == 16 and 2 or (v325 == 17 and 3 or 7));
            v324 = v324 + 1;
            v326 = i;
        else
            v326 = i;
        end;
    end;

    local v327 = 0;
    local v328 = 0;
    local v329 = 0;

    for i = 1, #p309 do
        local v330 = p309[i];
        p307(p321[v330], p320[v330]);
        local v331;

        if v330 > 256 then
            v328 = v328 + 1;

            if v330 > 264 and v330 < 285 then
                v327 = v327 + 1;
                p307(p310[v327], u15[v330 - 256]);
            end;

            local v332 = p311[v328];
            p307(p323[v332], p322[v332]);

            if v332 > 3 then
                v329 = v329 + 1;
                p307(p312[v329], (v332 - v332 % 2) / 2 - 1);
                v331 = i;
            else
                v331 = i;
            end;
        else
            v331 = i;
        end;
    end;
end;

local function GetFixedHuffmanBlockSize(p333: table, p334: table) -- Line: 1771
    -- upvalues: u22 (ref), u15 (copy)
    local v335 = 3;
    local v336 = 0;

    for i = 1, #p333 do
        local v337 = p333[i];
        v335 = v335 + u22[v337];
        local v338;

        if v337 > 256 then
            v336 = v336 + 1;

            if v337 > 264 and v337 < 285 then
                v335 = v335 + u15[v337 - 256];
            end;

            local v339 = p334[v336];
            v335 = v335 + 5;

            if v339 > 3 then
                v335 = v335 + ((v339 - v339 % 2) / 2 - 1);
                v338 = i;
            else
                v338 = i;
            end;
        else
            v338 = i;
        end;
    end;

    return v335;
end;

local function CompressFixedHuffmanBlock(p340: function, p341: boolean, p342: table, p343: table, p344: table, p345: table) -- Line: 1799
    -- upvalues: u16 (ref), u22 (ref), u15 (copy), u10 (ref)
    p340(p341 and 1 or 0, 1);
    p340(1, 2);
    local v346 = 0;
    local v347 = 0;
    local v348 = 0;

    for i = 1, #p342 do
        local v349 = p342[i];
        p340(u16[v349], u22[v349]);
        local v350;

        if v349 > 256 then
            v346 = v346 + 1;

            if v349 > 264 and v349 < 285 then
                v347 = v347 + 1;
                p340(p343[v347], u15[v349 - 256]);
            end;

            local v351 = p344[v346];
            p340(u10[v351], 5);

            if v351 > 3 then
                v348 = v348 + 1;
                p340(p345[v348], (v351 - v351 % 2) / 2 - 1);
                v350 = i;
            else
                v350 = i;
            end;
        else
            v350 = i;
        end;
    end;
end;

local function GetStoreBlockSize(p352: number, p353: number, p354: number) -- Line: 1847
    assert(p353 - p352 + 1 <= 65535);

    return 3 + (8 - (p354 + 3) % 8) % 8 + 32 + (p353 - p352 + 1) * 8;
end;

local function CompressStoreBlock(p355: function, p356: function, p357: boolean, p358: string, p359: number, p360: number, p361: number) -- Line: 1861
    -- upvalues: u2 (copy)
    assert(p360 - p359 + 1 <= 65535);
    p355(p357 and 1 or 0, 1);
    p355(0, 2);
    local v362 = (8 - (p361 + 3) % 8) % 8;

    if v362 > 0 then
        p355(u2[v362] - 1, v362);
    end;

    local v363 = p360 - p359 + 1;
    p355(v363, 16);
    p355(255 - v363 % 256 + (255 - (v363 - v363 % 256) / 256) * 256, 16);
    p356(p358:sub(p359, p360));
end;

local function Deflate(p364: table?, p365: function, p366: function, p367: function, p368: string, p369: table?) -- Line: 1899
    -- upvalues: LoadStringToTable (copy), GetBlockLZ77Result (copy), GetBlockDynamicHuffmanHeader (copy), GetDynamicHuffmanBlockSize (copy), GetFixedHuffmanBlockSize (copy), CompressStoreBlock (copy), CompressFixedHuffmanBlock (copy), CompressDynamicHuffmanBlock (copy)
    local v370 = {};
    local v371 = {};
    local v372 = nil;
    local v373 = 0;
    local v374 = 0;
    local v375, _ = p367(3);
    local v376 = #p368;
    local v377 = nil;
    local v378 = nil;

    if p364 then
        if p364.level then
            v377 = p364.level;
        end;

        if p364.strategy then
            v378 = p364.strategy;
        end;
    end;

    if not v377 then
        if v376 < 2048 then
            v377 = 7;
        elseif v376 > 65536 then
            v377 = 3;
        else
            v377 = 5;
        end;
    end;

    while not v372 do
        local v379;

        if v373 == 0 then
            v373 = 1;
            v379 = 0;
            v374 = 65535;
        else
            v373 = v374 + 1;
            v374 = v374 + 32768;
            v379 = v373 - 32768 - 1;
        end;

        if v376 <= v374 then
            v374 = v376;
            v372 = true;
        else
            v372 = false;
        end;

        local v380, v381, v382, v383, v384, v385, v386, v387, v388, v389, v390, v391, v392, v393, v394, v395, v396;

        if v377 == 0 then
            v380 = nil;
            v381 = {};
            v382 = nil;
            v383 = {};
            v384 = nil;
            v385 = {};
            v386 = {};
            v387 = {};
            v388 = {};
            v389 = {};
            v390 = nil;
            v391 = {};
            v392 = {};
            v393 = nil;
            v394 = {};
            v395 = {};
            v396 = {};
        else
            LoadStringToTable(p368, v370, v373, v374 + 3, v379);

            if v373 == 1 and p369 then
                local string_table = p369.string_table;
                local strlen = p369.strlen;

                for i = 0, -strlen + 1 < -257 and -257 or -strlen + 1, -1 do
                    v370[i] = string_table[strlen + i];
                    local _ = i;
                end;
            end;

            local v397, v398;

            if v378 == "huffman_only" then
                v383 = {};
                LoadStringToTable(p368, v383, v373, v374, v373 - 1);
                v383[v374 - v373 + 2] = 256;
                v397 = {};
                v394 = {};

                for i = 1, v374 - v373 + 2 do
                    local v399 = v383[i];
                    v397[v399] = (v397[v399] or 0) + 1;
                    local _ = i;
                end;

                v391 = {};
                v398 = {};
                v386 = {};
            else
                v383, v394, v397, v391, v386, v398 = GetBlockLZ77Result(v377, v370, v371, v373, v374, v379, p369);
            end;

            v384, v393, v390, v389, v396, v385, v392, v387, v395, v388, v381 = GetBlockDynamicHuffmanHeader(v397, v398);
            v380 = GetDynamicHuffmanBlockSize(v383, v391, v390, v389, v385, v387, v388);
            v382 = GetFixedHuffmanBlockSize(v383, v391);
        end;

        assert(v374 - v373 + 1 <= 65535);
        local v400 = 3 + (8 - (v375 + 3) % 8) % 8 + 32 + (v374 - v373 + 1) * 8;
        local v401;

        if v382 and (v382 < v400 and v382) then
            v401 = v382;
        else
            v401 = v400;
        end;

        if v380 and (v380 < v401 and v380) then
            v401 = v380;
        end;

        if v377 == 0 or v378 ~= "fixed" and (v378 ~= "dynamic" and v400 == v401) then
            CompressStoreBlock(p365, p366, v372, p368, v373, v374, v375);
            v375 = v375 + v400;
        elseif v378 == "dynamic" or v378 ~= "fixed" and v382 ~= v401 then
            if v378 == "dynamic" or v380 == v401 then
                CompressDynamicHuffmanBlock(p365, v372, v383, v394, v391, v386, v384, v393, v390, v389, v396, v385, v392, v387, v395, v388, v381);
                v375 = v375 + assert(v380);
            end;
        else
            CompressFixedHuffmanBlock(p365, v372, v383, v394, v391, v386);
            v375 = v375 + assert(v382);
        end;

        local v402;

        if v372 then
            v402 = p367(3);
        else
            v402 = p367(0);
        end;

        assert(v402 == v375);

        if not v372 then
            if p369 and v373 == 1 then
                local v403 = 0;

                while v370[v403] do
                    v370[v403] = nil;
                    v403 = v403 - 1;
                end;
            end;

            local v404 = 1;
            p369 = nil;

            for i = v374 - 32767, v374 do
                v370[v404] = v370[i - v379];
                v404 = v404 + 1;
                local _ = i;
            end;

            for i, v in pairs(v371) do
                local v405 = #v;

                if v405 > 0 and v374 + 1 - v[1] > 32768 then
                    if v405 == 1 then
                        v371[i] = nil;
                    else
                        local v406 = v;
                        local v407 = 0;
                        local v408 = {};

                        for i2 = 2, v405 do
                            local v409 = v406[i2];
                            local v410;

                            if v374 + 1 - v409 <= 32768 then
                                v407 = v407 + 1;
                                v408[v407] = v409;
                                v410 = i2;
                            else
                                v410 = i2;
                            end;
                        end;

                        v371[i] = v408;
                    end;
                end;
            end;
        end;
    end;
end;

local function CompressDeflateInternal(p411: string, p412: table?, p413: table?) -- Line: 2123
    -- upvalues: CreateWriter (copy), Deflate (copy)
    local v414, v415, v416 = CreateWriter();
    Deflate(p413, v414, v415, v416, p411, p412);
    local v417, v418 = v416(1);
    assert(v418);

    return v418, (8 - v417 % 8) % 8;
end;

local function CompressZlibInternal(p419: string, p420: table?, p421: table?) -- Line: 2134
    -- upvalues: CreateWriter (copy), Deflate (copy), u13 (copy)
    local v422, v423, v424 = CreateWriter();
    v422(120, 8);
    local v425 = p420 and 1 or 0;
    local v426 = 128 + v425 * 32;
    v422(v426 + (31 - (30720 + v426) % 31), 8);

    if v425 == 1 then
        assert(p420);
        local adler32 = p420.adler32;
        local v427 = adler32 % 256;
        local v428 = (adler32 - v427) / 256;
        local v429 = v428 % 256;
        local v430 = (v428 - v429) / 256;
        local v431 = v430 % 256;
        v422((v430 - v431) / 256 % 256, 8);
        v422(v431, 8);
        v422(v429, 8);
        v422(v427, 8);
    end;

    Deflate(p421, v422, v423, v424, p419, p420);
    v424(2);
    local v432 = u13:Adler32(p419);
    local v433 = v432 % 256;
    local v434 = (v432 - v433) / 256;
    local v435 = v434 % 256;
    local v436 = (v434 - v435) / 256;
    local v437 = v436 % 256;
    v422((v436 - v437) / 256 % 256, 8);
    v422(v437, 8);
    v422(v435, 8);
    v422(v433, 8);
    local v438, v439 = v424(1);
    assert(v439);

    return v439, (8 - v438 % 8) % 8;
end;

function u13.CompressDeflate(p440, p441, p442) -- Line: 2205
    -- upvalues: IsValidArguments (copy), CompressDeflateInternal (copy)
    local v443, v444 = IsValidArguments(p441, false, nil, true, p442);

    if not v443 then
        error("Usage: LibDeflate:CompressDeflate(str, configs): " .. v444, 2);
    end;

    return CompressDeflateInternal(p441, nil, p442);
end;

function u13.CompressDeflateWithDict(p445, p446, p447, p448) -- Line: 2229
    -- upvalues: IsValidArguments (copy), CompressDeflateInternal (copy)
    local v449, v450 = IsValidArguments(p446, true, p447, true, p448);

    if not v449 then
        error("Usage: LibDeflate:CompressDeflateWithDict" .. "(str, dictionary, configs): " .. v450, 2);
    end;

    return CompressDeflateInternal(p446, p447, p448);
end;

function u13.CompressZlib(p451, p452, p453) -- Line: 2247
    -- upvalues: IsValidArguments (copy), CompressZlibInternal (copy)
    local v454, v455 = IsValidArguments(p452, false, nil, true, p453);

    if not v454 then
        error("Usage: LibDeflate:CompressZlib(str, configs): " .. v455, 2);
    end;

    return CompressZlibInternal(p452, nil, p453);
end;

function u13.CompressZlibWithDict(p456, p457, p458, p459) -- Line: 2268
    -- upvalues: IsValidArguments (copy), CompressZlibInternal (copy)
    local v460, v461 = IsValidArguments(p457, true, p458, true, p459);

    if not v460 then
        error("Usage: LibDeflate:CompressZlibWithDict" .. "(str, dictionary, configs): " .. v461, 2);
    end;

    return CompressZlibInternal(p457, p458, p459);
end;

local function CreateReader(u462: string) -- Line: 2296
    -- upvalues: u2 (copy), string_byte (copy), string_char (copy), string_sub (copy), u3 (copy)
    local u463 = #u462;
    local u464 = 1;
    local u465 = 0;
    local u466 = 0;

    return function(p467: number) -- Line: 2309, Name: ReadBits
        -- upvalues: u2 (ref), u465 (ref), u466 (ref), u462 (copy), u464 (ref), string_byte (ref)
        local v468 = u2[p467];

        if p467 <= u465 then
            local v469 = u466 % v468;
            u466 = (u466 - v469) / v468;
            u465 = u465 - p467;

            return v469;
        end;

        local v470 = u2[u465];
        local v471, v472, v473, v474 = string_byte(u462, u464, u464 + 3);
        u466 = u466 + ((v471 or 0) + (v472 or 0) * 256 + (v473 or 0) * 65536 + (v474 or 0) * 16777216) * v470;
        u464 = u464 + 4;
        u465 = u465 + 32 - p467;
        local v475 = u466 % v468;
        u466 = (u466 - v475) / v468;

        return v475;
    end, function(p476: number, p477: table, p478: number) -- Line: 2337, Name: ReadBytes
        -- upvalues: u465 (ref), u466 (ref), string_char (ref), u463 (copy), u464 (ref), u462 (copy), string_sub (ref)
        assert(u465 % 8 == 0);
        local v479;

        if u465 / 8 < p476 then
            v479 = u465 / 8 or p476;
        else
            v479 = p476;
        end;

        for i = 1, v479 do
            local v480 = u466 % 256;
            p478 = p478 + 1;
            p477[p478] = string_char(v480);
            u466 = (u466 - v480) / 256;
            local _ = i;
        end;

        u465 = u465 - v479 * 8;
        local v481 = p476 - v479;

        if (u463 - u464 - v481 + 1) * 8 + u465 < 0 then
            return -1;
        end;

        for i = u464, u464 + v481 - 1 do
            p478 = p478 + 1;
            p477[p478] = string_sub(u462, i, i);
            local _ = i;
        end;

        u464 = u464 + v481;

        return p478;
    end, function(p482: table, p483: table, p484: number) -- Line: 2372, Name: Decode
        -- upvalues: u465 (ref), u462 (copy), u2 (ref), u464 (ref), string_byte (ref), u466 (ref), u3 (ref)
        local v485, v486, v487;

        if p484 > 0 then
            if u465 < 15 and u462 then
                local v488 = u2[u465];
                local v489, v490, v491, v492 = string_byte(u462, u464, u464 + 3);
                u466 = u466 + ((v489 or 0) + (v490 or 0) * 256 + (v491 or 0) * 65536 + (v492 or 0) * 16777216) * v488;
                u464 = u464 + 4;
                u465 = u465 + 32;
            end;

            local v493 = u2[p484];
            u465 = u465 - p484;
            local v494 = u466 % v493;
            u466 = (u466 - v494) / v493;
            local v495 = u3[p484][v494];
            v485 = p482[p484];

            if v495 < v485 then
                return p483[v495];
            end;

            v486 = v485 * 2;
            v487 = v495 * 2;
        else
            v487 = 0;
            v486 = 0;
            v485 = 0;
        end;

        for i = p484 + 1, 15 do
            local v496 = u466 % 2;
            u466 = (u466 - v496) / 2;
            u465 = u465 - 1;

            if v496 == 1 then
                v487 = v487 + 1 - v487 % 2 or v487;
            end;

            local v497 = p482[i] or 0;
            local v498 = v487 - v486;

            if v498 < v497 then
                return p483[v485 + v498];
            end;

            v485 = v485 + v497;
            v486 = (v486 + v497) * 2;
            v487 = v487 * 2;
            local _ = i;
        end;

        return -10;
    end, function() -- Line: 2431, Name: ReaderBitlenLeft
        -- upvalues: u463 (copy), u464 (ref), u465 (ref)
        return (u463 - u464 + 1) * 8 + u465;
    end, function() -- Line: 2435, Name: SkipToByteBoundary
        -- upvalues: u465 (ref), u2 (ref), u466 (ref)
        local v499 = u465 % 8;
        local v500 = u2[v499];
        u465 = u465 - v499;
        u466 = (u466 - u466 % v500) / v500;
    end;
end;

local function CreateDecompressState(p501: string, p502: table?) -- Line: 2450
    -- upvalues: CreateReader (copy)
    local v503, v504, v505, v506, v507 = CreateReader(p501);

    return {
        buffer_size = 0,
        ReadBits = v503,
        ReadBytes = v504,
        Decode = v505,
        ReaderBitlenLeft = v506,
        SkipToByteBoundary = v507,
        buffer = {},
        result_buffer = {},
        dictionary = p502
    };
end;

local function GetHuffmanForDecode(p508: table, p509: number, p510: number) -- Line: 2475
    local v511 = p510;
    local v512 = {};

    for i = 0, p509 do
        local v513 = p508[i] or 0;

        if v513 > 0 and (v513 < p510 and v513) then
            p510 = v513;
        end;

        v512[v513] = (v512[v513] or 0) + 1;
        local _ = i;
    end;

    if v512[0] == p509 + 1 then
        return 0, v512, {}, 0;
    end;

    local v514 = 1;

    for i = 1, v511 do
        v514 = v514 * 2 - (v512[i] or 0);

        if v514 < 0 then
            return v514, {}, {}, 0;
        end;

        local _ = i;
    end;

    local v515 = { 0 };

    for i = 1, v511 - 1 do
        v515[i + 1] = v515[i] + (v512[i] or 0);
        local _ = i;
    end;

    local v516 = {};

    for i = 0, p509 do
        local v517 = p508[i] or 0;
        local v518;

        if v517 == 0 then
            v518 = i;
        else
            v516[v515[v517]] = i;
            v515[v517] = v515[v517] + 1;
            v518 = i;
        end;
    end;

    return v514, v512, v516, p510;
end;

local function DecodeUntilEndOfBlock(p519: table, p520: table, p521: table, p522: number, p523: table, p524: table, p525: number) -- Line: 2541
    -- upvalues: u1 (copy), u17 (copy), u15 (copy), u18 (copy), u19 (copy), table_concat (copy)
    local buffer = p519.buffer;
    local buffer_size = p519.buffer_size;
    local ReadBits = p519.ReadBits;
    local Decode = p519.Decode;
    local ReaderBitlenLeft = p519.ReaderBitlenLeft;
    local result_buffer = p519.result_buffer;
    local dictionary = p519.dictionary;
    local v526, v527, v528;

    if dictionary and not buffer[0] then
        v526 = dictionary.string_table;
        v527 = dictionary.strlen;
        v528 = -v527 + 1;

        for i = 0, -v527 + 1 < -257 and -257 or -v527 + 1, -1 do
            buffer[i] = u1[v526[v527 + i]];
            local _ = i;
        end;
    else
        v527 = nil;
        v526 = {};
        v528 = 1;
    end;

    while true do
        local v529 = Decode(p520, p521, p522);

        if v529 < 0 or v529 > 285 then
            break;
        end;

        if v529 < 256 then
            buffer_size = buffer_size + 1;
            buffer[buffer_size] = u1[v529];
        elseif v529 > 256 then
            local v530 = v529 - 256;
            local v531 = u17[v530];

            if v530 >= 8 then
                v531 = v531 + ReadBits(u15[v530]) or v531;
            end;

            v529 = Decode(p523, p524, p525);

            if v529 < 0 or v529 > 29 then
                return -10;
            end;

            local v532 = u18[v529];

            if v532 > 4 then
                v532 = v532 + ReadBits(u19[v529]) or v532;
            end;

            local v533 = buffer_size - v532 + 1;

            if v533 < v528 then
                return -11;
            end;

            if v533 >= -257 then
                for i = 1, v531 do
                    buffer_size = buffer_size + 1;
                    buffer[buffer_size] = buffer[v533];
                    v533 = v533 + 1;
                    local _ = i;
                end;
            else
                local v534 = v527 + v533;

                for i = 1, v531 do
                    buffer_size = buffer_size + 1;
                    buffer[buffer_size] = u1[v526[v534]];
                    v534 = v534 + 1;
                    local _ = i;
                end;
            end;
        end;

        if ReaderBitlenLeft() < 0 then
            return 2;
        end;

        if buffer_size >= 65536 then
            result_buffer[#result_buffer + 1] = table_concat(buffer, "", 1, 32768);

            for i = 32769, buffer_size do
                buffer[i - 32768] = buffer[i];
                local _ = i;
            end;

            buffer_size = buffer_size - 32768;
            buffer[buffer_size + 1] = nil;
        end;

        if v529 == 256 then
            p519.buffer_size = buffer_size;

            return 0;
        end;
    end;

    return -10;
end;

local function DecompressStoreBlock(p535: table) -- Line: 2634
    -- upvalues: table_concat (copy)
    local buffer = p535.buffer;
    local buffer_size = p535.buffer_size;
    local ReadBits = p535.ReadBits;
    local ReadBytes = p535.ReadBytes;
    local ReaderBitlenLeft = p535.ReaderBitlenLeft;
    local result_buffer = p535.result_buffer;
    p535.SkipToByteBoundary();
    local v536 = ReadBits(16);

    if ReaderBitlenLeft() < 0 then
        return 2;
    end;

    local v537 = ReadBits(16);

    if ReaderBitlenLeft() < 0 then
        return 2;
    end;

    if v536 % 256 + v537 % 256 ~= 255 then
        return -2;
    end;

    if (v536 - v536 % 256) / 256 + (v537 - v537 % 256) / 256 ~= 255 then
        return -2;
    end;

    local v538 = ReadBytes(v536, buffer, buffer_size);

    if v538 < 0 then
        return 2;
    end;

    if v538 >= 65536 then
        result_buffer[#result_buffer + 1] = table_concat(buffer, "", 1, 32768);

        for i = 32769, v538 do
            buffer[i - 32768] = buffer[i];
            local _ = i;
        end;

        v538 = v538 - 32768;
        buffer[v538 + 1] = nil;
    end;

    p535.buffer_size = v538;

    return 0;
end;

local function DecompressFixBlock(p539: table) -- Line: 2683
    -- upvalues: DecodeUntilEndOfBlock (copy), u20 (ref), u21 (ref), u11 (ref), u12 (ref)
    return DecodeUntilEndOfBlock(p539, u20, u21, 7, u11, u12, 5);
end;

local function DecompressDynamicBlock(p540: table) -- Line: 2698
    -- upvalues: u14 (copy), GetHuffmanForDecode (copy), DecodeUntilEndOfBlock (copy)
    local ReadBits = p540.ReadBits;
    local Decode = p540.Decode;
    local v541 = ReadBits(5) + 257;
    local v542 = ReadBits(5) + 1;
    local v543 = ReadBits(4) + 4;

    if v541 > 286 or v542 > 30 then
        return -3;
    end;

    local v544 = {};

    for i = 1, v543 do
        v544[u14[i]] = ReadBits(3);
        local _ = i;
    end;

    local v545, v546, v547, v548 = GetHuffmanForDecode(v544, 18, 7);

    if v545 ~= 0 then
        return -4;
    end;

    local v549 = 0;
    local v550 = {};
    local v551 = {};

    while v549 < v541 + v542 do
        local v552 = Decode(v546, v547, v548);

        if v552 < 0 then
            return v552;
        end;

        if v552 < 16 then
            if v549 < v541 then
                v550[v549] = v552;
            else
                v551[v549 - v541] = v552;
            end;

            v549 = v549 + 1;
        else
            local v553 = 0;
            local v554;

            if v552 == 16 then
                if v549 == 0 then
                    return -5;
                end;

                if v549 - 1 < v541 then
                    v553 = v550[v549 - 1];
                else
                    v553 = v551[v549 - v541 - 1];
                end;

                v554 = 3 + ReadBits(2);
            elseif v552 == 17 then
                v554 = 3 + ReadBits(3);
            else
                v554 = 11 + ReadBits(7);
            end;

            if v549 + v554 > v541 + v542 then
                return -6;
            end;

            while v554 > 0 do
                v554 = v554 - 1;

                if v549 < v541 then
                    v550[v549] = v553;
                else
                    v551[v549 - v541] = v553;
                end;

                v549 = v549 + 1;
            end;
        end;
    end;

    if (v550[256] or 0) == 0 then
        return -9;
    end;

    local v555, v556, v557, v558 = GetHuffmanForDecode(v550, v541 - 1, 15);

    if v555 ~= 0 and (v555 < 0 or v541 ~= (v556[0] or 0) + (v556[1] or 0)) then
        return -7;
    end;

    local v559, v560, v561, v562 = GetHuffmanForDecode(v551, v542 - 1, 15);

    return v559 ~= 0 and (v559 < 0 or v542 ~= (v560[0] or 0) + (v560[1] or 0)) and -8 or DecodeUntilEndOfBlock(p540, v556, v557, v558, v560, v561, v562);
end;

local function Inflate(p563: table) -- Line: 2818
    -- upvalues: DecompressStoreBlock (copy), DecodeUntilEndOfBlock (copy), u20 (ref), u21 (ref), u11 (ref), u12 (ref), DecompressDynamicBlock (copy), table_concat (copy)
    local ReadBits = p563.ReadBits;
    local v564 = nil;

    while not v564 do
        v564 = ReadBits(1) == 1;
        local v565 = ReadBits(2);
        local v566;

        if v565 == 0 then
            v566 = DecompressStoreBlock(p563);
        elseif v565 == 1 then
            v566 = DecodeUntilEndOfBlock(p563, u20, u21, 7, u11, u12, 5);
        else
            if v565 ~= 2 then
                return nil, -1;
            end;

            v566 = DecompressDynamicBlock(p563);
        end;

        if v566 ~= 0 then
            return nil, v566;
        end;
    end;

    p563.result_buffer[#p563.result_buffer + 1] = table_concat(p563.buffer, "", 1, p563.buffer_size);

    return table_concat(p563.result_buffer), 0;
end;

local function DecompressDeflateInternal(p567: string, p568: table?) -- Line: 2847
    -- upvalues: CreateDecompressState (copy), Inflate (copy)
    local v569 = CreateDecompressState(p567, p568);
    local v570, v571 = Inflate(v569);

    if not v570 then
        return nil, v571;
    end;

    local v572 = v569.ReaderBitlenLeft();

    return v570, (v572 - v572 % 8) / 8;
end;

local function DecompressZlibInternal(p573: string, p574: table?) -- Line: 2861
    -- upvalues: CreateDecompressState (copy), Inflate (copy), u13 (copy)
    local v575 = CreateDecompressState(p573, p574);
    local ReadBits = v575.ReadBits;
    local v576 = ReadBits(8);

    if v575.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;

    local v577 = v576 % 16;

    if v577 ~= 8 then
        return nil, -12;
    end;

    if (v576 - v577) / 16 > 7 then
        return nil, -13;
    end;

    local v578 = ReadBits(8);

    if v575.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;

    if (v576 * 256 + v578) % 31 ~= 0 then
        return nil, -14;
    end;

    local _ = (v578 - v578 % 64) / 64 % 4;

    if (v578 - v578 % 32) / 32 % 2 == 1 then
        if not p574 then
            return nil, -16;
        end;

        local v579 = ReadBits(8);
        local v580 = ReadBits(8);
        local v581 = ReadBits(8);
        local v582 = ReadBits(8);

        if v575.ReaderBitlenLeft() < 0 then
            return nil, 2;
        end;

        if (v579 * 16777216 + v580 * 65536 + v581 * 256 + v582) % 4294967296 ~= p574.adler32 % 4294967296 then
            return nil, -17;
        end;
    end;

    local v583, v584 = Inflate(v575);

    if not v583 then
        return nil, v584;
    end;

    v575.SkipToByteBoundary();
    local v585 = ReadBits(8);
    local v586 = ReadBits(8);
    local v587 = ReadBits(8);
    local v588 = ReadBits(8);

    if v575.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;

    local v589 = u13:Adler32(v583);

    if (v585 * 16777216 + v586 * 65536 + v587 * 256 + v588) % 4294967296 ~= v589 % 4294967296 then
        return nil, -15;
    end;

    local v590 = v575.ReaderBitlenLeft();

    return v583, (v590 - v590 % 8) / 8;
end;

function u13.DecompressDeflate(p591: table, p592: string) -- Line: 2943
    -- upvalues: DecompressDeflateInternal (copy)
    local v593, v594;

    if type(p592) == "string" then
        v593 = true;
        v594 = "";
    else
        v594 = ("\'str\' - string expected got \'%s\'."):format((type(p592)));
        v593 = false;
    end;

    if not v593 then
        error("Usage: LibDeflate:DecompressDeflate(str): " .. v594, 2);
    end;

    return DecompressDeflateInternal(p592);
end;

function u13.DecompressDeflateWithDict(p595: table, p596: string, p597: table) -- Line: 2969
    -- upvalues: IsValidDictionary (copy), DecompressDeflateInternal (copy)
    local v598, v599;

    if type(p596) == "string" then
        local v600;
        v600, v598 = IsValidDictionary(p597);

        if v600 then
            v599 = true;
            v598 = "";
        else
            v599 = false;
        end;
    else
        v598 = ("\'str\' - string expected got \'%s\'."):format((type(p596)));
        v599 = false;
    end;

    if not v599 then
        error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): " .. v598, 2);
    end;

    return DecompressDeflateInternal(p596, p597);
end;

function u13.DecompressZlib(p601: table, p602: string) -- Line: 2990
    -- upvalues: DecompressZlibInternal (copy)
    local v603, v604;

    if type(p602) == "string" then
        v603 = true;
        v604 = "";
    else
        v604 = ("\'str\' - string expected got \'%s\'."):format((type(p602)));
        v603 = false;
    end;

    if not v603 then
        error("Usage: LibDeflate:DecompressZlib(str): " .. v604, 2);
    end;

    return DecompressZlibInternal(p602);
end;

function u13.DecompressZlibWithDict(p605: table, p606: string, p607: table) -- Line: 3016
    -- upvalues: IsValidDictionary (copy), DecompressZlibInternal (copy)
    local v608, v609;

    if type(p606) == "string" then
        local v610;
        v610, v608 = IsValidDictionary(p607);

        if v610 then
            v609 = true;
            v608 = "";
        else
            v609 = false;
        end;
    else
        v608 = ("\'str\' - string expected got \'%s\'."):format((type(p606)));
        v609 = false;
    end;

    if not v609 then
        error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): " .. v608, 2);
    end;

    return DecompressZlibInternal(p606, p607);
end;

u22 = {};

for i = 0, 143 do
    u22[i] = 8;
    local _ = i;
end;

for i = 144, 255 do
    u22[i] = 9;
    local _ = i;
end;

u22[256] = 7;
u22[257] = 7;
u22[258] = 7;
u22[259] = 7;
u22[260] = 7;
u22[261] = 7;
u22[262] = 7;
u22[263] = 7;
u22[264] = 7;
u22[265] = 7;
u22[266] = 7;
u22[267] = 7;
u22[268] = 7;
u22[269] = 7;
u22[270] = 7;
u22[271] = 7;
u22[272] = 7;
u22[273] = 7;
u22[274] = 7;
u22[275] = 7;
u22[276] = 7;
u22[277] = 7;
u22[278] = 7;
u22[279] = 7;
u22[280] = 8;
u22[281] = 8;
u22[282] = 8;
u22[283] = 8;
u22[284] = 8;
u22[285] = 8;
u22[286] = 8;
u22[287] = 8;
local v611 = {};

for i = 0, 31 do
    v611[i] = 5;
    local _ = i;
end;

local v612, v613, v614 = GetHuffmanForDecode(u22, 287, 9);
u20 = v613;
u21 = v614;
assert(v612 == 0);
local v615, v616, v617 = GetHuffmanForDecode(v611, 31, 5);
u11 = v616;
u12 = v617;
assert(v615 == 0);
u16 = GetHuffmanCodeFromBitlen(u20, u22, 287, 9);
u10 = GetHuffmanCodeFromBitlen(u11, v611, 31, 5);
local u618 = {
    ["\0"] = "%z",
    ["("] = "%(",
    [")"] = "%)",
    ["."] = "%.",
    ["%"] = "%%",
    ["+"] = "%+",
    ["-"] = "%-",
    ["*"] = "%*",
    ["?"] = "%?",
    ["["] = "%[",
    ["]"] = "%]",
    ["^"] = "%^",
    ["$"] = "%$"
};

local function escape_for_gsub(p619: string) -- Line: 3084
    -- upvalues: u618 (copy)
    local v620, _ = p619:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);

    return v620;
end;

function u13.CreateCodec(p621: table, p622: string, p623: string, p624: string) -- Line: 3129
    -- upvalues: string_byte (copy), string_sub (copy), table_concat (copy), u618 (copy), u1 (copy), string_gsub (copy), string_find (copy)
    if type(p622) ~= "string" or (type(p623) ~= "string" or type(p624) ~= "string") then
        error(
            "Usage: LibDeflate:CreateCodec(reserved_chars, escape_chars, map_chars): All arguments must be string.",
            2
        );
    end;

    if p623 == "" then
        return nil, "No escape characters supplied.";
    end;

    if #p622 < #p624 then
        return nil, "The number of reserved characters must be at least as many as the number of mapped chars.";
    end;

    if p622 == "" then
        return nil, "No characters to encode.";
    end;

    local v625 = p622 .. p623 .. p624;
    local v626 = {};

    for i = 1, #v625 do
        local v627 = string_byte(v625, i, i);

        if v626[v627] then
            return nil, "There must be no duplicate characters in the concatenation of reserved_chars, escape_chars and map_chars.";
        end;

        v626[v627] = true;
        local _ = i;
    end;

    local u628 = {};
    local u629 = {};
    local v630 = {};
    local u631 = {};

    if #p624 > 0 then
        local v632 = {};
        local v633 = {};

        for i = 1, #p624 do
            local v634 = string_sub(p622, i, i);
            local v635 = string_sub(p624, i, i);
            u631[v634] = v635;
            v630[#v630 + 1] = v634;
            v632[v635] = v634;
            v633[#v633 + 1] = v635;
            local _ = i;
        end;

        local v636, _ = table_concat(v633):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
        u628[#u628 + 1] = "([" .. v636 .. "])";
        u629[#u629 + 1] = v632;
    end;

    local v637 = 1;
    local v638 = string_sub(p623, v637, v637);
    local v639 = 0;
    local v640 = {};
    local v641 = {};

    for i = 1, #v625 do
        local v642 = string_sub(v625, i, i);
        local v643;

        if u631[v642] then
            v643 = i;
        else
            v643 = i;

            while v639 >= 256 or v626[v639] do
                v639 = v639 + 1;

                if v639 > 255 then
                    local v644, _ = v638:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
                    local v645, _ = table_concat(v640):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
                    u628[#u628 + 1] = v644 .. "([" .. v645 .. "])";
                    u629[#u629 + 1] = v641;
                    v637 = v637 + 1;
                    v638 = string_sub(p623, v637, v637);

                    if not v638 or v638 == "" then
                        return nil, "Out of escape characters.";
                    end;

                    v639 = 0;
                    v640 = {};
                    v641 = {};
                end;
            end;

            local v646 = u1[v639];
            u631[v642] = v638 .. v646;
            v630[#v630 + 1] = v642;
            v641[v646] = v642;
            v640[#v640 + 1] = v646;
            v639 = v639 + 1;
        end;

        if v643 == #v625 then
            local v647, _ = v638:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
            local v648, _ = table_concat(v640):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
            u628[#u628 + 1] = v647 .. "([" .. v648 .. "])";
            u629[#u629 + 1] = v641;
        end;
    end;

    local v649 = {};
    local v650, _ = table_concat(v630):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
    local u651 = "([" .. v650 .. "])";

    function v649.Encode(p652: table, p653: string) -- Line: 3243
        -- upvalues: string_gsub (ref), u651 (copy), u631 (copy)
        if type(p653) ~= "string" then
            error(("Usage: codec:Encode(str): \'str\' - string expected got \'%s\'."):format((type(p653))), 2);
        end;

        local v654, _ = string_gsub(p653, u651, u631);

        return v654;
    end;

    local u655 = #u628;
    local v656, _ = p622:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u618);
    local u657 = "([" .. v656 .. "])";

    function v649.Decode(p658: table, p659: string) -- Line: 3254
        -- upvalues: string_find (ref), u657 (copy), u655 (copy), string_gsub (ref), u628 (copy), u629 (copy)
        if type(p659) ~= "string" then
            error(("Usage: codec:Decode(str): \'str\' - string expected got \'%s\'."):format((type(p659))), 2);
        end;

        if string_find(p659, u657) then
            return nil;
        end;

        for i = 1, u655 do
            p659 = string_gsub(p659, u628[i], u629[i]);
            local _ = i;
        end;

        return p659;
    end;

    return v649, "";
end;

u13.internals = {
    LoadStringToTable = LoadStringToTable,
    IsValidDictionary = IsValidDictionary,
    IsEqualAdler32 = IsEqualAdler32
};

return table.freeze(u13);