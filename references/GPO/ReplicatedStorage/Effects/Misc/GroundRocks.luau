 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3, p4, p5, u6, u7) --[[ Line: 4 ]]
    local v8 = CFrame.new(p2.Position)
    if _G.checkRenderDistance(v8.Position) ~= false then
        local v9 = math.floor(p5)
        local v10 = CFrame.Angles
        local v11 = math.random(-360, 360)
        local v12 = v8 * v10(0, math.rad(v11), 0)
        for v13 = 1, v9 do
            local u14 = script.Part:Clone()
            local v15 = CFrame.Angles
            local v16 = 360 / v9 * v13
            u14.CFrame = v12 * v15(0, math.rad(v16), 0)
            u14.CFrame = u14.CFrame * CFrame.new(0, -p4 / 2, 0)
            local _ = u14.CFrame * CFrame.new(0, 2, -10)
            local v17 = u14.CFrame * CFrame.new(0, 2, -p3)
            local v18 = CFrame.Angles
            local v19 = math.random(-360, 360)
            local v20 = math.rad(v19)
            local v21 = math.random(-360, 360)
            local v22 = math.rad(v21)
            local v23 = math.random(-360, 360)
            local v24 = v17 * v18(v20, v22, (math.rad(v23)))
            _G.destroy(u14, u6 + 1)
            local v25 = {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v26 = Ray.new(v24.Position + Vector3.new(0, 10, 0), CFrame.new(v24.Position).UpVector * -20)
            local u27, v28 = _G.raycastWhitelist(v26, { workspace.Islands, workspace.Ships, workspace.Env })
            if u27 then
                _G.matchMaterial(u14, u27)
                local v29 = CFrame.new(v28)
                local v30 = CFrame.Angles
                local v31 = math.random(-360, 360)
                local v32 = math.rad(v31)
                local v33 = math.random(-360, 360)
                local v34 = math.rad(v33)
                local v35 = math.random(-360, 360)
                local v36 = v29 * v30(v32, v34, (math.rad(v35)))
                u14.Parent = workspace.Effects
                if u7 == nil then
                    _G.tween(u14, v25, {
                        ["CFrame"] = v36
                    })
                    _G.tween(u14.Mesh, v25, {
                        ["Scale"] = Vector3.new(p4, p4, p4) * (math.random(50, 100) / 100)
                    })
                else
                    u14.CFrame = v36
                    u14.Mesh.Scale = Vector3.new(p4, p4, p4) * (math.random(50, 100) / 100)
                end
                task.spawn(function() --[[ Line: 34 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u27
                        [3] = u14
                        [4] = u6
                    --]]
                    if u7 == nil then
                        task.wait(0.25)
                    end
                    local u37
                    if u27:IsDescendantOf(workspace.Env) == false and u27.Anchored == false then
                        u37 = Instance.new("Weld")
                        u37.C0 = u27.CFrame:inverse() * u14.CFrame
                        u37.Part0 = u27
                        u37.Part1 = u14
                        u37.Parent = u14
                        u14.Anchored = false
                    else
                        u37 = nil
                    end
                    task.spawn(function() --[[ Line: 47 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                            [2] = u14
                            [3] = u37
                        --]]
                        task.wait(u6)
                        if u14 and u14:FindFirstChild("Mesh") == nil then
                            u14:Destroy()
                        else
                            _G.tween(u14.Mesh, {
                                0.5,
                                Enum.EasingStyle.Quad,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Scale"] = Vector3.new(0, 0, 0)
                            })
                            if u37 == nil then
                                _G.tween(u14, {
                                    0.5,
                                    Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["CFrame"] = CFrame.new(u14.CFrame.Position) * CFrame.new(0, -u14.Size.X, 0)
                                })
                            end
                            _G.destroy(u14, 1)
                        end
                    end)
                end)
            else
                u14:Destroy()
            end
        end
    end
end
return v1