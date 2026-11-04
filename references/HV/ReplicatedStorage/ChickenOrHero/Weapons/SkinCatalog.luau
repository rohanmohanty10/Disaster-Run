 

 

local ShopConfig = require(script.Parent.ShopConfig);
local OfferRules = require(script.Parent.OfferRules);
local u1 = {
    Default = "BaseDagger",
    Order = { "BaseDagger", "VIPDagger", "DevelopersPencil", "SecretPencil", "CloneDagger", "GhostScythe", "SpoonDagger", "IceCreamDagger", "BalloonDagger", "TopWinsDagger", "OwnersTrident" },
    Skins = {
        CloneDagger = {
            Name = "CLONE DAGGER",
            Subtitle = "One of you was already a problem.",
            Description = "Split into three for 12 seconds. Runner decoys distract; catcher clones earn catches for you. 45-second recharge; refreshes when you become a catcher and each match.",
            Model = "CloneDagger",
            SoundProfile = "CloneDagger",
            Collection = "THE VALLEY EXCLUSIVE",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(104, 172, 255)
        },
        GhostScythe = {
            Name = "GHOST SCYTHE",
            Subtitle = "Here one moment. Gone the next.",
            Description = "Fade to 80% invisibility and become fully immune for 2 seconds. 45-second recharge; refreshes each match.",
            Model = "GhostScythe",
            SoundProfile = "GhostScythe",
            Collection = "HALLOWEEN EXCLUSIVE",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(166, 242, 232)
        },
        OwnersTrident = {
            Name = "OWNER’S TRIDENT",
            Subtitle = "A heavenly problem.",
            Description = "Three points. One judgement. The owner’s signature trident, crowned in gold and choir.",
            Model = "OwnersTrident",
            SoundProfile = "OwnersTrident",
            Collection = "OWNER’S SIGNATURE",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(255, 205, 106)
        },
        BaseDagger = {
            Name = "VALLEY ORIGINAL",
            Subtitle = "The one that started it.",
            Description = "Clean steel. A familiar grip. Your first knife, ready for every crossing.",
            Model = "BaseDagger",
            SoundProfile = "BaseDagger",
            Collection = "STANDARD ISSUE",
            Available = true,
            DefaultOwned = true,
            Accent = Color3.fromRGB(224, 213, 176)
        },
        VIPDagger = {
            Name = "VIP DAGGER",
            Subtitle = "A little extra edge.",
            Description = "Gold finish. Blue jewel. A sharp welcome to the VIP club. Included with VIP.",
            Model = "VIPDagger",
            SoundProfile = "VIPDagger",
            Collection = "VIP EXCLUSIVE",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(237, 190, 77)
        },
        DevelopersPencil = {
            Name = "DEVELOPER’S PENCIL",
            Subtitle = "Making a few pointed changes.",
            Description = "For crossing out bugs. And occasionally, runners.",
            Model = "DevelopersPencil",
            SoundProfile = "DevelopersPencil",
            Collection = "EARNED IN THE VALLEY",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(245, 198, 71)
        },
        SecretPencil = {
            Name = "SECRET PENCIL",
            Subtitle = "A surprise with a sharp point.",
            Description = "A secret knife won from the spin wheel. Yours to keep forever.",
            Model = "SecretPencil",
            SoundProfile = "DevelopersPencil",
            Collection = "SPIN WHEEL EXCLUSIVE",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(255, 211, 78)
        },
        SpoonDagger = {
            Name = "THE SPOON",
            Subtitle = "A different kind of sharp.",
            Description = "Someone brought a spoon to a knife fight. Breakfast is cancelled.",
            Model = "SpoonDagger",
            SoundProfile = "SpoonDagger",
            Collection = "THE VALLEY SPECIAL",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(137, 211, 196)
        },
        IceCreamDagger = {
            Name = "ICE CREAM SCYTHE",
            Subtitle = "Your last scoop.",
            Description = "An oversized dessert with a dangerous curve. A frosty finish, served with a side of chaos.",
            Model = "IceCreamDagger",
            SoundProfile = "IceCreamDagger",
            Collection = "SEASON 1 PREMIUM · TIER 30",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(186, 167, 255)
        },
        BalloonDagger = {
            Name = "PARTY POPPER",
            Subtitle = "Inflated ego. Inflated knife.",
            Description = "Invite a friend who joins through your invite. Unlock this oversized balloon dagger forever.",
            Model = "BalloonDagger",
            SoundProfile = "BalloonDagger",
            Collection = "BRING A FRIEND",
            Available = false,
            EquipReady = true,
            RewardKey = "FriendReferral",
            Accent = Color3.fromRGB(255, 128, 185)
        },
        TopWinsDagger = {
            Name = "THE NUMBER ONE",
            Subtitle = "You reached the summit.",
            Description = "Reach #1 on the global Wins leaderboard. The title belongs to today\'s leader. This trophy stays yours forever.",
            Model = "TopWinsDagger",
            SoundProfile = "TopWinsDagger",
            Collection = "GLOBAL WINS TROPHY",
            Available = false,
            EquipReady = true,
            RewardKey = "TopWins",
            Accent = Color3.fromRGB(255, 215, 107)
        }
    }
};
local FantasySkinCatalog = require(script.Parent.FantasySkinCatalog);

for _, v in FantasySkinCatalog.Order do
    table.insert(u1.Order, v);
    u1.Skins[v] = FantasySkinCatalog.Skins[v];
end;

local ComedySkinCatalog = require(script.Parent.ComedySkinCatalog);

for _, v in ComedySkinCatalog.Order do
    table.insert(u1.Order, v);
    u1.Skins[v] = ComedySkinCatalog.Skins[v];
end;

local v2 = {
    Kitsune = "Kitsune",
    ImmortalKitsune = "Kitsune",
    DualImmortalKitsune = "Kitsune",
    Kusarigama = "Kusarigama",
    VoidKusarigama = "Kusarigama",
    DualVoidKusarigamas = "Kusarigama",
    UltimateVoidBlades = "Kusarigama"
};

for _, v in {
    {
        "Kitsune",
        "Kitsune",
        "Base · Spin Wheel",
        Color3.fromRGB(175, 185, 192),
        true
    },
    {
        "ImmortalKitsune",
        "Immortal Kitsune",
        "Upgraded · made from 5 Kitsunes",
        Color3.fromRGB(92, 173, 238),
        true
    },
    {
        "DualImmortalKitsune",
        "Dual Immortal Kitsune",
        "Dual · made from 5 Immortal Kitsunes",
        Color3.fromRGB(183, 123, 244),
        true
    },
    {
        "Kusarigama",
        "Kusarigama",
        "Base · Spin Wheel",
        Color3.fromRGB(175, 185, 192),
        true
    },
    {
        "VoidKusarigama",
        "Void Kusarigama",
        "Upgraded · made from 5 Kusarigamas",
        Color3.fromRGB(92, 173, 238),
        true
    },
    {
        "DualVoidKusarigamas",
        "Dual Void Kusarigamas",
        "Dual · made from 5 Void Kusarigamas",
        Color3.fromRGB(183, 123, 244),
        true
    },
    {
        "UltimateVoidBlades",
        "Ultimate Void Blades",
        "Ultimate · one of each Dual, fused",
        Color3.fromRGB(242, 191, 89),
        false
    }
} do
    local table_unpack_ret, v3, v4, v5, v6 = table.unpack(v);
    table.insert(u1.Order, table_unpack_ret);
    u1.Skins[table_unpack_ret] = {
        Collection = "VOID BLADES EVENT",
        Available = false,
        EquipReady = true,
        Name = string.upper(v3),
        SourceName = v3,
        Subtitle = v4,
        Description = v6 and "A Void Blades event knife. Merge copies at the COMBINE machine on the way to the Ultimate Void Blades." or "The only Ultimate: fused from a Dual Immortal Kitsune and Dual Void Kusarigamas.",
        Model = table_unpack_ret,
        SoundProfile = v2[table_unpack_ret] or "CelestialLegendary",
        Accent = v5,
        Stackable = v6
    };
end;

table.insert(u1.Order, "InfectedKnife");
u1.Skins.InfectedKnife = {
    Name = "INFECTED KNIFE",
    Subtitle = "Catch them. Spread it.",
    Description = "Every runner you catch with it is infected and gets the knife too. All infected knives upgrade as the outbreak spreads.",
    Model = "InfectedKnife",
    SoundProfile = "InfectedKnife",
    Collection = "THE OUTBREAK",
    Available = false,
    EquipReady = true,
    Accent = Color3.fromRGB(150, 255, 90)
};
local v7 = u1.Skins[ShopConfig.Earnable.SkinId];

if v7 then
    v7.Offer = {
        Currency = "gems",
        Price = ShopConfig.Earnable.Price,
        StartsAt = ShopConfig.Earnable.StartsAt,
        EndsAt = ShopConfig.Earnable.EndsAt
    };
end;

function u1.canBuy(p8, p9) -- Line: 224
    -- upvalues: u1 (copy), OfferRules (copy)
    local v10 = u1.get(p8);
    local v11;

    if v10 == nil or (v10.Available ~= true or (v10.EquipReady == false or (v10.Offer == nil or (type(v10.Offer.Price) ~= "number" or (v10.Offer.Price <= 0 or v10.Offer.Price % 1 ~= 0))))) then
        v11 = false;
    else
        v11 = OfferRules.active(v10.Offer, p9 or os.time());
    end;

    return v11;
end;

u1.SoundEvents = { "Equip", "Windup", "Swing", "Dive", "Hit", "Sheath", "Cancel", "DiveHit" };

function u1.get(p12) -- Line: 237
    -- upvalues: u1 (copy)
    return type(p12) == "string" and u1.Skins[p12] or nil;
end;

return u1;