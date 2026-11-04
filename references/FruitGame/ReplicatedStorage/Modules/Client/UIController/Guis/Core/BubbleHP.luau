 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = v1.LocalPlayer
local u4 = u3:WaitForChild("PlayerGui")
local v5 = v2:WaitForChild("Modules")
local u6 = require(v5.Trove)
local v7 = v5.Shared
require(v7.GameUtils)
v2:WaitForChild("Events")
local u23 = {
    ["Initialized"] = false,
    ["Initialize"] = function(_) --[[ Name: Initialize, Line 18 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u4
            [3] = u6
            [4] = u3
        --]]
        if not u23.Initialized then
            local u8 = u4:WaitForChild("BubbleHP", 360):WaitForChild("Main")
            local u9 = u8:WaitForChild("Bubble")
            local u10 = u6.new()
            local u11 = nil
            local function v17(u12) --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u11
                    [3] = u8
                    [4] = u9
                --]]
                u10:Clean()
                u11 = u12
                local u13 = nil
                u8.Visible = false
                local function v16(u14) --[[ Line: 39 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                        [2] = u12
                        [3] = u13
                        [4] = u8
                        [5] = u9
                    --]]
                    if u14.Name == "coatBubble" and (u11 == u12 and u13 == nil) then
                        u8.Visible = false
                        u9.Size = UDim2.new(1, 0, 1, 0)
                        u13 = u14
                        task.spawn(function() --[[ Line: 46 ]]
                            --[[
                            Upvalues:
                                [1] = u8
                                [2] = u11
                                [3] = u12
                                [4] = u13
                                [5] = u14
                                [6] = u9
                            --]]
                            while true do
                                u8.Visible = true
                                task.wait(0.2)
                                if u11 ~= u12 or u13 == nil then
                                    break
                                end
                                local v15 = u14.Health.Value / u14.Health.MaxValue
                                u9.Size = UDim2.new(v15, 0, v15, 0)
                                if v15 <= 0 then
                                    break
                                end
                            end
                            u13 = nil
                            u8.Visible = false
                        end)
                    end
                end
                u10:Add(u12.ChildAdded:Connect(v16))
            end
            local u18 = u3.Character or u3.CharacterAdded:Wait()
            u10:Clean()
            u11 = u18
            local u19 = nil
            u8.Visible = false
            local function v22(u20) --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u18
                    [3] = u19
                    [4] = u8
                    [5] = u9
                --]]
                if u20.Name == "coatBubble" and (u11 == u18 and u19 == nil) then
                    u8.Visible = false
                    u9.Size = UDim2.new(1, 0, 1, 0)
                    u19 = u20
                    task.spawn(function() --[[ Line: 46 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u11
                            [3] = u18
                            [4] = u19
                            [5] = u20
                            [6] = u9
                        --]]
                        while true do
                            u8.Visible = true
                            task.wait(0.2)
                            if u11 ~= u18 or u19 == nil then
                                break
                            end
                            local v21 = u20.Health.Value / u20.Health.MaxValue
                            u9.Size = UDim2.new(v21, 0, v21, 0)
                            if v21 <= 0 then
                                break
                            end
                        end
                        u19 = nil
                        u8.Visible = false
                    end)
                end
            end
            u10:Add(u18.ChildAdded:Connect(v22))
            u3.CharacterAdded:Connect(v17)
            u23.Initialized = true
        end
    end
}
return u23