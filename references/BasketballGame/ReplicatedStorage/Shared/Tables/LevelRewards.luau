 
 

local AnalyticsService = game:GetService("AnalyticsService");

return {
    Icons = {
        LuckySpins = "rbxassetid://111333169806568",
        Spins = "rbxassetid://111333169806568",
        LuckyZoneSpins = "rbxassetid://71537410313776",
        ZoneSpins = "rbxassetid://71537410313776",
        TrailColorSpins = "rbxassetid://118616255715301",
        ZoneColorSpins = "rbxassetid://118616255715301",
        Money = "rbxassetid://77462302548024"
    },
    Rewards = { { "Spins", "Style Spins", { 3, 10 }, 15 }, { "ZoneSpins", "Zone Spins", { 3, 10 }, 15 }, { "LuckySpins", "Lucky Style Spins", { 2, 3 }, 3 }, { "LuckyZoneSpins", "Lucky Zone Spins", { 2, 3 }, 3 }, { "Money", "Cash", { 2000, 5000 }, 40 }, { "ZoneColorSpins", "Zone Color Spins", { 1, 3 }, 12 }, { "TrailColorSpins", "Trail Color Spins", { 1, 3 }, 12 } },
    BoostedRewards = { { "Spins", "Style Spins", { 3, 10 }, 15 }, { "ZoneSpins", "Zone Spins", { 3, 10 }, 15 }, { "LuckySpins", "Lucky Style Spins", { 3, 5 }, 5 }, { "LuckyZoneSpins", "Lucky Zone Spins", { 3, 5 }, 5 }, { "Money", "Cash", { 3500, 6500 }, 28 }, { "ZoneColorSpins", "Zone Color Spins", { 2, 3 }, 15 }, { "TrailColorSpins", "Trail Color Spins", { 2, 3 }, 15 } },
    Scripts = {
        Spins = function(p1, p2, p3) -- Line: 36, Name: Spins
            p2:ChangePlrValue(p1, "Spins", p2.Players[p1.Name].Spins + p3);
        end,

        ZoneSpins = function(p4, p5, p6) -- Line: 39, Name: ZoneSpins
            p5:ChangePlrValue(p4, "ZoneSpins", p5.Players[p4.Name].ZoneSpins + p6);
        end,

        LuckySpins = function(p7, p8, p9) -- Line: 42, Name: LuckySpins
            p8:ChangePlrValue(p7, "LuckySpins", p8.Players[p7.Name].LuckySpins + p9);
        end,

        LuckyZoneSpins = function(p10, p11, p12) -- Line: 45, Name: LuckyZoneSpins
            p11:ChangePlrValue(p10, "ZoneLuckySpins", p11.Players[p10.Name].ZoneLuckySpins + p12);
        end,

        Money = function(p13, p14, p15) -- Line: 48, Name: Money
            -- upvalues: AnalyticsService (copy)
            p14:ChangePlrValue(p13, "Money", p14.Players[p13.Name].Money + p15);
            AnalyticsService:LogEconomyEvent(p13, Enum.AnalyticsEconomyFlowType.Source, "$", p15, p14.Players[p13.Name].Money, Enum.AnalyticsEconomyTransactionType.Gameplay.Name, "LevelRewards");
        end,

        ZoneColorSpins = function(p16, p17, p18) -- Line: 60, Name: ZoneColorSpins
            p17:ChangePlrValue(p16, "ZoneColorSpins", p17.Players[p16.Name].ZoneColorSpins + p18);
        end,

        TrailColorSpins = function(p19, p20, p21) -- Line: 63, Name: TrailColorSpins
            p20:ChangePlrValue(p19, "TrailColorSpins", p20.Players[p19.Name].TrailColorSpins + p21);
        end
    }
};