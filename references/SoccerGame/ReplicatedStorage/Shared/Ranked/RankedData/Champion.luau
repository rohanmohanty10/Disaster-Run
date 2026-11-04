  

return {
    LastRank = true,
    LeaderboardRank = 250,
    MinElo = 5000,
    RankName = script.Name,
    Tiers = {
        [3] = 5000,
        [2] = 5000,
        [1] = 5000
    },
    DivisionImages = { "rbxassetid://95306713966479", "rbxassetid://95306713966479", "rbxassetid://95306713966479" },
    RankRewards = { {
            ItemType = "Cosmetic",
            Value = "Champ Aura",
            DisplayName = "Champ Aura",
            Icon = ""
        } },
    Milestones = {
        {
            Title = "Break 12 Ankles",
            Description = "Ankles",
            Icon = "rbxassetid://72060219740081",
            Signal = "GoalScored",
            RequiredAmount = 12,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 7000
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
                Amount = 20
            }
        },
        {
            Title = "Win 12 Matches",
            Description = "",
            Icon = "rbxassetid://72060219740081",
            Signal = "Wins",
            RequiredAmount = 12,
            Rewards = {
                Reward = "Money",
                RewardName = "Cash",
                Amount = 10000
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
                Amount = 20
            }
        },
        {
            Title = "Get Mvp 12 Times",
            Description = "",
            Icon = "rbxassetid://109201230562391",
            Signal = "GotMVP",
            RequiredAmount = 12,
            Rewards = {
                Reward = "Emotes",
                RewardName = "Predator Shark Stance Emote",
                Item = "PredatorShark"
            }
        }
    }
};