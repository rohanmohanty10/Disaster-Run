 

 

local u1 = {
    Cards = 6,
    CooldownSeconds = 300,
    CursedChance = 0.3333333333333333,
    KeyCap = 9999,
    Reach = 25,
    KeyDrops = {
        Zombie = 0.15,
        Skeleton = 0.15
    },
    KeyDropAmount = 1,
    KeyIcon = "rbxassetid://99826093535691",
    LastManStandingKeys = 1,
    MatchKeysMinPlayers = 4,
    WheelKeys = 1,
    UniverseId = 10764627709,
    TestUniverseId = 10768621983,
    SkipSteps = { {
            Price = 49,
            ProductId = 3721699581,
            TestProductId = 3721699675
        }, {
            Price = 99,
            ProductId = 3721699605,
            TestProductId = 3721699696
        }, {
            Price = 199,
            ProductId = 3721699629,
            TestProductId = 3721699713
        }, {
            Price = 499,
            ProductId = 3721699651,
            TestProductId = 3721699733
        }, {
            Price = 999,
            ProductId = 3721699666,
            TestProductId = 3721699754
        } },
    RarityColors = {
        Common = Color3.fromRGB(175, 185, 192),
        Rare = Color3.fromRGB(92, 173, 238),
        Epic = Color3.fromRGB(183, 123, 244),
        Legendary = Color3.fromRGB(242, 191, 89),
        Mythical = Color3.fromRGB(255, 72, 96)
    },
    Rewards = {
        {
            Id = "Coins750",
            Kind = "Coins",
            Amount = 750,
            Rarity = "Common",
            Name = "750 Coins",
            Normal = 24,
            Cursed = 0
        },
        {
            Id = "Coins2000",
            Kind = "Coins",
            Amount = 2000,
            Rarity = "Rare",
            Name = "2,000 Coins",
            Normal = 10,
            Cursed = 17
        },
        {
            Id = "Candy300",
            Kind = "Candy",
            Amount = 300,
            Rarity = "Common",
            Name = "300 Candy Corn",
            Normal = 18,
            Cursed = 0
        },
        {
            Id = "Candy1000",
            Kind = "Candy",
            Amount = 1000,
            Rarity = "Rare",
            Name = "1,000 Candy Corn",
            Normal = 6,
            Cursed = 15
        },
        {
            Id = "Gems50",
            Kind = "Gems",
            Amount = 50,
            Rarity = "Common",
            Name = "50 Gems",
            Normal = 8,
            Cursed = 0
        },
        {
            Id = "Gems150",
            Kind = "Gems",
            Amount = 150,
            Rarity = "Rare",
            Name = "150 Gems",
            Normal = 0,
            Cursed = 12
        },
        {
            Id = "Keys2",
            Kind = "Keys",
            Amount = 2,
            Rarity = "Rare",
            Name = "+2 Ghost Keys",
            Normal = 6,
            Cursed = 0
        },
        {
            Id = "Keys3",
            Kind = "Keys",
            Amount = 3,
            Rarity = "Rare",
            Name = "+3 Ghost Keys",
            Normal = 0,
            Cursed = 12
        },
        {
            Id = "TrickOrTreatKey",
            Kind = "CrateKey",
            Crate = "TrickOrTreat",
            Amount = 1,
            Rarity = "Rare",
            Name = "Trick or Treat Crate Key",
            Normal = 8,
            Cursed = 12
        },
        {
            Id = "EmoteCrateKey",
            Kind = "CrateKey",
            Crate = "HalloweenEmote",
            Amount = 1,
            Rarity = "Rare",
            Name = "Emote Crate Key",
            Normal = 9,
            Cursed = 8
        },
        {
            Id = "Keyholder",
            Kind = "Title",
            TitleId = "Keyholder",
            Rarity = "Rare",
            Name = "Keyholder Title",
            Normal = 4,
            Cursed = 0
        },
        {
            Id = "CardTrick",
            Kind = "Emote",
            EmoteId = "CardTrick",
            Rarity = "Epic",
            Name = "Card Trick",
            Normal = 3,
            Cursed = 7
        },
        {
            Id = "SkeletonKey",
            Kind = "Knife",
            Skin = "SkeletonKey",
            Rarity = "Epic",
            Name = "Skeleton Key",
            Normal = 2.5,
            Cursed = 6
        },
        {
            Id = "Ghostlock",
            Kind = "Knife",
            Skin = "Ghostlock",
            Rarity = "Legendary",
            Name = "Ghostlock",
            Normal = 1,
            Cursed = 4
        },
        {
            Id = "LastDoor",
            Kind = "Knife",
            Skin = "TheLastDoor",
            Rarity = "Mythical",
            Name = "The Last Door",
            Normal = 0,
            Cursed = 5
        }
    }
};

local function weight(p2, p3) -- Line: 114
    local v4;

    if p3 then
        v4 = p2.Cursed;
    else
        v4 = p2.Normal;
    end;

    return (type(v4) ~= "number" or (v4 ~= v4 or (v4 <= 0 or v4 >= (1 / 0)))) and 0 or v4;
end;

function u1.column(p5) -- Line: 121
    -- upvalues: u1 (copy)
    local v6 = 0;

    for _, v in u1.Rewards do
        local v7;

        if p5 then
            v7 = v.Cursed;
        else
            v7 = v.Normal;
        end;

        v6 = v6 + ((type(v7) ~= "number" or (v7 ~= v7 or (v7 <= 0 or v7 >= (1 / 0)))) and 0 or v7);
    end;

    local v8 = {};

    if v6 <= 0 then
        return v8;
    end;

    for _, v in u1.Rewards do
        local v9;

        if p5 then
            v9 = v.Cursed;
        else
            v9 = v.Normal;
        end;

        local v10 = (type(v9) ~= "number" or (v9 ~= v9 or (v9 <= 0 or v9 >= (1 / 0)))) and 0 or v9;

        if v10 > 0 then
            table.insert(v8, {
                row = v,
                chance = v10 / v6,
                v,
                v10 / v6
            });
        end;
    end;

    return v8;
end;

function u1.pick(p11, p12) -- Line: 140
    -- upvalues: u1 (copy)
    local v13 = u1.column(p11);
    local v14 = 0;

    for _, v in v13 do
        v14 = v14 + v.chance;

        if p12 < v14 then
            return v.row;
        end;
    end;

    if #v13 > 0 then
        return v13[#v13].row;
    end;

    return nil;
end;

function u1.get(p15) -- Line: 153
    -- upvalues: u1 (copy)
    for _, v in u1.Rewards do
        if v.Id == p15 then
            return v;
        end;
    end;

    return nil;
end;

function u1.day(p16) -- Line: 163
    return math.floor(p16 / 86400);
end;

function u1.skipStep(p17) -- Line: 168
    -- upvalues: u1 (copy)
    local v18 = type(p17) ~= "number" and 0 or math.floor(p17);
    local math_clamp_ret = math.clamp(v18 + 1, 1, #u1.SkipSteps);

    return math_clamp_ret, u1.SkipSteps[math_clamp_ret];
end;

function u1.skipProduct(p19) -- Line: 175
    -- upvalues: u1 (copy)
    local v20;

    if p19.TestProductId and game.GameId == u1.TestUniverseId then
        v20 = p19.TestProductId;
    else
        v20 = p19.ProductId;
    end;

    if type(v20) == "number" and v20 > 0 then
        return v20;
    end;

    return nil;
end;

function u1.skipByProduct(p21) -- Line: 181
    -- upvalues: u1 (copy)
    for i, v in u1.SkipSteps do
        if not ((v.ProductId == nil or v.ProductId ~= p21) and (v.TestProductId == nil or v.TestProductId ~= p21)) then
            return v, i;
        end;
    end;

    return nil;
end;

for _, v in u1.Rewards do
    table.freeze(v);
end;

for _, v in u1.SkipSteps do
    table.freeze(v);
end;

table.freeze(u1.Rewards);
table.freeze(u1.SkipSteps);
table.freeze(u1.RarityColors);
table.freeze(u1.KeyDrops);

return table.freeze(u1);