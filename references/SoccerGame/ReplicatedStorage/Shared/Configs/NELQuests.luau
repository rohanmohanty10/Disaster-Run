  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.FormatNumber);

return {
    King = require(script.King),
    Aiku = require(script.Aiku),
    Bachira = {
        NELName = "NEL Bachira",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://97721994477052",
        RewardLine = { {
                XP = 20,
                Display = "Heel Center"
            }, {
                XP = 40,
                Display = "The Butterfly"
            }, {
                XP = 60,
                Display = "Roulette"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            bachira_quest_opt1 = {
                Display = "10x Ankle Breakers (Bachira)",
                StyleRequired = "Bachira",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            bachira_quest_opt2 = {
                Display = "10x Goals (Bachira)",
                StyleRequired = "Bachira",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            bachira_quest_opt10 = {
                Display = "10x Awakened Goals (Bachira)",
                StyleRequired = "Bachira",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            bachira_quest_opt3 = {
                Display = "8x Assists (Bachira)",
                StyleRequired = "Bachira",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            bachira_quest_opt4 = {
                Display = "5x Awakenings (Bachira)",
                StyleRequired = "Bachira",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            bachira_quest_opt5 = {
                Display = "x4 Overtime Goals (Bachira)",
                StyleRequired = "Bachira",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            bachira_quest_opt6 = {
                Display = "x10 Wins (Bachira)",
                StyleRequired = "Bachira",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            bachira_quest_opt7 = {
                Display = "Playtime (Bachira)",
                StyleRequired = "Bachira",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p1) -- Line: 67, Name: format
                    return `{p1 // 60}m`;
                end
            },
            bachira_quest_opt8 = {
                Display = "x3 Hatricks (Bachira)",
                StyleRequired = "Bachira",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    },
    Rin = {
        NELName = "NEL Rin",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://95714099001891",
        RewardLine = { {
                XP = 20,
                Display = "Annihilate"
            }, {
                XP = 40,
                Display = "Occlusion Break"
            }, {
                XP = 60,
                Display = "Destroyer Mode"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            rin_quest_opt1 = {
                Display = "10x Ankle Breakers (Rin)",
                StyleRequired = "Rin",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            rin_quest_opt2 = {
                Display = "10x Goals (Rin)",
                StyleRequired = "Rin",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            rin_quest_opt10 = {
                Display = "10x Awakened Goals (Rin)",
                StyleRequired = "Rin",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            rin_quest_opt3 = {
                Display = "8x Assists (Rin)",
                StyleRequired = "Rin",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            rin_quest_opt4 = {
                Display = "5x Awakenings (Rin)",
                StyleRequired = "Rin",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            rin_quest_opt5 = {
                Display = "x4 Overtime Goals (Rin)",
                StyleRequired = "Rin",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            rin_quest_opt6 = {
                Display = "x10 Wins (Rin)",
                StyleRequired = "Rin",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            rin_quest_opt7 = {
                Display = "Playtime (Rin)",
                StyleRequired = "Rin",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p2) -- Line: 137, Name: format
                    return `{p2 // 60}m`;
                end
            },
            rin_quest_opt8 = {
                Display = "x3 Hatricks (Rin)",
                StyleRequired = "Rin",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    },
    Isagi = {
        NELName = "NEL Isagi",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://135962763518164",
        RewardLine = { {
                XP = 20,
                Display = "Direct Shot"
            }, {
                XP = 40,
                Display = "Meta-Burst Point"
            }, {
                XP = 60,
                Display = "Side Step Dribble"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            isagi_quest_opt1 = {
                Display = "10x Ankle Breakers (Isagi)",
                StyleRequired = "Isagi",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            isagi_quest_opt2 = {
                Display = "10x Goals (Isagi)",
                StyleRequired = "Isagi",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            isagi_quest_opt10 = {
                Display = "10x Awakened Goals (Isagi)",
                StyleRequired = "Isagi",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            isagi_quest_opt3 = {
                Display = "8x Assists (Isagi)",
                StyleRequired = "Isagi",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            isagi_quest_opt4 = {
                Display = "5x Awakenings (Isagi)",
                StyleRequired = "Isagi",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            isagi_quest_opt5 = {
                Display = "x4 Overtime Goals (Isagi)",
                StyleRequired = "Isagi",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            isagi_quest_opt6 = {
                Display = "x10 Wins (Isagi)",
                StyleRequired = "Isagi",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            isagi_quest_opt7 = {
                Display = "Playtime (Isagi)",
                StyleRequired = "Isagi",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p3) -- Line: 207, Name: format
                    return `{p3 // 60}m`;
                end
            },
            isagi_quest_opt8 = {
                Display = "x3 Hatricks (Isagi)",
                StyleRequired = "Isagi",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    },
    Nagi = {
        NELName = "NEL Nagi",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://132221246687326",
        RewardLine = { {
                XP = 20,
                Display = "Skull Trap"
            }, {
                XP = 40,
                Display = "Zero Reset Turn"
            }, {
                XP = 60,
                Display = "Direct Heel Lift"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            nagi_quest_opt1 = {
                Display = "10x Ankle Breakers (Nagi)",
                StyleRequired = "Nagi",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            nagi_quest_opt2 = {
                Display = "10x Goals (Nagi)",
                StyleRequired = "Nagi",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            nagi_quest_opt10 = {
                Display = "10x Awakened Goals (Nagi)",
                StyleRequired = "Nagi",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            nagi_quest_opt3 = {
                Display = "8x Assists (Nagi)",
                StyleRequired = "Nagi",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            nagi_quest_opt4 = {
                Display = "5x Awakenings (Nagi)",
                StyleRequired = "Nagi",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            nagi_quest_opt5 = {
                Display = "x4 Overtime Goals (Nagi)",
                StyleRequired = "Nagi",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            nagi_quest_opt6 = {
                Display = "x10 Wins (Nagi)",
                StyleRequired = "Nagi",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            nagi_quest_opt7 = {
                Display = "Playtime (Nagi)",
                StyleRequired = "Nagi",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p4) -- Line: 277, Name: format
                    return `{p4 // 60}m`;
                end
            },
            nagi_quest_opt8 = {
                Display = "x3 Hatricks (Nagi)",
                StyleRequired = "Nagi",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    },
    Chigiri = {
        NELName = "NEL Chigiri",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://86751497562079",
        RewardLine = { {
                XP = 20,
                Display = "High-speed Speedster"
            }, {
                XP = 40,
                Display = "Panther Illusion"
            }, {
                XP = 60,
                Display = "No-Break Dribble"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            chigiri_quest_opt1 = {
                Display = "10x Ankle Breakers (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            chigiri_quest_opt2 = {
                Display = "10x Goals (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            chigiri_quest_opt10 = {
                Display = "10x Awakened Goals (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            chigiri_quest_opt3 = {
                Display = "8x Assists (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            chigiri_quest_opt4 = {
                Display = "5x Awakenings (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            chigiri_quest_opt5 = {
                Display = "x4 Overtime Goals (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            chigiri_quest_opt6 = {
                Display = "x10 Wins (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            chigiri_quest_opt7 = {
                Display = "Playtime (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p5) -- Line: 347, Name: format
                    return `{p5 // 60}m`;
                end
            },
            chigiri_quest_opt8 = {
                Display = "x3 Hatricks (Chigiri)",
                StyleRequired = "Chigiri",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    },
    Reo = {
        NELName = "NEL Reo",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://79294072268907",
        RewardLine = { {
                XP = 20,
                Display = "Oppressive Pass"
            }, {
                XP = 40,
                Display = "Chameleon Defense"
            }, {
                XP = 60,
                Display = "Trivela"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            reo_quest_opt1 = {
                Display = "10x Ankle Breakers (Reo)",
                StyleRequired = "Reo",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            reo_quest_opt2 = {
                Display = "10x Goals (Reo)",
                StyleRequired = "Reo",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            reo_quest_opt10 = {
                Display = "10x Awakened Goals (Reo)",
                StyleRequired = "Reo",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            reo_quest_opt3 = {
                Display = "8x Assists (Reo)",
                StyleRequired = "Reo",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            reo_quest_opt4 = {
                Display = "5x Awakenings (Reo)",
                StyleRequired = "Reo",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            reo_quest_opt5 = {
                Display = "x4 Overtime Goals (Reo)",
                StyleRequired = "Reo",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            reo_quest_opt6 = {
                Display = "x10 Wins (Reo)",
                StyleRequired = "Reo",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            reo_quest_opt7 = {
                Display = "Playtime (Reo)",
                StyleRequired = "Reo",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p6) -- Line: 417, Name: format
                    return `{p6 // 60}m`;
                end
            },
            reo_quest_opt8 = {
                Display = "x3 Hatricks (Reo)",
                StyleRequired = "Reo",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    },
    Shidou = {
        NELName = "NEL Shidou",
        NELRarity = "World Class",
        ChibiImage = "rbxassetid://134581375308838",
        RewardLine = { {
                XP = 20,
                Display = "Dragonic Volley"
            }, {
                XP = 40,
                Display = "Demonic Rush"
            }, {
                XP = 60,
                Display = "Demon Shot"
            }, {
                XP = 100,
                Display = "Awakening"
            } },
        Quests = {
            shidou_quest_opt1 = {
                Display = "10x Ankle Breakers (Shidou)",
                StyleRequired = "Shidou",
                XP = 10,
                internal = {
                    type = "Ankle",
                    goal = 10
                }
            },
            shidou_quest_opt2 = {
                Display = "10x Goals (Shidou)",
                StyleRequired = "Shidou",
                XP = 10,
                internal = {
                    type = "Goal",
                    goal = 10
                }
            },
            shidou_quest_opt10 = {
                Display = "10x Awakened Goals (Shidou)",
                StyleRequired = "Shidou",
                XP = 15,
                internal = {
                    type = "AwakenGoals",
                    goal = 10
                }
            },
            shidou_quest_opt3 = {
                Display = "8x Assists (Shidou)",
                StyleRequired = "Shidou",
                XP = 10,
                internal = {
                    type = "Assist",
                    goal = 8
                }
            },
            shidou_quest_opt4 = {
                Display = "5x Awakenings (Shidou)",
                StyleRequired = "Shidou",
                XP = 20,
                internal = {
                    type = "Awaken",
                    goal = 5
                }
            },
            shidou_quest_opt5 = {
                Display = "x4 Overtime Goals (Shidou)",
                StyleRequired = "Shidou",
                XP = 20,
                internal = {
                    type = "OvertimeGoal",
                    goal = 4
                }
            },
            shidou_quest_opt6 = {
                Display = "x10 Wins (Shidou)",
                StyleRequired = "Shidou",
                XP = 25,
                internal = {
                    type = "Wins",
                    goal = 10
                }
            },
            shidou_quest_opt7 = {
                Display = "Playtime (Shidou)",
                StyleRequired = "Shidou",
                XP = 25,
                internal = {
                    type = "MatchPlaytime",
                    goal = 3600
                },

                format = function(p7) -- Line: 487, Name: format
                    return `{p7 // 60}m`;
                end
            },
            shidou_quest_opt8 = {
                Display = "x3 Hatricks (Shidou)",
                StyleRequired = "Shidou",
                XP = 30,
                internal = {
                    type = "Hatrick",
                    goal = 3
                }
            }
        }
    }
};