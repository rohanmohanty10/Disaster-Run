 

repeat
    task.wait()
until script.char.Value ~= nil
local v1 = script.char.Value
local u2 = v1:WaitForChild("Humanoid", 60)
local u3 = {}
local u4 = game.Players:GetPlayerFromCharacter(v1)
local u5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local function u29(p6, p7, p8) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    if u4 and u4.Team ~= game.Teams.Players then
        warn("ret bec not alive!")
    else
        local v9 = math.floor(p7)
        local v10 = math.floor(p8)
        local v11 = (v9 < 0 and 0 or v9) / v10
        local v12 = p6.bar.Size.X.Scale
        if u3[p6.Name] == nil then
            u3[p6.Name] = 0
        end
        if u3[p6.Name] ~= v11 then
            local v13 = v12 - v11
            local v14 = v11 >= 1 and 1 or v11
            u3[p6.Name] = v14
            local v15 = math.pow(10, 3 or 0)
            local v16 = v14 * v15
            local v17
            if v16 >= 0 then
                local v18 = v16 + 0.5
                v17 = math.floor(v18)
            else
                local v19 = v16 - 0.5
                v17 = math.ceil(v19)
            end
            local v20 = v17 / v15
            local v21 = p6.bar.Size.X.Scale
            local v22 = math.pow(10, 3 or 0)
            local v23 = v21 * v22
            local v24
            if v23 >= 0 then
                local v25 = v23 + 0.5
                v24 = math.floor(v25)
            else
                local v26 = v23 - 0.5
                v24 = math.ceil(v26)
            end
            if v20 ~= v24 / v22 then
                p6.bar:TweenSize(UDim2.new(v14, 0, 1, 0), "Out", "Quad", 0.25, true)
            end
            if v13 > 0 then
                if p6.bar.Parent:FindFirstChild("a") then
                    p6.bar.Parent.a:Destroy()
                end
                local v27 = p6.bar:Clone()
                v27.Name = "a"
                v27.ZIndex = 2
                v27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                v27.Size = UDim2.new(v13, 0, 1, 0)
                v27.Position = UDim2.new(v14, 0, 0.5, 0)
                v27:ClearAllChildren()
                v27.Parent = p6.bar.Parent
                local v28 = v13 + 0.25
                _G.tween(v27, {
                    v28,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["BackgroundTransparency"] = 1,
                    ["Size"] = UDim2.new(0, 0, 1, 0)
                })
                _G.destroy(v27, v28)
            end
        end
    end
end
cnt = u2:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 68 ]]
    --[[
    Upvalues:
        [1] = u29
        [2] = u2
    --]]
    u29(script.Parent.HealthBar, u2.Health, u2.MaxHealth)
end)
cnt2 = u2:GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u29
        [2] = u2
    --]]
    u29(script.Parent.HealthBar, u2.Health, u2.MaxHealth)
end)
cnt3 = u5.Stamina.Changed:Connect(function() --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u29
        [2] = u5
    --]]
    u29(script.Parent.StaminaBar, u5.Stamina.Value, u5.Stamina.MaxValue)
end)
u29(script.Parent.HealthBar, u2.Health, u2.MaxHealth)
u29(script.Parent.StaminaBar, u5.Stamina.Value, u5.Stamina.MaxValue)
if u4 then
    u4:GetPropertyChangedSignal("Team"):Connect(function() --[[ Line: 90 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u29
            [3] = u2
            [4] = u5
        --]]
        if u4.Team == game.Teams.Eliminated then
            u29(script.Parent.HealthBar, 0, u2.MaxHealth)
            u29(script.Parent.StaminaBar, 0, u5.Stamina.MaxValue)
            script.Parent.Parent.TextLabel.TextColor3 = script.Parent.HealthBar.BackgroundColor3
            script.Parent.HealthBar.bar.Visible = false
            script.Parent.StaminaBar.bar.Visible = false
        else
            script.Parent.HealthBar.bar.Visible = true
            script.Parent.StaminaBar.bar.Visible = true
            script.Parent.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
    u4.CharacterAdded:Connect(function(p30) --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u29
        --]]
        if cnt then
            cnt:Disconnect()
        end
        if cnt2 then
            cnt2:Disconnect()
        end
        u2 = p30:WaitForChild("Humanoid", 100000000000)
        cnt = u2:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 116 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u2
            --]]
            u29(script.Parent.HealthBar, u2.Health, u2.MaxHealth)
        end)
        cnt2 = u2:GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 120 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u2
            --]]
            u29(script.Parent.HealthBar, u2.Health, u2.MaxHealth)
        end)
    end)
    game.Players.PlayerRemoving:Connect(function(p31) --[[ Line: 124 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        if p31 == u4 then
            script.Parent.Parent:Destroy()
        end
    end)
end