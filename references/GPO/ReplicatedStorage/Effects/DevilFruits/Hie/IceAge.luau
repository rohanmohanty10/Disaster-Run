 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, p3, p4) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v5 = CFrame.Angles
        local v6 = math.random(-360, 360)
        local v7 = p3 * v5(0, math.rad(v6), 0)
        local v8 = 5 * (p4 / 2)
        for _ = 1, 7 do
            for v9 = 1, 13 do
                local u10 = script.MeshPart:Clone()
                local v11 = CFrame.Angles
                local v12 = v9 * 27.692307692307693
                u10.CFrame = v7 * v11(0, math.rad(v12), 0)
                u10.CFrame = u10.CFrame * CFrame.new(0, -p4 / 2, 0)
                local _ = u10.CFrame * CFrame.new(0, 2, -10)
                local v13 = u10.CFrame * CFrame.new(0, 2, -v8)
                local v14 = CFrame.Angles
                local v15 = math.random(-360, 360)
                local v16 = math.rad(v15)
                local v17 = math.random(-360, 360)
                local v18 = math.rad(v17)
                local v19 = math.random(-360, 360)
                local v20 = v13 * v14(v16, v18, (math.rad(v19)))
                _G.destroy(u10, 5)
                local v21 = {
                    0.25,
                    Enum.EasingStyle.Exponential,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v22 = Ray.new(v20.Position + Vector3.new(0, 10, 0), CFrame.new(v20.Position).UpVector * -40)
                local u23, v24 = _G.raycastWhitelist(v22, { workspace.Islands, workspace.Ships, workspace.Env })
                if u23 or (v24.Y <= workspace.Env.WaterStuff.Falls.Position.Y or v24.Y < workspace.Env.WaterStuff.Sand.Position.Y) then
                    if v24.Y <= workspace.Env.WaterStuff.Falls.Position.Y and v24.Y > workspace.Env.WaterStuff.Sand.Position.Y then
                        local v25 = v24.X
                        local v26 = workspace.Env.WaterStuff.Falls.Position.Y
                        local v27 = v24.Z
                        v24 = Vector3.new(v25, v26, v27)
                    end
                    u10.Color = BrickColor.new("Pastel light blue").Color
                    u10.Material = Enum.Material.Ice
                    local v28 = CFrame.new(v24)
                    local v29 = CFrame.Angles
                    local v30 = math.random(-360, 360)
                    local v31 = math.rad(v30)
                    local v32 = math.random(-360, 360)
                    local v33 = math.rad(v32)
                    local v34 = math.random(-360, 360)
                    local v35 = v28 * v29(v31, v33, (math.rad(v34)))
                    local v36 = Vector3.new(p4, p4, p4) * (math.random(50, 100) / 100)
                    u10.Parent = workspace.Effects
                    _G.tween(u10, v21, {
                        ["CFrame"] = v35,
                        ["Size"] = v36
                    })
                    u10.sm2:Emit(5)
                    u10.sm3.Size = NumberSequence.new(v36.Magnitude / 2, v36.Magnitude)
                    u10.sm3:Emit(3)
                    task.spawn(function() --[[ Line: 38 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u10
                        --]]
                        task.wait(0.25)
                        local u37
                        if u23 and (u23:IsDescendantOf(workspace.Env) == false and u23.Anchored == false) then
                            u37 = Instance.new("Weld")
                            u37.C0 = u23.CFrame:inverse() * u10.CFrame
                            u37.Part0 = u23
                            u37.Part1 = u10
                            u37.Parent = u10
                            u10.Anchored = false
                        else
                            u37 = nil
                        end
                        task.spawn(function() --[[ Line: 50 ]]
                            --[[
                            Upvalues:
                                [1] = u10
                                [2] = u37
                            --]]
                            task.wait(4)
                            local v38 = {
                                0.25,
                                Enum.EasingStyle.Quad,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }
                            _G.tween(u10, v38, {
                                ["Size"] = Vector3.new(0, 0, 0)
                            })
                            if u37 == nil then
                                _G.tween(u10, {
                                    0.5,
                                    Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["CFrame"] = CFrame.new(u10.CFrame.Position) * CFrame.new(0, -u10.Size.X, 0)
                                })
                            end
                            _G.destroy(u10, 1)
                        end)
                    end)
                else
                    u10:Destroy()
                end
            end
            u2()
            p4 = p4 * 1.5
            v8 = v8 * 1.4
        end
    end
end
return v1