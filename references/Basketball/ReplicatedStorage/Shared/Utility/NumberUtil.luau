 
 

local u1 = {};
local utf8_char_ret = utf8.char(8734);
local u2 = { "k", "M", "B", "T", "Qd", "Qn", "Sx", "Sp" };
local u3 = { { "s", 1 }, { "m", 60 }, { "h", 3600 }, { "d", 86400 }, { "w", 604800 }, { "mo", 2592000 } };

local function GetTruncateLabel(p4) -- Line: 45
    -- upvalues: u2 (copy)
    return (p4 <= 0 or p4 > #u2) and "*" or u2[p4];
end;

function u1.FormatPercentage(p5) -- Line: 57
    return string.format("%3.2f", p5 * 100) .. "%";
end;

function u1.Round(p6, p7) -- Line: 64
    local v8 = p7 or 0;
    local v9 = 10 ^ v8;

    if v8 == 0 then
        return math.round(p6);
    end;

    return math.round(p6 * v9) / v9;
end;

function u1.TruncateNumber(p10, p11) -- Line: 76
    -- upvalues: utf8_char_ret (copy), u1 (copy), u2 (copy)
    if p10 == (1 / 0) then
        return utf8_char_ret;
    end;

    local v12 = p11 or 1;
    local v13 = 3;
    local v14 = p10 / 10 ^ v13;

    if v14 < 1 then
        local v15 = u1.Round(v14 * 1000, v12);

        return tostring(v15);
    end;

    local v16 = 0;

    while v14 >= 1 do
        local _ = math.floor(v16 / #u2) + 1;
        v13 = v13 + 3;
        v16 = v16 + 1;
        v14 = p10 / 10 ^ v13;
    end;

    local v17 = u1.Round(v14 * 1000, v12);
    local v18 = "";

    repeat
        local math_clamp_ret = math.clamp(v16, 1, 8);
        v18 = ((math_clamp_ret <= 0 or math_clamp_ret > #u2) and "*" or u2[math_clamp_ret]) .. v18;
        v16 = v16 - #u2;
    until v16 <= 0;

    return tostring(v17) .. v18;
end;

function u1.Clamp01(p19) -- Line: 118
    return math.clamp(p19, 0, 1);
end;

function u1.Lerp(p20, p21, p22) -- Line: 123
    return (p21 - p20) * p22 + p20;
end;

function u1.Map(p23, p24, p25, p26, p27) -- Line: 128
    return (p23 - p24) * (p27 - p26) / (p25 - p24) + p26;
end;

function u1.Map01(p28, p29, p30) -- Line: 133
    return (p28 - p29) / p30;
end;

function u1.WithCommas(p31, p32) -- Line: 138
    local math_abs_ret = math.abs(p31);
    local math_floor_ret = math.floor(math_abs_ret);
    local v33 = tostring(math_floor_ret);
    local v34 = p31 - math.floor(p31);
    local v35 = tostring(v34);
    local v36 = "";
    local v37 = 0;
    local v38 = p32 and "." or ",";
    local v39 = p32 and "," or ".";

    for i = #v33, 1, -1 do
        v36 = v33:sub(i, i) .. v36;
        v37 = v37 + 1;
        local v40;

        if v37 == 3 and i ~= 1 then
            v36 = v38 .. v36;
            v40 = i;
            v37 = 0;
        else
            v40 = i;
        end;
    end;

    if v35 ~= "0" and #v35 > 2 then
        v36 = v36 .. v39 .. v35:sub(3);
    end;

    if math.sign(p31) == -1 then
        v36 = "-" .. v36;
    end;

    return v36;
end;

function u1.SecondsToClock(p41, p42) -- Line: 168
    if p41 <= 0 then
        warn("Something called SecondsToClock with negative time!");
        p41 = math.abs(p41);
    end;

    local string_format_ret = string.format("%02.f", (math.floor(p41 / 3600)));
    local string_format_ret2 = string.format("%02.f", (math.floor(p41 / 60 - string_format_ret * 60)));
    local string_format_ret3 = string.format("%02.f", (math.floor(p41 - string_format_ret * 3600 - string_format_ret2 * 60)));

    if p42 then
        return string.format("%02.f", (math.floor(p41 / 60))) .. ":" .. string_format_ret3;
    end;

    if math.floor(p41 / 86400) > 0 then
        return string.format("%i", (math.floor(p41 / 86400))) .. ":" .. string.format("%02.f", (math.floor(p41 / 3600 % 24))) .. ":" .. string_format_ret2 .. ":" .. string_format_ret3;
    end;

    return string_format_ret .. ":" .. string_format_ret2 .. ":" .. string_format_ret3;
end;

function u1.AdaptiveClockString(p43: number, p44: boolean?, p45: number?) -- Line: 190
    -- upvalues: u3 (copy)
    local math_max_ret = math.max(p43, 0);

    if not ((not p44 or math_max_ret >= 60) and (p44 or math_max_ret > 1)) then
        return `{math.floor(math_max_ret)}s`;
    end;

    local v46 = "";
    local v47 = false;
    local v48 = 0;
    local v49 = 1;

    for i = #u3, 1, -1 do
        local v50 = u3[i];
        local v51 = v50[1];
        local v52 = v50[2];
        local v53;

        if v52 <= math_max_ret or (v47 or i <= v49) then
            v47 = true;
            local math_floor_ret = math.floor(math_max_ret / v52);
            math_max_ret = math_max_ret % v52;

            if math_floor_ret > 0 then
                if p44 then
                    v46 = v46 .. string.format("%02.f", math_floor_ret) .. ":";
                else
                    v46 = v46 .. math_floor_ret .. v51 .. " ";
                end;
            end;

            v48 = v48 + 1;

            if v48 >= 3 then
                break;
            end;

            v53 = i;
        else
            v53 = i;
        end;
    end;

    return v46:sub(1, -2);
end;

return u1;