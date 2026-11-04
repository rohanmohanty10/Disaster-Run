  

return {
    Positions = { "Attacker", "Midfielder", "Defender", "Goalkeeper" },
    PositionQuestLabels = {
        Attacker = "Striker",
        Midfielder = "Midfielder",
        Defender = "Defender",
        Goalkeeper = "Goalkeeper"
    },
    RankOrder = { "Bench", "Starter", "WorldClassTalent", "TeamEmperor" },
    RankDisplay = {
        Bench = "Bench",
        Starter = "Starter",
        WorldClassTalent = "World Class Talent",
        TeamEmperor = "Team Emperor"
    },
    RankRequirements = {
        Bench = {},
        Starter = {
            A = 2,
            B = 2
        },
        WorldClassTalent = {
            S = 1,
            A = 3
        },
        TeamEmperor = {
            S = 3,
            A = 2
        }
    },
    TierCounted = { "S", "A", "B" },
    WinsPerLuckySpin = 5,
    SeasonEndRewards = {
        Bench = {
            LuckySpins = 0,
            Yen = 0
        },
        Starter = {
            LuckySpins = 1,
            Yen = 25000000
        },
        WorldClassTalent = {
            LuckySpins = 2,
            Yen = 75000000
        },
        TeamEmperor = {
            LuckySpins = 3,
            Yen = 150000000
        }
    },
    QuestSetOrder = { "Beginner", "Starter", "TrueTalent", "WorldClass" },
    QuestSetDisplay = {
        Beginner = "Beginner",
        Starter = "Starter",
        TrueTalent = "True Talent",
        WorldClass = "World Class"
    },
    SetCompletionsToAdvance = 1,
    QuestInfoText = "Resets Daily If Completed, Complete All 3 Quests To Unlock Next Set Of Quests\nSwapping Teams Makes You Restart Quests\nBigger Rewards Further You Advance",
    LadderQuests = {
        Goalkeeper = {
            Beginner = { {
                    Type = "MatchStat",
                    Display = "Get 3 Saves In A Match",
                    Req = {
                        Saves = 3
                    },
                    Reward = {
                        LuckyFlowSpins = 1
                    }
                }, {
                    Type = "Wins",
                    Goal = 3,
                    Display = "Win 3 Matches",
                    Reward = {
                        Yen = 2000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 1800,
                    Display = "Play For 30 Minutes",
                    Reward = {
                        LuckyFlowSpins = 1,
                        LuckyStyleSpins = 1
                    }
                } },
            Starter = { {
                    Type = "MatchStat",
                    Display = "Get 5 Saves In A Match",
                    Req = {
                        Saves = 5
                    },
                    Reward = {
                        LuckyFlowSpins = 2
                    }
                }, {
                    Type = "Wins",
                    Goal = 5,
                    Display = "Win 5 Matches",
                    Reward = {
                        Yen = 5000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 3600,
                    Display = "Play For 1 Hour",
                    Reward = {
                        LuckyFlowSpins = 2,
                        LuckyStyleSpins = 2
                    }
                } },
            TrueTalent = { {
                    Type = "MatchStat",
                    Display = "Get 7 Saves In A Match",
                    Req = {
                        Saves = 7
                    },
                    Reward = {
                        LuckyFlowSpins = 3
                    }
                }, {
                    Type = "Wins",
                    Goal = 8,
                    Display = "Win 8 Matches",
                    Reward = {
                        Yen = 7000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 3,
                        LuckyStyleSpins = 3
                    }
                } },
            WorldClass = { {
                    Type = "MatchStat",
                    Display = "Get 10 Saves In A Match",
                    Req = {
                        Saves = 10
                    },
                    Reward = {
                        LuckyFlowSpins = 4
                    }
                }, {
                    Type = "Wins",
                    Goal = 10,
                    Display = "Win 10 Matches",
                    Reward = {
                        Yen = 10000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 5,
                        LuckyStyleSpins = 5
                    }
                } }
        },
        Defender = {
            Beginner = { {
                    Type = "MatchStat",
                    Display = "Get 3 Steals In A Match",
                    Req = {
                        Steals = 3
                    },
                    Reward = {
                        LuckyFlowSpins = 1
                    }
                }, {
                    Type = "Wins",
                    Goal = 3,
                    Display = "Win 3 Matches",
                    Reward = {
                        Yen = 2000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 1800,
                    Display = "Play For 30 Minutes",
                    Reward = {
                        LuckyFlowSpins = 1,
                        LuckyStyleSpins = 1
                    }
                } },
            Starter = { {
                    Type = "MatchStat",
                    Display = "Get 5 Steals In A Match",
                    Req = {
                        Steals = 5
                    },
                    Reward = {
                        LuckyFlowSpins = 2
                    }
                }, {
                    Type = "Wins",
                    Goal = 4,
                    Display = "Win 4 Matches",
                    Reward = {
                        Yen = 5000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 3600,
                    Display = "Play For 1 Hour",
                    Reward = {
                        LuckyFlowSpins = 2,
                        LuckyStyleSpins = 2
                    }
                } },
            TrueTalent = { {
                    Type = "MatchStat",
                    Display = "Get 7 Steals In A Match",
                    Req = {
                        Steals = 7
                    },
                    Reward = {
                        LuckyFlowSpins = 3
                    }
                }, {
                    Type = "Wins",
                    Goal = 5,
                    Display = "Win 5 Matches",
                    Reward = {
                        Yen = 7000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 3,
                        LuckyStyleSpins = 3
                    }
                } },
            WorldClass = { {
                    Type = "MatchStat",
                    Display = "Get 10 Steals In A Match",
                    Req = {
                        Steals = 10
                    },
                    Reward = {
                        LuckyFlowSpins = 4
                    }
                }, {
                    Type = "Wins",
                    Goal = 10,
                    Display = "Win 10 Matches",
                    Reward = {
                        Yen = 10000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 5,
                        LuckyStyleSpins = 5
                    }
                } }
        },
        Midfielder = {
            Beginner = { {
                    Type = "MatchStat",
                    Display = "Get 1 G/A + 1 Ankle Break In A Match",
                    Req = {
                        GoalsAssists = 1,
                        AnkleBreakers = 1
                    },
                    Reward = {
                        LuckyFlowSpins = 1
                    }
                }, {
                    Type = "Wins",
                    Goal = 3,
                    Display = "Win 3 Matches",
                    Reward = {
                        Yen = 2000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 1800,
                    Display = "Play For 30 Minutes",
                    Reward = {
                        LuckyFlowSpins = 1,
                        LuckyStyleSpins = 1
                    }
                } },
            Starter = { {
                    Type = "MatchStat",
                    Display = "Get 1 G/A + 2 Ankle Breaks In A Match",
                    Req = {
                        GoalsAssists = 1,
                        AnkleBreakers = 2
                    },
                    Reward = {
                        LuckyFlowSpins = 2
                    }
                }, {
                    Type = "Wins",
                    Goal = 5,
                    Display = "Win 5 Matches",
                    Reward = {
                        Yen = 5000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 3600,
                    Display = "Play For 1 Hour",
                    Reward = {
                        LuckyFlowSpins = 2,
                        LuckyStyleSpins = 2
                    }
                } },
            TrueTalent = { {
                    Type = "MatchStat",
                    Display = "Get 2 G/A + 3 Ankle Breaks In A Match",
                    Req = {
                        GoalsAssists = 2,
                        AnkleBreakers = 3
                    },
                    Reward = {
                        LuckyFlowSpins = 3
                    }
                }, {
                    Type = "Wins",
                    Goal = 8,
                    Display = "Win 8 Matches",
                    Reward = {
                        Yen = 7000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 3,
                        LuckyStyleSpins = 3
                    }
                } },
            WorldClass = { {
                    Type = "MatchStat",
                    Display = "Get 3 G/A + 3 Ankle Breaks In A Match",
                    Req = {
                        GoalsAssists = 3,
                        AnkleBreakers = 3
                    },
                    Reward = {
                        LuckyFlowSpins = 4
                    }
                }, {
                    Type = "Wins",
                    Goal = 10,
                    Display = "Win 10 Matches",
                    Reward = {
                        Yen = 10000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 5,
                        LuckyStyleSpins = 5
                    }
                } }
        },
        Attacker = {
            Beginner = { {
                    Type = "MatchStat",
                    Display = "Get 2 Goals In A Match",
                    Req = {
                        Goals = 2
                    },
                    Reward = {
                        LuckyFlowSpins = 1
                    }
                }, {
                    Type = "Wins",
                    Goal = 3,
                    Display = "Win 3 Matches",
                    Reward = {
                        Yen = 2000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 1800,
                    Display = "Play For 30 Minutes",
                    Reward = {
                        LuckyFlowSpins = 1,
                        LuckyStyleSpins = 1
                    }
                } },
            Starter = { {
                    Type = "MatchStat",
                    Display = "Get 2 Goals + 1 Assist/Ankle Break In A Match",
                    Req = {
                        Goals = 2,
                        AssistsAnkles = 1
                    },
                    Reward = {
                        LuckyFlowSpins = 2
                    }
                }, {
                    Type = "Wins",
                    Goal = 5,
                    Display = "Win 5 Matches",
                    Reward = {
                        Yen = 5000
                    }
                }, {
                    Type = "Playtime",
                    Goal = 3600,
                    Display = "Play For 1 Hour",
                    Reward = {
                        LuckyFlowSpins = 2,
                        LuckyStyleSpins = 2
                    }
                } },
            TrueTalent = { {
                    Type = "MatchStat",
                    Display = "Get 3 Goals + 1 Assist/Ankle Break In A Match",
                    Req = {
                        Goals = 3,
                        AssistsAnkles = 1
                    },
                    Reward = {
                        LuckyFlowSpins = 3
                    }
                }, {
                    Type = "Wins",
                    Goal = 8,
                    Display = "Win 8 Matches",
                    Reward = {
                        Yen = 7000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 3,
                        LuckyStyleSpins = 3
                    }
                } },
            WorldClass = { {
                    Type = "MatchStat",
                    Display = "Get 4 Goals In A Match",
                    Req = {
                        Goals = 4
                    },
                    Reward = {
                        LuckyFlowSpins = 4
                    }
                }, {
                    Type = "Wins",
                    Goal = 10,
                    Display = "Win 10 Matches",
                    Reward = {
                        Yen = 10000
                    }
                }, {
                    Type = "DailyPlaytime",
                    Goal = 2,
                    DailySeconds = 3600,
                    Display = "Play 1 Hour A Day, 2 Days In A Row",
                    Reward = {
                        LuckyFlowSpins = 5,
                        LuckyStyleSpins = 5
                    }
                } }
        }
    }
};