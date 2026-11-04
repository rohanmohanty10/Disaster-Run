 

local v1 = game:GetService("Players")
game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("UserInputService")
game:GetService("RunService")
local u4 = v1.LocalPlayer
local _ = u4.PlayerGui
local v5 = v2.Modules
local v6 = v2.Events
local u7 = v6.SaveButtons
local u8 = v6.DefaultButtons
local u9 = workspace.CurrentCamera
local u10 = u4:GetMouse()
local u11 = require(v5.ContextActionService)
local v12 = require(v5.Maid)
local u13 = require(v5.TableUtils)
local u14 = require(v5:WaitForChild("TopbarPlus"):WaitForChild("Icon"))
require(v5.Shared.Signals.Signal)
local u104 = {
    ["Editting"] = false,
    ["EdittingSize"] = false,
    ["Cached"] = {},
    ["Skills"] = {},
    ["Cleaner"] = v12.new(),
    ["Increment"] = 5,
    ["_changeButtons"] = function(u15, u16, u17, u18) --[[ Name: _changeButtons, Line 35 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
            [3] = u3
            [4] = u104
        --]]
        local u19 = u17.Button
        local v20 = u17.Callbacks
        local u21 = u15.Increment
        u18.Interactable = false
        if v20.InputEnded then
            v20.InputEnded()
        end
        u15.Cached[u16] = {
            ["Callbacks"] = v20,
            ["Animatable"] = u17.Animatable,
            ["Visible"] = u17.Frame.Visible
        }
        u17.Frame.Visible = true
        u17.Animatable = false
        local function v37() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u19
                [3] = u21
                [4] = u11
                [5] = u16
                [6] = u15
                [7] = u3
            --]]
            local u22 = Vector2.new(u10.X, u10.Y)
            local u23 = u19.AbsolutePosition + u19.AbsoluteSize / 2 - u22
            local function v36() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u22
                    [3] = u10
                    [4] = u23
                    [5] = u21
                    [6] = u11
                    [7] = u16
                --]]
                local v24 = u19.AbsoluteSize
                u22 = Vector2.new(u10.X, u10.Y) + u23
                local v25 = (u22.X + u21 / 2) / u21
                local v26 = math.floor(v25) * u21
                local v27 = (u22.Y + u21 / 2) / u21
                local v28 = math.floor(v27) * u21
                local v29 = u11
                local v30 = {
                    ["ButtonName"] = u16
                }
                local v31 = UDim2.fromOffset
                local v32 = v24.X / 2
                local v33 = u10.ViewSizeX - v24.X / 2
                local v34 = math.clamp(v26, v32, v33)
                local v35 = u10.ViewSizeY
                v30.Position = v31(v34, (math.clamp(v28, 0, v35)))
                v29:UpdatePosition(v30)
            end
            u15.Cleaner[u16] = u10.Move:Connect(v36)
            repeat
                u3.InputEnded:Wait()
            until not u3:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            if u15.Cleaner[u16] then
                u15.Cleaner[u16]:Disconnect()
                u15.Cleaner[u16] = nil
            end
        end
        local v38 = script["Size Drag"]:Clone()
        v38.Name = "EditSizeButton"
        v38.Visible = u104.EdittingSize
        v38.Parent = u19
        local v39 = script.EditMoveIcon:Clone()
        v39.Name = "EditMoveIcon"
        v39.Visible = true
        v39.Parent = u19
        local function v55() --[[ Line: 97 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u10
                [3] = u15
                [4] = u21
                [5] = u17
                [6] = u18
                [7] = u16
                [8] = u11
                [9] = u3
            --]]
            local u40 = u19.AbsolutePosition
            local function v54() --[[ Line: 100 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u40
                    [3] = u15
                    [4] = u21
                    [5] = u17
                    [6] = u18
                    [7] = u16
                    [8] = u11
                --]]
                local v41 = Vector2.new(u10.X, u10.Y) - u40
                local v42 = u15.MinimumButtonRadius
                local v43 = v41.X
                local v44 = v41.Y
                local v45 = math.max(v42, v43, v44)
                local v46 = u15.MaximumButtonRadius
                local v47 = math.min(v45, v46)
                local v48 = v47 / u21
                local v49 = math.ceil(v48) * u21
                local v50 = v47 / u21
                local v51 = math.ceil(v50) * u21
                u17.SizeRatio = Vector2.new(v49, v51) / u18.AbsoluteSize
                local v52 = UDim2.fromOffset(u18.AbsoluteSize.X * u17.SizeRatio.X, u18.AbsoluteSize.Y * u17.SizeRatio.Y)
                local v53 = {
                    ["ButtonName"] = u16,
                    ["Size"] = v52,
                    ["Position"] = UDim2.fromOffset(u40.X, u40.Y) + UDim2.fromOffset(v52.X.Offset * 0.5, v52.Y.Offset * 0.5)
                }
                u11:UpdateSize(v53)
                u11:UpdatePosition(v53)
            end
            u15.Cleaner[u16] = u10.Move:Connect(v54)
            repeat
                u3.InputEnded:Wait()
            until not u3:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            if u15.Cleaner[u16] then
                u15.Cleaner[u16]:Disconnect()
                u15.Cleaner[u16] = nil
            end
        end
        v38.MouseButton1Down:Connect(v55)
        u15.Cleaner:AddTask(v38)
        u15.Cleaner:AddTask(v39)
        local v56 = {
            ["ButtonName"] = u16,
            ["Callbacks"] = {
                ["InputBegan"] = v37
            }
        }
        u11:UpdateCallbacks(v56)
    end,
    ["_editButtons"] = function(u57) --[[ Name: _editButtons, Line 138 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        print("edit mode is on")
        local _, _, u58 = u11:GetMobileUI()
        u57.MaximumButtonRadius = u58.AbsoluteSize.X * 1.5
        u57.MinimumButtonRadius = u58.AbsoluteSize.X * 0.5
        local function v61(p59, p60) --[[ Line: 146 ]]
            --[[
            Upvalues:
                [1] = u57
                [2] = u58
            --]]
            u57:_changeButtons(p59, p60, u58)
        end
        for v62, v63 in u11.Buttons do
            u57:_changeButtons(v62, v63, u58)
        end
        u57.Cleaner:AddTask(u11.ButtonAdded:Connect(v61))
    end,
    ["_stopEdittingButtons"] = function(p64) --[[ Name: _stopEdittingButtons, Line 157 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u4
            [3] = u13
            [4] = u7
            [5] = u9
        --]]
        print("edit mode is off")
        local _, _, v65 = u11:GetMobileUI()
        v65.Interactable = true
        local v66 = u4:WaitForChild("PlayerScripts")
        local v67 = require(v66:WaitForChild("InputHandler"))
        for v68, v69 in p64.Cached do
            local v70 = u11:GetButtonData(v68)
            local _ = v70.Button
            v70.Frame.Visible = v69.Visible
            v70.Animatable = v69.Animatable
            u11:UpdateCallbacks({
                ["ButtonName"] = v68,
                ["Callbacks"] = v69.Callbacks
            })
        end
        local v71 = {}
        for v72, v73 in u11.Buttons do
            local v74 = {
                ["X"] = v73.Properties.Position.X.Offset,
                ["Y"] = v73.Properties.Position.Y.Offset,
                ["SizeRatio"] = {
                    ["X"] = v73.SizeRatio.X,
                    ["Y"] = v73.SizeRatio.Y
                }
            }
            v71[v72] = v74
        end
        for v75, v76 in p64.Skills do
            local v77 = v71[v76]
            v71[("Skill%*"):format(v75)] = u13:DeepCopy(v77)
        end
        v67.Inputs.Mobile.SavedButtons = v71
        u7:FireServer({
            ["Positions"] = v71,
            ["ViewportSize"] = u9.ViewportSize
        })
        p64.Cached = {}
        p64.Cleaner:Destroy()
    end,
    ["Initialize"] = function(u78) --[[ Name: Initialize, Line 205 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u11
            [3] = u4
            [4] = u8
            [5] = u9
        --]]
        local v79 = u14.new()
        v79:setLeft()
        v79:disableStateOverlay(true)
        v79:setImage("rbxassetid://13863907825", "deselected")
        v79:setImage("rbxassetid://13863903503", "selected")
        v79:setCaption("Edit Mobile Buttons")
        v79:setImageScale(0.7)
        local u80 = v79.new()
        u80:setLabel("Edit Button Sizes")
        local u81 = nil
        local function u82() --[[ Line: 222 ]]
            --[[
            Upvalues:
                [1] = u78
                [2] = u81
            --]]
            if _G.canuse then
                u78.Editting = not u78.Editting
                _G.mobileButtonsEditting = u78.Editting
                if u78.Editting == false and u81 then
                    u81:Destroy()
                    u81 = nil
                end
                if u78.Editting then
                    u78:_editButtons()
                else
                    u78:_stopEdittingButtons()
                end
            else
                return
            end
        end
        local function u84() --[[ Line: 241 ]]
            --[[
            Upvalues:
                [1] = u78
                [2] = u82
                [3] = u11
                [4] = u80
            --]]
            if _G.canuse then
                if not u78.Editting then
                    u82()
                end
                u78.EdittingSize = not u78.EdittingSize
                for _, v83 in u11.Buttons do
                    v83.Button.EditSizeButton.Visible = u78.EdittingSize
                end
                if u78.EdittingSize then
                    u80:setLabel("Tap to Stop Editing Sizes")
                else
                    u80:setLabel("Edit Button Sizes")
                end
            else
                return
            end
        end
        u80.toggled:Connect(u84)
        v79.toggled:Connect(function() --[[ Line: 266 ]]
            --[[
            Upvalues:
                [1] = u78
                [2] = u84
                [3] = u82
            --]]
            if u78.EdittingSize then
                u84()
            end
            u82()
        end)
        local v85 = v79.new()
        v85:setLabel("Reset Buttons")
        v85.selected:Connect(function() --[[ Line: 276 ]]
            --[[
            Upvalues:
                [1] = u81
                [2] = u4
                [3] = u11
                [4] = u8
                [5] = u9
                [6] = u78
            --]]
            if u81 then
                u81:Destroy()
                u81 = nil
            end
            local v103 = {
                [true] = function() --[[ Line: 282 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u11
                        [3] = u8
                        [4] = u9
                        [5] = u78
                    --]]
                    local v86 = u4:WaitForChild("PlayerScripts")
                    local v87 = require(v86:WaitForChild("InputHandler"))
                    local _, _, v88 = u11:GetMobileUI()
                    local v89 = u8:InvokeServer({
                        ["ViewportSize"] = u9.ViewportSize,
                        ["JumpButtonSize"] = v88.AbsoluteSize,
                        ["Increments"] = u78.Increment
                    })
                    for v90, v91 in v89 do
                        u11:UpdateSize({
                            ["ButtonName"] = v90,
                            ["Size"] = UDim2.fromOffset(v91.SizeRatio.X * v88.AbsoluteSize.X, v91.SizeRatio.Y * v88.AbsoluteSize.Y)
                        })
                        u11:UpdatePosition({
                            ["ButtonName"] = v90,
                            ["Position"] = UDim2.fromOffset(v91.X, v91.Y)
                        })
                        u11.Buttons[v90].SizeRatio = v91.SizeRatio
                    end
                    local v92 = #u78.Skills - 1
                    local v93 = math.max(v92, 5)
                    local v94, _ = u11:GetPositionAndSize()
                    local v95 = u11:GetButton("Block")
                    local v96 = 0
                    for v97, v98 in u78.Skills do
                        v96 = v96 + 1
                        local v99 = 2.356194490192345 + 4.71238898038469 / v93 * v96
                        local v100 = v94.X.Offset * 1.75
                        local v101 = v95.Position + UDim2.new(0, math.sin(v99) * v100, 0, -math.cos(v99) * v100)
                        u11.Buttons[v98].SizeRatio = {
                            ["X"] = 0.75,
                            ["Y"] = 0.75
                        }
                        local v102 = {
                            ["X"] = v101.X.Offset,
                            ["Y"] = v101.Y.Offset,
                            ["SizeRatio"] = {
                                ["X"] = 0.75,
                                ["Y"] = 0.75
                            }
                        }
                        v89[v98] = v102
                        u11:UpdatePosition({
                            ["ButtonName"] = v98,
                            ["Position"] = v101
                        })
                        u11:UpdateSize({
                            ["ButtonName"] = v98,
                            ["Size"] = UDim2.fromOffset(0.75 * v88.AbsoluteSize.X, 0.75 * v88.AbsoluteSize.Y)
                        })
                        v89[("Skill%*"):format(v97)] = nil
                    end
                    v87.Inputs.Mobile.SavedButtons = v89
                end
            }
            u81 = _G.promptQuestion(game.Players.LocalPlayer, "Are you sure you want to RESET BUTTONS?", v103)
        end)
        v79:setMenu({ u80, v85 })
    end
}
return u104