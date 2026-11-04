 

 

local v1 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local v2 = {
    Order = {},
    Skins = {}
};

for _, v in {
    { "CopperBite", "Copper Bite", "Common", "Ember" },
    { "Ashsteel", "Ashsteel", "Common", "Ember" },
    { "AmberSting", "Amber Sting", "Rare", "Ember" },
    { "RoseQuartz", "Rose Quartz", "Rare", "Ember" },
    { "MoltenFang", "Molten Fang", "Epic", "Ember" },
    { "SpectralReaper", "Spectral Reaper", "Epic", "Ember" },
    { "SolarPhoenix", "Solar Phoenix", "Legendary", "Ember" },
    { "VoidSovereign", "Void Sovereign", "Legendary", "Ember" },
    { "IronFang", "Iron Fang", "Common", "Celestial" },
    { "ForestEdge", "Forest Edge", "Common", "Celestial" },
    { "TidalShard", "Tidal Shard", "Rare", "Celestial" },
    { "VenomThorn", "Venom Thorn", "Rare", "Celestial" },
    { "StormTalon", "Storm Talon", "Epic", "Celestial" },
    { "Moonfang", "Moonfang", "Epic", "Celestial" },
    { "GlacialCrown", "Glacial Crown", "Legendary", "Celestial" },
    { "CelestialDragon", "Celestial Dragon", "Legendary", "Celestial" },
    { "Voidspine", "Voidspine", "Legendary", "Celestial", "Journey" },
    { "Bloodthorn", "Bloodthorn", "Legendary", "Celestial", "Journey" },
    { "VipersFang", "Viper\'s Fang", "Legendary", "Celestial", "Journey" },
    {
        "Vowbreaker",
        "Vowbreaker",
        "Legendary",
        "Limited",
        Source = "Limited · Bundle exclusive",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "Vowbreaker"
    },
    {
        "Soulbinder",
        "Soulbinder",
        "Mythical",
        "Limited",
        Source = "Limited · Bundle exclusive",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "Soulbinder",
        Hide = false
    },
    {
        "SoulbinderBlade",
        "Soulbinder Blade",
        "Legendary",
        "Limited",
        Source = "Limited · Soulbinder Blade",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "Soulbinder"
    },
    {
        "GrinnerBlades",
        "Grinner Blades",
        "Mythical",
        "Limited",
        Source = "Limited · Bundle exclusive",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "GrinnerBlades"
    },
    {
        "GrinnerBlade",
        "Grinner Blade",
        "Legendary",
        "Limited",
        Source = "Limited · Grinner Blade",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "GrinnerBlades"
    },
    {
        "Hallowreapers",
        "Hallowreapers",
        "Mythical",
        "Limited",
        Source = "Limited · Bundle exclusive",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "Hallowreapers"
    },
    {
        "DrownedCutlass",
        "Spectral Cutlass",
        "Mythical",
        "Limited",
        Source = "Limited · Bundle exclusive",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "DrownedCutlass"
    },
    {
        "Hexflask",
        "Hexflask",
        "Legendary",
        "Limited",
        Source = "Limited · Bundle exclusive",
        Collection = "LIMITED EXCLUSIVE",
        Sound = "Hexflask"
    },
    {
        "AlbiesCutlass",
        "Albie\'s Cutlass",
        "Mythical",
        "Exclusive",
        Source = "Owner exclusive",
        Collection = "OWNER EXCLUSIVE",
        Sound = "AlbiesCutlass",
        Hide = true
    },
    {
        "iSlice",
        "iSlice",
        "Epic",
        "Celestial",
        Hide = true
    },
    {
        "Hotdog",
        "Hotdog",
        "Legendary",
        "Event",
        Source = "Team Football reward",
        Collection = "FOOTBALL VS FÚTBOL",
        Sound = "Hotdog"
    },
    {
        "NumberOneFan",
        "#1 Fan",
        "Legendary",
        "Event",
        Source = "Team Fútbol reward",
        Collection = "FOOTBALL VS FÚTBOL",
        Sound = "FoamFinger"
    },
    {
        "SelfieStick",
        "Selfie Stick",
        "Epic",
        "Robux",
        Source = "Robux exclusive",
        Collection = "THE VALLEY SPECIAL",
        Sound = "BaseDagger"
    },
    {
        "ReaperScythe",
        "Reaper Scythe",
        "Legendary",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "ReaperScythe"
    },
    {
        "HollowMoon",
        "Hollow Moon",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "HollowMoon"
    },
    {
        "Hexbinder",
        "Hexbinder",
        "Legendary",
        "Halloween",
        Source = "Pumpkin Hunt",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "Hexbinder"
    },
    {
        "PumpkinSovereign",
        "Pumpkin Sovereign",
        "Mythical",
        "Halloween",
        Source = "Pumpkin Hunt",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "PumpkinSovereign"
    },
    {
        "ReapersTithe",
        "Reaper\'s Tithe",
        "Epic",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "ReapersTithe"
    },
    {
        "HallowedEmber",
        "Hallowed Ember",
        "Legendary",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "HallowedEmber"
    },
    {
        "PumpkinCleaver",
        "Pumpkin Cleaver",
        "Legendary",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "PumpkinCleaver"
    },
    {
        "PumpkinSpiceShank",
        "Pumpkin Spice Shank",
        "Epic",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "PumpkinSpiceShank"
    },
    {
        "GhoulBlade",
        "Ghoul Blade",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "GhoulBlade"
    },
    {
        "FunSizeFang",
        "Fun-Size Fang",
        "Legendary",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "FunSizeFang"
    },
    {
        "FemurShiv",
        "Femur Shiv",
        "Epic",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "FemurShiv"
    },
    {
        "Gravewarden",
        "Gravewarden",
        "Common",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "Gravewarden"
    },
    {
        "Witchroot",
        "Witchroot",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "Witchroot"
    },
    {
        "SpiderFang",
        "Spider Fang",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "SpiderFang"
    },
    {
        "PumpkinPatchBlade",
        "Pumpkin Patch Blade",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "PumpkinPatchBlade"
    },
    {
        "BoneShiv",
        "Bone Shiv",
        "Common",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "BoneShiv"
    },
    {
        "MummyWrapShiv",
        "Mummy Wrap Shiv",
        "Common",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "MummyWrapShiv"
    },
    {
        "BedsheetBoo",
        "Bedsheet Boo",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "BedsheetBoo"
    },
    {
        "CandyCornCleaver",
        "Candy Corn Cleaver",
        "Rare",
        "Halloween",
        Source = "Halloween collection",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "CandyCornCleaver"
    },
    {
        "FakeFinger",
        "Fake Finger",
        "Epic",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "FakeFinger"
    },
    {
        "ToffeeAppleStabber",
        "Toffee Apple Stabber",
        "Rare",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "ToffeeAppleStabber"
    },
    {
        "JackInTheBox",
        "Jack-in-the-Box",
        "Mythical",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "JackInTheBox"
    },
    {
        "LanternWarden",
        "Lantern Warden",
        "Legendary",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "LanternWarden"
    },
    {
        "CrowboneDirk",
        "Crowbone Dirk",
        "Rare",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "CrowboneDirk"
    },
    {
        "EclipseFang",
        "Eclipse Fang",
        "Mythical",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "EclipseFang"
    },
    {
        "PlasticPitchfork",
        "Plastic Pitchfork",
        "Rare",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "PlasticPitchfork"
    },
    {
        "ChatteringTeeth",
        "Chattering Teeth",
        "Epic",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "ChatteringTeeth"
    },
    {
        "PumpkinPieSlicer",
        "Pumpkin Pie Slicer",
        "Legendary",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "PumpkinPieSlicer"
    },
    {
        "GhostPepper",
        "Ghost Pepper",
        "Mythical",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "GhostPepper"
    },
    {
        "Wolfsbane",
        "Wolfsbane",
        "Epic",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "Wolfsbane"
    },
    {
        "BansheesCry",
        "Banshee\'s Cry",
        "Legendary",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "BansheesCry"
    },
    {
        "GlowstickShank",
        "Glowstick Shank",
        "Rare",
        "Halloween",
        Source = "Trick Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "GlowstickShank"
    },
    {
        "AshenSickle",
        "Ashen Sickle",
        "Rare",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "AshenSickle"
    },
    {
        "CoffinNail",
        "Coffin Nail",
        "Epic",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "CoffinNail"
    },
    {
        "WitchfireAthame",
        "Witchfire Athame",
        "Mythical",
        "Halloween",
        Source = "Treat Crate",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "WitchfireAthame"
    },
    {
        "SkeletonKey",
        "Skeleton Key",
        "Epic",
        "Halloween",
        Source = "Ghost Key Trader",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "SkeletonKey"
    },
    {
        "Ghostlock",
        "Ghostlock",
        "Legendary",
        "Halloween",
        Source = "Ghost Key Trader",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "Ghostlock"
    },
    {
        "TheLastDoor",
        "The Last Door",
        "Mythical",
        "Halloween",
        Source = "Ghost Key Trader",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "TheLastDoor"
    },
    {
        "GraveShard",
        "Grave Shard",
        "Epic",
        "Halloween",
        Source = "Fallen King reward",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "GraveShard"
    },
    {
        "ShrineBreaker",
        "Shrine Breaker",
        "Legendary",
        "Halloween",
        Source = "Fallen King reward",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "ShrineBreaker"
    },
    {
        "FallenAxes",
        "Fallen Axes (Red)",
        "Mythical",
        "Halloween",
        Source = "Fallen King live fight",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "FallenAxes"
    },
    {
        "FallenAxesBlue",
        "Fallen Axes (Blue)",
        "Mythical",
        "Halloween",
        Source = "Fallen King re-summon",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "FallenAxesBlue"
    },
    {
        "Nightrend",
        "Nightrend",
        "Legendary",
        "Halloween",
        Source = "Coming soon",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "CelestialLegendary",
        Hide = true
    },
    {
        "RuneboundSword",
        "Runebound Sword",
        "Legendary",
        "Halloween",
        Source = "Coming soon",
        Collection = "HALLOWEEN COLLECTION",
        Sound = "CelestialLegendary",
        Hide = true
    }
} do
    local table_unpack_ret, v3, v4, v5, v6 = table.unpack(v);
    local v7 = v5 == "Ember" and "Ember & Shadow" or v5;
    local v8 = v6 == "Journey";
    table.insert(v2.Order, table_unpack_ret);
    local Skins = v2.Skins;
    local table_freeze = table.freeze;
    local v9 = {
        Available = false,
        EquipReady = true,
        Name = string.upper(v3),
        SourceName = v3,
        Subtitle = v4 .. " · " .. (v.Source or (v8 and "Valley Journey reward" or v7 .. " collection")),
        Description = v4 == "Mythical" and "+1 movement speed · 1.25 seconds shorter item and ability cooldowns · 0.4 seconds shorter dodge cooldown · a kill effect." or (v4 == "Legendary" and "+0.85 movement speed · 0.85 seconds shorter item and ability cooldowns · 0.3 seconds shorter dodge cooldown." or (v4 == "Epic" and "+0.35 movement speed · 0.35 seconds shorter item and ability cooldowns · 0.1 seconds shorter dodge cooldown." or "A permanent knife skin.")),
        Model = table_unpack_ret,
        SoundProfile = v.Sound or v5 .. v4,
        Accent = v1[v4],
        Collection = v.Collection or (v8 and "VALLEY JOURNEY" or string.upper(v7) .. " CRATE"),
        Rarity = v4
    };

    if v8 or not (v5 == "Ember" and true or v5 == "Celestial") then
        v5 = nil;
    end;

    v9.Crate = v5;
    v9.Hide = v.Hide == true;
    v9.HideOwned = v.HideOwned == true;
    Skins[table_unpack_ret] = table_freeze(v9);
end;

table.freeze(v2.Order);
table.freeze(v2.Skins);

return table.freeze(v2);