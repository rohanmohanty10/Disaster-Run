 

local v1 = {}
require(game.ReplicatedStorage.Modules.sBeat)
function v1.start(_, p2, p3, p4, p5, p6, p7, p8, p9, p10, u11) --[[ Line: 4 ]]
    local v12 = _G.awaitObject(p2)
    if v12 == nil then
        return
    end
    if _G.checkRenderDistance(v12.Position) == false then
        return
    end
    local v13 = p6 == nil and 0.5 or p6
    local v14 = p7 == nil and 2 or p7
    local v15 = p8 == nil and 0 or p8
    local v16 = p10 == nil and 0.2 or p10
    local v17 = tick()
    local v18 = {}
    if p9 == nil then
        p9 = CFrame.new(0, 0, 0)
    end
    local v19 = v12.CFrame * p9
    local v20 = v19.Position
    local v21 = CFrame.new(v19.Position + Vector3.new(0, 1, 0)) * CFrame.new(0, v12.Size.Y / 2, 0)
    local v22 = Ray.new(v21.Position, v21.upVector * -(v12.Size.Y * 2 + v15))
    local _, v23 = _G.raycastWhitelist(v22, { workspace.Islands, workspace.Env, workspace.Ships })
    local v24 = CFrame.new(v23)
    local v25 = v12
    while true do
        if ((v12.CFrame * p9).Position - v20).Magnitude < v16 then
            game["Run Service"].Heartbeat:Wait()
        else
            v20 = (v12.CFrame * p9).Position
            local v26 = v12.CFrame * p9
            local v27 = CFrame.new(v26.Position + Vector3.new(0, 1, 0)) * CFrame.new(0, v12.Size.Y / 2, 0)
            local v28 = Ray.new(v27.Position, v27.upVector * -(v12.Size.Y * 2 + v15))
            local v29, v30 = _G.raycastWhitelist(v28, { workspace.Islands, workspace.Env, workspace.Ships })
            if v29 then
                local u31 = script.trail:Clone()
                local _ = v30.Y
                local v32 = (v24.Position - v30).Magnitude
                local v33 = Vector3.new(v14, v32, 0.1)
                u31.Mesh.Scale = Vector3.new(0, v32, 0)
                u31.Color = p4
                u31.CFrame = CFrame.new(v24.Position, v30) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v32 / 2, 0)
                u31.Parent = workspace.Effects
                _G.tween(u31, {
                    v13,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = p5
                })
                _G.tween(u31.Mesh, {
                    v13,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = v33
                })
                v24 = CFrame.new(v30)
                if u11 == nil then
                    table.insert(v18, u31)
                else
                    task.delay(u11.delayTime, function() --[[ Line: 67 ]]
                        --[[
                        Upvalues:
                            [1] = u31
                            [2] = u11
                        --]]
                        local v34 = _G.tween
                        local v35 = u31.Mesh
                        local v36 = {
                            u11.fadeTime,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }
                        local v37 = {}
                        local v38 = u31.Mesh.Scale.Y
                        v37.Scale = Vector3.new(0, v38, 0)
                        v34(v35, v36, v37)
                        _G.destroy(u31, u11.fadeTime)
                    end)
                end
            else
                v24 = CFrame.new(v30)
            end
            task.wait()
        end
        if p3 and p3 <= tick() - v17 or v25:IsDescendantOf(workspace) == false then
            for v39 = 1, #v18 do
                local v40 = _G.tween
                local v41 = v18[v39].Mesh
                local v42 = {
                    2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v43 = {}
                local v44 = v18[v39].Mesh.Scale.Y
                v43.Scale = Vector3.new(0, v44, 0)
                v40(v41, v42, v43)
                _G.destroy(v18[v39], 2)
            end
            table.clear(v18)
            return
        end
    end
end
return v1