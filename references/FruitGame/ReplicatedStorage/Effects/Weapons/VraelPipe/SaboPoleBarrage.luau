 

game:GetService("RunService")
return {
    ["start"] = function(_, p1, p2, u3) --[[ Name: start, Line 5 ]]
        local v4 = p1.PrimaryPart or p1:WaitForChild("HumanoidRootPart")
        p1:FindFirstChildOfClass("Humanoid")
        if _G.checkRenderDistance(p1.PrimaryPart.Position) == false then
            return
        else
            local v5
            if p2 == true then
                v5 = _G.PlaySound(p1.PrimaryPart, script.Mera.woosh)
            else
                v5 = _G.PlaySound(p1.PrimaryPart, script.Regular.woosh)
            end
            v5.Parent = p1.PrimaryPart
            if p2 == false then
                task.wait(0.13)
                local v6 = RaycastParams.new()
                v6.FilterType = Enum.RaycastFilterType.Whitelist
                v6.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
                local v7 = workspace:Raycast(v4.Position, v4.CFrame.UpVector * Vector3.new(0, -25, 0), v6)
                if v7 and v7.Instance then
                    local v8 = script.Regular.PipeFloor:Clone()
                    v8.CFrame = CFrame.new(v7.Position, v7.Position + v7.Normal) * CFrame.new(0, 1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v8.Parent = workspace.Effects
                    v8.smoke.Color = ColorSequence.new(v7.Instance.Color)
                    _G.customEmit(v8)
                    _G.destroy(v8, 3)
                end
                local v9 = script.Regular.PipeSpin:Clone()
                v9.CFrame = v4.CFrame * CFrame.new(0.0000381469727, 2.49999952, 0.0000152587891, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v9.Parent = workspace.Effects
                local v10 = Instance.new("WeldConstraint")
                v10.Part0 = v4
                v10.Part1 = v9
                v10.Parent = v9
                _G.particleEnabled(v9, true)
                task.wait(0.25)
                _G.particleEnabled(v9, false)
                _G.destroy(v9, 3)
                task.wait(0.1)
                local v11 = script.Regular.PipeSlash:Clone()
                v11.CFrame = v4.CFrame * CFrame.new(0.0000381469727, -4.76837158e-7, -1.12498474, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v11.Parent = workspace.Effects
                _G.customEmit(v11)
                local v12 = script.Regular.swirltwo:Clone()
                v12.CFrame = v4.CFrame
                v12.Parent = workspace.Effects
                _G.tween(v12, {
                    0.6,
                    "Exponential",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(25, 0.5, 25),
                    ["CFrame"] = v4.CFrame * CFrame.Angles(0, 2.181661564992912, 0),
                    ["Transparency"] = 1
                })
                _G.destroy(v12, 0.6)
                local v13 = Instance.new("WeldConstraint")
                v13.Part0 = v4
                v13.Part1 = v11
                v13.Parent = v11
                _G.destroy(v11, 3)
            else
                task.spawn(function() --[[ Line: 62 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    local v14 = tick()
                    if u3 ~= nil then
                        repeat
                            game["Run Service"].RenderStepped:Wait()
                            u3.Flame:Emit(2)
                        until tick() - v14 >= 0.7
                    end
                end)
                task.wait(0.13)
                local v15 = RaycastParams.new()
                v15.FilterType = Enum.RaycastFilterType.Whitelist
                v15.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
                local v16 = workspace:Raycast(v4.Position, v4.CFrame.UpVector * Vector3.new(0, -25, 0), v15)
                if v16 then
                    local v17 = script.Mera.PipeFloor:Clone()
                    v17.CFrame = CFrame.new(v16.Position, v16.Position + v16.Normal) * CFrame.new(0, 1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v17.Parent = workspace.Effects
                    _G.customEmit(v17)
                    _G.destroy(v17, 3)
                end
                local v18 = script.Mera.PipeSpin:Clone()
                v18.CFrame = v4.CFrame * CFrame.new(0.0000381469727, 2.49999952, 0.0000152587891, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v18.Parent = workspace.Effects
                local v19 = Instance.new("WeldConstraint")
                v19.Part0 = v4
                v19.Part1 = v18
                v19.Parent = v18
                _G.particleEnabled(v18, true)
                task.wait(0.25)
                _G.particleEnabled(v18, false)
                _G.destroy(v18, 3)
                task.wait(0.1)
                local v20 = script.Mera.PipeSlash:Clone()
                v20.CFrame = v4.CFrame * CFrame.new(0.0000381469727, -4.76837158e-7, -1.12498474, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v20.Parent = workspace.Effects
                _G.customEmit(v20)
                local v21 = RaycastParams.new()
                v21.FilterType = Enum.RaycastFilterType.Whitelist
                v21.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
                local v22 = workspace:Raycast(v4.Position, v4.CFrame.UpVector * Vector3.new(0, -25, 0), v21)
                if v22 then
                    local u23 = script.Mera.scorch:Clone()
                    local v24 = CFrame.new(v22.Position, v22.Position + v22.Normal)
                    local v25 = CFrame.Angles
                    local v26 = math.random(0, 360)
                    u23.CFrame = v24 * v25(-1.5707963267948966, math.rad(v26), 0)
                    u23.Parent = workspace.Effects
                    for _, v27 in ipairs(u23:GetDescendants()) do
                        if v27:IsA("Decal") then
                            _G.tween(v27, {
                                0.5,
                                "Quad",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Transparency"] = 0.35
                            })
                        end
                    end
                    task.delay(1.5, function() --[[ Line: 113 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                        --]]
                        for _, v28 in ipairs(u23:GetDescendants()) do
                            if v28:IsA("Decal") then
                                _G.tween(v28, {
                                    2,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Transparency"] = 1
                                })
                            end
                        end
                    end)
                    _G.tween(u23.PointLight, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 25,
                        ["Brightness"] = 0
                    })
                    _G.destroy(u23, 6)
                end
                local v29 = script.Mera.swirltwo:Clone()
                v29.CFrame = v4.CFrame
                v29.Parent = workspace.Effects
                _G.tween(v29, {
                    0.6,
                    "Exponential",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(25, 0.5, 25),
                    ["CFrame"] = v4.CFrame * CFrame.Angles(0, 2.181661564992912, 0),
                    ["Transparency"] = 1
                })
                _G.destroy(v29, 0.6)
                local v30 = Instance.new("WeldConstraint")
                v30.Part0 = v4
                v30.Part1 = v20
                v30.Parent = v20
                _G.destroy(v20, 3)
            end
        end
    end
}