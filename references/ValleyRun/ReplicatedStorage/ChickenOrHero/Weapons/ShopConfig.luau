 

 

local OfferRules = require(script.Parent.OfferRules);
local u1 = {
    WeekEnding = {
        Year = 2026,
        Month = 9,
        Day = 26
    }
};
local WeekEnding = u1.WeekEnding;
local v2 = OfferRules.ukSaturdayDeadline(WeekEnding.Year, WeekEnding.Month, WeekEnding.Day);
u1.FlagshipWeekEnding = {
    Year = 2026,
    Month = 10,
    Day = 3
};
local FlagshipWeekEnding = u1.FlagshipWeekEnding;
local v3 = OfferRules.ukSaturdayDeadline(FlagshipWeekEnding.Year, FlagshipWeekEnding.Month, FlagshipWeekEnding.Day);
u1.Earnable = {
    SkinId = "DevelopersPencil",
    Price = 2000,
    StartsAt = 0,
    Eyebrow = "EARNED IN THE VALLEY",
    Title = "YOUR NEXT FIND",
    Tagline = "Cross. Collect. Claim.",
    Description = "A new gem-earned knife will appear here.",
    Footnote = "Collect gems during crossings.",
    EndsAt = v2
};
u1.Display = {
    MaxDistance = 50,
    PromptDistance = 11,
    AnimationDistance = 90,
    SoundDistance = 12
};
u1.Flagship = {
    SkinId = "CloneDagger",
    StartsAt = 0,
    OfferKey = "Clone",
    Eyebrow = "THE VALLEY EXCLUSIVE",
    Title = "CLONE DAGGER",
    Tagline = "One of you was already a problem.",
    Description = "Blue energy. Gold trim. A few extra yous, for emotional support.",
    Footnote = "2 clones · 12 seconds · 45-second cooldown. Refreshes on becoming a chaser and each match.",
    EndsAt = v3
};
u1.GhostFlagship = {
    SkinId = "GhostScythe",
    StartsAt = 1791043200,
    EndsAt = 1791918000,
    OfferKey = "Ghost",
    Eyebrow = "HALLOWEEN EXCLUSIVE",
    Title = "GHOST SCYTHE",
    Tagline = "Here one moment. Gone the next.",
    Description = "Fade to 80% invisibility and become fully immune for 2 seconds.",
    Footnote = "2-second spectral escape · 45-second cooldown. Refreshes each match."
};
u1.FootballFlagship = {
    SkinId = "Football",
    StartsAt = 1791651600,
    EndsAt = 1792256400,
    OfferKey = "Football",
    New = true,
    Eyebrow = "LIMITED · GAME DAY",
    Title = "FOOTBALL",
    Tagline = "Tuck it. Truck it. Score.",
    Description = "Shoulder a Chaser right before their hit lands, and run as Hero to a full game-day show. Comes with the Touchdown emote.",
    Footnote = "Trucking · 0.25-second window · 25-second cooldown. Hero and last runners get the catch, the field and the touchdown."
};
u1.FutbolFlagship = {
    SkinId = "Futbol",
    StartsAt = 1791651600,
    EndsAt = 1792256400,
    OfferKey = "Futbol",
    New = true,
    Eyebrow = "LIMITED · MATCH DAY",
    Title = "FUTBOL",
    Tagline = "Step over. Burst past. Score.",
    Description = "Fake one way, burst the other, and run as Hero to a full match-day show. Comes with the Ball Juggle emote.",
    Footnote = "Step Over · two dashes in one · 30-second cooldown. Hero and last runners get the juggle, the pitch and the goal."
};
u1.Flagships = {
    u1.Flagship,
    u1.FootballFlagship,
    u1.FutbolFlagship,
    u1.GhostFlagship
};

if game.GameId == 10768621983 then
    u1.Flagship.EndsAt = 1;
    u1.FootballFlagship.StartsAt = 0;
    u1.FutbolFlagship.StartsAt = 0;
end;

function u1.isNew(p4, p5) -- Line: 49
    if type(p4) == "table" and p4.New == true then
        return p4.StartsAt <= 0 and true or (p5 or os.time()) < p4.StartsAt + (p4.NewDays or 4) * 86400;
    end;

    return false;
end;

function u1.featured(p6) -- Line: 53
    -- upvalues: u1 (copy)
    local v7 = p6 or os.time();
    local v8 = nil;
    local v9 = nil;

    for _, v in u1.Flagships do
        if v.StartsAt <= v7 and (v.EndsAt == 0 or v7 < v.EndsAt) then
            return v;
        end;

        if v7 < v.StartsAt and (not v8 or v.StartsAt < v8.StartsAt) then
            v8 = v;
        end;

        v9 = v;
    end;

    return v8 or v9;
end;

function u1.featuredAll(p10) -- Line: 65
    -- upvalues: u1 (copy)
    local v11 = p10 or os.time();
    local v12 = {};

    for _, v in u1.Flagships do
        if v.StartsAt <= v11 and (v.EndsAt == 0 or v11 < v.EndsAt) then
            table.insert(v12, v);
        end;
    end;

    return v12;
end;

function u1.flagship(p13) -- Line: 74
    -- upvalues: u1 (copy)
    for _, v in u1.Flagships do
        if v.OfferKey == p13 then
            return v;
        end;
    end;

    return nil;
end;

u1.AdditionalKnives = { {
        SkinId = "SelfieStick",
        OfferKey = "Selfie",
        Eyebrow = "THE VALLEY SPECIAL",
        Title = "SELFIE STICK",
        Tagline = "Say cheese.",
        Description = "Every catch deserves a picture. An Epic knife with its speed and cooldown perks.",
        Footnote = "Robux exclusive · yours to keep."
    } };
u1.Passes = {
    Clone = {
        Name = "Clone Dagger",
        SkinId = "CloneDagger"
    },
    Ghost = {
        Name = "Ghost Scythe",
        SkinId = "GhostScythe"
    },
    IceCream = {
        Name = "Ice Cream Scythe",
        SkinId = "IceCreamDagger"
    },
    Spoon = {
        Name = "The Spoon",
        SkinId = "SpoonDagger"
    },
    Selfie = {
        Name = "Selfie Stick",
        SkinId = "SelfieStick"
    },
    Football = {
        Name = "Football",
        SkinId = "Football"
    },
    Futbol = {
        Name = "Futbol",
        SkinId = "Futbol"
    },
    DoubleXP = {
        Name = "2× XP",
        Multiplier = 2
    },
    VIP = {
        Name = "VIP",
        Multiplier = 1.25,
        RewardSkinId = "VIPDagger"
    }
};
u1.Packs = {
    {
        Key = "Coins1",
        Currency = "coins",
        Amount = 100,
        Label = "POCKET CHANGE"
    },
    {
        Key = "Coins2",
        Icon = "rbxassetid://121702830882736",
        Currency = "coins",
        Amount = 250,
        Label = "A LITTLE EXTRA"
    },
    {
        Key = "Coins3",
        Icon = "rbxassetid://103157410965032",
        Currency = "coins",
        Amount = 600,
        Label = "THE STASH"
    },
    {
        Key = "Coins4",
        Icon = "rbxassetid://128648871452616",
        Currency = "coins",
        Amount = 1400,
        Label = "FULL POCKETS"
    },
    {
        Key = "Coins5",
        Icon = "rbxassetid://108159368864824",
        Currency = "coins",
        Amount = 3200,
        Label = "THE VAULT"
    },
    {
        Key = "Coins6",
        Icon = "rbxassetid://101461654434033",
        Currency = "coins",
        Amount = 7500,
        Label = "VALLEY RESERVES"
    },
    {
        Key = "Gems1",
        Currency = "gems",
        Amount = 100,
        Label = "FIRST FIND"
    },
    {
        Key = "Gems2",
        Icon = "rbxassetid://96217818660415",
        Currency = "gems",
        Amount = 230,
        Label = "A GOOD HAUL"
    },
    {
        Key = "Gems3",
        Icon = "rbxassetid://105242050281746",
        Currency = "gems",
        Amount = 500,
        Label = "THE CACHE"
    },
    {
        Key = "Gems4",
        Icon = "rbxassetid://107427051950771",
        Currency = "gems",
        Amount = 1025,
        Label = "HIDDEN TREASURE"
    },
    {
        Key = "Gems5",
        Icon = "rbxassetid://102091120447384",
        Currency = "gems",
        Amount = 2225,
        Label = "DEEP POCKETS"
    },
    {
        Key = "Gems6",
        Icon = "rbxassetid://113610310237500",
        Currency = "gems",
        Amount = 4625,
        Label = "VALLEY TREASURE"
    }
};
u1.LiveUniverseId = 10764627709;
u1.TestUniverseId = 10768621983;
u1.Universes = {
    [10764627709] = {
        PurchasesEnabled = true,
        PassIds = {
            Clone = 1998944863,
            Ghost = 2007002633,
            IceCream = 0,
            Spoon = 1990226321,
            Selfie = 2025740546,
            Football = 2021630275,
            Futbol = 2022794459,
            DoubleXP = 1989662291,
            VIP = 1990310290
        },
        ProductIds = {
            Coins1 = 3715700196,
            Coins2 = 3715700200,
            Coins3 = 3715700203,
            Coins4 = 3715700204,
            Coins5 = 3715700205,
            Coins6 = 3715700208,
            Gems1 = 3715700211,
            Gems2 = 3715700216,
            Gems3 = 3715700220,
            Gems4 = 3715700223,
            Gems5 = 3715700226,
            Gems6 = 3715700228
        }
    },
    [10767420607] = {
        PurchasesEnabled = false,
        PassIds = {
            Clone = 1998944863,
            Ghost = 0,
            IceCream = 0,
            Spoon = 1990226321,
            Selfie = 0,
            Football = 0,
            Futbol = 0,
            DoubleXP = 1989662291,
            VIP = 1990310290
        },
        ProductIds = {}
    }
};
u1.ProductGrants = {
    [3715700196] = {
        UniverseId = 10764627709,
        Currency = "coins",
        Amount = 100
    },
    [3715700200] = {
        UniverseId = 10764627709,
        Currency = "coins",
        Amount = 250
    },
    [3715700203] = {
        UniverseId = 10764627709,
        Currency = "coins",
        Amount = 600
    },
    [3715700204] = {
        UniverseId = 10764627709,
        Currency = "coins",
        Amount = 1400
    },
    [3715700205] = {
        UniverseId = 10764627709,
        Currency = "coins",
        Amount = 3200
    },
    [3715700208] = {
        UniverseId = 10764627709,
        Currency = "coins",
        Amount = 7500
    },
    [3715700211] = {
        UniverseId = 10764627709,
        Currency = "gems",
        Amount = 100
    },
    [3715700216] = {
        UniverseId = 10764627709,
        Currency = "gems",
        Amount = 230
    },
    [3715700220] = {
        UniverseId = 10764627709,
        Currency = "gems",
        Amount = 500
    },
    [3715700223] = {
        UniverseId = 10764627709,
        Currency = "gems",
        Amount = 1025
    },
    [3715700226] = {
        UniverseId = 10764627709,
        Currency = "gems",
        Amount = 2225
    },
    [3715700228] = {
        UniverseId = 10764627709,
        Currency = "gems",
        Amount = 4625
    }
};
u1.Promotion = {
    Enabled = false,
    StartsAt = 0,
    EndsAt = 0,
    Text = "WEEKEND AT THE VALLEY"
};

function u1.storeUniverse(p14) -- Line: 135
    -- upvalues: u1 (copy)
    if p14 == u1.TestUniverseId then
        p14 = u1.LiveUniverseId or p14;
    end;

    return p14;
end;

u1.TestPassIds = {
    Football = 2021888289,
    Futbol = 2022260515
};
local u15 = nil;

function u1.binding(p16) -- Line: 140
    -- upvalues: u1 (copy), u15 (ref)
    if p16 ~= u1.TestUniverseId then
        return u1.Universes[u1.storeUniverse(p16)] or {
            PurchasesEnabled = false,
            PassIds = {},
            ProductIds = {}
        };
    end;

    if not u15 then
        local v17 = u1.Universes[u1.LiveUniverseId];
        local table_clone_ret = table.clone(v17.PassIds);

        for i, v in u1.TestPassIds do
            table_clone_ret[i] = v;
        end;

        u15 = {
            PassIds = table_clone_ret,
            ProductIds = v17.ProductIds,
            PurchasesEnabled = v17.PurchasesEnabled
        };
    end;

    return u15;
end;

function u1.promotionActive(p18) -- Line: 152
    -- upvalues: u1 (copy)
    local Promotion = u1.Promotion;
    local Enabled = Promotion.Enabled;

    if Enabled then
        if Promotion.StartsAt == 0 or Promotion.StartsAt <= p18 then
            Enabled = Promotion.EndsAt == 0 and true or p18 < Promotion.EndsAt;
        else
            Enabled = false;
        end;
    end;

    return Enabled;
end;

return u1;