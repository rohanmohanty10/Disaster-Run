  

 

local v1 = {
    LegendaryPity = 100,
    RosterFormat = {
        Common = 3,
        Uncommon = 2,
        Rare = 2,
        Epic = 2,
        Legendary = 1
    },
    WeightPool = {
        Common = 5000,
        Uncommon = 3500,
        Rare = 2500,
        Epic = 1500,
        Legendary = 200,
        Mythic = 7
    },
    RewardInfo = {
        Common = 1,
        Uncommon = 1,
        Rare = 1,
        Epic = 3,
        Legendary = 3,
        Mythic = 3
    },
    RarityRecipes = {
        Common = 1,
        Uncommon = 1,
        Rare = 2,
        Epic = 2,
        Legendary = 3,
        Mythic = 3
    },
    AbilityPool = {
        Common = { "Standless", "Silver Chariot", "Casey", "The Hand", "ShadowDio" },
        Uncommon = { "Gold Experience", "Sticky Fingers", "Magician\'s Red", "Base Hamon", "Sans", "Kuro Claws" },
        Rare = { "The World: High Voltage", "Star Platinum", "Killer Queen", "The World", "King Crimson", "Whitesnake", "Broly", "Brickbattle", "Locke" },
        Epic = { "Star Platinum: The World", "Killua", "Joseph Hamon", "Jonathan Hamon", "Asgore", "Nocturnus", "Sol", "C-Moon", "Yasuo", "Yone", "Weather Report", "Anubis", "Soul Survivor", "D4C" },
        Legendary = { "SPR", "D4C: Love Train", "Dawn", "PLANET // SHAPER", "STWR", "Made In Heaven", "Gold Experience Requiem", "The World: Over Heaven", "Dragon Knight", "Reaper", "Mero", "Crazy Diamond", "Suna", "Kars", "Xeno", "Cursed Child", "The Strongest" },
        Mythic = { "Chrono Warden", "Ope" }
    },
    RarityCache = {}
};

for i, v in v1.AbilityPool do
    for _, v2 in v do
        v1.RarityCache[v2] = i;
    end;
end;

return v1;