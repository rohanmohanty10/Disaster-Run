 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("UserInputService")
local u5 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v6 = v2:WaitForChild("Modules")
require(v6.Leveling)
local v7 = v6.Shared
require(v7.GameUtils)
local u8 = require(v7:WaitForChild("SoundUtils"))
local u9 = require(v6.Client.Notification)
local u10 = v2:WaitForChild("Events")
local u64 = {
    ["Initialized"] = false,
    ["Initialize"] = function(u11) --[[ Name: Initialize, Line 23 ]]
        --[[
        Upvalues:
            [1] = u64
            [2] = u5
            [3] = u8
            [4] = u3
            [5] = u9
            [6] = u10
            [7] = u4
        --]]
        if not u64.Initialized then
            local u12 = u5:WaitForChild("MenuWheel", 360)
            local u13 = u12:WaitForChild("Main")
            local u14 = u13:WaitForChild("Background")
            local v15 = u13:WaitForChild("Buttons")
            local u16 = v15:WaitForChild("Middle")
            local u17 = u13:WaitForChild("Title")
            local u18 = {}
            local u19 = os.clock()
            local u20 = false
            local u21 = false
            local u22 = "None"
            local u23 = nil
            local u24 = {}
            local function u27() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u8
                    [3] = u13
                    [4] = u3
                    [5] = u14
                    [6] = u16
                    [7] = u17
                    [8] = u18
                --]]
                u12.Enabled = true
                u8.PlaySound("MenuOpen", {
                    ["SoundCategory"] = "UI"
                })
                u13.Rotation = math.random(90, 180)
                u3:Create(u13, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                    ["Rotation"] = 0
                }):Play()
                u3:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Size"] = UDim2.new(0.35, 0, 0.35, 0)
                }):Play()
                task.wait(0.1)
                u16:TweenSize(UDim2.new(0.3, 0, 0.3, 0), "Out", "Quad", 0.1, true)
                task.wait(0.1)
                u3:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Size"] = UDim2.new(0.1, 0, 0.039, 0)
                }):Play()
                for v25, v26 in pairs(u18) do
                    if v25 ~= u16 then
                        v25.Visible = true
                        v25:TweenSizeAndPosition(v26.OriginalSize, v26.OriginalPosition, "Out", "Quad", 0.25, true)
                    end
                end
            end
            local function u29() --[[ Line: 94 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u3
                    [3] = u13
                    [4] = u17
                    [5] = u18
                    [6] = u16
                    [7] = u14
                    [8] = u12
                --]]
                u8.PlaySound("MenuClose", {
                    ["SoundCategory"] = "UI"
                })
                u3:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                    ["Rotation"] = -math.random(90, 180)
                }):Play()
                u3:Create(u17, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Size"] = UDim2.new(0, 0, 0, 0)
                }):Play()
                for u28, _ in pairs(u18) do
                    if u28 ~= u16 then
                        u28:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), u16.Position, "Out", "Quad", 0.1, true)
                        task.delay(0.1, function() --[[ Line: 122 ]]
                            --[[
                            Upvalues:
                                [1] = u28
                            --]]
                            u28.Visible = false
                        end)
                    end
                end
                task.wait(0.1)
                u16:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.1, true)
                u14:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), u14.Position, "Out", "Quad", 0.1, true)
                task.delay(0.1, function() --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                    --]]
                    u12.Enabled = false
                end)
            end
            local function u30() --[[ Line: 154 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u22
                    [3] = u24
                    [4] = u8
                    [5] = u23
                    [6] = u19
                    [7] = u20
                    [8] = u29
                    [9] = u27
                --]]
                if u21 == true then
                    return
                elseif u22 == "None" then
                    if os.clock() - u19 < 0.25 then
                        return
                    else
                        u19 = os.clock()
                        u20 = not u20
                        if u20 == false then
                            u29()
                        elseif u20 == true then
                            u27()
                        end
                    end
                else
                    u21 = true
                    if u24[u22] then
                        u8.PlaySound("MenuClose", {
                            ["SoundCategory"] = "UI"
                        })
                        u24[u22].Close()
                    end
                    u22 = "None"
                    u21 = false
                    u23 = nil
                    return
                end
            end
            local u31 = u5:WaitForChild("Statistics")
            local u32 = u31:WaitForChild("Main")
            local u33 = u32.Size
            u32.Size = UDim2.new(0, 0, 0, 0)
            u31.Enabled = false
            u24.Stats = {
                ["Open"] = function() --[[ Name: Open, Line 184 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u32
                        [3] = u31
                        [4] = u33
                    --]]
                    u23 = u32
                    u31.Enabled = true
                    u32.Visible = true
                    u32.Size = UDim2.new(u33.X.Scale / 2, 0, u33.Y.Scale / 2, 0)
                    u32:TweenSize(u33, "Out", "Quad", 0.25, true)
                end,
                ["Close"] = function() --[[ Name: Close, Line 193 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                        [2] = u31
                    --]]
                    u32:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
                    task.wait(0.25)
                    u31.Enabled = false
                    u32.Visible = false
                end
            }
            local u34 = u5:WaitForChild("Inventory")
            local u35 = u34:WaitForChild("Main")
            local u36 = u35.Size
            u34.Enabled = false
            task.spawn(function() --[[ Line: 209 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                local _ = u5:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").Size == UDim2.new(0, 120, 0, 120)
            end)
            u24.Inventory = {
                ["Open"] = function() --[[ Name: Open, Line 220 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u35
                        [3] = u34
                        [4] = u36
                    --]]
                    u23 = u35
                    u34.Enabled = true
                    u35.Visible = true
                    u35.Size = UDim2.new(u36.X.Scale / 2, 0, u36.Y.Scale / 2, 0)
                    u35:TweenSize(u36, "Out", "Quad", 0.25, true)
                end,
                ["Close"] = function() --[[ Name: Close, Line 229 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u34
                    --]]
                    u35:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
                    task.wait(0.25)
                    u34.Enabled = false
                    u35.Visible = false
                end
            }
            local u37 = u5:WaitForChild("Settings")
            local u38 = u37:WaitForChild("Main")
            local u39 = u38.Size
            u37.Enabled = false
            u24.Settings = {
                ["Open"] = function() --[[ Name: Open, Line 247 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u38
                        [3] = u37
                        [4] = u39
                    --]]
                    u23 = u38
                    u37.Enabled = true
                    u38.Visible = true
                    u38.Size = UDim2.new(u39.X.Scale / 2, 0, u39.Y.Scale / 2, 0)
                    u38:TweenSize(u39, "Out", "Quad", 0.25, true)
                end,
                ["Close"] = function() --[[ Name: Close, Line 256 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                        [2] = u37
                    --]]
                    u38:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
                    task.wait(0.25)
                    u37.Enabled = false
                    u38.Visible = false
                end
            }
            local u40 = u5:WaitForChild("Shop")
            local u41 = u40:WaitForChild("Main")
            local u42 = u41.Size
            u41.Size = UDim2.new(0, 0, 0, 0)
            u40.Enabled = false
            u24.Shop = {
                ["Open"] = function() --[[ Name: Open, Line 274 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u23
                        [3] = u41
                        [4] = u22
                        [5] = u40
                        [6] = u42
                    --]]
                    repeat
                        task.wait()
                    until _G.arena ~= nil
                    if _G.arena == true then
                        u9.DisplayMessage("Can not use shop in this universe!")
                        return
                    else
                        u23 = u41
                        u22 = "Shop"
                        if u40.Enabled ~= true then
                            u40.Enabled = true
                            u41.Visible = true
                            u41.Size = UDim2.new(u42.X.Scale / 2, 0, u42.Y.Scale / 2, 0)
                            u41:TweenSize(u42, "Out", "Quad", 0.25, true)
                        end
                    end
                end,
                ["Close"] = function() --[[ Name: Close, Line 295 ]]
                    --[[
                    Upvalues:
                        [1] = u41
                        [2] = u40
                    --]]
                    u41:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
                    task.wait(0.25)
                    u40.Enabled = false
                    u41.Visible = false
                end
            }
            local u43 = u5:WaitForChild("Crews")
            local u44 = u43:WaitForChild("Main")
            local u45 = u44.Size
            u44.Size = UDim2.new(0, 0, 0, 0)
            u43.Enabled = false
            u24.Crew = {
                ["Open"] = function() --[[ Name: Open, Line 313 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u23
                        [3] = u44
                        [4] = u43
                        [5] = u45
                    --]]
                    repeat
                        task.wait()
                    until _G.arena ~= nil
                    if _G.arena == true then
                        u9.DisplayMessage("Can not use crews in this universe!")
                    else
                        u23 = u44
                        u43.Enabled = true
                        u44.Visible = true
                        u44.Size = UDim2.new(u45.X.Scale / 2, 0, u45.Y.Scale / 2, 0)
                        u44:TweenSize(u45, "Out", "Quad", 0.25, true)
                    end
                end,
                ["Close"] = function() --[[ Name: Close, Line 331 ]]
                    --[[
                    Upvalues:
                        [1] = u44
                        [2] = u43
                    --]]
                    u44:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
                    task.wait(0.25)
                    u43.Enabled = false
                    u44.Visible = false
                end
            }
            u24.Boat = {
                ["OneClick"] = function() --[[ Name: OneClick, Line 342 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                    --]]
                    u10.ShipEvents.Spawn:InvokeServer("true")
                end
            }
            u14.Size = UDim2.new(0, 0, 0, 0)
            u16.Size = UDim2.new(0, 0, 0, 0)
            u17.Size = UDim2.new(0, 0, 0, 0)
            u13.Visible = true
            local u46 = u21
            local u47 = u23
            local u48 = u22
            local u49 = u20
            local u50 = false
            local u51 = false
            for _, u52 in ipairs(v15:GetChildren()) do
                if u52:IsA("ImageButton") then
                    local v53 = u52.ImageLabel
                    u52.MouseButton1Click:Connect(function() --[[ Line: 360 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                            [2] = u51
                            [3] = u11
                            [4] = u29
                            [5] = u49
                            [6] = u50
                            [7] = u24
                            [8] = u48
                        --]]
                        if u52.Size == UDim2.new(0, 0, 0, 0) then
                            return
                        elseif u51 ~= true then
                            u51 = true
                            u11.UIUtils.ButtonEffect()
                            u29()
                            u49 = false
                            u50 = true
                            task.spawn(function() --[[ Line: 371 ]]
                                --[[
                                Upvalues:
                                    [1] = u24
                                    [2] = u52
                                    [3] = u48
                                --]]
                                if u24[u52.Name] then
                                    if u24[u52.Name].OneClick then
                                        u24[u52.Name].OneClick()
                                    else
                                        u48 = u52.Name
                                        u24[u52.Name].Open()
                                    end
                                else
                                    print("no menu func for", u52.Name)
                                    return
                                end
                            end)
                            u51 = false
                            task.wait(0.25)
                            u50 = false
                        end
                    end)
                    v53.MouseEnter:Connect(function() --[[ Line: 390 ]]
                        --[[
                        Upvalues:
                            [1] = u17
                            [2] = u52
                        --]]
                        u17.TextLabel.Text = u52.Name
                        u52.Image = "http://www.roblox.com/asset/?id=15888186036"
                    end)
                    v53.MouseLeave:Connect(function() --[[ Line: 395 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                        --]]
                        u52.Image = "http://www.roblox.com/asset/?id=15913312197"
                    end)
                    u18[u52] = {
                        ["OriginalSize"] = u52.Size,
                        ["OriginalPosition"] = u52.Position
                    }
                    u52.Position = u16.Position
                    if u52 ~= u16 then
                        u52.Size = UDim2.new(0, 0, 0, 0)
                        u52.Visible = false
                    end
                end
            end
            local u59 = {
                [Enum.UserInputType.MouseButton1] = function(p54) --[[ Name: IsClickPositionValid, Line 410 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u46
                        [3] = u50
                        [4] = u30
                    --]]
                    if u47 ~= nil and (u46 == false and u50 == false) then
                        local v55 = u47.Parent:FindFirstChild("MouseFrame") or u47
                        local v56 = p54.Position
                        local v57 = v55.AbsoluteSize
                        local v58 = v55.AbsolutePosition
                        if v56.X > v58.X and (v56.X < v58.X + v57.X and (v56.Y > v58.Y and v56.Y < v58.Y + v57.Y)) then
                            return
                        end
                        u30()
                    end
                end,
                [Enum.KeyCode.M] = function(_) --[[ Line: 431 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                    --]]
                    u30()
                end
            }
            u4.InputBegan:Connect(function(p60, p61) --[[ Line: 436 ]]
                --[[
                Upvalues:
                    [1] = u59
                --]]
                if p61 then
                    return
                else
                    local v62 = p60.UserInputType
                    local v63 = p60.KeyCode
                    if u59[v62] then
                        u59[v62](p60)
                    elseif u59[v63] then
                        u59[v63](p60)
                    end
                end
            end)
            u64.MenuButtonFunctions = u24
            u64.SetMenuState = u30
            u64.Initialized = true
        end
    end
}
return u64