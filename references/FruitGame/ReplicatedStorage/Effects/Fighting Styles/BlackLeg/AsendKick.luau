 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) ~= false then
            local v3 = script.sphere:Clone()
            v3.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(0, 0, -40) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
            v3.Mesh.Scale = Vector3.new(12, 80, 12)
            v3.Parent = workspace.Effects
            local v4 = _G.tween
            local v5 = v3.Mesh
            local v6 = {
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v7 = {}
            local v8 = v3.Mesh.Scale.Y + 15
            v7.Scale = Vector3.new(0, v8, 0)
            v7.Offset = Vector3.new(0, 47.5, 0)
            v4(v5, v6, v7)
            _G.destroy(v3, 0.15)
            local v9 = p1.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) * CFrame.Angles(-1.5707963267948966, 0, 0)
            _G.PlayEffect("Spheres", nil, {
                ["startSize"] = Vector3.new(0, 0, 0),
                ["xrange"] = 30,
                ["yrange"] = 48,
                ["zrange"] = 30,
                ["cf"] = v9,
                ["ti"] = 0.2,
                ["ti2"] = 0.2,
                ["range"] = 0,
                ["minThick"] = 20,
                ["maxThick"] = 40,
                ["part"] = nil,
                ["color"] = script.sphere.Color,
                ["am"] = 25
            })
            _G.PlayEffect("Shockwave2", nil, v9 * CFrame.new(0, 60, 0), v9, BrickColor.new("Pastel Blue"), Vector3.new(35, 2, 35), Vector3.new(5, 2, 5), 0.5, -1, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
            _G.PlayEffect("Shockwave2", nil, v9 * CFrame.new(0, 20, 0), v9, BrickColor.new("Pastel Blue"), Vector3.new(60, 2, 60), Vector3.new(5, 2, 5), 0.4, -1, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
            local v10 = script.Part:Clone()
            v10.CFrame = v9
            v10.Mesh.Offset = Vector3.new(0, 12.5, 0)
            v10.Mesh.Scale = Vector3.new(20, 25, 20)
            v10.Parent = workspace.Effects
            _G.tween(v10.Mesh, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 0, 0),
                ["Offset"] = Vector3.new(0, 25, 0)
            })
            _G.tween(v10, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v10, 0.25)
            local u11 = script.MeshPart:Clone()
            local v12 = CFrame.Angles
            local v13 = math.random(-360, 360)
            u11.CFrame = v9 * v12(0, math.rad(v13), 1.5707963267948966)
            u11.Parent = workspace.Effects
            local v14 = _G.tween
            local v15 = {
                0.35,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v16 = {}
            local v17 = u11.CFrame * CFrame.new(50, 0, 0)
            local v18 = CFrame.Angles
            local v19 = math.random(-360, 360)
            v16.CFrame = v17 * v18(math.rad(v19), 0, 0)
            v16.Size = u11.Size * 4 + Vector3.new(10, 0, 0)
            v14(u11, v15, v16)
            task.spawn(function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u11
                --]]
                _G.tween(u11, {
                    0.35,
                    "Smooth",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
            end)
            _G.destroy(u11, 0.5)
            local v20 = script.PunchedParticle:Clone()
            v20.CFrame = v9
            v20.Attachment.new3.Size = NumberSequence.new(18, 0)
            v20.Parent = workspace.Effects
            _G.customEmit(v20)
            _G.destroy(v20, 2)
            _G.PlayEffect("PhoenixSlash", nil, 6, {
                ["CFrame"] = v9,
                ["Scale"] = 45,
                ["Accent"] = Color3.fromRGB(255, 170, 0),
                ["Offset"] = CFrame.new(0, 40, 0),
                ["Color"] = Color3.fromRGB(255, 81, 0),
                ["Transparency"] = -1,
                ["Duration"] = 0.25,
                ["RotationDirection"] = 3
            })
            _G.PlayEffect("PhoenixSlash", nil, 5, {
                ["CFrame"] = v9,
                ["Scale"] = 30,
                ["Accent"] = Color3.fromRGB(255, 0, 0),
                ["Offset"] = CFrame.new(0, 50, 0),
                ["Color"] = Color3.fromRGB(255, 81, 0),
                ["Transparency"] = -1,
                ["Duration"] = 0.4,
                ["RotationDirection"] = 3
            })
            for _ = 1, 20 do
                local v21 = script.sph:Clone()
                v21.CFrame = p2 * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.random(-15, 15), 0, math.random(-15, 15))
                v21.Parent = workspace.Effects
                local v22 = math.random(3000, 6000) / 1000
                local v23 = v21.Mesh
                local v24 = math.random(500, 5000) / 100
                v23.Scale = Vector3.new(v22, v24, v22)
                if math.random(1, 2) == 1 then
                    v21.Color = Color3.fromRGB(213, 115, 61)
                end
                local v25 = math.random(200, 400) / 1000
                local v26 = _G.tween
                local v27 = v21.Mesh
                local v28 = {}
                local v29 = v21.Mesh.Scale.Y
                v28.Scale = Vector3.new(0, v29, 0)
                local v30 = -v21.Mesh.Scale.Y * math.random(2, 5)
                v28.Offset = Vector3.new(0, v30, 0)
                v26(v27, {
                    v25,
                    "Smoother",
                    "Out",
                    0,
                    false,
                    0
                }, v28)
                _G.destroy(v21, v25)
            end
        end
    end
}