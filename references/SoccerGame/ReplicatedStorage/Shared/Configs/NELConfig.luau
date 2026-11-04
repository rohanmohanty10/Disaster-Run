  

return {
    QuestTrackDesc = {
        Goal = "Score goals",
        Assist = "Set up goals with assists",
        Steal = "Steal the ball from opponents",
        AnkleBreakers = "Break your opponents\' ankles",
        Hatrick = "Score hat-tricks",
        GoalFirst30s = "Score within the first 30 seconds",
        AssistWithin10s = "Assist a goal within 10s of your pass",
        StealOwnHalf = "Steal the ball in your own half",
        GoalOutsideBox = "Score from outside the box",
        GoalContribution = "Score or assist goals",
        WinWithContribution = "Win matches while scoring or assisting",
        AllRounderGames = "Get 1 goal, 1 assist, 1 ankle break & 1 steal in a match",
        Combo = "Score 3 goals, 2 ankle breaks & earn MVP",
        Games2Goals = "Score 2+ goals in a single match"
    },
    MainQuestDesc = {
        true_egoist = "Complete every team\'s questline",
        nel_champion = "Win NEL matches",
        nel_legend = "Earn MVP in NEL matches",
        nel_prodigy = "Win NEL matches in a row"
    },
    PerkDescriptions = {
        IronThrone = "Earn 5% more XP and Cash from goals you score by yourself",
        EmperorsEgo = "Get 4 hat-tricks across 4 games to earn 1 lucky spin",
        FootballJunkie = "Get 3 goals + 2 ankle breaks + 1 MVP to earn 1 lucky flow spin",
        TheCity = "Earn 12.5% more XP and Cash from assisting, scoring, and dribbling",
        MachCutIn = "Get 5 steals + 5 ankle breaks to earn 1 lucky flow spin",
        PerfectBody = "Get 10 goals + 10 assists to earn 3 lucky flows",
        CrownMessenger = "Earn 12.5% more cash from matches",
        TheInvestment = "Every 20 actions (assist, tackle, save, chem reaction) grants 10% XP bonus next match",
        GoldenTeeth = "Steal the ball 30 times to earn 1 lucky style spin",
        GingaFlow = "Earn 12.5% more XP from ankle breaks",
        ButterflyWings = "Every 10 ankle breaks earns 1 normal style spin",
        StrikersDevoured = "6x chain dribbles OR 6x assists OR 6x chem reactions earns 1 flow spin",
        RoyalBlood = "Earn 5% more XP and Cash from overall match activity (must use Rin/Sae)",
        MetaVision = "Get 8 assists + 4 chem reactions to earn 1 lucky spin",
        DestroyerFlow = "Get 2 hat-tricks in a row to earn 1 lucky flow spin",
        CannonFire = "Win the match to earn 15% more XP and Cash",
        AchromaticSight = "Get 7.5% salary increase per steal and assist earned",
        Chameleon = "Get 2 goals + 2 assists + 2 steals to earn 20% more cash",
        ParisStrength = "Earn 12.5% more cash and points for using a PXG style",
        RelentlessTalent = "Get 2 MVPs in a row to earn 1 lucky spin",
        GameMaster = "Passes leading to a goal earn you 7.5% more XP"
    },
    TeamPerks = {
        ["Bastard Munchen"] = { {
                Key = "IronThrone",
                Name = "Iron Throne",
                Icon = "rbxassetid://100355595340145",
                Type = "Passive",
                Stat = "XPCash",
                Percent = 0.05,
                Condition = "SoloGoal"
            }, {
                Key = "EmperorsEgo",
                Name = "Emperor\'s Ego",
                Icon = "rbxassetid://128731004565319",
                Type = "Progress",
                Track = "HatrickAcrossGames",
                Goal = 4,
                Repeatable = true,
                Reward = { {
                        Type = "LuckyStyleSpins",
                        Amount = 1
                    } }
            }, {
                Key = "FootballJunkie",
                Name = "Football Junkie",
                Icon = "rbxassetid://79646162274794",
                Type = "Progress",
                Track = "Combo",
                Repeatable = true,
                Goal = {
                    Goals = 3,
                    AnkleBreakers = 2,
                    MVP = 1
                },
                Reward = { {
                        Type = "LuckyFlowSpins",
                        Amount = 1
                    } }
            } },
        Manshine = { {
                Key = "TheCity",
                Name = "The City",
                Icon = "rbxassetid://127409049735932",
                Type = "Passive",
                Stat = "XPCash",
                Percent = 0.125,
                Condition = "AssistScoreDribble"
            }, {
                Key = "MachCutIn",
                Name = "Mach Cut-In",
                Icon = "rbxassetid://121845666809069",
                Type = "Progress",
                Track = "Combo",
                Repeatable = true,
                Goal = {
                    Steals = 5,
                    AnkleBreakers = 5
                },
                Reward = { {
                        Type = "LuckyFlowSpins",
                        Amount = 1
                    } }
            }, {
                Key = "PerfectBody",
                Name = "Perfect Body",
                Icon = "rbxassetid://114714019950535",
                Type = "Progress",
                Track = "Combo",
                Repeatable = true,
                Goal = {
                    Goals = 10,
                    Assists = 10
                },
                Reward = { {
                        Type = "LuckyFlowSpins",
                        Amount = 3
                    } }
            } },
        Ubers = { {
                Key = "CrownMessenger",
                Name = "Crown Messenger",
                Icon = "rbxassetid://130828796374592",
                Type = "Passive",
                Stat = "Cash",
                Percent = 0.125,
                Condition = "Match"
            }, {
                Key = "TheInvestment",
                Name = "The Investment",
                Icon = "rbxassetid://129215189364805",
                Type = "Progress",
                Track = "ActionCount",
                Goal = 20,
                Repeatable = true,
                Reward = { {
                        Type = "XPBoostNextMatch",
                        Amount = 0.1
                    } }
            }, {
                Key = "GoldenTeeth",
                Name = "Golden Teeth",
                Icon = "rbxassetid://138507928540804",
                Type = "Progress",
                Track = "Steal",
                Goal = 30,
                Repeatable = true,
                Reward = { {
                        Type = "LuckyStyleSpins",
                        Amount = 1
                    } }
            } },
        Barcha = { {
                Key = "GingaFlow",
                Name = "Ginga Flow",
                Icon = "rbxassetid://116275966010681",
                Type = "Passive",
                Stat = "XP",
                Percent = 0.125,
                Condition = "AnkleBreak"
            }, {
                Key = "ButterflyWings",
                Name = "Butterfly Wings",
                Icon = "rbxassetid://124912241237853",
                Type = "Progress",
                Track = "AnkleBreakers",
                Goal = 10,
                Repeatable = true,
                Reward = { {
                        Type = "StyleSpins",
                        Amount = 1
                    } }
            }, {
                Key = "StrikersDevoured",
                Name = "Strikers Devoured",
                Icon = "rbxassetid://128289881739712",
                Type = "Progress",
                Track = "AnyOf",
                Repeatable = true,
                Goal = {
                    ChainDribbles = 6,
                    Assists = 6,
                    ChemReactions = 6
                },
                Reward = { {
                        Type = "FlowSpins",
                        Amount = 1
                    } }
            } },
        REAL = { {
                Key = "RoyalBlood",
                Name = "Royal Blood",
                Icon = "rbxassetid://125905801807324",
                Type = "Passive",
                Stat = "XPCash",
                Percent = 0.05,
                Condition = "Match",
                StyleGate = { "Rin", "Sae" }
            }, {
                Key = "MetaVision",
                Name = "Meta Vision",
                Icon = "rbxassetid://121694663311473",
                Type = "Progress",
                Track = "Combo",
                Repeatable = true,
                Goal = {
                    Assists = 8,
                    ChemReactions = 4
                },
                Reward = { {
                        Type = "LuckyStyleSpins",
                        Amount = 1
                    } }
            }, {
                Key = "DestroyerFlow",
                Name = "Destroyer Flow",
                Icon = "rbxassetid://125489161650955",
                Type = "Progress",
                Track = "HatrickStreak",
                Goal = 2,
                Repeatable = true,
                Reward = { {
                        Type = "LuckyFlowSpins",
                        Amount = 1
                    } }
            } },
        Arsenaly = { {
                Key = "CannonFire",
                Name = "Cannon Fire",
                Icon = "rbxassetid://97679644731186",
                Type = "Passive",
                Stat = "XPCash",
                Percent = 0.15,
                Condition = "Win"
            }, {
                Key = "AchromaticSight",
                Name = "Achromatic Sight",
                Icon = "rbxassetid://120763487195698",
                Type = "Passive",
                Stat = "Yen",
                Percent = 0.075,
                Condition = "StealAssist"
            }, {
                Key = "Chameleon",
                Name = "Chameleon",
                Icon = "rbxassetid://130489504119243",
                Type = "Progress",
                Track = "Combo",
                Repeatable = true,
                Goal = {
                    Goals = 2,
                    Assists = 2,
                    Steals = 2
                },
                Reward = { {
                        Type = "CashPercentNextMatch",
                        Amount = 0.2
                    } }
            } },
        PXG = { {
                Key = "ParisStrength",
                Name = "Paris Strength",
                Icon = "rbxassetid://131042357004450",
                Type = "Passive",
                Stat = "CashPoints",
                Percent = 0.125,
                Condition = "Match",
                StyleGate = { "PXG" }
            }, {
                Key = "RelentlessTalent",
                Name = "Relentless Talent",
                Icon = "rbxassetid://109621403468134",
                Type = "Progress",
                Track = "MvpStreak",
                Goal = 2,
                Repeatable = true,
                Reward = { {
                        Type = "LuckyStyleSpins",
                        Amount = 1
                    } }
            }, {
                Key = "GameMaster",
                Name = "Game Master",
                Icon = "rbxassetid://80855056567551",
                Type = "Passive",
                Stat = "XP",
                Percent = 0.075,
                Condition = "PassLeadingToGoal"
            } }
    },
    TeamQuests = {
        {
            Team = "PXG",
            Key = "pxg_billion",
            Display = "1 Billion Yen on PXG",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "PXG Goals Emote"
                } }
        },
        {
            Team = "Arsenaly",
            Key = "arsenaly_billion",
            Display = "1 Billion Yen on Arsenaly",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "Arsenaly Goals Emote"
                } }
        },
        {
            Team = "Manshine",
            Key = "manshine_billion",
            Display = "1 Billion Yen on Manshine",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "Manshine Goals Emote"
                } }
        },
        {
            Team = "Barcha",
            Key = "barcha_billion",
            Display = "1 Billion Yen on Barcha",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "Barcha Goals Emote"
                } }
        },
        {
            Team = "REAL",
            Key = "real_billion",
            Display = "1 Billion Yen on REAL",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "REAL Goals Emote"
                } }
        },
        {
            Team = "Bastard Munchen",
            Key = "munchen_billion",
            Display = "1 Billion Yen on Munchen",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "Munchen Goals Emote"
                } }
        },
        {
            Team = "Ubers",
            Key = "ubers_billion",
            Display = "1 Billion Yen on Ubers",
            Threshold = 1000000000,
            Reward = { {
                    Type = "Emote",
                    Name = "Ubers Goals Emote"
                } }
        }
    },
    CaptainQuests = {
        {
            Team = "PXG",
            Key = "loki_speedblitz",
            Captain = "Loki",
            Display = "Speed Blitz",
            Track = "GoalFirst30s",
            Goal = 10,
            Hourly = true,
            Reward = { {
                    Type = "Money",
                    Amount = 5000
                } }
        },
        {
            Team = "PXG",
            Key = "charles_gamecreator",
            Captain = "Charles",
            Display = "Game Creator",
            Track = "AssistWithin10s",
            Goal = 10,
            Hourly = true,
            Reward = { {
                    Type = "StyleSpins",
                    Amount = 5
                } }
        },
        {
            Team = "Arsenaly",
            Key = "hugo_ironfortress",
            Captain = "Hugo",
            Display = "Iron Fortress",
            Track = "StealOwnHalf",
            Goal = 30,
            Hourly = true,
            Reward = { {
                    Type = "StyleSpins",
                    Amount = 5
                }, {
                    Type = "Money",
                    Amount = 3000
                } }
        },
        {
            Team = "Arsenaly",
            Key = "reo_chameleon",
            Captain = "Reo",
            Display = "Chameleon Playstyle",
            Track = "AllRounderGames",
            Goal = 2,
            Hourly = true,
            Reward = { {
                    Type = "LuckyFlowSpins",
                    Amount = 1
                } }
        },
        {
            Team = "Manshine",
            Key = "chris_perfecthero",
            Captain = "Chris Prince",
            Display = "Perfect Hero",
            Track = "Hatrick",
            Goal = 3,
            Hourly = true,
            Reward = { {
                    Type = "Money",
                    Amount = 5000
                }, {
                    Type = "StyleSpins",
                    Amount = 5
                } }
        },
        {
            Team = "Manshine",
            Key = "chigiri_redpanther",
            Captain = "Chigiri",
            Display = "Red Panther",
            Track = "Combo",
            Hourly = true,
            Goal = {
                Goals = 15,
                AnkleBreakers = 10
            },
            Reward = { {
                    Type = "Money",
                    Amount = 5000
                } }
        },
        {
            Team = "Barcha",
            Key = "lavinho_thedancer",
            Captain = "Lavinho",
            Display = "The Dancer",
            Track = "AnkleBreakers",
            Goal = 25,
            Hourly = true,
            Reward = { {
                    Type = "Money",
                    Amount = 10000
                } }
        },
        {
            Team = "Barcha",
            Key = "bunny_rabbitrampage",
            Captain = "Bunny",
            Display = "Rabbit Rampage",
            Track = "Goal",
            Goal = 25,
            Hourly = true,
            Reward = { {
                    Type = "LuckyFlowSpins",
                    Amount = 1
                } }
        },
        {
            Team = "REAL",
            Key = "sae_thecode",
            Captain = "Sae",
            Display = "The Code",
            Track = "Assist",
            Goal = 25,
            Hourly = true,
            Reward = { {
                    Type = "StyleSpins",
                    Amount = 3
                } }
        },
        {
            Team = "REAL",
            Key = "rin_destruction",
            Captain = "Rin",
            Display = "Absolute Destruction",
            Track = "Games2Goals",
            Goal = 5,
            Hourly = true,
            Reward = { {
                    Type = "Money",
                    Amount = 5000
                } }
        },
        {
            Team = "Bastard Munchen",
            Key = "noa_worldsbest",
            Captain = "Noel Noa",
            Display = "World\'s Best",
            Track = "GoalContribution",
            Goal = 30,
            Hourly = true,
            Reward = { {
                    Type = "Money",
                    Amount = 6000
                } }
        },
        {
            Team = "Bastard Munchen",
            Key = "kaiser_emperor",
            Captain = "Kaiser",
            Display = "The Emperor",
            Track = "GoalOutsideBox",
            Goal = 15,
            Hourly = true,
            Reward = { {
                    Type = "StyleSpins",
                    Amount = 3
                } }
        },
        {
            Team = "Ubers",
            Key = "snuffy_win10",
            Captain = "Snuffy",
            Display = "Snuffy",
            Track = "WinWithContribution",
            Goal = 10,
            Hourly = true,
            Reward = { {
                    Type = "Money",
                    Amount = 7500
                } }
        },
        {
            Team = "Ubers",
            Key = "lorenzo_zombie",
            Captain = "Lorenzo",
            Display = "Zombie Defender",
            Track = "Steal",
            Goal = 20,
            Hourly = true,
            Reward = { {
                    Type = "StyleSpins",
                    Amount = 5
                } }
        }
    },
    QuestlineRewards = {
        REAL = {
            ChatTag = "REAL Tag",
            PlayerCard = "REAL",
            GoalEffect = "REAL"
        },
        ["Bastard Munchen"] = {
            ChatTag = "Munchen Tag",
            PlayerCard = "Munchen",
            GoalEffect = "Bas Munchen"
        },
        PXG = {
            ChatTag = "PXG Tag",
            PlayerCard = "P X G",
            GoalEffect = "PXG"
        },
        Arsenaly = {
            ChatTag = "Arsenaly Tag",
            PlayerCard = "Arsenaly",
            GoalEffect = "Arsenaly"
        },
        Manshine = {
            ChatTag = "Manshine Tag",
            PlayerCard = "Manshine",
            GoalEffect = "Manshine"
        },
        Barcha = {
            ChatTag = "Barcha Tag",
            PlayerCard = "Barcha",
            GoalEffect = "Barcha"
        },
        Ubers = {
            ChatTag = "Ubers Tag",
            PlayerCard = "Ubers",
            GoalEffect = "Ubers"
        }
    },
    MainQuests = { {
            Key = "true_egoist",
            Display = "True Egoist",
            Track = "AllQuestlines",
            Goal = 1,
            Repeatable = false,
            Reward = { {
                    Type = "GoalEffect",
                    Name = "Ego\'s Portal"
                } }
        }, {
            Key = "nel_champion",
            Display = "NEL Champion",
            Track = "Wins",
            Goal = 15,
            Repeatable = true,
            Reward = { {
                    Type = "LuckyStyleSpins",
                    Amount = 5
                } }
        }, {
            Key = "nel_legend",
            Display = "NEL Legend",
            Track = "MVP",
            Goal = 15,
            Repeatable = true,
            Reward = { {
                    Type = "LuckyFlowSpins",
                    Amount = 10
                } }
        }, {
            Key = "nel_prodigy",
            Display = "NEL Prodigy",
            Track = "WinStreak",
            Goal = 10,
            Repeatable = true,
            Reward = { {
                    Type = "LuckyStyleSpins",
                    Amount = 5
                }, {
                    Type = "LuckyFlowSpins",
                    Amount = 5
                } }
        } },
    AcademyStageAnimations = {
        REAL = {
            Character1 = "rbxassetid://99672717151378",
            Character2 = "rbxassetid://119601918141061"
        },
        ["Bastard Munchen"] = {
            Character1 = "rbxassetid://120665492486504",
            Character2 = "rbxassetid://92426367767707"
        },
        PXG = {
            Character1 = "rbxassetid://102862977203697",
            Character2 = "rbxassetid://120293152734591"
        },
        Arsenaly = {
            Character1 = "rbxassetid://113740862485261",
            Character2 = "rbxassetid://134510190537736"
        },
        Manshine = {
            Character1 = "rbxassetid://98298377711483",
            Character2 = "rbxassetid://95410995656661"
        },
        Barcha = {
            Character1 = "rbxassetid://104811029772699",
            Character2 = "rbxassetid://116231663649541"
        },
        Ubers = {
            Character1 = "rbxassetid://129521728538957",
            Character2 = "rbxassetid://87694487149155"
        }
    },
    AcademyCharacters = {
        REAL = {
            Character1 = "rin",
            Character2 = "sae"
        },
        ["Bastard Munchen"] = {
            Character1 = "Noel noa",
            Character2 = "kaiser"
        },
        PXG = {
            Character1 = "Loki",
            Character2 = "charles"
        },
        Arsenaly = {
            Character1 = "Hugo",
            Character2 = "Reo"
        },
        Manshine = {
            Character1 = "chris prince",
            Character2 = "chigiri"
        },
        Barcha = {
            Character1 = "lahvinho",
            Character2 = "Bunny"
        },
        Ubers = {
            Character1 = "snuffy",
            Character2 = "don lorenzo"
        }
    },
    AcademyAuras = {
        REAL = "real",
        ["Bastard Munchen"] = "munchenaura",
        PXG = "pxgaura",
        Arsenaly = "arsenalyaura",
        Manshine = "manshineaura",
        Barcha = "barchaaura",
        Ubers = "ubers"
    }
};