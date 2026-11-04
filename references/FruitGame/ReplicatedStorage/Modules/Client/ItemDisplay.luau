 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local u3 = game:GetService("HttpService")
local v4 = v1:WaitForChild("Modules")
local u5 = require(v4:WaitForChild("ToolDesc"))
local u6 = require(v4:WaitForChild("Module3D"))
local u7 = require(v4:WaitForChild("Trove"))
local u8 = require(v1.Modules.MEnterLeave)
local v9 = v4.Shared
local u10 = require(v9:WaitForChild("GameUtils"))
local v11 = v4.Client
require(v11:WaitForChild("UIUtils"))
local v12 = v11.UIs
local u13 = require(v12:WaitForChild("RarityGradient"))
local u14 = v1:WaitForChild("Tools")
local u15 = v2.LocalPlayer
local v16 = script:WaitForChild("Gradients")
local u17 = {
    ["Uncommon"] = v16:WaitForChild("Uncommon"),
    ["Rare"] = v16:WaitForChild("Rare"),
    ["Epic"] = v16:WaitForChild("Epic"),
    ["Legendary"] = v16:WaitForChild("Legendary"),
    ["Mythical"] = v16:WaitForChild("Mythical"),
    ["Collectable"] = v16:WaitForChild("Collectable")
}
local u18 = {}
u18.__index = u18
function u18.new(p19) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u3
        [3] = u7
    --]]
    local v20 = p19.Gui ~= nil
    assert(v20, "Missing Gui in Arguments")
    local v21 = u18
    local u22 = setmetatable({}, v21)
    u22.Name = u3:GenerateGUID()
    u22.Gui = p19.Gui
    u22.Items = {}
    u22.Gradients = {}
    u22.ClickCallbacks = {}
    u22.Rotation = false
    u22.Trade = p19.Trade or false
    u22.TradeRemote = nil
    u22.Thread = nil
    u22.TotalItems = 0
    u22.DisableAmount = p19.DisableAmount or false
    u22.TextAlwaysOn = p19.TextAlwaysOn or false
    u22.UseUniqueId = p19.UseUniqueId == nil or p19.UseUniqueId ~= false
    u22.RainbowGradientFunctions = {}
    u22.RainbowGradientThreads = {}
    u22.Trove = u7.new()
    if u22.Gui then
        local v23 = u22.Gui
        if typeof(v23) ~= "Instance" then
            local v24 = u22.Gui
            if typeof(v24) ~= "table" or u22.Gui.Destroying == nil then
                goto l9
            end
        end
        u22.Gui.Destroying:Connect(function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u22
            --]]
            u22:Destroy()
        end)
        goto l9
    else
        ::l9::
        return u22
    end
end
function u18.AddTradeRemote(p25, p26) --[[ Line: 80 ]]
    p25.TradeRemote = p26
end
function u18.AddClickCallbacks(p27, p28) --[[ Line: 84 ]]
    local v29 = p27.ClickCallbacks
    table.insert(v29, p28)
end
function u18.EnableRotation(p30, p31) --[[ Line: 88 ]]
    p30.Rotation = p31
    if p31 == true then
        p30:StartRotation()
    elseif p31 == false then
        p30:StopRotation()
    end
end
function u18.BindFrameToRotation(u32, u33, p34) --[[ Line: 97 ]]
    u32.Trove:Add(u33:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u32
        --]]
        if u33.Visible == true and u32.Rotation == true then
            u32:StartRotation()
        elseif u33.Visible == false then
            u32:StopRotation()
        end
    end))
    if p34 then
        u32:StartRotation()
    end
end
function u18.UpdateItem(p35, p36, p37) --[[ Line: 111 ]]
    local v38 = p35.Items[p36]
    if v38 then
        local v39 = v38.Button
        v38.ItemAmount = p37
        v39.Amount.Text = ("x%*"):format(p37)
        v39:SetAttribute("amountOwned", p37)
    end
end
function u18.BindRainbowGradient(u40, u41, u42) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local u43 = u41.Parent:IsA("TextLabel") or u41.Parent:IsA("TextButton")
    local u44 = u43 and (u41.Parent.Text or "SkipThis") or "SkipThis"
    local function u45() --[[ Line: 129 ]]
        --[[
        Upvalues:
            [1] = u42
            [2] = u41
            [3] = u40
            [4] = u45
            [5] = u43
            [6] = u44
            [7] = u13
        --]]
        while true do
            if u42 then
                print("extra callback")
                u42()
            end
            task.wait(0.02)
            if u41.Parent == nil then
                if u40.RainbowGradientFunctions[u45] ~= nil then
                    u40.RainbowGradientFunctions[u45] = nil
                    return
                end
                break
            end
            if u43 and u41.Parent.Text ~= u44 then
                print("it broke?")
                if u40.RainbowGradientFunctions[u45] ~= nil then
                    u40.RainbowGradientFunctions[u45] = nil
                    return
                end
                break
            end
            u41.Color = u13.GetRainbowGradientColor()
        end
    end
    u40.RainbowGradientFunctions[u45] = u45
    if u40.Thread ~= nil then
        u40.RainbowGradientThreads[u45] = task.spawn(u45)
    end
end
function u18.UpdateGradientColor(p46, p47, p48, p49) --[[ Line: 165 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u17
    --]]
    local v50 = u5[p47]
    local v51 = v50.Rare
    local v52 = u17[v51]
    p48.Enabled = true
    p48.Color = v51 == "Common" and ColorSequence.new(Color3.fromRGB(255, 255, 255)) or v52.Color
    if v50.Rare == "Legendary" or v50.Chroma ~= nil then
        p46:BindRainbowGradient(p48, p49)
    end
end
function u18.AddItem(u53, p54, u55, p56, _, p57) --[[ Line: 179 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u15
        [3] = u5
        [4] = u14
        [5] = u3
        [6] = u6
        [7] = u8
    --]]
    if u53.Items[u55] == nil then
        local u58 = p56 or u10.CheckItemAmount(u15, u55)
        local _ = u58 == 0
        local v59 = u5[u55]
        local v60
        if v59 then
            v60 = v59.Type
        else
            v60 = v59
        end
        if v59 ~= nil then
            local v61 = u14:FindFirstChild(u55)
            if v61 then
                local v62
                if u53.UseUniqueId == true then
                    v62 = ("%*%*%*"):format(v59.Type, u55, (u3:GenerateGUID())) or u55
                else
                    v62 = u55
                end
                local u63 = script.EmptyTemplate:Clone()
                u63.Name = v62
                u63.Parent = p54
                u53.TotalItems = u53.TotalItems + 1
                u53.Items[v62] = {
                    ["Button"] = u63,
                    ["ItemModule3D"] = nil,
                    ["ItemAmount"] = p56
                }
                local v64 = u63.Border
                u63.ItemName.Text = u55
                u53:UpdateGradientColor(u55, u63.ItemName.ItemRare)
                u63.Amount.Text = ("x%*"):format(u58)
                if u58 == 0 then
                    u63.Amount.Text = ""
                end
                if u53.DisableAmount == true then
                    u63.Amount.Visible = false
                end
                u63:SetAttribute("FullName", v62)
                u63:SetAttribute("itemName", u55)
                u63:SetAttribute("itemType", v59.Type)
                u63:SetAttribute("amountOwned", u58)
                if v60 ~= "Grip" then
                    local v65 = u6:Attach3D(u63.Display, v61:Clone())
                    v65:SetDepthMultiplier(1)
                    v65.Camera.FieldOfView = 50
                    v65:SetActive(true)
                    v65:SetCFrame(CFrame.Angles(0, os.clock() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0))
                    u53.Items[v62].ItemModule3D = v65
                end
                if u55 == "Peli" or u55 == "Bounty" then
                    u63.Amount.Size = UDim2.new(1, 0, 0.2, 0)
                    u63.Amount.Position = UDim2.new(1, 0, 0.975, 0)
                end
                local v66 = u63.Display:FindFirstChild("ViewportFrame")
                if v66 then
                    v66.ZIndex = 5
                    v66.BorderSizePixel = 0
                    v66.ClipsDescendants = true
                    v66.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
                end
                local v67 = v64.UIGradient
                u53:UpdateGradientColor(u55, v67)
                u53.Gradients[u63] = v67
                local v68, v69
                if p57 == true then
                    v68, v69 = u8.MouseEnterLeaveEvent(u63)
                else
                    v68 = nil
                    v69 = nil
                end
                if v60 == "Grip" then
                    u63.ItemName.Visible = true
                elseif u53.TextAlwaysOn == false then
                    u63.ItemName.Visible = false
                    if v68 == nil then
                        v68, v69 = u8.MouseEnterLeaveEvent(u63)
                    end
                    v68:Connect(function() --[[ Line: 284 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        u63.ItemName.Visible = true
                    end)
                    v69:Connect(function() --[[ Line: 288 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        u63.ItemName.Visible = false
                    end)
                else
                    u63.ItemName.Visible = true
                end
                if p57 == true then
                    v68:Connect(function() --[[ Line: 300 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        u63.Unavailable.Visible = true
                    end)
                    v69:Connect(function() --[[ Line: 304 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        u63.Unavailable.Visible = false
                    end)
                end
                if u53.Trade == true then
                    u63.Active = true
                    u63.MouseButton1Click:Connect(function() --[[ Line: 313 ]]
                        --[[
                        Upvalues:
                            [1] = u58
                            [2] = u15
                            [3] = u55
                            [4] = u53
                        --]]
                        local u70 = nil
                        if u58 >= 10 then
                            _G.promptQuestionSlider(u15, {
                                ["DisplayText"] = u55,
                                ["uiName"] = "tradeItemCountSelector",
                                ["Start"] = 1,
                                ["End"] = u58 - (_G.LocalOfferedItems and _G.LocalOfferedItems[u55] ~= nil and (_G.LocalOfferedItems[u55] or 0) or 0),
                                ["AcceptText"] = "Add selected",
                                ["DeclineText"] = "Add 1",
                                ["finishFunction"] = function(p71) --[[ Name: finishFunction, Line 326 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u70
                                    --]]
                                    u70 = p71
                                    warn("client slider function", p71)
                                end
                            })
                        end
                        if u53.TradeRemote ~= nil then
                            warn("remote fire count", u70)
                            local v72 = {
                                ["addItem"] = u55,
                                ["customCount"] = u70
                            }
                            u53.TradeRemote:FireServer(v72)
                        end
                        for _, v73 in pairs(u53.ClickCallbacks) do
                            v73()
                        end
                    end)
                else
                    u63.Active = false
                end
                return u63, {
                    ["newlyMade"] = true,
                    ["updated"] = true
                }
            end
            warn("Missing model for itme", u55)
        end
    else
        local v74 = u53.Items[u55].ItemAmount ~= p56
        local v75 = u53.Items[u55].ItemAmount < p56
        u53:UpdateItem(u55, p56)
        return u53.Items[u55].Button, {
            ["updated"] = v74,
            ["increased"] = v75
        }
    end
end
function u18.AddToolItem(p76, p77, p78, _) --[[ Line: 349 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u14
        [3] = u3
        [4] = u6
    --]]
    local v79 = u5[p78]
    if v79 then
        local _ = v79.Type
    end
    if v79 ~= nil then
        local v80 = u14:FindFirstChild(p78)
        if v80 then
            local v81
            if p76.UseUniqueId == true then
                v81 = ("%*%*%*"):format(v79.Type, p78, (u3:GenerateGUID())) or p78
            else
                v81 = p78
            end
            local v82 = script.EmptyToolTemplate:Clone()
            v82.Name = v81
            v82.Parent = p77
            p76.TotalItems = p76.TotalItems + 1
            p76.Items[v81] = {
                ["Button"] = v82,
                ["ItemModule3D"] = nil
            }
            v82:SetAttribute("FullName", v81)
            v82:SetAttribute("itemName", p78)
            v82:SetAttribute("itemType", v79.Type)
            local v83 = u6:Attach3D(v82.Display, v80:Clone())
            v83:SetDepthMultiplier(1)
            v83.Camera.FieldOfView = 50
            v83:SetActive(true)
            v83:SetCFrame(CFrame.Angles(0, os.clock() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0))
            p76.Items[v81].ItemModule3D = v83
            local v84 = v82.Display:FindFirstChild("ViewportFrame")
            if v84 then
                v84.ZIndex = 5
                v84.ClipsDescendants = true
                v84.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
            end
            return v82
        end
        warn("Missing model for itme", p78)
    end
end
function u18.AddCraftingItem(p85, p86, p87, p88) --[[ Line: 411 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u15
        [3] = u5
        [4] = u14
        [5] = u6
    --]]
    if p85.Items[p87] ~= nil then
        local v89 = p85.Items[p87]
        local v90 = u10.CheckItemAmount(u15, p87)
        local v91 = p88 <= v90
        v89.Button.Amount.Text = ("%*/%*"):format(v90, p88)
        v89.Button.Amount.TextColor3 = v91 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 80, 80)
        v89.RequiredAmount = p88
        v89.HasEnough = v91
        return v89.Button, v91
    end
    local v92 = u5[p87]
    if v92 == nil then
        warn("[ItemDisplay] Missing ToolDesc for:", p87)
        return nil, false
    end
    local v93 = u10.CheckItemAmount(u15, p87)
    local v94 = p88 <= v93
    local v95 = u14:FindFirstChild(p87)
    local v96 = script.EmptyTemplate:Clone()
    v96.Name = p87
    v96.Parent = p86
    p85.TotalItems = p85.TotalItems + 1
    p85.Items[p87] = {
        ["Button"] = v96,
        ["ItemModule3D"] = nil,
        ["RequiredAmount"] = p88,
        ["HasEnough"] = v94
    }
    v96.ItemName.Text = p87
    p85:UpdateGradientColor(p87, v96.ItemName.ItemRare)
    v96.ItemName.Visible = true
    v96.Amount.Text = ("%*/%*"):format(v93, p88)
    v96.Amount.TextColor3 = v94 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 80, 80)
    v96:SetAttribute("itemName", p87)
    v96:SetAttribute("itemType", v92.Type)
    v96:SetAttribute("requiredAmount", p88)
    v96:SetAttribute("hasEnough", v94)
    if v95 then
        local v97 = u6:Attach3D(v96.Display, v95:Clone())
        v97:SetDepthMultiplier(1)
        v97.Camera.FieldOfView = 50
        v97:SetActive(true)
        v97:SetCFrame(CFrame.Angles(0, os.clock() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0))
        p85.Items[p87].ItemModule3D = v97
        local v98 = v96.Display:FindFirstChild("ViewportFrame")
        if v98 then
            v98.ZIndex = 5
            v98.BorderSizePixel = 0
            v98.ClipsDescendants = true
            v98.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
        end
    elseif v96:FindFirstChild("Display") then
        v96.Display.Visible = false
    end
    local v99 = v96:FindFirstChild("Border")
    local v100 = v99 and v99:FindFirstChild("UIGradient")
    if v100 then
        p85:UpdateGradientColor(p87, v100)
        p85.Gradients[v96] = v100
    end
    return v96, v94
end
function u18.RemoveItem(p101, p102) --[[ Line: 501 ]]
    local v103 = p101.Items[p102]
    if not v103 then
        return false
    end
    if v103.ItemModule3D then
        v103.ItemModule3D:Destroy()
        v103.ItemModule3D = nil
    end
    v103.Button:Destroy()
    p101.Items[p102] = nil
    p101.TotalItems = p101.TotalItems - 1
    return true
end
function u18.RemoveAllItems(p104) --[[ Line: 522 ]]
    for v105, v106 in pairs(p104.Items) do
        if v106.ItemModule3D then
            v106.ItemModule3D:Destroy()
            v106.ItemModule3D = nil
        end
        v106.Button:Destroy()
        p104.Items[v105] = nil
    end
    p104.TotalItems = 0
end
function u18.AddItemsWithDictionary(p107, p108, p109, p110) --[[ Line: 537 ]]
    for v111, v112 in pairs(p109) do
        p107:AddItem(p108, v111, v112, p110)
    end
end
function u18.AddItemsWithArray(p113, p114, p115, p116) --[[ Line: 543 ]]
    for _, v117 in pairs(p115) do
        p113:AddItem(p114, v117, nil, p116)
    end
end
function u18.StartRotation(u118) --[[ Line: 549 ]]
    if u118.Thread == nil then
        print(u118.Gui, "Start Rotation")
        u118.Thread = task.spawn(function() --[[ Line: 553 ]]
            --[[
            Upvalues:
                [1] = u118
            --]]
            local v119 = 0
            while true do
                task.wait()
                v119 = v119 + 1
                for _, v120 in pairs(u118.Gradients) do
                    v120.Rotation = v119
                end
                for _, v121 in pairs(u118.Items) do
                    if v121.ItemModule3D then
                        v121.ItemModule3D:SetCFrame(CFrame.Angles(0, os.clock() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0))
                    end
                end
            end
        end)
        for _, v122 in pairs(u118.RainbowGradientFunctions) do
            if u118.RainbowGradientThreads[v122] ~= nil and coroutine.status(u118.RainbowGradientThreads[v122]) ~= "dead" then
                task.cancel(u118.RainbowGradientThreads[v122])
                u118.RainbowGradientThreads[v122] = nil
            end
            u118.RainbowGradientThreads[v122] = task.spawn(v122)
        end
        print("created rainbow threads")
    end
end
function u18.StopRotation(p123) --[[ Line: 604 ]]
    if p123.Thread and coroutine.status(p123.Thread) ~= "dead" then
        task.cancel(p123.Thread)
        p123.Thread = nil
    end
    for v124, v125 in pairs(p123.RainbowGradientThreads) do
        if coroutine.status(v125) ~= "dead" then
            task.cancel(v125)
            p123.RainbowGradientThreads[v124] = nil
        end
    end
end
function u18.Destroy(p126) --[[ Line: 621 ]]
    p126:StopRotation()
    p126.Trove:Destroy()
end
return u18