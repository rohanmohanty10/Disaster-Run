 

 

local u1 = {
    Enabled = true,
    Target = 50000,
    OverMax = 2,
    PickupRadius = 15,
    ClaimSeconds = 2,
    DepositRadius = 39,
    Float = 0,
    SpawnDelay = 1,
    SyncSeconds = 60,
    ThroneName = "Throne",
    StartsAt = DateTime.fromUniversalTime(2026, 10, 24, 17).UnixTimestamp,
    EndsAt = DateTime.fromUniversalTime(2026, 11, 7, 18).UnixTimestamp,
    SpawnsAt = DateTime.fromUniversalTime(2026, 10, 31, 18).UnixTimestamp,
    TrackStartsAt = DateTime.fromUniversalTime(2026, 10, 24, 17).UnixTimestamp,
    TrackEndsAt = DateTime.fromUniversalTime(2026, 10, 31, 17).UnixTimestamp,
    Personal = { {
            At = 5,
            Reward = "500 coins",
            Image = "rbxassetid://89151797781662",
            Coins = 500
        }, {
            At = 15,
            Reward = "+1 Trick & Treat Crate",
            Crate = "HalloweenTrick",
            Crates = {
                HalloweenTrick = 1,
                HalloweenTreat = 1
            }
        }, {
            At = 30,
            Reward = "\"Soulkeeper\" title",
            Image = "rbxassetid://129011720555395",
            Title = "Soulkeeper"
        }, {
            At = 100,
            Reward = "Kneel to the King",
            Sub = "Emote",
            Image = "rbxassetid://75762175680254",
            Emote = "KneelToTheKing"
        }, {
            At = 500,
            Reward = "Burrow",
            Sub = "Runner ability",
            Image = "rbxassetid://99077389400318",
            Ability = "Burrow"
        } },
    LanternLevels = { 1, 2, 3 },
    Stages = { {
            At = 0.2,
            Name = "The stone cracks",
            Line = "Cracks glow purple.",
            Reward = "500 candy corn",
            Candy = 500
        }, {
            At = 0.4,
            Name = "His eyes open",
            Line = "Eyes glow; ground rumbles.",
            Reward = "King\'s Demise (catcher ability)"
        }, {
            At = 0.6,
            Name = "The crown ignites",
            Line = "Ghost fire and circling souls.",
            Reward = "\"Soul Bearer\" title",
            Title = "SoulBearer"
        }, {
            At = 0.8,
            Name = "The chains snap",
            Line = "Chains break; stones float.",
            Reward = "1 Trick Crate + 1 Treat Crate",
            Crates = {
                HalloweenTrick = 1,
                HalloweenTreat = 1
            }
        }, {
            At = 1,
            Name = "The king awakens",
            Line = "The boss spawns.",
            Reward = "+10% damage to start the boss fight",
            BossBonus = 0.1
        } }
};

function u1.active(p2) -- Line: 64
    -- upvalues: u1 (copy)
    if not u1.Enabled then
        return false;
    end;

    if game:GetService("RunService"):IsStudio() or game.PlaceId == 130574217370467 then
        return true;
    end;

    local v3 = p2 or os.time();
    local v4;

    if u1.StartsAt <= v3 then
        v4 = v3 < u1.EndsAt;
    else
        v4 = false;
    end;

    return v4;
end;

function u1.progress(p5) -- Line: 77
    -- upvalues: u1 (copy)
    local v6 = p5 or os.time();

    if v6 <= u1.TrackEndsAt then
        return math.clamp((v6 - u1.TrackStartsAt) / (u1.TrackEndsAt - u1.TrackStartsAt), 0, 1);
    end;

    return 1 + math.clamp((v6 - u1.TrackEndsAt) / (u1.EndsAt - u1.TrackEndsAt), 0, 1) * (u1.OverMax - 1);
end;

function u1.stage(p7) -- Line: 87
    -- upvalues: u1 (copy)
    local v8 = 0;

    for i, v in u1.Stages do
        if (p7 or 0) >= v.At - 1e-9 then
            v8 = i;
        end;
    end;

    return v8;
end;

function u1.personal(p9) -- Line: 98
    -- upvalues: u1 (copy)
    local v10 = 0;

    for i, v in u1.Personal do
        if (p9 or 0) >= v.At then
            v10 = i;
        end;
    end;

    return v10;
end;

function u1.level(p11) -- Line: 109
    -- upvalues: u1 (copy)
    local v12 = 0;

    for i, v in u1.LanternLevels do
        if v <= (p11 or 0) then
            v12 = i;
        end;
    end;

    return v12;
end;

return u1;