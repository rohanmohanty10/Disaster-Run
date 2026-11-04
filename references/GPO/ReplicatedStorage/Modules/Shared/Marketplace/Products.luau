 

local v1 = game:GetService("RunService")
local u2 = game:GetService("MarketplaceService")
local u3 = game:GetService("Players")
local u4 = game:GetService("ReplicatedStorage")
local u5 = require(game.ReplicatedStorage.Modules.ToolDesc)
local u6 = game:GetService("HttpService")
local u7 = {
    ["ListByName"] = {
        ["2x EXP (15 Minutes)"] = {
            ["Main"] = 606947457,
            ["Test"] = 1687289602,
            ["CanGift"] = true
        },
        ["2x EXP (5 Minutes)"] = {
            ["Main"] = 3457788725,
            ["Test"] = 3457774650,
            ["CanGift"] = true,
            ["Ads"] = {
                ["Limit"] = -1
            }
        },
        ["Devil Fruit Remover"] = {
            ["Main"] = 1031589075,
            ["Test"] = 1687293618,
            ["CanGift"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 3,
                ["bonusCount"] = 2,
                ["Active"] = true
            }
        },
        ["Devil Fruit Notifier (1 Hour)"] = {
            ["Main"] = 1059644849,
            ["Test"] = 1687294663,
            ["CanGift"] = true
        },
        ["2x Drop Rates (1 Hour)"] = {
            ["Main"] = 1114835757,
            ["Test"] = 1687296109,
            ["CanGift"] = true
        },
        ["2x Drop Rates (5 Mins)"] = {
            ["Main"] = 3457789187,
            ["Test"] = 3457783012,
            ["CanGift"] = true,
            ["Ads"] = {
                ["Limit"] = -1
            }
        },
        ["Custom Observation Color"] = {
            ["Main"] = 1129612721,
            ["Test"] = 1687302350,
            ["CanGift"] = true
        },
        ["Hoverboard"] = {
            ["Main"] = 1149063054,
            ["Test"] = 1148100236,
            ["CanGift"] = true
        },
        ["Coffin Boat"] = {
            ["Main"] = 1173741141,
            ["Test"] = 1172091385,
            ["CanGift"] = true
        },
        ["Striker"] = {
            ["Main"] = 1173741065,
            ["Test"] = 1172091340,
            ["CanGift"] = true
        },
        ["Trading Sign"] = {
            ["Main"] = 1173741227,
            ["Test"] = 1172565068,
            ["CanGift"] = true
        },
        ["Custom Spirit Color"] = {
            ["Main"] = 1203263798,
            ["Test"] = 1201491213,
            ["CanGift"] = true
        },
        ["Golden Hammer"] = {
            ["Main"] = 1204758257,
            ["Test"] = 1687303320,
            ["CanGift"] = true
        },
        ["Fruit Bag"] = {
            ["Main"] = 1219019424,
            ["Test"] = 1210163773,
            ["CanGift"] = true
        },
        ["SP Reset Essence"] = {
            ["Main"] = 1221504949,
            ["Test"] = 1221358507,
            ["CanGift"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 3,
                ["bonusCount"] = 2,
                ["Active"] = true
            }
        },
        ["Devil Fruit Journal"] = {
            ["Main"] = 1276740776,
            ["Test"] = 1263521933,
            ["CanGift"] = true
        },
        ["Bomi\'s Log Pose"] = {
            ["Main"] = 1276740934,
            ["Test"] = 1271710564,
            ["CanGift"] = true
        },
        ["All Seeing Eye"] = {
            ["Main"] = 1276737886,
            ["Test"] = 1272696393,
            ["CanGift"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 2,
                ["bonusCount"] = 1,
                ["Active"] = false
            }
        },
        ["Thrilled Ship"] = {
            ["Main"] = 1276737887,
            ["Test"] = 1273313185,
            ["CanGift"] = true
        },
        ["Drippy Fit V2"] = {
            ["Main"] = 1279587844,
            ["Test"] = 1279382524,
            ["CanGift"] = true
        },
        ["Hollow\'s Great Sword"] = {
            ["Main"] = 1690202836,
            ["Test"] = 1686450992,
            ["CanGift"] = true
        },
        ["Hollow\'s Halberd"] = {
            ["Main"] = 1690204815,
            ["Test"] = 1686450991,
            ["CanGift"] = true
        },
        ["Hollow Bundle"] = {
            ["Main"] = 1690205795,
            ["Test"] = 1686451243,
            ["CanGift"] = true
        },
        ["Ani Bundle"] = {
            ["Main"] = 1714245752,
            ["Test"] = 1713084224,
            ["CanGift"] = true
        },
        ["Reroll Impel Shop"] = {
            ["Main"] = 1690206194,
            ["Test"] = 1672430317,
            ["CanGift"] = false
        },
        ["Impel Revive"] = {
            ["Main"] = 1690206370,
            ["Test"] = 1684462487,
            ["CanGift"] = false
        },
        ["Roll Grip"] = {
            ["Ignore"] = true,
            ["Main"] = 0,
            ["Test"] = 1383839888,
            ["CanGift"] = false
        },
        ["Roll Grip x10"] = {
            ["Main"] = 1561375720,
            ["Test"] = 1384435588,
            ["CanGift"] = false
        },
        ["Reroll Crew Shop"] = {
            ["Main"] = 1745354421,
            ["Test"] = 1744530126,
            ["CanGift"] = false
        },
        ["Create Crew"] = {
            ["Main"] = 1746145258,
            ["Test"] = 1746144519,
            ["CanGift"] = false
        },
        ["Karoo Mount"] = {
            ["Main"] = 1203263569,
            ["Test"] = 1194261894,
            ["CanGift"] = false
        },
        ["Race Reroll x1"] = {
            ["Main"] = 940683010,
            ["Test"] = 1772098502,
            ["CanGift"] = true,
            ["isPaidRandomItem"] = true,
            ["Ads"] = {
                ["Limit"] = -1,
                ["LevelRequirement"] = 50
            }
        },
        ["Race Reroll x5"] = {
            ["Main"] = 1173707665,
            ["Test"] = 1772098568,
            ["CanGift"] = true,
            ["isPaidRandomItem"] = true
        },
        ["Race Reroll x10"] = {
            ["Main"] = 1170438674,
            ["Test"] = 1772098688,
            ["CanGift"] = true,
            ["isPaidRandomItem"] = true
        },
        ["Race Reroll x50"] = {
            ["Main"] = 1170438820,
            ["Test"] = 1772098795,
            ["CanGift"] = true,
            ["isPaidRandomItem"] = true
        },
        ["SP Reset"] = {
            ["Main"] = 699566079,
            ["Test"] = 1687838557,
            ["CanGift"] = false
        },
        ["Shout"] = {
            ["Main"] = 1690224383,
            ["Test"] = 1688464804,
            ["CanGift"] = false
        },
        ["Myth Chest"] = {
            ["Main"] = 1561376503,
            ["Test"] = 1546543569,
            ["CanGift"] = false,
            ["isPaidRandomItem"] = true
        },
        ["Myth Chest (Discount)"] = {
            ["Main"] = 1561376165,
            ["Test"] = 1688055658,
            ["CanGift"] = false,
            ["isPaidRandomItem"] = true
        },
        ["Rent Statue"] = {
            ["Main"] = 1690205584,
            ["Test"] = 1688991516,
            ["CanGift"] = false
        },
        ["Reroll Sulong Fur Color"] = {
            ["Main"] = 1772126612,
            ["Test"] = 1767619010,
            ["CanGift"] = false
        },
        ["Flower Sword"] = {
            ["Main"] = 1772126056,
            ["Test"] = 1770044820,
            ["CanGift"] = true
        },
        ["Mini Bunny"] = {
            ["Main"] = 1792833152,
            ["Test"] = 1791904719,
            ["CanGift"] = true
        },
        ["Egg Phone"] = {
            ["Main"] = 3275829701,
            ["Test"] = 3274619899,
            ["CanGift"] = true
        },
        ["Yukio The Bunny"] = {
            ["Main"] = 1808123676,
            ["Test"] = 1808117682,
            ["CanGift"] = true
        },
        ["Mythical Fruit Chest"] = {
            ["Main"] = 1792833338,
            ["Test"] = 1841951511,
            ["CanGift"] = true,
            ["isPaidRandomItem"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 2,
                ["bonusCount"] = 1,
                ["Active"] = true
            }
        },
        ["Nightfall Shroud"] = {
            ["Main"] = 2529637068,
            ["Test"] = 2528590257,
            ["CanGift"] = false
        },
        ["Legendary Fruit Chest Blueprint"] = {
            ["Main"] = 2318978315,
            ["Test"] = 2155410101,
            ["CanGift"] = true,
            ["isPaidRandomItem"] = true
        },
        ["Cupid\'s Bow"] = {
            ["Main"] = 3033042858,
            ["Test"] = 3033003160,
            ["CanGift"] = true
        },
        ["Mega-Pow"] = {
            ["Main"] = 3229667746,
            ["Test"] = 3227767705,
            ["CanGift"] = true
        },
        ["Blo\'s Sledgehammer"] = {
            ["Main"] = 3275829420,
            ["Test"] = 3274066137,
            ["CanGift"] = true
        },
        ["Nightfall Half Shroud"] = {
            ["Main"] = 3434369141,
            ["Test"] = 3418858695,
            ["CanGift"] = false
        },
        ["Special Tailor Token"] = {
            ["Main"] = 3434369970,
            ["Test"] = 3428454551,
            ["CanGift"] = true
        },
        ["Tailor Unlock"] = {
            ["Main"] = 3570861877,
            ["Test"] = 3569455606,
            ["CanGift"] = false
        },
        ["Blood Scythe"] = {
            ["Main"] = 3434369619,
            ["Test"] = 3432417248,
            ["CanGift"] = true
        },
        ["Hollow\'s World Ender"] = {
            ["Main"] = 3440321359,
            ["Test"] = 3440138981,
            ["CanGift"] = true
        },
        ["Extra Loadout Slot"] = {
            ["Main"] = 3445112053,
            ["Test"] = 3443645867,
            ["CanGift"] = true
        },
        ["All Seeing Ba\'al"] = {
            ["Main"] = 3445112306,
            ["Test"] = 3444445734,
            ["CanGift"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 2,
                ["bonusCount"] = 1,
                ["Active"] = true
            }
        },
        ["Iceborn Gunblade"] = {
            ["Main"] = 2679077976,
            ["Test"] = 2679017342,
            ["CanGift"] = true
        },
        ["Iceborn Katana"] = {
            ["Main"] = 3488363893,
            ["Test"] = 3484838284,
            ["CanGift"] = true
        },
        ["Iceborn Blade"] = {
            ["Main"] = 1714246497,
            ["Test"] = 3484838826,
            ["CanGift"] = true
        },
        ["Iceborn Daggers"] = {
            ["Main"] = 3488365077,
            ["Test"] = 3484879430,
            ["CanGift"] = true
        },
        ["Iceborn Rapier"] = {
            ["Main"] = 3488365301,
            ["Test"] = 3487749471,
            ["CanGift"] = true
        },
        ["All Seeing Holly"] = {
            ["Main"] = 3488363171,
            ["Test"] = 3484879431,
            ["CanGift"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 2,
                ["bonusCount"] = 1,
                ["Active"] = true
            }
        },
        ["All Seeing Shamrock"] = {
            ["Main"] = 3558579797,
            ["Test"] = 3558451404,
            ["CanGift"] = true,
            ["endTime"] = 1775015940,
            ["hasDeal"] = {
                ["PurchaseCount"] = 2,
                ["bonusCount"] = 1,
                ["Active"] = true
            }
        },
        ["Hunter\'s Journal"] = {
            ["Main"] = 3514520276,
            ["Test"] = 3519825348,
            ["CanGift"] = true
        },
        ["Starter Pack #1"] = {
            ["Main"] = 3521412996,
            ["Test"] = 3513026083,
            ["CanGift"] = false,
            ["PurchaseLimit"] = 1,
            ["LevelLimit"] = 275,
            ["RaceRerolls"] = 10,
            ["Boosts"] = {
                ["2XEXP"] = 21600,
                ["2XDROP"] = 21600
            },
            ["Items"] = {
                ["Rare Fruit Chest"] = 2,
                ["Dark Root"] = 5,
                ["SP Reset Essence"] = 5,
                ["Spare Fruit Bag"] = 1,
                ["Bomi\'s Log Pose"] = 1
            }
        },
        ["Unlimited Free Tailoring"] = {
            ["Main"] = "EXP-5720151623766639097",
            ["Test"] = "EXP-7154751072219431426",
            ["CanGift"] = false,
            ["IsSub"] = true
        },
        ["Cupid\'s All Seeing Eye"] = {
            ["Main"] = 3537158982,
            ["Test"] = 3535159666,
            ["CanGift"] = true,
            ["hasDeal"] = {
                ["PurchaseCount"] = 2,
                ["bonusCount"] = 1,
                ["Active"] = true
            }
        },
        ["Cupid\'s Chakram"] = {
            ["Main"] = 3551805385,
            ["Test"] = 3551735817,
            ["CanGift"] = true
        }
    },
    ["ListById"] = {}
}
for v8, v9 in pairs(u7.ListByName) do
    if v9.Ignore ~= true then
        for v10, v11 in pairs(v9) do
            if v11 == 0 then
                print("ProductId Not Set for", v8, "in", v10)
            else
                u7.ListById[v11] = v8
            end
        end
    end
end
function u7.GetProductsByName(_) --[[ Line: 172 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    return u7.ListByName
end
u7.GetProducts = u7.GetProductsByName
function u7.GetProductsById(_) --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    return u7.ListById
end
function u7.GetProductIdByPlace(_, p12) --[[ Line: 182 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v13 = u7:GetProductsByName()[p12]
    return game.GameId == 648454481 == true and v13.Main or v13.Test
end
function u7.AddCallbackTo(p14, p15) --[[ Line: 191 ]]
    if p14 then
        p14.Callback = p15
    end
end
if v1:IsClient() then
    local v16 = u7:GetProductsByName()
    for _, u17 in { "Starter Pack #1" } do
        local v18 = v16[u17]
        local v19 = v16[u17]
        local u20 = v19.Items
        local _ = v19.MaxQuantity
        local function v30(p21, p22) --[[ Line: 277 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
                [3] = u20
                [4] = u5
                [5] = u2
                [6] = u7
                [7] = u17
            --]]
            local v23
            if script:GetAttribute("ServerLoaded") == true then
                v23 = true
            else
                _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
                v23 = false
            end
            if v23 ~= false then
                if p22 then
                    local v24
                    if p22:IsDescendantOf(u3) then
                        local v25 = p22:FindFirstChild("Loaded")
                        if v25 and v25.Value ~= false then
                            v24 = u4:FindFirstChild("Stats" .. p22.Name) and true or false
                        else
                            v24 = false
                        end
                    else
                        v24 = false
                    end
                    if v24 == false then
                        _G.displayMessage("<Color=Red>This player has not loaded yet!")
                        return false
                    end
                end
                local v26 = p22 or p21
                if u20 then
                    for v27, v28 in pairs(u20) do
                        local v29 = u5[v27].Max
                        if v29 <= _G.CheckItemAmmount(v26, v27) or v29 < _G.CheckItemAmmount(v26, v27) + v28 then
                            _G.displayMessage("<Color=Red>Could not purchase bundle: You will be over the max for " .. v27 .. " after this purchase!")
                            return false
                        end
                    end
                end
                u2:PromptProductPurchase(p21, u7:GetProductIdByPlace(u17))
                return true
            end
        end
        if v18 then
            v18.Callback = v30
        end
    end
    local v31 = v16["Race Reroll x1"]
    local function v37(p32, p33) --[[ Line: 313 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v34
        if script:GetAttribute("ServerLoaded") == true then
            v34 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v34 = false
        end
        if v34 ~= false then
            if p33 then
                local v35
                if p33:IsDescendantOf(u3) then
                    local v36 = p33:FindFirstChild("Loaded")
                    if v36 and v36.Value ~= false then
                        v35 = u4:FindFirstChild("Stats" .. p33.Name) and true or false
                    else
                        v35 = false
                    end
                else
                    v35 = false
                end
                if v35 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p32, u7:GetProductIdByPlace("Race Reroll x1"))
            return true
        end
    end
    if v31 then
        v31.Callback = v37
    end
    local v38 = v16["Race Reroll x5"]
    local function v44(p39, p40) --[[ Line: 326 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v41
        if script:GetAttribute("ServerLoaded") == true then
            v41 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v41 = false
        end
        if v41 ~= false then
            if p40 then
                local v42
                if p40:IsDescendantOf(u3) then
                    local v43 = p40:FindFirstChild("Loaded")
                    if v43 and v43.Value ~= false then
                        v42 = u4:FindFirstChild("Stats" .. p40.Name) and true or false
                    else
                        v42 = false
                    end
                else
                    v42 = false
                end
                if v42 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p39, u7:GetProductIdByPlace("Race Reroll x5"))
            return true
        end
    end
    if v38 then
        v38.Callback = v44
    end
    local v45 = v16["Race Reroll x10"]
    local function v51(p46, p47) --[[ Line: 339 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v48
        if script:GetAttribute("ServerLoaded") == true then
            v48 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v48 = false
        end
        if v48 ~= false then
            if p47 then
                local v49
                if p47:IsDescendantOf(u3) then
                    local v50 = p47:FindFirstChild("Loaded")
                    if v50 and v50.Value ~= false then
                        v49 = u4:FindFirstChild("Stats" .. p47.Name) and true or false
                    else
                        v49 = false
                    end
                else
                    v49 = false
                end
                if v49 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p46, u7:GetProductIdByPlace("Race Reroll x10"))
            return true
        end
    end
    if v45 then
        v45.Callback = v51
    end
    local v52 = v16["Race Reroll x50"]
    local function v58(p53, p54) --[[ Line: 352 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v55
        if script:GetAttribute("ServerLoaded") == true then
            v55 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v55 = false
        end
        if v55 ~= false then
            if p54 then
                local v56
                if p54:IsDescendantOf(u3) then
                    local v57 = p54:FindFirstChild("Loaded")
                    if v57 and v57.Value ~= false then
                        v56 = u4:FindFirstChild("Stats" .. p54.Name) and true or false
                    else
                        v56 = false
                    end
                else
                    v56 = false
                end
                if v56 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p53, u7:GetProductIdByPlace("Race Reroll x50"))
            return true
        end
    end
    if v52 then
        v52.Callback = v58
    end
    local v59 = v16["2x EXP (15 Minutes)"]
    local function v65(p60, p61) --[[ Line: 365 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v62
        if script:GetAttribute("ServerLoaded") == true then
            v62 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v62 = false
        end
        if v62 ~= false then
            if p61 then
                local v63
                if p61:IsDescendantOf(u3) then
                    local v64 = p61:FindFirstChild("Loaded")
                    if v64 and v64.Value ~= false then
                        v63 = u4:FindFirstChild("Stats" .. p61.Name) and true or false
                    else
                        v63 = false
                    end
                else
                    v63 = false
                end
                if v63 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p60, u7:GetProductIdByPlace("2x EXP (15 Minutes)"))
            return true
        end
    end
    if v59 then
        v59.Callback = v65
    end
    local v66 = v16["2x EXP (5 Minutes)"]
    local function v72(p67, p68) --[[ Line: 378 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v69
        if script:GetAttribute("ServerLoaded") == true then
            v69 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v69 = false
        end
        if v69 ~= false then
            if p68 then
                local v70
                if p68:IsDescendantOf(u3) then
                    local v71 = p68:FindFirstChild("Loaded")
                    if v71 and v71.Value ~= false then
                        v70 = u4:FindFirstChild("Stats" .. p68.Name) and true or false
                    else
                        v70 = false
                    end
                else
                    v70 = false
                end
                if v70 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p67, u7:GetProductIdByPlace("2x EXP (5 Minutes)"))
            return true
        end
    end
    if v66 then
        v66.Callback = v72
    end
    local v73 = v16["Devil Fruit Remover"]
    local function v80(p74, p75) --[[ Line: 391 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u5
            [4] = u2
            [5] = u7
        --]]
        local v76
        if script:GetAttribute("ServerLoaded") == true then
            v76 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v76 = false
        end
        if v76 ~= false then
            if p75 then
                local v77
                if p75:IsDescendantOf(u3) then
                    local v78 = p75:FindFirstChild("Loaded")
                    if v78 and v78.Value ~= false then
                        v77 = u4:FindFirstChild("Stats" .. p75.Name) and true or false
                    else
                        v77 = false
                    end
                else
                    v77 = false
                end
                if v77 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p75 or p74, "Dark Root") < u5["Dark Root"].Max then
                u2:PromptProductPurchase(p74, u7:GetProductIdByPlace("Devil Fruit Remover"))
                return true
            end
            local v79 = p75 and "<Color=Red>" .. p75.Name .. " already has the maximum Dark Roots" or "<Color=Red>You already have the maximum Dark Roots"
            _G.displayMessage(v79)
            return false
        end
    end
    if v73 then
        v73.Callback = v80
    end
    local v81 = v16["Devil Fruit Notifier (1 Hour)"]
    local function v87(p82, p83) --[[ Line: 414 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v84
        if script:GetAttribute("ServerLoaded") == true then
            v84 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v84 = false
        end
        if v84 ~= false then
            if p83 then
                local v85
                if p83:IsDescendantOf(u3) then
                    local v86 = p83:FindFirstChild("Loaded")
                    if v86 and v86.Value ~= false then
                        v85 = u4:FindFirstChild("Stats" .. p83.Name) and true or false
                    else
                        v85 = false
                    end
                else
                    v85 = false
                end
                if v85 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p82, u7:GetProductIdByPlace("Devil Fruit Notifier (1 Hour)"))
            return true
        end
    end
    if v81 then
        v81.Callback = v87
    end
    local v88 = v16["2x Drop Rates (1 Hour)"]
    local function v94(p89, p90) --[[ Line: 427 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v91
        if script:GetAttribute("ServerLoaded") == true then
            v91 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v91 = false
        end
        if v91 ~= false then
            if p90 then
                local v92
                if p90:IsDescendantOf(u3) then
                    local v93 = p90:FindFirstChild("Loaded")
                    if v93 and v93.Value ~= false then
                        v92 = u4:FindFirstChild("Stats" .. p90.Name) and true or false
                    else
                        v92 = false
                    end
                else
                    v92 = false
                end
                if v92 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p89, u7:GetProductIdByPlace("2x Drop Rates (1 Hour)"))
            return true
        end
    end
    if v88 then
        v88.Callback = v94
    end
    local v95 = v16["2x Drop Rates (5 Mins)"]
    local function v101(p96, p97) --[[ Line: 440 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v98
        if script:GetAttribute("ServerLoaded") == true then
            v98 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v98 = false
        end
        if v98 ~= false then
            if p97 then
                local v99
                if p97:IsDescendantOf(u3) then
                    local v100 = p97:FindFirstChild("Loaded")
                    if v100 and v100.Value ~= false then
                        v99 = u4:FindFirstChild("Stats" .. p97.Name) and true or false
                    else
                        v99 = false
                    end
                else
                    v99 = false
                end
                if v99 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            u2:PromptProductPurchase(p96, u7:GetProductIdByPlace("2x Drop Rates (5 Mins)"))
            return true
        end
    end
    if v95 then
        v95.Callback = v101
    end
    local v102 = v16["Custom Observation Color"]
    local function v109(p103, p104) --[[ Line: 453 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v105
        if script:GetAttribute("ServerLoaded") == true then
            v105 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v105 = false
        end
        if v105 ~= false then
            if p104 then
                local v106
                if p104:IsDescendantOf(u3) then
                    local v107 = p104:FindFirstChild("Loaded")
                    if v107 and v107.Value ~= false then
                        v106 = u4:FindFirstChild("Stats" .. p104.Name) and true or false
                    else
                        v106 = false
                    end
                else
                    v106 = false
                end
                if v106 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if u4:FindFirstChild("Stats" .. (p104 or p103).Name).Stats.KenMastery.Value > 0 then
                u2:PromptProductPurchase(p103, u7:GetProductIdByPlace("Custom Observation Color"))
                return true
            end
            local v108 = p104 and "<Color=Red>" .. p104.Name .. " needs to unlock observation haki before buying this!" or "<Color=Red>You need to unlock observation haki before buying this!"
            _G.displayMessage(v108)
            return false
        end
    end
    if v102 then
        v102.Callback = v109
    end
    local v110 = v16.Hoverboard
    local function v117(p111, p112) --[[ Line: 477 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v113
        if script:GetAttribute("ServerLoaded") == true then
            v113 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v113 = false
        end
        if v113 ~= false then
            if p112 then
                local v114
                if p112:IsDescendantOf(u3) then
                    local v115 = p112:FindFirstChild("Loaded")
                    if v115 and v115.Value ~= false then
                        v114 = u4:FindFirstChild("Stats" .. p112.Name) and true or false
                    else
                        v114 = false
                    end
                else
                    v114 = false
                end
                if v114 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.HasItem(p112 or p111, "Hoverboard") == false then
                u2:PromptProductPurchase(p111, u7:GetProductIdByPlace("Hoverboard"))
                return true
            end
            local v116 = p112 and "<Color=Red>" .. p112.Name .. " already owns this item!" or "<Color=Red>You already own this item!"
            _G.displayMessage(v116)
            return false
        end
    end
    if v110 then
        v110.Callback = v117
    end
    local v118 = v16["Coffin Boat"]
    local function v125(p119, p120) --[[ Line: 500 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v121
        if script:GetAttribute("ServerLoaded") == true then
            v121 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v121 = false
        end
        if v121 ~= false then
            if p120 then
                local v122
                if p120:IsDescendantOf(u3) then
                    local v123 = p120:FindFirstChild("Loaded")
                    if v123 and v123.Value ~= false then
                        v122 = u4:FindFirstChild("Stats" .. p120.Name) and true or false
                    else
                        v122 = false
                    end
                else
                    v122 = false
                end
                if v122 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.HasItem(p120 or p119, "Coffin Boat") == false then
                u2:PromptProductPurchase(p119, u7:GetProductIdByPlace("Coffin Boat"))
                return true
            end
            local v124 = p120 and "<Color=Red>" .. p120.Name .. " already owns this item!" or "<Color=Red>You already own this item!"
            _G.displayMessage(v124)
            return false
        end
    end
    if v118 then
        v118.Callback = v125
    end
    local v126 = v16.Striker
    local function v133(p127, p128) --[[ Line: 523 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v129
        if script:GetAttribute("ServerLoaded") == true then
            v129 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v129 = false
        end
        if v129 ~= false then
            if p128 then
                local v130
                if p128:IsDescendantOf(u3) then
                    local v131 = p128:FindFirstChild("Loaded")
                    if v131 and v131.Value ~= false then
                        v130 = u4:FindFirstChild("Stats" .. p128.Name) and true or false
                    else
                        v130 = false
                    end
                else
                    v130 = false
                end
                if v130 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.HasItem(p128 or p127, "Striker") == false then
                u2:PromptProductPurchase(p127, u7:GetProductIdByPlace("Striker"))
                return true
            end
            local v132 = p128 and "<Color=Red>" .. p128.Name .. " already owns this item!" or "<Color=Red>You already own this item!"
            _G.displayMessage(v132)
            return false
        end
    end
    if v126 then
        v126.Callback = v133
    end
    local v134 = v16["Trading Sign"]
    local function v141(p135, p136) --[[ Line: 546 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v137
        if script:GetAttribute("ServerLoaded") == true then
            v137 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v137 = false
        end
        if v137 ~= false then
            if p136 then
                local v138
                if p136:IsDescendantOf(u3) then
                    local v139 = p136:FindFirstChild("Loaded")
                    if v139 and v139.Value ~= false then
                        v138 = u4:FindFirstChild("Stats" .. p136.Name) and true or false
                    else
                        v138 = false
                    end
                else
                    v138 = false
                end
                if v138 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.HasItem(p136 or p135, "Trading Sign") == false then
                u2:PromptProductPurchase(p135, u7:GetProductIdByPlace("Trading Sign"))
                return true
            end
            local v140 = p136 and "<Color=Red>" .. p136.Name .. " already owns this item!" or "<Color=Red>You already own this item!"
            _G.displayMessage(v140)
            return false
        end
    end
    if v134 then
        v134.Callback = v141
    end
    local v142 = v16["Custom Spirit Color"]
    local function v150(p143, p144) --[[ Line: 569 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u5
            [4] = u2
            [5] = u7
        --]]
        local v145
        if script:GetAttribute("ServerLoaded") == true then
            v145 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v145 = false
        end
        if v145 ~= false then
            if p144 then
                local v146
                if p144:IsDescendantOf(u3) then
                    local v147 = p144:FindFirstChild("Loaded")
                    if v147 and v147.Value ~= false then
                        v146 = u4:FindFirstChild("Stats" .. p144.Name) and true or false
                    else
                        v146 = false
                    end
                else
                    v146 = false
                end
                if v146 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            local v148 = u4:FindFirstChild("Stats" .. (p144 or p143).Name)
            if _G.CheckItemAmmount(p143, "Spirit Color Essence") > u5["Spirit Color Essence"].Max then
                _G.displayMessage("<Color=Red>You have the max of this item!")
                return false
            end
            if p143.PlayerGui:FindFirstChild("hakiColor") == nil and v148.Stats.BusoV2.Value == true then
                u2:PromptProductPurchase(p143, u7:GetProductIdByPlace("Custom Spirit Color"))
                return true
            end
            local v149 = p144 and "<Color=Red>" .. p144.Name .. " can\'t receive this!" or "<Color=Red>You\'re not ready to buy this!"
            _G.displayMessage(v149)
            return false
        end
    end
    if v142 then
        v142.Callback = v150
    end
    local v151 = v16["Golden Hammer"]
    local function v158(p152, p153) --[[ Line: 596 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v154
        if script:GetAttribute("ServerLoaded") == true then
            v154 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v154 = false
        end
        if v154 ~= false then
            if p153 then
                local v155
                if p153:IsDescendantOf(u3) then
                    local v156 = p153:FindFirstChild("Loaded")
                    if v156 and v156.Value ~= false then
                        v155 = u4:FindFirstChild("Stats" .. p153.Name) and true or false
                    else
                        v155 = false
                    end
                else
                    v155 = false
                end
                if v155 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.HasItem(p153 or p152, "Golden Hammer") == false then
                u2:PromptProductPurchase(p152, u7:GetProductIdByPlace("Golden Hammer"))
                return true
            end
            local v157 = p153 and "<Color=Red>" .. p153.Name .. " already owns this item!" or "<Color=Red>You already own this item!"
            _G.displayMessage(v157)
            return false
        end
    end
    if v151 then
        v151.Callback = v158
    end
    local v159 = v16["Fruit Bag"]
    local function v166(p160, p161) --[[ Line: 619 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u5
            [4] = u2
            [5] = u7
        --]]
        local v162
        if script:GetAttribute("ServerLoaded") == true then
            v162 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v162 = false
        end
        if v162 ~= false then
            if p161 then
                local v163
                if p161:IsDescendantOf(u3) then
                    local v164 = p161:FindFirstChild("Loaded")
                    if v164 and v164.Value ~= false then
                        v163 = u4:FindFirstChild("Stats" .. p161.Name) and true or false
                    else
                        v163 = false
                    end
                else
                    v163 = false
                end
                if v163 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p161 or p160, "Spare Fruit Bag") < u5["Spare Fruit Bag"].Max then
                u2:PromptProductPurchase(p160, u7:GetProductIdByPlace("Fruit Bag"))
                return true
            end
            local v165 = p161 and "<Color=Red>" .. p161.Name .. " already has the maximum amount of Fruit Bags" or "<Color=Red>You already have the maximum amount of Fruit Bags"
            _G.displayMessage(v165)
            return false
        end
    end
    if v159 then
        v159.Callback = v166
    end
    local v167 = v16["SP Reset Essence"]
    local function v174(p168, p169) --[[ Line: 642 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u5
            [4] = u2
            [5] = u7
        --]]
        local v170
        if script:GetAttribute("ServerLoaded") == true then
            v170 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v170 = false
        end
        if v170 ~= false then
            if p169 then
                local v171
                if p169:IsDescendantOf(u3) then
                    local v172 = p169:FindFirstChild("Loaded")
                    if v172 and v172.Value ~= false then
                        v171 = u4:FindFirstChild("Stats" .. p169.Name) and true or false
                    else
                        v171 = false
                    end
                else
                    v171 = false
                end
                if v171 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p169 or p168, "SP Reset Essence") < u5["SP Reset Essence"].Max then
                u2:PromptProductPurchase(p168, u7:GetProductIdByPlace("SP Reset Essence"))
                return true
            end
            local v173 = p169 and "<Color=Red>" .. p169.Name .. " already has the maximum amount of SP Reset Essence" or "<Color=Red>You already have the maximum amount of SP Reset Essence"
            _G.displayMessage(v173)
            return false
        end
    end
    if v167 then
        v167.Callback = v174
    end
    local v175 = v16["Devil Fruit Journal"]
    local function v182(p176, p177) --[[ Line: 665 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u5
            [4] = u2
            [5] = u7
        --]]
        local v178
        if script:GetAttribute("ServerLoaded") == true then
            v178 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v178 = false
        end
        if v178 ~= false then
            if p177 then
                local v179
                if p177:IsDescendantOf(u3) then
                    local v180 = p177:FindFirstChild("Loaded")
                    if v180 and v180.Value ~= false then
                        v179 = u4:FindFirstChild("Stats" .. p177.Name) and true or false
                    else
                        v179 = false
                    end
                else
                    v179 = false
                end
                if v179 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p177 or p176, "Devil Fruit Journal") < u5["Devil Fruit Journal"].Max then
                u2:PromptProductPurchase(p176, u7:GetProductIdByPlace("Devil Fruit Journal"))
                return true
            end
            local v181 = p177 and "<Color=Red>" .. p177.Name .. " already has the maximum Devil Fruit Journals" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v181)
            return false
        end
    end
    if v175 then
        v175.Callback = v182
    end
    local v183 = v16["Bomi\'s Log Pose"]
    local function v190(p184, p185) --[[ Line: 688 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v186
        if script:GetAttribute("ServerLoaded") == true then
            v186 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v186 = false
        end
        if v186 ~= false then
            if p185 then
                local v187
                if p185:IsDescendantOf(u3) then
                    local v188 = p185:FindFirstChild("Loaded")
                    if v188 and v188.Value ~= false then
                        v187 = u4:FindFirstChild("Stats" .. p185.Name) and true or false
                    else
                        v187 = false
                    end
                else
                    v187 = false
                end
                if v187 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p185 or p184, "Bomi\'s Log Pose") < 3 then
                u2:PromptProductPurchase(p184, u7:GetProductIdByPlace("Bomi\'s Log Pose"))
                return true
            end
            local v189 = p185 and "<Color=Red>" .. p185.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v189)
            return false
        end
    end
    if v183 then
        v183.Callback = v190
    end
    local v191 = v16["All Seeing Eye"]
    local function v198(p192, p193) --[[ Line: 711 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v194
        if script:GetAttribute("ServerLoaded") == true then
            v194 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v194 = false
        end
        if v194 ~= false then
            if p193 then
                local v195
                if p193:IsDescendantOf(u3) then
                    local v196 = p193:FindFirstChild("Loaded")
                    if v196 and v196.Value ~= false then
                        v195 = u4:FindFirstChild("Stats" .. p193.Name) and true or false
                    else
                        v195 = false
                    end
                else
                    v195 = false
                end
                if v195 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p193 or p192, "All Seeing Eye") < 3 then
                u2:PromptProductPurchase(p192, u7:GetProductIdByPlace("All Seeing Eye"))
                return true
            end
            local v197 = p193 and "<Color=Red>" .. p193.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v197)
            return false
        end
    end
    if v191 then
        v191.Callback = v198
    end
    local v199 = v16["Thrilled Ship"]
    local function v206(p200, p201) --[[ Line: 734 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v202
        if script:GetAttribute("ServerLoaded") == true then
            v202 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v202 = false
        end
        if v202 ~= false then
            if p201 then
                local v203
                if p201:IsDescendantOf(u3) then
                    local v204 = p201:FindFirstChild("Loaded")
                    if v204 and v204.Value ~= false then
                        v203 = u4:FindFirstChild("Stats" .. p201.Name) and true or false
                    else
                        v203 = false
                    end
                else
                    v203 = false
                end
                if v203 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p201 or p200, "Thrilled Ship") < 3 then
                u2:PromptProductPurchase(p200, u7:GetProductIdByPlace("Thrilled Ship"))
                return true
            end
            local v205 = p201 and "<Color=Red>" .. p201.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v205)
            return false
        end
    end
    if v199 then
        v199.Callback = v206
    end
    local v207 = v16["Drippy Fit V2"]
    local function v214(p208, p209) --[[ Line: 757 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u7
        --]]
        local v210
        if script:GetAttribute("ServerLoaded") == true then
            v210 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v210 = false
        end
        if v210 ~= false then
            if p209 then
                local v211
                if p209:IsDescendantOf(u3) then
                    local v212 = p209:FindFirstChild("Loaded")
                    if v212 and v212.Value ~= false then
                        v211 = u4:FindFirstChild("Stats" .. p209.Name) and true or false
                    else
                        v211 = false
                    end
                else
                    v211 = false
                end
                if v211 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p209 or p208, "Drippy Fit V2") < 3 then
                u2:PromptProductPurchase(p208, u7:GetProductIdByPlace("Drippy Fit V2"))
                return true
            end
            local v213 = p209 and "<Color=Red>" .. p209.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v213)
            return false
        end
    end
    if v207 then
        v207.Callback = v214
    end
    local v215 = v16["Reroll Sulong Fur Color"]
    local function v219(p216, _) --[[ Line: 780 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
        --]]
        local v217
        if script:GetAttribute("ServerLoaded") == true then
            v217 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v217 = false
        end
        if v217 == false then
            return
        else
            local v218 = game.ReplicatedStorage:FindFirstChild("Stats" .. p216.Name)
            if v218 then
                if v218.Stats.FightingStyle.Value == "Moonlit Electro" then
                    u2:PromptProductPurchase(p216, u7:GetProductIdByPlace("Reroll Sulong Fur Color"))
                    return true
                else
                    _G.displayMessage("<Color=Red>You cant buy this!")
                    return false
                end
            else
                _G.displayMessage("<Color=Red>You cant buy this!")
                return false
            end
        end
    end
    if v215 then
        v215.Callback = v219
    end
    local v220 = v16["Mythical Fruit Chest"]
    local v221 = nil
    local u222 = v221 == nil and "Mythical Fruit Chest" or v221
    local u223 = "Mythical Fruit Chest"
    local function v230(p224, p225) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u223
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u222
        --]]
        local v226
        if script:GetAttribute("ServerLoaded") == true then
            v226 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v226 = false
        end
        if v226 ~= false then
            if p225 then
                local v227
                if p225:IsDescendantOf(u3) then
                    local v228 = p225:FindFirstChild("Loaded")
                    if v228 and v228.Value ~= false then
                        v227 = u4:FindFirstChild("Stats" .. p225.Name) and true or false
                    else
                        v227 = false
                    end
                else
                    v227 = false
                end
                if v227 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p225 or p224, u223) < u5[u223].Max then
                u2:PromptProductPurchase(p224, u7:GetProductIdByPlace(u222))
                return true
            end
            local v229 = p225 and "<Color=Red>" .. p225.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v229)
            return false
        end
    end
    if v220 then
        v220.Callback = v230
    end
    local v231 = v16["Legendary Fruit Chest Blueprint"]
    local v232 = nil
    local u233 = v232 == nil and "Legendary Fruit Chest Blueprint" or v232
    local u234 = "Legendary Fruit Chest Blueprint"
    local function v241(p235, p236) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u234
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u233
        --]]
        local v237
        if script:GetAttribute("ServerLoaded") == true then
            v237 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v237 = false
        end
        if v237 ~= false then
            if p236 then
                local v238
                if p236:IsDescendantOf(u3) then
                    local v239 = p236:FindFirstChild("Loaded")
                    if v239 and v239.Value ~= false then
                        v238 = u4:FindFirstChild("Stats" .. p236.Name) and true or false
                    else
                        v238 = false
                    end
                else
                    v238 = false
                end
                if v238 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p236 or p235, u234) < u5[u234].Max then
                u2:PromptProductPurchase(p235, u7:GetProductIdByPlace(u233))
                return true
            end
            local v240 = p236 and "<Color=Red>" .. p236.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v240)
            return false
        end
    end
    if v231 then
        v231.Callback = v241
    end
    local v242 = v16["Iceborn Gunblade"]
    local v243 = nil
    local u244 = v243 == nil and "Iceborn Gunblade" or v243
    local u245 = "Iceborn Gunblade"
    local function v252(p246, p247) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u245
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u244
        --]]
        local v248
        if script:GetAttribute("ServerLoaded") == true then
            v248 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v248 = false
        end
        if v248 ~= false then
            if p247 then
                local v249
                if p247:IsDescendantOf(u3) then
                    local v250 = p247:FindFirstChild("Loaded")
                    if v250 and v250.Value ~= false then
                        v249 = u4:FindFirstChild("Stats" .. p247.Name) and true or false
                    else
                        v249 = false
                    end
                else
                    v249 = false
                end
                if v249 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p247 or p246, u245) < u5[u245].Max then
                u2:PromptProductPurchase(p246, u7:GetProductIdByPlace(u244))
                return true
            end
            local v251 = p247 and "<Color=Red>" .. p247.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v251)
            return false
        end
    end
    if v242 then
        v242.Callback = v252
    end
    local v253 = v16["Cupid\'s Bow"]
    local v254 = nil
    local u255 = v254 == nil and "Cupid\'s Bow" or v254
    local u256 = "Cupid\'s Bow"
    local function v263(p257, p258) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u256
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u255
        --]]
        local v259
        if script:GetAttribute("ServerLoaded") == true then
            v259 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v259 = false
        end
        if v259 ~= false then
            if p258 then
                local v260
                if p258:IsDescendantOf(u3) then
                    local v261 = p258:FindFirstChild("Loaded")
                    if v261 and v261.Value ~= false then
                        v260 = u4:FindFirstChild("Stats" .. p258.Name) and true or false
                    else
                        v260 = false
                    end
                else
                    v260 = false
                end
                if v260 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p258 or p257, u256) < u5[u256].Max then
                u2:PromptProductPurchase(p257, u7:GetProductIdByPlace(u255))
                return true
            end
            local v262 = p258 and "<Color=Red>" .. p258.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v262)
            return false
        end
    end
    if v253 then
        v253.Callback = v263
    end
    local v264 = v16["Mega-Pow"]
    local v265 = nil
    local u266 = v265 == nil and "Mega-Pow" or v265
    local u267 = "Mega-Pow"
    local function v274(p268, p269) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u267
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u266
        --]]
        local v270
        if script:GetAttribute("ServerLoaded") == true then
            v270 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v270 = false
        end
        if v270 ~= false then
            if p269 then
                local v271
                if p269:IsDescendantOf(u3) then
                    local v272 = p269:FindFirstChild("Loaded")
                    if v272 and v272.Value ~= false then
                        v271 = u4:FindFirstChild("Stats" .. p269.Name) and true or false
                    else
                        v271 = false
                    end
                else
                    v271 = false
                end
                if v271 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p269 or p268, u267) < u5[u267].Max then
                u2:PromptProductPurchase(p268, u7:GetProductIdByPlace(u266))
                return true
            end
            local v273 = p269 and "<Color=Red>" .. p269.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v273)
            return false
        end
    end
    if v264 then
        v264.Callback = v274
    end
    local v275 = v16["Blo\'s Sledgehammer"]
    local v276 = nil
    local u277 = v276 == nil and "Blo\'s Sledgehammer" or v276
    local u278 = "Blo\'s Sledgehammer"
    local function v285(p279, p280) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u278
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u277
        --]]
        local v281
        if script:GetAttribute("ServerLoaded") == true then
            v281 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v281 = false
        end
        if v281 ~= false then
            if p280 then
                local v282
                if p280:IsDescendantOf(u3) then
                    local v283 = p280:FindFirstChild("Loaded")
                    if v283 and v283.Value ~= false then
                        v282 = u4:FindFirstChild("Stats" .. p280.Name) and true or false
                    else
                        v282 = false
                    end
                else
                    v282 = false
                end
                if v282 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p280 or p279, u278) < u5[u278].Max then
                u2:PromptProductPurchase(p279, u7:GetProductIdByPlace(u277))
                return true
            end
            local v284 = p280 and "<Color=Red>" .. p280.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v284)
            return false
        end
    end
    if v275 then
        v275.Callback = v285
    end
    local v286 = v16["Egg Phone"]
    local v287 = nil
    local u288 = v287 == nil and "Egg Phone" or v287
    local u289 = "Egg Phone"
    local function v296(p290, p291) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u289
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u288
        --]]
        local v292
        if script:GetAttribute("ServerLoaded") == true then
            v292 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v292 = false
        end
        if v292 ~= false then
            if p291 then
                local v293
                if p291:IsDescendantOf(u3) then
                    local v294 = p291:FindFirstChild("Loaded")
                    if v294 and v294.Value ~= false then
                        v293 = u4:FindFirstChild("Stats" .. p291.Name) and true or false
                    else
                        v293 = false
                    end
                else
                    v293 = false
                end
                if v293 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p291 or p290, u289) < u5[u289].Max then
                u2:PromptProductPurchase(p290, u7:GetProductIdByPlace(u288))
                return true
            end
            local v295 = p291 and "<Color=Red>" .. p291.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v295)
            return false
        end
    end
    if v286 then
        v286.Callback = v296
    end
    local v297 = v16["Blood Scythe"]
    local v298 = nil
    local u299 = v298 == nil and "Blood Scythe" or v298
    local u300 = "Blood Scythe"
    local function v307(p301, p302) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u300
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u299
        --]]
        local v303
        if script:GetAttribute("ServerLoaded") == true then
            v303 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v303 = false
        end
        if v303 ~= false then
            if p302 then
                local v304
                if p302:IsDescendantOf(u3) then
                    local v305 = p302:FindFirstChild("Loaded")
                    if v305 and v305.Value ~= false then
                        v304 = u4:FindFirstChild("Stats" .. p302.Name) and true or false
                    else
                        v304 = false
                    end
                else
                    v304 = false
                end
                if v304 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p302 or p301, u300) < u5[u300].Max then
                u2:PromptProductPurchase(p301, u7:GetProductIdByPlace(u299))
                return true
            end
            local v306 = p302 and "<Color=Red>" .. p302.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v306)
            return false
        end
    end
    if v297 then
        v297.Callback = v307
    end
    local v308 = v16["Hollow\'s Halberd"]
    local v309 = nil
    local u310 = v309 == nil and "Hollow\'s Halberd" or v309
    local u311 = "Hollow\'s Halberd"
    local function v318(p312, p313) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u311
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u310
        --]]
        local v314
        if script:GetAttribute("ServerLoaded") == true then
            v314 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v314 = false
        end
        if v314 ~= false then
            if p313 then
                local v315
                if p313:IsDescendantOf(u3) then
                    local v316 = p313:FindFirstChild("Loaded")
                    if v316 and v316.Value ~= false then
                        v315 = u4:FindFirstChild("Stats" .. p313.Name) and true or false
                    else
                        v315 = false
                    end
                else
                    v315 = false
                end
                if v315 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p313 or p312, u311) < u5[u311].Max then
                u2:PromptProductPurchase(p312, u7:GetProductIdByPlace(u310))
                return true
            end
            local v317 = p313 and "<Color=Red>" .. p313.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v317)
            return false
        end
    end
    if v308 then
        v308.Callback = v318
    end
    local v319 = v16["Hollow\'s Great Sword"]
    local v320 = nil
    local u321 = v320 == nil and "Hollow\'s Great Sword" or v320
    local u322 = "Hollow\'s Great Sword"
    local function v329(p323, p324) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u322
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u321
        --]]
        local v325
        if script:GetAttribute("ServerLoaded") == true then
            v325 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v325 = false
        end
        if v325 ~= false then
            if p324 then
                local v326
                if p324:IsDescendantOf(u3) then
                    local v327 = p324:FindFirstChild("Loaded")
                    if v327 and v327.Value ~= false then
                        v326 = u4:FindFirstChild("Stats" .. p324.Name) and true or false
                    else
                        v326 = false
                    end
                else
                    v326 = false
                end
                if v326 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p324 or p323, u322) < u5[u322].Max then
                u2:PromptProductPurchase(p323, u7:GetProductIdByPlace(u321))
                return true
            end
            local v328 = p324 and "<Color=Red>" .. p324.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v328)
            return false
        end
    end
    if v319 then
        v319.Callback = v329
    end
    local v330 = v16["Special Tailor Token"]
    local function v334(p331, p332) --[[ Line: 812 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u7
        --]]
        local v333
        if script:GetAttribute("ServerLoaded") == true then
            v333 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v333 = false
        end
        if v333 == false then
            return
        elseif _G.CheckItemAmmount(p332 or p331, "Special Tailor Token") + 10 > u5["Special Tailor Token"].Max then
            _G.displayMessage("<Color=Red>You will go over the max for this item if you purchase this.")
            return false
        else
            u2:PromptProductPurchase(p331, u7:GetProductIdByPlace("Special Tailor Token"))
            return true
        end
    end
    if v330 then
        v330.Callback = v334
    end
    local v335 = v16["Nightfall Half Shroud"]
    local v336 = nil
    local u337 = v336 == nil and "Nightfall Half Shroud" or v336
    local u338 = "Nightfall Half Shroud"
    local function v345(p339, p340) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u338
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u337
        --]]
        local v341
        if script:GetAttribute("ServerLoaded") == true then
            v341 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v341 = false
        end
        if v341 ~= false then
            if p340 then
                local v342
                if p340:IsDescendantOf(u3) then
                    local v343 = p340:FindFirstChild("Loaded")
                    if v343 and v343.Value ~= false then
                        v342 = u4:FindFirstChild("Stats" .. p340.Name) and true or false
                    else
                        v342 = false
                    end
                else
                    v342 = false
                end
                if v342 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p340 or p339, u338) < u5[u338].Max then
                u2:PromptProductPurchase(p339, u7:GetProductIdByPlace(u337))
                return true
            end
            local v344 = p340 and "<Color=Red>" .. p340.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v344)
            return false
        end
    end
    if v335 then
        v335.Callback = v345
    end
    local v346 = v16["Hollow\'s World Ender"]
    local v347 = nil
    local u348 = v347 == nil and "Hollow\'s World Ender" or v347
    local u349 = "Hollow\'s World Ender"
    local function v356(p350, p351) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u349
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u348
        --]]
        local v352
        if script:GetAttribute("ServerLoaded") == true then
            v352 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v352 = false
        end
        if v352 ~= false then
            if p351 then
                local v353
                if p351:IsDescendantOf(u3) then
                    local v354 = p351:FindFirstChild("Loaded")
                    if v354 and v354.Value ~= false then
                        v353 = u4:FindFirstChild("Stats" .. p351.Name) and true or false
                    else
                        v353 = false
                    end
                else
                    v353 = false
                end
                if v353 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p351 or p350, u349) < u5[u349].Max then
                u2:PromptProductPurchase(p350, u7:GetProductIdByPlace(u348))
                return true
            end
            local v355 = p351 and "<Color=Red>" .. p351.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v355)
            return false
        end
    end
    if v346 then
        v346.Callback = v356
    end
    local v357 = v16["Extra Loadout Slot"]
    local function v364(p358, p359) --[[ Line: 833 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
        --]]
        local v360
        if script:GetAttribute("ServerLoaded") == true then
            v360 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v360 = false
        end
        if v360 == false then
            return
        else
            local v361 = game.ReplicatedStorage:FindFirstChild("Stats" .. (p359 or p358).Name)
            if v361 then
                local v362 = u6:JSONDecode(v361.Inventory.LoadoutSlotsTable.Value)
                local v363 = 0
                for _, _ in pairs(v362) do
                    v363 = v363 + 1
                end
                if v363 >= 10 then
                    _G.displayMessage("<Color=Red>You already have the max loadout slots!")
                    return false
                else
                    u2:PromptProductPurchase(p358, u7:GetProductIdByPlace("Extra Loadout Slot"))
                    return true
                end
            else
                return
            end
        end
    end
    if v357 then
        v357.Callback = v364
    end
    local v365 = v16["Cupid\'s All Seeing Eye"]
    local v366 = nil
    local u367 = v366 == nil and "Cupid\'s All Seeing Eye" or v366
    local u368 = "Cupid\'s All Seeing Eye"
    local function v375(p369, p370) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u368
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u367
        --]]
        local v371
        if script:GetAttribute("ServerLoaded") == true then
            v371 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v371 = false
        end
        if v371 ~= false then
            if p370 then
                local v372
                if p370:IsDescendantOf(u3) then
                    local v373 = p370:FindFirstChild("Loaded")
                    if v373 and v373.Value ~= false then
                        v372 = u4:FindFirstChild("Stats" .. p370.Name) and true or false
                    else
                        v372 = false
                    end
                else
                    v372 = false
                end
                if v372 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p370 or p369, u368) < u5[u368].Max then
                u2:PromptProductPurchase(p369, u7:GetProductIdByPlace(u367))
                return true
            end
            local v374 = p370 and "<Color=Red>" .. p370.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v374)
            return false
        end
    end
    if v365 then
        v365.Callback = v375
    end
    local v376 = v16["All Seeing Shamrock"]
    local v377 = nil
    local u378 = v377 == nil and "All Seeing Shamrock" or v377
    local u379 = "All Seeing Shamrock"
    local function v386(p380, p381) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u379
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u378
        --]]
        local v382
        if script:GetAttribute("ServerLoaded") == true then
            v382 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v382 = false
        end
        if v382 ~= false then
            if p381 then
                local v383
                if p381:IsDescendantOf(u3) then
                    local v384 = p381:FindFirstChild("Loaded")
                    if v384 and v384.Value ~= false then
                        v383 = u4:FindFirstChild("Stats" .. p381.Name) and true or false
                    else
                        v383 = false
                    end
                else
                    v383 = false
                end
                if v383 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p381 or p380, u379) < u5[u379].Max then
                u2:PromptProductPurchase(p380, u7:GetProductIdByPlace(u378))
                return true
            end
            local v385 = p381 and "<Color=Red>" .. p381.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v385)
            return false
        end
    end
    if v376 then
        v376.Callback = v386
    end
    local v387 = v16["Iceborn Blade"]
    local v388 = nil
    local u389 = v388 == nil and "Iceborn Blade" or v388
    local u390 = "Iceborn Blade"
    local function v397(p391, p392) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u390
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u389
        --]]
        local v393
        if script:GetAttribute("ServerLoaded") == true then
            v393 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v393 = false
        end
        if v393 ~= false then
            if p392 then
                local v394
                if p392:IsDescendantOf(u3) then
                    local v395 = p392:FindFirstChild("Loaded")
                    if v395 and v395.Value ~= false then
                        v394 = u4:FindFirstChild("Stats" .. p392.Name) and true or false
                    else
                        v394 = false
                    end
                else
                    v394 = false
                end
                if v394 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p392 or p391, u390) < u5[u390].Max then
                u2:PromptProductPurchase(p391, u7:GetProductIdByPlace(u389))
                return true
            end
            local v396 = p392 and "<Color=Red>" .. p392.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v396)
            return false
        end
    end
    if v387 then
        v387.Callback = v397
    end
    local v398 = v16["Iceborn Katana"]
    local v399 = nil
    local u400 = v399 == nil and "Iceborn Katana" or v399
    local u401 = "Iceborn Katana"
    local function v408(p402, p403) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u401
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u400
        --]]
        local v404
        if script:GetAttribute("ServerLoaded") == true then
            v404 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v404 = false
        end
        if v404 ~= false then
            if p403 then
                local v405
                if p403:IsDescendantOf(u3) then
                    local v406 = p403:FindFirstChild("Loaded")
                    if v406 and v406.Value ~= false then
                        v405 = u4:FindFirstChild("Stats" .. p403.Name) and true or false
                    else
                        v405 = false
                    end
                else
                    v405 = false
                end
                if v405 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p403 or p402, u401) < u5[u401].Max then
                u2:PromptProductPurchase(p402, u7:GetProductIdByPlace(u400))
                return true
            end
            local v407 = p403 and "<Color=Red>" .. p403.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v407)
            return false
        end
    end
    if v398 then
        v398.Callback = v408
    end
    local v409 = v16["Iceborn Rapier"]
    local v410 = nil
    local u411 = v410 == nil and "Iceborn Rapier" or v410
    local u412 = "Iceborn Rapier"
    local function v419(p413, p414) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u412
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u411
        --]]
        local v415
        if script:GetAttribute("ServerLoaded") == true then
            v415 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v415 = false
        end
        if v415 ~= false then
            if p414 then
                local v416
                if p414:IsDescendantOf(u3) then
                    local v417 = p414:FindFirstChild("Loaded")
                    if v417 and v417.Value ~= false then
                        v416 = u4:FindFirstChild("Stats" .. p414.Name) and true or false
                    else
                        v416 = false
                    end
                else
                    v416 = false
                end
                if v416 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p414 or p413, u412) < u5[u412].Max then
                u2:PromptProductPurchase(p413, u7:GetProductIdByPlace(u411))
                return true
            end
            local v418 = p414 and "<Color=Red>" .. p414.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v418)
            return false
        end
    end
    if v409 then
        v409.Callback = v419
    end
    local v420 = v16["Iceborn Daggers"]
    local v421 = nil
    local u422 = v421 == nil and "Iceborn Daggers" or v421
    local u423 = "Iceborn Daggers"
    local function v430(p424, p425) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u423
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u422
        --]]
        local v426
        if script:GetAttribute("ServerLoaded") == true then
            v426 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v426 = false
        end
        if v426 ~= false then
            if p425 then
                local v427
                if p425:IsDescendantOf(u3) then
                    local v428 = p425:FindFirstChild("Loaded")
                    if v428 and v428.Value ~= false then
                        v427 = u4:FindFirstChild("Stats" .. p425.Name) and true or false
                    else
                        v427 = false
                    end
                else
                    v427 = false
                end
                if v427 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p425 or p424, u423) < u5[u423].Max then
                u2:PromptProductPurchase(p424, u7:GetProductIdByPlace(u422))
                return true
            end
            local v429 = p425 and "<Color=Red>" .. p425.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v429)
            return false
        end
    end
    if v420 then
        v420.Callback = v430
    end
    local v431 = v16["Hunter\'s Journal"]
    local v432 = nil
    local u433 = v432 == nil and "Hunter\'s Journal" or v432
    local u434 = "Hunter\'s Journal"
    local function v441(p435, p436) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u434
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u433
        --]]
        local v437
        if script:GetAttribute("ServerLoaded") == true then
            v437 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v437 = false
        end
        if v437 ~= false then
            if p436 then
                local v438
                if p436:IsDescendantOf(u3) then
                    local v439 = p436:FindFirstChild("Loaded")
                    if v439 and v439.Value ~= false then
                        v438 = u4:FindFirstChild("Stats" .. p436.Name) and true or false
                    else
                        v438 = false
                    end
                else
                    v438 = false
                end
                if v438 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p436 or p435, u434) < u5[u434].Max then
                u2:PromptProductPurchase(p435, u7:GetProductIdByPlace(u433))
                return true
            end
            local v440 = p436 and "<Color=Red>" .. p436.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v440)
            return false
        end
    end
    if v431 then
        v431.Callback = v441
    end
    local v442 = v16["Cupid\'s Chakram"]
    local v443 = nil
    local u444 = v443 == nil and "Cupid\'s Chakram" or v443
    local u445 = "Cupid\'s Chakram"
    local function v452(p446, p447) --[[ Line: 244 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u445
            [4] = u5
            [5] = u2
            [6] = u7
            [7] = u444
        --]]
        local v448
        if script:GetAttribute("ServerLoaded") == true then
            v448 = true
        else
            _G.displayMessage("<Color=Red>Marketplace has not been setup yet, please wait")
            v448 = false
        end
        if v448 ~= false then
            if p447 then
                local v449
                if p447:IsDescendantOf(u3) then
                    local v450 = p447:FindFirstChild("Loaded")
                    if v450 and v450.Value ~= false then
                        v449 = u4:FindFirstChild("Stats" .. p447.Name) and true or false
                    else
                        v449 = false
                    end
                else
                    v449 = false
                end
                if v449 == false then
                    _G.displayMessage("<Color=Red>This player has not loaded yet!")
                    return false
                end
            end
            if _G.CheckItemAmmount(p447 or p446, u445) < u5[u445].Max then
                u2:PromptProductPurchase(p446, u7:GetProductIdByPlace(u444))
                return true
            end
            local v451 = p447 and "<Color=Red>" .. p447.Name .. " already owns the max for this item!" or "<Color=Red>You already own the max for this item!"
            _G.displayMessage(v451)
            return false
        end
    end
    if v442 then
        v442.Callback = v452
    end
end
return u7