 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5, p6, p7, p8) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v9 = p6 == nil and 500 or p6
            local v10 = p7 == nil and 25 or p7
            for v11 = 1, 5 do
                local v12 = p1 * CFrame.new(math.random(-v9, v9) / 100, math.random(-v9, v9) / 200, math.random(-v9, v9) / 100)
                local v13 = script.Part:Clone()
                v13.CFrame = v12
                if p8 then
                    v13.Color = p8
                    v13.PointLight.Color = p8
                end
                if v11 == 1 then
                    _G.tween(v13.PointLight, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = p3 * 4,
                        ["Brightness"] = 0
                    })
                    v12 = p1
                end
                v13.Parent = workspace.Effects
                local v14 = _G.tween
                local v15 = v13.Mesh
                local v16 = {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }
                local v17 = {}
                local v18 = v10 + p2
                local v19 = v10 + p2
                local v20 = v10 + p2
                v17.Scale = Vector3.new(v18, v19, v20) * math.random(70, 110) / 100
                v14(v15, v16, v17)
                _G.tween(v13, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v13, 0.25)
                local v21 = script.exploson:Clone()
                v21.CFrame = v12
                if p8 then
                    v21.Color = p8
                end
                local v22 = v21.Color
                local v23
                if v11 % 2 == 1 then
                    v22 = BrickColor.new("Black").Color
                    p4 = p5
                    v23 = 1
                else
                    v23 = 1.15
                end
                v21.Parent = workspace.Effects
                local v24 = _G.tween
                local v25 = {
                    1 * p4,
                    "EntranceExpressive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v26 = {}
                local v27 = v21.CFrame
                local v28 = CFrame.Angles
                local v29 = math.random(-360, 900)
                local v30 = math.rad(v29)
                local v31 = math.random(-360, 900)
                local v32 = math.rad(v31)
                local v33 = math.random(-360, 900)
                v26.CFrame = v27 * v28(v30, v32, (math.rad(v33)))
                v24(v21, v25, v26)
                _G.tween(v21, {
                    0.5 * p4,
                    "Smoother",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = v22
                })
                local v34 = _G.tween
                local v35 = {
                    0.35 * p4,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }
                local v36 = {}
                local v37 = 15 + p2
                local v38 = 15 + p2
                local v39 = 15 + p2
                v36.Size = Vector3.new(v37, v38, v39) * v23
                v34(v21, v35, v36)
                _G.destroy(v21, 0.35 * p4 * 2)
            end
        end
    end
}