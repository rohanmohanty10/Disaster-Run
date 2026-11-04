 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            local v3 = script.trailp:Clone()
            local v4 = (p1.Position - p2.Position).Magnitude
            v3.CFrame = CFrame.new(p1.Position, p2.Position) * CFrame.new(0, 0, -v4 / 2) * CFrame.Angles(1.5707963267948966, 0, 0)
            v3.Mesh.Scale = Vector3.new(3, v4, 3)
            v3.Parent = workspace.Effects
            _G.tween(v3, {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.fromRGB(248, 217, 109)
            })
            local v5 = _G.tween
            local v6 = v3.Mesh
            local v7 = {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v8 = {
                ["Scale"] = Vector3.new(0, 0, 0)
            }
            local v9 = -v4 / 2
            v8.Offset = Vector3.new(0, v9, 0)
            v5(v6, v7, v8)
            _G.destroy(v3, 0.25)
            for v10 = 1, 2 do
                local v11 = v10 == 2 and -1 or 1
                local v12 = script.Path:Clone()
                local v13 = CFrame.Angles
                local v14 = v11 * 10
                local v15 = p2 * v13(0, math.rad(v14), 0) * CFrame.new(v11 * 4, 0, v4 / 2)
                local v16 = CFrame.Angles
                local v17 = v11 * 10
                v12.CFrame = p2 * v16(0, math.rad(v17), 0) * CFrame.new(v11 * 4, 0, -v4 / 6)
                v12.Size = Vector3.new(0, 0, 0)
                v12.Parent = workspace.Effects
                _G.tween(v12, {
                    0.25,
                    Enum.EasingStyle.Exponential,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v15,
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(0.1, 10, v4)
                })
                _G.destroy(v12, 0.25)
            end
            for v18 = 1, 10 do
                local v19 = p1:Lerp(p2, v18 / 10)
                local v20 = CFrame.new(v19.Position, p2.Position)
                local v21 = script.s:Clone()
                v21.CFrame = v20 * CFrame.Angles(1.5707963267948966, 0, 0)
                v21.Parent = workspace.Effects
                _G.customEmit(v21.ParticleEmitter2)
                local v22 = {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(25, 10, 25) * (v18 / 10)
                }
                _G.tween(v21, {
                    0.35,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, v22)
                _G.destroy(v21, 0.5)
            end
        end
    end
}