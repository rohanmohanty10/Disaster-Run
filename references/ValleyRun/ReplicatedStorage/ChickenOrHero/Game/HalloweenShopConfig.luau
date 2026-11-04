 

 

local u1 = {
    Store = "HalloweenStore",
    CandyCorn = table.freeze({
        field = "CandyCorn",
        name = "Candy Corn",
        icon = "rbxassetid://119759573303359",
        color = Color3.fromRGB(255, 196, 70)
    }),
    Coins = table.freeze({
        field = "coins",
        name = "Coins",
        icon = "rbxassetid://78008558948307",
        color = Color3.fromRGB(255, 202, 58)
    })
};
u1.Currency = u1.CandyCorn;
u1.ComingSoon = "Coming soon!";
u1.EndsAt = require(script.Parent:WaitForChild("CandyCorn")).EndsAt;
u1.Items = table.freeze({
    table.freeze({
        id = "HalloweenEmoteCrate",
        kind = "Crate",
        model = "HalloweenEmoteCrate",
        crate = "HalloweenEmote",
        name = "Emote Crate",
        price = 750
    }),
    table.freeze({
        id = "TreatCrate",
        kind = "Crate",
        model = "TreatCrate",
        crate = "HalloweenTreat",
        name = "Treat Crate",
        price = 750
    }),
    table.freeze({
        id = "TrickCrate",
        kind = "Crate",
        model = "TrickCrate",
        crate = "HalloweenTrick",
        name = "Trick Crate",
        price = 750
    }),
    table.freeze({
        id = "Hexflask",
        kind = "Knife",
        knife = "Hexflask",
        badge = "LIMITED",
        subtitle = "Only during the event",
        price = 15000,
        endsAt = DateTime.fromUniversalTime(2026, 11, 3, 20, 0, 0).UnixTimestamp
    })
});
u1.Day = 86400;
u1.TitleDays = 2;
u1.RotatingTitles = table.freeze({
    table.freeze({
        id = "HeadlessHorseman",
        title = "Headless Horseman",
        price = 1250,
        color = Color3.fromRGB(255, 132, 28)
    }),
    table.freeze({
        id = "Boo",
        title = "Boo!",
        price = 375,
        color = Color3.fromRGB(235, 235, 255)
    }),
    table.freeze({
        id = "VampireLord",
        title = "Vampire Lord",
        price = 2500,
        color = Color3.fromRGB(210, 30, 50)
    }),
    table.freeze({
        id = "GraveRobber",
        title = "Grave Robber",
        price = 1500,
        color = Color3.fromRGB(160, 170, 180)
    }),
    table.freeze({
        id = "PumpkinKing",
        title = "Pumpkin King",
        price = 3750,
        color = Color3.fromRGB(255, 150, 20)
    }),
    table.freeze({
        id = "MonsterMash",
        title = "Monster Mash",
        price = 1000,
        color = Color3.fromRGB(120, 220, 110)
    }),
    table.freeze({
        id = "TheUndying",
        title = "The Undying",
        price = 5000,
        color = Color3.fromRGB(90, 230, 255)
    }),
    table.freeze({
        id = "CandyCollector",
        title = "Candy Collector",
        price = 1250,
        color = Color3.fromRGB(255, 120, 200)
    }),
    table.freeze({
        id = "Hexed",
        title = "Hexed",
        price = 1750,
        color = Color3.fromRGB(176, 98, 255)
    }),
    table.freeze({
        id = "BatOutOfHell",
        title = "Bat Out of Hell",
        price = 750,
        color = Color3.fromRGB(150, 90, 210)
    }),
    table.freeze({
        id = "Cobweb",
        title = "Cobweb",
        price = 500,
        color = Color3.fromRGB(200, 200, 215)
    })
});
u1.RotatingEmotes = table.freeze({ "ScarecrowPose", "SpookyTiptoe", "PumpkinCarve", "WerewolfTransform", "PoltergeistThrow" });
u1.EmotePrices = table.freeze({
    Common = 500,
    Rare = 750,
    Epic = 1250,
    Legendary = 2000
});
u1.GraceSeconds = 60;

local function hash(p2) -- Line: 72
    local v3 = 5381;

    for i = 1, #p2 do
        local v4 = bit32.lshift(v3, 5) + v3;
        v3 = bit32.bxor(v4, string.byte(p2, i));
        local _ = i;
    end;

    return v3;
end;

local function order(p5, p6, p7, p8) -- Line: 80
    -- upvalues: order (copy)
    local table_create_ret = table.create(p6);

    for i = 1, p6 do
        table_create_ret[i] = i;
        local _ = i;
    end;

    local Random_new = Random.new;
    local v9 = p5 .. ":" .. p7;
    local v10 = 5381;

    for i = 1, #v9 do
        local v11 = bit32.lshift(v10, 5) + v10;
        v10 = bit32.bxor(v11, string.byte(v9, i));
        local _ = i;
    end;

    local v12 = Random_new(v10);

    for i = p6, 2, -1 do
        local v13 = v12:NextInteger(1, i);
        local v14 = table_create_ret[i];
        table_create_ret[i] = table_create_ret[v13];
        table_create_ret[v13] = v14;
        local _ = i;
    end;

    if p6 > 1 and p8 < 1 then
        local v15 = order(p5, p6, p7 - 1, p8 + 1);

        if table_create_ret[1] == v15[p6] then
            local v16 = table_create_ret[1];
            table_create_ret[1] = table_create_ret[2];
            table_create_ret[2] = v16;
        end;
    end;

    return table_create_ret;
end;

local function pick(p17, p18, p19) -- Line: 99
    -- upvalues: order (copy)
    return order(p17, p18, p19 // p18, 0)[p19 % p18 + 1];
end;

u1.ResetHour = 10;
u1.TitleStart = DateTime.fromUniversalTime(2026, 10, 17, 17, 0, 0).UnixTimestamp;

local function utc(p20, p21, p22, p23) -- Line: 112
    return DateTime.fromUniversalTime(p20, p21, p22, p23, 0, 0).UnixTimestamp;
end;

local function nthSunday(p24, p25, p26) -- Line: 115
    return 1 + (8 - os.date("!*t", DateTime.fromUniversalTime(p24, p25, 1, 12, 0, 0).UnixTimestamp).wday) % 7 + (p26 - 1) * 7;
end;

local function pacificOffset(p27) -- Line: 119
    local year = os.date("!*t", p27).year;
    local v28 = 1 + (8 - os.date("!*t", DateTime.fromUniversalTime(year, 3, 1, 12, 0, 0).UnixTimestamp).wday) % 7 + 7;
    local UnixTimestamp = DateTime.fromUniversalTime(year, 3, v28, 10, 0, 0).UnixTimestamp;
    local v29 = 1 + (8 - os.date("!*t", DateTime.fromUniversalTime(year, 11, 1, 12, 0, 0).UnixTimestamp).wday) % 7 + 0;
    local UnixTimestamp2 = DateTime.fromUniversalTime(year, 11, v29, 9, 0, 0).UnixTimestamp;

    return UnixTimestamp <= p27 and p27 < UnixTimestamp2 and 7 or 8;
end;

local function dayStart(p30) -- Line: 126
    -- upvalues: u1 (copy), pacificOffset (copy)
    return p30 * u1.Day + (u1.ResetHour + pacificOffset(p30 * u1.Day + (u1.ResetHour + 8) * 3600)) * 3600;
end;

function u1.day(p31) -- Line: 131
    -- upvalues: u1 (copy), pacificOffset (copy)
    local v32 = (math.floor(p31) - (u1.ResetHour + 7) * 3600) // u1.Day;

    if p31 < v32 * u1.Day + (u1.ResetHour + pacificOffset(v32 * u1.Day + (u1.ResetHour + 8) * 3600)) * 3600 then
        return v32 - 1;
    end;

    local v33 = v32 + 1;

    if v33 * u1.Day + (u1.ResetHour + pacificOffset(v33 * u1.Day + (u1.ResetHour + 8) * 3600)) * 3600 <= p31 then
        v32 = v32 + 1;
    end;

    return v32;
end;

function u1.rotation(p34) -- Line: 140
    -- upvalues: u1 (copy), pacificOffset (copy), order (copy)
    local v35 = u1.day(p34);
    local v36 = u1.day(u1.TitleStart);
    local math_max_ret = math.max(0, (v35 - v36) // u1.TitleDays);
    local v37 = u1.RotatingTitles[math_max_ret % #u1.RotatingTitles + 1];
    local v38 = {
        kind = "Title",
        rotating = "Title",
        id = v37.id,
        title = v37.title,
        badge = v37.id,
        color = v37.color,
        price = v37.price
    };
    local v39 = v36 + (math_max_ret + 1) * u1.TitleDays;
    v38.rotatesAt = v39 * u1.Day + (u1.ResetHour + pacificOffset(v39 * u1.Day + (u1.ResetHour + 8) * 3600)) * 3600;
    local v40 = #u1.RotatingEmotes;
    local v41 = u1.RotatingEmotes[order("emote", v40, v35 // v40, 0)[v35 % v40 + 1]];
    local v42 = {
        kind = "Emote",
        rotating = "Emote",
        id = "Emote:" .. v41,
        emote = v41
    };
    local v43 = v35 + 1;
    v42.rotatesAt = v43 * u1.Day + (u1.ResetHour + pacificOffset(v43 * u1.Day + (u1.ResetHour + 8) * 3600)) * 3600;

    return v38, v42;
end;

function u1.stock(p44) -- Line: 164
    -- upvalues: u1 (copy)
    local EmoteCatalog = require(script.Parent.Parent:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
    local v45, v46 = u1.rotation(p44);
    local v47 = EmoteCatalog.get(v46.emote);
    v46.name = v47 and v47.Name or v46.emote;
    v46.rarity = v47 and v47.Rarity or "Common";
    v46.price = u1.EmotePrices[v46.rarity] or u1.EmotePrices.Common;
    local v48 = {};

    for _, v in u1.Items do
        if v.kind == "Knife" then
            table.insert(v48, v45);
            table.insert(v48, v46);
        end;

        table.insert(v48, v);
    end;

    return v48;
end;

u1.Packs = table.freeze({ table.freeze({
        id = "CandyHandful",
        name = "Handful",
        amount = 100,
        robux = 49,
        productId = 3719260409
    }), table.freeze({
        id = "CandyBag",
        name = "Bag of Candy",
        amount = 500,
        robux = 199,
        productId = 3719260323
    }), table.freeze({
        id = "CandyCauldron",
        name = "Cauldron",
        amount = 4000,
        robux = 699,
        productId = 3719260209,
        best = true
    }) });

function u1.packByProduct(p49) -- Line: 196
    -- upvalues: u1 (copy)
    for _, v in u1.Packs do
        if not ((v.productId == nil or v.productId ~= p49) and (v.testProductId == nil or v.testProductId ~= p49)) then
            return v;
        end;
    end;

    return nil;
end;

u1.TestUniverseId = 10768621983;

function u1.packProduct(p50) -- Line: 206
    -- upvalues: u1 (copy)
    if p50.testProductId and game.GameId == u1.TestUniverseId then
        return p50.testProductId;
    end;

    return p50.productId;
end;

return table.freeze(u1);