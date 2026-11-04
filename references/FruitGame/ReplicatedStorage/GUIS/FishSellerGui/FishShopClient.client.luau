 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1:WaitForChild("Modules")
local u4 = require(v3:WaitForChild("ToolDesc"):WaitForChild("ToolDescUtils"))
local v5 = v3:WaitForChild("Client")
local v6 = require(v5:WaitForChild("ItemDisplay"))
local v7 = v3:WaitForChild("Shared")
local u8 = require(v7:WaitForChild("GameUtils"))
local v9 = require(v5.UIController)
local u10 = v2.LocalPlayer
u8.GetStatsFolder(u10)
local u11 = script.Parent
local v12 = u11:WaitForChild("Main")
local u13 = v12:WaitForChild("Items"):WaitForChild("List")
local v14 = v12:WaitForChild("Close")
local u15 = v6.new({
    ["Gui"] = u11,
    ["Trade"] = false,
    ["UseUniqueId"] = false
})
local v16 = v9:GetStatsFolder():WaitForChild("Inventory"):WaitForChild("Inventory")
local u17 = v1:WaitForChild("FishingShopRemote")
local u18 = {}
local u19 = false
local function u27() --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u4
        [3] = u18
        [4] = u8
        [5] = u10
        [6] = u13
        [7] = u15
        [8] = u19
        [9] = u17
    --]]
    if u11.Enabled ~= false then
        for u20, u21 in pairs(u4.GetAllFishes()) do
            local v22 = u18[u20] or script.Template:Clone()
            local v23 = u8.CheckItemAmount(u10, u20)
            if u18[u20] == nil and _G.HasItem(u10, u20) == true then
                v22.Name = u20
                v22.LayoutOrder = _G.layoutMulti[u21.Rare]
                v22.Price.Text = ("%* Peli"):format(u21.Price)
                v22.Parent = u13
                u18[u20] = v22
                u15:AddItem(v22.Display, u20, v23 or 0, 3)
                v22.Visible = v23 > 0
                v22.Sell.MouseButton1Click:Connect(function() --[[ Line: 60 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u10
                        [3] = u20
                        [4] = u21
                        [5] = u17
                    --]]
                    if u19 ~= true then
                        u19 = true
                        local v24 = {
                            [true] = function() --[[ Line: 65 ]]
                                --[[
                                Upvalues:
                                    [1] = u17
                                    [2] = u20
                                    [3] = u19
                                --]]
                                u17:InvokeServer({
                                    ["Method"] = "SellFish",
                                    ["Fish"] = u20,
                                    ["All"] = false
                                })
                                u19 = false
                            end,
                            [false] = function() --[[ Line: 70 ]]
                                --[[
                                Upvalues:
                                    [1] = u19
                                --]]
                                u19 = false
                            end
                        }
                        _G.promptQuestion(u10, ("Sell 1 <font color=\"rgb(170, 255, 255)\">%*</font> for <font color=\"rgb(255, 255, 126)\">%* Peli</font>?"):format(u20, u21.Price), v24)
                    end
                end)
                v22.SellAll.MouseButton1Click:Connect(function() --[[ Line: 78 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u8
                        [3] = u10
                        [4] = u20
                        [5] = u21
                        [6] = u17
                    --]]
                    if u19 ~= true then
                        u19 = true
                        local v25 = u8.CheckItemAmount(u10, u20)
                        local v26 = {
                            [true] = function() --[[ Line: 84 ]]
                                --[[
                                Upvalues:
                                    [1] = u17
                                    [2] = u20
                                    [3] = u19
                                --]]
                                u17:InvokeServer({
                                    ["Method"] = "SellFish",
                                    ["Fish"] = u20,
                                    ["All"] = true
                                })
                                u19 = false
                            end,
                            [false] = function() --[[ Line: 89 ]]
                                --[[
                                Upvalues:
                                    [1] = u19
                                --]]
                                u19 = false
                            end
                        }
                        _G.promptQuestion(u10, ("Sell <b><font color=\"rgb(247,52,71)\">ALL [%*]</font></b> <font color=\"rgb(170, 255, 255)\">%*s</font> for <font color=\"rgb(255, 255, 126)\">%* Peli</font>?"):format(v25, u20, u21.Price * v25), v26)
                    end
                end)
            end
            u15:UpdateItem(u20, v23)
            v22.Visible = v23 > 0
        end
    end
end
v16:GetPropertyChangedSignal("Value"):Connect(u27)
v14.MouseButton1Down:Connect(function() --[[ Line: 105 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    u11.Enabled = false
end)
u11:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u15
        [3] = u27
    --]]
    if u11.Enabled == false then
        u15:StopRotation()
    else
        u15:StartRotation()
        u27()
    end
end)