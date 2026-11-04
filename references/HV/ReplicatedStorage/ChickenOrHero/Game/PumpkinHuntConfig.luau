 

 

local u3 = {
    EventName = "Pumpkin Hunt",
    Tag = "HalloweenEventPedestal",
    PromptDistance = 20,
    Unavailable = "This feature is currently not available.",
    Pot = table.freeze({
        Goal = 1500,
        Max = 5000,
        Amounts = table.freeze({ 50, 100, 250, 500 })
    }),
    CooldownSeconds = 900,
    HuntMap = "Map5",
    HuntSeconds = 90,
    People = table.freeze({
        PerPlayer = 2,
        Min = 6,
        Max = 20,
        Speed = 20,
        MirrorSpeed = 30,
        Front = 7,
        Spread = 4,
        Aggro = 30,
        Leash = 60,
        WanderSpeed = 7,
        WanderRadius = 25,
        RiseSeconds = 2.4,
        TellAfter = 3,
        TellWarn = 1,
        LungeSpeed = 46,
        LungeSeconds = 0.35,
        LungeReach = 4.5,
        LungeCooldown = 2,
        BreakRange = 22,
        DashAfter = 8,
        SpawnClearance = 18,
        BodyGoneSeconds = 4,
        WanderPause = table.freeze({ 1.5, 4 })
    }),
    HitsToOut = 4,
    HitGrace = 1,
    Anims = table.freeze({
        Idle = "rbxassetid://124290622952477",
        Walk = "rbxassetid://99198240253774",
        Rise = "rbxassetid://79361541928556",
        Lunge = "rbxassetid://85674065679433"
    }),
    KnifeChanceMin = 25,
    KnifeChanceMax = 100,
    Roll = 1000000,
    Knife = "PumpkinSovereign",
    RestrictedCoins = 100,
    Prizes = table.freeze({
        table.freeze({
            Id = "Spin",
            Kind = "Spins",
            Amount = 1,
            Weight = 2,
            Name = "1 Wheel Spin"
        }),
        table.freeze({
            Id = "GemBoost",
            Kind = "GemBoostMinutes",
            Amount = 15,
            Weight = 8,
            Name = "2x Gems 15m"
        }),
        table.freeze({
            Id = "Gems100",
            Kind = "Gems",
            Amount = 100,
            Weight = 10,
            Name = "100 Gems"
        }),
        table.freeze({
            Id = "Candy750",
            Kind = "CandyCorn",
            Amount = 375,
            Weight = 10,
            Name = "375 Candy Corn"
        }),
        table.freeze({
            Id = "Candy250",
            Kind = "CandyCorn",
            Amount = 125,
            Weight = 25,
            Name = "125 Candy Corn"
        }),
        table.freeze({
            Id = "GhostKey",
            Kind = "GhostKeys",
            Amount = 1,
            Weight = 15,
            Name = "1 Ghost Key"
        }),
        table.freeze({
            Id = "Gems50",
            Kind = "Gems",
            Amount = 50,
            Weight = 25,
            Name = "50 Gems"
        }),
        table.freeze({
            Id = "Gems25",
            Kind = "Gems",
            Amount = 25,
            Weight = 40,
            Name = "25 Gems"
        })
    }),
    KnifeDuplicateGems = 40,
    PumpkinCap = 1000,
    Tiers = table.freeze({
        table.freeze({
            Name = "Plain",
            From = 25,
            Color = Color3.fromRGB(214, 128, 58)
        }),
        table.freeze({
            Name = "Lucky",
            From = 40,
            Color = Color3.fromRGB(118, 222, 96)
        }),
        table.freeze({
            Name = "Blessed",
            From = 60,
            Color = Color3.fromRGB(176, 98, 255)
        }),
        table.freeze({
            Name = "MAXED",
            From = 100,
            Color = Color3.fromRGB(255, 202, 58)
        })
    }),
    Sounds = table.freeze({
        Sacrifice = { "rbxassetid://1841354543", 0.45 },
        Tell = { "rbxassetid://9114446852", 0.7 },
        Lunge = { "rbxassetid://9120972321", 0.8 },
        Hit = { "rbxassetid://9113480915", 0.9 },
        Out = { "rbxassetid://17208353912", 0.8 },
        AnkleBreak = { "rbxassetid://9119559518", 1 },
        HeadPop = { "rbxassetid://9113511790", 0.8 },
        Haunted = { "rbxassetid://9126213995", 0.8 },
        Collect = { "rbxassetid://9116395089", 0.8 },
        Rise = { "rbxassetid://9125881620", 0.8 },
        Coins = { "rbxassetid://9117243937", 0.9 }
    }),

    whole = function(p1) -- Line: 144, Name: whole
        local v2;

        if type(p1) == "number" and (p1 == p1 and (p1 % 1 == 0 and p1 >= 0)) then
            v2 = p1 < 9007199254740992;
        else
            v2 = false;
        end;

        return v2;
    end
};

local function divide(p4, p5) -- Line: 150
    local v6 = p4 // p5;

    while v6 > 0 and p4 < v6 * p5 do
        v6 = v6 - 1;
    end;

    while (v6 + 1) * p5 <= p4 do
        v6 = v6 + 1;
    end;

    return v6;
end;

u3.divide = divide;

function u3.chance(p7) -- Line: 164
    -- upvalues: u3 (copy), divide (copy)
    local Goal = u3.Pot.Goal;
    local Max = u3.Pot.Max;
    local v8;

    if type(p7) == "number" and (p7 == p7 and (p7 % 1 == 0 and p7 >= 0)) then
        v8 = p7 < 9007199254740992;
    else
        v8 = false;
    end;

    if not v8 or p7 < Goal then
        return nil;
    end;

    local KnifeChanceMin = u3.KnifeChanceMin;
    local KnifeChanceMax = u3.KnifeChanceMax;
    local v9 = Max - Goal;

    if v9 <= 0 then
        return KnifeChanceMax;
    end;

    local v10 = math.min(p7, Max) - Goal;

    return KnifeChanceMin + divide((KnifeChanceMax - KnifeChanceMin) * v10 * v10, v9 * v9);
end;

function u3.tier(p11) -- Line: 179
    -- upvalues: u3 (copy)
    local v12 = u3.Tiers[1];

    for _, v in u3.Tiers do
        local v13;

        if type(p11) == "number" and (p11 == p11 and (p11 % 1 == 0 and p11 >= 0)) then
            v13 = p11 < 9007199254740992;
        else
            v13 = false;
        end;

        if v13 and v.From <= p11 then
            v12 = v;
        end;
    end;

    return v12;
end;

function u3.slots(p14) -- Line: 191
    -- upvalues: u3 (copy), divide (copy)
    local v15;

    if type(p14) == "number" and (p14 == p14 and (p14 % 1 == 0 and p14 >= 0)) then
        v15 = p14 < 9007199254740992;
    else
        v15 = false;
    end;

    local v16;

    if v15 then
        v16 = math.clamp(p14, u3.KnifeChanceMin, u3.KnifeChanceMax);
    else
        v16 = u3.KnifeChanceMin;
    end;

    local v17 = v16 * divide(u3.Roll, 10000);
    local v18 = u3.Roll - v17;
    local v19 = 0;

    for _, v in u3.Prizes do
        v19 = v19 + v.Weight;
    end;

    local v20 = {
        {
            id = "Knife",
            kind = "Knife",
            amount = 1,
            name = u3.Knife,
            slots = v17
        }
    };
    local v21 = nil;

    for _, v in u3.Prizes do
        local v22 = {
            id = v.Id,
            name = v.Name,
            kind = v.Kind,
            amount = v.Amount,
            slots = divide(v18 * v.Weight, v19)
        };
        v17 = v17 + v22.slots;
        v21 = (not v21 or v.Weight > v21.weight) and {
            entry = v22,
            weight = v.Weight
        } or v21;
        table.insert(v20, v22);
    end;

    local entry = v21.entry;
    entry.slots = entry.slots + (u3.Roll - v17);

    return v20;
end;

function u3.ranked(p23) -- Line: 220
    local table_clone_ret = table.clone(p23);
    local u24 = {};

    for i, v in p23 do
        u24[v] = i;
    end;

    table.sort(table_clone_ret, function(p25, p26) -- Line: 226
        -- upvalues: u24 (copy)
        if p25.kind == "Knife" ~= (p26.kind == "Knife") then
            return p25.kind == "Knife";
        end;

        if p25.slots == p26.slots then
            return u24[p25] < u24[p26];
        end;

        return p25.slots < p26.slots;
    end);

    return table_clone_ret;
end;

function u3.pick(p27, p28) -- Line: 239
    local v29 = 0;

    for _, v in p27 do
        v29 = v29 + v.slots;

        if p28 <= v29 then
            return v;
        end;
    end;

    return p27[#p27];
end;

function u3.percents(u30) -- Line: 252
    -- upvalues: divide (copy), u3 (copy)
    local u31 = divide(u3.Roll, 10000);
    local u32 = {};
    local v33 = 0;
    local v34 = {};

    for i, v in u30 do
        u32[i] = divide(v.slots, u31);
        v33 = v33 + u32[i];
        table.insert(v34, i);
    end;

    table.sort(v34, function(p35, p36) -- Line: 260
        -- upvalues: u30 (copy), u32 (copy), u31 (copy)
        local v37 = u30[p35].slots - u32[p35] * u31;
        local v38 = u30[p36].slots - u32[p36] * u31;

        if v37 == v38 then
            return p35 < p36;
        end;

        return v38 < v37;
    end);

    for i = 1, 10000 - v33 do
        local v39 = v34[(i - 1) % #v34 + 1];
        u32[v39] = u32[v39] + 1;
        local _ = i;
    end;

    return u32;
end;

function u3.percentText(p40) -- Line: 276
    return string.format("%d.%02d%%", p40 // 100, p40 % 100);
end;

function u3.chanceText(p41) -- Line: 281
    -- upvalues: u3 (copy)
    if p41 % 100 == 0 then
        return string.format("%d%%", p41 // 100);
    end;

    return u3.percentText(p41);
end;

function u3.commas(p42) -- Line: 286
    local math_floor_ret = math.floor(p42);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

function u3.short(p43) -- Line: 293
    -- upvalues: divide (copy)
    local function cut(p44, p45, p46) -- Line: 294
        -- upvalues: divide (ref)
        local v47 = divide(p44 * 10, p45);

        if v47 % 10 == 0 then
            return tostring(v47 // 10) .. p46;
        end;

        return tostring(v47 // 10) .. "." .. tostring(v47 % 10) .. p46;
    end;

    local v48;

    if type(p43) == "number" and (p43 == p43 and (p43 % 1 == 0 and p43 >= 0)) then
        v48 = p43 < 9007199254740992;
    else
        v48 = false;
    end;

    if not v48 then
        return "0";
    end;

    if p43 >= 1000000 then
        local v49 = divide(p43 * 10, 1000000);

        if v49 % 10 == 0 then
            return tostring(v49 // 10) .. "M";
        end;

        return tostring(v49 // 10) .. "." .. tostring(v49 % 10) .. "M";
    end;

    if p43 < 1000 then
        return tostring(p43);
    end;

    local v50 = divide(p43 * 10, 1000);

    if v50 % 10 == 0 then
        return tostring(v50 // 10) .. "K";
    end;

    return tostring(v50 // 10) .. "." .. tostring(v50 % 10) .. "K";
end;

function u3.check() -- Line: 310
    -- upvalues: u3 (copy)
    local Pot = u3.Pot;
    local Goal = Pot.Goal;
    local v51;

    if type(Goal) == "number" and (Goal == Goal and (Goal % 1 == 0 and Goal >= 0)) then
        v51 = Goal < 9007199254740992;
    else
        v51 = false;
    end;

    if v51 then
        v51 = Pot.Goal > 0;
    end;

    assert(v51, "PumpkinHuntConfig: Pot.Goal must be a whole number above 0");
    local Max = Pot.Max;
    local v52;

    if type(Max) == "number" and (Max == Max and (Max % 1 == 0 and Max >= 0)) then
        v52 = Max < 9007199254740992;
    else
        v52 = false;
    end;

    if v52 then
        v52 = Pot.Max >= Pot.Goal;
    end;

    assert(v52, "PumpkinHuntConfig: Pot.Max must be a whole number, at least Goal");
    assert(Pot.Max - Pot.Goal <= 10000000, "PumpkinHuntConfig: Pot.Max - Pot.Goal may be at most " .. 10000000);
    local v53;

    if #Pot.Amounts >= 1 then
        v53 = #Pot.Amounts <= 6;
    else
        v53 = false;
    end;

    assert(v53, "PumpkinHuntConfig: 1 to 6 Pot.Amounts");

    for _, v in Pot.Amounts do
        local v54;

        if type(v) == "number" and (v == v and (v % 1 == 0 and v >= 0)) then
            v54 = v < 9007199254740992;
        else
            v54 = false;
        end;

        if v54 then
            if v > 0 then
                v54 = v <= Pot.Max;
            else
                v54 = false;
            end;
        end;

        assert(v54, "PumpkinHuntConfig: bad Pot.Amounts entry");
    end;

    local CooldownSeconds = u3.CooldownSeconds;
    local v55;

    if type(CooldownSeconds) == "number" and (CooldownSeconds == CooldownSeconds and (CooldownSeconds % 1 == 0 and CooldownSeconds >= 0)) then
        v55 = CooldownSeconds < 9007199254740992;
    else
        v55 = false;
    end;

    assert(v55, "PumpkinHuntConfig: CooldownSeconds must be a whole number");
    local HuntSeconds = u3.HuntSeconds;
    local v56;

    if type(HuntSeconds) == "number" and (HuntSeconds == HuntSeconds and (HuntSeconds % 1 == 0 and HuntSeconds >= 0)) then
        v56 = HuntSeconds < 9007199254740992;
    else
        v56 = false;
    end;

    if v56 then
        v56 = u3.HuntSeconds >= 10;
    end;

    assert(v56, "PumpkinHuntConfig: HuntSeconds must be a whole number, at least 10");
    local KnifeDuplicateGems = u3.KnifeDuplicateGems;
    local v57;

    if type(KnifeDuplicateGems) == "number" and (KnifeDuplicateGems == KnifeDuplicateGems and (KnifeDuplicateGems % 1 == 0 and KnifeDuplicateGems >= 0)) then
        v57 = KnifeDuplicateGems < 9007199254740992;
    else
        v57 = false;
    end;

    assert(v57, "PumpkinHuntConfig: KnifeDuplicateGems must be a whole number");
    local PumpkinCap = u3.PumpkinCap;
    local v58;

    if type(PumpkinCap) == "number" and (PumpkinCap == PumpkinCap and (PumpkinCap % 1 == 0 and PumpkinCap >= 0)) then
        v58 = PumpkinCap < 9007199254740992;
    else
        v58 = false;
    end;

    if v58 then
        if u3.PumpkinCap > 0 then
            v58 = u3.PumpkinCap <= 100000;
        else
            v58 = false;
        end;
    end;

    assert(v58, "PumpkinHuntConfig: bad PumpkinCap");
    local v59 = type(u3.HuntMap) == "string";
    assert(v59, "PumpkinHuntConfig: HuntMap must be a map id");
    local KnifeChanceMin = u3.KnifeChanceMin;
    local v60;

    if type(KnifeChanceMin) == "number" and (KnifeChanceMin == KnifeChanceMin and (KnifeChanceMin % 1 == 0 and KnifeChanceMin >= 0)) then
        v60 = KnifeChanceMin < 9007199254740992;
    else
        v60 = false;
    end;

    if v60 then
        local KnifeChanceMax = u3.KnifeChanceMax;

        if type(KnifeChanceMax) == "number" and (KnifeChanceMax == KnifeChanceMax and (KnifeChanceMax % 1 == 0 and KnifeChanceMax >= 0)) then
            v60 = KnifeChanceMax < 9007199254740992;
        else
            v60 = false;
        end;

        if v60 then
            if u3.KnifeChanceMin >= 1 then
                v60 = u3.KnifeChanceMin <= u3.KnifeChanceMax;
            else
                v60 = false;
            end;
        end;
    end;

    assert(v60, "PumpkinHuntConfig: bad knife chances");
    assert(u3.KnifeChanceMax <= 10000, "PumpkinHuntConfig: KnifeChanceMax is at most 10000 (100%)");
    assert(u3.Roll == 1000000, "PumpkinHuntConfig: Roll must stay 1000000");
    local v61 = 0;

    for _, v in u3.Prizes do
        local Weight = v.Weight;
        local v62;

        if type(Weight) == "number" and (Weight == Weight and (Weight % 1 == 0 and Weight >= 0)) then
            v62 = Weight < 9007199254740992;
        else
            v62 = false;
        end;

        if v62 then
            if v.Weight > 0 then
                v62 = v.Weight <= 1000000;
            else
                v62 = false;
            end;
        end;

        local v63 = "PumpkinHuntConfig: bad Weight on " .. tostring(v.Id);
        assert(v62, v63);
        local Amount = v.Amount;
        local v64;

        if type(Amount) == "number" and (Amount == Amount and (Amount % 1 == 0 and Amount >= 0)) then
            v64 = Amount < 9007199254740992;
        else
            v64 = false;
        end;

        if v64 then
            v64 = v.Amount > 0;
        end;

        local v65 = "PumpkinHuntConfig: bad Amount on " .. tostring(v.Id);
        assert(v64, v65);
        v61 = v61 + v.Weight;
    end;

    local v66;

    if #u3.Prizes >= 1 then
        v66 = v61 > 0;
    else
        v66 = false;
    end;

    assert(v66, "PumpkinHuntConfig: needs prizes");

    for _, v in u3.Tiers do
        local From = v.From;
        local v67;

        if type(From) == "number" and (From == From and (From % 1 == 0 and From >= 0)) then
            v67 = From < 9007199254740992;
        else
            v67 = false;
        end;

        assert(v67, "PumpkinHuntConfig: bad tier");
    end;

    return true;
end;

return table.freeze(u3);