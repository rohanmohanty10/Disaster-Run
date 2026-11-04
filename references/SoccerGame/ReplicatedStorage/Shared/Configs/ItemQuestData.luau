  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Util);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local u1 = {
    Enabled = false,
    EVENT = "New years",
    ITEM_REWARD = "2026 Egoist Aura",
    ITEM_REWARD_TYPE = require(ReplicatedStorage.Shared.Configs.ItemType).Cosmetic,
    QuestColours = {
        Red = {
            BG = Color3.fromRGB(246, 13, 51),
            Outline = Color3.fromRGB(248, 120, 141)
        },
        Blue = {
            BG = Color3.fromRGB(22, 112, 246),
            Outline = Color3.fromRGB(120, 176, 246)
        },
        Yellow = {
            BG = Color3.fromRGB(246, 213, 23),
            Outline = Color3.fromRGB(245, 248, 189)
        },
        Green = {
            BG = Color3.fromRGB(85, 216, 37),
            Outline = Color3.fromRGB(199, 248, 120)
        },
        Purple = {
            BG = Color3.fromRGB(211, 124, 255),
            Outline = Color3.fromRGB(227, 200, 248)
        },
        Orange = {
            BG = Color3.fromRGB(255, 173, 10),
            Outline = Color3.fromRGB(255, 173, 10)
        }
    },
    Quests = {
        Goal = {
            Goal = 50,
            Display = "Score X Goals",
            Colour = "Red"
        },
        Saves = {
            Goal = 25,
            Display = "Save X Goals",
            Colour = "Orange"
        },
        Match = {
            Goal = 25,
            Display = "Play X Matches",
            Colour = "Yellow"
        },
        MVP = {
            Goal = 10,
            Display = "Get match MVP X times",
            Colour = "Purple"
        },
        Assist = {
            Goal = 50,
            Display = "Get X Assists",
            Colour = "Blue"
        },
        Awaken = {
            Goal = 50,
            Display = "Awaken X times",
            Colour = "Green"
        }
    },
    QuestAmount = 6
};

function u1.GetRandomQuests(p2) -- Line: 35
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
            Goal = (typeof(v8.Goal) == "number" and v8.Goal or math.random(v8.Goal.Min, v8.Goal.Max)) * v4
        };
        local _ = i;
    end;

    return v6;
end;

return u1;