  

game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.TableUtil);
require(ReplicatedStorage.Shared.Functions.Lottery);
local Rarities = require(ReplicatedStorage.Shared.Rarities);
local Flows = require(ReplicatedStorage.Shared.Flows);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local u1 = {};

for i in Rarities do
    u1[i] = {};
end;

for i, v in Flows do
    table.insert(u1[v.Rarity], i);
end;

local u2 = {
    Odds = { { "Rare", 62.215 }, { "Epic", 30 }, { "Legendary", 7 }, { "Mythic", 0.5 }, { "World Class", 0.25 }, { "Master", 0.035 } },
    LuckyOdds = { { "Legendary", 92.3 }, { "Mythic", 5 }, { "World Class", 2.5 }, { "Master", 0.2 } },
    Pitty = { { "Legendary", 93 }, { "Mythic", 7 } }
};

local function getOddsTable(p3: string) -- Line: 44
    -- upvalues: u2 (copy)
    local v4 = nil;

    if p3 == "Lucky" then
        return u2.LuckyOdds;
    end;

    if p3 == "Normal" then
        return u2.Odds;
    end;

    if p3 == "Halloween" then
        v4 = u2.HalloweenOdds;
    end;

    return v4;
end;

function u2.GetRarityChances(p5: boolean) -- Line: 58
    -- upvalues: u2 (copy), ReplicatedStorage (copy), HttpService (copy)
    local v6 = {};
    local v7 = {};

    if p5 then
        for _, v in u2.LuckyOdds do
            v6[v[1]] = v[2];
        end;
    else
        for _, v in u2.Odds do
            v6[v[1]] = v[2];
        end;
    end;

    for i, v in ReplicatedStorage.ServerModifiers:GetAttributes() do
        local v8 = i:split("_");

        if v8[1] == "boosted" and v8[2] == (p5 and "Lucky" or "Normal") then
            local v9 = HttpService:JSONDecode(v);
            local v10 = v9[1];
            local v11 = v9[2];

            if workspace:GetServerTimeNow() < v10 then
                local v12 = v8[3]:gsub("1", " ");
                local v13 = v11 - v6[v12];

                if p5 then
                    v6[v12] = v6[v12] + v13;
                    v7[v12] = v10;
                    v6.Legendary = v6.Legendary - v13;
                else
                    v6[v12] = v6[v12] + v13;
                    v7[v12] = v10;
                    v6.Rare = v6.Rare - v13;
                end;
            end;
        end;
    end;

    return v6, v7;
end;

function u2.GetRarityChance(p14: any, p15: boolean) -- Line: 97
    -- upvalues: u2 (copy)
    return u2.GetRarityChances(p15)[p14];
end;

function u2.GetStyleChance(p16: any, p17: boolean, p18: boolean) -- Line: 101
    -- upvalues: u2 (copy), u1 (copy), Flows (copy)
    local v19 = u2.GetRarityChances(p17)[p16];

    if not v19 then
        return 0;
    end;

    local v20 = 0;

    for _, v in u1[p16] do
        if not Flows[v].Unobtainable then
            v20 = v20 + 1;
        end;
    end;

    if p18 then
        return v19 * (2 / (v20 + 1));
    end;

    return v19 / v20;
end;

function u2.Roll(p21: string, p22: userdata) -- Line: 121
    -- upvalues: u2 (copy), RngUtil (copy)
    local v23 = nil;

    if p21 == "Lucky" then
        v23 = u2.LuckyOdds;
    elseif p21 == "Normal" then
        v23 = u2.Odds;
    elseif p21 == "Halloween" then
        v23 = u2.HalloweenOdds;
    end;

    return v23[RngUtil.SelectRandom(v23, 2, p22)][1];
end;

function u2.RarityCanBeSpun(p24: string, p25: string) -- Line: 127
    -- upvalues: u2 (copy)
    local v26 = nil;

    if p24 == "Lucky" then
        v26 = u2.LuckyOdds;
    elseif p24 == "Normal" then
        v26 = u2.Odds;
    elseif p24 == "Halloween" then
        v26 = u2.HalloweenOdds;
    end;

    for _, v in v26 do
        if v[1] == p25 then
            return true;
        end;
    end;

    return false;
end;

return u2;