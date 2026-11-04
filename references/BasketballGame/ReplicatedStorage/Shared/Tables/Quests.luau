 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RandomUtil = require(ReplicatedStorage.Shared.Utility.RandomUtil);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local DailyQuestRewards = require(ReplicatedStorage.Shared.Tables.DailyQuestRewards);
local u1 = {
    ["Lucky Style Spins"] = {
        Rarity = "Mythic",
        DataIndex = "LuckySpins",
        FixedReward = DailyQuestRewards["Lucky Style Spins"]
    },
    ["Lucky Zone Spins"] = {
        Rarity = "Mythic",
        DataIndex = "ZoneLuckySpins",
        FixedReward = DailyQuestRewards["Lucky Zone Spins"]
    },
    ["Style Spins"] = {
        Rarity = "Legendary",
        DataIndex = "LuckySpins",
        Reward = "Lucky Style Spins",
        Range = NumberRange.new(2, 5)
    },
    ["Zone Spins"] = {
        Rarity = "Epic",
        DataIndex = "ZoneSpins",
        FixedReward = DailyQuestRewards["Zone Spins"]
    },
    Money = {
        Rarity = "Rare",
        DataIndex = "Money",
        FixedReward = DailyQuestRewards.Money
    }
};
local u2 = {};

for i, v in u1 do
    table.insert(u2, {
        Weight = Rarities.QuestRewardOdds[v.Rarity],
        Value = i
    });
end;

local function GetRandomReward() -- Line: 68
    -- upvalues: RandomUtil (copy), u2 (copy), u1 (copy)
    local RandomValueFromWeights = RandomUtil.GetRandomValueFromWeights(u2);
    local v3 = u1[RandomValueFromWeights];

    return not v3.FixedReward and {
        Reward = v3.Reward or RandomValueFromWeights,
        Value = Random.new():NextInteger(v3.Range.Min, v3.Range.Max),
        Rarity = v3.Rarity,
        DataIndex = v3.DataIndex
    } or table.clone(v3.FixedReward);
end;

local function CreateTargetQuest(u4: string, u5: string, u6, p7: function, u8: table?) -- Line: 81
    -- upvalues: GetRandomReward (copy)
    return {
        DisplayName = u5,

        Description = function(p9) -- Line: 90, Name: Description
            -- upvalues: u4 (copy)
            return string.format(u4, p9.Metadata.Target);
        end,

        CanComplete = function(p10) -- Line: 94, Name: CanComplete
            -- upvalues: u5 (copy)
            return p10.Metadata[u5] >= p10.Metadata.Target;
        end,

        OnCompleted = p7,

        InitialMetadata = function() -- Line: 99, Name: InitialMetadata
            -- upvalues: u5 (copy), u6 (copy), u8 (copy), GetRandomReward (ref)
            return {
                [u5] = 0,
                Index = u5,
                Target = math.random(u6.Min, u6.Max),
                Reward = u8 and table.clone(u8) or GetRandomReward()
            };
        end
    };
end;

local function CreatePlaytimeQuest(u11, p12: function, u13: table?) -- Line: 109
    -- upvalues: GetRandomReward (copy)
    return {
        DisplayName = "Playtime",

        Description = function(p14) -- Line: 116, Name: Description
            return `Play For {math.floor(p14.Metadata.Target / 60)} Minutes Without Leaving!`;
        end,

        CanComplete = function(p15) -- Line: 122, Name: CanComplete
            return p15.Metadata.Playtime >= p15.Metadata.Target;
        end,

        OnCompleted = p12,

        InitialMetadata = function() -- Line: 127, Name: InitialMetadata
            -- upvalues: u11 (copy), u13 (copy), GetRandomReward (ref)
            local v16 = {
                Playtime = 0,
                Index = "Playtime"
            };
            local v17 = math.random(u11.Min * 60, u11.Max * 60) / 60;
            v16.Target = math.round(v17) * 60;
            v16.Reward = u13 and table.clone(u13) or GetRandomReward();

            return v16;
        end
    };
end;

local function ClaimRewardCallback(p18: userdata, p19: table) -- Line: 138
    -- upvalues: Knit (copy)
    if not game:GetService("RunService"):IsServer() then
        return warn("can only call callback on server!");
    end;

    if not p19.Metadata.Reward then
        return warn((`quest '{p19.QuestName}' has not reward`));
    end;

    Knit.GetService("QuestsService"):RewardPlayer(p18, p19.Metadata.Reward);
end;

local v20 = {
    CompleteMatches = CreateTargetQuest("Complete %i Matches!", "Matches", NumberRange.new(3, 5), ClaimRewardCallback),
    ScorePoints = CreateTargetQuest("Score %i Points!", "Points", NumberRange.new(65, 100), ClaimRewardCallback),
    ScoreDunks = CreateTargetQuest("Score %i Dunks!", "Dunks", NumberRange.new(10, 20), ClaimRewardCallback),
    Score3Pointers = CreateTargetQuest("Score %i 3-Pointers!", "3Pointers", NumberRange.new(15, 30), ClaimRewardCallback),
    ScoreAssists = CreateTargetQuest("Score %i Assists!", "Assists", NumberRange.new(10, 20), ClaimRewardCallback),
    PerformAnkleBreakers = CreateTargetQuest("Perform %i Ankle Breakers!", "AnkleBreaks", NumberRange.new(20, 35), ClaimRewardCallback),
    BlockShots = CreateTargetQuest("Block %i Shots!", "Blocks", NumberRange.new(25, 50), ClaimRewardCallback),
    Playtime = CreatePlaytimeQuest(NumberRange.new(15, 25), ClaimRewardCallback)
};

local function ClaimSeasonQuest(p21: userdata, p22: table) -- Line: 197
    -- upvalues: Knit (copy)
    if not game:GetService("RunService"):IsServer() then
        return warn("can only call callback on server!");
    end;

    local Service = Knit.GetService("SeasonPassService");

    if Service.Active then
        Service:GiveEXP(p21, Random.new():NextInteger(50, 100));
    end;
end;

local v23 = {
    Reward = "Season Pass EXP",
    Rarity = "Legendary",
    Value = "50-100",
    DataIndex = "N/A"
};
v20.SeasonCompleteMatches = CreateTargetQuest("Complete %i Matches!", "Matches", NumberRange.new(3, 5), ClaimSeasonQuest, v23);
v20.SeasonScorePoints = CreateTargetQuest("Score %i Points!", "Points", NumberRange.new(65, 100), ClaimSeasonQuest, v23);
v20.SeasonScoreDunks = CreateTargetQuest("Score %i Dunks!", "Dunks", NumberRange.new(10, 20), ClaimSeasonQuest, v23);
v20.SeasonScore3Pointers = CreateTargetQuest("Score %i 3-Pointers!", "3Pointers", NumberRange.new(15, 30), ClaimSeasonQuest, v23);
v20.SeasonScoreAssists = CreateTargetQuest("Score %i Assists!", "Assists", NumberRange.new(10, 20), ClaimSeasonQuest, v23);
v20.SeasonPerformAnkleBreakers = CreateTargetQuest("Perform %i Ankle Breakers!", "AnkleBreaks", NumberRange.new(20, 35), ClaimSeasonQuest, v23);
v20.SeasonBlockShots = CreateTargetQuest("Block %i Shots!", "Blocks", NumberRange.new(25, 50), ClaimSeasonQuest, v23);
v20.SeasonPlaytime = CreatePlaytimeQuest(NumberRange.new(15, 25), ClaimSeasonQuest, v23);
v20.FirstQuests1 = CreatePlaytimeQuest(NumberRange.new(25), ClaimRewardCallback, DailyQuestRewards["Lucky Style Spins"]);
v20.FirstQuests2 = CreateTargetQuest("Score %i Points!", "Points", NumberRange.new(30), ClaimRewardCallback, DailyQuestRewards.Money);
v20.FirstQuests3 = CreateTargetQuest("Score %i Dunks!", "Dunks", NumberRange.new(5), ClaimRewardCallback, DailyQuestRewards["Lucky Zone Spins"]);

return v20;