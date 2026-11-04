  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);
local u1 = {
    QuestAmount = 4,
    XpPerQuest = 100,
    QuestResetTime = 86400
};
u1.Quests = {
    Goal = {
        Display = "Score X Goals",
        Goal = {
            Min = 5,
            Max = 15
        },
        XP = u1.XpPerQuest
    },
    AwakenGoals = {
        Display = "Score X Awakened Goals",
        Goal = {
            Min = 3,
            Max = 8
        },
        XP = u1.XpPerQuest
    },
    Assist = {
        Display = "Get X Assists",
        Goal = {
            Min = 5,
            Max = 15
        },
        XP = u1.XpPerQuest
    },
    Awaken = {
        Display = "Awaken X Times",
        Goal = {
            Min = 3,
            Max = 10
        },
        XP = u1.XpPerQuest
    },
    OvertimeGoal = {
        Display = "Score X Overtime Goals",
        Goal = {
            Min = 1,
            Max = 5
        },
        XP = u1.XpPerQuest
    },
    Wins = {
        Display = "Win X Matches",
        Goal = {
            Min = 3,
            Max = 10
        },
        XP = u1.XpPerQuest
    },
    Playtime = {
        Display = "Play for X",
        Goal = { 1200, 1800, 2700, 3600 },
        XP = u1.XpPerQuest
    },
    Match = {
        Display = "Play X Matches",
        Goal = {
            Min = 3,
            Max = 10
        },
        XP = u1.XpPerQuest
    }
};
u1.Rewards = {
    {
        XPRequired = 100,
        Reward = 5,
        Display = "5x Lucky Spins",
        Image = "rbxassetid://125339871021518",
        RewardType = ItemType.LuckyStyleSpins
    },
    {
        XPRequired = 250,
        Reward = "Wildcard",
        Display = "Wildcard Card",
        Image = "rbxassetid://129365398973883",
        RewardType = ItemType.PlayerCard
    },
    {
        XPRequired = 1000,
        Reward = "Ego Head Chibi",
        Display = "Ego Head Chibi",
        Image = "rbxassetid://105214115131077",
        RewardType = ItemType.Cosmetic
    },
    {
        XPRequired = 2500,
        Reward = 10,
        Display = "10x Lucky Spins",
        Image = "rbxassetid://125339871021518",
        RewardType = ItemType.LuckyStyleSpins
    },
    {
        XPRequired = 10000,
        Reward = "Blue Lightning Aura",
        Display = "Blue Lightning Aura",
        Image = "rbxassetid://82245763681162",
        RewardType = ItemType.Cosmetic
    }
};

function u1.GetRandomQuests() -- Line: 32
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