 

game:GetService("RunService")
Emit = _G.Emit
Tween = _G.Ess.Tween
BeamToggle = _G.Ess.BeamToggle
return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 28 ]]
        local v4 = p3 == game.Players.LocalPlayer
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) ~= false then
            local v5 = Random.new()
            local v6 = p1:FindFirstChildWhichIsA("Humanoid")
            local v7 = v6.RootPart
            local v8 = v7.Position
            local v9 = (CFrame.new(v8, p2) * CFrame.new(0, 0, -20)).Position
            local v10 = CFrame.new(v8, p2)
            local v11 = CFrame.new(v9, v10.Position)
            local v12 = (v10.Position - v11.Position).Magnitude
            local v13 = false
            local v14 = tick()
            local v15 = tick()
            local v16 = (tick() - v14) * 1800 % 360
            local v17 = math.ceil(v16)
            local v18 = math.abs(v17)
            local v19 = math.rad(v18)
            local u20 = script.Follower:Clone()
            u20.CFrame = CFrame.new(v10.Position, v11.Position)
            u20.Parent = workspace.Effects
            local v21
            if v4 == true then
                v21 = script.LinearVelocity:Clone()
                v21.VectorVelocity = v10.LookVector * (3200 / v12) / 1
                v21.Attachment0 = v7:FindFirstChildWhichIsA("Attachment")
                v21.Parent = v7
                Tween(v21, TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                    ["MaxForce"] = 0
                })
                v7.CFrame = CFrame.new(v10.Position, v11.Position)
            else
                v21 = nil
            end
            local u22 = script.BatDrill:Clone()
            u22.Parent = v7
            u22:Play()
            local u23 = script.Transform:Clone()
            u23.Position = v8
            u23.Parent = workspace.Effects
            Emit(u23.Attachment, true)
            for v24 = 1, 5 do
                local v25 = CFrame.new(0, v5:NextNumber(-9, 9), v5:NextNumber(-8, 8))
                if v24 == 1 then
                    v25 = CFrame.new()
                end
                local v26 = Instance.new("Attachment")
                v26.CFrame = v25 * CFrame.Angles(0, 0, -0.2617993877991494) + Vector3.new(0, 2, 0)
                v26.Parent = u20
                local u27 = script.Bat:Clone()
                local u28 = u27.RootPart
                u28.RigidConstraint.Attachment1 = v26
                u27:PivotTo(u20.CFrame)
                u27.Parent = workspace.Effects
                local v29 = u27.AnimationController:LoadAnimation(u27.AnimationController.Animation)
                v29:Play()
                v29:AdjustSpeed(2)
                Tween(v26, TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.In, 0, false), {
                    ["Position"] = Vector3.new()
                })
                task.spawn(function() --[[ Line: 128 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                    --]]
                    for _, v30 in u27:GetDescendants() do
                        if v30:IsA("BasePart") then
                            Tween(v30, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 0, false), {
                                ["Transparency"] = 1
                            })
                        else
                            v30:IsA("Trail")
                        end
                    end
                end)
                task.delay(0.8, function() --[[ Line: 140 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u27
                    --]]
                    Emit(u28.Attachment, false)
                    u28.Trail.Enabled = false
                    u28.Trail1.Enabled = false
                    task.wait(0.6)
                    u27:Destroy()
                end)
            end
            while u20:IsDescendantOf(workspace) do
                u20.CFrame = CFrame.new(v7.Position, v7.Position + v10.LookVector * 20) * CFrame.Angles(0, 0, v19)
                local v31 = tick()
                local v32 = tick() - v14
                local v33 = (tick() - v14) * 1800 % 360
                local v34 = math.ceil(v33)
                local v35 = math.abs(v34)
                v19 = -math.rad(v35)
                if v31 - v15 > 0.035 and v32 < 0.775 then
                    local u36 = script.BeanWind:Clone()
                    u36.CFrame = u20.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, v19, 0)
                    u36.Parent = workspace.Effects
                    Tween(u36.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false), {
                        ["Transparency"] = 1
                    })
                    Tween(u36.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
                        ["Scale"] = u36.Mesh.Scale * 2
                    })
                    Tween(u36, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
                        ["CFrame"] = u36.CFrame * CFrame.Angles(0, 4.71238898038469, 0) * CFrame.new(0, 15, 0),
                        ["Size"] = u36.Size * Vector3.new(1.5, 1, 1.5)
                    })
                    task.delay(0.2, function() --[[ Line: 180 ]]
                        --[[
                        Upvalues:
                            [1] = u36
                        --]]
                        u36:Destroy()
                    end)
                    v15 = tick()
                end
                if v32 > 0.4 and not v13 then
                    task.delay(0.4, function() --[[ Line: 188 ]]
                        --[[
                        Upvalues:
                            [1] = u20
                            [2] = u22
                        --]]
                        u20:Destroy()
                        task.wait(0.25)
                        u22:Destroy()
                    end)
                    for _, v37 in u20:GetChildren() do
                        if v37:IsA("BasePart") then
                            Tween(v37, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false), {
                                ["Transparency"] = 1
                            })
                        end
                    end
                    v13 = true
                end
                task.wait()
            end
            if v4 == true then
                v21:Destroy()
                v7.Velocity = Vector3.new()
                v6:ChangeState(Enum.HumanoidStateType.Freefall)
                v6.AutoRotate = true
            end
            u23.Position = v7.Position
            Emit(u23.Attachment, false, 0.025)
            task.delay(1.6, function() --[[ Line: 221 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23:Destroy()
            end)
            task.wait(0.1)
        end
    end
}