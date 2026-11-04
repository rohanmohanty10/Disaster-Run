 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = v1.LocalPlayer
local u4 = u3:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Modules")
local u6 = require(v5.Trove)
local v7 = v5.Shared
require(v7.GameUtils)
local u8 = v2:WaitForChild("Events")
local u25 = {
    ["Initialized"] = false,
    ["Initialize"] = function(p9) --[[ Name: Initialize, Line 18 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u4
            [3] = u3
            [4] = u8
            [5] = u6
        --]]
        if not u25.Initialized then
            p9:GetStatsFolder():WaitForChild("Gamepasses"):WaitForChild("FruitBag")
            local u10 = u4:WaitForChild("StoreFruit", 360):WaitForChild("Store")
            local u11 = u10:WaitForChild("Text")
            u10.Visible = false
            local function u13() --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u11
                    [3] = u10
                --]]
                local v12 = u3.Character:FindFirstChildOfClass("Tool")
                u11.Text = v12 and v12.Name == "Dark Root" and "Store Dark Root" or "Store Fruit"
                if v12 and v12:FindFirstChild("FruitEater") then
                    u10.Visible = true
                else
                    u10.Visible = false
                end
            end
            u10.MouseButton1Click:Connect(function() --[[ Line: 50 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u11
                    [3] = u8
                --]]
                local v14 = u3.Character
                if v14 == nil then
                    return
                else
                    local v15 = v14:FindFirstChild("Humanoid")
                    if v15 == nil then
                        return
                    elseif v15.Health <= 0 then
                        return
                    else
                        local v16 = v14:FindFirstChildOfClass("Tool")
                        local v17
                        if v16 then
                            v17 = v16:FindFirstChild("FruitEater")
                        else
                            v17 = v16
                        end
                        local v18 = v16 and v16.Name == "Dark Root" and "Store Dark Root" or "Store Fruit"
                        local v19 = _G.HasItem(u3, "Prestige Fruitbag")
                        local v20 = _G.fruitsInStorage(u3, v16.Name)
                        local v21 = v19 == false and "One" or "Two"
                        if #v20 >= 1 and v19 == false then
                            _G.displayMessage((("<Color=Red>You can only store %* fruit at a time.<Color=/> Discard your <Color=Orange>%*<Color=/> in inventory by equiping it and dropping or buy a <Color=Green>Fruit Bag<Color=/> to store another fruit!"):format(v21, v20[1])))
                            return
                        elseif v16 and (v17 and v17.Busy.Value == true) then
                            u11.Text = "BUSY"
                            task.wait(0.2)
                            u11.Text = v18
                        else
                            u11.Text = "Storing..."
                            u8.FruitStorage:InvokeServer(true)
                            u11.Text = v18
                        end
                    end
                end
            end)
            local u22 = u6.new()
            local v23 = u3.Character or u3.CharacterAdded:Wait()
            u10.Visible = false
            u22:Clean()
            u22:Add(v23.ChildAdded:Connect(u13))
            u22:Add(v23.ChildRemoved:Connect(u13))
            u3.CharacterAdded:Connect(function(p24) --[[ Name: CharacterAdded, Line 93 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u22
                    [3] = u13
                --]]
                u10.Visible = false
                u22:Clean()
                u22:Add(p24.ChildAdded:Connect(u13))
                u22:Add(p24.ChildRemoved:Connect(u13))
            end)
            u25.Initialized = true
        end
    end
}
return u25