 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = game:GetService("Debris")
return function(p4, u5, p6) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local u7 = p4:Clone()
    u7.Parent = workspace.Effects
    local v8 = p6 or u7.CFrame
    for _, u9 in u7:GetDescendants() do
        if u9:IsA("Beam") then
            u9.Enabled = true
            local u10 = {
                ["Width0"] = u9.Width0,
                ["Width1"] = u9.Width1,
                ["TextureSpeed"] = u9.TextureSpeed,
                ["Brightness"] = u9.Brightness,
                ["LightEmission"] = u9.LightEmission
            }
            local v11 = u1:Create(u9, TweenInfo.new(u5.Duration, Enum.EasingStyle[u5.Easing], Enum.EasingDirection[u5.EasingDirection]), u5.Properties)
            v11:Play()
            v11.Completed:Once(function() --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u10
                --]]
                u9.Enabled = false
                for v12, v13 in u10 do
                    u9[v12] = v13
                end
            end)
        end
    end
    u1:Create(u7, TweenInfo.new(u5.Duration, Enum.EasingStyle[u5.Easing], Enum.EasingDirection[u5.EasingDirection]), {
        ["Position"] = (v8 * u5.Offset).Position
    }):Play()
    local u14 = 0
    local u15 = nil
    u15 = u2.Heartbeat:Connect(function(p16) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
            [3] = u14
            [4] = u15
        --]]
        local v17 = u7
        local v18 = v17.CFrame
        local v19 = CFrame.Angles
        local v20 = u5.RotationSpeed * p16
        v17.CFrame = v18 * v19(0, 0, (math.rad(v20)))
        u14 = u14 + p16
        if u14 > 5 and u15 then
            u15:Disconnect()
        end
    end)
    u3:AddItem(u7, 5)
    return u7
end