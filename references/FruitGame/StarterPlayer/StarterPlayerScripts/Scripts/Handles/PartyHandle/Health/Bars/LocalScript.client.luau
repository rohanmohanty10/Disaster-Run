 

repeat
    task.wait()
until script.char.Value ~= nil
local v1 = script.char.Value
local u2 = v1:WaitForChild("Humanoid", 120)
local u3 = {}
local u4 = game.Players:GetPlayerFromCharacter(v1)
local u5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u6 = math.floor
local u7 = math.pow
local u8 = math.ceil
local v9 = game:GetService("Teams")
local v10 = game:GetService("Players")
local u11 = v9:FindFirstChild("Players")
local u12 = v9:FindFirstChild("Eliminated")
local u13 = script.Parent.HealthBar
local u14 = script.Parent.StaminaBar
local u15 = script.Parent.Parent.TextLabel
local function u35(p16, p17, p18) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u4
        [3] = u6
        [4] = u3
        [5] = u7
        [6] = u8
    --]]
    if u11 and (u4 and u4.Team ~= u11) then
        warn("ret bec not alive!")
    else
        local v19 = u6(p17)
        local v20 = u6(p18)
        local v21 = (v19 < 0 and 0 or v19) / v20
        local v22 = p16.bar.Size.X.Scale
        if u3[p16.Name] == nil then
            u3[p16.Name] = 0
        end
        if u3[p16.Name] ~= v21 then
            local v23 = v22 - v21
            local v24 = v21 >= 1 and 1 or v21
            u3[p16.Name] = v24
            local v25 = u7(10, 3 or 0)
            local v26 = v24 * v25
            local v27
            if v26 >= 0 then
                v27 = u6(v26 + 0.5)
            else
                v27 = u8(v26 - 0.5)
            end
            local v28 = v27 / v25
            local v29 = p16.bar.Size.X.Scale
            local v30 = u7(10, 3 or 0)
            local v31 = v29 * v30
            local v32
            if v31 >= 0 then
                v32 = u6(v31 + 0.5)
            else
                v32 = u8(v31 - 0.5)
            end
            if v28 ~= v32 / v30 then
                p16.bar:TweenSize(UDim2.new(v24, 0, 1, 0), "Out", "Quad", 0.25, true)
            end
            if v23 > 0 then
                if p16.bar.Parent:FindFirstChild("a") then
                    p16.bar.Parent.a:Destroy()
                end
                local v33 = p16.bar:Clone()
                v33.Name = "a"
                v33.ZIndex = 2
                v33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                v33.Size = UDim2.new(v23, 0, 1, 0)
                v33.Position = UDim2.new(v24, 0, 0.5, 0)
                v33:ClearAllChildren()
                v33.Parent = p16.bar.Parent
                local v34 = v23 + 0.25
                _G.tween(v33, {
                    v34,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["BackgroundTransparency"] = 1,
                    ["Size"] = UDim2.new(0, 0, 1, 0)
                })
                _G.destroy(v33, v34)
            end
        end
    end
end
local u36, u37
if u2 then
    u36 = u2:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u13
            [3] = u2
        --]]
        u35(u13, u2.Health, u2.MaxHealth)
    end)
    u37 = u2:GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u13
            [3] = u2
        --]]
        u35(u13, u2.Health, u2.MaxHealth)
    end)
else
    u36 = nil
    u37 = nil
end
if u5 and u5:FindFirstChild("Stamina") then
    u5.Stamina.Changed:Connect(function() --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u14
            [3] = u5
        --]]
        u35(u14, u5.Stamina.Value, u5.Stamina.MaxValue)
    end)
end
if u2 then
    u35(u13, u2.Health, u2.MaxHealth)
end
if u5 and u5:FindFirstChild("Stamina") then
    u35(u14, u5.Stamina.Value, u5.Stamina.MaxValue)
end
if u4 then
    local v38 = u4:FindFirstChild("leaderstats")
    local u39 = v38 and v38:FindFirstChild("Lives")
    if u39 then
        u39:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u35
                [3] = u13
                [4] = u2
                [5] = u14
                [6] = u5
                [7] = u15
            --]]
            if u39.Value < 0 then
                u35(u13, 0, u2.MaxHealth)
                u35(u14, 0, u5.Stamina.MaxValue)
                u15.TextColor3 = u13.BackgroundColor3
                u13.bar.Visible = false
                u14.bar.Visible = false
            else
                u13.bar.Visible = true
                u14.bar.Visible = true
                u15.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)
    end
    u4:GetPropertyChangedSignal("Team"):Connect(function() --[[ Line: 144 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u12
            [3] = u35
            [4] = u13
            [5] = u2
            [6] = u14
            [7] = u5
            [8] = u15
        --]]
        if u4.Team == u12 then
            u35(u13, 0, u2.MaxHealth)
            u35(u14, 0, u5.Stamina.MaxValue)
            u15.TextColor3 = u13.BackgroundColor3
            u13.bar.Visible = false
            u14.bar.Visible = false
        else
            u13.bar.Visible = true
            u14.bar.Visible = true
            u15.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
    u4.CharacterAdded:Connect(function(p40) --[[ Line: 160 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u37
            [3] = u2
            [4] = u35
            [5] = u13
        --]]
        if u36 then
            u36:Disconnect()
        end
        if u37 then
            u37:Disconnect()
        end
        u2 = p40:WaitForChild("Humanoid", 120)
        if u2 then
            u36 = u2:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 174 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u13
                    [3] = u2
                --]]
                u35(u13, u2.Health, u2.MaxHealth)
            end)
            u37 = u2:GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 178 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u13
                    [3] = u2
                --]]
                u35(u13, u2.Health, u2.MaxHealth)
            end)
            u35(u13, u2.Health, u2.MaxHealth)
        else
            script.Parent.Parent:Destroy()
        end
    end)
    v10.PlayerRemoving:Connect(function(p41) --[[ Line: 185 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        if p41 == u4 then
            script.Parent.Parent:Destroy()
        end
    end)
end