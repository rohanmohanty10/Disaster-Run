 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Tween = _G.Ess.Tween
BeamToggle = _G.Ess.BeamToggle
local v2 = {}
local u3 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
function v2.start(_, u4, p5, u6) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    if _G.checkRenderDistance(u4.PrimaryPart.Position) ~= false then
        Random.new()
        local u7 = u4:FindFirstChildWhichIsA("Humanoid").RootPart
        local u8 = nil
        local v9 = OverlapParams.new()
        v9.FilterType = Enum.RaycastFilterType.Blacklist
        v9.FilterDescendantsInstances = { u4, workspace.Effects, workspace.Islands }
        local u10 = p5[1]
        local u11 = p5[2]
        local u12 = (u11 - u10).Magnitude
        local u13 = u12 / 145
        local v14 = CFrame.new(u10, u11) + Vector3.new(0, 2.15, 0)
        local _ = v14 * CFrame.new(0, 0, -u12)
        local u15 = script.ShadowErruptionTravel:Clone()
        local u16 = script.ShadowErruptionBoom:Clone()
        u15.PlaybackSpeed = u15.PlaybackSpeed / math.clamp(u13, 0.25, 1)
        u15:Play()
        u15.Parent = u7
        u16.Parent = u7
        tick()
        local v17 = TweenInfo.new(u13, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
        u7.CFrame = CFrame.new(u10, u11)
        local u18 = script.GroundShadow:Clone()
        u18.CFrame = v14
        u18.Parent = workspace.Effects
        task.delay(u13 * 1.5 + 1.5, function() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18:Destroy()
        end)
        local u19 = (u7.CFrame * CFrame.new(0, -3.05, 0)).Position.Y
        local u20 = 0
        u8 = u1.Heartbeat:Connect(function(p21) --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u4
                [3] = u19
                [4] = u10
                [5] = u11
                [6] = u12
                [7] = u13
                [8] = u18
                [9] = u8
                [10] = u16
                [11] = u15
                [12] = u6
                [13] = u20
                [14] = u3
            --]]
            local _ = u7.CFrame.LookVector * 4
            local v22 = workspace:Raycast(u7.Position + Vector3.new(0, 10, 0), Vector3.new(0, -55, 0), _G.RayParams)
            if v22 and u4:FindFirstChild("iFrame") ~= nil then
                local v23 = v22.Normal
                local v24 = v22.Position + Vector3.new(0, 3.5, 0)
                local v25 = v22.Position.Y
                local v26
                if v23.Y == 1 then
                    u19 = v22.Position.Y
                    v26 = 0
                else
                    local v27 = v22.Instance
                    local v28 = v27.Size.X
                    local v29 = v27.Size.Y
                    local v30 = v27.Size.Z
                    local _ = (math.max(v28, v30) ^ 2 + v29 ^ 2) ^ 0.5
                    local v31 = (u7.Position - (u7.Position + Vector3.new(0, -4.5, 0))).Unit:Dot(v23)
                    local v32 = math.acos(v31)
                    local v33 = math.deg(v32)
                    local v34 = (v27.CFrame * CFrame.new(0, -v29 / 2, 0)).Y
                    math.ceil(v34)
                    if u19 - v25 < 0 then
                        v26 = math.abs(v33)
                    else
                        v26 = -v33
                    end
                end
                local v35 = CFrame.new(v24, v24 + CFrame.new(u10, u11).LookVector) * CFrame.Angles(math.rad(v26), 0, 0)
                local v36 = p21 / 0.016666666666666666
                u7.CFrame = v35 * CFrame.new(0, 0, -(145 / u12) * u13 * 2.25 * v36)
                u18.CFrame = u7.CFrame * CFrame.new(0, -1.15, 0)
            else
                u8:Disconnect()
                u8 = nil
                u16:Play()
                task.spawn(function() --[[ Line: 92 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u7
                        [3] = u18
                        [4] = u16
                        [5] = u15
                        [6] = u6
                        [7] = u4
                    --]]
                    if u8 == nil then
                        u7.Velocity = Vector3.new()
                        for _, u37 in u18:GetDescendants() do
                            if u37:IsA("Attachment") and u37.Name:match("beamend") then
                                local v38 = u37.Position
                                u37.Position = Vector3.new()
                                Tween(u37, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    ["Position"] = v38
                                })
                                task.delay(0.8, function() --[[ Line: 109 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u37
                                    --]]
                                    Tween(u37, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        ["Position"] = Vector3.new()
                                    })
                                end)
                            elseif u37:IsA("Beam") then
                                task.delay(0.8, function() --[[ Line: 116 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u37
                                    --]]
                                    Tween(u37, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                        ["Width0"] = 0,
                                        ["Width1"] = 0
                                    })
                                end)
                            end
                        end
                        BeamToggle(u18.beamend:GetChildren())
                        task.delay(1, function() --[[ Line: 128 ]]
                            --[[
                            Upvalues:
                                [1] = u18
                                [2] = u16
                                [3] = u15
                            --]]
                            Emit(u18.Attachment, false)
                            task.wait(0.4)
                            BeamToggle(u18.beamend:GetChildren())
                            u16:Destroy()
                            u15:Destroy()
                        end)
                        u18.Attachment.swirl.Enabled = true
                        Emit(u18.Emitter, false, 1)
                        if u6 and u4 == game.Players.LocalPlayer.Character then
                            u6:FireServer("end", u4.PrimaryPart.CFrame)
                        end
                    end
                end)
            end
            if game.Players.LocalPlayer.Character == u4 and (tick() - 0 >= 0.05 and u6 ~= nil) then
                u6:FireServer("update", u4.PrimaryPart.CFrame)
            end
            if tick() - u20 >= 0.1 and game.Players.LocalPlayer.Character == u4 then
                local v39 = u3.Block(u4.PrimaryPart.CFrame, Vector3.new(20, 20, 20)):FindPartsInRegion3WithWhiteList(_G.getTargets(u4), 50000)
                for v40 = 1, #v39 do
                    local v41 = v39[v40].Parent
                    if v41:FindFirstChild("Humanoid") and v41.Humanoid.Health > 0 then
                        if u8 ~= nil then
                            u8:Disconnect()
                            u8 = nil
                            u16:Play()
                            task.spawn(function() --[[ Line: 92 ]]
                                --[[
                                Upvalues:
                                    [1] = u8
                                    [2] = u7
                                    [3] = u18
                                    [4] = u16
                                    [5] = u15
                                    [6] = u6
                                    [7] = u4
                                --]]
                                if u8 == nil then
                                    u7.Velocity = Vector3.new()
                                    for _, u42 in u18:GetDescendants() do
                                        if u42:IsA("Attachment") and u42.Name:match("beamend") then
                                            local v43 = u42.Position
                                            u42.Position = Vector3.new()
                                            Tween(u42, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                                ["Position"] = v43
                                            })
                                            task.delay(0.8, function() --[[ Line: 109 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u42
                                                --]]
                                                Tween(u42, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                    ["Position"] = Vector3.new()
                                                })
                                            end)
                                        elseif u42:IsA("Beam") then
                                            task.delay(0.8, function() --[[ Line: 116 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u42
                                                --]]
                                                Tween(u42, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                                    ["Width0"] = 0,
                                                    ["Width1"] = 0
                                                })
                                            end)
                                        end
                                    end
                                    BeamToggle(u18.beamend:GetChildren())
                                    task.delay(1, function() --[[ Line: 128 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u18
                                            [2] = u16
                                            [3] = u15
                                        --]]
                                        Emit(u18.Attachment, false)
                                        task.wait(0.4)
                                        BeamToggle(u18.beamend:GetChildren())
                                        u16:Destroy()
                                        u15:Destroy()
                                    end)
                                    u18.Attachment.swirl.Enabled = true
                                    Emit(u18.Emitter, false, 1)
                                    if u6 and u4 == game.Players.LocalPlayer.Character then
                                        u6:FireServer("end", u4.PrimaryPart.CFrame)
                                    end
                                end
                            end)
                        end
                        break
                    end
                end
                u20 = tick()
            end
        end)
        task.delay(v17.Time, function() --[[ Line: 220 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u16
                [3] = u7
                [4] = u18
                [5] = u15
                [6] = u6
                [7] = u4
            --]]
            if u8 ~= nil then
                u8:Disconnect()
                u8 = nil
                u16:Play()
                task.spawn(function() --[[ Line: 92 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u7
                        [3] = u18
                        [4] = u16
                        [5] = u15
                        [6] = u6
                        [7] = u4
                    --]]
                    if u8 == nil then
                        u7.Velocity = Vector3.new()
                        for _, u44 in u18:GetDescendants() do
                            if u44:IsA("Attachment") and u44.Name:match("beamend") then
                                local v45 = u44.Position
                                u44.Position = Vector3.new()
                                Tween(u44, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    ["Position"] = v45
                                })
                                task.delay(0.8, function() --[[ Line: 109 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u44
                                    --]]
                                    Tween(u44, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        ["Position"] = Vector3.new()
                                    })
                                end)
                            elseif u44:IsA("Beam") then
                                task.delay(0.8, function() --[[ Line: 116 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u44
                                    --]]
                                    Tween(u44, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                        ["Width0"] = 0,
                                        ["Width1"] = 0
                                    })
                                end)
                            end
                        end
                        BeamToggle(u18.beamend:GetChildren())
                        task.delay(1, function() --[[ Line: 128 ]]
                            --[[
                            Upvalues:
                                [1] = u18
                                [2] = u16
                                [3] = u15
                            --]]
                            Emit(u18.Attachment, false)
                            task.wait(0.4)
                            BeamToggle(u18.beamend:GetChildren())
                            u16:Destroy()
                            u15:Destroy()
                        end)
                        u18.Attachment.swirl.Enabled = true
                        Emit(u18.Emitter, false, 1)
                        if u6 and u4 == game.Players.LocalPlayer.Character then
                            u6:FireServer("end", u4.PrimaryPart.CFrame)
                        end
                    end
                end)
            end
        end)
    end
end
return v2