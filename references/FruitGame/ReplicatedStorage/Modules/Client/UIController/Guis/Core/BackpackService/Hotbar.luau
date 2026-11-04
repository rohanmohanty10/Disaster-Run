 

local u1 = game:GetService("UserInputService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("HttpService")
local v4 = game:GetService("Players")
local v5 = u2:WaitForChild("Modules"):WaitForChild("Shared")
local u6 = require(v5:WaitForChild("Queues"):WaitForChild("QueueTask"))
local u7 = v4.LocalPlayer
local u8 = nil
local u9 = nil
local u10 = {
    ["One"] = 1,
    ["Two"] = 2,
    ["Three"] = 3,
    ["Four"] = 4,
    ["Five"] = 5,
    ["Six"] = 6,
    ["Seven"] = 7,
    ["Eight"] = 8,
    ["Nine"] = 9,
    ["Zero"] = 10
}
local u53 = {
    ["SelectedHotbarButton"] = nil,
    ["KeyCodeDictionary"] = {},
    ["HotbarSlotNumber"] = {},
    ["GetSelectedHotbarButton"] = function(_) --[[ Name: GetSelectedHotbarButton, Line 35 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        return u53.SelectedHotbarButton
    end,
    ["UnequipCurrentTool"] = function(_) --[[ Name: UnequipCurrentTool, Line 39 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        if u53:GetSelectedHotbarButton() ~= nil then
            u53.SelectedHotbarButton:SetAttribute("Selected", false)
            u53.SelectedHotbarButton = nil
            u53.BackpackService:UnequipTools()
        end
    end,
    ["SelectTool"] = function(_, p11) --[[ Name: SelectTool, Line 52 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        local v12 = u53.BackpackService
        if v12.Humanoid == nil then
            return
        elseif v12.Backpack == nil then
            return
        elseif v12.Character == nil then
            return
        elseif u53.SelectedHotbarButton == p11 then
            u53:UnequipCurrentTool()
        else
            u53:UnequipCurrentTool()
            local v13 = p11.ToolObject.Value
            if v13 ~= nil and (v13:IsA("Tool") and v12:EquipTool(v13) == true) then
                u53.SelectedHotbarButton = p11
                u53.SelectedHotbarButton:SetAttribute("Selected", true)
            end
        end
    end,
    ["GetKeyCode"] = function(_, p14) --[[ Name: GetKeyCode, Line 90 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        if u53.KeyCodeDictionary[p14] then
            return u53.KeyCodeDictionary[p14]
        else
            return nil
        end
    end,
    ["SelectKeyCode"] = function(_, p15) --[[ Name: SelectKeyCode, Line 99 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        local v16 = u53:GetKeyCode(p15)
        local v17 = v16 ~= nil and v16.HotbarFrame:FindFirstChildOfClass("ImageButton")
        if v17 then
            u53:SelectTool(v17)
        end
    end,
    ["GetEmptyHotbar"] = function(_) --[[ Name: GetEmptyHotbar, Line 111 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        for v18, v19 in ipairs(u53.HotbarSlotNumber) do
            if not v19:FindFirstChildOfClass("ImageButton") then
                return v18
            end
        end
        return nil
    end,
    ["GetFrameSlot"] = function(_, p20) --[[ Name: GetFrameSlot, Line 123 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        return u53.HotbarSlotNumber[p20]
    end,
    ["SetHotbarNumbersVisible"] = function(_, _) --[[ Name: SetHotbarNumbersVisible, Line 127 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        for _, v21 in ipairs(u9:GetChildren()) do
            if v21:IsA("Frame") then
                local v22 = v21:FindFirstChild("Number")
                if v22 then
                    v22.Visible = false
                end
            end
        end
    end,
    ["Initialize"] = function(_, p23) --[[ Name: Initialize, Line 138 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u53
            [3] = u8
            [4] = u9
            [5] = u7
            [6] = u3
            [7] = u10
            [8] = u6
            [9] = u1
        --]]
        local u24 = u2.Events:WaitForChild("Hotbar")
        u53.BackpackService = p23
        local v25 = p23.BackpackGui
        u8 = v25:WaitForChild("Backpack")
        u9 = v25:WaitForChild("Hotbar")
        u53.BackpackGui = v25
        local u26 = u9:WaitForChild("UIScale")
        local v27 = v25.AbsoluteSize
        local v28 = v27.X
        local v29 = v27.Y
        if math.min(v28, v29) <= 500 then
            u26.Scale = 1.5
        end
        task.spawn(function() --[[ Line: 161 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u26
            --]]
            local v30 = u7.PlayerGui:WaitForChild("TouchGui", 60)
            if v30 then
                if v30:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").Size == UDim2.new(0, 120, 0, 120) then
                    u26.Scale = 1.5
                end
            end
        end)
        local u31 = u2:WaitForChild("Stats" .. u7.Name):WaitForChild("Inventory"):WaitForChild("HotbarOrder")
        local u32 = os.clock()
        local function v33(_) --[[ Line: 179 ]]
            --[[
            Upvalues:
                [1] = u32
            --]]
            print("this was suppose to run")
            u32 = os.clock()
        end
        if not u7.Character then
            u7.CharacterAdded:Wait()
        end
        print("this was suppose to run")
        u32 = os.clock()
        u7.CharacterAdded:Connect(v33)
        u7.CharacterRemoving:Connect(v33)
        function u53.GetClientHotbar(_, p34) --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u3
                [3] = u31
                [4] = u10
            --]]
            local v35 = {}
            for _, v36 in pairs(u9:GetChildren()) do
                if v36:IsA("Frame") then
                    local v37 = v36:FindFirstChildOfClass("ImageButton")
                    if v37 then
                        local v38 = v37.ToolObject.Value
                        v35[v36.Name] = v38.Name
                    else
                        v35[v36.Name] = "None"
                        if v36 ~= p34 then
                            local v39 = u3:JSONDecode(u31.Value)[u10[v36.Name]]
                            if v39 and v39 ~= "None" then
                                v35[v36.Name] = v39
                            end
                        end
                    end
                end
            end
            return v35
        end
        for _, u40 in pairs(u9:GetChildren()) do
            if u40:IsA("Frame") then
                u40:SetAttribute("Disabled", false)
                local u41 = u40:WaitForChild("Design")
                u40.Visible = false
                local u42 = false
                local u43 = nil
                u8:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 233 ]]
                    --[[
                    Upvalues:
                        [1] = u40
                        [2] = u8
                        [3] = u42
                    --]]
                    if u40:GetAttribute("Disabled") == true then
                        return
                    elseif u8.Visible == true and u42 == false then
                        u40.Visible = true
                    elseif u8.Visible == false and u42 == false then
                        u40.Visible = false
                    end
                end)
                local u44 = u6.new()
                u40.ChildAdded:Connect(function(u45) --[[ Line: 244 ]]
                    --[[
                    Upvalues:
                        [1] = u44
                        [2] = u43
                        [3] = u42
                        [4] = u40
                        [5] = u41
                        [6] = u3
                        [7] = u31
                        [8] = u10
                        [9] = u24
                        [10] = u53
                    --]]
                    if u45:IsA("ImageButton") then
                        u44:QueueTask(function() --[[ Line: 246 ]]
                            --[[
                            Upvalues:
                                [1] = u43
                                [2] = u45
                                [3] = u42
                                [4] = u40
                                [5] = u41
                                [6] = u3
                                [7] = u31
                                [8] = u10
                                [9] = u24
                                [10] = u53
                            --]]
                            u43 = u45
                            u42 = true
                            u40.Visible = true
                            u41.ImageTransparency = 1
                            local v46 = u45.ToolObject.Value
                            local v47 = u3:JSONDecode(u31.Value)
                            if table.find(v47, v46.Name) ~= u10[u40.Name] then
                                u24:FireServer(u53:GetClientHotbar())
                            end
                        end)
                    end
                end)
                u40.ChildRemoved:Connect(function(u48) --[[ Line: 270 ]]
                    --[[
                    Upvalues:
                        [1] = u44
                        [2] = u43
                        [3] = u42
                        [4] = u41
                        [5] = u8
                        [6] = u40
                    --]]
                    if u48:IsA("ImageButton") then
                        u44:QueueTask(function() --[[ Line: 272 ]]
                            --[[
                            Upvalues:
                                [1] = u43
                                [2] = u48
                                [3] = u42
                                [4] = u41
                                [5] = u8
                                [6] = u40
                            --]]
                            if u43 == u48 then
                                u42 = false
                                u41.ImageTransparency = 0.5
                                if u8.Visible == false then
                                    u40.Visible = false
                                elseif u8.Visible == true then
                                    u40.Visible = true
                                end
                            else
                                return
                            end
                        end)
                    end
                end)
            end
        end
        u53.KeyCodeDictionary = {
            [Enum.KeyCode.One] = {
                ["HotbarFrame"] = u9.One
            },
            [Enum.KeyCode.Two] = {
                ["HotbarFrame"] = u9.Two
            },
            [Enum.KeyCode.Three] = {
                ["HotbarFrame"] = u9.Three
            },
            [Enum.KeyCode.Four] = {
                ["HotbarFrame"] = u9.Four
            },
            [Enum.KeyCode.Five] = {
                ["HotbarFrame"] = u9.Five
            },
            [Enum.KeyCode.Six] = {
                ["HotbarFrame"] = u9.Six
            },
            [Enum.KeyCode.Seven] = {
                ["HotbarFrame"] = u9.Seven
            },
            [Enum.KeyCode.Eight] = {
                ["HotbarFrame"] = u9.Eight
            },
            [Enum.KeyCode.Nine] = {
                ["HotbarFrame"] = u9.Nine
            },
            [Enum.KeyCode.Zero] = {
                ["HotbarFrame"] = u9.Zero
            }
        }
        u53.HotbarSlotNumber = {
            u9.One,
            u9.Two,
            u9.Three,
            u9.Four,
            u9.Five,
            u9.Six,
            u9.Seven,
            u9.Eight,
            u9.Nine,
            u9.Zero
        }
        local v49 = u7:WaitForChild("PlayerScripts"):WaitForChild("InputHandler")
        local v50 = require(v49:WaitForChild("GetPreferredInput"))
        print("preferredinput", v50)
        if v50.Current == "Mobile" then
            print("its mobile, disable buttons")
            for v51 = 6, 10 do
                print("Disabled", v51)
                local v52 = u53.HotbarSlotNumber[v51]
                v52:SetAttribute("Disabled", true)
                v52.Visible = false
            end
        end
        if u1.KeyboardEnabled == false then
            u53:SetHotbarNumbersVisible(false)
        end
    end
}
return u53