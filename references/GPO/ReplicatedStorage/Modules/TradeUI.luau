 

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("UserInputService")
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local u5 = {}
local u6 = v1.LocalPlayer or v1.PlayerAdded:Wait()
local u7 = require(u3:WaitForChild("Modules"):WaitForChild("ToolDesc"))
local u8 = require(u3.Modules:WaitForChild("Module3D"))
local u9 = require(u3.Modules.MEnterLeave)
require(u3.Modules.LayoutUtil)
require(u3.Modules.Trove)
local u10 = {}
local u11 = {}
local u12 = {}
local u13 = {
    ["Uncommon"] = Color3.fromRGB(170, 255, 127),
    ["Rare"] = Color3.fromRGB(0, 255, 255),
    ["Legendary"] = Color3.fromRGB(170, 0, 255),
    ["Mythical"] = Color3.fromRGB(170, 0, 255)
}
local u14 = nil
local u15 = {}
local function u19(p16, p17) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u13
        [3] = u11
    --]]
    local v18 = u7[p17].Rare
    if v18 ~= "Common" then
        p16.Outter.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), u13[v18])
        if v18 == "Legendary" then
            p16.Outter.UIGradient.Color = script.Legend.Color
        elseif v18 == "Mythical" then
            p16.Outter.UIGradient.Color = script.Myth.Color
        elseif v18 == "Collectable" then
            p16.Outter.UIGradient.Color = script.Collectable.Color
        elseif v18 == "Epic" then
            p16.Outter.UIGradient.Color = script.Epic.Color
        end
        u11[p16.Outter.UIGradient] = p16.Outter.UIGradient
    end
end
local function u30(p20, p21) --[[ Line: 55 ]]
    local v22 = p21 == nil and 1 or p21
    local v23 = Vector2.new(0.025, 0.025)
    local v24 = Vector2.new(0.315, 0.315) * v22
    local v25 = p20.UIGridLayout
    local v26 = v24 * p20.AbsoluteSize
    local v27 = v23 * p20.AbsoluteSize
    local v28 = UDim2.new(0, v27.X, 0, v27.Y)
    local v29 = UDim2.new(0, v26.X, 0, v26.Y)
    if p20:IsA("ScrollingFrame") then
        v25.CellPadding = v28
        v25.CellSize = v29
        p20.CanvasSize = UDim2.new(0, v25.AbsoluteContentSize.X, 0, v25.AbsoluteContentSize.Y)
    end
end
local function u40(p31) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
        [3] = u7
        [4] = u12
    --]]
    local v32 = u3:FindFirstChild("Stats" .. u6.Name)
    local v33
    if p31 == nil then
        v33 = v32.Inventory.Inventory.Value
    else
        v33 = p31
    end
    local v34
    if typeof(v33) == "string" then
        v34 = game:GetService("HttpService"):JSONDecode(v33)
    else
        v34 = p31
    end
    local _ = p31 == nil
    local v35 = {}
    local v36 = {}
    for v37, v38 in pairs(v34) do
        if u7[v37] then
            local v39 = u7[v37].Type
            if _G.notAllowed[v39] == nil and (_G.bannedItems[v37] == nil and u7[v37].Untradeable == nil) then
                v35[v37] = v38
                table.insert(v36, v37)
            end
        end
    end
    if p31 == nil then
        u12 = v36
    end
    return v35, v34
end
local function u46(p41, p42) --[[ Line: 119 ]]
    local v43 = p41:GetChildren()
    local v44 = nil
    for v45 = 1, #v43 do
        if v43[v45]:IsA("Frame") and v43[v45]:GetAttribute("realItemName") == p42 then
            return v43[v45]
        end
    end
    return v44
end
_G.targetPlayerInventory = {}
_G.targetPlayer = nil
local function u67(u47, p48, p49, p50, p51) --[[ Line: 133 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u7
        [3] = u3
        [4] = u15
        [5] = u46
        [6] = u8
        [7] = u9
        [8] = u19
        [9] = u10
        [10] = u30
    --]]
    if _G.displayRareItem == nil then
        repeat
            task.wait()
        until _G.displayRareItem ~= nil
    end
    if p48 == nil then
        local v52
        v52, p48 = u40()
    else
        u40(p48)
    end
    for u53, v54 in pairs(p48) do
        if (u7[u53] == nil or u7[u53] ~= nil and _G.notAllowed[u7[u53].Type] ~= nil or (u3.Tools:FindFirstChild(u53) == nil or _G.targetPlayerInventory[u53] ~= nil and p49 ~= nil)) and (u7[u53] and u7[u53].Type == "Grip" and true or false) == false then
            warn("skipping", u53)
        elseif p49 and (u15 ~= nil and u15[u53] ~= nil) then
            if u47:FindFirstChild(u53) then
                u47:FindFirstChild(u53).Visible = false
            end
        else
            local v55 = u46(u47, u53)
            if v55 == nil then
                local u56 = script.Frame:Clone()
                u56.Name = u7[u53].Type
                u56:SetAttribute("realItemName", u53)
                local v57 = u3.Tools[u53]:Clone()
                local v58 = u8:Attach3D(u56.ItemFrame, v57)
                v58:SetDepthMultiplier(1)
                v58.Camera.FieldOfView = 50
                v58:SetActive(true)
                local v59 = u56.ItemFrame:WaitForChild("ViewportFrame", 1)
                if v59 then
                    v59.ZIndex = 5
                    v59.ClipsDescendants = true
                    v59.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
                end
                if p51 == nil then
                    p51 = u56
                end
                u56.Ammount.Text = "x" .. v54
                u56.Parent = u47
                if p49 == true and _G.targetPlayer ~= nil then
                    local v60 = u3:WaitForChild("Stats" .. _G.targetPlayer.Name, 3)
                    if u7[u53].tradeLevel ~= nil and v60.Stats.Level.Value < u7[u53].tradeLevel or (_G.bannedItems[u53] ~= nil or u7[u53].Untradeable ~= nil) then
                        u56.lock.Visible = true
                        if _G.bannedItems[u53] == nil and u7[u53].Untradeable == nil then
                            u56.lock.levelreq.Text = u7[u53].tradeLevel
                        else
                            u56.lock.levelreq.Text = "X"
                        end
                    end
                end
                local v61, v62 = u9.MouseEnterLeaveEvent(u56)
                u56.itemName.Text = u53
                _G.displayRareItem(u53, u56.itemName.ItemRare)
                if u7[u53].Type == "Grip" then
                    u56.itemName.Visible = true
                else
                    v61:Connect(function() --[[ Line: 208 ]]
                        --[[
                        Upvalues:
                            [1] = u56
                        --]]
                        u56.itemName.Visible = true
                    end)
                    v62:Connect(function() --[[ Line: 211 ]]
                        --[[
                        Upvalues:
                            [1] = u56
                        --]]
                        u56.itemName.Visible = false
                    end)
                end
                u19(u56, u53)
                if p49 == true then
                    local u63 = false
                    u56.FrameButton.InputBegan:Connect(function() --[[ Line: 221 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        u63 = true
                    end)
                    u56.FrameButton.InputEnded:Connect(function() --[[ Line: 225 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        u63 = false
                    end)
                    u56.FrameButton.Activated:Connect(function() --[[ Line: 233 ]]
                        --[[
                        Upvalues:
                            [1] = u53
                            [2] = u56
                            [3] = u47
                        --]]
                        local v64 = {
                            ["addItem"] = u53
                        }
                        _G.tradeRemote:FireServer(v64)
                        circleclick:Activate(u56.FrameButton)
                        local v65 = u47.Parent
                        v65.Items.Visible = true
                        v65.Inventory.Visible = false
                        v65.Outline.Outter.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        v65.SearchBar.Visible = false
                    end)
                end
                u10[u56] = { v58, p51 }
                u56.AncestryChanged:Connect(function() --[[ Line: 249 ]]
                    --[[
                    Upvalues:
                        [1] = u56
                        [2] = u10
                    --]]
                    if not u56:IsDescendantOf(game) then
                        u10[u56] = nil
                    end
                end)
            else
                v55.Ammount.Text = "x" .. v54
                v55.Visible = true
            end
        end
    end
    u30(u47, p50)
    for _, v66 in u47:GetChildren() do
        if v66:IsA("Frame") and p48[v66:GetAttribute("realItemName")] == nil then
            v66:Destroy()
        end
    end
end
function u5.displayTrade(_, p68, p69, p70, p71) --[[ Line: 263 ]]
    --[[
    Upvalues:
        [1] = u67
    --]]
    u67(p68, p69, nil, p70, p71)
end
function u5.openZhensBalls(_, u72) --[[ Line: 267 ]]
    --[[
    Upvalues:
        [1] = u67
        [2] = u14
        [3] = u4
    --]]
    if not u72.Inventory.Visible then
        u72.Items.Visible = false
        u72.Inventory.Visible = true
        u72.Outline.Outter.ImageColor3 = Color3.fromRGB(170, 170, 255)
        u67(u72.Inventory, nil, true)
        if u14 then
            u14:Disconnect()
            u14 = nil
        end
        u72.SearchBar.Visible = true
        u14 = u4.InputBegan:Connect(function(p73, p74) --[[ Line: 280 ]]
            --[[
            Upvalues:
                [1] = u72
            --]]
            if not p74 then
                if p73.UserInputType == Enum.UserInputType.MouseButton1 or p73.UserInputType == Enum.UserInputType.Touch then
                    local v75 = u72
                    v75.Items.Visible = true
                    v75.Inventory.Visible = false
                    v75.Outline.Outter.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    v75.SearchBar.Visible = false
                end
            end
        end)
    end
end
function u5.setupFrame(_, u76) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    for _ = 1, 40 - (#u76.Items:GetChildren() - 1) do
        local u77 = script.Add:Clone()
        u77.FrameButton.Activated:Connect(function() --[[ Line: 294 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u76
                [3] = u77
            --]]
            u5:openZhensBalls(u76)
            circleclick:Activate(u77.FrameButton)
        end)
        u77.Parent = u76.Items
    end
end
function u5.updateItems(_, u78, p79) --[[ Line: 302 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u3
        [3] = u8
        [4] = u10
        [5] = u19
        [6] = u7
        [7] = u9
        [8] = u5
    --]]
    local v80 = {}
    local v81 = 0
    u15 = p79
    for v82, v83 in pairs(p79) do
        v81 = v81 + 1
        v80[v82] = v83
    end
    if v81 > 40 then
        warn("max slots reached")
    else
        for u84, _ in pairs(p79) do
            if u78.Items:FindFirstChild(u84) then
                u78.Items:FindFirstChild(u84).Ammount.Text = "x" .. v80[u84]
            else
                local u85 = script.Frame:Clone()
                u85.Name = u84
                local v86 = u3.Tools[u84]:Clone()
                local v87 = u8:Attach3D(u85.ItemFrame, v86)
                v87:SetDepthMultiplier(1)
                v87.Camera.FieldOfView = 50
                v87:SetActive(true)
                local v88 = u85.ItemFrame:WaitForChild("ViewportFrame", 1)
                if v88 then
                    v88.ZIndex = 5
                    v88.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
                end
                u85.Ammount.Text = "x" .. v80[u84]
                u85.Parent = u78.Items
                u10[u85] = { v87, u85 }
                u85.AncestryChanged:Connect(function() --[[ Line: 336 ]]
                    --[[
                    Upvalues:
                        [1] = u85
                        [2] = u10
                    --]]
                    if not u85:IsDescendantOf(game) then
                        u10[u85] = nil
                    end
                end)
                u19(u85, u84)
                if u7[u84].Type == "Grip" then
                    u85.itemName.Visible = true
                    u85.itemName.Text = u84
                    _G.displayRareItem(u84, u85.itemName.ItemRare)
                end
                local v89, v90 = u9.MouseEnterLeaveEvent(u85)
                v89:Connect(function() --[[ Line: 353 ]]
                    --[[
                    Upvalues:
                        [1] = u85
                        [2] = u78
                    --]]
                    u85.takeoff.Visible = true
                    local v91 = u78.Items:GetChildren()
                    for v92 = 1, #v91 do
                        if v91[v92]:IsA("Frame") and (v91[v92]:FindFirstChild("takeoff") and v91[v92] ~= u85) then
                            v91[v92].takeoff.Visible = false
                        end
                    end
                end)
                v90:Connect(function() --[[ Line: 362 ]]
                    --[[
                    Upvalues:
                        [1] = u85
                    --]]
                    u85.takeoff.Visible = false
                end)
                u85.FrameButton.Activated:Connect(function() --[[ Line: 365 ]]
                    --[[
                    Upvalues:
                        [1] = u84
                        [2] = u85
                    --]]
                    local v93 = {
                        ["removeItem"] = u84
                    }
                    _G.tradeRemote:FireServer(v93)
                    circleclick:Activate(u85.FrameButton)
                end)
            end
        end
        for _, v94 in u78.Items:GetChildren() do
            if v80[v94.Name] == nil and v94:IsA("Frame") then
                v94:Destroy()
            end
        end
        for _ = 1, v81 do
            if u78.Items:FindFirstChild("Add") then
                u78.Items:FindFirstChild("Add"):Destroy()
            end
        end
        u5:setupFrame(u78)
    end
end
function u5.clearAll(_) --[[ Line: 390 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u10
        [3] = u15
    --]]
    local v95 = u6.PlayerGui:FindFirstChild("TradeGUI")
    if v95 ~= nil then
        for v96, v97 in pairs(u10) do
            if v96:IsDescendantOf(v95) then
                v97[1]:End()
                u10[v96] = nil
            else
                u10[v96] = nil
            end
        end
        u15 = {}
    end
end
local u98 = 0
local u99 = {}
local function u103(p100) --[[ Line: 414 ]]
    --[[
    Upvalues:
        [1] = u99
    --]]
    if u99[p100] and u99[p100].Visible == false then
        return false
    end
    local v101 = p100:FindFirstAncestorWhichIsA("ScreenGui")
    if v101 and v101.Enabled == false then
        return false
    end
    local u102 = p100
    while p100 ~= v101 do
        if p100 and (p100:IsA("GuiObject") and p100.Visible == false) then
            if u102 ~= nil and not u99[u102] then
                u99[u102] = u102
                u102.Destroying:Connect(function() --[[ Line: 435 ]]
                    --[[
                    Upvalues:
                        [1] = u99
                        [2] = u102
                    --]]
                    if u99[u102] then
                        u99[u102] = nil
                    end
                end)
            end
            return false
        end
        if p100 == nil then
            break
        end
        p100 = p100.Parent
    end
    return p100 ~= nil
end
if _G.TradingRotationRS then
    _G.TradingRotationRS:Disconnect()
    _G.TradingRotationRS = nil
end
local u104 = CFrame.Angles(-0.03490658503988659, 0, 0)
_G.TradingRotationRS = v2.Heartbeat:Connect(function() --[[ Line: 469 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u103
        [3] = u104
        [4] = u98
        [5] = u11
    --]]
    if _G.itemRotation then
        for v105, v106 in u10 do
            if v105.Visible then
                local v107, v108 = unpack(v106)
                if v108 and (v108:IsDescendantOf(game) and v105:IsDescendantOf(game)) then
                    if not v108 or u103(v108) then
                        v107:SetCFrame(CFrame.Angles(0, tick() % 6.283185307179586, 0) * u104)
                    end
                else
                    u10[v105] = nil
                end
            end
        end
        u98 = u98 + 1
        for v109, v110 in u11 do
            if v110 then
                if v110:IsDescendantOf(game) then
                    v110.Rotation = u98
                else
                    u11[v109] = nil
                end
            else
                u11[v109] = nil
            end
        end
    end
end)
function u3.tradeCheck.OnClientInvoke() --[[ Line: 503 ]]
    return true
end
return u5