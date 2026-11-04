 

return {
    ["start"] = function(_, u1, _) --[[ Name: start, Line 3 ]]
        Random.new()
        game:GetService("RunService")
        local u2 = game:GetService("TweenService")
        game:GetService("Debris")
        local v3 = Instance.new("Folder")
        v3.Parent = workspace.Effects
        _G.PlaySound(u1.PrimaryPart, script.IceGrip)
        for v4 = 1, 4 do
            local v5 = script.Follow:Clone()
            local u6 = script.Spikes:Clone()
            local u7 = u6.ConeLR
            local u8 = u6.ConeRL
            local u9 = u6.ConeFB
            local u10 = u6.ConeBF
            local u11 = v5.FollowLR
            local u12 = v5.FollowRL
            local u13 = v5.FollowFB
            local u14 = v5.FollowBF
            v5.Parent = v3
            u6.Parent = v3
            if v4 == 1 then
                local v15 = u1:GetPivot() * CFrame.new(-10, -4.196, 0)
                local v16 = u1:GetPivot() * CFrame.new(10, -4.196, 0)
                local v17 = u1:GetPivot() * CFrame.new(0, -4.196, -10)
                local v18 = u1:GetPivot() * CFrame.new(0, -4.196, 10)
                u11.CFrame = v15
                u12.CFrame = v16
                u13.CFrame = v17
                u14.CFrame = v18
                u2:Create(u11, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                    ["CFrame"] = u1:GetPivot() * CFrame.new(0, -3.696, 0)
                }):Play()
                u2:Create(u12, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                    ["CFrame"] = u1:GetPivot() * CFrame.new(0, -3.696, 0)
                }):Play()
                u2:Create(u13, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                    ["CFrame"] = u1:GetPivot() * CFrame.new(0, -3.696, 0)
                }):Play()
                u2:Create(u14, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                    ["CFrame"] = u1:GetPivot() * CFrame.new(0, -3.696, 0)
                }):Play()
            end
            local v19 = u11.CFrame
            local v20 = u12.CFrame
            local v21 = u13.CFrame
            local v22 = u14.CFrame
            u7.CFrame = v19
            u8.CFrame = v20
            u9.CFrame = v21
            u10.CFrame = v22
            task.spawn(function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u7
                    [3] = u11
                    [4] = u8
                    [5] = u12
                    [6] = u9
                    [7] = u13
                    [8] = u10
                    [9] = u14
                    [10] = u6
                --]]
                u2:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                    ["Size"] = Vector3.new(1.5, 5, 1.5),
                    ["CFrame"] = u11.CFrame * CFrame.new(0, 3, 0)
                }):Play()
                u2:Create(u8, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                    ["Size"] = Vector3.new(1.5, 5, 1.5),
                    ["CFrame"] = u12.CFrame * CFrame.new(0, 3, 0)
                }):Play()
                u2:Create(u9, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                    ["Size"] = Vector3.new(1.5, 5, 1.5),
                    ["CFrame"] = u13.CFrame * CFrame.new(0, 3, 0)
                }):Play()
                u2:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                    ["Size"] = Vector3.new(1.5, 5, 1.5),
                    ["CFrame"] = u14.CFrame * CFrame.new(0, 3, 0)
                }):Play()
                task.delay(0.075, function() --[[ Line: 42 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                    --]]
                    _G.customEmit(u6)
                end)
                task.wait(0.25)
                u2:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    ["Size"] = Vector3.new(1, 0.001, 1),
                    ["CFrame"] = u7.CFrame * CFrame.new(0, -3, 0)
                }):Play()
                u2:Create(u8, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    ["Size"] = Vector3.new(1, 0.001, 1),
                    ["CFrame"] = u8.CFrame * CFrame.new(0, -3, 0)
                }):Play()
                u2:Create(u9, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    ["Size"] = Vector3.new(1, 0.001, 1),
                    ["CFrame"] = u9.CFrame * CFrame.new(0, -3, 0)
                }):Play()
                u2:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    ["Size"] = Vector3.new(1, 0.001, 1),
                    ["CFrame"] = u10.CFrame * CFrame.new(0, -3, 0)
                }):Play()
                task.wait(0.25)
                u7.Transparency = 1
                u8.Transparency = 1
                u9.Transparency = 1
                u10.Transparency = 1
            end)
            task.wait(0.15)
        end
        for _ = 1, 1 do
            local u23 = script.SpikeF:Clone()
            local u24 = u23.ConeF
            local u25 = u23.IceGround
            u23.Parent = v3
            u24.CFrame = u24.CFrame
            u25.CFrame = u25.CFrame
            u24.CFrame = u1:GetPivot()
            task.spawn(function() --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u24
                    [3] = u1
                    [4] = u25
                    [5] = u23
                --]]
                u2:Create(u24, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
                    ["Size"] = Vector3.new(10, 12.5, 10),
                    ["CFrame"] = u1:GetPivot() * CFrame.new(0, 4.054, 0)
                }):Play()
                u2:Create(u25, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
                    ["Size"] = Vector3.new(10, 1, 10)
                }):Play()
                _G.customEmit(u23)
                task.wait(0.75)
                u2:Create(u24, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
                    ["Size"] = Vector3.new(2, 1, 2),
                    ["CFrame"] = u1:GetPivot() * CFrame.new(0, -5.054, 0)
                }):Play()
                u2:Create(u25, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.075), {
                    ["Transparency"] = 1,
                    ["CFrame"] = u25.CFrame * CFrame.new(0, -2.5, 0)
                }):Play()
                task.wait(0.35)
                u24.Transparency = 1
            end)
        end
        for _, v26 in pairs(v3:GetDescendants()) do
            _G.destroy(v26, 5)
        end
    end
}