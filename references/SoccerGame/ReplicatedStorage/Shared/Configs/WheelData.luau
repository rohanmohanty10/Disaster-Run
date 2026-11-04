  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);

return {
    {
        { ItemType.EventTokens, 25 },
        42
    },
    {
        { ItemType.LuckyStyleSpins, 1 },
        26
    },
    {
        { ItemType.PlayerCard, "Ego Match" },
        20
    },
    {
        { ItemType.GoalEffect, "Reaper Dab" },
        11
    },
    {
        { ItemType.Cosmetic, "Toxic Aura" },
        1
    }
};