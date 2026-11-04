 

 

local RankedConfig = require(script.Parent.RankedConfig);
local Tiers = RankedConfig.Tiers;
local DivisionRP = RankedConfig.DivisionRP;
local u1 = {};
local v2 = 0;
local u3 = {
    DIVISIONS = { "IV", "III", "II", "I" }
};

for i, v in Tiers do
    u1[i] = v2;
    v2 = v2 + math.max(1, v.Divisions) * DivisionRP;
end;

u3.GRANDMASTER = #Tiers;

function u3.tierIndex(p4) -- Line: 20
    -- upvalues: Tiers (copy)
    for i, v in Tiers do
        if v.Name == p4 then
            return i;
        end;
    end;

    return nil;
end;

function u3.place(p5) -- Line: 31
    -- upvalues: Tiers (copy), u1 (copy), DivisionRP (copy), u3 (copy)
    local v6 = tonumber(p5) or 0;
    local math_floor_ret = math.floor(v6);
    local math_max_ret = math.max(0, math_floor_ret);

    for i = #Tiers, 1, -1 do
        if u1[i] <= math_max_ret then
            local v7 = Tiers[i];
            local v8 = math_max_ret - u1[i];

            if v7.Divisions == 0 then
                return {
                    division = 0,
                    divisionName = "",
                    tier = i,
                    name = v7.Name,
                    into = v8,
                    floor = u1[i],
                    entry = v7.Entry
                };
            end;

            local math_min_ret = math.min(v7.Divisions, v8 // DivisionRP + 1);

            return {
                tier = i,
                name = v7.Name,
                division = math_min_ret,
                divisionName = u3.DIVISIONS[math_min_ret],
                into = v8 - (math_min_ret - 1) * DivisionRP,
                span = DivisionRP,
                floor = u1[i] + (math_min_ret - 1) * DivisionRP,
                entry = v7.Entry
            };
        end;

        local _ = i;
    end;

    return u3.place(0);
end;

function u3.floor(p9, p10) -- Line: 57
    -- upvalues: u1 (copy), DivisionRP (copy)
    return u1[p9] + math.max(0, (p10 or 1) - 1) * DivisionRP;
end;

function u3.label(p11) -- Line: 62
    if p11.division > 0 then
        return p11.name .. " " .. p11.divisionName;
    end;

    return p11.name;
end;

function u3.color(p12) -- Line: 66
    -- upvalues: RankedConfig (copy)
    return RankedConfig.TierColors[p12] or Color3.new(1, 1, 1);
end;

local PreSeasonEndsUTC = RankedConfig.PreSeasonEndsUTC;
local os_date_ret = os.date("!*t", PreSeasonEndsUTC);

local function utc(p13, p14, p15, p16) -- Line: 75
    local os_time_ret = os.time({
        hour = 0,
        min = 0,
        sec = 0,
        year = p13 + (p14 - 1) // 12,
        month = (p14 - 1) % 12 + 1,
        day = p15
    });

    return os_time_ret - (os.time(os.date("!*t", os_time_ret)) - os_time_ret) + p16 * 3600;
end;

local function pacificDaylight(p17, p18, p19) -- Line: 83
    -- upvalues: utc (copy)
    if p18 > 3 and p18 < 11 then
        return true;
    end;

    if p18 ~= 3 and p18 ~= 11 then
        return false;
    end;

    local v20 = 1 + (8 - os.date("!*t", (utc(p17, p18, 1, 12))).wday) % 7;

    if p18 == 3 then
        return v20 + 7 <= p19;
    end;

    return p19 < v20;
end;

local function seasonStart(p21) -- Line: 93
    -- upvalues: os_date_ret (copy), pacificDaylight (copy), utc (copy), RankedConfig (copy)
    local v22 = os_date_ret.year + (os_date_ret.month + p21 - 2) // 12;
    local v23 = (os_date_ret.month + p21 - 2) % 12 + 1;
    local v24 = pacificDaylight(v22, v23, os_date_ret.day) and 7 or 8;

    return utc(v22, v23, os_date_ret.day, RankedConfig.SeasonStartHourPT + v24);
end;

function u3.seasonNumber(p25) -- Line: 99
    -- upvalues: PreSeasonEndsUTC (copy), os_date_ret (copy), pacificDaylight (copy), utc (copy), RankedConfig (copy)
    local v26 = p25 or os.time();

    if v26 < PreSeasonEndsUTC then
        return 0;
    end;

    local os_date_ret2 = os.date("!*t", v26);
    local v27 = (os_date_ret2.year - os_date_ret.year) * 12 + os_date_ret2.month - os_date_ret.month + 1;
    local v28 = os_date_ret.year + (os_date_ret.month + v27 - 2) // 12;
    local v29 = (os_date_ret.month + v27 - 2) % 12 + 1;
    local v30 = pacificDaylight(v28, v29, os_date_ret.day) and 7 or 8;

    if v26 < utc(v28, v29, os_date_ret.day, RankedConfig.SeasonStartHourPT + v30) then
        v27 = v27 - 1;
    end;

    return math.max(1, v27);
end;

function u3.season(p31) -- Line: 111
    -- upvalues: u3 (copy)
    local v32 = u3.seasonNumber(p31);

    return v32 == 0 and "PRE" or "S" .. v32;
end;

function u3.seasonEnds(p33) -- Line: 116
    -- upvalues: u3 (copy), os_date_ret (copy), pacificDaylight (copy), utc (copy), RankedConfig (copy)
    local v34 = u3.seasonNumber(p33) + 1;
    local v35 = os_date_ret.year + (os_date_ret.month + v34 - 2) // 12;
    local v36 = (os_date_ret.month + v34 - 2) % 12 + 1;
    local v37 = pacificDaylight(v35, v36, os_date_ret.day) and 7 or 8;

    return utc(v35, v36, os_date_ret.day, RankedConfig.SeasonStartHourPT + v37);
end;

function u3.numbered(p38) -- Line: 120
    local v39;

    if type(p38) == "string" then
        v39 = p38:match("^S%d+$") ~= nil;
    else
        v39 = false;
    end;

    return v39;
end;

function u3.seasonName(p40) -- Line: 124
    local v41 = tostring(p40):match("^S(%d+)$");

    return not v41 and "PRE-SEASON" or "SEASON " .. v41;
end;

function u3.softReset(p42) -- Line: 130
    -- upvalues: u3 (copy), Tiers (copy)
    local v43 = u3.place(p42);

    if v43.tier == u3.GRANDMASTER then
        return u3.floor(v43.tier - 1, Tiers[v43.tier - 1].Divisions);
    end;

    return v43.tier <= 1 and 0 or u3.floor(v43.tier - 1, 1);
end;

function u3.placementRP(p44) -- Line: 140
    -- upvalues: u3 (copy), RankedConfig (copy), Tiers (copy)
    local v45 = 1;

    for i = 1, u3.tierIndex(RankedConfig.PlacementCap) or 1 do
        local v46;

        if Tiers[i].Entry <= p44 then
            v45 = i;
            v46 = v45;
            local v47 = v45;
            v45 = v46;
            v47 = v46;
        else
            v46 = i;
        end;
    end;

    return u3.floor(v45, 1);
end;

function u3.band(p48, p49) -- Line: 152
    -- upvalues: u3 (copy)
    return p49 and 2.5 or math.min(p48, u3.GRANDMASTER - 1);
end;

return table.freeze(u3);