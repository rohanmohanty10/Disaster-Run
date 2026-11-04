  

return {
    MinElo = 0,
    MaxElo = 1499,
    RankName = script.Name,
    Tiers = {
        [3] = 0,
        [2] = 1150,
        [1] = 1300
    },
    DivisionImages = { "rbxassetid://115612269576408", "rbxassetid://76728029463348", "rbxassetid://136007704548172" },
    Milestones = {
        {
            Title = "Score 3 Goals",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "GoalScored",
            RequiredAmount = 3,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 250
            }
        },
        {
            Title = "Reach Division 2",
            Description = "",
            Icon = "rbxassetid://133558083095603",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 2,
                RankName = script.Name
            },
            Rewards = {
                Reward = "FlowSpins",
                RewardName = "Flow Spins",
                Amount = 3
            }
        },
        {
            Title = "Get 3 Assists",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Assists",
            RequiredAmount = 3,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 500
            }
        },
        {
            Title = "Reach Division 1",
            Description = "",
            Icon = "rbxassetid://125339871021518",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 3,
                RankName = script.Name
            },
            Rewards = {
                Reward = "Spins",
                RewardName = "Style Spins",
                Amount = 3
            }
        },
        {
            Title = "Advance to Bronze",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Bronze",
                RankTier = 1
            },
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 750
            }
        }
    }
};