 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("AnalyticsService");
local SeasonPass = require(ReplicatedStorage.Shared.Tables.SeasonPass);

return {
    Icons = {
        LuckySpins = "rbxassetid://111333169806568",
        Spins = "rbxassetid://111333169806568",
        LuckyZoneSpins = "rbxassetid://71537410313776",
        ZoneSpins = "rbxassetid://71537410313776",
        TrailColorSpins = "rbxassetid://118616255715301",
        ZoneColorSpins = "rbxassetid://118616255715301",
        OPCrate = "rbxassetid://140379772466729",
        SeasonPassCurrency = SeasonPass.Items.Currency.Icon
    },
    Rewards = {
        { "LimitedItem", "Piano Drop", {
                Type = "GoalEffects",
                Name = "Piano Drop",
                LuckySpins = 10
            }, 1 },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            400,
            4
        },
        { "LimitedItem", "Stone Bloom", {
                Type = "Cosmetics",
                Name = "Stone Bloom",
                SeasonPassCurrency = 75
            }, 5 },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            250,
            7
        },
        { "LimitedItem", "Playing Piano", {
                Type = "Emotes",
                Name = "Playing Piano",
                SeasonPassCurrency = 75
            }, 10 },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            150,
            18
        },
        { "LimitedItem", "Illusion", {
                Type = "Cards",
                Name = "Illusion",
                SeasonPassCurrency = 75
            }, 25 },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            100,
            30
        }
    },
    Basic = {
        { "OPCrate", "OP CRATE", nil, 1 },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            150,
            10
        },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            50,
            25
        },
        { "LimitedItem", "Red Rock", {
                Type = "Cards",
                Name = "Red Rock",
                SeasonPassCurrency = 50
            }, 28 },
        {
            "SeasonPassCurrency",
            SeasonPass.Items.Currency.DisplayName,
            50,
            36
        }
    },
    OP = { { "Zones", "LIMITED ZONE", {
                Name = "Formless",
                LuckySpins = 15
            }, 5 }, { "LimitedItem", "Rose Grave", {
                Type = "Cosmetics",
                Name = "Rose Grave",
                SeasonPassCurrency = 150
            }, 10 }, { "LimitedItem", "Long Tongue", {
                Type = "Emotes",
                Name = "Long Tongue",
                SeasonPassCurrency = 150
            }, 16 }, { "LimitedItem", "Blossom Skull", {
                Type = "Cosmetics",
                Name = "Blossom Skull",
                SeasonPassCurrency = 150
            }, 28 }, { "LimitedItem", "Punk Rock", {
                Type = "Cards",
                Name = "Punk Rock",
                SeasonPassCurrency = 150
            }, 41 } },
    Scripts = {
        LuckySpins = function(p1, p2, p3) -- Line: 47, Name: LuckySpins
            p2:ChangePlrValue(p1, "LuckySpins", p2.Players[p1.Name].LuckySpins + p3);
        end,

        LuckyZoneSpins = function(p4, p5, p6) -- Line: 50, Name: LuckyZoneSpins
            p5:ChangePlrValue(p4, "ZoneLuckySpins", p5.Players[p4.Name].ZoneLuckySpins + p6);
        end,

        ZoneColorSpins = function(p7, p8, p9) -- Line: 53, Name: ZoneColorSpins
            p8:ChangePlrValue(p7, "ZoneColorSpins", p8.Players[p7.Name].ZoneColorSpins + p9);
        end,

        SeasonPassCurrency = function(p10, p11, p12) -- Line: 56, Name: SeasonPassCurrency
            p11:ChangePlrValue(p10, "SeasonPass Currency", p11.Players[p10.Name].SeasonPass.Currency + p12);
        end,

        LimitedItem = function(p13, p14, p15) -- Line: 59, Name: LimitedItem
            local Inventory = p14.Players[p13.Name].Customization.Inventory;

            if table.find(Inventory[p15.Type], p15.Name) then
                if p15.LuckySpins then
                    p14:ChangePlrValue(p13, "LuckySpins", p14.Players[p13.Name].LuckySpins + p15.LuckySpins);

                    return true;
                end;

                if p15.SeasonPassCurrency then
                    p14:ChangePlrValue(p13, "SeasonPass Currency", p14.Players[p13.Name].SeasonPass.Currency + p15.SeasonPassCurrency);

                    return true;
                end;

                return;
            end;

            table.insert(Inventory[p15.Type], p15.Name);
            p14:ChangePlrValue(p13, `Customization Inventory {p15.Type}`, Inventory[p15.Type]);
        end,

        Styles = function(p16, p17, p18) -- Line: 78, Name: Styles
            local LimitedStyles = p17.Players[p16.Name].LimitedStyles;

            if table.find(LimitedStyles, p18.Name) then
                if p18.LuckySpins then
                    p17:ChangePlrValue(p16, "LuckySpins", p17.Players[p16.Name].LuckySpins + p18.LuckySpins);

                    return true;
                end;

                if p18.SeasonPassCurrency then
                    p17:ChangePlrValue(p16, "SeasonPass Currency", p17.Players[p16.Name].SeasonPass.Currency + p18.SeasonPassCurrency);

                    return true;
                end;

                return;
            end;

            table.insert(LimitedStyles, p18.Name);
            p17:ChangePlrValue(p16, "LimitedStyles", LimitedStyles);
            p17:ChangePlrValue(p16, "LimitedStyleEquipped", p18.Name);
        end,

        Zones = function(p19, p20, p21) -- Line: 98, Name: Zones
            local LimitedZones = p20.Players[p19.Name].LimitedZones;

            if table.find(LimitedZones, p21.Name) then
                if p21.LuckySpins then
                    p20:ChangePlrValue(p19, "LuckySpins", p20.Players[p19.Name].LuckySpins + p21.LuckySpins);

                    return true;
                end;

                if p21.SeasonPassCurrency then
                    p20:ChangePlrValue(p19, "SeasonPass Currency", p20.Players[p19.Name].SeasonPass.Currency + p21.SeasonPassCurrency);

                    return true;
                end;

                return;
            end;

            table.insert(LimitedZones, p21.Name);
            p20:ChangePlrValue(p19, "LimitedZones", LimitedZones);
            p20:ChangePlrValue(p19, "LimitedZoneEquipped", p21.Name);
        end
    }
};