 

 

local v1 = {
    MinLevel = 10,
    AccountAgeDays = 30,
    LeaveSafeSeconds = 10,
    HeroRevealSeconds = 1.6,
    EndEventRounds = 3,
    EndEventChaserShare = 0.5,
    Runner = {
        Crossing = 5,
        CrossingPerChasers = 2,
        CrossingMax = 14,
        Hero = 10,
        HeroPerChaser = 3,
        HeroMax = 75,
        EndEventRound = 15,
        Win = 50,
        LastCaught = { 25, 15, 10 }
    },
    Chaser = {
        Catch = 8,
        BountyPerCrossing = 1,
        BountyMax = 10,
        EndEventCatch = 5,
        FinalCatch = 15
    },
    StartingChaserMirror = true,
    DivisionRP = 100,
    Tiers = { {
            Name = "Bronze",
            Divisions = 4,
            Entry = 0
        }, {
            Name = "Silver",
            Divisions = 4,
            Entry = 10
        }, {
            Name = "Gold",
            Divisions = 4,
            Entry = 18
        }, {
            Name = "Platinum",
            Divisions = 4,
            Entry = 26
        }, {
            Name = "Diamond",
            Divisions = 4,
            Entry = 35
        }, {
            Name = "Master",
            Divisions = 4,
            Entry = 45
        }, {
            Name = "Grandmaster",
            Divisions = 0,
            Entry = 55
        } },
    ChampionTop = 100,
    Placements = 5,
    PlacementCap = "Gold",
    TierShieldMatches = 3,
    PreSeasonEndsUTC = 1794679200,
    SeasonStartHourPT = 10,
    DivisionReward = {
        Coins = 250
    },
    TierRewards = {
        Silver = {
            Coins = 1000
        },
        Gold = {
            Coins = 2000
        },
        Platinum = {
            Coins = 3000
        },
        Diamond = {
            Coins = 5000
        },
        Master = {
            Coins = 7500
        },
        Grandmaster = {
            Coins = 10000
        }
    },
    SeasonRewards = {
        Bronze = {
            Coins = 500,
            Exclusive = "Season icon"
        },
        Silver = {
            Coins = 1000,
            Exclusive = "Season title"
        },
        Gold = {
            Coins = 2000,
            Exclusive = "Season ranked knife"
        },
        Platinum = {
            Coins = 3500,
            Exclusive = "Knife effect"
        },
        Diamond = {
            Coins = 5000,
            Exclusive = "Ranked emote"
        },
        Master = {
            Coins = 7500,
            Exclusive = "Animated knife"
        },
        Grandmaster = {
            Coins = 10000,
            Exclusive = "Second ranked emote"
        }
    },
    TierIcons = {
        Bronze = "rbxassetid://130793335599648",
        Silver = "rbxassetid://84327724380270",
        Gold = "rbxassetid://115254098438613",
        Platinum = "rbxassetid://104892601805943",
        Diamond = "rbxassetid://77394043535877",
        Master = "rbxassetid://122031037783690",
        Grandmaster = "rbxassetid://112325732740739"
    },
    ChampionIcon = "rbxassetid://119992582300952",
    TierColors = {
        Bronze = Color3.fromRGB(205, 127, 70),
        Silver = Color3.fromRGB(196, 206, 218),
        Gold = Color3.fromRGB(255, 202, 58),
        Platinum = Color3.fromRGB(80, 220, 200),
        Diamond = Color3.fromRGB(110, 170, 255),
        Master = Color3.fromRGB(190, 110, 255),
        Grandmaster = Color3.fromRGB(255, 80, 96)
    },
    LobbySize = 20,
    MinLobby = 15,
    QueueFillSeconds = 60,
    BandWidenSeconds = 30,
    ArriveSeconds = 40,
    MinStart = 2,
    AfterMatchSeconds = 90,
    StudioQueueSeconds = 5,
    RepeatCatchMatches = 5,
    AFKSeconds = 20,
    LeaverRP = 20,
    LeaverCooldownMinutes = { 5, 15, 60 },
    LoadoutEnabled = false,
    Credits = 100,
    ReadyShare = 0.3333333333333333,
    ReadyCountdownSeconds = 15,
    LoadoutMaxSeconds = 45,
    Loadout = {
        MaxUses = 3,
        Abilities = {
            Cloak = 40,
            SoulReap = 40,
            OneHitShield = 35,
            TimeWarp = 35,
            FartCloud = 30,
            PumpkinBomb = 30,
            Burrow = 30,
            InflatableDecoy = 25,
            PocketDoor = 25,
            EmergencyAirhorn = 20,
            RocketShoes = 35,
            BearTrap = 30,
            BrokenVow = 30,
            KingsDemise = 30,
            PiratesCall = 30,
            SpringBox = 30,
            BigDagger = 25,
            BowlingBall = 20,
            RufusLeash = 20
        },
        Items = {
            RescueKit = 30,
            Lifeline = 15,
            Adrenaline = 10,
            BananaPeel = 5
        },
        Default = {
            Runner = "OneHitShield",
            Catcher = "BearTrap",
            Item = "Adrenaline",
            Uses = 2
        }
    }
};

return table.freeze(v1);