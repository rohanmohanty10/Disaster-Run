 

local v1 = game:GetService("Players")
game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
game:GetService("TweenService")
local u2 = game:GetService("CollectionService")
local u3 = game:GetService("ReplicatedStorage")
local v4 = u3:WaitForChild("Modules")
local v5 = v4:WaitForChild("Shared")
local v6 = v5:WaitForChild("Signals")
local v7 = require(v6:WaitForChild("GoodSignal"))
local u8 = game:GetService("RunService")
local v9 = v5:WaitForChild("Promises")
local u10 = require(v9:WaitForChild("Promise"))
local u11 = require(u3.Modules.Trove)
local u12 = require(v5:WaitForChild("GamePlaceInfo"))
local u13 = require(v5.GameUtils)
require(u3.Modules.MEnterLeave)
local u14 = v1.LocalPlayer
local u15 = u14:WaitForChild("PlayerGui")
local u46 = {
    ["GuiModules"] = {},
    ["UIStrokes"] = {},
    ["Whitelist"] = {
        [73169236] = true,
        [38079729] = true,
        [100195140] = true
    },
    ["StatsFolder"] = nil,
    ["OnStatsFolderLoaded"] = v7.new(),
    ["ItemRotation"] = true,
    ["GetWhitelist"] = function(_) --[[ Name: GetWhitelist, Line 49 ]]
        --[[
        Upvalues:
            [1] = u46
        --]]
        return u46.Whitelist
    end,
    ["GetStatsFolder"] = function(_) --[[ Name: GetStatsFolder, Line 53 ]]
        --[[
        Upvalues:
            [1] = u46
        --]]
        return u46.StatsFolder or u46.OnStatsFolderLoaded:Wait()
    end,
    ["Initialize"] = function(_) --[[ Name: Initialize, Line 57 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u14
            [3] = u10
            [4] = u46
            [5] = u13
            [6] = u15
            [7] = u12
            [8] = u11
            [9] = u8
            [10] = u2
        --]]
        local v16 = u3:WaitForChild("reservedCode")
        while v16.Value == "checking" do
            task.wait(1)
        end
        local u17 = u3.GUIS:GetChildren()
        if #u17 == 0 then
            u17 = u3.GUIS.ChildAdded:Wait()
            if u17 then
                u17 = u3.GUIS:GetChildren()
            end
        end
        local function v19() --[[ Line: 70 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u14
            --]]
            for _, v18 in u17 do
                if not u14.PlayerGui:FindFirstChild(v18.Name) then
                    v18:Clone().Parent = u14.PlayerGui
                end
            end
        end
        u14.CharacterAdded:Connect(v19)
        v19()
        local function u24() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u3
                [3] = u14
                [4] = u46
                [5] = u24
            --]]
            u10.spawn(function(p20, p21) --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u14
                --]]
                local v22 = u3:FindFirstChild("Stats" .. u14.Name)
                if not v22 then
                    p21(v22)
                end
                p20(v22)
            end):Then(function(p23) --[[ Line: 95 ]]
                --[[
                Upvalues:
                    [1] = u46
                --]]
                p23:WaitForChild("Stats")
                u46.StatsFolder = p23
                u46.OnStatsFolderLoaded:Fire(p23)
            end):Catch(function(_) --[[ Line: 100 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                task.wait(1)
                u24()
            end)
        end
        u24()
        u3:WaitForChild("Stats" .. u14.Name):WaitForChild("Stats")
        local u25 = script:WaitForChild("Guis")
        local function u28(p26) --[[ Line: 117 ]]
            --[[
            Upvalues:
                [1] = u46
            --]]
            for _, v27 in ipairs(p26:GetChildren()) do
                print("initializng", v27)
                u46.GuiModules[v27.Name] = require(v27)
                task.spawn(u46.GuiModules[v27.Name].Initialize, u46)
            end
        end
        if not u14.Character then
            u14.CharacterAdded:Wait()
        end
        while _G.hideUI == nil or _G.HasBaseItem == nil do
            task.wait()
        end
        if u13.GetInputType() ~= "PC" and u13.GetInputType() ~= "Console" then
            local v29 = u15:GetDescendants()
            for v30 = 1, #v29 do
                if v29[v30].Name == "DeviceUIScale" then
                    v29[v30].Scale = v29[v30]:GetAttribute("CustomScale") or 1.3
                elseif v29[v30]:GetAttribute("DeviceScale") then
                    local v31 = v29[v30]:GetAttribute("DeviceScale")
                    local v32 = v29[v30].Size
                    v29[v30].Size = UDim2.new(v32.X.Scale * v31, v32.X.Offset * v31, v32.Y.Scale * v31, v32.Y.Offset * v31)
                end
            end
            pcall(function() --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                u15:WaitForChild("Compass", 5).IgnoreGuiInset = false
            end)
            warn("not pc", u13.GetInputType())
        end
        u28(u25:WaitForChild("Core"))
        task.spawn(function() --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u28
                [3] = u25
            --]]
            local v33 = u12:GetPlaceIds()[game.PlaceId]
            if v33 ~= nil and (v33 == "Trade Hub" or v33 == "VC Trade Hub") then
                u28(u25:WaitForChild("TradeHub"))
            end
        end)
        local u34 = game.Players.LocalPlayer:GetMouse()
        local function u43(u35, p36) --[[ Line: 167 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u34
                [3] = u11
                [4] = u8
            --]]
            if p36 == nil then
                if u35:GetAttribute("EnableMouseSelectionHoverEnabled") then
                    return
                end
            else
                local v37 = u35:FindFirstChild("SelectionStroke")
                if v37 then
                    v37:Destroy()
                end
            end
            if u35:IsDescendantOf(u15) ~= false then
                u35:SetAttribute("EnableMouseSelectionHoverEnabled", true)
                local u38 = script.SelectionStroke:Clone()
                u38.Parent = u35
                u35.MouseEnter:Connect(function() --[[ Line: 190 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                        [2] = u34
                        [3] = u11
                        [4] = u8
                        [5] = u35
                    --]]
                    u38.Enabled = true
                    script.HoverUI:Play()
                    local u39 = u11.new()
                    u39:Add(u8.Heartbeat:Connect(function() --[[ Line: 207 ]]
                        --[[
                        Upvalues:
                            [1] = u35
                            [2] = u34
                            [3] = u38
                            [4] = u39
                        --]]
                        local v40 = u35
                        local v41 = u34.X
                        local v42 = u34.Y
                        if (v40.AbsolutePosition.X < v41 and (v40.AbsolutePosition.Y < v42 and (v41 < v40.AbsolutePosition.X + v40.AbsoluteSize.X and v42 < v40.AbsolutePosition.Y + v40.AbsoluteSize.Y))) == false then
                            u38.Enabled = false
                            u39:Destroy()
                            u39 = nil
                        end
                    end))
                end)
            end
        end
        u2:GetInstanceAddedSignal("EnableMouseSelectionHover"):Connect(function(p44) --[[ Line: 232 ]]
            --[[
            Upvalues:
                [1] = u43
            --]]
            u43(p44, true)
        end)
        for _, v45 in pairs(u2:GetTagged("EnableMouseSelectionHover")) do
            u43(v45)
        end
    end,
    ["UIUtils"] = require(v4.Client.UIUtils)
}
return u46