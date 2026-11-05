  

 

local v2 = {
    Skin_Crate = {
        Name = "Skin Crate",
        Purchasable = true,
        LayoutOrder = 1,
        UShards = 5000,
        UPoints = 100,
        StrikeUPoints = 200,
        WeightPool = {
            Common = 1000,
            Uncommon = 700,
            Rare = 450,
            Epic = 149.715,
            Legendary = 40,
            Mythic = 10,
            Universal = 1.65
        },
        Items = {},
        Charms = {},
        PremiumCharms = {}
    },
    Recycle_Crate = {
        Name = "Recycle Crate",
        Purchasable = false,
        LayoutOrder = 1,
        WeightPool = {
            Common = 1000,
            Uncommon = 1000,
            Rare = 1000,
            Epic = 1000,
            Legendary = 1000,
            Mythic = 1000,
            Universal = 1000
        },
        AutoAddRarities = { 1, 2, 3, 4, 5, 7, 12 },

        AutoAddParser = function(p1) -- Line: 47, Name: AutoAddParser
            return p1.Available;
        end,

        Items = {},
        Charms = {},
        PremiumCharms = {}
    },
    KillEffect_Crate = {
        Name = "Kill Effect Crate",
        Purchasable = true,
        LayoutOrder = 2,
        UPoints = 100,
        WeightPool = {
            Rare = 450,
            Epic = 150,
            Legendary = 50,
            Mythic = 5
        },
        Items = {}
    },
    Christmas_Crate_23 = {
        Name = "Jolly Crate 2023",
        LayoutOrder = 2,
        UShards = 10000,
        UPoints = 400,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2024, 1, 11).UnixTimestamp,
        WeightPool = {
            Common = 500,
            Uncommon = 250,
            Rare = 150,
            Epic = 90,
            Event = 10
        },
        Items = {},
        Charms = { "1", "2", "3", "4", "5", "6", "7" }
    },
    Event_Crate_1 = {
        Name = "Event Crate 1",
        LayoutOrder = 2,
        UShards = 10000,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2024, 3, 14).UnixTimestamp,
        WeightPool = {
            Common = 400,
            Uncommon = 250,
            Rare = 200,
            Epic = 125,
            Event = 25
        },
        Items = {
            SKIN_666_4 = true,
            SKIN_69_5 = true,
            SKIN_70_6 = true,
            SKIN_73_4 = true,
            SKIN_2319_6 = true,
            SKIN_666_10 = true,
            SKIN_69_2 = true,
            SKIN_658_8 = true,
            SKIN_26_1 = true,
            SKIN_701_5 = true,
            SKIN_666_8 = true,
            SKIN_69_4 = true,
            SKIN_658_9 = true,
            SKIN_701_3 = true,
            SKIN_26_2 = true,
            SKIN_69_100 = true,
            SKIN_658_1 = true,
            SKIN_666_13 = true,
            SKIN_701_1 = true,
            SKIN_26_5 = true
        },
        Charms = { "1", "2", "3", "4", "5", "6", "7" }
    },
    Premium_Event_Crate_1 = {
        Name = "Premium Event Crate 1",
        LayoutOrder = 3,
        PremiumCrate = "PremiumEventCrate_1",
        UPoints = 400,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2024, 3, 14).UnixTimestamp,
        WeightPool = {
            Event = 100
        },
        Items = {
            SKIN_69_100 = true,
            SKIN_658_1 = true,
            SKIN_666_13 = true,
            SKIN_701_1 = true,
            SKIN_26_5 = true
        },
        Charms = { "8", "9", "10", "11" }
    },
    Event_Crate_2 = {
        Name = "Summer Crate",
        LayoutOrder = 4,
        UPoints = 200,
        USummer26 = 100,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2026, 9, 7).UnixTimestamp,
        WeightPool = {
            Event = 100
        },
        Items = {
            SKIN_456073_3 = true,
            SKIN_300000_8 = true,
            SKIN_658_7 = true,
            SKIN_6_6 = true,
            SKIN_2_4 = true,
            SKIN_9_10 = true,
            SKIN_2555_2 = true,
            SKIN_9111_3 = true,
            SKIN_12_13 = true
        },
        Charms = { "1", "2", "3", "4", "5", "6", "7", "13" },
        PremiumCharms = { "8", "9", "10", "11", "12", "14" }
    },
    Halloween_Crate_2025 = {
        Name = "Halloween Crate",
        LayoutOrder = 3,
        UPoints = 300,
        UHalloween = 3000,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2025, 11, 21).UnixTimestamp,
        WeightPool = {
            Event = 100
        },
        Items = {
            SKIN_12789_7 = true,
            SKIN_3701_2 = true,
            SKIN_12789_6 = true,
            SKIN_32003_3 = true,
            SKIN_69_100 = true,
            SKIN_6_3 = true,
            SKIN_6_2 = true,
            SKIN_26_8 = true,
            SKIN_658_1 = true,
            SKIN_9_5 = true,
            SKIN_119_2 = true,
            SKIN_140404_6 = true,
            SKIN_4_17 = true,
            SKIN_666_20 = true,
            SKIN_119_3 = true,
            SKIN_684_3 = true,
            SKIN_33_5 = true,
            SKIN_300000_11 = true,
            SKIN_69_14 = true,
            SKIN_24_6 = true
        },
        Charms = { "1", "2", "3", "4", "5", "6", "7" },
        PremiumCharms = { "8", "9", "10", "11" }
    },
    Halloween_KillEffect_Crate_2025 = {
        Name = "Halloween Kill Effect Crate",
        LayoutOrder = 4,
        UPoints = 300,
        UHalloween = 3000,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2025, 11, 21).UnixTimestamp,
        WeightPool = {
            Event = 100
        },
        Items = {}
    },
    Christmas_Crate_2024 = {
        Name = "Christmas Crate 2024",
        LayoutOrder = 4,
        UPoints = 300,
        UChristmas24 = 3000,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2025, 1, 18).UnixTimestamp,
        WeightPool = {
            Event = 100
        },
        Items = {},
        Charms = { "1", "2", "3", "4", "5", "6", "7", "13" },
        PremiumCharms = { "8", "9", "10", "11", "12", "14" }
    },
    Christmas_KillEffect_Crate_2024 = {
        Name = "Christmas Kill Effect Crate 2024",
        LayoutOrder = 5,
        UPoints = 275,
        UChristmas24 = 2750,
        Purchasable = os.time() <= DateTime.fromUniversalTime(2025, 1, 18).UnixTimestamp,
        WeightPool = {
            Event = 100
        },
        Items = {}
    }
};

for i, _ in v2.Skin_Crate.WeightPool do
    local WeightPool = v2.Skin_Crate.WeightPool;
    WeightPool[i] = WeightPool[i] * 1000;
end;

for _, descendant in script:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        for i, v in require(descendant) do
            if v2[i] then
                warn(i, "already exists");
            else
                v2[i] = v;
            end;
        end;
    end;
end;

for i, v in require(game:GetService("ReplicatedStorage").ReplicatedModules.PVEPackage.CharmsHandler.CharmsInfo) do
    if v.Available ~= false and (not v.Testing or game.GameId == 1900951801) then
        local v3;

        if v.Premium then
            v3 = v2.Skin_Crate.PremiumCharms;
        else
            v3 = v2.Skin_Crate.Charms;
        end;

        table.insert(v3, i);
    end;
end;

return v2;