 

return {
    ["start"] = function(_, p1, p2, p3, p4) --[[ Name: start, Line 6 ]]
        if _G.checkRenderDistance(p2) ~= false then
            local v5 = 35 * p4
            for _ = 1, 35 * p4 do
                local v6 = script.sph:Clone()
                local v7 = CFrame.new(p2)
                local v8 = CFrame.Angles
                local v9 = math.random(-360, 360)
                v6.CFrame = v7 * v8(0, math.rad(v9), 0) * CFrame.new(0, math.random(10, 30), math.random(0, v5))
                v6.Parent = workspace.Effects
                local v10 = math.random(500, 2000) / 1000
                local v11 = v6.Mesh
                local v12 = math.random(500, 5000) / 100
                v11.Scale = Vector3.new(v10, v12, v10) * p4
                if math.random(1, 2) == 1 then
                    v6.Color = Color3.fromRGB(102, 207, 255)
                end
                local v13 = _G.tween
                local v14 = v6.Mesh
                local v15 = {}
                local v16 = v6.Mesh.Scale.Y
                v15.Scale = Vector3.new(0, v16, 0)
                local v17 = -v6.Mesh.Scale.Y * 2.5
                v15.Offset = Vector3.new(0, v17, 0)
                v13(v14, {
                    0.25,
                    "Smoother",
                    "Out",
                    0,
                    false,
                    0
                }, v15)
                _G.destroy(v6, 0.25)
            end
            task.wait(0.1)
            if p1 then
                local v18 = _G.PlayEffect
                local v19 = CFrame.new(p2, p2 + p3) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local v20 = 35 * p4
                local v21 = p4 / 1.5
                v18("GuraCrack", nil, v19, v20, math.clamp(v21, 1, 20) * 9)
                local v22 = _G.PlayEffect
                local v23 = CFrame.new(p2)
                local v24 = p4 / 2
                local v25 = math.clamp(v24, 1, 50) * 30
                local v26 = 40 * p4
                local v27 = p4 / 2
                v22("GroundRocks2", nil, v23, v25, v26, math.clamp(v27, 1, 50) * 8, 0.1, 10)
                local v28 = script.dust:Clone()
                v28.Parent = workspace.Effects
                v28.CFrame = CFrame.new(p2)
                v28.Attachment.Rocks.Color = ColorSequence.new(p1.Color)
                v28.Attachment.sm2.Color = ColorSequence.new(p1.Color)
                v28.Attachment.sm3.Color = ColorSequence.new(p1.Color)
                v28.Attachment.sm3.Size = NumberSequence.new(0, 25)
                v28.Attachment.rings.Size = NumberSequence.new(0, 100)
                _G.customEmit(v28.Attachment)
                _G.destroy(v28, 2)
                local v29 = CFrame.new(p2) * CFrame.Angles(3.141592653589793, 0, 0) * CFrame.new(0, -10, 0)
                _G.PlayEffect("Shockwave2", nil, v29 * CFrame.new(0, 8, 0), v29, BrickColor.new("White"), Vector3.new(125, 3, 125) * p4, Vector3.new(35, 3, 35) * p4, 0.5, -1, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
            end
            _G.PlayEffect("PhoenixSlash", nil, 8, {
                ["CFrame"] = CFrame.new(p2, p2 + p3) * CFrame.Angles(-1.5707963267948966, 0, 0),
                ["Scale"] = 75 * p4,
                ["Accent"] = Color3.fromRGB(102, 207, 255),
                ["Offset"] = CFrame.new(0, 5, 0),
                ["Color"] = Color3.fromRGB(255, 255, 255),
                ["Transparency"] = -1,
                ["Duration"] = 0.45,
                ["RotationDirection"] = -6
            })
            for _ = 1, 3 do
                _G.PlayEffect("PhoenixSlash", nil, math.random(1, 4), {
                    ["CFrame"] = CFrame.new(p2, p2 + p3) * CFrame.Angles(-1.5707963267948966, 0, 0),
                    ["Scale"] = 100 * p4,
                    ["Accent"] = Color3.fromRGB(102, 207, 255),
                    ["Offset"] = CFrame.new(0, 5, 0),
                    ["Color"] = Color3.fromRGB(255, 255, 255),
                    ["Transparency"] = -1,
                    ["Duration"] = 0.6,
                    ["RotationDirection"] = -2
                })
            end
        end
    end
}