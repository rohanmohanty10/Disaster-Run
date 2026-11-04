 
 

local v1 = {
    Limited = { "PERFECT", "PERFECT V2", "Basketball God", "Current.", "Current. V2", "Other Current.", "Other Current. V2", "4th of July", "CYBER", "PSYCHIC", "SPIDER VS SYMBIOTE", "VAMPIRE", "JOKER", "GHOST", "POPSTAR", "KING VS AIR", "LUKA DONČIĆ", "GENIUS", "HONORED ONE", "CURSE KING", "JUDGEMENT", "JOHNNY", "GOAT", "VALENTINE", "ALIEN", "KING OF NYC", "SCARY MONSTER", "KIRA", "NINJA", "Rewards", "Retired", "Dev" },
    TextColors = {
        ["Current."] = Color3.fromRGB(255, 255, 255),
        ["Other Current."] = Color3.fromRGB(255, 255, 255)
    },
    Colors = {
        Rare = Color3.new(0.184314, 0.85098, 1),
        Epic = Color3.new(0.4, 0, 1),
        Legendary = Color3.new(1, 0.615686, 0),
        Mythic = Color3.new(1, 0, 0),
        Limited = Color3.new(1, 0, 0.0156863),
        Miracle = Color3.fromRGB(255, 254, 237),
        PERFECT = Color3.fromRGB(115, 255, 159),
        ["PERFECT V2"] = Color3.fromRGB(115, 255, 159),
        ["Basketball God"] = Color3.fromRGB(255, 231, 142),
        ["Current."] = Color3.fromRGB(13, 13, 13),
        ["Current. V2"] = Color3.fromRGB(13, 13, 13),
        ["Other Current."] = Color3.fromRGB(13, 13, 13),
        ["Other Current. V2"] = Color3.fromRGB(13, 13, 13),
        ["4th of July"] = Color3.fromRGB(253, 4, 23),
        CYBER = Color3.fromRGB(255, 201, 39),
        PSYCHIC = Color3.fromRGB(222, 32, 255),
        ["SPIDER VS SYMBIOTE"] = Color3.fromRGB(0, 0, 0),
        VAMPIRE = Color3.fromRGB(158, 19, 21),
        JOKER = Color3.fromRGB(158, 0, 255),
        GHOST = Color3.fromRGB(29, 255, 138),
        POPSTAR = Color3.fromRGB(205, 180, 255),
        ["KING VS AIR"] = Color3.fromRGB(255, 103, 28),
        ["LUKA DONČIĆ"] = Color3.fromRGB(255, 240, 31),
        GENIUS = Color3.fromRGB(133, 255, 99),
        ["HONORED ONE"] = Color3.fromRGB(69, 176, 210),
        ["CURSE KING"] = Color3.fromRGB(255, 0, 25),
        JUDGEMENT = Color3.fromRGB(255, 170, 96),
        JOHNNY = Color3.fromRGB(181, 231, 255),
        GOAT = Color3.fromRGB(255, 205, 67),
        VALENTINE = Color3.fromRGB(255, 155, 197),
        ALIEN = Color3.fromRGB(112, 255, 50),
        ["KING OF NYC"] = Color3.fromRGB(255, 115, 0),
        ["SCARY MONSTER"] = Color3.fromRGB(40, 130, 255),
        KIRA = Color3.fromRGB(255, 43, 43),
        NINJA = Color3.fromRGB(255, 154, 52),
        Rewards = Color3.fromRGB(222, 35, 255),
        Retired = Color3.fromRGB(197, 196, 183),
        Dev = Color3.fromRGB(0, 0, 0)
    },
    Odds = { { "Rare", 62.25 }, { "Epic", 35 }, { "Legendary", 2 }, { "Mythic", 0.5 }, { "Miracle", 0.25 }, { "PERFECT V2", 0.25 }, { "4th of July", 0.25 }, { "Basketball God", 0.25 }, { "CYBER", 0.25 }, { "PSYCHIC", 0.25 }, { "SPIDER VS SYMBIOTE", 0.25 }, { "Current.", 0.25 }, { "Current. V2", 0.25 }, { "VAMPIRE", 0.25 }, { "JOKER", 0.25 }, { "GHOST", 0.25 }, { "POPSTAR", 0.25 }, { "KING VS AIR", 0.25 }, { "LUKA DONČIĆ", 0.25 }, { "GENIUS", 0.25 }, { "HONORED ONE", 0.25 }, { "CURSE KING", 0.25 }, { "JUDGEMENT", 0.25 }, { "JOHNNY", 0.25 }, { "GOAT", 0.25 }, { "VALENTINE", 0.25 }, { "ALIEN", 0.25 }, { "KING OF NYC", 0.25 }, { "SCARY MONSTER", 0.25 }, { "KIRA", 0.25 }, { "NINJA", 0.25 } },
    SlightyLuckyOdds = { { "Rare", 25.5 }, { "Epic", 25.5 }, { "Legendary", 45.5 }, { "Mythic", 2.5 }, { "Miracle", 1 }, { "PERFECT V2", 0.5 }, { "4th of July", 0.25 }, { "Basketball God", 0.5 }, { "CYBER", 0.5 }, { "PSYCHIC", 0.5 }, { "SPIDER VS SYMBIOTE", 0.5 }, { "Current.", 0.5 }, { "Current. V2", 0.5 }, { "VAMPIRE", 0.5 }, { "JOKER", 0.5 }, { "GHOST", 0.5 }, { "POPSTAR", 0.5 }, { "KING VS AIR", 0.5 }, { "LUKA DONČIĆ", 0.5 }, { "GENIUS", 0.5 }, { "HONORED ONE", 0.5 }, { "CURSE KING", 0.5 }, { "JUDGEMENT", 0.5 }, { "JOHNNY", 0.5 }, { "GOAT", 0.5 }, { "VALENTINE", 0.5 }, { "ALIEN", 0.5 }, { "KING OF NYC", 0.5 }, { "SCARY MONSTER", 0.5 }, { "KIRA", 0.5 }, { "NINJA", 0.5 } },
    LuckyOdds = { { "Legendary", 92 }, { "Mythic", 5 }, { "Miracle", 2 }, { "PERFECT V2", 1 }, { "4th of July", 1 }, { "Basketball God", 1 }, { "CYBER", 1 }, { "PSYCHIC", 1 }, { "SPIDER VS SYMBIOTE", 1 }, { "Current.", 1 }, { "Current. V2", 1 }, { "VAMPIRE", 1 }, { "JOKER", 1 }, { "GHOST", 1 }, { "POPSTAR", 1 }, { "KING VS AIR", 1 }, { "LUKA DONČIĆ", 1 }, { "GENIUS", 1 }, { "HONORED ONE", 1 }, { "CURSE KING", 1 }, { "JUDGEMENT", 1 }, { "JOHNNY", 1 }, { "GOAT", 1 }, { "VALENTINE", 1 }, { "ALIEN", 1 }, { "KING OF NYC", 1 }, { "SCARY MONSTER", 1 }, { "KIRA", 1 }, { "NINJA", 1 } }
};
v1.Pitty = v1.LuckyOdds;
v1.LuckyPitty = { { "Mythic", 50 }, { "Miracle", 45 }, { "PERFECT V2", 5 }, { "4th of July", 5 }, { "Basketball God", 5 }, { "CYBER", 5 }, { "PSYCHIC", 5 }, { "SPIDER VS SYMBIOTE", 5 }, { "Current.", 5 }, { "Current. V2", 5 }, { "VAMPIRE", 5 }, { "JOKER", 5 }, { "GHOST", 5 }, { "POPSTAR", 5 }, { "KING VS AIR", 5 }, { "LUKA DONČIĆ", 5 }, { "GENIUS", 5 }, { "HONORED ONE", 5 }, { "CURSE KING", 5 }, { "JUDGEMENT", 5 }, { "JOHNNY", 5 }, { "GOAT", 5 }, { "VALENTINE", 5 }, { "ALIEN", 5 }, { "KING OF NYC", 5 }, { "SCARY MONSTER", 5 }, { "KIRA", 5 }, { "NINJA", 5 } };
v1.PackOdds = { { "Rare", 63 }, { "Epic", 35 }, { "Legendary", 2 } };
v1.RobuxPackOdds = { { "Epic", 50 }, { "Legendary", 45 } };
v1.QuestRewardOdds = {
    Rare = 50,
    Epic = 25,
    Legendary = 15,
    Mythic = 10
};

function v1.ComputePercentages(p2, p3) -- Line: 235
    local v4 = 0;
    local v5 = {};

    for _, v in p2 do
        if not p3 or table.find(p3, v[1]) == nil then
            v4 = v4 + v[2];
        end;
    end;

    for _, v in p2 do
        if not p3 or table.find(p3, v[1]) == nil then
            table.insert(v5, { v[1], v[2] / v4 });
        end;
    end;

    return v5;
end;

function v1.GetExpiredRarities(p6) -- Line: 258
    if not (p6 and p6.RarityTimes) then
        return {};
    end;

    local GetUnixTime = require(game:GetService("ReplicatedStorage").Shared.Utility.GetUnixTime);
    local v7 = {};

    for i, v in p6.RarityTimes do
        if v < GetUnixTime() then
            table.insert(v7, i);
        end;
    end;

    return v7;
end;

return v1;