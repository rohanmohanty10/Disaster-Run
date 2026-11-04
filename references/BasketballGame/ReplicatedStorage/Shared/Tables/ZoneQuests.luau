 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
local SeasonPass = require(ReplicatedStorage.Shared.Tables.SeasonPass);

local function CreateTargetQuest(p1: string, u2: string, u3, p4: table, u5: boolean) -- Line: 19
    return {
        Description = p1,
        Rewards = p4,

        CanComplete = function(p6) -- Line: 31, Name: CanComplete
            -- upvalues: u2 (copy)
            return p6.Metadata[u2] >= p6.Metadata.Target;
        end,

        InitialMetadata = function() -- Line: 35, Name: InitialMetadata
            -- upvalues: u2 (copy), u3 (copy), u5 (copy)
            return {
                [u2] = 0,
                Index = u2,
                Target = u3,
                OneMatch = u5
            };
        end
    };
end;

return {
    Dribbling = { CreateTargetQuest("Dribble 200 times!", "Dribble", 200, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }), CreateTargetQuest("Break 75 Ankles in total!", "AnkleBreaks", 75, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }), CreateTargetQuest("Break 7 Ankles in a match!", "AnkleBreaks", 7, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 2
            }
        }, true) },
    Shooting = {
        CreateTargetQuest("Score 25 Layups!", "Layup", 25, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }),
        CreateTargetQuest("Score 50 Three Pointers!", "3Pointers", 50, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }),
        CreateTargetQuest("Score 350 Points in total!", "Points", 350, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "ZoneLuckySpins",
                Name = "Lucky Zone Spins",
                Value = 1
            }
        }),
        CreateTargetQuest("Score 15 Points in a Match!", "Points", 15, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 1
            }
        }, true),
        CreateTargetQuest("Score 5 Half-Court Shots!", "Half-Court", 5, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 2
            }
        })
    },
    Dunking = {
        [1] = CreateTargetQuest("Score 25 Dunks in total!", "Dunks", 25, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }),
        [2] = CreateTargetQuest("Score 150 Dunks in total!", "Dunks", 150, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "ZoneLuckySpins",
                Name = "Lucky Zone Spins",
                Value = 1
            }
        }),
        [3] = CreateTargetQuest("Score 10 Dunks in a Match!", "Dunks", 10, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 1
            }
        }, true),
        [5] = CreateTargetQuest("Assist 10 Dunks!", "DunkAssist", 10, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 2
            }
        })
    },
    Defense = {
        CreateTargetQuest("Block 75 Shots in total!", "Blocks", 75, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }),
        CreateTargetQuest("Steal 50 times in total!", "Steal", 50, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }),
        CreateTargetQuest("Steal 7 times in a Match!", "Steal", 7, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "ZoneLuckySpins",
                Name = "Lucky Zone Spins",
                Value = 1
            }
        }, true),
        CreateTargetQuest("Block 5 times in a Match!", "Blocks", 5, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 1
            }
        }),
        CreateTargetQuest("Collect 5 Rebounds!", "Rebound", 5, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 2
            }
        })
    },
    Offense = {
        CreateTargetQuest("Score 500 Points in total!", "Points", 500, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            }
        }),
        CreateTargetQuest("Pass 100 Times to Teammates!", "Pass", 100, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "ZoneLuckySpins",
                Name = "Lucky Zone Spins",
                Value = 1
            }
        }),
        CreateTargetQuest("Assist Teammates 75 times!", "Assists", 75, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 1
            }
        }),
        CreateTargetQuest("Score 20 Points in a Match!", "Points", 20, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 2
            }
        }, true),
        CreateTargetQuest("Get MVP 5 times!", "MVP", 5, {
            {
                DataIndex = "Money",
                Value = 10000
            },
            {
                DataIndex = "SeasonPass Currency",
                Value = 50,
                Name = SeasonPass.Items.Currency.DisplayName
            },
            {
                DataIndex = "LuckySpins",
                Name = "Lucky Style Spins",
                Value = 50
            }
        })
    }
};