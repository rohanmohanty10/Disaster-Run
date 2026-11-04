  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Essentials);

return {
    AbbreviationToNormal = {
        LS = "LuckySpins",
        Flow = "FlowSpins",
        Spins = "Spins",
        FL = "LuckyFlowSpins",
        Snow = "EventCurrency"
    },
    ToUI = {
        LS = "Lucky Spins",
        Flow = "Flow Spins",
        Spins = "Spins",
        FL = "Lucky Flow Spins",
        Emotes = "Emotes",
        GoalEffects = "Goal Effect",
        Cards = "Card",
        Snow = "Snowflakes",
        Cosmetics = "Cosmetic",
        None = "None"
    },
    InventoryItems = { "Emotes", "GoalEffects", "Cards", "Cosmetics" },
    Icons = {
        LS = "rbxassetid://125339871021518",
        Spins = "rbxassetid://125339871021518",
        Flow = "rbxassetid://133558083095603",
        FL = "rbxassetid://133558083095603",
        Snow = "rbxassetid://109206154581451",
        Emotes = "rbxassetid://133558083095603",
        GoalEffects = "rbxassetid://133558083095603",
        Cards = "rbxassetid://109206154581451",
        None = "rbxassetid://71873528065567",
        Cosmetics = "rbxassetid://109707434209411"
    },
    Tiers = {
        Tier1 = {
            Index = 1,
            Free = {
                Value = 50,
                Reward = "Snow"
            },
            Premium = {
                Value = 100,
                Reward = "Snow"
            }
        },
        Tier2 = {
            Index = 2,
            Free = {
                Value = 55,
                Reward = "Snow"
            },
            Premium = {
                Value = 100,
                Reward = "Snow"
            }
        },
        Tier3 = {
            Index = 3,
            Free = {
                Value = nil,
                Reward = "None"
            },
            Premium = {
                Value = 2,
                Reward = "LS"
            }
        },
        Tier4 = {
            Index = 4,
            Free = {
                Value = "Confused",
                Reward = "Emotes"
            },
            Premium = {
                Value = 105,
                Reward = "Snow"
            }
        },
        Tier5 = {
            Index = 5,
            Free = {
                Value = "Wood",
                Reward = "Cards"
            },
            Premium = {
                Value = "Santa Laugh",
                Reward = "Emotes"
            }
        },
        Tier6 = {
            Index = 6,
            Free = {
                Value = 60,
                Reward = "Snow"
            },
            Premium = {
                Value = 105,
                Reward = "Snow"
            }
        },
        Tier7 = {
            Index = 7,
            Free = {
                Value = 60,
                Reward = "Snow"
            },
            Premium = {
                Value = "Snowflakes",
                Reward = "GoalEffects"
            }
        },
        Tier8 = {
            Index = 8,
            Free = {
                Value = 65,
                Reward = "Snow"
            },
            Premium = {
                Value = 110,
                Reward = "Snow"
            }
        },
        Tier9 = {
            Index = 9,
            Free = {
                Value = 1,
                Reward = "FL"
            },
            Premium = {
                Value = 115,
                Reward = "Snow"
            }
        },
        Tier10 = {
            Index = 10,
            Free = {
                Value = nil,
                Reward = "None"
            },
            Premium = {
                Value = 120,
                Reward = "Snow"
            }
        },
        Tier11 = {
            Index = 11,
            Free = {
                Value = 65,
                Reward = "Snow"
            },
            Premium = {
                Value = "Holiday",
                Reward = "Cards"
            }
        },
        Tier12 = {
            Index = 12,
            Free = {
                Value = "Helicopter",
                Reward = "Emotes"
            },
            Premium = {
                Value = 125,
                Reward = "Snow"
            }
        },
        Tier13 = {
            Index = 13,
            Free = {
                Value = nil,
                Reward = "None"
            },
            Premium = {
                Value = 130,
                Reward = "Snow"
            }
        },
        Tier14 = {
            Index = 14,
            Free = {
                Value = 70,
                Reward = "Snow"
            },
            Premium = {
                Value = 135,
                Reward = "Snow"
            }
        },
        Tier15 = {
            Index = 15,
            Free = {
                Value = 70,
                Reward = "Snow"
            },
            Premium = {
                Value = 135,
                Reward = "Snow"
            }
        },
        Tier16 = {
            Index = 16,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = "Moves",
                Reward = "Emotes"
            }
        },
        Tier17 = {
            Index = 17,
            Free = {
                Value = "Defender",
                Reward = "GoalEffects"
            },
            Premium = {
                Value = 135,
                Reward = "Snow"
            }
        },
        Tier18 = {
            Index = 18,
            Free = {
                Value = nil,
                Reward = "None"
            },
            Premium = {
                Value = 140,
                Reward = "Snow"
            }
        },
        Tier19 = {
            Index = 19,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = 145,
                Reward = "Snow"
            }
        },
        Tier20 = {
            Index = 20,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = 150,
                Reward = "Snow"
            }
        },
        Tier21 = {
            Index = 21,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = 155,
                Reward = "Snow"
            }
        },
        Tier22 = {
            Index = 22,
            Free = {
                Value = nil,
                Reward = "None"
            },
            Premium = {
                Value = 160,
                Reward = "Snow"
            }
        },
        Tier23 = {
            Index = 23,
            Free = {
                Value = 80,
                Reward = "Snow"
            },
            Premium = {
                Value = 160,
                Reward = "Snow"
            }
        },
        Tier24 = {
            Index = 24,
            Free = {
                Value = "Forest",
                Reward = "Cards"
            },
            Premium = {
                Value = 165,
                Reward = "Snow"
            }
        },
        Tier25 = {
            Index = 25,
            Free = {
                Value = 80,
                Reward = "Snow"
            },
            Premium = {
                Value = 165,
                Reward = "Snow"
            }
        },
        Tier26 = {
            Index = 26,
            Free = {
                Value = nil,
                Reward = "None"
            },
            Premium = {
                Value = 170,
                Reward = "Snow"
            }
        },
        Tier27 = {
            Index = 27,
            Free = {
                Value = 85,
                Reward = "Snow"
            },
            Premium = {
                Value = 170,
                Reward = "Snow"
            }
        },
        Tier28 = {
            Index = 28,
            Free = {
                Value = 90,
                Reward = "Snow"
            },
            Premium = {
                Value = "Presents",
                Reward = "GoalEffects"
            }
        },
        Tier29 = {
            Index = 29,
            Free = {
                Value = 100,
                Reward = "Snow"
            },
            Premium = {
                Value = "Steps",
                Reward = "Emotes"
            }
        },
        Tier30 = {
            Index = 30,
            Free = {
                Value = "Santa Scarf",
                Reward = "Cosmetics"
            },
            Premium = {
                Value = "Gingerbread Cape",
                Reward = "Cosmetics"
            }
        }
    },
    Rebirth = {
        Tier1 = {
            Index = 1,
            Free = {
                Value = 50,
                Reward = "Snow"
            },
            Premium = {
                Value = 100,
                Reward = "Snow"
            }
        },
        Tier2 = {
            Index = 2,
            Free = {
                Value = 55,
                Reward = "Snow"
            },
            Premium = {
                Value = 100,
                Reward = "Snow"
            }
        },
        Tier3 = {
            Index = 3,
            Free = {
                Value = 60,
                Reward = "Snow"
            },
            Premium = {
                Value = 105,
                Reward = "Snow"
            }
        },
        Tier4 = {
            Index = 4,
            Free = {
                Value = 60,
                Reward = "Snow"
            },
            Premium = {
                Value = 110,
                Reward = "Snow"
            }
        },
        Tier5 = {
            Index = 5,
            Free = {
                Value = 60,
                Reward = "Snow"
            },
            Premium = {
                Value = 115,
                Reward = "Snow"
            }
        },
        Tier6 = {
            Index = 6,
            Free = {
                Value = 65,
                Reward = "Snow"
            },
            Premium = {
                Value = 120,
                Reward = "Snow"
            }
        },
        Tier7 = {
            Index = 7,
            Free = {
                Value = 65,
                Reward = "Snow"
            },
            Premium = {
                Value = 125,
                Reward = "Snow"
            }
        },
        Tier8 = {
            Index = 8,
            Free = {
                Value = 65,
                Reward = "Snow"
            },
            Premium = {
                Value = 130,
                Reward = "Snow"
            }
        },
        Tier9 = {
            Index = 9,
            Free = {
                Value = 65,
                Reward = "Snow"
            },
            Premium = {
                Value = 135,
                Reward = "Snow"
            }
        },
        Tier10 = {
            Index = 10,
            Free = {
                Value = 70,
                Reward = "Snow"
            },
            Premium = {
                Value = 135,
                Reward = "Snow"
            }
        },
        Tier11 = {
            Index = 11,
            Free = {
                Value = 70,
                Reward = "Snow"
            },
            Premium = {
                Value = 140,
                Reward = "Snow"
            }
        },
        Tier12 = {
            Index = 12,
            Free = {
                Value = 70,
                Reward = "Snow"
            },
            Premium = {
                Value = 145,
                Reward = "Snow"
            }
        },
        Tier13 = {
            Index = 13,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = 150,
                Reward = "Snow"
            }
        },
        Tier14 = {
            Index = 14,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = 155,
                Reward = "Snow"
            }
        },
        Tier15 = {
            Index = 15,
            Free = {
                Value = 75,
                Reward = "Snow"
            },
            Premium = {
                Value = 160,
                Reward = "Snow"
            }
        },
        Tier16 = {
            Index = 16,
            Free = {
                Value = 80,
                Reward = "Snow"
            },
            Premium = {
                Value = 165,
                Reward = "Snow"
            }
        },
        Tier17 = {
            Index = 17,
            Free = {
                Value = 80,
                Reward = "Snow"
            },
            Premium = {
                Value = 170,
                Reward = "Snow"
            }
        },
        Tier18 = {
            Index = 18,
            Free = {
                Value = 80,
                Reward = "Snow"
            },
            Premium = {
                Value = 170,
                Reward = "Snow"
            }
        },
        Tier19 = {
            Index = 19,
            Free = {
                Value = 85,
                Reward = "Snow"
            },
            Premium = {
                Value = 175,
                Reward = "Snow"
            }
        },
        Tier20 = {
            Index = 20,
            Free = {
                Value = 85,
                Reward = "Snow"
            },
            Premium = {
                Value = 180,
                Reward = "Snow"
            }
        },
        Tier21 = {
            Index = 21,
            Free = {
                Value = 90,
                Reward = "Snow"
            },
            Premium = {
                Value = 185,
                Reward = "Snow"
            }
        },
        Tier22 = {
            Index = 22,
            Free = {
                Value = 95,
                Reward = "Snow"
            },
            Premium = {
                Value = 190,
                Reward = "Snow"
            }
        },
        Tier23 = {
            Index = 23,
            Free = {
                Value = 100,
                Reward = "Snow"
            },
            Premium = {
                Value = 195,
                Reward = "Snow"
            }
        },
        Tier24 = {
            Index = 24,
            Free = {
                Value = 110,
                Reward = "Snow"
            },
            Premium = {
                Value = 200,
                Reward = "Snow"
            }
        },
        Tier25 = {
            Index = 25,
            Free = {
                Value = 110,
                Reward = "Snow"
            },
            Premium = {
                Value = 205,
                Reward = "Snow"
            }
        },
        Tier26 = {
            Index = 26,
            Free = {
                Value = 110,
                Reward = "Snow"
            },
            Premium = {
                Value = 210,
                Reward = "Snow"
            }
        },
        Tier27 = {
            Index = 27,
            Free = {
                Value = 115,
                Reward = "Snow"
            },
            Premium = {
                Value = 215,
                Reward = "Snow"
            }
        },
        Tier28 = {
            Index = 28,
            Free = {
                Value = 115,
                Reward = "Snow"
            },
            Premium = {
                Value = 220,
                Reward = "Snow"
            }
        },
        Tier29 = {
            Index = 29,
            Free = {
                Value = 120,
                Reward = "Snow"
            },
            Premium = {
                Value = 225,
                Reward = "Snow"
            }
        },
        Tier30 = {
            Index = 30,
            Free = {
                Value = 120,
                Reward = "Snow"
            },
            Premium = {
                Value = 230,
                Reward = "Snow"
            }
        }
    }
};