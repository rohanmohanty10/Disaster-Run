  

local v1 = {};
local TeamJerseys = require(game:GetService("ReplicatedStorage").Shared.TeamJerseys);
v1.YenPerAction = {
    Goal = 10000000,
    Assist = 7000000,
    Save = 5000000,
    Steal = 800000
};
v1.GamesPerOffer = 5;
v1.PositionBuckets = {
    Striker = { "Goal" },
    Midfielder = { "Assist" },
    Defender = { "Save", "Steal" }
};
v1.PositionPriority = { "Striker", "Midfielder", "Defender" };
v1.DominantMultiplier = 2;
v1.StatMultiplierTiers = { 2, 1.5, 1.25, 1 };
v1.ContractLengths = { 5, 10, 15 };
v1.LengthRewardMultiplier = {
    [5] = 1,
    [10] = 2,
    [15] = 3
};
v1.DefaultKit = {
    Shirt = "rbxassetid://110155109558501",
    Pants = "rbxassetid://134336241618805"
};
v1.TeamCountries = {
    REAL = "Spain 🇪🇸",
    ["Bastard Munchen"] = "Germany 🇩🇪",
    PXG = "France 🇫🇷",
    Arsenaly = "England 🏴󠁧󠁢󠁥󠁮󠁧󠁿",
    Manshine = "England 🏴󠁧󠁢󠁥󠁮󠁧󠁿",
    Barcha = "Spain 🇪🇸",
    Ubers = "Italy 🇮🇹"
};
v1.TeamColors = {
    REAL = { Color3.fromRGB(20, 60, 180), Color3.fromRGB(90, 150, 255) },
    ["Bastard Munchen"] = { Color3.fromRGB(150, 20, 30), Color3.fromRGB(255, 90, 90) },
    PXG = { Color3.fromRGB(15, 25, 80), Color3.fromRGB(55, 100, 230) },
    Manshine = { Color3.fromRGB(30, 130, 205), Color3.fromRGB(135, 215, 255) },
    Ubers = { Color3.fromRGB(45, 30, 75), Color3.fromRGB(140, 95, 215) },
    Barcha = { Color3.fromRGB(20, 40, 140), Color3.fromRGB(160, 35, 80) },
    Arsenaly = { Color3.fromRGB(170, 20, 30), Color3.fromRGB(255, 195, 75) }
};
v1.TeamKits = {
    ["Bastard Munchen"] = TeamJerseys.Home["4"],
    Manshine = TeamJerseys.Home["3"],
    Ubers = TeamJerseys.Home["5"],
    Barcha = TeamJerseys.Away["4"],
    PXG = TeamJerseys.Away["5"],
    REAL = TeamJerseys.Home["9"],
    Arsenaly = TeamJerseys.Home["6"]
};
v1.GradeRank = {
    S = 4,
    A = 3,
    B = 2,
    C = 1,
    D = 0
};
v1.GradeRubric = {
    Offense = { { "S", 4 }, { "A", 3 }, { "B", 2 }, { "C", 1 } },
    Shooting = { { "S", 4 }, { "A", 3 }, { "B", 2 }, { "C", 1 } },
    Dribble = { { "S", 7 }, { "A", 6 }, { "B", 4 }, { "C", 2 } },
    Passing = { { "S", 9 }, { "A", 7 }, { "B", 5 }, { "C", 3 } }
};
v1.DefenseRubric = {
    Steals = { { "S", 6 }, { "A", 5 }, { "B", 3 }, { "C", 1 } },
    Saves = { { "S", 5 }, { "A", 4 }, { "B", 3 }, { "C", 2 } }
};
v1.Teams = { {
        Name = "REAL",
        Prestige = 1,
        RewardPool = "REAL",
        BaseContract = 250000000
    }, {
        Name = "Bastard Munchen",
        Prestige = 2,
        RewardPool = "Munchen",
        BaseContract = 180000000
    }, {
        Name = "PXG",
        Prestige = 3,
        RewardPool = "PXG",
        BaseContract = 150000000
    }, {
        Name = "Arsenaly",
        Prestige = 4,
        RewardPool = "Arsenaly",
        BaseContract = 90000000
    }, {
        Name = "Manshine",
        Prestige = 5,
        RewardPool = "Manshine",
        BaseContract = 75000000
    }, {
        Name = "Barcha",
        Prestige = 6,
        RewardPool = "Barcha",
        BaseContract = 45000000
    }, {
        Name = "Ubers",
        Prestige = 7,
        RewardPool = "Ubers",
        BaseContract = 30000000
    } };
v1.TeamRequirements = {
    REAL = { "S", "S", "S" },
    ["Bastard Munchen"] = { "S", "S", "A" },
    PXG = { "S", "A", "A" },
    Arsenaly = { "A", "A", "B" },
    Manshine = { "B", "B", "C" },
    Barcha = { "C", "C", "D" },
    Ubers = {}
};
v1.TeamTotalThreshold = {
    REAL = 80,
    ["Bastard Munchen"] = 70,
    PXG = 55,
    Arsenaly = 40,
    Manshine = 30,
    Barcha = 15,
    Ubers = 0
};
v1.ContractBand = {
    BaseWiden = 0.15,
    WidenPerGame = 0.01,
    MaxWiden = 0.6
};
v1.FilteredPass = {
    MinDistance = 15,
    ReturnCooldown = 5
};
v1.MaxSwitchOffers = 2;
v1.ScoreBands = { { "S", 90 }, { "A", 75 }, { "B", 55 }, { "C", 35 } };
v1.ScoreMax = {
    Offense = 4.5,
    Shooting = 4.5,
    Dribble = 7.5,
    Passing = 9.5
};
v1.DefenseScoreMax = {
    Steals = 6.5,
    Saves = 5.5
};
v1.SpeedPlaceholder = 50;
v1.GradeLetterScore = {
    S = 95,
    A = 82,
    B = 65,
    C = 45,
    D = 20
};
v1.SpeedRanking = {
    Loki = "S",
    ["NEL Chigiri"] = "S",
    ["Don Lorenzo"] = "A",
    Chigiri = "A",
    ["NEL Rin"] = "A",
    Yukimiya = "A",
    ["NEL Isagi"] = "A",
    Nagi = "B",
    ["NEL Bachira"] = "B",
    King = "B",
    Reo = "B",
    Rin = "B",
    Charles = "B",
    ["NEL Reo"] = "B",
    Lavinho = "B",
    Otoya = "C",
    Raichi = "C",
    Karasu = "C",
    Isagi = "C",
    Ness = "C",
    Kiyora = "C",
    Bachira = "C",
    Shidou = "C",
    Aiku = "C",
    ["NEL Nagi"] = "C",
    Sae = "C",
    Kaiser = "C",
    Hiori = "C",
    Kurona = "D",
    Gagamaru = "D",
    Kunigami = "D"
};
v1.AcademyReward = { {
        Type = "Money",
        Amount = 5000
    }, {
        Type = "StyleSpins",
        Amount = 3
    } };
v1.TeamLifetimeBillion = 1000000000;
v1.Questline = { {
        Threshold = 500000000,
        RewardKind = "ChatTag"
    }, {
        Threshold = 1500000000,
        RewardKind = "PlayerCard"
    }, {
        Threshold = 3000000000,
        RewardKind = "GoalEffect"
    } };
v1.CareerRewardBrackets = { {
        MinYen = 50000000,
        RewardPool = "Career1",
        Icon = "rbxassetid://124378809116694"
    }, {
        MinYen = 100000000,
        RewardPool = "Career2",
        Icon = "rbxassetid://133145997029970"
    }, {
        MinYen = 150000000,
        RewardPool = "Career3",
        Icon = "rbxassetid://79578357526127"
    }, {
        MinYen = 200000000,
        RewardPool = "Career4",
        Icon = "rbxassetid://73417471982030"
    }, {
        MinYen = 250000000,
        RewardPool = "Career5",
        Icon = "rbxassetid://107943104322968"
    } };
v1.NpcIcons = {
    Rin = "rbxassetid://90013011807959",
    Isagi = "rbxassetid://112314334726518",
    Shidou = "rbxassetid://137901787697333",
    Barou = "rbxassetid://108702138940598",
    Nagi = "rbxassetid://105249457248883",
    Bachira = "rbxassetid://73482475412906",
    Chigiri = "rbxassetid://114227146240716",
    Reo = "rbxassetid://89690730962908",
    Kunigami = "rbxassetid://123260986755529",
    Otoya = "rbxassetid://80978604531682",
    Aiku = "rbxassetid://114649899125957",
    Karasu = "rbxassetid://109682083957883",
    Gagamaru = "rbxassetid://112856443855235",
    Aryu = "rbxassetid://89919440410535",
    Yukimiya = "rbxassetid://95182145828472",
    Niko = "rbxassetid://80354859792703",
    Hiori = "rbxassetid://124725100516788",
    Sendou = "rbxassetid://85755657657946",
    Kurona = "rbxassetid://74066875062727",
    Fukaku = "rbxassetid://121609091953884",
    Raichi = "rbxassetid://103682302541656",
    Kiyora = "rbxassetid://100625753553386",
    Nanase = "rbxassetid://84113269466626",
    ["Don Lorenzo"] = "rbxassetid://108439121572308"
};
v1.TeamIcons = {
    REAL = "rbxassetid://131695367201121",
    ["Bastard Munchen"] = "rbxassetid://91706667107571",
    PXG = "rbxassetid://107529915501024",
    Arsenaly = "rbxassetid://76693209522206",
    Manshine = "rbxassetid://109641041914920",
    Barcha = "rbxassetid://94991122495366",
    Ubers = "rbxassetid://116008361609819"
};
v1.NpcSalaryRanges = {
    Rin = { 33500000, 49000000 },
    Isagi = { 33500000, 49000000 },
    Shidou = { 29500000, 44500000 },
    Barou = { 28500000, 44500000 },
    Nagi = { 10500000, 49000000 },
    Bachira = { 21500000, 35500000 },
    Chigiri = { 15500000, 30500000 },
    Reo = { 14100000, 28100000 },
    Kunigami = { 12700000, 26700000 },
    Otoya = { 8100000, 20100000 },
    Aiku = { 8500000, 22500000 },
    Karasu = { 7500000, 25500000 },
    Gagamaru = { 2500000, 17500000 },
    Aryu = { 1500000, 16500000 },
    Yukimiya = { 1000000, 15900000 },
    Niko = { 1000000, 15500000 },
    Hiori = { 1000000, 15300000 },
    Sendou = { 1000000, 14900000 },
    Kurona = { 1000000, 14500000 },
    Fukaku = { 1000000, 13100000 },
    Raichi = { 1000000, 12900000 },
    Kiyora = { 1000000, 12700000 },
    Nanase = { 1000000, 12500000 }
};
v1.RewardPools = {
    Career1 = { {
            Type = "PlayerCard",
            Name = "Karasu",
            Display = "Karasu Player Card"
        } },
    Career2 = { {
            Type = "Cosmetic",
            Name = "Bachira Aura",
            Display = "Bachira Aura"
        } },
    Career3 = { {
            Type = "Cosmetic",
            Name = "Shidou Aura",
            Display = "Shidou Aura"
        } },
    Career4 = { {
            Type = "GoalEffect",
            Name = "Rin Goal",
            Display = "Rin Goal Effect"
        } },
    Career5 = { {
            Type = "Cosmetic",
            Name = "Ruby Puffer",
            Display = "Ruby Puffer"
        } },
    REAL = { {
            Type = "Money",
            MinAmount = 22000,
            MaxAmount = 28000
        }, {
            Type = "LuckyStyleSpins",
            MinAmount = 8,
            MaxAmount = 10
        }, {
            Type = "LuckyFlowSpins",
            MinAmount = 5,
            MaxAmount = 7
        }, {
            Type = "Cosmetic",
            Name = "REAL Aura"
        } },
    Munchen = { {
            Type = "Money",
            MinAmount = 20000,
            MaxAmount = 25000
        }, {
            Type = "LuckyStyleSpins",
            MinAmount = 7,
            MaxAmount = 9
        }, {
            Type = "LuckyFlowSpins",
            MinAmount = 4,
            MaxAmount = 6
        }, {
            Type = "Cosmetic",
            Name = "Munchen Aura"
        } },
    PXG = { {
            Type = "Money",
            MinAmount = 18000,
            MaxAmount = 23000
        }, {
            Type = "LuckyStyleSpins",
            MinAmount = 6,
            MaxAmount = 8
        }, {
            Type = "LuckyFlowSpins",
            MinAmount = 3,
            MaxAmount = 5
        }, {
            Type = "Cosmetic",
            Name = "PXG Aura"
        } },
    Arsenaly = { {
            Type = "Money",
            MinAmount = 14000,
            MaxAmount = 20000
        }, {
            Type = "LuckyStyleSpins",
            MinAmount = 5,
            MaxAmount = 7
        }, {
            Type = "LuckyFlowSpins",
            MinAmount = 1,
            MaxAmount = 4
        }, {
            Type = "Cosmetic",
            Name = "Arsenaly Aura"
        } },
    Manshine = { {
            Type = "Money",
            MinAmount = 11000,
            MaxAmount = 16000
        }, {
            Type = "LuckyStyleSpins",
            MinAmount = 4,
            MaxAmount = 6
        }, {
            Type = "LuckyFlowSpins",
            MinAmount = 2,
            MaxAmount = 3
        }, {
            Type = "Cosmetic",
            Name = "Manshine Aura"
        } },
    Barcha = { {
            Type = "Money",
            MinAmount = 6000,
            MaxAmount = 10000
        }, {
            Type = "LuckyStyleSpins",
            MinAmount = 1,
            MaxAmount = 3
        }, {
            Type = "LuckyFlowSpins",
            MinAmount = 1,
            MaxAmount = 2
        }, {
            Type = "Cosmetic",
            Name = "Barcha Aura"
        } },
    Ubers = { {
            Type = "Money",
            MinAmount = 4000,
            MaxAmount = 8000
        }, {
            Type = "StyleSpins",
            MinAmount = 7,
            MaxAmount = 12
        }, {
            Type = "FlowSpins",
            MinAmount = 6,
            MaxAmount = 10
        }, {
            Type = "Cosmetic",
            Name = "Ubers Aura"
        } }
};

return v1;