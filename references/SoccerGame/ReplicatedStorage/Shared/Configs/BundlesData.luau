  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);

return {
    KaiserBundle2 = {
        Display = "Kaiser",
        PurchaseId = 3721915344,
        GiftId = 3721915348,
        BuyLimit = 1,
        Items = {
            {
                Name = "Emperor",
                Type = ItemType.PlayerCard
            },
            {
                Name = "Rose Mural",
                Type = ItemType.GoalEffect
            },
            {
                Amount = 10,
                Type = ItemType.LuckyStyleSpins
            }
        }
    },
    ZantetsuBundle = {
        Display = "Zantetsu",
        PurchaseId = 3724532276,
        GiftId = 3724532284,
        BuyLimit = 1,
        Items = {
            {
                Name = "Zantetsu",
                Type = ItemType.GoalEffect
            },
            {
                Name = "Aura Glasses",
                Type = ItemType.Cosmetic
            },
            {
                Amount = 10,
                Type = ItemType.LuckyStyleSpins
            }
        }
    },
    ExtraPrize = {}
};