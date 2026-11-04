  

return {
    MinElo = 3500,
    MaxElo = 3999,
    RankName = script.Name,
    Tiers = {
        [3] = 3500,
        [2] = 3650,
        [1] = 3800
    },
    DivisionImages = { "rbxassetid://75860111075508", "rbxassetid://130230916917087", "rbxassetid://106174778500084" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Diamond Aura",
            DisplayName = "Diamond Aura",
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
                Amount = 3750
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
                Amount = 7
            }
        },
        {
            Title = "Steal 5 Balls",
            Description = "Steal",
            Icon = "rbxassetid://72060219740081",
            Signal = "Steals",
            RequiredAmount = 5,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 4000
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
                Amount = 7
            }
        },
        {
            Title = "Advance to Elite",
            Description = "",
            Icon = "rbxassetid://140484580976760 ",
            Signal = "DivisionReached",
            RequiredAmount = 1,
            Uniqueness = {
                RankName = "Elite",
                RankTier = 1
            },
            Rewards = {
                Reward = "Emotes",
                RewardName = "Predator Shark Emote",
                Item = "PredatorShark"
            }
        }
    }
};