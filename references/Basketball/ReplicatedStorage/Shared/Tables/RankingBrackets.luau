 
 

return {
    Decay = {
        Rate = 50,
        Time = 259200,
        Grace = 172800
    },
    Brackets = { "Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Champion" },
    BracketsS1 = { "Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Champion" },
    BracketRewardsFirstTime = {
        Iron = {},
        Bronze = {
            Spins = 10,
            ZoneSpins = 10
        },
        Silver = {
            LuckySpins = 3,
            LuckyZoneSpins = 3
        },
        Gold = {
            LuckySpins = 6,
            LuckyZoneSpins = 6
        },
        Platinum = {
            LuckySpins = 10,
            LuckyZoneSpins = 10
        },
        Diamond = {
            LuckySpins = 15,
            LuckyZoneSpins = 15
        },
        Master = {
            LuckySpins = 20,
            LuckyZoneSpins = 20
        },
        Champion = {
            LuckySpins = 25,
            LuckyZoneSpins = 25
        },
        Legend = {
            LuckySpins = 30,
            LuckyZoneSpins = 30
        }
    },
    BracketRewardsS1 = {
        Iron = {
            Spins = 30,
            ZoneSpins = 30
        },
        Bronze = {
            LuckySpins = 3,
            LuckyZoneSpins = 3
        },
        Silver = {
            LuckySpins = 8,
            LuckyZoneSpins = 8
        },
        Gold = {
            LuckySpins = 12,
            LuckyZoneSpins = 12
        },
        Platinum = {
            LuckySpins = 20,
            LuckyZoneSpins = 20
        },
        Diamond = {
            LuckySpins = 30,
            LuckyZoneSpins = 30,
            ZoneSlot = 1
        },
        Champion = {
            LuckySpins = 50,
            LuckyZoneSpins = 50,
            StyleSlot = 1
        }
    },
    BracketRewards = {
        Iron = {
            Spins = 30,
            ZoneSpins = 30
        },
        Bronze = {
            LuckySpins = 3,
            LuckyZoneSpins = 3
        },
        Silver = {
            LuckySpins = 8,
            LuckyZoneSpins = 8
        },
        Gold = {
            LuckySpins = 12,
            LuckyZoneSpins = 12
        },
        Platinum = {
            LuckySpins = 20,
            LuckyZoneSpins = 20
        },
        Diamond = {
            LuckySpins = 30,
            LuckyZoneSpins = 30
        },
        Master = {
            LuckySpins = 40,
            LuckyZoneSpins = 40,
            ZoneSlot = 1
        },
        Champion = {
            LuckySpins = 50,
            LuckyZoneSpins = 50,
            StyleSlot = 1
        },
        Legend = {
            LuckySpins = 100,
            LuckyZoneSpins = 100,
            ChatTag = "Legend"
        }
    },
    MysteryReward = {
        {
            {
                Type = "Cosmetic",

                Template = function(p1: string) -- Line: 168, Name: Template
                    return `S1 {p1} Badge`;
                end
            }
        },
        {
            {
                Type = "GoalEffect",

                Template = function(p2: string) -- Line: 176, Name: Template
                    return `S2 {p2} Burst`;
                end
            }
        },
        {
            {
                Type = "ChatTag",

                Template = function(p3: string) -- Line: 184, Name: Template
                    return `S3 {p3}`;
                end
            }
        },
        {
            {
                Type = "GoalEffect",

                Template = function(p4: string) -- Line: 192, Name: Template
                    return `S4 {p4} Crown`;
                end
            }
        },
        {
            {
                Type = "ChatTag",

                Template = function(p5: string) -- Line: 200, Name: Template
                    return `S5 {p5}`;
                end
            }
        },
        {
            {
                Type = "Emote",

                Template = function(p6: string) -- Line: 208, Name: Template
                    return `S6 {p6} Badge`;
                end
            }
        },
        {
            {
                Type = "GoalEffect",

                Template = function(p7: string) -- Line: 216, Name: Template
                    return `S7 {p7} Orb`;
                end
            }
        },
        {
            {
                Type = "Cosmetic",

                Template = function(p8: string) -- Line: 224, Name: Template
                    return `S8 {p8} Back Trophy`;
                end
            }
        },
        {
            {
                Type = "Cosmetic",

                Template = function(p9: string) -- Line: 232, Name: Template
                    return `S9 {p9} Staff`;
                end
            }
        },
        {
            {
                Type = "ChatTag",

                Template = function(p10: string) -- Line: 240, Name: Template
                    return `S10 {p10}`;
                end
            }
        },
        {
            {
                Type = "ShotEffect",

                Template = function(p11: string) -- Line: 248, Name: Template
                    return `S11 {p11} Burst`;
                end
            }
        },
        {
            {
                Type = "Cosmetic",

                Template = function(p12: string) -- Line: 256, Name: Template
                    return `S12 {p12} Aura`;
                end
            }
        },
        {
            {
                Type = "Card",

                Template = function(p13: string) -- Line: 264, Name: Template
                    return `S13 {p13} Card`;
                end
            }
        },
        {
            {
                Type = "ChatTag",

                Template = function(p14: string) -- Line: 272, Name: Template
                    return `S14 {p14}`;
                end
            }
        }
    },
    Icons = {
        Legend = "rbxassetid://121361694337055",
        Unplaced = "rbxassetid://102054019152094",
        Iron = { "rbxassetid://111570493379818", "rbxassetid://114606379343437", "rbxassetid://99250399047951" },
        Bronze = { "rbxassetid://92851477935989", "rbxassetid://106159680843449", "rbxassetid://125309372637808" },
        Silver = { "rbxassetid://91071814429484", "rbxassetid://90706315450191", "rbxassetid://81796243150515" },
        Gold = { "rbxassetid://139903203997101", "rbxassetid://78474972506083", "rbxassetid://140278250732459" },
        Platinum = { "rbxassetid://75428402896337", "rbxassetid://108106461185883", "rbxassetid://81805445203153" },
        Diamond = { "rbxassetid://74741596033677", "rbxassetid://129893103696648", "rbxassetid://93076830728029" },
        Master = { "rbxassetid://121090885201168", "rbxassetid://120394718607428", "rbxassetid://86793518524089" },
        Champion = { "rbxassetid://102040335120064", "rbxassetid://93238380258733", "rbxassetid://109558650230755" }
    },
    ChatTags = {
        Unplaced = { "?", "#ad9f95" },
        Iron = { "Ir", "#ad9f95" },
        Bronze = { "B", "#c78c58" },
        Silver = { "S", "#dadbda" },
        Gold = { "G", "#f8e647" },
        Platinum = { "P", "#42cefe" },
        Diamond = { "D", "#bb55f9" },
        Master = { "M", "#4fec44" },
        Champion = { "C", "#f84a47" },
        Legend = { "LEGEND", "#ffffff" }
    },

    _getExpectedMMR = function(p15: table, p16: number) -- Line: 346, Name: _getExpectedMMR
        return math.floor(p16 / 100 * 200 + 0.5);
    end,

    _getExpectedRR = function(p17: table, p18: number) -- Line: 352, Name: _getExpectedRR
        return math.floor(p18 / 200 * 100 + 0.5);
    end,

    GetMaxRR = function(p19) -- Line: 357, Name: GetMaxRR
        return #p19.Brackets * 300;
    end,

    GetRankFromRR = function(p20: table, p21: number, p22: boolean?) -- Line: 361, Name: GetRankFromRR
        if p22 then
            if p21 >= 2100 then
                return "Champion", 3;
            end;
        elseif p20:GetMaxRR() <= p21 then
            return "Legend";
        end;

        local v23;

        if p22 then
            v23 = p20.BracketsS1;
        else
            v23 = p20.Brackets;
        end;

        return v23[p21 // 300 + 1], p21 % 300 // 100 + 1;
    end,

    GetRRToNextRank = function(p24: table, p25: number) -- Line: 381, Name: GetRRToNextRank
        return p25 % 100, 100;
    end,

    CalculateRRAdjustment = function(p26: table, p27: number, p28: number, p29: number, p30: boolean) -- Line: 387, Name: CalculateRRAdjustment
        local v31 = p30 and 25 or -25;
        local v32 = p28 - p26:_getExpectedMMR(p27);
        local v33 = math.abs(v32) * 0.025;
        local math_min_ret = math.min(v33, 15);

        if v32 > 0 then
            v31 = v31 + math_min_ret;
        elseif v32 < 0 then
            v31 = v31 - math_min_ret;
        end;

        local v34;

        if p30 then
            v34 = math.max(v31, 5);
        else
            v34 = math.min(v31, -10);
        end;

        return math.floor(v34 + 0.5);
    end,

    GetInitialPlacement = function(p35: table, p36: number, p37: number, p38: number) -- Line: 411, Name: GetInitialPlacement
        local v39 = p35:_getExpectedRR(p36) + (p37 - 0.5) * 2 * 120 * math.clamp(1 - p38 / 50, 0.25, 1);
        local math_min_ret = math.min(1100, #p35.Brackets * 300 - 1);
        local math_floor_ret = math.floor(v39 + 0.5);

        return math.clamp(math_floor_ret, 300, math_min_ret);
    end
};