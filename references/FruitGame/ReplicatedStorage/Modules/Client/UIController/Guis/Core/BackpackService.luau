 

local v1 = game:GetService("Players")
local u2 = game:GetService("StarterGui")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("UserInputService")
local u5 = game:GetService("HttpService")
game:GetService("RunService")
local v6 = u3:WaitForChild("Modules").Shared
local u7 = require(v6:WaitForChild("Promises"):WaitForChild("Promise"))
local u8 = require(v6:WaitForChild("Maids"):WaitForChild("Maid"))
local u9 = require(script:WaitForChild("ToolService"))
local u10 = require(script:WaitForChild("Hotbar"))
local u11 = v1.LocalPlayer
local u12 = u11:WaitForChild("PlayerGui")
local u13 = u12:WaitForChild("BackpackGui")
local u14 = u13:WaitForChild("Hotbar")
local u15 = u13:WaitForChild("Backpack")
local u16 = u15:WaitForChild("Search")
local u17 = u3.Events:WaitForChild("Hotbar")
local u18 = u12:WaitForChild("HUD"):WaitForChild("Main"):WaitForChild("Buttons"):WaitForChild("Backpack"):WaitForChild("ItemNum")
local v19 = u11:WaitForChild("PlayerScripts"):WaitForChild("InputHandler")
local u20 = require(v19:WaitForChild("GetPreferredInput"))
print("preferredinput", u20)
local u21 = {
    ["Debug"] = true,
    ["Initialized"] = false,
    ["BackpackGui"] = u13,
    ["Backpack"] = nil,
    ["Character"] = nil,
    ["Humanoid"] = nil,
    ["BackpackKey"] = Enum.KeyCode.Backquote,
    ["CurrentDraggedButton"] = nil,
    ["Tools"] = {},
    ["DebugMessage"] = function(_, ...) --[[ Name: DebugMessage, Line 59 ]]
        --[[
        Upvalues:
            [1] = u21
        --]]
        if u21.Debug == true then
            warn("[Inventory]:", ...)
        end
    end
}
local u22 = u15:WaitForChild("Inventory")
local u23 = u22:WaitForChild("UncategorizedInventory")
local u24 = Vector2.new(1920, 1080)
local u25 = 0
local function u26(_) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u18
    --]]
    u25 = u25 + 1
    u18.Text = u25
    if u25 >= 1 then
        u18.Visible = true
    end
end
local function u27(_) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u18
    --]]
    u25 = u25 - 1
    u18.Text = u25
    if u25 == 0 then
        u18.Visible = false
    end
end
local function v48(u28) --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u26
        [3] = u27
    --]]
    local v29 = workspace.Camera
    local u30 = u28:WaitForChild("UIGridLayout")
    local function v34() --[[ Line: 110 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u30
        --]]
        local v31 = workspace.Camera.ViewportSize
        local v32 = u24
        local v33 = 73 * ((v31.X + v31.Y) / 2 / ((v32.X + v32.Y) / 2))
        u30.CellSize = UDim2.new(0, v33, 0, v33)
    end
    v29:GetPropertyChangedSignal("ViewportSize"):Connect(v34)
    local v35 = workspace.Camera.ViewportSize
    local v36 = u24
    local v37 = 73 * ((v35.X + v35.Y) / 2 / ((v36.X + v36.Y) / 2))
    u30.CellSize = UDim2.new(0, v37, 0, v37)
    local u38 = 1
    local function v43() --[[ Line: 119 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u38
            [3] = u24
            [4] = u28
        --]]
        local v39 = u30.AbsoluteCellCount
        if v39.Y ~= u38 then
            u38 = v39.Y
            local v40 = workspace.Camera.ViewportSize
            local v41 = u24
            local v42 = 73 * ((v40.X + v40.Y) / 2 / ((v41.X + v41.Y) / 2))
            u28.Size = UDim2.new(0.98, 0, 0, (v42 + 8) * u38)
        end
    end
    u30:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(v43)
    local v44 = u30.AbsoluteCellCount
    if v44.Y ~= u38 then
        u38 = v44.Y
        local v45 = workspace.Camera.ViewportSize
        local v46 = u24
        local v47 = 73 * ((v45.X + v45.Y) / 2 / ((v46.X + v46.Y) / 2))
        u28.Size = UDim2.new(0.98, 0, 0, (v47 + 8) * u38)
    end
    u28.ChildAdded:Connect(u26)
    u28.ChildRemoved:Connect(u27)
end
for _, v49 in ipairs(u22:GetChildren()) do
    if v49.Name:find("Inventory") then
        v48(v49)
    end
end
local u50 = {}
function u21.AutoPlaceToolButton(p51) --[[ Line: 148 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u50
        [3] = u22
        [4] = u16
    --]]
    local v52 = p51.ToolButton
    local v53 = p51.Tool:GetAttribute("Category")
    if v53 == nil then
        v52.Parent = u23
    else
        local v54 = v53 .. "Inventory"
        local v55 = u50[v54]
        if v55 then
            v52.Parent = v55
            return
        end
        local v56 = u22:FindFirstChild(v54)
        if v56 then
            v52.Parent = v56
            u50[v54] = v56
        else
            v52.Parent = u23
        end
    end
    local v57 = u16.Text
    if v57 ~= "" then
        v52.Visible = string.find(string.lower(v52.Name), v57) and true or false
    end
end
local v58 = u3:WaitForChild("SkillCallbacks")
local u59 = v58:WaitForChild("DevilFruit")
local u60 = v58:WaitForChild("FistStyles")
function u21.AddTool(u61, p62) --[[ Line: 183 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u9
        [3] = u3
        [4] = u11
        [5] = u5
        [6] = u59
        [7] = u60
        [8] = u10
        [9] = u20
        [10] = u14
        [11] = u17
        [12] = u15
        [13] = u12
    --]]
    if not u61:IsA("Tool") then
        return
    end
    if u21.Tools[u61] ~= nil then
        return
    end
    local u63 = u9.new(u61)
    u63:UpdateLayoutOrder()
    local u64
    if u3:FindFirstChild("battleRoyaleDrop") then
        u64 = p62 or u10:GetEmptyHotbar()
    else
        local v65 = u5:JSONDecode(u3:WaitForChild("Stats" .. u11.Name):WaitForChild("Inventory"):WaitForChild("HotbarOrder").Value)
        u64 = table.find(v65, u61.Name) or p62
        local v66 = u59:FindFirstChild(u61.Name) or u60:FindFirstChild(u61.Name)
        if v66 then
            for v67, v68 in pairs(v65) do
                if v66.Parent:FindFirstChild(v68) and v68 ~= u61.Name then
                    u64 = v67
                    break
                end
            end
        end
        if u64 == nil and u61:GetAttribute("StarterTool") == true then
            u64 = u10:GetEmptyHotbar()
        end
        if u64 == nil and (u21.LastRefresh and os.clock() - u21.LastRefresh > 2) then
            u64 = u64 or u10:GetEmptyHotbar()
        end
    end
    local v69
    if u64 == nil or u64 > 10 then
        v69 = false
    else
        v69 = u20.Current ~= "Mobile" or u64 < 6
    end
    if v69 then
        local v70 = u10:GetFrameSlot(u64)
        local v71 = v70:FindFirstChildOfClass("ImageButton")
        if v71 then
            print("Existing? why?", v71, "in", u64, "instead of", u61)
            u21.AutoPlaceToolButton(u63)
        else
            local v72 = u63.ToolButton
            v72.Parent = v70
            v72.Position = UDim2.new(0.5, 0, 0.5, 0)
            v72.Size = UDim2.new(1, 0, 1, 0)
            u63.HotbarObject.Value = v70
        end
    else
        u21.AutoPlaceToolButton(u63)
    end
    local u73 = u63.ToolButton
    local u74 = u63.ToolButton.Parent
    u73:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 281 ]]
        --[[
        Upvalues:
            [1] = u74
            [2] = u14
            [3] = u73
            [4] = u61
            [5] = u10
            [6] = u17
        --]]
        if u74 and (u74:IsA("Frame") and (u74.Parent == u14 and (u73.Parent ~= nil and u73.Parent ~= u14))) then
            print("previous tool parent", u74, "new parent", u61.Parent)
            print("client hotbar", u10:GetClientHotbar(u74))
            u17:FireServer(u10:GetClientHotbar(u74))
        end
        u74 = u73.Parent
    end)
    local u75 = os.clock()
    u73.MouseButton1Click:Connect(function() --[[ Line: 297 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u63
            [3] = u75
            [4] = u64
        --]]
        u10:SelectTool(u63.ToolButton)
        if os.clock() - u75 < 0.25 and u63.ToolButton.Parent.Name:find("Inventory") then
            u64 = u10:GetEmptyHotbar()
            if u64 ~= nil and u64 <= 10 then
                local v76 = u10:GetFrameSlot(u64)
                if v76 and not v76:FindFirstChildOfClass("ImageButton") then
                    local v77 = u63.ToolButton
                    v77.Parent = v76
                    v77.Position = UDim2.new(0.5, 0, 0.5, 0)
                    v77.Size = UDim2.new(1, 0, 1, 0)
                    u63.HotbarObject.Value = v76
                end
            end
        end
        u75 = os.clock()
    end)
    function u63.Drag.DragStarted() --[[ Line: 350 ]]
        --[[
        Upvalues:
            [1] = u63
            [2] = u21
        --]]
        local v78 = u63.ToolButton
        u21.CurrentDraggedButton = v78
        v78.Size = UDim2.new(0, v78.AbsoluteSize.X, 0, v78.AbsoluteSize.Y)
        v78.Parent = u21.BackpackGui
    end
    function u63.Drag.Dragged() --[[ Line: 357 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u10
            [3] = u63
        --]]
        if u15.Visible ~= false then
            if u10:GetSelectedHotbarButton() == u63.ToolButton then
                u10:UnequipCurrentTool()
            end
        end
    end
    function u63.Drag.DragEnded(p79) --[[ Line: 365 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u14
            [3] = u63
            [4] = u21
        --]]
        if p79 == nil then
            return
        end
        local v80 = p79.Position
        local v81 = u12:GetGuiObjectsAtPosition(v80.X, v80.Y)
        local v82 = nil
        for _, v83 in ipairs(v81) do
            if v83:IsA("Frame") and v83.Parent == u14 then
                v82 = v83
                break
            end
        end
        if v82 then
            local v84 = u63.ToolButton
            local v85 = v82:FindFirstChildOfClass("ImageButton")
            v84.Position = UDim2.new(0.5, 0, 0.5, 0)
            v84.Size = UDim2.new(1, 0, 1, 0)
            if v85 then
                local v86 = v85.HotbarObject
                local v87 = u63.HotbarObject.Value
                if u63.HotbarObject.Value == nil then
                    u63.HotbarObject.Value = v82
                    v84.Parent = v82
                    v86.Value = nil
                    u21.AutoPlaceToolButton(u21.Tools[v85.ToolObject.Value])
                else
                    u63.HotbarObject.Value = v82
                    v84.Parent = v82
                    v86.Value = v87
                    v85.Parent = v87
                end
            else
                u63.HotbarObject.Value = v82
                v84.Parent = v82
            end
        else
            u63.HotbarObject.Value = nil
            u21.AutoPlaceToolButton(u63)
        end
        u21.CurrentDraggedButton = nil
    end
    u21.Tools[u61] = u63
end
function u21.RemoveTool(p88) --[[ Line: 426 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u10
    --]]
    if p88:IsA("Tool") then
        local v89 = u21.Tools[p88]
        local v90 = p88.Parent
        if v90 == u21.Character then
            return
        elseif v90 == u21.Backpack then
            if v89.ToolButton == u10:GetSelectedHotbarButton() then
                u10:UnequipCurrentTool()
            end
        elseif v89 ~= nil then
            if v89.ToolButton == u10:GetSelectedHotbarButton() then
                u10:UnequipCurrentTool()
            end
            v89:Destroy()
            u21.Tools[p88] = nil
        end
    else
        return
    end
end
function u21.AssignSlot(_, p91, p92) --[[ Line: 461 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    if p91 <= 0 or p91 >= 11 then
        u21:DebugMessage(("Invalid Slot Number! Must be a number between 1-10. Received [%s]"):format(p91))
        return
    else
        local v93 = typeof(p92) == "Instance" and p92:IsA("Tool") and p92.Name or (typeof(p92) == "string" and p92 and p92 or nil)
        if v93 == nil then
            u21:DebugMessage("Invalid Object/Name")
        else
            u21.SavedSlots[p91] = v93
        end
    end
end
function u21.GetSavedSlots(_) --[[ Line: 479 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    return u21.SavedSlots
end
function u21.ClearAllTools(_) --[[ Line: 483 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u10
    --]]
    for v94, v95 in pairs(u21.Tools) do
        if v95.ToolButton == u10:GetSelectedHotbarButton() then
            u10:UnequipCurrentTool()
        end
        if v95.Destroy then
            v95:Destroy()
        end
        u21.Tools[v94] = nil
    end
end
local u96 = 0
local u97 = 0
function u21.EquipTool(p98, p99) --[[ Line: 501 ]]
    --[[
    Upvalues:
        [1] = u97
        [2] = u96
        [3] = u21
    --]]
    local v100 = tick()
    if v100 - u97 >= 0.1 then
        u96 = 0
    end
    u96 = u96 + 1
    if u96 > 6 then
        _G.displayMessage("<Color=Red>Too many equip attempts! Please wait.")
        return false
    end
    u97 = v100
    if p99.Parent ~= nil then
        if u21.Humanoid then
            u21.Humanoid:EquipTool(p99)
        end
        return true
    end
    print("Invalid Tool, Refresh", p99)
    p98:Refresh()
    return false
end
function u21.UnequipTools(_) --[[ Line: 530 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    if u21.Humanoid then
        u21.Humanoid:UnequipTools()
    end
end
function u21.SetVisible(_, p101) --[[ Line: 537 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    local v102 = u22
    if p101 == nil or not p101 then
        p101 = not u22.Visible
    end
    v102.Visible = p101
end
function u21.SetBackpackVisible(_, p103) --[[ Line: 541 ]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    local v104 = u15
    if p103 == nil or not p103 then
        p103 = not u15.Visible
    end
    v104.Visible = p103
end
function u21.Initialize() --[[ Line: 546 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u8
        [3] = u7
        [4] = u11
        [5] = u2
        [6] = u12
        [7] = u10
        [8] = u4
        [9] = u13
        [10] = u3
        [11] = u17
    --]]
    if u21.Initialized ~= true then
        u21.Maid = u8.new()
        local function v109() --[[ Line: 551 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u11
                [3] = u2
                [4] = u21
            --]]
            u7.spawn(function(p105, p106) --[[ Line: 552 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u2
                --]]
                if u11 == nil then
                    p106("Player Probably Left During Initialize")
                end
                local v107, _ = pcall(function() --[[ Line: 558 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    u2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                end)
                p105(v107)
            end):Catch(function(p108) --[[ Line: 563 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                u21:DebugMessage(p108)
            end)
        end
        v109()
        local function v112(p110) --[[ Line: 571 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u12
                [3] = u11
            --]]
            u21.LastRefresh = os.clock()
            u21:Refresh()
            u21.BackpackGui = u12:WaitForChild("BackpackGui")
            u21.Backpack = u11:FindFirstChild("Backpack") or u11:WaitForChild("Backpack")
            u21.Character = p110
            u21.Humanoid = p110:WaitForChild("Humanoid")
            while p110:GetAttribute("backpackLoaded") ~= true do
                task.wait()
            end
            task.wait()
            for _, v111 in ipairs(u21.Backpack:GetChildren()) do
                if v111:IsA("Tool") then
                    u21.AddTool(v111)
                end
            end
            u21.Maid:AddTask(p110.ChildAdded:Connect(u21.AddTool))
            u21.Maid:AddTask(p110.ChildRemoved:Connect(u21.RemoveTool))
            u21.Maid:AddTask(u21.Backpack.ChildAdded:Connect(u21.AddTool))
            u21.Maid:AddTask(u21.Backpack.ChildRemoved:Connect(u21.RemoveTool))
        end
        function u21.Refresh(_) --[[ Line: 610 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            u21:ClearAllTools()
            u21.Maid:Destroy()
            u21.Backpack = nil
            u21.Character = nil
            u21.Humanoid = nil
            u21.Tools = nil
            u21.Tools = {}
        end
        u10:Initialize(u21)
        u11.CharacterAdded:Connect(v112)
        v112(u11.Character or u11.CharacterAdded:Wait())
        u4.InputBegan:Connect(function(p113, p114) --[[ Line: 628 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u21
                [3] = u10
                [4] = u4
            --]]
            if not p114 and u13.Enabled ~= false then
                if p113.UserInputType == Enum.UserInputType.Keyboard then
                    local v115 = p113.KeyCode
                    if v115 == u21.BackpackKey then
                        u21:SetBackpackVisible()
                    end
                    if u10:GetKeyCode(v115) ~= nil and not u4:GetFocusedTextBox() then
                        u10:SelectKeyCode(v115)
                    end
                end
            end
        end)
        u21.Initialized = true
        local v116 = u3:WaitForChild("reservedCode")
        repeat
            task.wait(0.03333333333333333)
        until v116.Value ~= "checking"
        if v116.Value == "arena" then
            v109()
            local v117 = u3:WaitForChild("Matchinfo"):WaitForChild("matchStarted")
            u13.Enabled = false
            repeat
                task.wait(0.03333333333333333)
            until v117.Value == true
            warn("enlaging backpack!")
        end
        u13.Enabled = true
        u17.OnClientEvent:Connect(function(p118) --[[ Line: 669 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            u21:EquipTool(p118)
        end)
        return u21
    end
    u21:DebugMessage("Already Initialized!")
end
return u21