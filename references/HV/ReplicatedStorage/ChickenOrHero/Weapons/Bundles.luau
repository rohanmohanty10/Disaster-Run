 

 

local u1 = {
    TestUniverseId = 10768621983
};
local table_freeze_ret = table.freeze({
    Key = "BonkerBundle",
    Title = "BONKER BUNDLE",
    Name = "Bonker Bundle",
    ProductId = 3716906114,
    UniverseId = 10764627709,
    SkinId = "Bonker",
    Gems = 750,
    Item = "BananaPeel",
    ItemCount = 50,
    Flag = "bonkerBundlePurchased",
    Contents = "BONKER, 750 gems and 50 Banana Peels",
    Blurb = "<font color=\"#57EB9F\">+750 Gems</font>, +50 Banana Peels and the Bonker knife.",
    StandLine = "<font color=\"#57EB9F\">+750 GEMS</font>  ·  +50 BANANA PEELS",
    Details = "Bonker, 750 gems and 50 Banana Peels are yours.",
    Reason = "bonker_bundle",
    StartsAt = 0,
    Accent = Color3.fromRGB(255, 86, 108),
    Backdrop = Color3.fromRGB(64, 18, 28),
    EndsAt = DateTime.fromUniversalTime(2026, 10, 14, 7, 0, 0).UnixTimestamp
});
local table_freeze_ret2 = table.freeze({
    Key = "VowbreakerBundle",
    ShopOrder = 2,
    Title = "VOWBREAKER BUNDLE",
    Name = "Vowbreaker Bundle",
    ProductId = 3718312230,
    TestProductId = 3718391701,
    UniverseId = 10764627709,
    SkinId = "Vowbreaker",
    Gems = 450,
    Emote = "KarambitSpin",
    Ability = "BrokenVow",
    Flag = "vowbreakerBundlePurchased",
    Contents = "VOWBREAKER, the Broken Vow ability, Karambit Spin and 450 gems",
    Blurb = "The Vowbreaker, the <font color=\"#FF8FC8\">Broken Vow</font> ability, the Karambit Spin emote and <font color=\"#57EB9F\">+450 Gems</font>.",
    StandLine = "<font color=\"#FF8FC8\">BROKEN VOW</font>  ·  KARAMBIT SPIN  ·  <font color=\"#57EB9F\">+450 GEMS</font>",
    Details = "Vowbreaker, its Broken Vow ability, the Karambit Spin emote and 450 gems are yours.",
    Reason = "vowbreaker_bundle",
    StartsAt = 0,
    Accent = Color3.fromRGB(255, 128, 196),
    Backdrop = Color3.fromRGB(58, 16, 44),
    Floaters = table.freeze({ "rbxassetid://11883615941" }),
    EndsAt = DateTime.fromUniversalTime(2026, 10, 24, 17, 0, 0).UnixTimestamp
});
local table_freeze_ret3 = table.freeze({
    Key = "PumpkinCleaverBundle",
    ShopOrder = 1,
    Title = "PUMPKIN CLEAVER BUNDLE",
    Name = "Pumpkin Cleaver Bundle",
    ProductId = 3719250539,
    TestProductId = 3719250867,
    UniverseId = 10764627709,
    SkinId = "PumpkinCleaver",
    Gems = 0,
    Ability = "TimeWarp",
    Flag = "pumpkinCleaverBundlePurchased",
    Contents = "PUMPKIN CLEAVER and the Time Warp ability",
    Blurb = "The Pumpkin Cleaver and the <font color=\"#78C8FF\">Time Warp</font> ability: rewind 2 seconds.",
    StandLine = "<font color=\"#78C8FF\">TIME WARP</font>  ·  REWIND 2 SECONDS",
    Details = "The Pumpkin Cleaver and its Time Warp ability are yours.",
    Reason = "pumpkin_cleaver_bundle",
    Next = "HexflaskBundle",
    StartsAt = 0,
    Accent = Color3.fromRGB(255, 140, 40),
    Backdrop = Color3.fromRGB(60, 26, 8),
    EndsAt = DateTime.fromUniversalTime(2026, 10, 24, 17, 0, 0).UnixTimestamp
});
local table_freeze_ret4 = table.freeze({
    Key = "SoulbinderBundle",
    ShopOrder = 0,
    Title = "SOULBINDER BUNDLE",
    Name = "Soulbinder Bundle",
    ProductId = 3720211664,
    TestProductId = 3720212498,
    UniverseId = 10764627709,
    SkinId = "Soulbinder",
    Gems = 0,
    Ability = "SoulReap",
    Candy = 5000,
    Emote = "SoulCall",
    Flag = "soulbinderBundlePurchased",
    Contents = "SOULBINDER, the Soul Reap ability, the Soul Call emote and 5,000 candy corn",
    Blurb = "The Soulbinder, the bundle-only <font color=\"#5AC8FF\">Soul Reap</font> ability (fallen teammates\' souls become extra lives), the Soul Call emote and <font color=\"#FFA03C\">+5,000 Candy Corn</font>.",
    StandLine = "<font color=\"#5AC8FF\">SOUL REAP</font>  ·  SOUL CALL  ·  <font color=\"#FFA03C\">+5,000 CANDY CORN</font>",
    Details = "The Soulbinder, its Soul Reap ability, the Soul Call emote and 5,000 candy corn are yours.",
    Reason = "soulbinder_bundle",
    StartsAt = 0,
    Accent = Color3.fromRGB(90, 200, 255),
    Backdrop = Color3.fromRGB(10, 22, 44),
    EndsAt = DateTime.fromUniversalTime(2026, 11, 3, 20, 0, 0).UnixTimestamp
});
local table_freeze_ret5 = table.freeze({
    Key = "SoulbinderBlade",
    Pair = "SoulbinderBundle",
    Title = "SOULBINDER BLADE",
    Name = "Soulbinder Blade",
    ProductId = nil,
    UniverseId = 10764627709,
    SkinId = "SoulbinderBlade",
    Gems = 0,
    Flag = "soulbinderBladePurchased",
    Contents = "the SOULBINDER BLADE",
    Blurb = "One Soulbinder blade, its standard look.",
    StandLine = "ONE BLADE",
    Details = "The Soulbinder Blade is yours.",
    Reason = "soulbinder_blade",
    StartsAt = 0,
    Accent = Color3.fromRGB(90, 200, 255),
    Backdrop = Color3.fromRGB(10, 22, 44),
    EndsAt = table_freeze_ret4.EndsAt
});
local table_freeze_ret6 = table.freeze({
    Key = "ClownKillerBundle",
    ShopOrder = -1,
    Title = "CLOWN KILLER BUNDLE",
    Name = "Clown Killer Bundle",
    ProductId = 3721740837,
    TestProductId = 3721740900,
    DiscountProductId = 3721740882,
    TestDiscountProductId = 3721740942,
    UniverseId = 10764627709,
    SkinId = "GrinnerBlades",
    Gems = 500,
    Ability = "SpringBox",
    Candy = 5000,
    Emote = "ClownJuggle",
    Flag = "clownKillerBundlePurchased",
    Contents = "GRINNER BLADES, the Spring Box ability, the Clown Juggle emote, 5,000 candy corn and 500 gems",
    Blurb = "The Grinner Blades, the bundle-only <font color=\"#FF465A\">Spring Box</font> ability (three jack-in-the-boxes that explode and send runners flying), the Clown Juggle emote, <font color=\"#FFA03C\">+5,000 Candy Corn</font> and <font color=\"#57EB9F\">+500 Gems</font>.",
    StandLine = "<font color=\"#FF465A\">SPRING BOX</font>  ·  CLOWN JUGGLE  ·  <font color=\"#FFA03C\">+5,000 CANDY CORN</font>  ·  <font color=\"#57EB9F\">+500 GEMS</font>",
    Details = "The Grinner Blades, the Spring Box ability, the Clown Juggle emote, 5,000 candy corn and 500 gems are yours.",
    Reason = "clown_killer_bundle",
    StartsAt = 0,
    Accent = Color3.fromRGB(255, 70, 90),
    Backdrop = Color3.fromRGB(52, 10, 22),
    Showcase = table.freeze({
        Effects = "Clown VFX on both",
        EffectsShort = "Clown VFX",
        Line = "Both blades, all their effects and the ability",
        BladeLine = "One Grinner Blade, standard look",
        Note = "Own the Blade already? The bundle costs you less.",
        Subtitle = "MYTHICAL KNIFE · HALLOWEEN",
        KillEffect = "BalloonLift"
    }),
    EndsAt = DateTime.fromUniversalTime(2026, 11, 3, 20, 0, 0).UnixTimestamp
});
local v2 = {
    table_freeze_ret,
    table_freeze_ret2,
    table_freeze_ret3,
    table_freeze_ret4,
    table_freeze_ret5,
    table_freeze_ret6,
    table.freeze({
        Key = "GrinnerBlade",
        Pair = "ClownKillerBundle",
        Title = "GRINNER BLADE",
        Name = "Grinner Blade",
        ProductId = 3721740862,
        TestProductId = 3721740919,
        UniverseId = 10764627709,
        SkinId = "GrinnerBlade",
        Gems = 0,
        Flag = "grinnerBladePurchased",
        Contents = "the GRINNER BLADE",
        Blurb = "One Grinner Blade, its standard look.",
        StandLine = "ONE BLADE",
        Details = "The Grinner Blade is yours.",
        Reason = "grinner_blade",
        StartsAt = 0,
        Accent = table_freeze_ret6.Accent,
        Backdrop = table_freeze_ret6.Backdrop,
        EndsAt = table_freeze_ret6.EndsAt
    }),
    table.freeze({
        Key = "HexflaskBundle",
        ShopOrder = 1,
        Title = "HEXFLASK BUNDLE",
        Name = "Hexflask Bundle",
        ProductId = 3721776995,
        TestProductId = 3721777039,
        UniverseId = 10764627709,
        SkinId = "Hexflask",
        Gems = 0,
        Ability = "FartCloud",
        Candy = 1000,
        Flag = "hexflaskBundlePurchased",
        Contents = "HEXFLASK, the Fart ability and 1,000 candy corn",
        Blurb = "The Hexflask, the <font color=\"#96D246\">Fart</font> ability (a burst of speed and a cloud that slows chasers) and <font color=\"#FFA03C\">+1,000 Candy Corn</font>.",
        StandLine = "<font color=\"#96D246\">FART</font>  ·  <font color=\"#FFA03C\">+1,000 CANDY CORN</font>",
        Details = "The Hexflask, its Fart ability and 1,000 candy corn are yours.",
        Reason = "hexflask_bundle",
        Next = "HallowreaperBundle",
        StartsAt = 0,
        Accent = Color3.fromRGB(150, 210, 70),
        Backdrop = Color3.fromRGB(24, 40, 14),
        EndsAt = DateTime.fromUniversalTime(2026, 11, 3, 20, 0, 0).UnixTimestamp
    }),
    table.freeze({
        Key = "HallowreaperBundle",
        ShopOrder = -2,
        Title = "HALLOWREAPER BUNDLE",
        Name = "Hallowreaper Bundle",
        ProductId = 3722736163,
        TestProductId = 3722736201,
        UniverseId = 10764627709,
        SkinId = "Hallowreapers",
        Gems = 0,
        Ability = "PumpkinBomb",
        Candy = 2000,
        Keys = 10,
        Flag = "hallowreaperBundlePurchased",
        Contents = "HALLOWREAPERS, the Jack-O-Bomb ability, 10 Ghost Keys and 2,000 candy corn",
        Blurb = "The dual-wielded Hallowreapers, the <font color=\"#FF8C28\">Jack-O-Bomb</font> ability (thick smoke bombs that hide your team\'s outlines and name tags, runners only), <font color=\"#FFD25A\">+10 Ghost Keys</font> and <font color=\"#FFA03C\">+2,000 Candy Corn</font>.",
        StandLine = "<font color=\"#FF8C28\">JACK-O-BOMB</font>  ·  <font color=\"#FFD25A\">+10 GHOST KEYS</font>  ·  <font color=\"#FFA03C\">+2,000 CANDY CORN</font>",
        Details = "The Hallowreapers, the Jack-O-Bomb ability, 10 Ghost Keys and 2,000 candy corn are yours.",
        Reason = "hallowreaper_bundle",
        StartsAt = 0,
        Accent = Color3.fromRGB(255, 140, 40),
        Backdrop = Color3.fromRGB(44, 20, 8),
        EndsAt = DateTime.fromUniversalTime(2026, 11, 7, 18, 0, 0).UnixTimestamp
    }),
    (table.freeze({
        Key = "SpectralCutlassBundle",
        ShopOrder = -3,
        Title = "SPECTRAL CUTLASS BUNDLE",
        Name = "Spectral Cutlass Bundle",
        ProductId = 3724292586,
        TestProductId = 3724292653,
        UniverseId = 10764627709,
        SkinId = "DrownedCutlass",
        Gems = 0,
        Ability = "PiratesCall",
        Candy = 5000,
        Keys = 25,
        Flag = "spectralCutlassBundlePurchased",
        Contents = "the SPECTRAL CUTLASS, the Raise The Crew ability, 25 Ghost Keys and 5,000 candy corn",
        Blurb = "The Spectral Cutlass, the <font color=\"#6EE6AA\">Raise The Crew</font> ability (two skeletons hunt down the nearest runners and knock them down, chasers only), <font color=\"#FFD25A\">+25 Ghost Keys</font> and <font color=\"#FFA03C\">+5,000 Candy Corn</font>.",
        StandLine = "<font color=\"#6EE6AA\">RAISE THE CREW</font>  ·  <font color=\"#FFD25A\">+25 GHOST KEYS</font>  ·  <font color=\"#FFA03C\">+5,000 CANDY CORN</font>",
        Details = "The Spectral Cutlass, the Raise The Crew ability, 25 Ghost Keys and 5,000 candy corn are yours.",
        Reason = "spectral_cutlass_bundle",
        StartsAt = 0,
        Accent = Color3.fromRGB(110, 230, 170),
        Backdrop = Color3.fromRGB(10, 34, 28),
        EndsAt = DateTime.fromUniversalTime(2026, 11, 7, 18, 0, 0).UnixTimestamp
    }))
};
u1.List = table.freeze(v2);

local function onSale(p3, p4) -- Line: 305
    local v5;

    if (p3.StartsAt or 0) <= p4 then
        v5 = p4 < (p3.EndsAt or (1 / 0));
    else
        v5 = false;
    end;

    return v5;
end;

function u1.shopList(p6) -- Line: 310
    -- upvalues: u1 (copy)
    local v7 = p6 or workspace:GetServerTimeNow();
    local v8 = {};

    for _, v in u1.List do
        local v9;

        if (v.StartsAt or 0) <= v7 then
            v9 = v7 < (v.EndsAt or (1 / 0));
        else
            v9 = false;
        end;

        if v9 and not v.Pair then
            table.insert(v8, v);
        end;
    end;

    table.sort(v8, function(p10, p11) -- Line: 319
        -- upvalues: u1 (ref)
        local v12 = p10.ShopOrder or 99;
        local v13 = p11.ShopOrder or 99;

        if v12 == v13 then
            return table.find(u1.List, p10) < table.find(u1.List, p11);
        end;

        return v12 < v13;
    end);

    return v8;
end;

function u1.isOnSale(p14, p15) -- Line: 328
    -- upvalues: u1 (copy)
    local v16;

    if p14 == nil or table.find(u1.List, p14) == nil then
        v16 = false;
    else
        local v17 = p15 or workspace:GetServerTimeNow();

        if (p14.StartsAt or 0) <= v17 then
            v16 = v17 < (p14.EndsAt or (1 / 0));
        else
            v16 = false;
        end;
    end;

    return v16;
end;

u1.Current = table_freeze_ret4;

for _, v in u1.List do
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v18;

    if (v.StartsAt or 0) <= ServerTimeNow then
        v18 = ServerTimeNow < (v.EndsAt or (1 / 0));
    else
        v18 = false;
    end;

    if v18 and not v.Pair then
        u1.Current = v;
        break;
    end;
end;

function u1.single(p19) -- Line: 342
    -- upvalues: u1 (copy)
    for _, v in u1.List do
        if p19 and v.Pair == p19.Key then
            return v;
        end;
    end;

    return nil;
end;

function u1.shown(p20, p21) -- Line: 353
    -- upvalues: u1 (copy)
    local v22 = p21 or workspace:GetServerTimeNow();
    local v23 = u1.get(p20);

    for i = 1, 8 do
        local v24 = v23 and v23.Next;

        if v24 then
            if (v23.EndsAt or (1 / 0)) <= v22 then
                v24 = u1.get(v23.Next);
            else
                v24 = false;
            end;
        end;

        if not v24 or v22 < (v24.StartsAt or 0) then
            break;
        end;

        v23 = v24;
        local _ = i;
    end;

    return v23;
end;

function u1.get(p25) -- Line: 365
    -- upvalues: u1 (copy)
    for _, v in u1.List do
        if v.Key == p25 then
            return v;
        end;
    end;

    return nil;
end;

function u1.productId(p26, p27) -- Line: 377
    -- upvalues: u1 (copy)
    local v28 = game.GameId == u1.TestUniverseId;

    if p27 and (p26.DiscountProductId or p26.TestDiscountProductId) then
        local v29 = u1.single(p26);
        local v30;

        if v28 and p26.TestDiscountProductId then
            v30 = p26.TestDiscountProductId;
        else
            v30 = p26.DiscountProductId;
        end;

        if v30 and (v29 and u1.purchased(v29, p27)) then
            return v30;
        end;
    end;

    if p26.TestProductId and v28 then
        return p26.TestProductId;
    end;

    return p26.ProductId;
end;

function u1.byProduct(p31) -- Line: 390
    -- upvalues: u1 (copy)
    for _, v in u1.List do
        if not (v.ProductId ~= p31 and (v.TestProductId == nil or v.TestProductId ~= p31) and ((v.DiscountProductId == nil or v.DiscountProductId ~= p31) and (v.TestDiscountProductId == nil or v.TestDiscountProductId ~= p31))) then
            return v;
        end;
    end;

    return nil;
end;

function u1.purchased(p32, p33) -- Line: 406
    if type(p33) ~= "table" then
        return false;
    end;

    if p33[p32.Flag] == true then
        return true;
    end;

    local v34;

    if type(p33.owned) == "table" then
        v34 = p33.owned[p32.SkinId] == true;
    else
        v34 = false;
    end;

    local v35 = not p32.Ability;

    if not v35 then
        if type(p33.abilities) == "table" then
            v35 = p33.abilities[p32.Ability] == true;
        else
            v35 = false;
        end;
    end;

    return v34 and v35;
end;

return table.freeze(u1);