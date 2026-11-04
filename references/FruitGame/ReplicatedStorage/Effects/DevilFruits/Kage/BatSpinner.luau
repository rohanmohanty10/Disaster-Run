 

game:GetService("RunService")
Emit = _G.Emit
Tween = _G.Ess.Tween
BeamToggle = _G.Ess.BeamToggle
return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 18 ]]
        if p2 and game.Players.LocalPlayer == p2 then
            return
        end
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) == false then
            return
        end
        local v4 = Random.new()
        local v5 = p1:FindFirstChildWhichIsA("Humanoid").RootPart
        local v6 = v5.Position
        local v7 = 17 * (p3 or 1)
        local v8 = p1.Name == "Moria" and p1.Parent == workspace.NPCs and 35 or v7
        local v9 = v8 / 17
        local v10 = (v5.CFrame * CFrame.new(0, 0, -v8)).Position
        local v11 = CFrame.new(v6)
        local v12 = CFrame.new(v10, v11.Position)
        local u13 = (v11.Position - v12.Position).Magnitude
        local v14 = 6.283185307179586 * u13
        local v15 = tick()
        local v16 = tick()
        local v17 = (tick() - v15) * v14 % 360
        local v18 = math.ceil(v17)
        local v19 = math.abs(v18)
        local v20 = math.rad(v19)
        local u21 = script.BatVortex:Clone()
        u21.Parent = v5
        u21:Play()
        local u22 = script.Follower:Clone()
        u22.CFrame = v12
        u22.Parent = workspace.Effects
        for _ = 1, 15 do
            local v23 = CFrame.new(v4:NextNumber(-5, 6) * v9, v4:NextNumber(-5, 5) * v9, v4:NextNumber(-4, 4) * v9)
            local v24 = Instance.new("Attachment")
            v24.CFrame = v23 * CFrame.Angles(0, -3.141592653589793, -0.2617993877991494) + Vector3.new(0, 2, 0)
            v24.Parent = u22
            local u25 = script.Bat:Clone()
            local u26 = u25.RootPart
            u26.RigidConstraint.Attachment1 = v24
            u25:PivotTo(u22.CFrame)
            u25.Parent = workspace.Effects
            local v27 = u25.AnimationController:LoadAnimation(u25.AnimationController.Animation)
            v27:Play()
            v27:AdjustSpeed(2)
            Tween(v24, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 0, false), {
                ["Position"] = v24.Position * Vector3.new(1, 0, 1)
            })
            task.spawn(function() --[[ Line: 107 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u13
                --]]
                for _, u28 in u25:GetChildren() do
                    if u28:IsA("BasePart") and u28.Transparency ~= 1 then
                        task.delay((1.5 + u13 * 0.01) * 0.7, function() --[[ Line: 110 ]]
                            --[[
                            Upvalues:
                                [1] = u28
                            --]]
                            u28.Transparency = 1
                        end)
                    end
                end
            end)
            task.delay(1.5, function() --[[ Line: 121 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u13
                    [3] = u25
                --]]
                Emit(u26.Attachment, false)
                task.wait(u13 * 0.02)
                u26.Trail.Enabled = false
                task.wait(0.3)
                u25:Destroy()
            end)
        end
        local v29
        if p1.Name == "Moria" and p1.Parent == workspace.NPCs then
            v29 = 15
        else
            v29 = 0
        end
        while true do
            u22.CFrame = v5.CFrame * CFrame.Angles(0, v20, 0) * CFrame.new(0, -v29, -u13) * CFrame.Angles(0, 1.5707963267948966, 0)
            local v30 = tick()
            local v31 = tick() - v15
            local v32 = (tick() - v15) * 1200 % 360
            local v33 = math.ceil(v32)
            local v34 = math.abs(v33)
            v20 = -math.rad(v34)
            if v30 - v16 > 0.08 and v31 < 1.475 then
                local u35 = script.BeanWind:Clone()
                u35.CFrame = v5.CFrame * CFrame.new(0, 3 - v29, 0) * CFrame.Angles(0, v20, 0)
                u35.Mesh.Scale = u35.Mesh.Scale * v9
                u35.Parent = workspace.Effects
                Tween(u35.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false), {
                    ["Transparency"] = 1
                })
                Tween(u35, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
                    ["CFrame"] = u35.CFrame * CFrame.Angles(0, 4.71238898038469, 0),
                    ["Size"] = u35.Size * Vector3.new(1.5, 1, 1.5)
                })
                task.delay(0.2, function() --[[ Line: 170 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                    --]]
                    u35:Destroy()
                end)
                v16 = tick()
            end
            if v31 > 1.5 then
                u13 = u13 - 1
            end
            if u13 <= 0 then
                task.delay(0.25, function() --[[ Line: 182 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u22
                    --]]
                    _G.tween(u21, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Volume"] = 0
                    })
                    _G.destroy(u21, 0.25)
                    u22:Destroy()
                end)
                return
            end
            task.wait()
        end
    end
}