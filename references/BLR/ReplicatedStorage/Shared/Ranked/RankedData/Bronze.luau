  

return {
    MinElo = 1500,
    MaxElo = 1999,
    RankName = script.Name,
    Tiers = {
        [3] = 1500,
        [2] = 1650,
        [1] = 1800
    },
    DivisionImages = { "rbxassetid://103921326771384", "rbxassetid://100751411933878", "rbxassetid://95800181362573" },
    Divisions = {},
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Bronze Aura",
            DisplayName = "Bronze Aura",
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
            Title = "Awaken 3 Times",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Awaken",
            RequiredAmount = 3,
            RewardName = "",
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 1000
            }
        },
        {
            Title = "Reach Division 2",
            Description = "",
            Icon = "rbxassetid://125339871021518",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 2,
                RankName = script.Name
            },
            Rewards = {
                Reward = "Spins",
                RewardName = "Style Spins",
                Amount = 5
            }
        },
        {
            Title = "Steal 3 Balls",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Steals",
            RequiredAmount = 3,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 1250
            }
        },
        {
            Title = "Reach Division 1",
            Description = "",
            Icon = "rbxassetid://133558083095603",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankTier = 3,
                RankName = script.Name
            },
            Rewards = {
                Reward = "FlowSpins",
                RewardName = "Flow Spins",
                Amount = 5
            }
        },
        {
            Title = "Advance to Silver",
            Description = "",
            Icon = "rbxassetid://97105890157992",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Silver",
                RankTier = 1
            },
            Rewards = {
                Reward = "Cards",
                RewardName = "Predator Shark Player Card",
                Item = "PredatorShark"
            }
        }
    }
};