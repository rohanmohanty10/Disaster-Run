  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Essentials);

return {
    AbbreviationToNormal = {
        LS = "LuckySpins",
        Flow = "FlowSpins",
        Spins = "Spins",
        FL = "LuckyFlowSpins",
        Snow = "EventCurrency"
    },
    ToUI = {
        LS = "Lucky Spins",
        Flow = "Flow Spins",
        Spins = "Spins",
        FL = "Lucky Flow Spins",
        Emotes = "Emotes",
        GoalEffects = "Goal Effect",
        Cards = "Card",
        Snow = "Snowflakes",
        Cosmetics = "Cosmetic",
        None = "None"
    },
    InventoryItems = { "Emotes", "GoalEffects", "Cards", "Cosmetics" },
    Icons = {
        LS = "rbxassetid://125339871021518",
        Spins = "rbxassetid://125339871021518",
        Flow = "rbxassetid://133558083095603",
        FL = "rbxassetid://133558083095603",
        Snow = "rbxassetid://109206154581451",
        Emotes = "rbxassetid://133558083095603",
        GoalEffects = "rbxassetid://133558083095603",
        Cards = "rbxassetid://109206154581451",
        None = "rbxassetid://71873528065567",
        Cosmetics = "rbxassetid://109707434209411"
    },
    Rewards = {
        Reward1 = {
            Index = 5,
            Item = "LS",
            Value = 5
        },
        Reward2 = {
            Index = 2,
            Item = "FL",
            Value = 5
        },
        Reward3 = {
            Index = 6,
            Item = "Cosmetics",
            Value = "Ninja"
        },
        Reward4 = {
            Index = 3,
            Item = "Snow",
            Value = 75
        },
        Reward5 = {
            Index = 1,
            Item = "Emotes",
            Value = "Present"
        },
        Reward6 = {
            Index = 4,
            Item = "Cosmetics",
            Value = "SHADOW"
        }
    }
};