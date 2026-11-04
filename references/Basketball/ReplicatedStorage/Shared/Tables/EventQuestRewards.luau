 
 

return {
    ["Lucky Style Spins"] = {
        Weight = 2,
        Value = {
            Rarity = "Mythic",
            DataIndex = "LuckySpins",
            Range = NumberRange.new(2, 3)
        }
    },
    ["Lucky Zone Spins"] = {
        Weight = 3,
        Value = {
            Rarity = "Mythic",
            DataIndex = "ZoneLuckySpins",
            Range = NumberRange.new(2, 3)
        }
    },
    ["Style Spins"] = {
        Weight = 15,
        Value = {
            Rarity = "Legendary",
            DataIndex = "Spins",
            Range = NumberRange.new(8, 15)
        }
    },
    ["Zone Spins"] = {
        Weight = 20,
        Value = {
            Rarity = "Legendary",
            DataIndex = "ZoneSpins",
            Range = NumberRange.new(8, 15)
        }
    },
    ["Zone Color Spins"] = {
        Weight = 20,
        Value = {
            Rarity = "Epic",
            DataIndex = "ZoneColorSpins",
            Range = NumberRange.new(1, 2)
        }
    },
    Money = {
        Weight = 40,
        Value = {
            Rarity = "Rare",
            DataIndex = "Money",
            Range = NumberRange.new(3000, 10000)
        }
    }
};