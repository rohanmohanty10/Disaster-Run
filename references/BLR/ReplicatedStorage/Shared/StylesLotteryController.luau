  

local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.TableUtil);
require(ReplicatedStorage.Shared.Functions.Lottery);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local PlrStyles = require(ReplicatedStorage.Shared.PlrStyles);
local Rarities = require(ReplicatedStorage.Shared.Rarities);
local StyleEventData = require(ReplicatedStorage.Shared.Configs.StyleEventData);
local LimitedStyleDrop = require(ReplicatedStorage.Shared.Configs.LimitedStyleDrop);
local u1 = {};

for i in Rarities do
    u1[i] = {};
end;

for i, v in PlrStyles do
    table.insert(u1[v.Rarity], i);
end;

local u2 = {
    Odds = { { "Rare", 62.215 }, { "Epic", 30 }, { "Legendary", 7 }, { "Mythic", 0.5 }, { "World Class", 0.25 }, { "Master", 0.035 } },
    LuckyOdds = { { "Legendary", 92.3 }, { "Mythic", 5 }, { "World Class", 2.5 }, { "Master", 0.2 } }
};

if StyleEventData.Enabled then
    u2.EventOdds = StyleEventData.EventOdds;

    if StyleEventData.LuckyOdds then
        table.insert(u2.LuckyOdds, { "Event", StyleEventData.LuckyOdds });
    end;

    if StyleEventData.Odds then
        table.insert(u2.Odds, { "Event", StyleEventData.Odds });
    end;
end;

local function getOddsTable(p3: string, p4: number?) -- Line: 57
    -- upvalues: u2 (copy), LimitedStyleDrop (copy)
    local v5 = nil;

    if p3 == "Lucky" then
        v5 = u2.LuckyOdds;

        if LimitedStyleDrop.IsActive(p4) then
            local table_clone_ret = table.clone(v5);

            for i, v in table_clone_ret do
                if v[1] == "Legendary" then
                    table_clone_ret[i] = { v[1], v[2] - LimitedStyleDrop.LuckyOdds };
                    break;
                end;
            end;

            table.insert(table_clone_ret, { LimitedStyleDrop.Rarity, LimitedStyleDrop.LuckyOdds });

            return table_clone_ret;
        end;
    else
        if p3 == "Normal" then
            return u2.Odds;
        end;

        if p3 == "Event" then
            v5 = u2.EventOdds;
        end;
    end;

    return v5;
end;

function u2.GetRarityChances(p6: string, p7: number?) -- Line: 81
    -- upvalues: getOddsTable (copy), ReplicatedStorage (copy), HttpService (copy)
    local v8 = getOddsTable(p6, p7);
    local v9 = {};
    local v10 = {};

    for _, v in v8 do
        v9[v[1]] = v[2];
    end;

    for i, v in ReplicatedStorage.ServerModifiers:GetAttributes() do
        local v11 = i:split("_");

        if v11[1] == "boosted" and v11[2] == p6 then
            local v12 = HttpService:JSONDecode(v);
            local v13 = v12[1];
            local v14 = v12[2];

            if workspace:GetServerTimeNow() < v13 then
                local v15 = v11[3]:gsub("1", " ");
                local v16 = v14 - v9[v15];
                v9[v15] = v9[v15] + v16;
                v10[v15] = v13;
                local v17 = v8[1][1];
                v9[v17] = v9[v17] - v16;
            end;
        end;
    end;

    return v9, v10;
end;

function u2.GetRarityChance(p18: string, p19: string, p20: number?) -- Line: 109
    -- upvalues: u2 (copy)
    return u2.GetRarityChances(p19, p20)[p18];
end;

function u2.GetStyleChance(p21: any, p22: string, p23: boolean) -- Line: 113
    -- upvalues: u2 (copy), PlrStyles (copy), LimitedStyleDrop (copy), u1 (copy), StyleEventData (copy)
    local v24 = u2.GetRarityChances(p22)[p21];

    if not v24 then
        return 0;
    end;

    local u25 = 0;

    local function loopStyleTable(p26) -- Line: 121
        -- upvalues: PlrStyles (ref), LimitedStyleDrop (ref), u25 (ref)
        for _, v in p26 do
            local v27 = PlrStyles[v];
            local v28;

            if v27.Rarity == LimitedStyleDrop.Rarity then
                v28 = LimitedStyleDrop.IsRollable(v);
            else
                v28 = not v27.Unobtainable;
            end;

            if v28 then
                u25 = u25 + 1;
            end;
        end;
    end;

    loopStyleTable(u1[p21]);

    if StyleEventData.Enabled and p21 == "Event" then
        loopStyleTable(StyleEventData.Styles);
    end;

    if u25 == 0 then
        return 0;
    end;

    if p23 then
        return v24 * (2 / (u25 + 1));
    end;

    return v24 / u25;
end;

function u2.Roll(p29: string, p30: userdata, p31: number?) -- Line: 149
    -- upvalues: getOddsTable (copy), RngUtil (copy)
    local v32 = getOddsTable(p29, p31);

    return v32[RngUtil.SelectRandom(v32, 2, p30)][1];
end;

function u2.RarityCanBeSpun(p33: string, p34: string, p35: number?) -- Line: 155
    -- upvalues: getOddsTable (copy)
    for _, v in getOddsTable(p33, p35) do
        if v[1] == p34 then
            return true;
        end;
    end;

    return false;
end;

return u2;