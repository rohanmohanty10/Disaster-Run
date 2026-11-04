  

local u1 = {};
local u2 = bit32 and bit32.extract;

function u1.makeencoder(p3, p4, p5) -- Line: 29
    local v6 = {};

    for i, v in pairs({
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        p3 or "+",
        p4 or "/",
        p5 or "="
    }) do
        v6[i] = v:byte();
    end;

    return v6;
end;

function u1.makedecoder(p7, p8, p9) -- Line: 41
    -- upvalues: u1 (copy)
    local v10 = {};

    for i, v in pairs(u1.makeencoder(p7, p8, p9)) do
        v10[v] = i;
    end;

    return v10;
end;

local u11 = u1.makeencoder();
local u12 = u1.makedecoder();
local string_char = string.char;
local table_concat = table.concat;

function u1.encode(p13, p14, p15) -- Line: 54
    -- upvalues: u11 (copy), u2 (copy), string_char (copy), table_concat (copy)
    local v16 = p14 or u11;
    local v17 = #p13;
    local v18 = v17 % 3;
    local v19 = {};
    local v20 = {};
    local v21 = 1;

    for i = 1, v17 - v18, 3 do
        local v22, v23, v24 = p13:byte(i, i + 2);
        local v25 = v22 * 65536 + v23 * 256 + v24;
        local v26;

        if p15 then
            v26 = v19[v25];

            if not v26 then
                v26 = string_char(v16[u2(v25, 18, 6)], v16[u2(v25, 12, 6)], v16[u2(v25, 6, 6)], v16[u2(v25, 0, 6)]);
                v19[v25] = v26;
            end;
        else
            v26 = string_char(v16[u2(v25, 18, 6)], v16[u2(v25, 12, 6)], v16[u2(v25, 6, 6)], v16[u2(v25, 0, 6)]);
        end;

        v20[v21] = v26;
        v21 = v21 + 1;
        local _ = i;
    end;

    if v18 == 2 then
        local v27, v28 = p13:byte(v17 - 1, v17);
        local v29 = v27 * 65536 + v28 * 256;
        v20[v21] = string_char(v16[u2(v29, 18, 6)], v16[u2(v29, 12, 6)], v16[u2(v29, 6, 6)], v16[64]);
    elseif v18 == 1 then
        local v30 = p13:byte(v17) * 65536;
        v20[v21] = string_char(v16[u2(v30, 18, 6)], v16[u2(v30, 12, 6)], v16[64], v16[64]);
    end;

    return table_concat(v20);
end;

function u1.decode(p31, p32, p33) -- Line: 86
    -- upvalues: u12 (copy), string_char (copy), u2 (copy), table_concat (copy)
    local v34 = p32 or u12;
    local v35;

    if v34 then
        local v36 = nil;
        local v37 = nil;

        for i, v in pairs(v34) do
            if v == 62 then
                v36 = i;
            elseif v == 63 then
                v37 = i;
            end;
        end;

        v35 = ("[^%%w%%%s%%%s%%=]"):format(string_char(v36), (string_char(v37)));
    else
        v35 = "[^%w%+%/%=]";
    end;

    local v38 = p31:gsub(v35, "");
    local v39 = p33 and {};
    local v40 = {};
    local v41 = 1;
    local v42 = #v38;
    local v43 = v38:sub(-2) == "==" and 2 or (v38:sub(-1) == "=" and 1 or 0);
    local v44;

    if v43 > 0 then
        v44 = v42 - 4 or v42;
    else
        v44 = v42;
    end;

    for i = 1, v44, 4 do
        local v45, v46, v47, v48 = v38:byte(i, i + 3);
        local v49;

        if p33 then
            local v50 = v45 * 16777216 + v46 * 65536 + v47 * 256 + v48;
            v49 = v39[v50];

            if not v49 then
                local v51 = v34[v45] * 262144 + v34[v46] * 4096 + v34[v47] * 64 + v34[v48];
                v49 = string_char(u2(v51, 16, 8), u2(v51, 8, 8), u2(v51, 0, 8));
                v39[v50] = v49;
            end;
        else
            local v52 = v34[v45] * 262144 + v34[v46] * 4096 + v34[v47] * 64 + v34[v48];
            v49 = string_char(u2(v52, 16, 8), u2(v52, 8, 8), u2(v52, 0, 8));
        end;

        v40[v41] = v49;
        v41 = v41 + 1;
        local _ = i;
    end;

    if v43 == 1 then
        local v53, v54, v55 = v38:byte(v42 - 3, v42 - 1);
        local v56 = v34[v53] * 262144 + v34[v54] * 4096 + v34[v55] * 64;
        v40[v41] = string_char(u2(v56, 16, 8), u2(v56, 8, 8));
    elseif v43 == 2 then
        local v57, v58 = v38:byte(v42 - 3, v42 - 2);
        v40[v41] = string_char(u2(v34[v57] * 262144 + v34[v58] * 4096, 16, 8));
    end;

    return table_concat(v40);
end;

return u1;