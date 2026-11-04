 

game:GetService("TweenService")
game:GetService("MarketplaceService")
local v1 = game:GetService("ReplicatedStorage")
local _ = game:GetService("Players").LocalPlayer
local v2 = v1.Modules
local v3 = v2.Shared
require(v3.CrewUtils)
local v4 = v2.Client
local u5 = require(v4.ItemDisplay)
return {
    ["Setup"] = function(p6, u7) --[[ Name: Setup, Line 17 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local u8 = p6.CrewsUI
        local u9 = p6.Frame
        local v10 = u9:WaitForChild("Frame")
        local u11 = v10:WaitForChild("Items")
        local u12 = u9:WaitForChild("ConquestPoints")
        local u13 = u9:WaitForChild("History")
        local u14 = v10:WaitForChild("History")
        local v15 = u9:WaitForChild("RefreshButton")
        u13.MouseButton1Click:Connect(function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u11
                [3] = u14
                [4] = u13
            --]]
            u7.UIUtils.ButtonEffect()
            u11.Visible = not u11.Visible
            u14.Visible = not u11.Visible
            u13.TextLabel.Text = u14.Visible and "Shop" or "Purchase History"
        end)
        local u16 = false
        v15.MouseButton1Click:Connect(function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u16
                [3] = u8
            --]]
            u7.UIUtils.ButtonEffect()
            if u16 ~= true then
                u16 = true
                local v17 = u8.Notify("Information", "Prompting shop reroll")
                local v18, v19 = u8.UIClient:GetRemote():InvokeServer({
                    ["Method"] = "ShopReroll"
                })
                u16 = false
                u8.RemoveNotification(v17, true)
                u8.Notify(v19 == nil and "Error" or "Success", v18)
            end
        end)
        local u20 = {}
        task.spawn(function() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            local v21 = u9:WaitForChild("Refresh")
            while true do
                os.date("!*t")
                local v22 = os.date("!*t", os.time() + 86400)
                local v23 = os.time({
                    ["year"] = v22.year,
                    ["month"] = v22.month,
                    ["day"] = v22.day,
                    ["hour"] = 0,
                    ["min"] = 0,
                    ["sec"] = 0
                }) - os.time()
                local v24 = (v23 - v23 % 60) / 60
                local v25 = v23 - v24 * 60
                local v26 = (v24 - v24 % 60) / 60
                local v27 = v24 - v26 * 60
                v21.Text = "\240\159\148\132 " .. string.format("%02i", v26) .. ":" .. string.format("%02i", v27) .. ":" .. string.format("%02i", v25)
                task.wait(1)
            end
        end)
        local u28 = {}
        function p6.UpdateLogs(_, p29) --[[ Line: 93 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u14
            --]]
            local v30 = p29.Purchases
            if v30 == nil then
                return
            else
                local v31 = v30.Shop
                if v31 ~= nil then
                    for _, v32 in pairs(u28) do
                        v32:Destroy()
                    end
                    for v33, v34 in pairs(v31) do
                        local v35 = game.HttpService:JSONDecode(v34)
                        local v36 = script.PurchaseTemplate:Clone()
                        v36.Name = v33
                        v36.LayoutOrder = -v33
                        v36.Parent = u14
                        local v37
                        if v35.Item == "Crew Shop Reroll" then
                            v37 = ("<font color=\"#FF7800\"> %s (%s) </font>purchased <font color=\"rgb(255,176,0)\">%s </font>on %s"):format(v35.PurchaseName or "", v35.PurchasedBy or "", v35.Item, v35.PurchasedDate)
                        else
                            v37 = ("<font color=\"#FF7800\"> %s (%s) </font>purchased <font color=\"rgb(255,176,0)\">%s </font><font color=\"#ddff02\">for %s Conquest Points</font> on %s"):format(v35.PurchaseName or "", v35.PurchasedBy or "", v35.Item, v35.Amount, v35.PurchasedDate)
                        end
                        v36.PurchaseInfo.Text = v37
                        local v38 = u28
                        table.insert(v38, v36)
                    end
                end
            end
        end
        local u39 = u5.new({
            ["Gui"] = u9.Parent.Parent.Parent,
            ["Trade"] = false
        })
        u9:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 139 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u39
            --]]
            if u9.Visible == true then
                u39:StartRotation()
            else
                u39:StopRotation()
            end
        end)
        function p6.UpdateShop(p40, p41) --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u20
                [3] = u11
                [4] = u39
                [5] = u7
                [6] = u8
            --]]
            if p41.Shop ~= nil then
                p40:UpdateLogs(p41)
                u12.Text = "<font color=\"rgb(255,176,0)\">Conquest Points: </font>" .. p41.ConquestPoints
                for _, v42 in pairs(u20) do
                    v42:Destroy()
                end
                for u43, u44 in pairs(p41.Shop) do
                    local u45 = script.ItemTemplate:Clone()
                    u45.Name = u43
                    u45.ItemName.Text = u43
                    u45.Cost.Text = "Cost - " .. u44.Price
                    u45.Available.Text = "Available - " .. u44.Available
                    u45.Parent = u11
                    task.spawn(function() --[[ Line: 167 ]]
                        --[[
                        Upvalues:
                            [1] = u39
                            [2] = u45
                            [3] = u43
                            [4] = u44
                        --]]
                        u39:AddItem(u45.Items, u43, u44.Available, 3)
                    end)
                    local u46 = false
                    u45.Buy.MouseButton1Click:Connect(function() --[[ Line: 172 ]]
                        --[[
                        Upvalues:
                            [1] = u46
                            [2] = u7
                            [3] = u8
                            [4] = u43
                        --]]
                        if u46 ~= true then
                            u46 = true
                            u7.UIUtils.ButtonEffect()
                            local v47 = u8.Notify("Information", "Purchasing " .. u43)
                            local v48 = {
                                ["Method"] = "Purchase",
                                ["PurchaseType"] = "CrewShopItem",
                                ["Item"] = u43
                            }
                            local v49, v50 = u8.UIClient:GetRemote():InvokeServer(v48)
                            u46 = false
                            u8.RemoveNotification(v47, true)
                            u8.Notify(v50 == nil and "Error" or "Success", v49)
                        end
                    end)
                    local v51 = u20
                    table.insert(v51, u45)
                end
            end
        end
    end
}