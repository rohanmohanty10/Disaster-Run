 

return {
    ["start"] = function(_, u1, _) --[[ Name: start, Line 3 ]]
        local _ = workspace.CurrentCamera
        _G.PlaySound(u1.PrimaryPart, script.PawGripSFX)
        local u2 = Random.new()
        game:GetService("RunService")
        local u3 = game:GetService("TweenService")
        game:GetService("Debris")
        local v4 = script["Paw Grip"]:Clone()
        local u5 = v4.Paw
        local u6 = v4.Ground
        v4.Parent = workspace.Effects
        u6.CFrame = u1.HumanoidRootPart.CFrame * CFrame.new(0, -2.999, 0)
        u5.CFrame = u1.HumanoidRootPart.CFrame * CFrame.new(0, 5, -7.35)
        u5.SphereN.CFrame = u1.HumanoidRootPart.CFrame * CFrame.new(0, 5, -7.35)
        local v7 = u1.Humanoid.Animator:LoadAnimation(v4:WaitForChild("PawGripAnim"))
        u3:Create(u5, TweenInfo.new(0.23, Enum.EasingStyle.Quart), {
            ["Size"] = Vector3.new(17.52, 16.116, 12.808)
        }):Play()
        u3:Create(u5.SphereN, TweenInfo.new(0.23, Enum.EasingStyle.Quart), {
            ["Size"] = Vector3.new(17.778, 16.376, 13.118)
        }):Play()
        _G.customEmit(u5.Start)
        v7:Play()
        task.spawn(function() --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u3
                [3] = u1
            --]]
            task.spawn(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                local v8 = u5.VFX.Sparks
                local v9 = u5.VFX.Sparks2
                local v10 = u5.VFX.Sparks3
                local v11 = u5.VFX.Sparks4
                local v12 = u5.VFX.Sparks5
                local v13 = u5.VFX.Sparks6
                task.wait(0.73)
                v8.Enabled = true
                task.wait(0.23)
                v8.Enabled = false
                task.wait(0.1)
                v9.Enabled = true
                task.wait(0.23)
                v9.Enabled = false
                task.wait(0.1)
                v10.Enabled = true
                task.wait(0.23)
                v10.Enabled = false
                task.wait(0.1)
                v11.Enabled = true
                task.wait(0.23)
                v11.Enabled = false
                task.wait(0.1)
                v12.Enabled = true
                task.wait(0.23)
                v12.Enabled = false
                task.wait(0.1)
                v13.Enabled = true
                task.wait(0.23)
                v13.Enabled = false
            end)
            task.spawn(function() --[[ Line: 70 ]]
                local v14 = Instance.new("ColorCorrectionEffect")
                v14.Contrast = -2
                v14.Enabled = false
                v14.Parent = game.Lighting
                task.wait(0.73)
                v14.Enabled = true
                task.wait(0.05)
                v14.Enabled = false
                task.wait(2.667)
                v14.Enabled = true
                task.wait(0.05)
                v14.Contrast = 2
                task.wait(0.05)
                v14.Enabled = true
                task.wait(0.025)
                v14.Enabled = false
                _G.destroy(v14, 2)
            end)
            task.wait(1)
            u3:Create(u5, TweenInfo.new(0.23, Enum.EasingStyle.Quart), {
                ["Size"] = Vector3.new(14.892, 13.699, 10.887),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 4, -6)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.23, Enum.EasingStyle.Quart), {
                ["Size"] = Vector3.new(15.111, 13.92, 11.15),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 4, -6)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(12.658, 11.644, 9.254),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 3, -5.25)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(12.845, 11.832, 9.478),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 3, -5.25)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(10.759, 9.897, 7.866),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 2.25, -4.5)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(10.918, 10.057, 8.056),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 2.25, -4.5)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(8.07, 7.423, 5.899),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 1.5, -4)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(8.188, 7.543, 6.042),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 1.5, -4)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(6.052, 5.567, 4.424),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 1.25, -3)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(6.141, 5.657, 4.532),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 1.25, -3)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(3.934, 3.619, 2.876),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, -2.5)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(3.992, 3.677, 2.946),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, -2.5)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(1.967, 1.809, 1.438),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 0.75, -1.75)
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.13, Enum.EasingStyle.Quad), {
                ["Size"] = Vector3.new(1.996, 1.839, 1.473),
                ["CFrame"] = u1.HumanoidRootPart.CFrame * CFrame.new(0, 0.75, -1.75)
            }):Play()
            task.wait(0.33)
            u3:Create(u5, TweenInfo.new(0.23, Enum.EasingStyle.Quad), {
                ["Transparency"] = 1
            }):Play()
            u3:Create(u5.SphereN, TweenInfo.new(0.23, Enum.EasingStyle.Quad), {
                ["Transparency"] = 1
            }):Play()
        end)
        task.wait(0.73)
        for v15 = 1, 25 do
            local u16 = script.Hits:Clone()
            u16.Hits.CFrame = u1.HumanoidRootPart.CFrame
            u16.Parent = v4
            task.spawn(function() --[[ Line: 140 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u2
                --]]
                local v17 = u16.Hits.Hit1
                local v18 = u16.Hits.Hit1.CFrame * CFrame.new(u2:NextNumber(-2, 2), u2:NextNumber(-2, 1.25), u2:NextNumber(-0, 0))
                local v19 = CFrame.Angles
                local v20 = u2:NextNumber(-25, 25)
                v17.CFrame = v18 * v19(math.rad(v20), 0, 0)
                local v21 = u16.Hits.Hit2
                local v22 = u16.Hits.Hit2.CFrame * CFrame.new(u2:NextNumber(-2, 2), u2:NextNumber(-2, 1.25), u2:NextNumber(-0, 0))
                local v23 = CFrame.Angles
                local v24 = u2:NextNumber(-25, 25)
                v21.CFrame = v22 * v23(math.rad(v24), 0, 0)
            end)
            task.spawn(function() --[[ Line: 145 ]]
                task.wait(0.25)
            end)
            if v15 == 1 then
                for _, u25 in pairs(u16.Hits.Blood:GetDescendants()) do
                    if u25:IsA("ParticleEmitter") then
                        task.spawn(function() --[[ Line: 152 ]]
                            --[[
                            Upvalues:
                                [1] = u6
                                [2] = u25
                            --]]
                            u6.Blood.Enabled = true
                            u6.VFX.Shockwave.Enabled = true
                            u25.Enabled = true
                        end)
                    end
                end
            end
            _G.customEmit(u16.Hits.Blood)
            if v15 == 1 then
                for _, u26 in pairs(u16.Hits.Blood:GetDescendants()) do
                    if u26:IsA("ParticleEmitter") then
                        task.spawn(function() --[[ Line: 166 ]]
                            --[[
                            Upvalues:
                                [1] = u6
                                [2] = u26
                            --]]
                            task.wait(2.533)
                            u6.Blood.Enabled = false
                            u6.VFX.Shockwave.Enabled = false
                            task.wait(0.1)
                            u26.Enabled = false
                        end)
                    end
                end
            end
            if v15 == 25 then
                _G.customEmit(u5.Explosion)
                _G.customEmit(u16.Hits.Blood)
            end
            task.wait(0.1)
        end
        _G.destroy(v4, 2.5)
    end
}