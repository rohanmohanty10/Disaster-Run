 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, p3, p4, p5, u6, u7, u8, p9) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v10 = math.floor(p4)
        local v11 = 360 / v10
        local v12 = 6.283185307179586 * p5 / v10 * 1.1
        local v13 = Instance.new("Model")
        v13.Parent = workspace.Effects
        _G.destroy(v13, u8 + 0.25)
        local u14 = p3 * CFrame.Angles(0, math.random(-360, 360), 0)
        local v15 = {}
        local v16 = {}
        for v17 = 1, v10 do
            local u18 = script.Part:Clone()
            local v19 = CFrame.Angles
            local v20 = v17 * v11
            local v21 = u14 * v19(0, math.rad(v20), 0) * CFrame.new(0, 0, p5) * CFrame.Angles(0.7853981633974483, 0, 0)
            local v22 = u6 * math.random(50, 120) / 100
            u18.Size = Vector3.new(v12, v22, v22)
            local v23 = 5 + u6 * 2
            local v24 = CFrame.new(v21.Position) * CFrame.new(0, v23, 0)
            if p9 ~= nil then
                v24 = v21 * CFrame.new(0, v23, 0)
            end
            local v25 = Ray.new(v24.Position, v24.upVector * (-v23 * 2))
            local v26, v27, v28 = _G.raycastWhitelist(v25, { workspace.Islands, workspace.Ships, workspace.Env })
            if v26 then
                _G.matchMaterial(u18, v26)
                local v29 = (v21.Position - v27).Magnitude
                local v30 = v21.Position.Y > v27.Y and -1 or 1
                local _ = v21 * CFrame.new(0, v29 * v30, 0)
                local v31 = CFrame.Angles
                local v32 = v17 * v11
                local v33 = u14 * v31(0, math.rad(v32), 0) * CFrame.new(0, 0, p5 / 2)
                local v34 = CFrame.Angles
                local v35 = v17 * v11
                u18.CFrame = u14 * v34(0, math.rad(v35), 0) * CFrame.new(0, 0, p5 / 2)
                u18.Parent = v13
                if v17 == 1 then
                    local _ = u18.CFrame
                end
                local u36 = CFrame.new(v27, v27 + v28) * CFrame.Angles(1.5707963267948966, 0, 0)
                table.insert(v15, v17, u18)
                table.insert(v16, v17, v33)
                task.spawn(function() --[[ Line: 53 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u36
                        [3] = u18
                        [4] = u7
                        [5] = u2
                        [6] = u8
                        [7] = u6
                    --]]
                    local v37, v38, v39 = u14:components()
                    local _, _, _, v40, v41, v42, v43, v44, v45, v46, v47, v48 = u36:components()
                    local v49 = CFrame.new(v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48)
                    local v50 = CFrame.new(u36.Position, v49.Position)
                    local v51 = CFrame.Angles
                    local v52 = math.random(20, 50)
                    u36 = v50 * v51(math.rad(v52), 0, 0)
                    local v53 = {
                        ["CFrame"] = u36
                    }
                    _G.tween(u18, {
                        u7,
                        "EntranceExpressive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, v53)
                    u2(u8)
                    if u18 then
                        _G.tween(u18.Mesh, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Scale"] = Vector3.new(1, 0, 0)
                        })
                        _G.tween(u18, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["CFrame"] = u36 * CFrame.new(0, -u6 * 1.25, 0)
                        })
                    end
                end)
            else
                u18:Destroy()
            end
        end
    end
end
return v1