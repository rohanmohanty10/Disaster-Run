  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);
require(ReplicatedStorage.Modules.Util);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local u1 = {
    Enabled = false,
    EVENT = "Christmas",
    RESET_TIME = 10800,
    QuestAmount = 3,
    CRATE_TYPES = {
        NORMAL = "Normal",
        ROBUX = "Robux"
    },
    Animations = {
        Normal = "rbxassetid://107295668198147",
        Robux = "rbxassetid://111406594384121",
        LimitedMiddleSpin = "rbxassetid://110588429125742"
    },
    Crates = {
        Normal = {
            {
                Chance = 51,
                Reward = nil,
                LimitedStock = nil,
                Amount = 1,
                Type = ItemType.EventSpin
            },
            {
                Chance = 41,
                Reward = nil,
                LimitedStock = nil,
                Amount = 100,
                Type = ItemType.EventTokens
            },
            {
                Chance = 6,
                Reward = "Yeti Mount",
                LimitedStock = nil,
                Amount = nil,
                Type = ItemType.Emote
            },
            {
                Chance = 1.995,
                Reward = "Lavinho Claus Aura",
                LimitedStock = nil,
                Amount = nil,
                Type = ItemType.Cosmetic
            },
            {
                Chance = 0.005,
                Reward = "Six Seven",
                LimitedStock = true,
                Amount = nil,
                Type = ItemType.Emote
            }
        },
        Robux = {
            {
                Chance = 34,
                Reward = nil,
                LimitedStock = nil,
                Amount = 1,
                Type = ItemType.EventSpin
            },
            {
                Chance = 39,
                Reward = nil,
                LimitedStock = nil,
                Amount = 100,
                Type = ItemType.EventTokens
            },
            {
                Chance = 20,
                Reward = "Lavinho Claus Aura",
                LimitedStock = nil,
                Amount = nil,
                Type = ItemType.Cosmetic
            },
            {
                Chance = 6.9,
                Reward = "Yeti Mount",
                LimitedStock = nil,
                Amount = nil,
                Type = ItemType.Emote
            },
            {
                Chance = 0.1,
                Reward = "Six Seven",
                LimitedStock = true,
                Amount = nil,
                Type = ItemType.Emote
            }
        }
    },
    RobuxCratePurchases = {
        PremiumPresent = {
            ID = 3483439130,
            Amount = 1
        },
        PremiumPresent2 = {
            ID = 3483439347,
            Amount = 3
        },
        PremiumPresent3 = {
            ID = 3483439491,
            Amount = 10
        }
    },
    Quests = {
        Match = {
            Display = "Play Matches [Y/X]",
            Goal = {
                Min = 5,
                Max = 25
            }
        },
        Goal = {
            Display = "Score Goals [Y/X]",
            Goal = {
                Min = 5,
                Max = 20
            }
        },
        Assist = {
            Display = "Get Assists [Y/X]",
            Goal = {
                Min = 5,
                Max = 20
            }
        },
        Ankle = {
            Display = "Break Ankles [Y/X]",
            Goal = {
                Min = 5,
                Max = 20
            }
        },
        Steal = {
            Display = "Steal Balls [Y/X]",
            Goal = {
                Min = 5,
                Max = 20
            }
        },
        Header = {
            Display = "Get Headers [Y/X]",
            Goal = {
                Min = 5,
                Max = 20
            }
        },
        Wins = {
            Display = "Win Games [Y/X]",
            Goal = {
                Min = 3,
                Max = 15
            }
        },
        Saves = {
            Display = "Save Goals [Y/X]",
            Goal = {
                Min = 5,
                Max = 25
            }
        },
        Hatrick = {
            Display = "Get Hatrick [Y/X]",
            Goal = {
                Min = 3,
                Max = 8
            }
        }
    }
};

function u1.GetRandomQuests(p2: number?) -- Line: 133
    -- upvalues: u1 (copy), TableUtil (copy)
    local v3 = {};
    local v4 = p2 or 1;

    for i, _ in u1.Quests do
        table.insert(v3, i);
    end;

    local v5 = TableUtil.Shuffle(TableUtil.Copy(v3));
    local v6 = {};

    for i = 1, u1.QuestAmount do
        local v7 = v5[i];
        local v8 = u1.Quests[v7];
        v6[v7] = {
            Progress = 0,
            Claimed = false,
            Goal = (typeof(v8.Goal) == "number" and v8.Goal or math.random(v8.Goal.Min, v8.Goal.Max)) * v4
        };
        local _ = i;
    end;

    return v6;
end;

return u1;