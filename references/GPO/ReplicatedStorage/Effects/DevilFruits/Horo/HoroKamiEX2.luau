 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            _G.shakenear(p1.Position, 150, 125, 150, -0.5)
            local v2 = script.explosion:Clone()
            v2.CFrame = p1
            v2.Parent = workspace.Effects
            _G.PlaySound(v2, script.boom)
            _G.customEmit(v2.Attachment)
            _G.tween(v2.Lighting.PointLight, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 50,
                ["Brightness"] = 0
            })
            _G.destroy(v2, 6)
            local v3 = CFrame.new(p1.Position)
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = v3,
                ["ti"] = 0.2,
                ["ti2"] = 0.25,
                ["range"] = 25,
                ["minThick"] = 1,
                ["maxThick"] = 5,
                ["part"] = nil,
                ["color"] = BrickColor.new("Toothpaste").Color,
                ["am"] = 30
            })
            local v4 = Ray.new(v3.Position, v3.upVector * -15)
            local v5, v6, v7 = _G.raycastWhitelist(v4, { workspace.Islands, workspace.Env, workspace.Ships })
            if v5 then
                local u8 = script.ex:Clone()
                u8.CFrame = CFrame.new(v6, v6 + v7) * CFrame.Angles(-1.5707963267948966, 0, 0)
                u8.Parent = workspace.Effects
                task.delay(4, function() --[[ Line: 32 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    _G.tween(u8.Decal, {
                        1,
                        "Sine",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(u8, 1)
                end)
                local v9 = (u8.CFrame + Vector3.new(0, 1, 0)).Position
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 20,
                    ["Position"] = v9 + Vector3.new(0, 2, 0),
                    ["DistanceRandomness"] = Vector2.new(0.5, 1),
                    ["Duration"] = 4,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 20,
                    ["Direction"] = -v7 * 45,
                    ["Angle"] = -0.6108652381980153
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 5,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 2,
                    ["Position"] = v9,
                    ["Direction"] = Vector3.new(0, 15, 0),
                    ["RaycastDirection"] = -v7 * 15,
                    ["Size"] = Vector3.new(0.8, 0.8, 0.8),
                    ["TrailEnabled"] = true
                })
            end
            local v10 = v3 * CFrame.new(0, -3, 0)
            local v11 = script.disin:Clone()
            v11.CFrame = v10
            v11.Parent = workspace.Effects
            _G.customEmit(v11)
            _G.destroy(v11, 7)
            local v12 = script.Part:Clone()
            v12.CFrame = v10
            v12.Mesh.Scale = Vector3.new(17.5, 17.5, 17.5)
            v12.Parent = workspace.Effects
            _G.tween(v12.Mesh, {
                0.25,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(52.5, 52.5, 52.5)
            })
            _G.tween(v12, {
                0.25,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v12, 0.25)
        end
    end
}