 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            local v4 = script.trailp:Clone()
            local v5 = (p1.Position - p2.Position).Magnitude
            v4.CFrame = CFrame.new(p1.Position, p2.Position) * CFrame.new(0, 0, -v5 / 2) * CFrame.Angles(1.5707963267948966, 0, 0)
            v4.Mesh.Scale = Vector3.new(4, v5, 4)
            v4.Parent = workspace.Effects
            _G.tween(v4, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.fromRGB(255, 81, 0)
            })
            local v6 = _G.tween
            local v7 = v4.Mesh
            local v8 = {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v9 = {
                ["Scale"] = Vector3.new(0, 0, 0)
            }
            local v10 = -v5 / 2
            v9.Offset = Vector3.new(0, v10, 0)
            v6(v7, v8, v9)
            _G.destroy(v4, 1)
            local v11 = script.tpball:Clone()
            v11.CFrame = p2
            v11.Parent = workspace.Effects
            _G.tween(v11.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 13,
                ["Brightness"] = 0
            })
            _G.customEmit(v11)
            _G.destroy(v11, 3)
            local v12 = v5 / 5
            for v13 = 1, v12 do
                local v14 = p1:Lerp(p2, v13 / v12)
                local v15 = Ray.new(v14.Position, v14.upVector * -10)
                local _, v16 = _G.raycastIgnoreList(v15, { workspace.Effects, p3 })
                local v17 = script.trail:Clone()
                v17.CFrame = CFrame.new(v16)
                v17.Parent = workspace.Effects
                _G.customEmit(v17)
                _G.tween(v17.PointLight, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = BrickColor.new("Gold").Color,
                    ["Range"] = 0
                })
                _G.destroy(v17, 1)
            end
        end
    end
}