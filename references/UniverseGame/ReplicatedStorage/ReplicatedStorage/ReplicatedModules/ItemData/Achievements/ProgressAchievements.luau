  

 

return {
    ACHIEVEMENT_40 = {
        Name = "The Way To Heaven",
        Description = "Obtain a Heavenly Ability",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p1, p2) -- Line: 52, Name: ProgressCallback
            return p1.HeavenAscension or 0;
        end
    },
    ACHIEVEMENT_50 = {
        Name = "Enshadowment",
        Description = "Obtain a Cursed Ability",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p3, p4) -- Line: 63, Name: ProgressCallback
            return p3.CursedAbility or 0;
        end
    },
    ACHIEVEMENT_22000 = {
        Name = "Soul Hunter I",
        Description = "Collect <Amount> Souls",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p5, p6) -- Line: 74, Name: ProgressCallback
            return p5.ReaperSoulsCollected or 0;
        end
    },
    ACHIEVEMENT_22001 = {
        Name = "Soul Hunter II",
        Description = "Collect <Amount> Souls",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p7, p8) -- Line: 84, Name: ProgressCallback
            return p7.ReaperSoulsCollected or 0;
        end
    },
    ACHIEVEMENT_22002 = {
        Name = "Soul Hunter III",
        Description = "Collect <Amount> Souls",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p9, p10) -- Line: 94, Name: ProgressCallback
            return p9.ReaperSoulsCollected or 0;
        end
    },
    ACHIEVEMENT_22003 = {
        Name = "Soul Hunter IV",
        Description = "Collect <Amount> Souls",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p11, p12) -- Line: 104, Name: ProgressCallback
            return p11.ReaperSoulsCollected or 0;
        end
    },
    ACHIEVEMENT_25000 = {
        Name = "Reaching Full Potential I",
        Description = "Ascend <Amount> time",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p13, p14) -- Line: 115, Name: ProgressCallback
            return p13.AscensionsTotal or 0;
        end
    },
    ACHIEVEMENT_25001 = {
        Name = "Reaching Full Potential II",
        Description = "Ascend <Amount> times in total",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p15, p16) -- Line: 126, Name: ProgressCallback
            return p15.AscensionsTotal or 0;
        end
    },
    ACHIEVEMENT_25002 = {
        Name = "Reaching Full Potential III",
        Description = "Ascend <Amount> times in total",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p17, p18) -- Line: 137, Name: ProgressCallback
            return p17.AscensionsTotal or 0;
        end
    },
    ACHIEVEMENT_25003 = {
        Name = "Reaching Full Potential IV",
        Description = "Ascend <Amount> times in total",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p19, p20) -- Line: 148, Name: ProgressCallback
            return p19.AscensionsTotal or 0;
        end
    },
    ACHIEVEMENT_25100 = {
        Name = "Ascendant",
        Description = "Ascend an ability to Ascension Rank <Rank>",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p21, p22) -- Line: 159, Name: ProgressCallback
            return p21.AscendRank5 or 0;
        end
    },
    ACHIEVEMENT_25101 = {
        Name = "Greater Ascendant",
        Description = "Ascend an ability to Ascension Rank <Rank>",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p23, p24) -- Line: 170, Name: ProgressCallback
            return p23.AscendRank10 or 0;
        end
    },
    ACHIEVEMENT_25200 = {
        Name = "Gambler I",
        Description = "Roll the ability banner <Amount> times.",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p25, p26) -- Line: 181, Name: ProgressCallback
            return p25.BannerRolls or 0;
        end
    },
    ACHIEVEMENT_25201 = {
        Name = "Gambler II",
        Description = "Roll the ability banner <Amount> times.",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p27, p28) -- Line: 191, Name: ProgressCallback
            return p27.BannerRolls or 0;
        end
    },
    ACHIEVEMENT_25202 = {
        Name = "Gambler III",
        Description = "Roll the ability banner <Amount> times.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 3,
        Requirements = {},

        ProgressCallback = function(p29, p30) -- Line: 202, Name: ProgressCallback
            return p29.BannerRolls or 0;
        end
    },
    ACHIEVEMENT_25203 = {
        Name = "Gambler IV",
        Description = "Roll the ability banner <Amount> times.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 4,
        Requirements = {},

        ProgressCallback = function(p31, p32) -- Line: 213, Name: ProgressCallback
            return p31.BannerRolls or 0;
        end
    },
    ACHIEVEMENT_25204 = {
        Name = "Gambler V",
        Description = "Roll the ability banner <Amount> times.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 5,
        Requirements = {},

        ProgressCallback = function(p33, p34) -- Line: 224, Name: ProgressCallback
            return p33.BannerRolls or 0;
        end
    },
    ACHIEVEMENT_25205 = {
        Name = "Gambler VI",
        Description = "Roll the ability banner <Amount> times.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 6,
        Requirements = {},

        ProgressCallback = function(p35, p36) -- Line: 235, Name: ProgressCallback
            return p35.BannerRolls or 0;
        end
    },
    ACHIEVEMENT_25400 = {
        Name = "Collector I",
        Description = "Earn a total of <Amount> uShards",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p37, p38) -- Line: 300, Name: ProgressCallback
            return p37.uShardsCollected or 0;
        end
    },
    ACHIEVEMENT_25401 = {
        Name = "Collector II",
        Description = "Earn a total of <Amount> uShards",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p39, p40) -- Line: 310, Name: ProgressCallback
            return p39.uShardsCollected or 0;
        end
    },
    ACHIEVEMENT_25402 = {
        Name = "Collector III",
        Description = "Earn a total of <Amount> uShards",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 3,
        Requirements = {},

        ProgressCallback = function(p41, p42) -- Line: 321, Name: ProgressCallback
            return p41.uShardsCollected or 0;
        end
    },
    ACHIEVEMENT_25403 = {
        Name = "Collector IV",
        Description = "Earn a total of <Amount> uShards",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 4,
        Requirements = {},

        ProgressCallback = function(p43, p44) -- Line: 332, Name: ProgressCallback
            return p43.uShardsCollected or 0;
        end
    },
    ACHIEVEMENT_25404 = {
        Name = "Collector V",
        Description = "Earn a total of <Amount> uShards",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 5,
        Requirements = {},

        ProgressCallback = function(p45, p46) -- Line: 343, Name: ProgressCallback
            return p45.uShardsCollected or 0;
        end
    },
    ACHIEVEMENT_25500 = {
        Name = "Crafter I",
        Description = "Craft <Amount> legendary abilities with ability shards.",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p47, p48) -- Line: 354, Name: ProgressCallback
            return p47.LegendariesCrafted or 0;
        end
    },
    ACHIEVEMENT_25501 = {
        Name = "Crafter II",
        Description = "Craft <Amount> legendary abilities with ability shards.",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p49, p50) -- Line: 364, Name: ProgressCallback
            return p49.LegendariesCrafted or 0;
        end
    },
    ACHIEVEMENT_25502 = {
        Name = "Crafter III",
        Description = "Craft <Amount> legendary abilities with ability shards.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 3,
        Requirements = {},

        ProgressCallback = function(p51, p52) -- Line: 375, Name: ProgressCallback
            return p51.LegendariesCrafted or 0;
        end
    },
    ACHIEVEMENT_25503 = {
        Name = "Crafter IV",
        Description = "Craft <Amount> legendary abilities with ability shards.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 4,
        Requirements = {},

        ProgressCallback = function(p53, p54) -- Line: 386, Name: ProgressCallback
            return p53.LegendariesCrafted or 0;
        end
    },
    ACHIEVEMENT_25504 = {
        Name = "Crafter V",
        Description = "Craft <Amount> legendary abilities with ability shards.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 5,
        Requirements = {},

        ProgressCallback = function(p55, p56) -- Line: 397, Name: ProgressCallback
            return p55.LegendariesCrafted or 0;
        end
    },
    ACHIEVEMENT_25600 = {
        Name = "Tower Climber I",
        Description = "Achieve C rank or higher in Boundless Tower.",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p57, p58) -- Line: 408, Name: ProgressCallback
            return p57.BT_C_Ranked or 0;
        end
    },
    ACHIEVEMENT_25601 = {
        Name = "Tower Climber II",
        Description = "Achieve B rank or higher in Boundless Tower.",
        Category = "Progression",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p59, p60) -- Line: 418, Name: ProgressCallback
            return p59.BT_B_Ranked or 0;
        end
    },
    ACHIEVEMENT_25602 = {
        Name = "Tower Climber III",
        Description = "Achieve A rank or higher in Boundless Tower.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 3,
        Requirements = {},

        ProgressCallback = function(p61, p62) -- Line: 429, Name: ProgressCallback
            return p61.BT_A_Ranked or 0;
        end
    },
    ACHIEVEMENT_25603 = {
        Name = "Tower Climber IV",
        Description = "Achieve S rank or higher in Boundless Tower.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 4,
        Requirements = {},

        ProgressCallback = function(p63, p64) -- Line: 440, Name: ProgressCallback
            return p63.BT_S_Ranked or 0;
        end
    },
    ACHIEVEMENT_25604 = {
        Name = "Tower Climber V",
        Description = "Achieve P rank in Boundless Tower, the highest merit a climber could hope to achieve.",
        Category = "Progression",
        Type = "Achievement",
        Rarity = 5,
        Requirements = {},

        ProgressCallback = function(p65, p66) -- Line: 451, Name: ProgressCallback
            return p65.BT_P_Ranked or 0;
        end
    },
    ACHIEVEMENT_2200 = {
        Name = "Shady Trader I",
        Description = "Trade <Amount> items to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p67, p68) -- Line: 462, Name: ProgressCallback
            return p67.BlackMarketItemsSold or 0;
        end
    },
    ACHIEVEMENT_2201 = {
        Name = "Shady Trader II",
        Description = "Trade <Amount> items to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p69, p70) -- Line: 472, Name: ProgressCallback
            return p69.BlackMarketItemsSold or 0;
        end
    },
    ACHIEVEMENT_2203 = {
        Name = "Shady Trader III",
        Description = "Trade <Amount> items to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Rarity = 3,
        Requirements = {},

        ProgressCallback = function(p71, p72) -- Line: 483, Name: ProgressCallback
            return p71.BlackMarketItemsSold or 0;
        end
    },
    ACHIEVEMENT_2204 = {
        Name = "Shady Trader IV",
        Description = "Trade <Amount> items to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Rarity = 4,
        Requirements = {},

        ProgressCallback = function(p73, p74) -- Line: 494, Name: ProgressCallback
            return p73.BlackMarketItemsSold or 0;
        end
    },
    ACHIEVEMENT_2205 = {
        Name = "Shady Trader V",
        Description = "Trade <Amount> items to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Rarity = 5,
        Requirements = {},

        ProgressCallback = function(p75, p76) -- Line: 505, Name: ProgressCallback
            return p75.BlackMarketItemsSold or 0;
        end
    },
    ACHIEVEMENT_2400 = {
        Name = "Underworld Merchant I",
        Description = "Trade <Amount> cursed orbs to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p77, p78) -- Line: 516, Name: ProgressCallback
            return p77.BlackMarketCursedOrbsSold or 0;
        end
    },
    ACHIEVEMENT_2401 = {
        Name = "Underworld Merchant II",
        Description = "Trade <Amount> cursed orbs to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p79, p80) -- Line: 526, Name: ProgressCallback
            return p79.BlackMarketCursedOrbsSold or 0;
        end
    },
    ACHIEVEMENT_2402 = {
        Name = "Underworld Merchant III",
        Description = "Trade <Amount> cursed orbs to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Rarity = 3,
        Requirements = {},

        ProgressCallback = function(p81, p82) -- Line: 537, Name: ProgressCallback
            return p81.BlackMarketCursedOrbsSold or 0;
        end
    },
    ACHIEVEMENT_2403 = {
        Name = "Underworld Merchant IV",
        Description = "Trade <Amount> cursed orbs to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Rarity = 4,
        Requirements = {},

        ProgressCallback = function(p83, p84) -- Line: 548, Name: ProgressCallback
            return p83.BlackMarketCursedOrbsSold or 0;
        end
    },
    ACHIEVEMENT_2404 = {
        Name = "Underworld Merchant V",
        Description = "Trade <Amount> cursed orbs to the Black Market.",
        Category = "Miscellaneous",
        Type = "Achievement",
        Rarity = 5,
        Requirements = {},

        ProgressCallback = function(p85, p86) -- Line: 559, Name: ProgressCallback
            return p85.BlackMarketCursedOrbsSold or 0;
        end
    },
    ACHIEVEMENT_3401 = {
        Name = "Strange",
        Description = "Kill <Amount> Player with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p87, p88) -- Line: 570, Name: ProgressCallback
            return p87.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3402 = {
        Name = "Unremarkable",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p89, p90) -- Line: 580, Name: ProgressCallback
            return p89.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3403 = {
        Name = "Scarcely Lethal",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p91, p92) -- Line: 590, Name: ProgressCallback
            return p91.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3404 = {
        Name = "Mildly Menacing",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p93, p94) -- Line: 600, Name: ProgressCallback
            return p93.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3405 = {
        Name = "Somewhat Threatening",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p95, p96) -- Line: 610, Name: ProgressCallback
            return p95.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3406 = {
        Name = "Uncharitable",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p97, p98) -- Line: 620, Name: ProgressCallback
            return p97.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3407 = {
        Name = "Notably Dangerous",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p99, p100) -- Line: 630, Name: ProgressCallback
            return p99.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3408 = {
        Name = "Sufficiently Lethal",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p101, p102) -- Line: 640, Name: ProgressCallback
            return p101.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3409 = {
        Name = "Truly Feared",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p103, p104) -- Line: 650, Name: ProgressCallback
            return p103.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3410 = {
        Name = "Spectacularly Lethal",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p105, p106) -- Line: 660, Name: ProgressCallback
            return p105.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3411 = {
        Name = "Gore-Spattered",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p107, p108) -- Line: 670, Name: ProgressCallback
            return p107.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3412 = {
        Name = "Wicked Nasty",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p109, p110) -- Line: 680, Name: ProgressCallback
            return p109.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3413 = {
        Name = "Postively Inhumane",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p111, p112) -- Line: 690, Name: ProgressCallback
            return p111.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3414 = {
        Name = "Totally Ordinary",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p113, p114) -- Line: 700, Name: ProgressCallback
            return p113.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3415 = {
        Name = "Face-Melting",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p115, p116) -- Line: 710, Name: ProgressCallback
            return p115.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3416 = {
        Name = "Rage-Inducing",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p117, p118) -- Line: 720, Name: ProgressCallback
            return p117.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3417 = {
        Name = "Server-Clearing",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p119, p120) -- Line: 730, Name: ProgressCallback
            return p119.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3418 = {
        Name = "EPIX",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p121, p122) -- Line: 740, Name: ProgressCallback
            return p121.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3419 = {
        Name = "LEGENDARIE",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p123, p124) -- Line: 750, Name: ProgressCallback
            return p123.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3420 = {
        Name = "AUSTRALIAN",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p125, p126) -- Line: 760, Name: ProgressCallback
            return p125.MercsKills or 0;
        end
    },
    ACHIEVEMENT_3421 = {
        Name = "HALE\'S OWN",
        Description = "Kill <Amount> Players with The Mercenaries",
        Category = "Miscellaneous",
        Type = "Achievement",
        Requirements = {},

        ProgressCallback = function(p127, p128) -- Line: 770, Name: ProgressCallback
            return p127.MercsKills or 0;
        end
    }
};