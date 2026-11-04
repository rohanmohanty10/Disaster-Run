  

return {
    MinElo = 2000,
    MaxElo = 2499,
    RankName = script.Name,
    Tiers = {
        [3] = 2000,
        [2] = 2150,
        [1] = 2300
    },
    DivisionImages = { "rbxassetid://115568617065045", "rbxassetid://111418068160983", "rbxassetid://72573229276858" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Silver Aura",
            DisplayName = "Silver Aura",
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
            Title = "Break 5 Ankles",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Ankles",
            RequiredAmount = 5,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 1500
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
                Amount = 10
            }
        },
        {
            Title = "Get Mvp 3 Times",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "GotMVP",
            RequiredAmount = 3,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 1750
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
                Amount = 10
            }
        },
        {
            Title = "Advance to Gold",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Gold",
                RankTier = 1
            },
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 2000
            }
        }
    }
};