 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p4.Position) ~= false then
            local v6 = script.dust:Clone()
            v6.CFrame = CFrame.new(p5)
            v6.Parent = workspace.Effects
            v6.Attachment.Rocks.Color = ColorSequence.new(p1.Color)
            v6.Attachment.sm2.Color = ColorSequence.new(p1.Color)
            v6.Attachment.Rocks.Speed = NumberRange.new(75 * p3, 150 * p3)
            v6.Attachment.sm2.Speed = NumberRange.new(35 * p3, 60 * p3)
            v6.Attachment.Rocks.Lifetime = NumberRange.new(1 * p3, 2 * p3)
            v6.Attachment.sm2.Lifetime = NumberRange.new(1 * p3, 2 * p3)
            v6.Attachment.sm2:Emit(15)
            v6.Attachment.Rocks:Emit(15)
            _G.destroy(v6, 2 * p3)
            local v7 = 15 * p3
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = p4,
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = v7,
                ["minThick"] = 10 * p3,
                ["maxThick"] = 40 * p3,
                ["part"] = v6,
                ["color"] = Color3.fromRGB(110, 153, 202),
                ["am"] = 15
            })
            _G.PlayEffect("Spheres", nil, {
                ["xrange"] = v7 / 1.5,
                ["yrange"] = v7 * 1.25,
                ["zrange"] = v7 / 1.5,
                ["cf"] = p4,
                ["ti"] = 0.25,
                ["ti2"] = 0.1,
                ["range"] = 15,
                ["minThick"] = 5 * p3,
                ["maxThick"] = 15 * p3,
                ["part"] = v6,
                ["color"] = Color3.fromRGB(170, 255, 127),
                ["am"] = 15
            })
            _G.PlayEffect("GroundRocks2", nil, p4, 10 * p3, 15 * p3, 4 * p3, 0.25, 3)
            local v8 = script.Part:Clone()
            v8.Parent = workspace.Effects
            v8.CFrame = p4
            _G.tween(v8.Mesh, {
                0.25,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(35, 35, 35) * p3
            })
            _G.tween(v8, {
                0.25,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v8, 0.5)
            _G.PlaySound(v8, script.Wallhit, {
                ["RollOffMaxDistance"] = 125 * p3
            })
            local v9 = p4 * CFrame.new(0, 3, 0)
            _G.PlayEffect("Shockwave2", nil, v9 * CFrame.new(0, -3, 0), v9, BrickColor.new("White"), Vector3.new(45, 1, 45) * p3, Vector3.new(25, 1, 25) * p3, 0.5, -1, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
            _G.PlayEffect("Shockwave2", nil, v9 * CFrame.new(0, 10, 0), v9, BrickColor.new("White"), Vector3.new(25, 1, 25) * p3, Vector3.new(5, 1, 5) * p3, 0.25, -1, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
            local _ = 50 * p3
            _G.PlayEffect("PhoenixSlash", nil, 8, {
                ["CFrame"] = CFrame.new(p5, p5 + p2) * CFrame.Angles(-1.5707963267948966, 0, 0),
                ["Scale"] = 25 * p3,
                ["Accent"] = Color3.fromRGB(170, 255, 127),
                ["Offset"] = CFrame.new(0, 5, 0),
                ["Color"] = Color3.fromRGB(110, 153, 202),
                ["Transparency"] = -1,
                ["Duration"] = 0.5,
                ["RotationDirection"] = -3
            })
            _G.PlayEffect("PhoenixSlash", nil, 6, {
                ["CFrame"] = CFrame.new(p5, p5 + p2) * CFrame.Angles(-1.5707963267948966, 0, 0),
                ["Scale"] = 25 * p3,
                ["Accent"] = Color3.fromRGB(170, 255, 127),
                ["Offset"] = CFrame.new(0, 10, 0),
                ["Color"] = Color3.fromRGB(110, 153, 202),
                ["Transparency"] = -1,
                ["Duration"] = 0.45,
                ["RotationDirection"] = -3
            })
            local v10 = script.sph:Clone()
            v10.CFrame = CFrame.new(p5)
            v10.Mesh.Scale = Vector3.new(15, 45, 15) * p3
            v10.Parent = workspace.Effects
            local v11 = _G.tween
            local v12 = v10.Mesh
            local v13 = {
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v14 = {}
            local v15 = v10.Mesh.Scale.Y + 15
            v14.Scale = Vector3.new(0, v15, 0)
            v14.Offset = Vector3.new(0, 22.5, 0)
            v11(v12, v13, v14)
            _G.destroy(v10, 0.15)
        end
    end
}