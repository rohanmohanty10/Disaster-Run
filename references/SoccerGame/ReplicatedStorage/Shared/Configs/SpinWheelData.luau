  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local u1 = {
    WheelName = "IsagiWheel",
    SpinCost = 1,
    Rewards = {
        {
            { ItemType.StyleSpins, 10 },
            29
        },
        {
            { ItemType.BallSkin, "Metavision Eye" },
            5
        },
        {
            { ItemType.Cash, 5000 },
            13.5
        },
        {
            { ItemType.LuckyStyleSpins, 10 },
            10
        },
        {
            { ItemType.Cosmetic, "Blue Skull Aura" },
            1
        },
        {
            { ItemType.LuckyStyleSpins, 3 },
            40
        }
    },
    QuestAmount = 4,
    TokensPerQuest = 1,
    QuestResetTime = 86400,
    Quests = {
        Goal = {
            Display = "Score X Goals",
            Goal = {
                Min = 5,
                Max = 15
            }
        },
        AwakenGoals = {
            Display = "Score X Awakened Goals",
            Goal = {
                Min = 3,
                Max = 8
            }
        },
        Assist = {
            Display = "Get X Assists",
            Goal = {
                Min = 5,
                Max = 15
            }
        },
        Awaken = {
            Display = "Awaken X Times",
            Goal = {
                Min = 3,
                Max = 10
            }
        },
        OvertimeGoal = {
            Display = "Score X Overtime Goals",
            Goal = {
                Min = 1,
                Max = 5
            }
        },
        Wins = {
            Display = "Win X Matches",
            Goal = {
                Min = 3,
                Max = 10
            }
        },
        Playtime = {
            Display = "Play for X",
            Goal = { 1200, 1800, 2700, 3600 }
        },
        Match = {
            Display = "Play X Matches",
            Goal = {
                Min = 3,
                Max = 10
            }
        }
    }
};

function u1.GetRandomQuests() -- Line: 36
    -- upvalues: u1 (copy), TableUtil (copy)
    local v2 = {};

    for i, _ in u1.Quests do
        table.insert(v2, i);
    end;

    local v3 = TableUtil.Shuffle(TableUtil.Copy(v2));
    local v4 = {};

    for i = 1, u1.QuestAmount do
        local v5 = v3[i];
        local v6 = u1.Quests[v5];
        local v7;

        if typeof(v6.Goal) == "number" then
            v7 = v6.Goal;
        elseif v6.Goal.Min then
            v7 = math.random(v6.Goal.Min, v6.Goal.Max);
        else
            v7 = v6.Goal[math.random(1, #v6.Goal)];
        end;

        v4[v5] = {
            Progress = 0,
            Claimed = false,
            Goal = v7
        };
        local _ = i;
    end;

    return v4;
end;

return u1;