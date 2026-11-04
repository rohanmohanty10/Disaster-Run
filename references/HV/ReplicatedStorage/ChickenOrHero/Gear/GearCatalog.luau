 

 

local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local u1 = {
    Enabled = true,
    SalesEnabled = true,
    MaxInventory = 1000000,
    PackSize = 3,
    Order = { "Lifeline", "RescueKit", "Adrenaline", "BananaPeel", "InflatableDecoy", "EmergencyAirhorn", "PocketDoor", "RufusLeash", "BowlingBall", "RocketShoes", "BigDagger", "Cloak", "OneHitShield", "BearTrap", "BrokenVow", "TimeWarp", "FartCloud", "Burrow", "SoulReap", "SpringBox", "KingsDemise", "PumpkinBomb", "PiratesCall" },
    Items = {
        BigDagger = {
            IconImage = "rbxassetid://103668834121739",
            Kind = "Ability",
            Cooldown = 25,
            Name = "BIG DAGGER",
            Tag = "A LITTLE EXTRA REACH",
            Description = "2× melee reach for your next hit. Expires in 5s.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Gems = 1125,
            Coins = 0,
            ProductId = 3715925637,
            Preview = "BigDagger",
            Accent = Color3.fromRGB(255, 180, 98)
        },
        Cloak = {
            IconImage = "rbxassetid://134839019713281",
            Kind = "Ability",
            Cooldown = 35,
            Name = "CLOAK",
            Tag = "BLINK AND I\'M GONE",
            Description = "Cloak for 3s. Still hittable and faintly visible up close. Using an item ends it.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Gems = 1625,
            Coins = 0,
            ProductId = 3715925800,
            Preview = "Cloak",
            Accent = Color3.fromRGB(170, 150, 245)
        },
        OneHitShield = {
            IconImage = "rbxassetid://88625045611008",
            Free = true,
            Kind = "Ability",
            Cooldown = 45,
            Name = "ONE HIT SHIELD",
            Tag = "NICE TRY",
            Description = "Block the next hit. Shield lasts 0.75s.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Gems = 0,
            Coins = 0,
            Preview = "OneHitShield",
            Accent = Color3.fromRGB(110, 205, 255)
        },
        BearTrap = {
            IconImage = "rbxassetid://101513963819420",
            Free = true,
            ThrowRange = 10,
            TriggerRadius = 2,
            TrapDuration = 12,
            StunDuration = 0.5,
            Kind = "Ability",
            Cooldown = 35,
            Name = "BEAR TRAP",
            Tag = "WATCH YOUR STEP",
            Description = "Throw a trap 10 studs ahead. Stops the first runner for 0.5s. Trap lasts 12s.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Gems = 0,
            Coins = 0,
            Preview = "BearTrap",
            Accent = Color3.fromRGB(222, 112, 96)
        },
        BrokenVow = {
            IconImage = "rbxassetid://130454449426794",
            Kind = "Ability",
            Cooldown = 45,
            Duration = 5,
            SealSeconds = 0.5,
            Name = "BROKEN VOW",
            Tag = "TILL DEATH DO US PART",
            Description = "For 5s, mark caught runners. Hold revive first to make them chasers.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Bundle = "VowbreakerBundle",
            Gems = 1000,
            Coins = 0,
            ProductId = 3721756643,
            Preview = "BrokenVow",
            HowTo = { "For 5 seconds, runners you strike down are marked.", "Hold revive for half a second to instantly bring them back as chasers.", "Other runners can still revive them, get there first!" },
            Accent = Color3.fromRGB(255, 92, 150)
        },
        TimeWarp = {
            IconImage = "rbxassetid://109918956850825",
            Kind = "Ability",
            Cooldown = 30,
            Rewind = 2,
            Windup = 0.35,
            RewindSeconds = 0.6,
            Name = "TIME WARP",
            Tag = "LET\'S TRY THAT AGAIN",
            Description = "Teleport to where you were 2s ago.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Bundle = "PumpkinCleaverBundle",
            Gems = 1250,
            Coins = 0,
            ProductId = 3721756666,
            Preview = "TimeWarp",
            HowTo = { "Press it to see the path you\'ve run for the last 2 seconds.", "A moment later you snap back to where you were 2 seconds ago.", "Undo a bad turn, or slip away from a chaser who thought they had you." },
            Accent = Color3.fromRGB(120, 200, 255)
        },
        KingsDemise = {
            IconImage = "rbxassetid://9680453974",
            Kind = "Ability",
            Cooldown = 30,
            Duration = 4,
            RiseSeconds = 0.5,
            SinkSeconds = 0.45,
            Stagger = 0.15,
            UnlockText = "UNLOCKS AT 40%  ·  THE FALLEN KING",
            SoldFor = "coins",
            Name = "KING\'S DEMISE",
            Tag = "THE DEAD RISE",
            Description = "Raise 4 gravestones beside you for 4s. Runners can\'t pass them; chasers walk through.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Gems = 0,
            Coins = 3500,
            ProductId = 3721780486,
            Preview = "KingsDemise",
            Spots = { {
                    offset = -3,
                    scale = 1,
                    order = 0
                }, {
                    offset = 3,
                    scale = 1,
                    order = 0
                }, {
                    offset = -6.4,
                    scale = 0.8,
                    order = 1
                }, {
                    offset = 6.4,
                    scale = 0.8,
                    order = 1
                } },
            Sounds = {
                Rise = "rbxassetid://9118666385",
                Whisper = "rbxassetid://9114228524",
                Sink = "rbxassetid://9125874350"
            },
            Unlock = {
                FallenKing = 0.4
            },
            HowTo = { "Four gravestones burst out of the ground beside you, two on each side.", "Runners can\'t get through them; you and other chasers walk straight through.", "After 4 seconds they sink back into the ground." },
            Accent = Color3.fromRGB(150, 120, 255)
        },
        PiratesCall = {
            IconImage = "rbxassetid://101305941614771",
            Kind = "Ability",
            Cooldown = 35,
            RiseSeconds = 0.75,
            Speed = 37,
            ChargeSeconds = 6,
            AimRange = 90,
            CatchRadius = 3.5,
            KnockSpeed = 12,
            KnockSeconds = 1.2,
            Name = "RAISE THE CREW",
            Tag = "ALL HANDS ON DECK",
            Description = "Raise 2 skeletons that hunt down the nearest runners and knock them down.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Bundle = "SpectralCutlassBundle",
            Gems = 1250,
            Coins = 0,
            Preview = "PiratesCall",
            Spots = { -3.5, 3.5 },
            Sounds = {
                Call = "rbxassetid://9120921325",
                Break = "rbxassetid://9113542694"
            },
            HowTo = { "Two skeletons climb out beside you", "They hunt the nearest runners and knock them down" },
            Accent = Color3.fromRGB(110, 230, 170)
        },
        Burrow = {
            IconImage = "rbxassetid://99077389400318",
            Kind = "Ability",
            Cooldown = 30,
            Distance = 25,
            RandomMin = 10,
            MinDistance = 10,
            Tries = 8,
            WindupSeconds = 0.45,
            HoleOpen = 0.15,
            HoleSize = 4.5,
            Seconds = 0.35,
            PopSeconds = 0.35,
            TunnelDepth = 5,
            GraveScale = 0.5,
            GraveSeconds = 3.2,
            RewardOnly = true,
            UnlockText = "THE FALLEN KING  ·  OFFER 500 SOULS",
            RewardText = "OFFER 500 SOULS",
            Name = "BURROW",
            Tag = "UNDERGROUND",
            Description = "Drop into a hole and pop out of another one up to 25 studs away.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Gems = 0,
            Coins = 0,
            Preview = "Burrow",
            Sounds = {
                Windup = "rbxassetid://88871879896373",
                Dive = "rbxassetid://9114083260",
                Tunnel = "rbxassetid://9114105633",
                Rise = "rbxassetid://9114083746",
                Pop = "rbxassetid://88871879896373"
            },
            HowTo = { "A hole opens under you and you drop in.", "Another opens somewhere up to 25 studs away and you pop out of it, short of walls and the safe zone.", "Chasers can\'t catch you while you\'re underground." },
            Accent = Color3.fromRGB(150, 110, 70)
        },
        FartCloud = {
            IconImage = "rbxassetid://96463241737620",
            Kind = "Ability",
            Cooldown = 30,
            Duration = 5,
            SpeedBonus = 3,
            Blur = 16,
            Radius = 9,
            Ahead = 12,
            SlowLinger = 0.75,
            Name = "FART",
            Tag = "PFFFT!",
            Description = "Run faster for 5s and leave a cloud that slows chasers who walk into it.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Bundle = "HexflaskBundle",
            Gems = 1125,
            Coins = 0,
            ProductId = 3721775734,
            Preview = "FartCloud",
            Sounds = { "rbxassetid://127442694123149", "rbxassetid://78155558349937", "rbxassetid://102366969521213" },
            HowTo = { "Let one rip: you run faster for 5 seconds.", "A green cloud hangs just ahead of you for 5 seconds: run through it and leave it behind.", "Any chaser who runs into it is slowed while they\'re inside." },
            Accent = Color3.fromRGB(150, 210, 70)
        },
        SoulReap = {
            IconImage = "rbxassetid://111039045804565",
            Bundle = "SoulbinderBundle",
            Kind = "Ability",
            Cooldown = 45,
            Range = 35,
            Cap = 3,
            FloatAnimation = "rbxassetid://101889161861379",
            FollowAnimation = "rbxassetid://125219113314922",
            CollectAnimation = "rbxassetid://96169997888891",
            Name = "SOUL REAP",
            Tag = "YOUR TURN NEXT",
            Description = "Collect nearby fallen teammates’ souls. Each soul gives you an extra life.",
            InfoNote = "Self-revive disabled when ability is equipped",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Gems = 1625,
            Coins = 0,
            ProductId = 3721777009,
            Preview = "SoulReap",
            GhostColor = Color3.fromRGB(90, 210, 255),
            Lines = { "You let me die.", "Don\'t think I forgot.", "Your turn next.", "You didn\'t even try.", "I saw you run.", "Was it worth it?", "I\'m right behind you.", "You owe me.", "Cold, isn\'t it?", "Keep running.", "Did you even look back?", "Why didn\'t you save me?", "Was I just a spare life?", "Do you feel safer now?", "Would you do it again?", "I trusted you.", "You could have revived me.", "Does it weigh on you?", "Was I worth more dead?", "Who\'s next?", "You\'ll join me soon.", "Can you hear them coming?", "Say my name.", "How does my soul feel?" },
            HowTo = { "Steal a nearby fallen teammate\'s soul.", "Gain an extra life.", "Carry up to 3 at the same time." },
            Accent = Color3.fromRGB(90, 200, 255)
        },
        SpringBox = {
            IconImage = "rbxassetid://133047936964566",
            Bundle = "ClownKillerBundle",
            ThrowRange = 13,
            Count = 3,
            SpreadDegrees = 35,
            TrapDuration = 2,
            BurstRadius = 12,
            RagdollSeconds = 1.5,
            FlingMax = 8,
            FlingFullSpeed = 24,
            BlastHop = 2,
            ShakeSeconds = 2,
            Kind = "Ability",
            Cooldown = 35,
            Name = "SPRING BOX",
            Tag = "SURPRISE!",
            Description = "Throw 3 boxes that explode after 2s and send nearby runners flying.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Gems = 1250,
            Coins = 0,
            ProductId = 3721777025,
            Preview = "SpringBox",
            HowTo = { "Throw 3 jack-in-the-boxes in an arc, 13 studs ahead.", "After 2 seconds the boxes explode: nearby runners are ragdolled and thrown the way they were running." },
            Accent = Color3.fromRGB(255, 70, 90)
        },
        PumpkinBomb = {
            IconImage = "rbxassetid://88167995522171",
            Kind = "Ability",
            Charges = 3,
            StartCharges = 1,
            ChargeSeconds = 35,
            Cooldown = 0.5,
            ThrowRange = 12,
            MomentumLead = 1.3,
            MomentumMaxSpeed = 60,
            AheadMin = 4,
            FlightSeconds = 0.75,
            Radius = 12,
            Height = 9,
            Duration = 6,
            KnockbackStuds = 9,
            KnockbackSeconds = 0.3,
            Name = "JACK-O-BOMB",
            Tag = "NOW YOU SEE ME",
            Description = "Throw a thick smoke bomb that hides outlines. Up to 3 bombs.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Bundle = "HallowreaperBundle",
            Gems = 1250,
            Coins = 0,
            ProductId = 3722714901,
            Preview = "PumpkinBomb",
            Sounds = {
                Throw = "rbxassetid://74238153433253",
                Burst = "rbxassetid://110329372880748",
                Hiss = "rbxassetid://108173766941619"
            },
            HowTo = { "Throw a smoke that hides your team", "Get a bomb every 35s, up to 3" },
            Accent = Color3.fromRGB(255, 140, 40)
        },
        InflatableDecoy = {
            IconImage = "rbxassetid://129293392144023",
            Kind = "Ability",
            Cooldown = 30,
            Name = "INFLATABLE DECOY",
            Tag = "DOUBLE TROUBLE",
            Description = "Send a decoy straight ahead for 7s. Pops when caught.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Coins = 840,
            Gems = 1200,
            ProductId = 3715705958,
            Preview = "InflatableDecoy",
            Accent = Color3.fromRGB(118, 212, 242)
        },
        EmergencyAirhorn = {
            IconImage = "rbxassetid://135681589443426",
            Kind = "Ability",
            Cooldown = 18,
            Name = "EMERGENCY AIRHORN",
            Tag = "SMALL HORN. BIG PANIC.",
            Description = "Knock back all nearby chasers.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Coins = 630,
            Gems = 1450,
            ProductId = 3715705962,
            Preview = "EmergencyAirhorn",
            Accent = Color3.fromRGB(255, 190, 92)
        },
        PocketDoor = {
            IconImage = "rbxassetid://91558112029977",
            Kind = "Ability",
            Cooldown = 25,
            Name = "POCKET DOOR",
            Tag = "NOT TODAY",
            Description = "Place a door ahead for 6s. Chasers can break it or go around.",
            Role = "RUNNER",
            UseRole = "Runner",
            RoleItem = true,
            Coins = 840,
            Gems = 875,
            ProductId = 3715705964,
            Preview = "PocketDoor",
            Accent = Color3.fromRGB(177, 152, 245)
        },
        RufusLeash = {
            HitRadius = 15,
            HoldSeconds = 1,
            ThrowRange = 15,
            IconImage = "rbxassetid://80899283856876",
            Kind = "Ability",
            Cooldown = 20,
            Name = "RUFUS’S LEASH",
            Tag = "COME BACK HERE",
            Description = "Throw up to 15 studs. Pull and hold a runner for up to 1s.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Coins = 840,
            Gems = 1625,
            ProductId = 3715705971,
            Preview = "RufusLeash",
            Accent = Color3.fromRGB(240, 168, 114)
        },
        BowlingBall = {
            IconImage = "rbxassetid://111231700334254",
            Kind = "Ability",
            Cooldown = 20,
            Name = "BOWLING BALL",
            Tag = "STRIKE!",
            Description = "Roll a ball. A direct hit briefly trips a runner.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Coins = 630,
            Gems = 600,
            ProductId = 3715705976,
            Preview = "BowlingBall",
            Accent = Color3.fromRGB(168, 142, 240)
        },
        RocketShoes = {
            IconImage = "rbxassetid://92376622457972",
            CarrySeconds = 0.6,
            Kind = "Ability",
            Cooldown = 28,
            Name = "ROCKET SHOES",
            Tag = "BRAKES SOLD SEPARATELY",
            Description = "Dash where you’re moving—or where your camera faces if standing still.",
            Role = "CHASER",
            UseRole = "Catcher",
            RoleItem = true,
            Coins = 420,
            Gems = 1300,
            ProductId = 3715705981,
            Preview = "RocketShoes",
            Accent = Color3.fromRGB(255, 136, 103)
        },
        BananaPeel = {
            IconImage = "rbxassetid://112706356863131",
            Kind = "Item",
            Cooldown = 12,
            Name = "BANANA PEEL",
            Tag = "A LITTLE SLIP-UP",
            Description = "Throw a peel. Trips the first opponent. Lasts 15s.",
            Role = "RUNNER / CATCHER",
            Coins = 135,
            Gems = 60,
            ProductId = 3715698235,
            Preview = "BananaPeel",
            Accent = Color3.fromRGB(242, 207, 105)
        },
        RescueKit = {
            IconImage = "rbxassetid://118675460882511",
            Kind = "Item",
            Cooldown = 32,
            BossCooldown = 120,
            Name = "RESCUE KIT",
            Tag = "BACK ON YOUR FEET",
            Description = "Revive yourself if rescue is available.",
            Role = "RUNNER",
            UseRole = "Runner",
            Coins = 609,
            Gems = 90,
            ProductId = 3715698237,
            Preview = "RescueKit",
            Accent = Color3.fromRGB(128, 218, 180)
        },
        Adrenaline = {
            IconImage = "rbxassetid://102044304638173",
            Kind = "Item",
            Cooldown = 12,
            Name = "ADRENALINE",
            Tag = "FIND YOUR SECOND WIND",
            Description = "Speed burst and +75% acceleration.",
            Burst = 5,
            BurstSeconds = 1.2,
            Role = "RUNNER / CATCHER",
            Coins = 135,
            Gems = 60,
            ProductId = 3715698239,
            Preview = "Adrenaline",
            Accent = Color3.fromRGB(137, 192, 246)
        },
        Lifeline = {
            IconImage = "rbxassetid://90097519208597",
            Kind = "Item",
            Cooldown = 15,
            Name = "LIFELINE",
            Tag = "HOLD ON TIGHT",
            Description = "Drag a downed runner to safety for 10s.",
            Range = 30,
            Length = 5,
            DragSeconds = 10,
            ThrowSeconds = 0.35,
            CutsToBreak = 3,
            CutRadius = 4.5,
            PullSpeed = 40,
            Role = "RUNNER",
            UseRole = "Runner",
            Coins = 135,
            Gems = 60,
            ProductId = 3720137594,
            Preview = "Lifeline",
            Accent = Color3.fromRGB(240, 92, 80)
        }
    }
};
local table_clone_ret = table.clone(u1.Items.PumpkinBomb);
table_clone_ret.Pair = "PumpkinBomb";
table_clone_ret.Role = "CHASER";
table_clone_ret.UseRole = "Catcher";
table_clone_ret.Preview = "PumpkinBombChaser";
u1.Items.PumpkinBombChaser = table_clone_ret;
u1.ProductGrants = {
    [3715925637] = {
        UniverseId = 10764627709,
        Item = "BigDagger",
        Amount = 1
    },
    [3715925800] = {
        UniverseId = 10764627709,
        Item = "Cloak",
        Amount = 1
    },
    [3715705958] = {
        UniverseId = 10764627709,
        Item = "InflatableDecoy",
        Amount = 1
    },
    [3715705962] = {
        UniverseId = 10764627709,
        Item = "EmergencyAirhorn",
        Amount = 1
    },
    [3715705964] = {
        UniverseId = 10764627709,
        Item = "PocketDoor",
        Amount = 1
    },
    [3715705971] = {
        UniverseId = 10764627709,
        Item = "RufusLeash",
        Amount = 1
    },
    [3715705976] = {
        UniverseId = 10764627709,
        Item = "BowlingBall",
        Amount = 1
    },
    [3715705981] = {
        UniverseId = 10764627709,
        Item = "RocketShoes",
        Amount = 1
    },
    [3715702794] = {
        UniverseId = 10764627709,
        Item = "InflatableDecoy",
        Amount = 3
    },
    [3715702796] = {
        UniverseId = 10764627709,
        Item = "EmergencyAirhorn",
        Amount = 3
    },
    [3715702799] = {
        UniverseId = 10764627709,
        Item = "PocketDoor",
        Amount = 3
    },
    [3715702801] = {
        UniverseId = 10764627709,
        Item = "RufusLeash",
        Amount = 3
    },
    [3715702805] = {
        UniverseId = 10764627709,
        Item = "BowlingBall",
        Amount = 3
    },
    [3715702806] = {
        UniverseId = 10764627709,
        Item = "RocketShoes",
        Amount = 3
    },
    [3715698235] = {
        UniverseId = 10764627709,
        Item = "BananaPeel",
        Amount = 3
    },
    [3715698237] = {
        UniverseId = 10764627709,
        Item = "RescueKit",
        Amount = 3
    },
    [3715698239] = {
        UniverseId = 10764627709,
        Item = "Adrenaline",
        Amount = 3
    },
    [3720137594] = {
        UniverseId = 10764627709,
        Item = "Lifeline",
        Amount = 3
    },
    [3721756643] = {
        UniverseId = 10764627709,
        Item = "BrokenVow",
        Amount = 1
    },
    [3721756666] = {
        UniverseId = 10764627709,
        Item = "TimeWarp",
        Amount = 1
    },
    [3721775734] = {
        UniverseId = 10764627709,
        Item = "FartCloud",
        Amount = 1
    },
    [3721777009] = {
        UniverseId = 10764627709,
        Item = "SoulReap",
        Amount = 1
    },
    [3721777025] = {
        UniverseId = 10764627709,
        Item = "SpringBox",
        Amount = 1
    },
    [3721780486] = {
        UniverseId = 10764627709,
        Item = "KingsDemise",
        Amount = 1
    },
    [3722714901] = {
        UniverseId = 10764627709,
        Item = "PumpkinBomb",
        Amount = 1
    }
};
u1.Disabled = {
    PumpkinBombChaser = true
};

if FFlags.LiveFlagsApply and not FFlags.StarterAbilitiesEnabled then
    for i, v in u1.Items do
        if v.Kind == "Ability" and v.Free == true then
            u1.Disabled[i] = true;
        end;
    end;

    for i = #u1.Order, 1, -1 do
        local v2;

        if u1.Disabled[u1.Order[i]] then
            table.remove(u1.Order, i);
            v2 = i;
        else
            v2 = i;
        end;
    end;
end;

function u1.boxYaw(p3, p4) -- Line: 713
    if type(p3) ~= "string" then
        return math.random() * 3.141592653589793 * 2;
    end;

    local v5 = 7 + (tonumber(p4) or 0) * 131;

    for i = 1, #p3 do
        v5 = (v5 * 31 + string.byte(p3, i)) % 1000003;
        local _ = i;
    end;

    return v5 % 3600 / 3600 * 3.141592653589793 * 2;
end;

function u1.boxShake(p6, p7) -- Line: 725
    -- upvalues: u1 (copy)
    local math_clamp_ret = math.clamp(1 - p6 / (u1.Items.SpringBox.ShakeSeconds or 2.5), 0, 1);

    if math_clamp_ret <= 0 then
        return CFrame.identity;
    end;

    local v8 = math_clamp_ret * math_clamp_ret;
    local v9 = v8 * 26 + 18;
    local CFrame_new = CFrame.new;
    local v10 = math.sin(p7 * v9 * 1.3) * 0.08 * v8;
    local math_sin_ret = math.sin(p7 * v9);

    return CFrame_new(v10, math.abs(math_sin_ret) * 0.14 * v8, math.cos(p7 * v9 * 1.1) * 0.08 * v8) * CFrame.Angles(math.sin(p7 * v9) * 0.2 * v8, 0, math.cos(p7 * v9 * 0.9) * 0.2 * v8);
end;

function u1.throwReaches(p11, p12, p13) -- Line: 739
    -- upvalues: u1 (copy)
    local v14 = u1.Items[p11];
    local v15 = v14 and (v14.ThrowRange or 10) or 10;

    if not (v14 and (v14.MomentumLead and (typeof(p12) == "Vector3" and typeof(p13) == "Vector3"))) then
        return { v15 };
    end;

    local v16 = p12:Dot(p13);
    local v17 = math.clamp(v16, 0, v14.MomentumMaxSpeed or 60) * (v14.FlightSeconds or 0);
    local v18 = v15 + v17 * v14.MomentumLead;
    local math_max_ret = math.max(v15, v17 + (v14.AheadMin or 4));
    local math_min_ret = math.min(v18, math_max_ret);

    return v18 - math_min_ret < 1 and { v18 } or {
        v18,
        v18 + (math_min_ret - v18) / 3,
        v18 + (math_min_ret - v18) * 2 / 3,
        math_min_ret
    };
end;

function u1.bundleOnly(p19, p20) -- Line: 756
    if type(p19) ~= "table" or p19.Bundle == nil then
        return false;
    end;

    local success, result = pcall(require, script.Parent.Parent.Weapons.Bundles);

    if success then
        success = result.get(p19.Bundle);
    end;

    return not (success and success.EndsAt) and true or (p20 or workspace:GetServerTimeNow()) < success.EndsAt;
end;

function u1.locked(p21) -- Line: 769
    local v22;

    if type(p21) == "table" then
        v22 = p21.Unlock;
    else
        v22 = false;
    end;

    if type(v22) ~= "table" then
        return false;
    end;

    if v22.FallenKing then
        local Game = script.Parent.Parent:FindFirstChild("Game");

        if (Game and tonumber(Game:GetAttribute("FallenKingProgress")) or 0) < v22.FallenKing then
            return true;
        end;
    end;

    return false;
end;

function u1.pair(p23) -- Line: 784
    -- upvalues: u1 (copy)
    local v24 = u1.Items[p23];

    return v24 and v24.Pair or nil;
end;

function u1.get(p25) -- Line: 788
    -- upvalues: u1 (copy)
    local v26;

    if type(p25) == "string" then
        v26 = not u1.Disabled[p25] and u1.Items[p25] or nil;
    else
        v26 = nil;
    end;

    return v26;
end;

function u1.equippedForRole(p27, p28) -- Line: 792
    -- upvalues: u1 (copy)
    if not p27 then
        return "";
    end;

    if type(p27.equippedAbilities) == "table" then
        return p27.equippedAbilities[p28] or "";
    end;

    local v29 = u1.get(p27.equippedAbility);

    return v29 and (v29.UseRole == p28 and p27.equippedAbility) or "";
end;

return u1;