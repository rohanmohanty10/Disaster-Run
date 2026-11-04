 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1) ~= false then
            local v3 = CFrame.new(p1)
            _G.PlayEffect("Shockwave2", nil, v3, v3, BrickColor.new("White"), Vector3.new(175, 2, 175), Vector3.new(20, 2, 20), 0.5, -1, Enum.EasingStyle.Quad, Color3.fromRGB(248, 217, 109), Enum.Material.Neon, "Rings")
            local v4 = script.dust:Clone()
            v4.CFrame = CFrame.new(p1)
            v4.Parent = workspace.Effects
            v4.Attachment.ParticleEmitter2.Size = NumberSequence.new(20, 0)
            v4.Attachment.Flare.Size = NumberSequence.new(50, 200)
            v4.Attachment.sm2.Color = ColorSequence.new(p2.Color)
            v4.Attachment.Rocks.Color = ColorSequence.new(p2.Color)
            _G.customEmit(v4.Attachment)
            _G.tween(v4.Attachment.star, {
                0.45,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Size"] = NumberSequence.new(125)
            })
            _G.tween(v4.Attachment.Ring, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = NumberSequence.new(125),
                ["Transparency"] = NumberSequence.new(1)
            })
            _G.tween(v4.Attachment.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Range"] = 50,
                ["Brightness"] = 0
            })
            _G.destroy(v4.Attachment.star, 0.9)
            _G.destroy(v4, 5)
            _G.PlayEffect("GroundRocks", nil, v3, 50, 8, 25, 5)
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = v3,
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = 75,
                ["minThick"] = 10,
                ["maxThick"] = 35,
                ["part"] = v4,
                ["color"] = Color3.fromRGB(248, 217, 109),
                ["am"] = 25
            })
            _G.PlaySound(v4, script.explosion)
            local u5 = script.shock:Clone()
            u5.CFrame = CFrame.new(p1)
            u5.Size = Vector3.new(0, 0, 0)
            u5.Parent = workspace.Effects
            _G.tween(u5, {
                0.5,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.fromRGB(218, 133, 65),
                ["Size"] = Vector3.new(75, 93.75, 75),
                ["CFrame"] = u5.CFrame * CFrame.new(0, 46.875, 0)
            })
            task.spawn(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                task.wait(0.5)
                _G.tween(u5, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Transparency"] = 1,
                    ["CFrame"] = u5.CFrame * CFrame.new(0, -46.875, 0)
                })
                _G.destroy(u5, 1)
            end)
            local v6 = script.Part:Clone()
            v6.CFrame = CFrame.new(p1)
            v6.Color = Color3.fromRGB(255, 255, 255)
            v6.Size = Vector3.new(25, 25, 25)
            v6.Material = Enum.Material.ForceField
            v6.Transparency = -5
            v6.Parent = workspace.Effects
            _G.tween(v6, {
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = Vector3.new(150, 150, 150),
                ["Color"] = Color3.fromRGB(218, 133, 65)
            })
            _G.destroy(v6, 0.35)
            for v7 = 1, 8 do
                local v8 = script.fart:Clone()
                local v9 = CFrame.Angles
                local v10 = v7 * 45
                v8.CFrame = v3 * v9(0, math.rad(v10), 0) * CFrame.new(0, -2, 40)
                v8.CFrame = CFrame.new(v8.Position, v3.Position) * CFrame.Angles(0, 1.5707963267948966, 0)
                v8.Color = p2.Color
                v8.Mesh.Offset = Vector3.new(0, 0, 0)
                local v11 = CFrame.Angles
                local v12 = v7 * 45
                local _ = v3 * v11(0, math.rad(v12), 0)
                v8.Mesh.Scale = Vector3.new(0, 0, 0)
                v8.Parent = workspace.Effects
                _G.tween(v8.Mesh, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Scale"] = Vector3.new(80, 80, 80),
                    ["Offset"] = Vector3.new(10, 0, 0)
                })
                _G.tween(v8, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v8.CFrame * CFrame.Angles(0, 0, -1.5707963267948966),
                    ["Transparency"] = 1
                })
                _G.destroy(v8, 5)
            end
        end
    end
}