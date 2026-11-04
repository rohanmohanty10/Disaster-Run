 

 

local v1 = {
    Color = Color3.new(0.333333, 1, 0),
    BundleReference = { "mvps", "aikuMVP" },
    XP = {
        Normal = {
            reflextackle = { "Reflex Tackle", 50 },
            reflextackleiframe = { "Reflex Tackle v IFrames", 75 },
            venomtrap = { "Venom Trap vs Enemy Ball", 50 },
            ultimatedefense = { "Ultimate Defense vs Enemy Ball", 150 },
            formerstriker = { "Former Striker (Goal)", 100 },
            stealflow = { "Steal Flow", 150 }
        },
        Daily = {
            stealflow5 = { "Land 5 Steal Flows against Enemies!", "stealflow", 5, 500 },
            reflextackle20 = { "Land 20 Reflex Tackles against Enemies!", "reflextackle", 20, 350 },
            venomtrap15 = { "Land Venom Traps against an Enemy\'s Ball 15 Times!", "venomtrap", 15, 350 },
            serpentsway30 = { "Successfully use Serpent Sway 30 Times!", "serpentsway", 30, 350 },
            formerstriker5 = { "Score with Former Striker 5 Times!", "formerstriker", 5, 500 },
            ultimatedefense10 = { "Land Ultimate Defense on an Enemy\'s Ball 10 Times!", "ultimatedefense", 10, 500 }
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
                title = "masteryaiku"
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
                emote = "masteryaiku"
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
                mvp = "aikuMVP"
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
                style = "aiku2",
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