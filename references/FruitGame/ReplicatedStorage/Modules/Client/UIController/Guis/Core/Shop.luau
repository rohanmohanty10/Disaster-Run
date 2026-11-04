 

local u1 = game:GetService("Players")
game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("UserInputService")
local u2 = game:GetService("MarketplaceService")
local u3 = game:GetService("PolicyService")
local u4 = game:GetService("AdService")
local u5 = game:GetService("ReplicatedStorage")
local u6 = game:GetService("HttpService")
local u7 = {
    Enum.AdAvailabilityResult.PlayerIneligible,
    Enum.AdAvailabilityResult.DeviceIneligible,
    Enum.AdAvailabilityResult.PublisherIneligible,
    Enum.AdAvailabilityResult.ExperienceIneligible
}
local u8 = game.GameId == 2097989947
local v9 = u5:WaitForChild("Modules")
require(v9.Leveling)
local v10 = v9.Shared
local v11 = v10:WaitForChild("Utils")
local u12 = require(v11:WaitForChild("PlayerUtils"))
require(v10:WaitForChild("GameUtils"))
require(v10:WaitForChild("SoundUtils"))
local v13 = require(u5.Modules.Shared.Signals.GoodSignal)
local v14 = v10:WaitForChild("Marketplace")
local u15 = require(v14:WaitForChild("Products"))
local u16 = require(v14:WaitForChild("MarketplaceUtils"))
local v17 = v9.Client
local u18 = require(v17:WaitForChild("Notification"))
local u19 = u1.LocalPlayer
local u20 = u19:WaitForChild("PlayerGui")
local v21 = u5:WaitForChild("Events")
local u22 = v21.ADShop
local u23 = v21:WaitForChild("CheckSubscription")
local u24 = u5:WaitForChild("Remotes").Monetization
local u25 = {
    ["Initialized"] = false,
    ["ShopGui"] = nil,
    ["ShopListFrame"] = nil,
    ["ADShopTitleFrame"] = nil
}
local u26 = v13.new()
local u27 = false
local u28 = {}
local u29 = 0
local u30 = u8 and {
    ["2x EXP (5 Minutes)"] = "662966069596443",
    ["2x Drop Rates (5 Mins)"] = "174101840437991",
    ["Race Reroll x1"] = "40190462364307"
} or {
    ["2x EXP (5 Minutes)"] = "536248645108658",
    ["2x Drop Rates (5 Mins)"] = "600025169914931",
    ["Race Reroll x1"] = "250356898332440"
}
local function u36(u31, p32) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u4
    --]]
    local u33 = u30[p32]
    if u33 then
        local v34, v35 = pcall(function() --[[ Line: 97 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u31
                [3] = u33
            --]]
            u4:RegisterAdOpportunityAsync(u31, u33)
        end)
        if not v34 then
            warn("Failed to register ad opportunity for", p32, ":", v35)
        end
    else
        warn("No placement ID found for product:", p32)
    end
end
local function u40() --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u28
        [3] = u25
        [4] = u29
    --]]
    if u27 and #u28 ~= 0 then
        local v37 = ""
        for _, v38 in ipairs(u28) do
            v37 = v37 .. "\n<Rare=Rare><" .. v38 .. "><Rare=/>"
        end
        local u39 = false
        _G.displayMessageWithButton(("<Color=Orange>AD<Color=/> available in the <Color=Green>ROBUX SHOP<Color=/> for free products!\nEligible Products: %*"):format(v37), script.Z_ADButton, function() --[[ Line: 124 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u25
            --]]
            if u39 ~= true then
                u39 = true
                u25:OpenADShop()
                u39 = false
            end
        end)
        script.ADNotification:Play()
        u29 = os.clock()
    end
end
local u41 = false
local function u54(p42) --[[ Line: 138 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u41
        [3] = u27
        [4] = u4
        [5] = u7
        [6] = u28
        [7] = u26
        [8] = u15
        [9] = u5
        [10] = u29
        [11] = u40
    --]]
    game.ReplicatedStorage:FindFirstChild("Stats" .. u19.Name)
    if u41 == true then
        return
    end
    if u27 == true and p42 == true then
        return
    end
    local v43, v44 = pcall(function() --[[ Line: 154 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        return u4:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo)
    end)
    local v45 = v44.AdAvailabilityResult
    for _, v46 in ipairs(u7) do
        if v45 == v46 then
            v53 = true
            ::l9::
            if v53 then
                u27 = false
                u28 = {}
                u26:Fire()
                u41 = true
                return
            elseif v43 and v44.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable then
                local v47 = u27 == false
                u27 = true
                local v48 = u15:GetProductsByName()
                u28 = {}
                local v49 = u5:FindFirstChild("Stats" .. u19.Name)
                for v50, v51 in v48 do
                    if v51.Ads ~= nil then
                        if (v51.Ads.LevelRequirement or 0) <= v49.Stats.Level.Value then
                            local v52 = u28
                            table.insert(v52, v50)
                        end
                    end
                end
                if v47 or os.clock() - u29 >= 1200 then
                    u40()
                end
                u26:Fire()
            else
                u27 = false
                u28 = {}
                u26:Fire()
            end
        end
    end
    local v53 = false
    goto l9
end
local function u63(p55) --[[ Line: 204 ]]
    if p55 <= 0 then
        return "ENDS SOON"
    else
        local v56 = p55 / 86400
        local v57 = math.floor(v56)
        local v58 = p55 % 86400 / 3600
        local v59 = math.floor(v58)
        local v60 = p55 % 3600 / 60
        local v61 = math.floor(v60)
        local v62 = p55 % 60
        if v57 > 0 then
            return string.format("%dd %dh %dm", v57, v59, v61)
        elseif v59 > 0 then
            return string.format("%dh %dm %ds", v59, v61, v62)
        else
            return string.format("%dm %ds", v61, v62)
        end
    end
end
local function u67(p64) --[[ Line: 223 ]]
    local v65 = tostring(p64)
    local v66 = 1
    while v66 ~= 0 do
        v65, v66 = string.gsub(v65, "^(-?%d+)(%d%d%d)", "%1,%2")
    end
    return v65
end
u22.OnClientEvent:Connect(function(_, _) --[[ Line: 232 ]]
    --[[
    Upvalues:
        [1] = u54
    --]]
    warn("client ad refreshing")
    u54()
end)
function u25.OpenADShop(p68) --[[ Line: 239 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u28
        [3] = u18
        [4] = u20
    --]]
    if not p68.Initialized then
        return false
    end
    if not u27 or #u28 == 0 then
        u18.DisplayMessage("<Color=Red>No ads available right now!")
        return false
    end
    local v69 = require(script.Parent.MenuWheel)
    if u20:FindFirstChild("Shop").Enabled == false then
        v69.MenuButtonFunctions.Shop.Open()
    end
    task.wait(0.25)
    if p68.ShopListFrame:IsA("ScrollingFrame") then
        local v70 = p68.ShopListFrame.CanvasPosition.Y
        local v71 = p68.ADShopTitleFrame.AbsolutePosition.Y - p68.ShopListFrame.AbsolutePosition.Y + v70
        p68.ShopListFrame.CanvasPosition = Vector2.new(0, v71)
    end
    return true
end
function u25.CanWatchAd(_) --[[ Line: 269 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u28
    --]]
    local v72 = u27
    if v72 then
        v72 = #u28 > 0
    end
    return v72
end
function u25.Initialize(p73) --[[ Line: 273 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u5
        [3] = u20
        [4] = u15
        [5] = u27
        [6] = u28
        [7] = u40
        [8] = u3
        [9] = u19
        [10] = u18
        [11] = u6
        [12] = u63
        [13] = u67
        [14] = u16
        [15] = u24
        [16] = u2
        [17] = u30
        [18] = u36
        [19] = u22
        [20] = u26
        [21] = u8
        [22] = u23
        [23] = u1
        [24] = u12
        [25] = u54
    --]]
    if not u25.Initialized then
        local u74 = u5:WaitForChild("Events")
        local u75 = u74:WaitForChild("ProductsRemote", 120)
        local u76 = p73:GetStatsFolder()
        local v77 = u76:WaitForChild("Stats")
        local u78 = v77:WaitForChild("FightingStyle")
        local u79 = v77:WaitForChild("Level")
        local u80 = nil
        local u81 = {}
        local u82 = u20:WaitForChild("Shop", 360)
        local u83 = u82:WaitForChild("Main")
        local v84 = u83:WaitForChild("List")
        local u85 = v84:WaitForChild("Products")
        local u86 = v84:WaitForChild("Boosts")
        local u87 = v84:WaitForChild("RaceRerolls")
        local u88 = v84:WaitForChild("ADShop")
        local u89 = v84:WaitForChild("ADShopTitle")
        local u90 = v84:WaitForChild("Recommended")
        local u91 = v84:WaitForChild("RecommendedTitle")
        u90.Visible = false
        u91.Visible = false
        local v92 = v84:WaitForChild("Gamepasses")
        local u93 = v84:WaitForChild("BundleTitle")
        local u94 = v84:WaitForChild("Bundles")
        local u95 = u83:WaitForChild("GiftButton")
        local u96 = u83:WaitForChild("GiftingTo")
        local v97 = u96:WaitForChild("Stop")
        local u98 = u83:WaitForChild("Gift")
        local u99 = u98:WaitForChild("List")
        local u100 = v84:WaitForChild("Codes"):WaitForChild("Redeem"):WaitForChild("Input")
        local u101 = u15:GetProductsByName()
        u25.ShopGui = u82
        u25.ShopListFrame = v84
        u25.ADShopTitleFrame = u89
        u88.Visible = false
        u89.Visible = false
        u79.Changed:Connect(function() --[[ Line: 328 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u28
                [3] = u40
            --]]
            if u27 and #u28 > 0 then
                u40()
            end
        end)
        local u102 = {
            ["Reroll Sulong Fur Color"] = function() --[[ Line: 335 ]]
                --[[
                Upvalues:
                    [1] = u78
                --]]
                return u78.Value == "Moonlit Electro"
            end
        }
        local u105 = {
            ["Reroll Sulong Fur Color"] = function(u103) --[[ Line: 347 ]]
                --[[
                Upvalues:
                    [1] = u78
                --]]
                local function v104() --[[ Line: 349 ]]
                    --[[
                    Upvalues:
                        [1] = u78
                        [2] = u103
                    --]]
                    if u78.Value == "Moonlit Electro" then
                        if script:GetAttribute("Gifting") == true then
                            u103.Visible = false
                        else
                            u103.Visible = true
                        end
                    else
                        u103.Visible = false
                        return
                    end
                end
                if u78.Value == "Moonlit Electro" then
                    if script:GetAttribute("Gifting") == true then
                        u103.Visible = false
                    else
                        u103.Visible = true
                    end
                else
                    u103.Visible = false
                end
                u78:GetPropertyChangedSignal("Value"):Connect(v104)
            end
        }
        local _, u106 = pcall(function() --[[ Line: 368 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u19
            --]]
            return u3:GetPolicyInfoForPlayerAsync(u19)
        end)
        local u107 = {}
        local u108 = false
        local u109 = u99:WaitForChild("InvisFix")
        u82:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 377 ]]
            --[[
            Upvalues:
                [1] = u109
                [2] = u82
            --]]
            u109.Visible = u82.Enabled
        end)
        u83:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 381 ]]
            --[[
            Upvalues:
                [1] = u83
                [2] = u108
                [3] = u107
            --]]
            if u83.Size.X.Scale >= 0.89 then
                if u108 then
                    return
                end
                u108 = true
                for _, u110 in pairs(u107) do
                    u110.Visible = false
                    task.delay(0.05, function() --[[ Line: 389 ]]
                        --[[
                        Upvalues:
                            [1] = u110
                        --]]
                        u110.Visible = true
                    end)
                end
                task.wait(0.05)
                u108 = false
            end
        end)
        u100.FocusLost:Connect(function() --[[ Line: 400 ]]
            --[[
            Upvalues:
                [1] = u74
                [2] = u100
            --]]
            local v111 = u74.RedeemCode:InvokeServer(u100.Text)
            if v111 then
                u100.Text = v111
            end
            task.wait(0.5)
            u100.Text = ""
        end)
        local function u116(p112, p113, p114) --[[ Line: 410 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u80
                [3] = u18
                [4] = u106
                [5] = u75
            --]]
            script["RBLX UI Purchase (SFX)"]:Play()
            local v115 = u19:GetAttribute("GiftTo")
            if v115 ~= nil and u80 ~= nil then
                if p112.CanGift == false then
                    u18.DisplayMessage("<Color=Red>This bundle can not be gifted!")
                    return
                end
                if u80.Name ~= v115 then
                    u18.DisplayMessage("<Color=Red> An issue occured. Please reselect a player to gift!")
                    return
                end
                if u80:GetAttribute("ProcessPromptPurchase") == true then
                    u18.DisplayMessage("<Color=Red>Can not gift Player that is in shop prompt!")
                    return
                end
            end
            if p112.isPaidRandomItem == true and u106.ArePaidRandomItemsRestricted == true then
                u18.DisplayMessage("<Color=Red>Your region policies do not allow you to buy this product!")
                return
            elseif p114 and p114() == true then
                u75:FireServer("dealQualify", p113)
            elseif p112.Callback(u19, u80) then
                u75:FireServer("PromptPurchase", {})
            end
        end
        local u117 = {}
        local u118 = 0
        local u119 = {}
        local u121 = {
            ["Starter Pack #1"] = function(p120, _) --[[ Line: 480 ]]
                --[[
                Upvalues:
                    [1] = u101
                    [2] = u76
                    [3] = u6
                    [4] = u119
                    [5] = u117
                    [6] = u118
                    [7] = u94
                    [8] = u93
                --]]
                if u101[p120.Name].PurchaseLimit == u6:JSONDecode(u76.Products.PurchaseLimits.Value)[p120.Name] then
                    p120.Visible = false
                    p120:SetAttribute("LimitReached", true)
                    if u119[p120] then
                        u119[p120]:Disconnect()
                        u119[p120] = nil
                    end
                    if u117[p120] ~= nil then
                        u117[p120] = nil
                        u118 = u118 - 1
                    end
                    if u118 <= 0 then
                        u94.Visible = false
                        u93.Visible = false
                        return
                    end
                    u94.Visible = true
                    u93.Visible = true
                end
            end
        }
        local u127 = {
            ["Starter Pack #1"] = function(u122) --[[ Line: 505 ]]
                --[[
                Upvalues:
                    [1] = u101
                    [2] = u79
                    [3] = u117
                    [4] = u118
                    [5] = u94
                    [6] = u93
                    [7] = u119
                --]]
                local u123 = u101[u122.Name].LevelLimit
                if u122:GetAttribute("LimitReached") then
                    return
                elseif u123 < u79.Value then
                    u122.Visible = false
                else
                    local function v126() --[[ Line: 519 ]]
                        --[[
                        Upvalues:
                            [1] = u122
                            [2] = u79
                            [3] = u123
                            [4] = u117
                            [5] = u118
                            [6] = u94
                            [7] = u93
                            [8] = u119
                        --]]
                        u122.Visible = u79.Value <= u123
                        if u123 < u79.Value then
                            local v124 = u122
                            if u117[v124] ~= nil then
                                u117[v124] = nil
                                u118 = u118 - 1
                            end
                            if u118 <= 0 then
                                u94.Visible = false
                                u93.Visible = false
                            else
                                u94.Visible = true
                                u93.Visible = true
                            end
                            u122:SetAttribute("LimitReached", true)
                            if u119[u122] then
                                u119[u122]:Disconnect()
                                u119[u122] = nil
                                return
                            end
                        else
                            local v125 = u122
                            if u117[v125] == nil then
                                u117[v125] = true
                                u118 = u118 + 1
                            end
                            if u118 <= 0 then
                                u94.Visible = false
                                u93.Visible = false
                                return
                            end
                            u94.Visible = true
                            u93.Visible = true
                        end
                    end
                    v126()
                    u119[u122] = u79:GetPropertyChangedSignal("Value"):Connect(v126)
                end
            end
        }
        local function v141(u128) --[[ Line: 542 ]]
            --[[
            Upvalues:
                [1] = u101
                [2] = u121
                [3] = u127
                [4] = u117
                [5] = u118
                [6] = u94
                [7] = u93
                [8] = u63
                [9] = u67
                [10] = u16
                [11] = u15
                [12] = u116
            --]]
            local u129 = u101[u128.Name]
            if u129 == nil then
                warn("Missing ProductData for", u129)
                return
            else
                if u129.PurchaseLimit then
                    u121[u128.Name](u128)
                end
                if u127[u128.Name] then
                    u127[u128.Name](u128)
                end
                if u128.Visible == false then
                    if u117[u128] ~= nil then
                        u117[u128] = nil
                        u118 = u118 - 1
                    end
                    if u118 <= 0 then
                        u94.Visible = false
                        u93.Visible = false
                    else
                        u94.Visible = true
                        u93.Visible = true
                    end
                else
                    if u129.CanGift == false then
                        local u130 = nil
                        u130 = script:GetAttributeChangedSignal("Gifting"):Connect(function() --[[ Line: 567 ]]
                            --[[
                            Upvalues:
                                [1] = u128
                                [2] = u117
                                [3] = u118
                                [4] = u94
                                [5] = u93
                                [6] = u130
                            --]]
                            if u128:GetAttribute("LimitReached") then
                                local v131 = u128
                                if u117[v131] ~= nil then
                                    u117[v131] = nil
                                    u118 = u118 - 1
                                end
                                if u118 <= 0 then
                                    u94.Visible = false
                                    u93.Visible = false
                                else
                                    u94.Visible = true
                                    u93.Visible = true
                                end
                                u130:Disconnect()
                                u130 = nil
                                return
                            elseif script:GetAttribute("Gifting") == true then
                                local v132 = u128
                                if u117[v132] ~= nil then
                                    u117[v132] = nil
                                    u118 = u118 - 1
                                end
                                if u118 <= 0 then
                                    u94.Visible = false
                                    u93.Visible = false
                                else
                                    u94.Visible = true
                                    u93.Visible = true
                                end
                            else
                                local v133 = u128
                                if u117[v133] == nil then
                                    u117[v133] = true
                                    u118 = u118 + 1
                                end
                                if u118 <= 0 then
                                    u94.Visible = false
                                    u93.Visible = false
                                else
                                    u94.Visible = true
                                    u93.Visible = true
                                end
                            end
                        end)
                    end
                    local u134 = u128.PriceBox.RobuxPrice
                    local u135 = u128.MPText
                    if u129.PurchaseLimit then
                        u135.Text = ("%*/%* Purchase Limit"):format(0, u129.PurchaseLimit)
                    end
                    if u129.endTime then
                        task.spawn(function() --[[ Line: 596 ]]
                            --[[
                            Upvalues:
                                [1] = u129
                                [2] = u128
                                [3] = u117
                                [4] = u118
                                [5] = u94
                                [6] = u93
                                [7] = u135
                                [8] = u63
                            --]]
                            while true do
                                local v136 = u129.endTime - os.time()
                                if v136 <= 0 then
                                    break
                                end
                                u135.Text = "Sale Ends: " .. u63(v136)
                                task.wait(1)
                            end
                            u128.Visible = false
                            local v137 = u128
                            if u117[v137] ~= nil then
                                u117[v137] = nil
                                u118 = u118 - 1
                            end
                            if u118 <= 0 then
                                u94.Visible = false
                                u93.Visible = false
                            else
                                u94.Visible = true
                                u93.Visible = true
                            end
                        end)
                    end
                    u134.Text = ("%*"):format(u67(nil) or "?")
                    local function u140() --[[ Line: 618 ]]
                        --[[
                        Upvalues:
                            [1] = u16
                            [2] = u15
                            [3] = u128
                            [4] = u134
                            [5] = u67
                            [6] = u140
                        --]]
                        u16.PromiseGetProductInfo(u15:GetProductIdByPlace(u128.Name), Enum.InfoType.Product):Then(function(p138) --[[ Line: 619 ]]
                            --[[
                            Upvalues:
                                [1] = u134
                                [2] = u67
                                [3] = u140
                            --]]
                            u134.Text = ("%*"):format(u67(p138.PriceInRobux) or "?")
                            task.wait(120 + math.random(60))
                            u140()
                        end):Catch(function(p139) --[[ Line: 625 ]]
                            --[[
                            Upvalues:
                                [1] = u140
                            --]]
                            warn(p139)
                            task.wait(30)
                            u140()
                        end)
                    end
                    task.spawn(u140)
                    u128.MouseButton1Click:Connect(function() --[[ Line: 669 ]]
                        --[[
                        Upvalues:
                            [1] = u116
                            [2] = u129
                            [3] = u128
                        --]]
                        u116(u129, u128.Name, nil)
                    end)
                    return
                end
            end
        end
        local u142 = u80
        local v143 = u118
        for _, v144 in ipairs(u94:GetChildren()) do
            if v144:IsA("ImageButton") then
                v141(v144)
            end
        end
        if v143 <= 0 then
            u94.Visible = false
            u93.Visible = false
        else
            u94.Visible = true
            u93.Visible = true
        end
        u24.OnClientEvent:Connect(function(p145) --[[ Line: 683 ]]
            --[[
            Upvalues:
                [1] = u121
                [2] = u94
            --]]
            local v146 = p145.Action
            local v147 = p145.Data
            if v146 == "ProductPurchased" and u121[v147.ProductName] then
                u121[v147.ProductName](u94:FindFirstChild(v147.ProductName), true)
            end
        end)
        local function v165(u148) --[[ Line: 697 ]]
            --[[
            Upvalues:
                [1] = u101
                [2] = u67
                [3] = u16
                [4] = u15
                [5] = u76
                [6] = u63
                [7] = u116
            --]]
            local u149 = u101[u148.Name]
            if u149 == nil then
                warn("Missing ProductData for", u148)
            else
                local v150 = u149.hasDeal
                local u151 = u148.PriceBox.RobuxPrice
                local u152 = false
                if u152 ~= true then
                    u151.Text = ("%*"):format(u67(nil) or "?")
                end
                local function u156() --[[ Line: 722 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u15
                        [3] = u148
                        [4] = u152
                        [5] = u151
                        [6] = u67
                        [7] = u156
                    --]]
                    u16.PromiseGetProductInfo(u15:GetProductIdByPlace(u148.Name), Enum.InfoType.Product):Then(function(p153) --[[ Line: 723 ]]
                        --[[
                        Upvalues:
                            [1] = u152
                            [2] = u151
                            [3] = u67
                            [4] = u156
                        --]]
                        local v154 = p153.PriceInRobux
                        if u152 ~= true then
                            u151.Text = ("%*"):format(u67(v154) or "?")
                        end
                        task.wait(120 + math.random(60))
                        u156()
                    end):Catch(function(p155) --[[ Line: 729 ]]
                        --[[
                        Upvalues:
                            [1] = u156
                        --]]
                        warn(p155)
                        task.wait(30)
                        u156()
                    end)
                end
                if v150 ~= nil and v150.Active == true then
                    local u157 = v150.PurchaseCount
                    local u158 = script.Deal:Clone()
                    u158.Parent = u148
                    u158.Position = UDim2.new(0.75, 0, 0.5, 0)
                    u158.Size = UDim2.new(0.2, 0, 1, 0)
                    u158.Desc.Text = ("BUY %*, GET %* FREE!"):format(u157, v150.bonusCount)
                    local function v162() --[[ Line: 743 ]]
                        --[[
                        Upvalues:
                            [1] = u148
                            [2] = u76
                            [3] = u157
                            [4] = u152
                            [5] = u151
                            [6] = u156
                            [7] = u158
                        --]]
                        local v159 = u148.Name
                        local v160 = game:GetService("HttpService"):JSONDecode(u76.Products.PurchaseDeals.Value)
                        local v161 = not (v160 and v160[v159]) and 0 or v160[v159]
                        if u157 <= v161 then
                            u152 = true
                            u151.Text = "FREE"
                        elseif u152 == true then
                            u152 = false
                            task.spawn(u156)
                        end
                        u158.Progress.Text = v161 .. "/" .. u157
                    end
                    v162()
                    u76.Products.PurchaseDeals.Changed:Connect(v162)
                end
                task.spawn(u156)
                local u163 = u149.endTime and u148:FindFirstChild("MPText")
                if u163 then
                    task.spawn(function() --[[ Line: 807 ]]
                        --[[
                        Upvalues:
                            [1] = u149
                            [2] = u148
                            [3] = u163
                            [4] = u63
                        --]]
                        while true do
                            local v164 = u149.endTime - os.time()
                            if v164 <= 0 then
                                break
                            end
                            u163.Text = "Sale Ends: " .. u63(v164)
                            task.wait(1)
                        end
                        u148.Visible = false
                    end)
                end
                u148.MouseButton1Click:Connect(function() --[[ Line: 823 ]]
                    --[[
                    Upvalues:
                        [1] = u116
                        [2] = u149
                        [3] = u148
                        [4] = u152
                    --]]
                    u116(u149, u148.Name, function() --[[ Line: 824 ]]
                        --[[
                        Upvalues:
                            [1] = u152
                        --]]
                        return u152
                    end)
                end)
            end
        end
        for _, v166 in ipairs(v84:GetChildren()) do
            if v166:GetAttribute("isTopSeller") == true then
                v165(v166)
            end
        end
        local u167 = {}
        local function v190(p168) --[[ Line: 879 ]]
            --[[
            Upvalues:
                [1] = u107
                [2] = u101
                [3] = u167
                [4] = u15
                [5] = u67
                [6] = u16
                [7] = u76
                [8] = u102
                [9] = u105
                [10] = u116
            --]]
            for _, u169 in ipairs(p168:GetChildren()) do
                if u169:IsA("Frame") then
                    if u169.Name:find("Ignore") then
                        local v170 = u107
                        table.insert(v170, u169)
                    else
                        local u171 = u101[u169.Name]
                        if u171 == nil then
                            warn("Missing ProductData for", u171)
                        else
                            if u171.Ads ~= nil then
                                u167[u169.Name] = u169
                            end
                            local v172 = u171.hasDeal
                            local v173 = u169.Main
                            local v174 = v173.Button
                            local u175 = v173.PriceBox.RobuxPrice
                            local u176 = false
                            local u177 = u15:GetProductIdByPlace(u169.Name)
                            if u176 ~= true then
                                u175.Text = ("%*"):format(u67(nil) or "?")
                            end
                            local function u181() --[[ Line: 918 ]]
                                --[[
                                Upvalues:
                                    [1] = u16
                                    [2] = u177
                                    [3] = u169
                                    [4] = u176
                                    [5] = u175
                                    [6] = u67
                                    [7] = u181
                                --]]
                                u16.PromiseGetProductInfo(u177, Enum.InfoType.Product):Then(function(p178) --[[ Line: 919 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u169
                                        [2] = u176
                                        [3] = u175
                                        [4] = u67
                                        [5] = u181
                                    --]]
                                    if p178.PriceInRobux >= 999999 then
                                        u169.Visible = false
                                    else
                                        local v179 = p178.PriceInRobux
                                        if u176 ~= true then
                                            u175.Text = ("%*"):format(u67(v179) or "?")
                                        end
                                        task.wait(120 + math.random(60))
                                        u181()
                                    end
                                end):Catch(function(p180) --[[ Line: 929 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u181
                                    --]]
                                    warn(p180)
                                    task.wait(30)
                                    u181()
                                end)
                            end
                            task.spawn(u181)
                            if v172 ~= nil and v172.Active == true then
                                local u182 = v172.PurchaseCount
                                local u183 = script.Deal:Clone()
                                u183.Parent = v173
                                u183.Desc.Text = ("BUY %*, GET %* FREE!"):format(u182, v172.bonusCount)
                                local function v187() --[[ Line: 943 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u169
                                        [2] = u76
                                        [3] = u182
                                        [4] = u176
                                        [5] = u175
                                        [6] = u181
                                        [7] = u183
                                    --]]
                                    local v184 = u169.Name
                                    local v185 = game:GetService("HttpService"):JSONDecode(u76.Products.PurchaseDeals.Value)
                                    local v186 = not (v185 and v185[v184]) and 0 or v185[v184]
                                    if u182 <= v186 then
                                        u176 = true
                                        u175.Text = "FREE"
                                    elseif u176 == true then
                                        u176 = false
                                        task.spawn(u181)
                                    end
                                    u183.Progress.Text = v186 .. "/" .. u182
                                end
                                v187()
                                u76.Products.PurchaseDeals.Changed:Connect(v187)
                            end
                            if u171.CanGift == false then
                                script:GetAttributeChangedSignal("Gifting"):Connect(function() --[[ Line: 968 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u169
                                        [2] = u102
                                    --]]
                                    if script:GetAttribute("Gifting") == true then
                                        u169.Visible = false
                                        return
                                    else
                                        local v188 = u102[u169.Name]
                                        if v188 == nil then
                                            u169.Visible = true
                                        else
                                            u169.Visible = v188()
                                        end
                                    end
                                end)
                            end
                            local v189 = u105[u169.Name]
                            if v189 then
                                v189(u169)
                            end
                            v174.MouseButton1Click:Connect(function() --[[ Line: 1019 ]]
                                --[[
                                Upvalues:
                                    [1] = u116
                                    [2] = u171
                                    [3] = u169
                                    [4] = u176
                                --]]
                                u116(u171, u169.Name, function() --[[ Line: 1020 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u176
                                    --]]
                                    return u176
                                end)
                            end)
                            task.wait()
                        end
                    end
                end
            end
        end
        v190(u85)
        v190(u86)
        v190(u87)
        task.spawn(function() --[[ Line: 1036 ]]
            --[[
            Upvalues:
                [1] = u85
                [2] = u86
                [3] = u87
                [4] = u101
                [5] = u15
                [6] = u2
                [7] = u90
                [8] = u67
                [9] = u16
                [10] = u6
                [11] = u76
                [12] = u116
                [13] = u91
            --]]
            local v191 = { u85, u86, u87 }
            local u192 = {}
            local v193 = {}
            for _, v194 in ipairs(v191) do
                for _, v195 in ipairs(v194:GetChildren()) do
                    if v195:IsA("Frame") and not (v195.Name:find("Ignore") or v195:GetAttribute("isTopSeller")) then
                        local v196 = u101[v195.Name]
                        if v196 and not v196.IsSub then
                            local v197 = u15:GetProductIdByPlace(v195.Name)
                            if v197 then
                                local v198 = {
                                    ["InfoType"] = Enum.InfoType.Product,
                                    ["Id"] = v197
                                }
                                table.insert(u192, v198)
                                v193[v197] = v195
                            end
                        end
                    end
                end
            end
            if #u192 == 0 then
                return
            end
            local v199, v200 = pcall(function() --[[ Line: 1083 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u192
                --]]
                return u2:RankProductsAsync(u192)
            end)
            if not v199 then
                warn("Failed to get ranked products for Recommended:", v200)
                return
            end
            local v201 = 0
            for _, v202 in ipairs(v200) do
                if v201 >= 6 then
                    break
                end
                local u203 = v193[v202.ProductIdentifier.Id]
                if u203 and u203.Visible then
                    local u204 = u101[u203.Name]
                    if u204 then
                        local u205 = u203:Clone()
                        u205.LayoutOrder = v201
                        u205.Parent = u90
                        local v206 = u205.Main
                        local v207 = v206.Button
                        local u208 = v206.PriceBox.RobuxPrice
                        local u209 = u15:GetProductIdByPlace(u203.Name)
                        for _, v210 in ipairs(v207:GetChildren()) do
                            if v210:IsA("BindableEvent") then
                                v210:Destroy()
                            end
                        end
                        local u211 = false
                        local v212 = u204.hasDeal
                        local function u216() --[[ Line: 1141 ]]
                            --[[
                            Upvalues:
                                [1] = u16
                                [2] = u209
                                [3] = u205
                                [4] = u211
                                [5] = u208
                                [6] = u67
                                [7] = u216
                            --]]
                            u16.PromiseGetProductInfo(u209, Enum.InfoType.Product):Then(function(p213) --[[ Line: 1142 ]]
                                --[[
                                Upvalues:
                                    [1] = u205
                                    [2] = u211
                                    [3] = u208
                                    [4] = u67
                                    [5] = u216
                                --]]
                                if p213.PriceInRobux >= 999999 then
                                    u205.Visible = false
                                else
                                    local v214 = p213.PriceInRobux
                                    if not u211 then
                                        u208.Text = ("%*"):format(u67(v214) or "?")
                                    end
                                    task.wait(120 + math.random(60))
                                    u216()
                                end
                            end):Catch(function(p215) --[[ Line: 1152 ]]
                                --[[
                                Upvalues:
                                    [1] = u216
                                --]]
                                warn(p215)
                                task.wait(30)
                                u216()
                            end)
                        end
                        task.spawn(u216)
                        local v217 = v206:FindFirstChild("Deal")
                        if v217 then
                            v217:Destroy()
                        end
                        if v212 ~= nil and v212.Active == true then
                            local u218 = v212.PurchaseCount
                            local u219 = script.Deal:Clone()
                            u219.Parent = v206
                            u219.Desc.Text = ("BUY %*, GET %* FREE!"):format(u218, v212.bonusCount)
                            local function v222() --[[ Line: 1173 ]]
                                --[[
                                Upvalues:
                                    [1] = u6
                                    [2] = u76
                                    [3] = u203
                                    [4] = u218
                                    [5] = u211
                                    [6] = u208
                                    [7] = u216
                                    [8] = u219
                                --]]
                                local v220 = u6:JSONDecode(u76.Products.PurchaseDeals.Value)
                                local v221 = not (v220 and v220[u203.Name]) and 0 or v220[u203.Name]
                                if u218 <= v221 then
                                    u211 = true
                                    u208.Text = "FREE"
                                elseif u211 == true then
                                    u211 = false
                                    task.spawn(u216)
                                end
                                u219.Progress.Text = v221 .. "/" .. u218
                            end
                            v222()
                            u76.Products.PurchaseDeals.Changed:Connect(v222)
                        end
                        if u204.CanGift == false then
                            script:GetAttributeChangedSignal("Gifting"):Connect(function() --[[ Line: 1194 ]]
                                --[[
                                Upvalues:
                                    [1] = u205
                                --]]
                                if script:GetAttribute("Gifting") == true then
                                    u205.Visible = false
                                else
                                    u205.Visible = true
                                end
                            end)
                        end
                        v207.MouseButton1Click:Connect(function() --[[ Line: 1203 ]]
                            --[[
                            Upvalues:
                                [1] = u116
                                [2] = u204
                                [3] = u203
                                [4] = u211
                            --]]
                            u116(u204, u203.Name, function() --[[ Line: 1204 ]]
                                --[[
                                Upvalues:
                                    [1] = u211
                                --]]
                                return u211
                            end)
                        end)
                        v201 = v201 + 1
                    else
                        warn("Recommended: No DevProductData for", u203.Name)
                    end
                end
            end
            if v201 > 0 then
                u90.Visible = true
                u91.Visible = true
            end
        end)
        local function u224() --[[ Line: 1216 ]]
            --[[
            Upvalues:
                [1] = u88
            --]]
            for _, v223 in ipairs(u88:GetChildren()) do
                if v223:IsA("Frame") then
                    v223:Destroy()
                end
            end
        end
        local function u235() --[[ Line: 1224 ]]
            --[[
            Upvalues:
                [1] = u224
                [2] = u27
                [3] = u28
                [4] = u88
                [5] = u89
                [6] = u167
                [7] = u101
                [8] = u15
                [9] = u30
                [10] = u36
                [11] = u76
                [12] = u22
            --]]
            u224()
            if u27 and #u28 ~= 0 then
                u88.Visible = true
                u89.Visible = true
                for _, u225 in ipairs(u28) do
                    local v226 = u167[u225]
                    if v226 then
                        local v227 = u101[u225]
                        if v227 then
                            local u228 = u15:GetProductIdByPlace(u225)
                            local u229 = v227.Ads.LevelRequirement or 0
                            local u230 = u30[u225]
                            local v231 = v226:Clone()
                            v231.Name = u225
                            v231.Parent = u88
                            local v232 = v231.Main
                            local u233 = v232.Button
                            v232.PriceBox.RobuxPrice.Text = "FREE"
                            for _, v234 in ipairs(u233:GetChildren()) do
                                if v234:IsA("BindableEvent") then
                                    v234:Destroy()
                                end
                            end
                            task.spawn(function() --[[ Line: 1268 ]]
                                --[[
                                Upvalues:
                                    [1] = u36
                                    [2] = u233
                                    [3] = u225
                                --]]
                                u36(u233, u225)
                            end)
                            u233.MouseButton1Click:Connect(function() --[[ Line: 1272 ]]
                                --[[
                                Upvalues:
                                    [1] = u76
                                    [2] = u229
                                    [3] = u22
                                    [4] = u228
                                    [5] = u230
                                --]]
                                script["RBLX UI Purchase (SFX)"]:Play()
                                if u76.Stats.Level.Value < u229 then
                                    _G.displayMessage((("<Color=Red>You need to be Level %* to redeem this!"):format(u229)))
                                else
                                    u22:FireServer(u228, u230)
                                end
                            end)
                        end
                    end
                end
            else
                u88.Visible = false
                u89.Visible = false
            end
        end
        task.spawn(function() --[[ Line: 1285 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u235
            --]]
            while true do
                u26:Wait()
                u235()
            end
        end);
        (function(p236) --[[ Name: SetupGamepassCategory, Line 1293 ]]
            --[[
            Upvalues:
                [1] = u107
                [2] = u16
                [3] = u105
                [4] = u18
                [5] = u19
                [6] = u2
            --]]
            for _, u237 in ipairs(p236:GetChildren()) do
                if u237:IsA("Frame") then
                    if u237.Name:find("Ignore") then
                        local v238 = u107
                        table.insert(v238, u237)
                    else
                        local v239 = u237.Main
                        local v240 = v239.Button
                        local u241 = v239.PriceBox.RobuxPrice
                        u241.Text = "?"
                        local u242 = u237:GetAttribute("GamepassId")
                        if u242 == nil then
                            warn("Missing GamepassId")
                        else
                            local function u245() --[[ Line: 1321 ]]
                                --[[
                                Upvalues:
                                    [1] = u16
                                    [2] = u242
                                    [3] = u241
                                    [4] = u245
                                --]]
                                u16.PromiseGetProductInfo(u242, Enum.InfoType.GamePass):Then(function(p243) --[[ Line: 1323 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u241
                                        [2] = u245
                                    --]]
                                    u241.Text = ("%*"):format(p243.PriceInRobux or "?")
                                    task.wait(120 + math.random(60))
                                    u245()
                                end):Catch(function(p244) --[[ Line: 1329 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u245
                                    --]]
                                    warn(p244)
                                    task.wait(30)
                                    u245()
                                end)
                            end
                            task.spawn(u245)
                            local v246 = u105[u237.Name]
                            if v246 then
                                v246(u237)
                            end
                            script:GetAttributeChangedSignal("Gifting"):Connect(function() --[[ Line: 1344 ]]
                                --[[
                                Upvalues:
                                    [1] = u237
                                --]]
                                if script:GetAttribute("Gifting") == true then
                                    u237.Visible = false
                                else
                                    u237.Visible = true
                                end
                            end)
                            local u247 = false
                            local function v251() --[[ Line: 1353 ]]
                                --[[
                                Upvalues:
                                    [1] = u247
                                    [2] = u18
                                    [3] = u237
                                    [4] = u16
                                    [5] = u19
                                    [6] = u242
                                    [7] = u2
                                --]]
                                if u247 then
                                    u18.DisplayMessage((("<Color=Red>You already own %*!"):format(u237.Name)))
                                    return
                                else
                                    local v248 = u16.promiseUserOwnsGamePass(u19.UserId, u242)
                                    v248:Yield()
                                    local v249, v250 = v248:GetResults()
                                    if v249 then
                                        if v250 == false then
                                            u2:PromptGamePassPurchase(u19, u242)
                                        else
                                            u247 = true
                                            u18.DisplayMessage((("<Color=Red>You already own %*!"):format(u237.Name)))
                                        end
                                        script["RBLX UI Purchase (SFX)"]:Play()
                                    end
                                end
                            end
                            v240.MouseButton1Click:Connect(v251)
                            task.wait()
                        end
                    end
                end
            end
        end)(v92)
        local u252 = {}
        (function(p253) --[[ Name: SetupSubscriptionCategory, Line 1392 ]]
            --[[
            Upvalues:
                [1] = u101
                [2] = u8
                [3] = u106
                [4] = u23
                [5] = u2
                [6] = u252
                [7] = u18
                [8] = u19
            --]]
            for _, u254 in ipairs(p253:GetChildren()) do
                if u254:IsA("ImageButton") then
                    local v255 = u101[u254.Name]
                    if v255 == nil or not v255.IsSub then
                        warn("not valid in data")
                    else
                        local u256
                        if u8 then
                            u256 = v255.Test
                        else
                            local v257 = v255.Main
                            u256 = tostring(v257)
                        end
                        local v258 = u254:WaitForChild("PriceBox")
                        local u259 = v258:WaitForChild("RobuxPrice")
                        local u260 = v258:FindFirstChild("Icon")
                        if u106 and u106.IsEligibleToPurchaseSubscription == false then
                            u254.Visible = false
                            warn("cant show subscriptions")
                        else
                            if v255.CanGift == false then
                                script:GetAttributeChangedSignal("Gifting"):Connect(function() --[[ Line: 1417 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u254
                                    --]]
                                    if script:GetAttribute("Gifting") == true then
                                        u254.Visible = false
                                    else
                                        u254.Visible = true
                                    end
                                end)
                            end
                            task.spawn(function() --[[ Line: 1443 ]]
                                --[[
                                Upvalues:
                                    [1] = u23
                                    [2] = u256
                                    [3] = u2
                                    [4] = u259
                                    [5] = u260
                                --]]
                                local v261 = nil
                                local v262 = nil
                                local v263, v264 = pcall(function() --[[ Line: 1448 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u23
                                        [2] = u256
                                    --]]
                                    return u23:InvokeServer(u256)
                                end)
                                if not v263 then
                                    v264 = false
                                end
                                if not v264 then
                                    local v265, v266 = pcall(function() --[[ Line: 1457 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u2
                                            [2] = u256
                                        --]]
                                        return u2:GetSubscriptionProductInfoAsync(u256)
                                    end)
                                    if v265 and v266 then
                                        v261 = v266.DisplayPrice
                                        v262 = v266.PriceInRobux
                                    end
                                end
                                if v264 then
                                    u259.Text = "SUBSCRIBED"
                                    if u260 then
                                        u260.Visible = false
                                        return
                                    end
                                elseif v261 then
                                    u259.Text = v261 .. "/ mo"
                                    if v262 == nil then
                                        if u260 then
                                            u260.Visible = false
                                        end
                                        u259.TextColor3 = Color3.fromRGB(0, 255, 127)
                                    end
                                end
                            end)
                            u252[u256] = function() --[[ Name: checkOwnership, Line 1470 ]]
                                --[[
                                Upvalues:
                                    [1] = u23
                                    [2] = u256
                                    [3] = u259
                                    [4] = u260
                                --]]
                                task.spawn(function() --[[ Line: 1471 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u23
                                        [2] = u256
                                        [3] = u259
                                        [4] = u260
                                    --]]
                                    local v267, v268 = pcall(function() --[[ Line: 1474 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u23
                                            [2] = u256
                                        --]]
                                        return u23:InvokeServer(u256)
                                    end)
                                    if not v267 then
                                        v268 = false
                                    end
                                    if v268 then
                                        u259.Text = "SUBSCRIBED"
                                        if u260 then
                                            u260.Visible = false
                                            return
                                        end
                                    end
                                end)
                            end
                            u254.MouseButton1Click:Connect(function() --[[ Line: 1489 ]]
                                --[[
                                Upvalues:
                                    [1] = u23
                                    [2] = u256
                                    [3] = u18
                                    [4] = u254
                                    [5] = u19
                                    [6] = u2
                                --]]
                                script["RBLX UI Purchase (SFX)"]:Play()
                                local v269, v270 = pcall(function() --[[ Line: 1492 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u23
                                        [2] = u256
                                    --]]
                                    return u23:InvokeServer(u256)
                                end)
                                if v269 and v270 == true then
                                    u18.DisplayMessage("<Color=Green>You already own this subscription!")
                                else
                                    if u254.Name == "Unlimited Free Tailoring" then
                                        local u271 = nil
                                        local v272 = _G.promptQuestion
                                        local v273 = u19
                                        local v274 = {
                                            ["Accept"] = {
                                                ["Color"] = Color3.fromRGB(0, 200, 0),
                                                ["LayoutOrder"] = 1,
                                                ["Function"] = function() --[[ Name: Function, Line 1508 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u271
                                                    --]]
                                                    u271 = true
                                                end
                                            },
                                            ["Cancel"] = {
                                                ["Color"] = Color3.fromRGB(255, 0, 0),
                                                ["LayoutOrder"] = 2,
                                                ["Function"] = function() --[[ Name: Function, Line 1515 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u271
                                                    --]]
                                                    u271 = false
                                                end
                                            }
                                        }
                                        v272(v273, "<font color=\"#FFAA00\"><b>Notice</b></font>\nThe Unlimited Tailor subscription applies strictly to <font color=\"#FFAA00\">outfits and accessories only</font>, and <font color=\"#FF0000\">does not apply to weapons or fruits</font>.", v274, nil, nil, {
                                            ["ScaleWithText"] = true
                                        })
                                        repeat
                                            task.wait()
                                        until u271 ~= nil
                                        if not u271 then
                                            return
                                        end
                                    end
                                    local v275, v276 = pcall(function() --[[ Line: 1524 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u2
                                            [2] = u19
                                            [3] = u256
                                        --]]
                                        u2:PromptSubscriptionPurchase(u19, u256)
                                    end)
                                    if not v275 then
                                        u18.DisplayMessage("<Color=Red>Unable to prompt subscription purchase!")
                                        warn("Subscription prompt failed:", v276)
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end)((v84:WaitForChild("Subscriptions")))
        u1.UserSubscriptionStatusChanged:Connect(function(p277, p278) --[[ Line: 1538 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u252
            --]]
            if p277 == u19 and u252[p278] then
                u252[p278]()
            end
        end)
        u2.PromptSubscriptionPurchaseFinished:Connect(function(p279, p280, p281) --[[ Line: 1544 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u252
            --]]
            if p279 == u19 and (p281 and u252[p280]) then
                u252[p280]()
            end
        end)
        local function u283(p282) --[[ Line: 1551 ]]
            --[[
            Upvalues:
                [1] = u142
                [2] = u96
                [3] = u95
                [4] = u98
                [5] = u75
            --]]
            script:SetAttribute("Gifting", true)
            u142 = p282
            u96.Text = "Gifting " .. p282.DisplayName
            u96.Visible = true
            u95.Visible = false
            u98.Visible = false
            u75:FireServer("SetGiftedPlayer", {
                ["GiftTo"] = p282.Name
            })
        end
        u95.MouseButton1Click:Connect(function() --[[ Line: 1578 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
                [3] = u98
            --]]
            if u19:GetAttribute("ProcessPromptPurchase") == true then
                u18.DisplayMessage("<Color=Red> Please wait for previous purchase to process before gifting!")
            else
                u98.Visible = not u98.Visible
            end
        end)
        v97.MouseButton1Click:Connect(function() --[[ Line: 1588 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
                [3] = u142
                [4] = u95
                [5] = u96
                [6] = u75
            --]]
            if u19:GetAttribute("ProcessPromptPurchase") == true then
                u18.DisplayMessage("<Color=Red> Please wait for previous purchase to process!")
            else
                script:SetAttribute("Gifting", false)
                u142 = nil
                u95.Visible = true
                u96.Visible = false
                u75:FireServer("UnsetGiftedPlayer", {})
            end
        end)
        local function v291(u284) --[[ Line: 1606 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u81
                [3] = u1
                [4] = u99
                [5] = u12
                [6] = u5
                [7] = u18
                [8] = u283
            --]]
            if u284 == u19 then
                return
            else
                if u81[u284] ~= nil then
                    u81[u284]:Destroy()
                    u81[u284] = nil
                end
                if u284:IsDescendantOf(u1) then
                    local v285 = script.TemplateGreen:Clone()
                    v285.Name = u284.DisplayName
                    v285.Parent = u99
                    local v286 = v285:WaitForChild("PlayerName")
                    local v287 = v285:WaitForChild("PlayerDisplayName")
                    local u288 = v285:WaitForChild("AvatarBox"):WaitForChild("AvatarIcon")
                    v286.Text = ("@%*"):format(u284.Name)
                    v287.Text = u284.DisplayName
                    u12.PromiseUserThumbnail(u284.UserId):Then(function(p289) --[[ Line: 1627 ]]
                        --[[
                        Upvalues:
                            [1] = u288
                        --]]
                        u288.Image = p289
                    end):Catch(function(p290) --[[ Line: 1629 ]]
                        warn(p290)
                    end)
                    v285.MouseButton1Up:Connect(function() --[[ Line: 1633 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u284
                            [3] = u18
                            [4] = u283
                        --]]
                        if u5:FindFirstChild("Stats" .. u284.Name) then
                            u283(u284)
                        else
                            u18.DisplayMessage("<Color=Red> This player has not loaded yet!")
                        end
                    end)
                    u81[u284] = v285
                end
            end
        end
        local function v293(p292) --[[ Line: 1645 ]]
            --[[
            Upvalues:
                [1] = u142
                [2] = u18
                [3] = u95
                [4] = u96
                [5] = u75
                [6] = u81
            --]]
            if u142 ~= nil and u142 == p292 then
                u18.DisplayMessage("<Color=Red> The player you were gifting left the game!")
                script:SetAttribute("Gifting", false)
                u142 = nil
                u95.Visible = true
                u96.Visible = false
                u75:FireServer("UnsetGiftedPlayer", {})
            end
            if u81[p292] ~= nil then
                u81[p292]:Destroy()
                u81[p292] = nil
            end
        end
        for _, v294 in pairs(u1:GetPlayers()) do
            task.spawn(v291, v294)
        end
        u1.PlayerAdded:Connect(v291)
        u1.PlayerRemoving:Connect(v293)
        task.delay(5, function() --[[ Line: 1663 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u54
            --]]
            if u19.Character == nil then
                u19.CharacterAdded:Wait()
            end
            while _G.arena ~= true do
                u54(true)
                task.wait(20)
            end
            warn("Is in arena, breaking ads")
        end)
        u25.Initialized = true
    end
end
return u25