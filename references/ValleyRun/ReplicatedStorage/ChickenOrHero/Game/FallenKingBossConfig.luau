 

 

local u1 = {};
local v2;

if game.GameId == 10768621983 then
    v2 = game.PlaceId == 130574217370467;
else
    v2 = false;
end;

u1.Enabled = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).FallenKingBoss == true;
u1.MapId = "Map1";
u1.Lighting = "Map7";
u1.LiveSeconds = 780;
u1.ShieldCatchUp = 10;
u1.SummonSeconds = 900;
u1.SummonHealthPerPlayer = 3000;
u1.SummonHealthMin = 3000;
u1.Intro = {
    Cutscene = "EventStart",
    Seconds = 46.5,
    HandBack = 1.5,
    Lead = 1,
    SendLead = 20,
    StudioSendLead = 2,
    CoverFade = 1,
    LightingFade = 0.5,
    CoverSeconds = 10,
    CoverLimit = 30,
    PreloadSeconds = 600,
    CastSeconds = 45,
    Cast = 8,
    Dress = false,
    LateStart = 30,
    Order = { "zstrxz", "graseterga2", "demlightt", "tenosicks", "gabriel", "NvrLvcky", "OFFICIALFAYYY", "stilivs" },
    Spots = {
        CFrame.lookAt(Vector3.new(119.65, 22.83, -110.45), Vector3.new(119.77, 22.83, -109.457)),
        CFrame.lookAt(Vector3.new(113.66, 22.76, -110.8), Vector3.new(113.509, 22.76, -109.812)),
        CFrame.lookAt(Vector3.new(126.56, 22.83, -110.72), Vector3.new(126.077, 22.83, -109.844)),
        CFrame.lookAt(Vector3.new(108.61, 22.56, -110.27), Vector3.new(108.392, 22.56, -109.294)),
        CFrame.lookAt(Vector3.new(132.4, 22.9, -110.04), Vector3.new(132.24, 22.9, -109.053)),
        CFrame.lookAt(Vector3.new(102.7, 22.75, -110.5), Vector3.new(102.881, 22.75, -109.516))
    },
    KingSpot = CFrame.lookAt(Vector3.new(115.82, 26.92, 12.52), Vector3.new(115.83, 26.92, 11.52)),
    Keep = { "test", "Rig" },
    Hide = { "Dark knight rig", "FallenKingFight" },
    Teasers = { {
            Before = 3600,
            Text = "Something stirs beneath the valley..."
        }, {
            Before = 1800,
            Text = "The King grows restless."
        }, {
            Before = 900,
            Text = "Gather. The King wakes in 15 minutes."
        }, {
            Before = 300,
            Text = "He\'s waking up."
        }, {
            Before = 10,
            Text = "Kneel."
        } }
};
u1.Music = {
    Id = 102975980003788,
    Volume = 0.3,
    FadeIn = 0.5,
    FadeOut = 1.5
};
u1.Phases = { {
        Name = "THE KING\'S COURT",
        Until = 0.5
    }, {
        Name = "THE SHRINES",
        Until = 0.3
    }, {
        Name = "THE LAST STAND",
        Until = 0
    } };
u1.King = {
    WalkSpeed = 14,
    WalkSpeedLastStand = 19,
    CatchRadius = 7,
    BodyRadius = 4.5,
    Wall = false,
    TouchRadius = 5.5,
    DazeSeconds = 4,
    DazeFlight = 10,
    Grace = 2
};
u1.Animations = {
    Walk = 119853906057825,
    TwinSweep = 134109010269847,
    GraveLunge = 78929605508507,
    SummonCourt = 70603441405083,
    ShrineSlam = 131694034119993,
    AxeRain = 88224550381681,
    DisarmedStart = 117679287625586,
    DisarmedLoop = 90934039384116,
    ShieldBreakStart = 129636115785800,
    ShieldBreakLoop = 119215840010809,
    Death = 122051986302313
};
u1.Sounds = {
    TwinSweep = {
        Id = 121274632522764,
        Volume = 1.6
    },
    GraveLunge = {
        Id = 123860371500764,
        Volume = 1.1
    },
    ShrineSlam = {
        Id = 85305571278350,
        Volume = 1
    },
    AxeRain = {
        Id = 127322689669796,
        Volume = 1.3
    },
    ShieldBreakStart = {
        Id = 114677405757672,
        Volume = 0.6
    },
    Death = {
        Id = 120172246513745,
        Volume = 1.6
    },
    SummonCourt = {
        Id = 9113980319,
        Volume = 1.6
    }
};
u1.TwinSweep = {
    Every = 9,
    LastStandEvery = 6,
    Warn = 1,
    Radius = 16,
    StrikeAt = 0.67
};
u1.GraveLunge = {
    Every = 12,
    LastStandEvery = 8,
    Warn = 1.1,
    Length = 60,
    Width = 6,
    Speed = 90
};
u1.SummonCourt = {
    Count = 4,
    MaxAlive = 10
};
u1.Waves = { {
        At = 0.95,
        Court = 3
    }, {
        At = 0.9,
        Court = 6
    }, {
        At = 0.8,
        KnifeRain = true
    }, {
        At = 0.7,
        Court = "PerPlayer",
        Min = 10
    }, {
        At = 0.6,
        Zombies = 6,
        Skeletons = 6
    }, {
        At = 0.1,
        KnifeRain = true
    } };
u1.KnifeRain = {
    WalkSpeed = 22,
    IdleSeconds = 1,
    RoarSeconds = 1.3,
    Knives = 30,
    PerPlayer = 2,
    MaxKnives = 70,
    Seconds = 4.5,
    Warn = 1.4,
    Radius = 4,
    OnPlayers = 0.4
};
u1.AxeRain = {
    Every = 18,
    Circles = 10,
    Radius = 7,
    Warn = 1.4,
    Disarmed = 4,
    DisarmedMultiplier = 2
};
u1.Shrines = {
    Count = 4,
    Health = 6000,
    SummonHealthPerPlayer = 300,
    SummonHealthMin = 1500,
    RegenPerSecond = 60,
    RegenDelay = 6,
    GuardEvery = 7,
    Stun = 5,
    HitShare = {
        Few = 3,
        FewShare = 0.05,
        Many = 30,
        ManyShare = 0.015
    },
    RegenShare = {
        Few = 3,
        FewShare = 0.008333333333333333,
        Many = 30,
        ManyShare = 0.0025
    }
};
u1.Turrets = {
    Count = 4,
    FireEvery = 3.5,
    FireballSpeed = 22,
    FireballRadius = 3
};
u1.Fog = {
    ShrinkSeconds = 25,
    MinRadiusShare = 0.5,
    CatchSeconds = 3
};
u1.Bombs = {
    Damage = 120,
    MaxCombo = 64,
    Speed = 70,
    SpeedPerBounce = 8,
    CatchRadius = 5,
    HitRadius = 6,
    Base = 5,
    PerPlayer = 1,
    Scale = 1.2,
    Fuse = 12,
    SpawnEvery = { 6, 5, 3 }
};
u1.KnifeChip = math.floor(u1.Bombs.Damage / 3);
u1.Strike = {
    Reach = 12,
    DiveReach = 11,
    Arc = 0.3
};
u1.KnifeRarity = {
    Common = 1,
    Rare = 1.15,
    Epic = 1.3,
    Legendary = 1.45,
    Mythical = 1.6
};
u1.Hearts = {
    Count = 3,
    Grace = 1.2,
    Dodge = 0.5,
    Halves = {
        TwinSweep = 2,
        GraveLunge = 2,
        AxeRain = 2,
        Fog = 2,
        Fireball = 1,
        Court = 0.5,
        Touch = 1,
        Pumpkin = 1,
        KnifeRain = 1
    }
};
u1.Launch = {
    Min = 25,
    Max = 60,
    Seconds = 0.9,
    Pose = 0.5,
    Slide = 8,
    Chip = 10
};
u1.HeartDrops = {
    Every = 0.1,
    PickupRadius = 5,
    MinFromKing = 15,
    Sound = {
        Id = 6373199071,
        Volume = 0.8
    }
};
u1.HitSounds = {
    Hurt = {
        Id = 102109874814687,
        Volume = 0.9
    },
    Land = {
        Id = 9114036511,
        Volume = 0.8
    }
};
u1.OfferingBonus = 0.1;
u1.LateJoin = {
    MinShare = 0.15,
    GraceSeconds = 30
};
u1.ParticipantSeconds = 60;
u1.SpoilsSeconds = 14;
u1.TopDamage = 10;
u1.Kingslayers = 3;
u1.Summon = {
    CoinsPerPlayer = 8000,
    SoulCoins = 100,
    TeaserGap = 3,
    HoldSeconds = 0.6,
    PromptDistance = 16,
    Reach = 45,
    Deposits = { 100, 1000, 10000 },
    Countdown = v2 and 10 or 120,
    RestSeconds = v2 and 60 or 600,
    Luck = { {
            At = 50000,
            Blades = 3,
            Axes = 2
        }, {
            At = 15000,
            Blades = 2,
            Axes = 1.5
        }, {
            At = 5000,
            Blades = 1.5,
            Axes = 1.25
        }, {
            At = 1000,
            Blades = 1.25,
            Axes = 1
        }, {
            At = 0,
            Blades = 1,
            Axes = 1
        } }
};
u1.Revive = {
    DownSeconds = 60
};
u1.Respawn = {
    Enabled = true,
    ProductId = 3723810336,
    TestProductId = 3723810396
};

function u1.phase(p3) -- Line: 344
    -- upvalues: u1 (copy)
    for i, v in u1.Phases do
        if v.Until < p3 then
            return i;
        end;
    end;

    return #u1.Phases;
end;

function u1.luck(p4) -- Line: 352
    -- upvalues: u1 (copy)
    for _, v in u1.Summon.Luck do
        if (p4 or 0) >= v.At then
            return v;
        end;
    end;

    return u1.Summon.Luck[#u1.Summon.Luck];
end;

return u1;