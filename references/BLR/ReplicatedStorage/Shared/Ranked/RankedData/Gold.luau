  

return {
    MinElo = 2500,
    MaxElo = 2999,
    RankName = script.Name,
    Tiers = {
        [3] = 2500,
        [2] = 2650,
        [1] = 2800
    },
    DivisionImages = { "rbxassetid://119881039194944", "rbxassetid://118249036404532", "rbxassetid://70527380987570" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Gold Aura",
            DisplayName = "Gold Aura",
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
            Title = "Win 5 Matches",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Wins",
            RequiredAmount = 5,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 2250
            }
        },
        {
            Title = "Reach Division 2",
            Description = "",
            Icon = "rbxassetid://133558083095603",
            Rainbow = true,
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 2,
                RankName = script.Name
            },
            Rewards = {
                Reward = "LuckyFlowSpins",
                RewardName = "Lucky Flow Spins",
                Amount = 3
            }
        },
        {
            Title = "Score 5 Goals",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "GoalScored",
            RequiredAmount = 5,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 2500
            }
        },
        {
            Title = "Reach Division 1",
            Description = "",
            Icon = "rbxassetid://125339871021518",
            Rainbow = true,
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 3,
                RankName = script.Name
            },
            Rewards = {
                Reward = "LuckySpins",
                RewardName = "Lucky Style Spins",
                Amount = 3
            }
        },
        {
            Title = "Advance to Platinum",
            Description = "",
            Icon = "rbxassetid://140484580976760",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Platinum",
                RankTier = 1
            },
            Rewards = {
                Reward = "Cosmetics",
                RewardName = "Predator Shark Cosmetic",
                Item = "PredatorShark"
            }
        }
    }
};