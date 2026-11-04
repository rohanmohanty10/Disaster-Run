  

return {
    NELName = "NEL King",
    NELRarity = "World Class",
    ChibiImage = "rbxassetid://101635156094692",
    RewardLine = { {
            XP = 20,
            Display = "Lion Shot"
        }, {
            XP = 40,
            Display = "Chop Feint"
        }, {
            XP = 60,
            Display = "Twisted Path"
        }, {
            XP = 100,
            Display = "Awakening"
        } },
    Quests = {
        king_quest_opt1 = {
            Display = "10x Ankle Breakers (King)",
            StyleRequired = "King",
            XP = 10,
            internal = {
                type = "Ankle",
                goal = 10
            }
        },
        king_quest_opt2 = {
            Display = "10x Goals (King)",
            StyleRequired = "King",
            XP = 10,
            internal = {
                type = "Goal",
                goal = 10
            }
        },
        king_quest_opt10 = {
            Display = "10x Awakened Goals (King)",
            StyleRequired = "King",
            XP = 15,
            internal = {
                type = "AwakenGoals",
                goal = 10
            }
        },
        king_quest_opt3 = {
            Display = "8x Assists (King)",
            StyleRequired = "King",
            XP = 10,
            internal = {
                type = "Assist",
                goal = 8
            }
        },
        king_quest_opt4 = {
            Display = "5x Awakenings (King)",
            StyleRequired = "King",
            XP = 20,
            internal = {
                type = "Awaken",
                goal = 5
            }
        },
        king_quest_opt5 = {
            Display = "x4 Overtime Goals (King)",
            StyleRequired = "King",
            XP = 20,
            internal = {
                type = "OvertimeGoal",
                goal = 4
            }
        },
        king_quest_opt6 = {
            Display = "x10 Wins (King)",
            StyleRequired = "King",
            XP = 25,
            internal = {
                type = "Wins",
                goal = 10
            }
        },
        king_quest_opt7 = {
            Display = "Playtime (King)",
            StyleRequired = "King",
            XP = 25,
            internal = {
                type = "MatchPlaytime",
                goal = 3600
            },

            format = function(p1) -- Line: 59, Name: format
                return `{p1 // 60}m`;
            end
        },
        king_quest_opt8 = {
            Display = "x3 Hatricks (King)",
            StyleRequired = "King",
            XP = 30,
            internal = {
                type = "Hatrick",
                goal = 3
            }
        }
    }
};