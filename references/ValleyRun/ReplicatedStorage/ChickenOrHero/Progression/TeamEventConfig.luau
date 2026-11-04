 

 

local ShopConfig = require(script.Parent.Parent.Weapons.ShopConfig);
local u2 = {
    EventId = "FvF2026",
    Teams = { "Football", "Futbol" },
    Team = {
        Football = {
            Name = "FOOTBALL",
            Label = "TEAM FOOTBALL",
            Subtitle = "AMERICAN FOOTBALL",
            Icon = "🏈",
            Title = "TeamFootball",
            Mvp = "FootballMvp",
            Champion = "FootballChampion",
            Legend = "FootballLegend",
            Goat = "FootballGoat",
            Elite = "FootballElite",
            AllStar = "FootballAllStar",
            Emote = "FootballCatch",
            Board = "HV_FvF2026_Football_v1",
            BoardKey = "TeamFootball",
            PersonalKnife = "SolarPhoenix",
            TeamKnife = "VoidSovereign",
            EventKnife = "Hotdog",
            TeamTitle1 = "FootballTeam1",
            TeamTitle3 = "FootballTeam3",
            TeamTitle5 = "FootballTeam5",
            Color = Color3.fromRGB(196, 46, 52)
        },
        Futbol = {
            Name = "FÚTBOL",
            Label = "TEAM FÚTBOL",
            Subtitle = "SOCCER",
            Icon = "⚽",
            Title = "TeamFutbol",
            Mvp = "FutbolMvp",
            Champion = "FutbolChampion",
            Legend = "FutbolLegend",
            Goat = "FutbolGoat",
            Elite = "FutbolElite",
            AllStar = "FutbolAllStar",
            Emote = "FutbolCatch",
            Board = "HV_FvF2026_Futbol_v1",
            BoardKey = "TeamFutbol",
            PersonalKnife = "GlacialCrown",
            TeamKnife = "CelestialDragon",
            EventKnife = "NumberOneFan",
            TeamTitle1 = "FutbolTeam1",
            TeamTitle3 = "FutbolTeam3",
            TeamTitle5 = "FutbolTeam5",
            Color = Color3.fromRGB(44, 92, 196)
        }
    },

    other = function(p1) -- Line: 28, Name: other
        return p1 == "Football" and "Futbol" or (p1 == "Futbol" and "Football" or nil);
    end,

    StartsAt = 1791651600,
    EndsAt = 1792256400
};

function u2.window() -- Line: 35
    -- upvalues: u2 (copy), ShopConfig (copy)
    local v3 = (1 / 0);
    local v4 = 0;

    for _, v in u2.Teams do
        local v5 = ShopConfig.flagship(v);

        if not v5 then
            return u2.StartsAt, u2.EndsAt;
        end;

        local v6 = tonumber(v5.StartsAt) or 0;
        v3 = math.min(v3, v6);
        local v7 = tonumber(v5.EndsAt) or 0;
        v4 = math.max(v4, v7);
    end;

    return v3, v4;
end;

u2.SettleSeconds = 900;
u2.UpdateSeconds = 300;

function u2.phaseAt(p8, p9) -- Line: 50
    -- upvalues: u2 (copy)
    if p9 then
        return "Final";
    end;

    local v10, v11 = u2.window();

    return v10 > 0 and p8 < v10 and "Upcoming" or (v11 > 0 and v11 <= p8 and "Settling" or "Active");
end;

u2.PersonalLevels = { 25, 150, 500, 1500, 5000 };
u2.TeamLevels = { 10000000, 25000000, 75000000, 150000000, 250000000 };
u2.Participation = { 5, 5, 25, 50, 100 };
u2.ActiveMinPoints = 5;
u2.ChampionMinPoints = 100;
u2.MatchCap = 30;
u2.BotMatchCap = 3;
u2.LegendRank = 1000;
u2.BoostCap = 3;
u2.BoostMinActive = 20;

function u2.boost(p12, p13) -- Line: 80
    -- upvalues: u2 (copy)
    local v14 = u2.other(p13);
    local v15;

    if p12 then
        v15 = p12[p13];
    else
        v15 = p12;
    end;

    if p12 then
        if v14 then
            v14 = p12[v14];
        end;
    else
        v14 = p12;
    end;

    local v16 = v15 and tonumber(v15.active) or 0;
    local v17 = v14 and tonumber(v14.active) or 0;

    if v16 < u2.BoostMinActive or (v17 < u2.BoostMinActive or v17 <= v16) then
        return 1;
    end;

    local BoostCap = u2.BoostCap;
    local v18 = math.floor(v17 / v16 * 10 + 0.5) / 10;

    return math.min(BoostCap, v18);
end;

u2.Placement = { {
        Rank = 1,
        Gems = 10000,
        Title = "$Goat"
    }, {
        Rank = 10,
        Gems = 5000,
        Title = "$Elite"
    }, {
        Rank = 100,
        Gems = 2500,
        Title = "$AllStar"
    } };
u2.Note = "Team point milestones may be adjusted if not enough people sign up!";

function u2.levelFor(p19, p20) -- Line: 97
    -- upvalues: u2 (copy)
    local v21 = 0;

    for i, v in p20 or u2.TeamLevels do
        if (tonumber(p19) or 0) < v then
            break;
        end;

        v21 = i;
    end;

    return v21;
end;

function u2.parseThresholds(p22) -- Line: 108
    -- upvalues: u2 (copy)
    if type(p22) ~= "string" then
        return nil;
    end;

    local v23 = {};

    for i in p22:gmatch("[^,%s]+") do
        local v24 = tonumber(i);

        if not (v24 and (v24 == v24 and (v24 > 0 and (v24 ~= (1 / 0) and (not v23[#v23] or v24 > v23[#v23]))))) then
            return nil;
        end;

        local math_floor_ret = math.floor(v24);
        table.insert(v23, math_floor_ret);
    end;

    if #v23 == #u2.TeamLevels then
        return v23;
    end;

    return nil;
end;

u2.Rewards = {
    Personal = { {
            Gems = 100,
            GemBoostMinutes = 30
        }, {
            Spins = 6,
            Coins = 2500
        }, {
            Crates = {
                Celestial = 2,
                Emote = 2
            }
        }, {
            Gems = 250,
            GemBoostMinutes = 120,
            Abilities = { "RufusLeash" }
        }, {
            Gems = 500,
            Knives = { "$PersonalKnife" },
            Titles = { "$Mvp" }
        } },
    Team = { {
            Gems = 150,
            Spins = 5,
            Titles = { "$TeamTitle1" }
        }, {
            CoinBoostMinutes = 120,
            Crates = {
                Emote = 4
            }
        }, {
            Knives = { "$TeamKnife" },
            Titles = { "$TeamTitle3" },
            Crates = {
                Celestial = 4
            }
        }, {
            Gems = 300,
            Abilities = { "PocketDoor" }
        }, {
            Gems = 500,
            Knives = { "$EventKnife" },
            Emotes = { "$Emote" },
            Titles = { "$TeamTitle5" }
        } },
    Champion = {
        Gems = 500,
        Titles = { "$Champion" },
        Abilities = { "InflatableDecoy" },
        Crates = {
            Celestial = 3
        }
    },
    Legend = {
        Titles = { "$Legend" }
    }
};
u2.CrateGems = {
    Emote = 250,
    Celestial = 750,
    Ember = 750
};
u2.OwnedKnifeCrates = 10;
u2.OppositeCrate = {
    Ember = "Celestial",
    Celestial = "Ember"
};

function u2.shown(p25, p26, p27) -- Line: 151
    -- upvalues: u2 (copy)
    if type(p25) ~= "table" or (type(p25.Knives) ~= "table" or type(p26) ~= "table") then
        return p25;
    end;

    local table_clone_ret = table.clone(type(p25.Crates) == "table" and (p25.Crates or {}) or {});
    local v28 = {};
    local v29 = false;

    for _, v in p25.Knives do
        local v30 = p27.get(v);

        if p26[v] == true then
            if v30 then
                v30 = u2.OppositeCrate[v30.Crate];
            end;
        else
            v30 = false;
        end;

        if v30 then
            table_clone_ret[v30] = (table_clone_ret[v30] or 0) + u2.OwnedKnifeCrates;
            v29 = true;
        else
            table.insert(v28, v);
        end;
    end;

    if not v29 then
        return p25;
    end;

    local table_clone_ret2 = table.clone(p25);
    table_clone_ret2.Knives = v28;
    table_clone_ret2.Crates = table_clone_ret;

    return table_clone_ret2;
end;

local function resolve(p31, p32) -- Line: 173
    -- upvalues: u2 (copy)
    local v33 = u2.Team[p32];

    if type(p31) ~= "table" or not v33 then
        return nil;
    end;

    local v34 = {};

    for i, v in p31 do
        if type(v) == "table" then
            local v35 = {};

            for i2, v2 in v do
                local v36;

                if type(v2) == "string" and string.sub(v2, 1, 1) == "$" then
                    v36 = v33[string.sub(v2, 2)] or v2;
                else
                    v36 = v2;
                end;

                v35[i2] = v36;
            end;

            v34[i] = v35;
        else
            v34[i] = v;
        end;
    end;

    return v34;
end;

function u2.reward(p37, p38, p39) -- Line: 197
    -- upvalues: resolve (copy), u2 (copy)
    return resolve(u2.Rewards[p37] and u2.Rewards[p37][p38], p39);
end;

function u2.championReward(p40) -- Line: 200
    -- upvalues: resolve (copy), u2 (copy)
    return resolve(u2.Rewards.Champion, p40);
end;

function u2.placementReward(p41, p42) -- Line: 205
    -- upvalues: u2 (copy), resolve (copy)
    if type(p41) ~= "number" or (p41 < 1 or u2.LegendRank < p41) then
        return nil;
    end;

    local v43 = resolve(u2.Rewards.Legend, p42);

    for _, v in u2.Placement do
        if v43 and p41 <= v.Rank then
            v43.Gems = v.Gems;

            if v.Title then
                v43.Titles = resolve({
                    Titles = { v.Title }
                }, p42).Titles;

                return v43;
            end;

            break;
        end;
    end;

    return v43;
end;

u2.Final = nil;

return u2;