 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5, p6) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1) ~= false then
            local v7 = script.dust:Clone()
            v7.CFrame = CFrame.new(p1)
            v7.Attachment.Rocks.Color = ColorSequence.new(p2.Color)
            v7.Attachment.sm2.Color = ColorSequence.new(p2.Color)
            v7.Attachment.sm2.Speed = NumberRange.new(150 + p3)
            v7.Attachment.sm2.Size = NumberSequence.new(0, 10 + p3 / 10)
            v7.Attachment.Rocks.Speed = NumberRange.new(25 + p3, 150 + p3)
            v7.Attachment.Spark3.Speed = NumberRange.new(50 + p3 * 2, 50 + p3 * 4)
            v7.Attachment.Spark3.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, p3 / 20, p3 / 20), NumberSequenceKeypoint.new(1, 0) })
            v7.Attachment.Rocks:Emit(p3 / 2)
            v7.Parent = workspace.Effects
            _G.customEmit(v7)
            _G.destroy(v7, 2)
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = p4,
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = p3 / 3,
                ["minThick"] = p3 / 3,
                ["maxThick"] = p3 / 2,
                ["part"] = v7,
                ["color"] = Color3.fromRGB(255, 255, 255),
                ["am"] = 15
            })
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = p4,
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = p3 / 2,
                ["minThick"] = p3 / 3,
                ["maxThick"] = p3 / 2,
                ["part"] = v7,
                ["color"] = Color3.fromRGB(0, 0, 0),
                ["am"] = 15
            })
            _G.PlayEffect("GroundRocks2", nil, p4, 10 + p3 * 0.1, p3 / 2, p3 / 10, 0.25, 3 + p3 / 10)
            local v8 = p3
            local v9 = p4
            for v10 = 1, 8 do
                local v11 = script.fart:Clone()
                local v12 = CFrame.Angles
                local v13 = v10 * 45
                v11.CFrame = p4 * v12(0, math.rad(v13), 0) * CFrame.new(0, -2, p3 / 3)
                v11.CFrame = CFrame.new(v11.Position, p4.Position) * CFrame.Angles(0, 1.5707963267948966, 0)
                v11.Color = p2.Color
                v11.Mesh.Offset = Vector3.new(0, 0, 0)
                local _ = v11.CFrame
                local v14 = CFrame.Angles
                local v15 = v10 * 45
                local _ = p4 * v14(0, math.rad(v15), 0)
                v11.Mesh.Scale = Vector3.new(0, 0, 0)
                v11.Parent = workspace.Effects
                local v16 = _G.tween
                local v17 = v11.Mesh
                local v18 = {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }
                local v19 = {
                    ["Scale"] = Vector3.new(p3, p3, p3) / 1.5
                }
                local v20 = 5 + p6 / 10
                v19.Offset = Vector3.new(v20, 0, 0)
                v16(v17, v18, v19)
                _G.tween(v11, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v11.CFrame * CFrame.Angles(0, 0, -1.5707963267948966),
                    ["Transparency"] = 1
                })
                _G.destroy(v11, 5)
            end
            local v21 = script.Part:Clone()
            v21.Parent = workspace.Effects
            v21.CFrame = v9
            v21.Mesh.Scale = Vector3.new(v8, v8, v8) * 0.5
            _G.tween(v21.Mesh, {
                0.5,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(v8, v8, v8)
            })
            _G.tween(v21, {
                0.5,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v21, 0.5)
            local v22 = script.Part:Clone()
            v22.Parent = workspace.Effects
            v22.CFrame = v9
            v22.Color = Color3.fromRGB(0, 0, 0)
            v22.Mesh.Scale = Vector3.new(v8, v8, v8) * 0.5
            _G.tween(v22.Mesh, {
                0.75,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(v8, v8, v8) * 1.5
            })
            _G.tween(v22, {
                0.75,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v22, 0.75)
            local v23 = script.Part:Clone()
            local v24 = v8 * 1.25
            v23.CFrame = CFrame.new(p1)
            local v25 = v8 / 2
            v23.Mesh.Scale = Vector3.new(v25, v24, v25)
            v23.Parent = workspace.Effects
            local v26 = _G.tween
            local v27 = v23.Mesh
            local v28 = {
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v29 = {}
            local v30 = v23.Mesh.Scale.Y + 15
            v29.Scale = Vector3.new(0, v30, 0)
            local v31 = v24 / 2
            v29.Offset = Vector3.new(0, v31, 0)
            v26(v27, v28, v29)
            _G.destroy(v23, 0.15)
            local v32 = v9 * CFrame.new(0, 5, 0)
            local v33 = _G.PlayEffect
            local v34 = v32 * CFrame.new(0, -5, 0)
            local v35 = BrickColor.new("White")
            local v36 = v8 / 20
            local v37 = Vector3.new(v8, v36, v8) * 2
            local v38 = v8 / 20
            v33("Shockwave2", nil, v34, v32, v35, v37, Vector3.new(v8, v38, v8) / 2, 0.5, -1, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
            local v39 = v32 * CFrame.new(0, v8 / 4, 0)
            local v40 = _G.PlayEffect
            local v41 = v39 * CFrame.new(0, -5, 0)
            local v42 = BrickColor.new("White")
            local v43 = v8 / 20
            local v44 = Vector3.new(v8, v43, v8) * 1.25
            local v45 = v8 / 20
            v40("Shockwave2", nil, v41, v39, v42, v44, Vector3.new(v8, v45, v8) / 2, 0.5, -1, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
            local v46 = v8 * 2
            for _ = 1, 6 do
                local v47 = script.s:Clone()
                local v48 = p5.cf
                local v49 = CFrame.Angles
                local v50 = math.random(-360, 360)
                local v51 = math.rad(v50)
                local v52 = math.random(-360, 360)
                local v53 = math.rad(v52)
                local v54 = math.random(-360, 360)
                v47.CFrame = v48 * v49(v51, v53, (math.rad(v54)))
                local v55 = math.random(v46 * 0.75, v46 * 1.25)
                v47.Size = Vector3.new(v55, 1, v55) / 2
                v47.Parent = workspace.Effects
                _G.tween(v47, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = v47.Size * 2,
                    ["Transparency"] = 1
                })
                _G.destroy(v47, 0.25)
            end
        end
    end
}