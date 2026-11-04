 

 

local u1 = {
    Order = { "Basic", "Premium", "Ember", "Celestial", "Emote" },
    DuplicateGems = {
        Common = 10,
        Rare = 20,
        Epic = 40,
        Legendary = 75,
        Mythical = 150
    },
    Crates = {
        Basic = {
            Name = "Basic Crate",
            WorldModel = "BasicCrate",
            Coins = 1000,
            ProductId = 3720074190,
            Icon = "rbxassetid://73417887661528",
            Bundles = {
                [3] = {
                    ProductId = 3720074217
                },
                [10] = {
                    ProductId = 3720074244
                }
            },
            Accent = Color3.fromRGB(150, 205, 120),
            Entries = { {
                    Skin = "CopperBite",
                    Weight = 1700,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "Ashsteel",
                    Weight = 1700,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "IronFang",
                    Weight = 1700,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "ForestEdge",
                    Weight = 1700,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "AmberSting",
                    Weight = 675,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "RoseQuartz",
                    Weight = 675,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "TidalShard",
                    Weight = 675,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "VenomThorn",
                    Weight = 675,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "MoltenFang",
                    Weight = 250,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "StormTalon",
                    Weight = 250,
                    Rarity = "Epic",
                    DuplicateGems = 40
                } }
        },
        Premium = {
            Name = "Premium Crate",
            WorldModel = "PremiumCrate",
            Coins = 5000,
            ProductId = 3720074262,
            Icon = "rbxassetid://84724569588872",
            Bundles = {
                [3] = {
                    ProductId = 3720074289
                },
                [10] = {
                    ProductId = 3720074309
                }
            },
            Accent = Color3.fromRGB(242, 191, 89),
            Entries = { {
                    Skin = "AmberSting",
                    Weight = 3000,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "TidalShard",
                    Weight = 3000,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "MoltenFang",
                    Weight = 800,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "SpectralReaper",
                    Weight = 800,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "StormTalon",
                    Weight = 800,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "Moonfang",
                    Weight = 800,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "SolarPhoenix",
                    Weight = 200,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                }, {
                    Skin = "VoidSovereign",
                    Weight = 200,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                }, {
                    Skin = "GlacialCrown",
                    Weight = 200,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                }, {
                    Skin = "CelestialDragon",
                    Weight = 200,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                } }
        },
        Ember = {
            Name = "Ember & Shadow Crate",
            WorldModel = "EmberCrate",
            EndsAt = 1792256400,
            Gems = 750,
            ProductId = 3715710929,
            Icon = "rbxassetid://84724569588872",
            Bundles = {
                [3] = {
                    ProductId = 3716645176
                },
                [10] = {
                    ProductId = 3716645180
                }
            },
            Accent = Color3.fromRGB(245, 164, 82),
            Entries = { {
                    Skin = "CopperBite",
                    Weight = 3000,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "Ashsteel",
                    Weight = 3000,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "AmberSting",
                    Weight = 1250,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "RoseQuartz",
                    Weight = 1250,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "MoltenFang",
                    Weight = 600,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "SpectralReaper",
                    Weight = 600,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "SolarPhoenix",
                    Weight = 150,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                }, {
                    Skin = "VoidSovereign",
                    Weight = 150,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                } }
        },
        Celestial = {
            Name = "Celestial Crate",
            WorldModel = "CelestialCrate",
            EndsAt = 1792256400,
            Gems = 750,
            ProductId = 3715710934,
            Icon = "rbxassetid://73417887661528",
            Bundles = {
                [3] = {
                    ProductId = 3716645187
                },
                [10] = {
                    ProductId = 3716645188
                }
            },
            Accent = Color3.fromRGB(152, 181, 250),
            Entries = { {
                    Skin = "IronFang",
                    Weight = 3000,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "ForestEdge",
                    Weight = 3000,
                    Rarity = "Common",
                    DuplicateGems = 10
                }, {
                    Skin = "TidalShard",
                    Weight = 1250,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "VenomThorn",
                    Weight = 1250,
                    Rarity = "Rare",
                    DuplicateGems = 20
                }, {
                    Skin = "StormTalon",
                    Weight = 600,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "Moonfang",
                    Weight = 600,
                    Rarity = "Epic",
                    DuplicateGems = 40
                }, {
                    Skin = "GlacialCrown",
                    Weight = 150,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                }, {
                    Skin = "CelestialDragon",
                    Weight = 150,
                    Rarity = "Legendary",
                    DuplicateGems = 75
                } }
        }
    }
};
u1.Crates.Emote = {
    Name = "Emote Crate",
    WorldModel = "EmoteCrate",
    Kind = "Emote",
    OpenAnywhere = true,
    Gems = 250,
    ProductId = 3716725849,
    Icon = "rbxassetid://138564590400026",
    Bundles = {
        [3] = {
            ProductId = 3716725852
        },
        [10] = {
            ProductId = 3716725853
        }
    },
    Accent = Color3.fromRGB(255, 120, 200),
    Entries = {
        {
            Emote = "BoogieDown",
            Weight = 1000,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Emote = "Skipping",
            Weight = 1000,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Emote = "PenguinWalk",
            Weight = 1000,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Emote = "RussianWalk",
            Weight = 1000,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Emote = "Distraction",
            Weight = 1000,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Emote = "OhARat",
            Weight = 1000,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Emote = "RatDance",
            Weight = 500,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Emote = "Caffeinated",
            Weight = 500,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Emote = "FastDancer",
            Weight = 500,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Emote = "Marisa",
            Weight = 500,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Emote = "CaliforniaGirls",
            Weight = 450,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Emote = "YaYaYing",
            Weight = 450,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Emote = "Marat",
            Weight = 450,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Emote = "EDanceSupreme",
            Weight = 325,
            Rarity = "Legendary",
            DuplicateGems = 75
        },
        {
            Emote = "DaBabyDance",
            Weight = 325,
            Rarity = "Legendary",
            DuplicateGems = 75
        }
    }
};
u1.Crates.HalloweenEmote = {
    Name = "Halloween Emote Crate",
    WorldModel = "HalloweenEmoteCrate",
    Kind = "Emote",
    OpenAnywhere = true,
    Halloween = true,
    CandyCorn = 750,
    ProductId = 0,
    Icon = "rbxassetid://125021218399148",
    Accent = Color3.fromRGB(255, 120, 200),
    Entries = { {
            Emote = "ZombieShuffle",
            Weight = 2000,
            Rarity = "Common",
            DuplicateGems = 10
        }, {
            Emote = "GhostFloat",
            Weight = 2000,
            Rarity = "Common",
            DuplicateGems = 10
        }, {
            Emote = "CandyToss",
            Weight = 2000,
            Rarity = "Common",
            DuplicateGems = 10
        }, {
            Emote = "WitchsBrew",
            Weight = 2000,
            Rarity = "Rare",
            DuplicateGems = 20
        }, {
            Emote = "JumpScare",
            Weight = 1350,
            Rarity = "Epic",
            DuplicateGems = 40
        }, {
            Emote = "SpiritPossession",
            Weight = 325,
            Rarity = "Legendary",
            DuplicateGems = 75
        }, {
            Emote = "RiseFromTheGrave",
            Weight = 325,
            Rarity = "Legendary",
            DuplicateGems = 75
        } }
};
u1.Crates.HalloweenTrick = {
    Name = "Trick Crate",
    WorldModel = "TrickCrate",
    Halloween = true,
    CandyCorn = 750,
    ProductId = 0,
    Icon = "rbxassetid://83040338500900",
    Accent = Color3.fromRGB(176, 98, 255),
    Entries = {
        {
            Skin = "MummyWrapShiv",
            Weight = 3450,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Skin = "BedsheetBoo",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "CandyCornCleaver",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "ToffeeAppleStabber",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "PumpkinSpiceShank",
            Weight = 700,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Skin = "FakeFinger",
            Weight = 700,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Skin = "FunSizeFang",
            Weight = 200,
            Rarity = "Legendary",
            DuplicateGems = 75
        },
        {
            Skin = "JackInTheBox",
            Weight = 25,
            Rarity = "Mythical",
            DuplicateGems = 150
        },
        {
            Skin = "PlasticPitchfork",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "ChatteringTeeth",
            Weight = 700,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Skin = "PumpkinPieSlicer",
            Weight = 200,
            Rarity = "Legendary",
            DuplicateGems = 75
        },
        {
            Skin = "GhostPepper",
            Weight = 25,
            Rarity = "Mythical",
            DuplicateGems = 150
        },
        {
            Skin = "GlowstickShank",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        }
    }
};
u1.Crates.HalloweenTreat = {
    Name = "Treat Crate",
    WorldModel = "TreatCrate",
    Halloween = true,
    CandyCorn = 750,
    ProductId = 0,
    Icon = "rbxassetid://110810440333744",
    Accent = Color3.fromRGB(255, 132, 28),
    Entries = {
        {
            Skin = "Gravewarden",
            Weight = 4050,
            Rarity = "Common",
            DuplicateGems = 10
        },
        {
            Skin = "Witchroot",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "HollowMoon",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "CrowboneDirk",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "ReapersTithe",
            Weight = 700,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Skin = "HallowedEmber",
            Weight = 200,
            Rarity = "Legendary",
            DuplicateGems = 75
        },
        {
            Skin = "LanternWarden",
            Weight = 200,
            Rarity = "Legendary",
            DuplicateGems = 75
        },
        {
            Skin = "EclipseFang",
            Weight = 25,
            Rarity = "Mythical",
            DuplicateGems = 150
        },
        {
            Skin = "Wolfsbane",
            Weight = 700,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Skin = "BansheesCry",
            Weight = 200,
            Rarity = "Legendary",
            DuplicateGems = 75
        },
        {
            Skin = "AshenSickle",
            Weight = 800,
            Rarity = "Rare",
            DuplicateGems = 20
        },
        {
            Skin = "CoffinNail",
            Weight = 700,
            Rarity = "Epic",
            DuplicateGems = 40
        },
        {
            Skin = "WitchfireAthame",
            Weight = 25,
            Rarity = "Mythical",
            DuplicateGems = 150
        }
    }
};
u1.ProductGrants = {
    [3715710929] = {
        UniverseId = 10764627709,
        Crate = "Ember"
    },
    [3715710934] = {
        UniverseId = 10764627709,
        Crate = "Celestial"
    },
    [3716645176] = {
        UniverseId = 10764627709,
        Crate = "Ember",
        Count = 3
    },
    [3716645180] = {
        UniverseId = 10764627709,
        Crate = "Ember",
        Count = 10
    },
    [3716645187] = {
        UniverseId = 10764627709,
        Crate = "Celestial",
        Count = 3
    },
    [3716645188] = {
        UniverseId = 10764627709,
        Crate = "Celestial",
        Count = 10
    },
    [3716725849] = {
        UniverseId = 10764627709,
        Crate = "Emote"
    },
    [3716725852] = {
        UniverseId = 10764627709,
        Crate = "Emote",
        Count = 3
    },
    [3716725853] = {
        UniverseId = 10764627709,
        Crate = "Emote",
        Count = 10
    },
    [3720074190] = {
        UniverseId = 10764627709,
        Crate = "Basic"
    },
    [3720074217] = {
        UniverseId = 10764627709,
        Crate = "Basic",
        Count = 3
    },
    [3720074244] = {
        UniverseId = 10764627709,
        Crate = "Basic",
        Count = 10
    },
    [3720074262] = {
        UniverseId = 10764627709,
        Crate = "Premium"
    },
    [3720074289] = {
        UniverseId = 10764627709,
        Crate = "Premium",
        Count = 3
    },
    [3720074309] = {
        UniverseId = 10764627709,
        Crate = "Premium",
        Count = 10
    }
};

for _, v in u1.Crates do
    v.Bundles = v.Bundles or {};
    local Bundles = v.Bundles;
    local v2 = {};
    local v3;

    if v.Coins then
        v3 = nil;
    else
        v3 = v.Gems;
    end;

    v2.Gems = v3;
    v2.Coins = v.Coins;
    v2.ProductId = v.ProductId;
    Bundles[1] = v2;
end;

function u1.get(p4) -- Line: 234
    -- upvalues: u1 (copy)
    return type(p4) == "string" and u1.Crates[p4] or nil;
end;

function u1.pick(p5, p6) -- Line: 237
    -- upvalues: u1 (copy)
    local v7 = u1.get(p5);
    local v8;

    if v7 then
        if type(p6) == "number" and (p6 % 1 == 0 and p6 >= 1) then
            v8 = p6 <= 10000;
        else
            v8 = false;
        end;
    else
        v8 = v7;
    end;

    assert(v8, "Invalid crate roll");
    local v9 = 0;

    for _, v in v7.Entries do
        v9 = v9 + v.Weight;

        if p6 <= v9 then
            return v;
        end;
    end;

    error("Crate weights must total 10000");
end;

function u1.poseEmote(p10) -- Line: 251
    -- upvalues: u1 (copy)
    local v11 = u1.get(p10);

    if v11 and (v11.Kind == "Emote" and #v11.Entries ~= 0) then
        return v11.Entries[math.random(#v11.Entries)].Emote;
    end;

    return nil;
end;

function u1.offer(p12, p13) -- Line: 259
    -- upvalues: u1 (copy)
    local v14 = u1.get(p12);

    return v14 and v14.Bundles[p13] or nil;
end;

return u1;