  

return {
    MinElo = 4000,
    MaxElo = 4499,
    RankName = script.Name,
    Tiers = {
        [3] = 4000,
        [2] = 4150,
        [1] = 4300
    },
    DivisionImages = { "rbxassetid://74512069662199", "rbxassetid://72260999980567", "rbxassetid://112739628422872" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Elite Aura",
            DisplayName = "Elite Aura",
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
            Title = "Win 7  Matches",
            Description = "",
            Signal = "Wins",
            RequiredAmount = 7,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 4250
            }
        },
        {
            Title = "Reach Division 2",
            Description = "",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 2,
                RankName = script.Name
            },
            Rewards = {
                Reward = "LuckyFlowSpins",
                RewardName = "Lucky Flow Spins",
                Amount = 9
            }
        },
        {
            Title = "Get Mvp 7 Times",
            Description = "",
            Signal = "GotMVP",
            RequiredAmount = 7,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 1000
            }
        },
        {
            Title = "Reach Division 1",
            Description = "",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 3,
                RankName = script.Name
            },
            Rewards = {
                Reward = "LuckySpins",
                RewardName = "Lucky Style Spins",
                Amount = 9
            }
        },
        {
            Title = "Advance to Challenger",
            Description = "",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Challenger",
                RankTier = 1
            },
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 4750
            }
        }
    }
};