 
 

local v1 = {
    Color = Color3.new(0.333333, 0.666667, 1),
    BundleReference = { "mvps", "superstarMVP" },
    XP = {
        Normal = {
            kimpact = { "Kaiser Impact (Goal)", 35 },
            beinschuss = { "Kaiser Impact: Beinschuss (Goal)", 125 },
            magnus = { "Kaiser Impact: Magnus (Goal)", 35 },
            superstar = { "Kaiser Impact: Magnus Superstar (Goal)", 150 },
            imperialbreak = { "Imperial Break (Counter)", 50 },
            lightning = { "Insta-Kill Flash (Goal)", 100 },
            excuseme = { "Intercept Flow (Others)", 100 },
            chem = { "Chemical Reaction w/ Kiyora", 100 }
        },
        Daily = {
            imperialbreak15 = { "Land 15 Counters!", "imperialbreak", 15, 300 },
            kimpact25 = { "Score 25 Kaiser Impacts!", "kimpact", 25, 500 },
            magnus15 = { "Score with 15 Magnus\'s!", "magnus", 15, 300 },
            aerialflow10 = { "Intercept the Ball w/ Aerial Flow 10 Times!", "excuseme", 10, 500 },
            superstar5 = { "Score w/ Superstar 5 Times", "superstar", 5, 1000 },
            beinschuss5 = { "Score w/ Superstar 5 Times", "beinschuss", 5, 1000 }
        }
    },
    Tiers = {
        { {
                currency = "style_currency",
                value = 1000
            }, {
                currency = "money",
                value = 1000
            } },
        { {
                currency = "money",
                value = 1000
            }, {
                currency = "style_currency",
                value = 1000
            } },
        { {
                currency = "style_currency",
                value = 1000
            }, {
                currency = "money",
                value = 1000
            } },
        { {
                currency = "money",
                value = 1000
            }, {
                currency = "style_currency",
                value = 1000
            } },
        { {
                title = "masterykaiser"
            }, {
                currency = "style_currency",
                value = 1000
            }, {
                currency = "money",
                value = 1000
            } },
        { {
                currency = "money",
                value = 2500
            }, {
                currency = "style_currency",
                value = 2500
            } },
        { {
                currency = "style_currency",
                value = 2500
            }, {
                currency = "money",
                value = 2500
            } },
        { {
                currency = "money",
                value = 2500
            }, {
                currency = "style_currency",
                value = 2500
            } },
        { {
                currency = "style_currency",
                value = 2500
            }, {
                currency = "money",
                value = 2500
            } },
        { {
                emote = "masterykaiser"
            }, {
                currency = "money",
                value = 2500
            }, {
                currency = "style_currency",
                value = 2500
            } },
        { {
                currency = "style_currency",
                value = 3500
            }, {
                currency = "money",
                value = 3500
            } },
        { {
                currency = "money",
                value = 3500
            }, {
                currency = "style_currency",
                value = 3500
            } },
        { {
                currency = "style_currency",
                value = 3500
            }, {
                currency = "money",
                value = 3500
            } },
        { {
                currency = "money",
                value = 3500
            }, {
                currency = "style_currency",
                value = 3500
            } },
        { {
                mvp = "superstarMVP"
            }, {
                currency = "style_currency",
                value = 3500
            }, {
                currency = "money",
                value = 3500
            } },
        { {
                currency = "money",
                value = 5000
            }, {
                currency = "style_currency",
                value = 5000
            } },
        { {
                currency = "style_currency",
                value = 5000
            }, {
                currency = "money",
                value = 5000
            } },
        { {
                currency = "money",
                value = 5000
            }, {
                currency = "style_currency",
                value = 5000
            } },
        { {
                currency = "style_currency",
                value = 5000
            }, {
                currency = "money",
                value = 5000
            } },
        { {
                style = "masterykaiser",
                is_mastery = true
            }, {
                currency = "money",
                value = 5000
            }, {
                currency = "style_currency",
                value = 5000
            } }
    }
};
v1.Tiers[1].XP = 100;
v1.Tiers[2].XP = 200;
v1.Tiers[3].XP = 300;
v1.Tiers[4].XP = 400;
v1.Tiers[5].XP = 500;

for i = 6, 20 do
    v1.Tiers[i].XP = 750;
    local _ = i;
end;

return v1;