 
 

local v1 = {
    Color = Color3.fromRGB(0, 0, 127),
    BundleReference = { "mvps", "isagiNigeriaWC" },
    XP = {
        Normal = {
            directshot = { "Scoring with Direct Shot", 40 },
            naruhayadirectshot = { "Successfully scoring with Direct Shot right after using Naruhaya Footwork", 55 },
            mydirectshot = { "Scoring MY DIRECT SHOT", 100 },
            reflexshot = { "Scoring Reflex Shot", 200 },
            backheelshot = { "Scoring Backheel Shot", 150 },
            moveit = { "Steal using MOVE IT.", 50 },
            moveitbarou = { "Steal using MOVE IT. from a Barou", 100 },
            luckygoal = { "Scoring the LUCK goal.", 150 }
        },
        Daily = {
            directshot25 = { "Score 25 Direct Shots!", "directshot", 25, 500 },
            naruhayadirectshot25 = { "Score 25 Direct Shots after using Naruhaya Footwork!", "naruhayadirectshot", 25, 700 },
            moveit10 = { "Steal the ball with MOVE IT. 10 times!", "moveit", 10, 200 },
            mydirectshot5 = { "Score w/ MY DIRECT SHOT 5 times!", "mydirectshot", 5, 500 },
            backheelshot5 = { "Score w/ Backheel Shot 5 times!", "backheelshot", 5, 700 },
            luckygoal3 = { "Score w/ LUCK goal 3 times!", "luckygoal", 3, 1000 }
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
                title = "masterynelisagi"
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
                emote = "TalentedLearner"
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
                mvp = "isagiNigeriaWC"
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
                style = "nelisagi",
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