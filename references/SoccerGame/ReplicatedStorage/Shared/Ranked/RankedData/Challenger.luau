  

return {
    MinElo = 4500,
    MaxElo = 4999,
    RankName = script.Name,
    Tiers = {
        [3] = 4500,
        [2] = 4650,
        [1] = 4800
    },
    DivisionImages = { "rbxassetid://140151903034684", "rbxassetid://78151133699842", "rbxassetid://112121044192468" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Challenger Aura",
            DisplayName = "Challenger Aura",
            Icon = ""
        }, {
            ItemType = "LuckyStyleSpins",
            Value = 3,
            DisplayName = "3 Lucky Style Spins",
            Icon = "rbxassetid://125339871021518"
        }, {
            ItemType = "LuckyStyleSpins",
            Value = 3,
            DisplayName = "3 Lucky Style Spins",
            Icon = "rbxassetid://125339871021518"
        } },
    Milestones = {
        {
            Title = "Score 12 Goals",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "GoalScored",
            RequiredAmount = 12,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 5000
            }
        },
        {
            Title = "Reach Division 2",
            Description = "",
            Icon = "rbxassetid://125339871021518",
            Rainbow = true,
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 2,
                RankName = script.Name
            },
            Rewards = {
                Reward = "LuckySpins",
                RewardName = "Lucky Style Spins",
                Amount = 12
            }
        },
        {
            Title = "Steal 12 Balls",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Steals",
            RequiredAmount = 12,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 6000
            }
        },
        {
            Title = "Reach Division 1",
            Description = "",
            Icon = "rbxassetid://133558083095603",
            Rainbow = true,
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 3,
                RankName = script.Name
            },
            Rewards = {
                Reward = "LuckyFlowSpins",
                RewardName = "Lucky Flow Spins",
                Amount = 12
            }
        },
        {
            Title = "Advance to Champion",
            Description = "",
            Icon = "rbxassetid://116729820503736",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Champion",
                RankTier = 1
            },
            Rewards = {
                Reward = "GoalEffects",
                RewardName = "Predator Shark Goal Effect",
                Item = "PredatorShark"
            }
        }
    }
};