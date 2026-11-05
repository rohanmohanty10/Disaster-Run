  

 

local ToolItems = require(script.ToolItems);

for i, v in ToolItems do
    if v.Testing and game.GameId == 1782832995 then
        ToolItems[i] = nil;
    end;

    v.ItemType = "Item";

    if v.Tool ~= false then
        v.Tool = v.Name;
    end;

    if v.BlackMarketSellable ~= false then
        v.BlackMarketSellable = true;
    end;

    if v.Available ~= false then
        v.Available = true;
    end;

    if typeof(v.Crates) ~= "table" and v.Available ~= false then
        v.Crates = { "Common_Chest", "Rare_Chest", "Epic_Chest", "Legendary_Chest" };
    end;
end;

local ChestItems = require(script.ChestItems);
local v1 = 1000;

for _, v in { {
        UCoins = 10000,
        Rarity = 1
    }, {
        UCoins = 15000,
        Rarity = 1
    }, {
        UCoins = 20000,
        Rarity = 2
    }, {
        UCoins = 25000,
        Rarity = 2
    }, {
        UCoins = 30000,
        Rarity = 3
    }, {
        UCoins = 35000,
        Rarity = 3
    }, {
        UCoins = 50000,
        Rarity = 4
    }, {
        UCoins = 100000,
        Rarity = 5
    } } do
    ChestItems[`ITEM_{v1}`] = {
        UCoins = v.UCoins,
        Rarity = v.Rarity
    };
    v1 = v1 + 1;
end;

local v2 = 2000;

for _, v in { {
        ShardRarity = "Common",
        Amount = 1,
        Rarity = 1
    }, {
        ShardRarity = "Uncommon",
        Amount = 1,
        Rarity = 2
    }, {
        ShardRarity = "Rare",
        Amount = 1,
        Rarity = 3
    }, {
        ShardRarity = "Epic",
        Amount = 1,
        Rarity = 4
    }, {
        ShardRarity = "Legendary",
        Amount = 1,
        Rarity = 5
    } } do
    for _ = 1, v.Amount do
        ChestItems[`ITEM_{v2}`] = {
            ShardRarity = v.ShardRarity,
            Rarity = v.Rarity
        };
        v2 = v2 + 1;
    end;
end;

local v3 = { 5, 5, 5 };
local v4 = 3000;

for i, v in ToolItems do
    local Rarity = v.Rarity;

    if v3[Rarity] and v.Available ~= false then
        for _ = 1, v3[Rarity] do
            ChestItems[`ITEM_{v4}`] = {
                LinkedItemId = i,
                Rarity = Rarity
            };
            v4 = v4 + 1;
        end;
    end;
end;

local v5 = 4000;

for _, v in { {
        SkinRarity = "Rare",
        Amount = 3,
        Rarity = 3
    }, {
        SkinRarity = "Epic",
        Amount = 2,
        Rarity = 4
    }, {
        SkinRarity = "Legendary",
        Amount = 1,
        Rarity = 5
    } } do
    for _ = 1, v.Amount do
        ChestItems[`ITEM_{v5}`] = {
            SkinRarity = v.SkinRarity,
            Rarity = v.Rarity
        };
        v5 = v5 + 1;
    end;
end;

for _, v in ChestItems do
    v.Type = "Item";
    v.Tradeable = false;

    if v.UCoins then
        v.Name = `{v.UCoins / 1000}k UCoins`;
        v.Description = `Gives {v.UCoins / 1000}k UCoins`;
        v.ItemType = "UCoins";
    end;

    if v.ShardRarity then
        v.Name = `{v.ShardRarity} Ability Shard`;
        v.Description = `Gives random {v.ShardRarity} Ability Shard`;
        v.ItemType = "AbilityShard";
    end;

    if v.SkinRarity then
        v.Name = `{v.SkinRarity} Skin`;
        v.Description = `{v.SkinRarity} Skin Drop`;
        v.ItemType = "SkinItem";
    end;

    if typeof(v.Crates) ~= "table" then
        v.Crates = { "Common_Chest", "Rare_Chest", "Epic_Chest", "Legendary_Chest" };
    end;
end;

local CrateItems = require(script.CrateItems);

for _, v in CrateItems do
    v.Type = "Item";
    v.ItemType = "SkinCrate";
    v.Tradeable = false;
    local CrateAmount = v.CrateAmount;
    v.Name = `{CrateAmount}x {v.CrateType} Crate`;

    if v.CrateType == "Skin" then
        v.Description = `Unboxes {CrateAmount} {CrateAmount > 1 and "skins" or "skin"} ranging from Common to Mythic`;
    else
        v.Description = `Unboxes {CrateAmount} {v.CrateType} {CrateAmount > 1 and "skins" or "skin"}`;
    end;
end;

local v6 = {
    ToolItems,
    CrateItems,
    require(script.MiscItems),
    ChestItems
};
local v7 = {};

for _, v in ipairs(v6) do
    for i, v8 in pairs(v) do
        if v7[i] then
            warn(i, "DUPLICATE", v7[i], v8);
        else
            v7[i] = v8;
        end;
    end;
end;

return v7;