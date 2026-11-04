 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v6 = script.Part:Clone()
            v6.CFrame = p1
            v6.Attachment.ParticleEmitter2.Size = NumberSequence.new(5, 20)
            v6.Parent = workspace.Effects
            _G.tween(v6, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(v6.Mesh, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(p2, p2, p2) / 2
            })
            _G.customEmit(v6)
            _G.destroy(v6, 0.25)
            for _ = 1, 6 do
                local v7 = script.s:Clone()
                local v8 = CFrame.Angles
                local v9 = math.random(-360, 360)
                local v10 = math.rad(v9)
                local v11 = math.random(-360, 360)
                local v12 = math.rad(v11)
                local v13 = math.random(-360, 360)
                v7.CFrame = p1 * v8(v10, v12, (math.rad(v13)))
                local v14 = math.random(25, 45)
                v7.Size = Vector3.new(v14, 1, v14) / 2
                v7.Parent = workspace.Effects
                _G.tween(v7, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = v7.Size * 2,
                    ["Transparency"] = 1
                })
                _G.destroy(v7, 0.25)
            end
            _G.PlayEffect("GroundRocks", nil, p1, p3, 1 + p4 / 2, 20 + p4 * 3, 4)
            local v15 = _G.PlayEffect
            local v16 = BrickColor.new("White")
            local v17 = p3 * 4
            local v18 = p3 * 4
            local v19 = Vector3.new(v17, 1, v18)
            local v20 = p3 * 2
            local v21 = p3 * 2
            v15("Shockwave2", nil, p1, p1, v16, v19, Vector3.new(v20, 1, v21), 0.25, 0, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
            local v22 = 5 + p4
            local v23 = Color3.fromRGB(170, 255, 127)
            if p4 % 2 == 0 then
                v23 = Color3.fromRGB(110, 153, 202)
            end
            _G.PlayEffect("Spheres", nil, {
                ["xrange"] = v22 / 1.5,
                ["yrange"] = v22 * 1.25,
                ["zrange"] = v22 / 1.5,
                ["cf"] = p1,
                ["ti"] = 0.25,
                ["ti2"] = 0.1,
                ["range"] = v22,
                ["minThick"] = 1,
                ["maxThick"] = 10,
                ["part"] = nil,
                ["color"] = p5 or v23,
                ["am"] = 15
            })
        end
    end
}