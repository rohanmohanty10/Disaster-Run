  

return {
    MinElo = 3000,
    MaxElo = 3499,
    RankName = script.Name,
    Tiers = {
        [3] = 3000,
        [2] = 3150,
        [1] = 3300
    },
    DivisionImages = { "rbxassetid://124117606351281", "rbxassetid://140362789270021", "rbxassetid://126144178626453" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Platinum Aura",
            DisplayName = "Platinum Aura",
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
            Title = "Get 5 Assists",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Assists",
            RequiredAmount = 5,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 3000
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
                Amount = 5
            }
        },
        {
            Title = "Awaken 5 Timess",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Awaken",
            RequiredAmount = 5,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 3250
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
                Amount = 5
            }
        },
        {
            Title = "Advance to Diamond",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Diamond",
                RankTier = 1
            },
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 3500
            }
        }
    }
};