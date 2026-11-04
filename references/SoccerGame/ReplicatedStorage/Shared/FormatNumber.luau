  

local u1 = { "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc", "Ud", "Dd", "Td", "Qad", "Qid", "Sxd", "Spd", "Od", "Nd", "V", "Uv", "Dv", "Tv", "Qav", "Qiv", "Sxv", "Spv", "Ov", "Nv", "Tt" };
local u2 = { { 100, "C" }, { 90, "XC" }, { 50, "L" }, { 40, "XL" }, { 10, "X" }, { 9, "IX" }, { 5, "V" }, { 4, "IV" }, { 1, "I" } };
local u3 = { { "s", 1 }, { "m", 60 }, { "h", 3600 }, { "d", 86400 }, { "w", 604800 }, { "mo", 2592000 } };
local u9 = {
    Percent = function(p4, p5) -- Line: 58, Name: Percent
        local v6 = 10 ^ (p5 or 0);

        return `{math.floor(p4 * 100 * v6) / v6}%`;
    end,

    Commas = function(p7) -- Line: 63, Name: Commas
        local v8 = tostring(p7);

        if #v8 <= 3 then
            return v8;
        end;

        return v8:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end
};
local u10 = {};

function u9.RomanNumerals(p11) -- Line: 72
    -- upvalues: u10 (copy), u2 (copy)
    local math_floor_ret = math.floor(p11);

    if u10[math_floor_ret] then
        return u10[math_floor_ret];
    end;

    local v12 = "";

    while true do
        if math_floor_ret <= 0 then
            if math_floor_ret < 100 then
                u10[math_floor_ret] = v12;
            end;

            return v12;
        end;

        for i = 1, #u2 do
            local v13, v14 = unpack(u2[i]);

            if v13 <= math_floor_ret then
                v12 = v12 .. v14;
                math_floor_ret = math_floor_ret - v13;
                break;
            end;

            local _ = i;
        end;
    end;
end;

function u9.ShortClockString(p15, p16) -- Line: 102
    -- upvalues: u3 (copy)
    local v17 = 1;
    local v18 = "s";

    for _, v in u3 do
        local v19 = v[2];

        if v19 < p15 and v17 < v19 then
            v18 = v[1];
            v17 = v19;
        end;
    end;

    local v20 = "";

    if p16 and table.find(p16, v18) then
        local math_floor_ret = math.floor(p15 % v17 / v17 * 10);

        if math_floor_ret > 0 then
            v20 = "." .. math_floor_ret;
        end;
    end;

    return `{math.floor(p15 / v17)}{v20}{v18}`;
end;

function u9.Chance(p21) -- Line: 127
    -- upvalues: u9 (copy)
    if p21 > 10 then
        return u9.DecimalPlaces(p21, 1) .. "%";
    end;

    if p21 > 1 then
        return u9.DecimalPlaces(p21, 1) .. "%";
    end;

    local v22, v23 = u9.SigFigs(p21, 1):match("(.+)e(.+)");

    if not (v22 and v23) then
        return u9.SigFigs(p21, 1) .. "%";
    end;

    local v24 = tonumber(v23);
    local v25 = string.format("%.2f", v22) * 100;

    return (`0.{string.rep("0", (math.abs(v24)))}{string.format(v25)}`):gsub("([0%.]+)$", "") .. "%";
end;

function u9.LongClockString(p26) -- Line: 153
    local v27 = tonumber(p26) or 0;

    if v27 <= 0 then
        return "0D 0H 0M";
    end;

    local math_floor_ret = math.floor(v27 / 86400);
    local v28 = v27 % 86400;
    local math_floor_ret2 = math.floor(v28 / 3600);
    local math_floor_ret3 = math.floor(v28 % 3600 / 60);

    return string.format("%dD %dH %dM", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;

function u9.ToClockString(p29) -- Line: 172
    local v30 = tonumber(p29);

    if v30 <= 0 then
        return "00:00:00";
    end;

    local string_format_ret = string.format("%02.f", (math.floor(v30 / 3600)));
    local string_format_ret2 = string.format("%02.f", (math.floor(v30 / 60 - string_format_ret * 60)));

    return string_format_ret .. ":" .. string_format_ret2 .. ":" .. string.format("%02.f", (math.floor(v30 - string_format_ret * 3600 - string_format_ret2 * 60)));
end;

function u9.AdaptiveClockString(p31: number, p32: boolean?, p33: number) -- Line: 185
    -- upvalues: u3 (copy)
    local math_max_ret = math.max(p31, 0);

    if not ((not p32 or math_max_ret >= 60) and (p32 or math_max_ret > 1)) then
        return `{math.floor(math_max_ret)}s`;
    end;

    local v34 = false;
    local v35 = "";
    local v36 = 1;

    for i = #u3, 1, -1 do
        local v37 = u3[i];
        local v38 = v37[1];
        local v39 = v37[2];
        local v40;

        if v39 <= math_max_ret or (v34 or i <= v36) then
            v34 = true;
            local math_floor_ret = math.floor(math_max_ret / v39);
            math_max_ret = math_max_ret % v39;

            if p32 then
                v35 = v35 .. string.format("%02.f", math_floor_ret) .. ":";
                v40 = i;
            else
                v35 = v35 .. math_floor_ret .. v38 .. " ";
                v40 = i;
            end;
        else
            v40 = i;
        end;
    end;

    return v35:sub(1, -2);
end;

function u9.Short(p41: number, p42: any) -- Line: 216
    -- upvalues: u9 (copy), u1 (copy)
    if p41 < 1000 then
        if p42 and p41 < 10 then
            return tostring(u9.DecimalPlaces(p41, 1));
        end;

        local math_floor_ret = math.floor(p41);

        return tostring(math_floor_ret);
    end;

    local math_floor_ret = math.floor(p41);
    local math_log10_ret = math.log10(math_floor_ret);
    local v43 = math.floor(math_log10_ret) / 3;
    local math_floor_ret2 = math.floor(v43);
    local v44 = math.floor(math_floor_ret / 1000 ^ math_floor_ret2 * 100) / 100;

    return tostring(v44) .. u1[math_floor_ret2];
end;

function u9.HHMMSS(p45) -- Line: 234
    local v46 = tonumber(p45);

    if v46 <= 0 then
        return "00:00:00";
    end;

    local math_floor_ret = math.floor(v46 / 3600);
    local math_floor_ret2 = math.floor(v46 / 60 - math_floor_ret * 60);
    local math_floor_ret3 = math.floor(v46 - math_floor_ret * 3600 - math_floor_ret2 * 60);

    return string.format("%02.f:%02.f:%02.f", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;

function u9.SigFigs(p47: number, p48: number) -- Line: 247
    return string.format("%." .. p48 .. "g", p47);
end;

function u9.DecimalPlaces(p49: number, p50: number) -- Line: 251
    local v51 = 10 ^ p50;

    return math.floor(p49 * v51) / v51;
end;

function u9.SigDP(p52: number, p53: number) -- Line: 256
    -- upvalues: u9 (copy)
    local v54 = p53 or 2;
    local v55 = p52 % 1;

    if v55 >= 1e-6 then
        return math.floor(p52) .. "." .. u9.SigFigs(v55, v54):sub(3);
    end;

    local math_floor_ret = math.floor(p52);

    return tostring(math_floor_ret);
end;

return u9;