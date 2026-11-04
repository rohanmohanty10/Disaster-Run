  

return {
    NELName = "NEL Aiku",
    NELRarity = "World Class",
    ChibiImage = "rbxassetid://98796846045806",
    RewardLine = { {
            XP = 20,
            Display = "Snake Interception"
        }, {
            XP = 40,
            Display = "Snake Deflect"
        }, {
            XP = 60,
            Display = "Serpentine Radar"
        }, {
            XP = 100,
            Display = "Awakening"
        } },
    Quests = {
        aiku_quest_opt1 = {
            Display = "10x Ankle Breakers (Aiku)",
            StyleRequired = "Aiku",
            XP = 10,
            internal = {
                type = "Ankle",
                goal = 10
            }
        },
        aiku_quest_opt2 = {
            Display = "10x Goals (Aiku)",
            StyleRequired = "Aiku",
            XP = 10,
            internal = {
                type = "Goal",
                goal = 10
            }
        },
        aiku_quest_opt10 = {
            Display = "10x Awakened Goals (Aiku)",
            StyleRequired = "Aiku",
            XP = 15,
            internal = {
                type = "AwakenGoals",
                goal = 10
            }
        },
        aiku_quest_opt3 = {
            Display = "8x Assists (Aiku)",
            StyleRequired = "Aiku",
            XP = 10,
            internal = {
                type = "Assist",
                goal = 8
            }
        },
        aiku_quest_opt4 = {
            Display = "5x Awakenings (Aiku)",
            StyleRequired = "Aiku",
            XP = 20,
            internal = {
                type = "Awaken",
                goal = 5
            }
        },
        aiku_quest_opt5 = {
            Display = "x4 Overtime Goals (Aiku)",
            StyleRequired = "Aiku",
            XP = 20,
            internal = {
                type = "OvertimeGoal",
                goal = 4
            }
        },
        aiku_quest_opt6 = {
            Display = "x10 Wins (Aiku)",
            StyleRequired = "Aiku",
            XP = 25,
            internal = {
                type = "Wins",
                goal = 10
            }
        },
        aiku_quest_opt7 = {
            Display = "Playtime (Aiku)",
            StyleRequired = "Aiku",
            XP = 25,
            internal = {
                type = "MatchPlaytime",
                goal = 3600
            },

            format = function(p1) -- Line: 59, Name: format
                return `{p1 // 60}m`;
            end
        },
        aiku_quest_opt8 = {
            Display = "x3 Hatricks (Aiku)",
            StyleRequired = "Aiku",
            XP = 30,
            internal = {
                type = "Hatrick",
                goal = 3
            }
        }
    }
};