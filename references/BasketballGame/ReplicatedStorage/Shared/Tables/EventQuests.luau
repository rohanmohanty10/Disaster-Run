 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RandomUtil = require(ReplicatedStorage.Shared.Utility.RandomUtil);
require(ReplicatedStorage.Shared.Tables.Rarities);
local EventQuestRewards = require(ReplicatedStorage.Shared.Tables.EventQuestRewards);
local u1 = {};

for i, v in EventQuestRewards do
    table.insert(u1, {
        Weight = v.Weight,
        Value = i
    });
end;

local Random_new_ret = Random.new(tick() * math.random());

local function GetRandomReward() -- Line: 42
    -- upvalues: RandomUtil (copy), u1 (copy), EventQuestRewards (copy), Random_new_ret (copy)
    local RandomValueFromWeights = RandomUtil.GetRandomValueFromWeights(u1);
    local Value = EventQuestRewards[RandomValueFromWeights].Value;

    return {
        Reward = RandomValueFromWeights,
        Value = Random_new_ret:NextInteger(Value.Range.Min, Value.Range.Max),
        Rarity = Value.Rarity,
        DataIndex = Value.DataIndex
    };
end;

local function CreateTargetQuest(u2: string, u3: string, p4, p5: function, u6: table?) -- Line: 63
    -- upvalues: GetRandomReward (copy)
    local NumberRange_new_ret = NumberRange.new(p4.Min * 1.25, p4.Max * 1.25);

    return {
        DisplayName = "TBD",

        Description = function(p7) -- Line: 74, Name: Description
            -- upvalues: u2 (copy)
            return string.format(u2, p7.Metadata.Target);
        end,

        CanComplete = function(p8) -- Line: 78, Name: CanComplete
            -- upvalues: u3 (copy)
            return p8.Metadata[u3] >= p8.Metadata.Target;
        end,

        OnCompleted = p5,

        InitialMetadata = function() -- Line: 83, Name: InitialMetadata
            -- upvalues: u3 (copy), NumberRange_new_ret (ref), u6 (copy), GetRandomReward (ref)
            return {
                [u3] = 0,
                Index = u3,
                Target = math.random(NumberRange_new_ret.Min, NumberRange_new_ret.Max),
                Reward = u6 or GetRandomReward()
            };
        end
    };
end;

local function CreatePlaytimeQuest(p9, p10: function, u11: table?) -- Line: 93
    -- upvalues: GetRandomReward (copy)
    local NumberRange_new_ret = NumberRange.new(p9.Min * 1.5, p9.Max * 1.5);

    return {
        DisplayName = "TBD",

        Description = function(p12) -- Line: 102, Name: Description
            return `Play For {math.floor(p12.Metadata.Target / 60)} Minutes Without Leaving!`;
        end,

        CanComplete = function(p13) -- Line: 108, Name: CanComplete
            return p13.Metadata.Playtime >= p13.Metadata.Target;
        end,

        OnCompleted = p10,

        InitialMetadata = function() -- Line: 113, Name: InitialMetadata
            -- upvalues: NumberRange_new_ret (ref), u11 (copy), GetRandomReward (ref)
            local v14 = {
                Playtime = 0,
                Index = "Playtime"
            };
            local v15 = math.random(NumberRange_new_ret.Min * 60, NumberRange_new_ret.Max * 60) / 60;
            v14.Target = math.round(v15) * 60;
            v14.Reward = u11 or GetRandomReward();

            return v14;
        end
    };
end;

local function ClaimRewardCallback(p16: userdata, p17: table) -- Line: 124
    -- upvalues: Knit (copy)
    if not game:GetService("RunService"):IsServer() then
        return warn("can only call callback on server!");
    end;

    if not p17.Metadata.Reward then
        return warn((`quest '{p17.QuestName}' has not reward`));
    end;

    Knit.GetService("QuestsService"):RewardPlayer(p16, p17.Metadata.Reward);
end;

return {
    CompleteMatches = CreateTargetQuest("Complete %i Matches!", "Matches", NumberRange.new(3, 5), ClaimRewardCallback),
    ScorePoints = CreateTargetQuest("Score %i Points!", "Points", NumberRange.new(65, 100), ClaimRewardCallback),
    ScoreDunks = CreateTargetQuest("Score %i Dunks!", "Dunks", NumberRange.new(10, 20), ClaimRewardCallback),
    Score3Pointers = CreateTargetQuest("Score %i 3-Pointers!", "3Pointers", NumberRange.new(15, 30), ClaimRewardCallback),
    ScoreAssists = CreateTargetQuest("Score %i Assists!", "Assists", NumberRange.new(10, 20), ClaimRewardCallback),
    PerformAnkleBreakers = CreateTargetQuest("Perform %i Ankle Breakers!", "AnkleBreaks", NumberRange.new(20, 35), ClaimRewardCallback),
    BlockShots = CreateTargetQuest("Block %i Shots!", "Blocks", NumberRange.new(25, 50), ClaimRewardCallback)
};