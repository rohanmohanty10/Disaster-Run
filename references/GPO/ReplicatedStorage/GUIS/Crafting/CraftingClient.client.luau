 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("HttpService")
local u4 = workspace:WaitForChild("NPCs")
local v5 = v2:WaitForChild("Modules")
local u6 = require(v5.Trove)
local u7 = require(v5:WaitForChild("Blueprints"))
local u8 = require(v5:WaitForChild("ToolDesc"))
require(v5.RichText)
local v9 = v5:WaitForChild("Client")
local v10 = require(v9:WaitForChild("ItemDisplay"))
local v11 = v9:WaitForChild("UIs")
local u12 = require(v11:WaitForChild("RarityGradient"))
local v13 = v5:WaitForChild("Shared")
require(v13:WaitForChild("GameUtils"))
local u14 = v1.LocalPlayer
local u15 = v2:WaitForChild("CraftingRemote", 360)
local u16 = script.Parent
local v17 = u16:WaitForChild("Main")
local v18 = v17:WaitForChild("Blueprints")
local u19 = v18:WaitForChild("List")
local u20 = v18:WaitForChild("SearchBox")
v17:WaitForChild("Description"):WaitForChild("Desc")
local v21 = v17:WaitForChild("Requirements")
local u22 = v21.List.Items
local v23 = v21:WaitForChild("Craft")
local u24 = v21:WaitForChild("Item")
local u25 = {}
local u26 = {}
local u27 = {
    ["Craftables"] = 6,
    ["Fish Baits"] = 10,
    ["Fishing Rods"] = 15,
    ["Brews"] = 20,
    ["Misc"] = 99
}
local u28 = false
local u29 = false
local u30 = nil
local u31 = {}
local u32 = 0
local u33 = {}
local u34 = {}
local u35 = nil
local function u45(p36) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u32
        [2] = u4
        [3] = u14
        [4] = u33
        [5] = u34
        [6] = u35
    --]]
    u32 = tick()
    local v37 = u4:FindFirstChild("Blacksmith Sen") or u14.Character
    local v38 = p36.Name
    if not u33[v38] then
        u33[v38] = {}
    end
    local v39 = p36:GetChildren()
    local v40 = {}
    for _, v41 in v39 do
        if not u33[v38][v41.Name] then
            table.insert(v40, v41)
        end
    end
    if #v40 == 0 then
        u33[v38] = {}
        for _, v42 in v39 do
            if v42.Name ~= u34[v38] then
                table.insert(v40, v42)
            end
        end
    end
    if #v40 ~= 0 then
        local v43 = v40[math.random(1, #v40)]
        u33[v38][v43.Name] = true
        u34[v38] = v43.Name
        if u35 then
            u35:Stop()
            u35:Destroy()
        end
        if _G.PlaySound then
            local v44 = _G.PlaySound(v37.PrimaryPart, v43)
            if v44 then
                v44.Parent = v37.PrimaryPart
            end
            u35 = v44
        end
    end
end
u20:GetPropertyChangedSignal("Text"):Connect(function() --[[ Name: UpdateSearchList, Line 123 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u19
    --]]
    local v46 = u20.Text
    local v47 = string.lower(v46)
    for _, v48 in pairs(u19:GetChildren()) do
        if v48:IsA("ImageButton") then
            v48.Visible = string.find(string.lower(v48.Name), v47) and true or false
        end
    end
end)
local u49 = v2:WaitForChild("Stats" .. u14.Name):WaitForChild("Inventory"):WaitForChild("Inventory")
local u50 = v10.new({
    ["Gui"] = u16,
    ["UseUniqueId"] = false
})
local function u68(p51) --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u3
        [3] = u49
        [4] = u8
        [5] = u31
    --]]
    local v52 = u7[p51]
    if not v52 then
        return 0
    end
    local v53 = u3:JSONDecode(u49.Value)
    local v54 = (1 / 0)
    for v55, v56 in pairs(v52.Requirements) do
        local v57 = u8[v55]
        local v58
        if v57 then
            v58 = v57.BaseItem
        else
            v58 = v57
        end
        if not (v57 or v58) then
            if v52.UseRequiredItem then
                v58 = v55
            end
        end
        if v52.IgnoreBaseItem then
            v58 = nil
        end
        if v58 then
            local v59 = v52.RequirementsExtra
            if v59 then
                v59 = v52.RequirementsExtra[v55]
            end
            local v60 = 0
            if v59 and v59.AllowMultiple then
                for v61, _ in pairs(u31) do
                    local v62 = u8[v61]
                    if v62 and v62.BaseItem == v58 then
                        v60 = v60 + (v53[v61] or 0)
                    end
                end
            else
                local v63 = u31[v58]
                if v63 then
                    v60 = v53[v63] or 0
                end
            end
            local v64 = v60 / v56
            local v65 = math.floor(v64)
            v54 = math.min(v54, v65)
        else
            local v66 = (v53[v55] or 0) / v56
            local v67 = math.floor(v66)
            v54 = math.min(v54, v67)
        end
    end
    return v54 == (1 / 0) and 0 or v54
end
local u69 = v21:WaitForChild("Selection")
local u70 = u69:FindFirstChild("List") or u69
local u71 = script:WaitForChild("SlotTemplate")
local u72 = u6.new()
local u73 = nil
local u74 = nil
local function u79(p75, p76, p77) --[[ Line: 229 ]]
    local v78 = p75:FindFirstChild("Amount")
    if v78 then
        v78.Text = ("%*/%*"):format(p76, p77)
        v78.TextColor3 = p77 <= p76 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 80, 80)
    end
end
local function u104(u80, u81, u82, u83, u84) --[[ Line: 239 ]]
    --[[
    Upvalues:
        [1] = u73
        [2] = u69
        [3] = u72
        [4] = u74
        [5] = u70
        [6] = u31
        [7] = u8
        [8] = u12
        [9] = u16
        [10] = u79
    --]]
    if u73 == u80 and u69.Visible then
        u69.Visible = false
        u72:Clean()
        u73 = nil
        u74 = nil
    else
        u72:Clean()
        u73 = u80
        u74 = u84
        for _, v85 in u70:GetChildren() do
            if v85:IsA("ImageButton") or v85:IsA("TextButton") then
                v85:Destroy()
            end
        end
        local u86 = 0
        if u83 and u83.AllowMultiple then
            for v87, _ in pairs(u31) do
                if u81[v87] then
                    u86 = u86 + u81[v87]
                end
            end
        else
            local v88 = u31[u80]
            if v88 and u81[v88] then
                local v89 = u81[v88]
                u86 = math.min(v89, u82)
            end
        end
        local u90 = Color3.fromRGB(42, 42, 42)
        local u91 = Color3.fromRGB(0, 255, 0)
        local v92 = 0
        for u93, u94 in pairs(u81) do
            local v95 = script.BlueprintTemplate:Clone()
            v95.Name = u93
            v95.ItemName.Text = ("%* x%*"):format(u93, u94)
            v95.Parent = u70
            local u96 = v95.Background
            u96.ImageTransparency = 0.5
            u96.ImageColor3 = u90
            local v97 = v95.ItemName
            if u8[u93] ~= nil then
                local v98 = v97:FindFirstChild("Gradient")
                if v98 == nil then
                    v98 = Instance.new("UIGradient")
                    v98.Name = "Gradient"
                    v98.Parent = v97
                end
                u12.ApplyRarityGradient(u93, v98, u16, nil)
            end
            local v99
            if u83 and u83.AllowMultiple then
                v99 = u31[u93] ~= nil
            else
                v99 = u31[u80] == u93
            end
            u96.ImageColor3 = v99 and u91 and u91 or u90
            u72:Add(v95.MouseButton1Click:Connect(function() --[[ Line: 298 ]]
                --[[
                Upvalues:
                    [1] = u83
                    [2] = u31
                    [3] = u93
                    [4] = u86
                    [5] = u94
                    [6] = u96
                    [7] = u90
                    [8] = u82
                    [9] = u80
                    [10] = u91
                    [11] = u81
                    [12] = u70
                    [13] = u84
                    [14] = u79
                --]]
                if u83 and u83.AllowMultiple then
                    if u31[u93] then
                        u31[u93] = nil
                        u86 = u86 - u94
                        u96.ImageColor3 = u90
                    elseif u86 < u82 then
                        u31[u93] = u80
                        u86 = u86 + u94
                        u96.ImageColor3 = u91
                    end
                else
                    local v100 = u31[u80]
                    if v100 and u81[v100] then
                        u86 = 0
                    end
                    for _, v101 in u70:GetChildren() do
                        if v101:IsA("ImageButton") or v101:IsA("TextButton") then
                            v101.Background.ImageColor3 = u90
                        end
                    end
                    u31[u80] = u93
                    local v102 = u94
                    local v103 = u82
                    u86 = math.min(v102, v103)
                    u96.ImageColor3 = u91
                end
                if u84 then
                    u79(u84, u86, u82)
                end
            end))
            v92 = v92 + 1
        end
        u69.Visible = true
        if v92 <= 0 then
            _G.displayMessage("<Color=Red>You dont have any eligible materials to add!")
        end
    end
end
local function u128(p105, p106, p107) --[[ Line: 344 ]]
    --[[
    Upvalues:
        [1] = u28
        [2] = u69
        [3] = u72
        [4] = u73
        [5] = u74
        [6] = u8
        [7] = u31
        [8] = u50
        [9] = u26
        [10] = u3
        [11] = u49
        [12] = u71
        [13] = u22
        [14] = u79
        [15] = u104
        [16] = u24
        [17] = u30
    --]]
    if not u28 then
        u28 = true
        u69.Visible = false
        u72:Clean()
        u73 = nil
        u74 = nil
        local v108 = script.Parent.Main.Requirements
        v108.List.Visible = true
        v108.Craft.Visible = true
        v108.Item.Visible = true
        if not (u8[p105] and u8[p105].Desc) then
            local _ = p106.Description
        end
        if not p107 then
            u31 = {}
        end
        u50:RemoveAllItems()
        for _, v109 in pairs(u26) do
            v109:Destroy()
        end
        table.clear(u26)
        for v110, u111 in pairs(p106.Requirements) do
            local v112 = u8[v110]
            v112 = v112
            local u113
            if v112 then
                u113 = v112.BaseItem
            else
                u113 = v112
            end
            if not v112 and (not u113 and p106.UseRequiredItem) then
                u113 = v110
            end
            if p106.IgnoreBaseItem then
                u113 = nil
            end
            if u113 then
                local u114 = p106.RequirementsExtra
                if u114 then
                    u114 = p106.RequirementsExtra[v110]
                end
                local v115 = u3:JSONDecode(u49.Value)
                local u116 = {}
                local v117 = 0
                for v118, v119 in pairs(v115) do
                    local v120 = u8[v118]
                    if v120 and v120.BaseItem == u113 then
                        u116[v118] = v119
                        v117 = v117 + v119
                    end
                end
                local _ = u111 <= v117
                local v121 = 0
                if u114 and u114.AllowMultiple then
                    for v122, _ in pairs(u31) do
                        if u116[v122] then
                            v121 = v121 + u116[v122]
                        else
                            u31[v122] = nil
                        end
                    end
                else
                    local v123 = u31[u113]
                    if v123 and u116[v123] then
                        local v124 = u116[v123]
                        v121 = math.min(v124, u111)
                    else
                        u31[u113] = nil
                    end
                end
                local u125 = u71:Clone()
                u125.Name = v110
                u125.Visible = true
                u125.ZIndex = 10000
                u125.Parent = u22
                local v126 = u125:FindFirstChild("Plus")
                if v126 then
                    v126.Visible = true
                end
                u79(u125, v121, u111)
                u125.MouseButton1Click:Connect(function() --[[ Line: 452 ]]
                    --[[
                    Upvalues:
                        [1] = u104
                        [2] = u113
                        [3] = u116
                        [4] = u111
                        [5] = u114
                        [6] = u125
                    --]]
                    warn("item frame clicked")
                    u104(u113, u116, u111, u114, u125)
                end)
                local v127 = u26
                table.insert(v127, u125)
            else
                local _, _ = u50:AddCraftingItem(u22, v110, u111)
            end
        end
        u50:AddItem(u24, p106.GivenItem, 1, 3)
        u30 = p105
        u28 = false
    end
end
v23.MouseButton1Click:Connect(function() --[[ Line: 484 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u29
        [3] = u68
        [4] = u14
        [5] = u7
        [6] = u15
        [7] = u31
        [8] = u26
        [9] = u8
        [10] = u45
        [11] = u128
    --]]
    if u30 and u29 == false then
        u29 = true
        local u129 = 1
        local v130 = u68(u30)
        if v130 > 1 then
            _G.promptQuestionSlider(u14, {
                ["DisplayText"] = u7[u30].GivenItem,
                ["uiName"] = "craftCountSelector",
                ["Start"] = 1,
                ["End"] = v130,
                ["AcceptText"] = "Craft Selected",
                ["DeclineText"] = "Craft 1",
                ["finishFunction"] = function(p131) --[[ Name: finishFunction, Line 500 ]]
                    --[[
                    Upvalues:
                        [1] = u129
                    --]]
                    u129 = p131
                end
            })
        end
        if u15:InvokeServer({
            ["Method"] = "Craft",
            ["BlueprintItem"] = u30,
            ["ExtraData"] = u31,
            ["Count"] = u129
        }) == true then
            for _, v132 in pairs(u26) do
                v132:Destroy()
            end
            script.Parent.Main.Requirements.List.Visible = false
            script.Parent.Main.Requirements.Craft.Visible = false
            script.Parent.Main.Requirements.Item.Visible = false
            script.BlackSmithCraft:Play()
            local v133 = script.VoiceLines.NormalCraftDone
            local v134 = u7[u30].GivenItem
            if v134 then
                local v135 = u8[v134]
                if v135 then
                    v135 = v135.Type
                end
                if v135 == "Fishing Rod" then
                    v133 = script.VoiceLines.FishCraftDone
                end
            end
            u45(v133)
            local v136 = script.Crafter.Value
            if v136 then
                v136.Humanoid:LoadAnimation(script.Animation):Play()
            end
            u128(u30, u7[u30], true)
        end
        u29 = false
    end
end)
local u137 = nil
local u138 = {}
local u139 = script.Selected
local function u152(u140, u141) --[[ Line: 558 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u27
        [3] = u19
        [4] = u138
        [5] = u128
        [6] = u137
        [7] = u139
        [8] = u6
        [9] = u8
        [10] = u12
        [11] = u16
        [12] = u49
    --]]
    if u25[u140] == nil then
        if u141.Disabled ~= true then
            local u142 = script.BlueprintTemplate:Clone()
            u142.LayoutOrder = u27[u141.Type] or 10
            u142.Name = u140
            u142.Parent = u19
            local u143 = u138["Line" .. u142.LayoutOrder]
            if u143 then
                u143.Parent = nil
                task.delay(0.2, function() --[[ Line: 576 ]]
                    --[[
                    Upvalues:
                        [1] = u143
                        [2] = u19
                    --]]
                    u143.Parent = u19
                end)
            else
                local v144 = script.Category:Clone()
                v144.LayoutOrder = u142.LayoutOrder - 1
                v144.Name = "Line" .. u142.LayoutOrder
                v144.Text = u141.Type
                v144.Parent = u19
                u138[v144.Name] = v144
            end
            u25[u140] = u142
            u142.MouseButton1Click:Connect(function() --[[ Line: 591 ]]
                --[[
                Upvalues:
                    [1] = u128
                    [2] = u140
                    [3] = u141
                    [4] = u137
                    [5] = u139
                    [6] = u142
                --]]
                u128(u140, u141)
                u137 = u140
                u139.Parent = u142
            end)
            local v145 = u6.new()
            local function v147() --[[ Line: 600 ]]
                --[[
                Upvalues:
                    [1] = u141
                    [2] = u142
                --]]
                local v146 = ("%*"):format(u141.GivenItem)
                u142.ItemName.Text = v146
            end
            local v148 = ("%*"):format(u141.GivenItem)
            u142.ItemName.Text = v148
            local v149 = u141.GivenItem
            local v150 = u142.ItemName
            if u8[v149] ~= nil then
                local v151 = v150:FindFirstChild("Gradient")
                if v151 == nil then
                    v151 = Instance.new("UIGradient")
                    v151.Name = "Gradient"
                    v151.Parent = v150
                end
                u12.ApplyRarityGradient(v149, v151, u16, nil)
            end
            v145:Connect(u49.Changed, v147)
            v145:AttachToInstance(u142)
        end
    else
        return
    end
end
local function v160() --[[ Line: 615 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u49
        [3] = u7
        [4] = u152
        [5] = u25
        [6] = u139
        [7] = u137
    --]]
    local v153 = u3:JSONDecode(u49.Value)
    local v154 = {}
    local v155 = 0
    for v156, _ in pairs(v153) do
        local v157 = u7[v156]
        if v157 ~= nil then
            v154[v156] = true
            u152(v156, v157)
            v155 = v155 + 1
        end
    end
    for v158, v159 in pairs(u25) do
        if v154[v158] == nil and not (u7[v158] and u7[v158].Default) then
            if v159 and v159.Parent then
                if u139.Parent == v159 then
                    u139.Parent = script
                end
                v159:Destroy()
            end
            u25[v158] = nil
        end
    end
    if v155 > 0 then
        if u137 == nil then
            ::l19::
            return
        end
        if u137 ~= nil and u25[u137] ~= nil then
            return
        end
    end
    script.Parent.Main.Requirements.Item.Visible = false
    script.Parent.Main.Requirements.List.Visible = false
    script.Parent.Main.Requirements.Craft.Visible = false
    goto l19
end
v160()
u49:GetPropertyChangedSignal("Value"):Connect(v160)
local u161 = u32
for v162, v163 in pairs(u7) do
    if v163.Default == true then
        u152(v162, v163)
    end
end
script.Parent.Main.Close.MouseButton1Click:Connect(function() --[[ Line: 683 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u14
        [3] = u45
    --]]
    script.Parent.Enabled = false
    if not u4:FindFirstChild("Blacksmith Sen") then
        local _ = u14.Character
    end
    u45(script.VoiceLines.Bye)
end)
script.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 691 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u14
        [3] = u45
    --]]
    if script.Parent.Enabled == true then
        if not u4:FindFirstChild("Blacksmith Sen") then
            local _ = u14.Character
        end
        u45(script.VoiceLines.Greet)
    end
end)
local u164 = nil
local u165 = nil
local function v168(p166) --[[ Line: 722 ]]
    --[[
    Upvalues:
        [1] = u164
        [2] = u161
        [3] = u45
        [4] = u165
    --]]
    if p166.Name == "Blacksmith Sen" then
        local v167 = p166.PrimaryPart
        if v167 == nil then
            v167 = p166:WaitForChild("HumanoidRootPart", 2)
        end
        if v167 then
            if u164 then
                task.cancel(u164)
            end
            local _ = p166.PrimaryPart.CFrame
            u164 = task.spawn(function() --[[ Line: 709 ]]
                --[[
                Upvalues:
                    [1] = u161
                    [2] = u45
                --]]
                while true do
                    while true do
                        warn("playing SFX")
                        if tick() - u161 < 20 then
                            break
                        end
                        u45(script.VoiceLines.Idles)
                        task.wait(math.random(8, 10))
                    end
                    task.wait(2)
                end
            end)
            if u165 then
                u165:Disconnect()
                u165 = nil
            end
            u165 = p166.AncestryChanged:Connect(function() --[[ Line: 738 ]]
                --[[
                Upvalues:
                    [1] = u164
                    [2] = u165
                --]]
                if u164 then
                    task.cancel(u164)
                end
                if u165 then
                    u165:Disconnect()
                    u165 = nil
                end
            end)
        end
    end
end
u4.ChildAdded:Connect(v168)
local v169 = u4:GetChildren()
for v170 = 1, #v169 do
    v168(v169[v170])
end
local u171 = false
local function v172() --[[ Line: 761 ]]
    --[[
    Upvalues:
        [1] = u171
        [2] = u16
        [3] = u50
    --]]
    if u171 == false then
        u171 = true
    end
    if u16.Enabled then
        u50:StartRotation()
    else
        u50:StopRotation()
    end
end
if u171 == false then
    u171 = true
end
if u16.Enabled then
    u50:StartRotation()
else
    u50:StopRotation()
end
u16:GetPropertyChangedSignal("Enabled"):Connect(v172)