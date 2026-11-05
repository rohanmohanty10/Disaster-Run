  

 

local v1 = {
    Common_Chest = {
        Name = "Common Chest",
        WeightPool = {
            Common = 60,
            Uncommon = 20,
            Rare = 15,
            Epic = 4.5,
            Legendary = 0.4,
            Mythic = 0.1
        },
        Items = {}
    },
    Rare_Chest = {
        Name = "Rare Chest",
        WeightPool = {
            Uncommon = 60,
            Rare = 35,
            Epic = 4.5,
            Legendary = 0.4,
            Mythic = 0.1
        },
        Items = {}
    },
    Epic_Chest = {
        Name = "Epic Chest",
        WeightPool = {
            Rare = 75,
            Epic = 24.5,
            Legendary = 0.4,
            Mythic = 0.1
        },
        Items = {}
    },
    Legendary_Chest = {
        Name = "Legendary Chest",
        WeightPool = {
            Epic = 94.72,
            Legendary = 4.4,
            Mythic = 0.88
        },
        Items = {}
    }
};

for _, v in v1 do
    for i, v2 in v.WeightPool do
        v.WeightPool[i] = v2 * 100;
    end;
end;

return v1;