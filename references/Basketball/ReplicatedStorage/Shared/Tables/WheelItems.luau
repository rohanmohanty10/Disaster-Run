 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AnalyticsService = game:GetService("AnalyticsService");
require(ReplicatedStorage.Shared.Tables.SeasonPass);

return {
    ZoneReward = "Scary",
    Icons = {
        LuckySpins = "rbxassetid://111333169806568",
        Spins = "rbxassetid://111333169806568",
        LuckyZoneSpins = "rbxassetid://71537410313776",
        ZoneSpins = "rbxassetid://71537410313776",
        TrailColorSpins = "rbxassetid://118616255715301",
        ZoneColorSpins = "rbxassetid://118616255715301",
        Money = "rbxassetid://140232684450711",
        MoreMoney = "rbxassetid://129982466788571"
    },
    Rewards = { { "LimitedItem", "Thriller Cutscene Emote", {
                Type = "Emotes",
                Name = "Thriller",
                LuckySpins = 10
            }, 0.1 }, { "LimitedItem", "Werewolf Howl Emote", {
                Type = "Emotes",
                Name = "Werewolf Howl",
                Money = 15000
            }, 15 }, { "LuckySpins", "Lucky Spins", 5, 1.9 }, { "LuckySpins", "Lucky Spins", 3, 6 }, { "MoreMoney", "Money", 15000, 27 }, { "Money", "Money", 5000, 50 } },
    Scripts = {
        LuckySpins = function(p1, p2, p3) -- Line: 30, Name: LuckySpins
            p2:ChangePlrValue(p1, "LuckySpins", p2.Players[p1.Name].LuckySpins + p3);
        end,

        LuckyZoneSpins = function(p4, p5, p6) -- Line: 33, Name: LuckyZoneSpins
            p5:ChangePlrValue(p4, "ZoneLuckySpins", p5.Players[p4.Name].ZoneLuckySpins + p6);
        end,

        Money = function(p7, p8, p9) -- Line: 36, Name: Money
            -- upvalues: AnalyticsService (copy)
            p8:ChangePlrValue(p7, "Money", p8.Players[p7.Name].Money + p9);
            AnalyticsService:LogEconomyEvent(p7, Enum.AnalyticsEconomyFlowType.Source, "$", p9, p8.Players[p7.Name].Money, Enum.AnalyticsEconomyTransactionType.Shop.Name, "WheelSpin");
        end,

        MoreMoney = function(p10, p11, p12) -- Line: 48, Name: MoreMoney
            -- upvalues: AnalyticsService (copy)
            p11:ChangePlrValue(p10, "Money", p11.Players[p10.Name].Money + p12);
            AnalyticsService:LogEconomyEvent(p10, Enum.AnalyticsEconomyFlowType.Source, "$", p12, p11.Players[p10.Name].Money, Enum.AnalyticsEconomyTransactionType.Shop.Name, "WheelSpin");
        end,

        WheelSpins = function(p13, p14, p15) -- Line: 60, Name: WheelSpins
            p14:ChangePlrValue(p13, "WheelSpins", p14.Players[p13.Name].WheelSpins + p15);
        end,

        ZoneColorSpins = function(p16, p17, p18) -- Line: 63, Name: ZoneColorSpins
            p17:ChangePlrValue(p16, "ZoneColorSpins", p17.Players[p16.Name].ZoneColorSpins + p18);
        end,

        LimitedItem = function(p19, p20, p21) -- Line: 66, Name: LimitedItem
            -- upvalues: AnalyticsService (copy)
            local Inventory = p20.Players[p19.Name].Customization.Inventory;

            if table.find(Inventory[p21.Type], p21.Name) then
                if p21.LuckySpins then
                    p20:ChangePlrValue(p19, "LuckySpins", p20.Players[p19.Name].LuckySpins + p21.LuckySpins);

                    return true;
                end;

                if p21.Money then
                    p20:ChangePlrValue(p19, "Money", p20.Players[p19.Name].Money + p21.Money);
                    AnalyticsService:LogEconomyEvent(p19, Enum.AnalyticsEconomyFlowType.Source, "$", p21.Money, p20.Players[p19.Name].Money, Enum.AnalyticsEconomyTransactionType.Shop.Name, "WheelSpin");

                    return true;
                end;

                return;
            end;

            table.insert(Inventory[p21.Type], p21.Name);
            p20:ChangePlrValue(p19, `Customization Inventory {p21.Type}`, Inventory[p21.Type]);
        end
    }
};