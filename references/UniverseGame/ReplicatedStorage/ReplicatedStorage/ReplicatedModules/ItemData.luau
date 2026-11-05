  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local StandsModule = require(PathShortcuts.StandsModule);
require(PathShortcuts.ReplicatedModules.WeightManager);
local u1 = {
    ChestSkins = {},
    Rarities = {
        {
            Name = "Common",
            Weight = 1000,
            PremiumPoints = 4,
            Color = Color3.fromRGB(225, 225, 225)
        },
        {
            Name = "Uncommon",
            Weight = 700,
            PremiumPoints = 5,
            Color = Color3.fromRGB(125, 235, 150)
        },
        {
            Name = "Rare",
            Weight = 450,
            PremiumPoints = 5,
            Color = Color3.fromRGB(75, 150, 255)
        },
        {
            Name = "Epic",
            Weight = 150,
            PremiumPoints = 10,
            Color = Color3.fromRGB(175, 90, 255)
        },
        {
            Name = "Legendary",
            Weight = 40,
            PremiumPoints = 20,
            Color = Color3.fromRGB(255, 150, 75)
        },
        {
            Name = "Event",
            Weight = 30,
            PremiumPoints = 10,
            Color = Color3.fromRGB(255, 0, 255)
        },
        {
            Name = "Mythic",
            Weight = 10,
            PremiumPoints = 34,
            Color = Color3.fromRGB(255, 85, 0)
        },
        {
            Name = "Developer",
            Weight = 10,
            Color = Color3.fromRGB(255, 0, 0)
        },
        {
            Name = "Unobtainable",
            Weight = 20,
            Color = Color3.fromRGB(85, 255, 255)
        },
        {
            Name = "Seasonal Unobtainable",
            Weight = 20,
            Color = Color3.fromRGB(255, 203, 99)
        },
        {
            Name = "Limited",
            Weight = 0,
            PremiumPoints = 34,
            Color = Color3.fromRGB(255, 246, 124)
        },
        {
            Name = "Universal",
            Weight = 1,
            PremiumPoints = 34,
            Color = Color3.fromRGB(0, 0, 0)
        }
    },
    Rates = {
        Common_Skin = 200,
        Uncommon_Skin = 400,
        Rare_Skin = 800,
        Epic_Skin = 1600,
        Legendary_Skin = 3200
    },
    PremiumRates = {
        Common_Skin = 100,
        Uncommon_Skin = 200,
        Rare_Skin = 400,
        Epic_Skin = 800,
        Legendary_Skin = 1600
    },
    AbilityGacha = {
        UShards = 1000,
        UPoints = 50
    },
    Crates = require(script.Crates),
    Skins = require(script.Skins),
    Abilities = require(script.Abilities),
    Items = require(script.Items),
    XPMats = require(script.XPMats),
    Achievements = require(script.Achievements),
    Recipes = require(script.Recipes),
    Mounts = require(script.Mounts),
    Titles = require(script.Titles),
    KillEffects = require(script.KillEffects),
    BossSpawns = require(script.BossSpawns),
    Emotes = require(script.Emotes),
    SubPowers = require(script.SubPowers)
};

for i, v in u1.BossSpawns do
    if v.Testing and game.GameId == 1782832995 then
        u1.BossSpawns[i] = nil;
    end;
end;

local v2 = { "Skins", "Abilities", "Items", "XPMats", "Achievements", "Mounts", "KillEffects", "BossSpawns", "Emotes", "SubPowers" };
local u3 = {};

for i, v in pairs(StandsModule) do
    if i >= 1 then
        local v4 = string.format("ABILITY_%s", i);

        if u1.Abilities[v4] then
            u1.Abilities[v4] = TableUtil.Reconcile(u1.Abilities[v4], {
                Inherit = "BASE",
                Tradeable = true,
                AbilityId = i,
                Name = v
            });
        else
            u1.Abilities[v4] = {
                Inherit = "BASE",
                Tradeable = true,
                AbilityId = i,
                Name = v
            };
        end;
    end;
end;

for _, v in v2 do
    for i, _ in u1[v] do
        u3[i] = v;
    end;
end;

function u1.GetItemInfo(p5) -- Line: 155
    -- upvalues: u3 (copy), u1 (copy), TableUtil (copy)
    local v6 = u3[p5];
    local v7;

    if v6 and u1[v6] then
        v7 = u1[v6][p5];
    else
        v7 = nil;
    end;

    if v7 and not v7.ItemId then
        v7.ItemId = p5;
    end;

    if v7 then
        v7 = TableUtil.Copy(v7, true);
    end;

    return v7;
end;

local function CreateItemType(p8, p9) -- Line: 166
    for i, v in p8 do
        if v.Type ~= "Candy" then
            v.Type = p9;
            v.ItemId = v.ItemId or i;
        end;
    end;
end;

for i, v in u1.Abilities do
    if v.Type ~= "Candy" then
        v.Type = "Ability";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.Items do
    if v.Type ~= "Candy" then
        v.Type = "Item";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.Skins do
    if v.Type ~= "Candy" then
        v.Type = "Skin";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.Mounts do
    if v.Type ~= "Candy" then
        v.Type = "Mount";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.KillEffects do
    if v.Type ~= "Candy" then
        v.Type = "KillEffect";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.BossSpawns do
    if v.Type ~= "Candy" then
        v.Type = "BossSpawn";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.Emotes do
    if v.Type ~= "Candy" then
        v.Type = "Emote";
        v.ItemId = v.ItemId or i;
    end;
end;

for i, v in u1.SubPowers do
    if v.Type ~= "Candy" then
        v.Type = "SubPower";
        v.ItemId = v.ItemId or i;
    end;
end;

for _, v in u1.Crates do
    if v.Items then
        for i, v3 in v.Items do
            if type(v3) ~= "number" then
                local v10 = u1.GetItemInfo(i);

                if v10 then
                    local v11 = u1.Rarities[v10.Rarity];

                    if v11 and v11.Name then
                        v.Items[i] = v.WeightPool[v11.Name];
                    end;
                end;
            end;
        end;
    end;
end;

local function AddToCrateType(p12, p13) -- Line: 199
    -- upvalues: u1 (copy)
    if not p13.Available then
        return;
    end;

    if type(p13.Crates) ~= "table" then
        return;
    end;

    for _, v in p13.Crates do
        if u1.Crates[v] then
            local v14 = u1.Crates[v];

            if v14.Items[p12] then
                warn(p12, "already in", v);
            else
                v14.Items[p12] = v14.WeightPool[u1.Rarities[p13.Rarity].Name];
            end;
        else
            warn(v, "not found");
        end;
    end;

    for _, v in u1.Crates do
        if v.AutoAddRarities and (not v.AutoAddParser or v.AutoAddParser(p13)) and (table.find(v.AutoAddRarities, p13.Rarity) and not v.Items[p12]) then
            v.Items[p12] = v.WeightPool[u1.Rarities[p13.Rarity].Name];
        end;
    end;
end;

for i, v in pairs(u1.Skins) do
    local Rarity = v.Rarity;
    local Type = v.Type;
    local v15 = u1.Rarities[Rarity] and u1.Rarities[Rarity].Name;
    local v16 = i:split("_");
    v.LinkedAbilityId = v16[2];
    v.LinkedSkinId = v16[3];
    AddToCrateType(i, v);
    v.Currencies = {};

    if v.Purchasable and not v.Price then
        local v17 = u1.Rates[v15 .. "_" .. Type];
        v.Currencies.UShards = v17;
        v.Price = v17;
    end;

    if v.PremiumPurchasable and not v.PremiumPrice then
        local v18 = u1.PremiumRates[v15 .. "_" .. Type];
        v.Currencies.UPoints = v18;
        v.PremiumPrice = v18;
    end;
end;

for i, v in pairs(u1.KillEffects) do
    AddToCrateType(i, v);
end;

for i, v in pairs(u1.Abilities) do
    for i2, v3 in pairs({
        Name = "Invalid Ability",
        Inherit = "BASE",
        Tradeable = true,
        AbilityId = i
    }) do
        if v[i2] == nil then
            v[i2] = v3;
        end;
    end;
end;

for i, v in pairs(u1.Abilities) do
    if v.Inherit then
        u1.Abilities[i] = TableUtil.Reconcile(v, u1.Abilities[v.Inherit]);
    end;
end;

for i, v in pairs(u1.Items) do
    if v.Tradeable == nil then
        v.Tradeable = true;
    end;

    if v.Crates then
        for _, v3 in v.Crates do
            local v19 = u1.Crates[v3];

            if v19 and not v19.Items[i] then
                v19.Items[i] = v19.WeightPool[u1.Rarities[v.Rarity].Name];
            end;
        end;
    end;
end;

for i, v in u1.Skins do
    if v.ChestSkin then
        u1.ChestSkins[i] = u1.Crates.Skin_Crate.WeightPool[u1.Rarities[v.Rarity].Name];
    end;
end;

function u1.GetItemInfoNoCopy(p20) -- Line: 308
    -- upvalues: u1 (copy)
    local v21 = u1.Skins[p20] or (u1.Abilities[p20] or u1.Items[p20]) or (u1.Mounts[p20] or u1.XPMats[p20] or (u1.Achievements[p20] or u1.KillEffects[p20]));

    if v21 and not v21.ItemId then
        v21.ItemId = p20;
    end;

    return v21;
end;

function u1.GetItem(p22) -- Line: 320
    -- upvalues: u1 (copy)
    return {
        ItemId = p22,
        ItemInfo = u1.GetItemInfo(p22)
    };
end;

function u1.GetSkins() -- Line: 327
    -- upvalues: u1 (copy)
    return u1.Skins;
end;

function u1.GetSkin(p23, p24) -- Line: 331
    -- upvalues: u1 (copy), TableUtil (copy)
    local v25 = tostring(p23);
    local v26 = tostring(p24);
    local v27 = string.format("SKIN_%s_%s", v25, v26);
    local v28 = u1.Skins[v27];

    if not v28 then
        for i, v in pairs(u1.Skins) do
            local Skin = v.Skin;

            if type(Skin) == "table" and (tostring(Skin.Ability) == v25 and Skin.ID == v26) then
                v28 = v;
                v27 = i;
            end;
        end;
    end;

    return TableUtil.Copy({
        ItemId = v27,
        ItemInfo = v28
    }, true);
end;

function u1.GetAbilities() -- Line: 353
    -- upvalues: u1 (copy)
    return u1.Abilities;
end;

function u1.GetAbility(p29) -- Line: 357
    -- upvalues: TableUtil (copy), u1 (copy)
    local v30 = tostring(p29);
    local v31 = string.format("ABILITY_%s", v30);

    return TableUtil.Copy({
        Type = "Ability",
        ItemId = v31,
        ItemInfo = u1.Abilities[v31]
    }, true);
end;

function u1.GetItems(p32) -- Line: 367
    -- upvalues: u1 (copy)
    if p32 then
        return u1[p32];
    end;

    return u1.Items;
end;

function u1.GetItemByName(p33) -- Line: 371
    -- upvalues: u1 (copy), TableUtil (copy)
    for i, v in pairs(u1.Items) do
        if v.Name == p33 then
            return TableUtil.Copy({
                ItemId = i,
                ItemInfo = v
            }, true);
        end;
    end;
end;

function u1.GetRarity(p34) -- Line: 382
    -- upvalues: u1 (copy)
    return u1.Rarities[p34.Rarity];
end;

function u1.GetRarityData(p35) -- Line: 386
    -- upvalues: u1 (copy)
    return u1.Rarities[p35];
end;

function u1.GetRarityInfoByValue(p36) -- Line: 390
    -- upvalues: u1 (copy)
    return u1.Rarities[p36];
end;

function u1.GetRarityByName(p37) -- Line: 394
    -- upvalues: u1 (copy)
    for _, v in u1.Rarities do
        if v.Name == p37 then
            return v;
        end;
    end;
end;

function u1.GetRarityValueByName(p38) -- Line: 400
    -- upvalues: u1 (copy)
    for i, v in u1.Rarities do
        if v.Name == p38 then
            return i;
        end;
    end;
end;

function u1.GetSkinsFromCrate(p39, p40, p41) -- Line: 406
    -- upvalues: u1 (copy)
    local v42 = {};

    if u1.Crates[p39] then
        for i, v in pairs(u1.Skins) do
            local v43 = u1.Rarities[v.Rarity];

            if (not p41 or v.Reroll ~= false) and (type(v.Crates) == "table" and (table.find(v.Crates, p39) and (v43 and (v43.Name == p40 or p40 == "All"))) and v.Available) then
                table.insert(v42, i);
            end;
        end;
    end;

    return v42;
end;

function u1.GetAchievement(p44) -- Line: 421
    -- upvalues: u1 (copy), TableUtil (copy)
    local v45 = u1.Achievements[p44];

    if v45 and not v45.ItemId then
        v45.ItemId = p44;
    end;

    if v45 then
        v45 = TableUtil.Copy(v45, true);
    end;

    return v45;
end;

function u1.GetXPItems() -- Line: 431
    -- upvalues: u1 (copy)
    return u1.XPMats;
end;

function u1.GetCraftingRecipes() -- Line: 435
    -- upvalues: u1 (copy)
    return u1.Recipes.Crafting;
end;

function u1.GetAbilityRecipes() -- Line: 439
    -- upvalues: u1 (copy)
    return u1.Recipes.Abilities;
end;

function u1.GetCrateInfo(p46) -- Line: 443
    -- upvalues: u1 (copy)
    return u1.Crates[p46];
end;

function u1.GetCrates() -- Line: 447
    -- upvalues: u1 (copy)
    return u1.Crates;
end;

function u1.GetMounts() -- Line: 451
    -- upvalues: u1 (copy)
    return u1.Mounts;
end;

function u1.GetMount(p47) -- Line: 455
    -- upvalues: u1 (copy)
    return u1.Mounts[p47];
end;

function u1.GetKillEffects() -- Line: 459
    -- upvalues: u1 (copy)
    return u1.KillEffects;
end;

function u1.GetEmotes() -- Line: 463
    -- upvalues: u1 (copy)
    return u1.Emotes;
end;

function u1.GetTitles() -- Line: 468
    -- upvalues: u1 (copy)
    return u1.Titles;
end;

function u1.GetTitle(p48) -- Line: 472
    -- upvalues: u1 (copy)
    return u1.Titles[p48];
end;

return u1;