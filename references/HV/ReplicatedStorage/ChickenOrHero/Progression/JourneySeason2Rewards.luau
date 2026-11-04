 

 

local v1 = {};

for i, v in {
    { {
            Coins = 100
        }, {
            SkinId = "SpiderFang"
        } },
    { {
            CandyCorn = 50
        }, {
            Badge = "TrickOrTreater"
        } },
    { {
            Coins = 150
        }, {
            Keys = 1
        } },
    { {
            Badge = "CornCollector"
        }, {
            CandyCorn = 100
        } },
    { {
            SkinId = "BoneShiv"
        }, {
            Coins = 250
        } },
    { {
            Coins = 200
        }, {
            Keys = 1
        } },
    { {
            CandyCorn = 75
        }, {
            Badge = "NightStalker"
        } },
    { {
            Badge = "Spooky"
        }, {
            Coins = 300
        } },
    { {
            Coins = 250
        }, {
            CandyCorn = 150
        } },
    { {
            Keys = 1
        }, {
            SkinId = "GhoulBlade"
        } },
    { {
            Coins = 300
        }, {
            Badge = "GhostHunter"
        } },
    { {
            CandyCorn = 100
        }, {
            Keys = 1
        } },
    { {
            Badge = "GraveyardShift"
        }, {
            Coins = 400
        } },
    { {
            Coins = 350
        }, {
            CandyCorn = 200
        } },
    { {
            Keys = 1
        }, {
            SkinId = "FemurShiv"
        } },
    { {
            Coins = 400
        }, {
            Badge = "WitchingHour"
        } },
    { {
            CandyCorn = 125
        }, {
            Coins = 500
        } },
    { {
            Badge = "CandySnatcher"
        }, {
            CandyCorn = 250
        } },
    { {
            Coins = 450
        }, {
            Keys = 1
        } },
    { {
            SkinId = "PumpkinPatchBlade"
        }, {
            Badge = "Haunted"
        } },
    { {
            Coins = 500
        }, {
            CandyCorn = 300
        } },
    { {
            CandyCorn = 150
        }, {
            Badge = "BoneCollector"
        } },
    { {
            Badge = "Cursed"
        }, {
            Keys = 2
        } },
    { {
            Coins = 550
        }, {
            Coins = 750
        } },
    { {
            Keys = 1
        }, {
            Keys = 1
        } },
    { {
            CandyCorn = 200
        }, {
            Badge = "Nightmare"
        } },
    { {
            Badge = "Headless"
        }, {
            CandyCorn = 400
        } },
    { {
            Coins = 600
        }, {
            Coins = 1000
        } },
    { {
            CandyCorn = 250
        }, {
            Badge = "SoulReaper"
        } },
    { {
            Badge = "PumpkinHunter"
        }, {
            SkinId = "ReaperScythe"
        } }
} do
    local table_clone_ret = table.clone(v[1]);
    local table_clone_ret2 = table.clone(v[2]);
    table_clone_ret.Key = "s2_free_" .. i;
    table_clone_ret2.Key = "s2_premium_" .. i;
    v1[i] = {
        Free = table_clone_ret,
        Premium = table_clone_ret2
    };
end;

return v1;