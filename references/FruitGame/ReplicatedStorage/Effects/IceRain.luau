 

return {
    ["start"] = function(_, p1, _, p2, _, p3, p4) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.Position) then
            local u5 = script.kenTrain.spike:Clone()
            u5.CFrame = p1
            u5.Size = u5.Size * p2
            u5.Parent = workspace.Effects
            local v6 = (u5.CFrame.Position - p3).Magnitude / 200 * (p2 / 2)
            local v7 = CFrame.new(p3, u5.CFrame.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -(u5.Size.Y / 2) + 1, 0)
            local v8 = script.kenTrain.Part:Clone()
            v8.CFrame = CFrame.new(p3, p3 + p4) * CFrame.Angles(0, 1.5707963267948966, 0)
            v8.Transparency = 1
            local v9 = u5.Size.Y
            local v10 = u5.Attachment
            local v11 = v9 / 2 - 1
            v10.Position = Vector3.new(0, v11, 0)
            _G.scaleParticle(u5.Attachment, p2)
            local v12 = u5.a1
            local v13 = -u5.Size.X / 2
            local v14 = -v9 / 2
            v12.Position = Vector3.new(v13, v14, 0)
            local v15 = u5.a2
            local v16 = u5.Size.X / 2
            local v17 = -v9 / 2
            v15.Position = Vector3.new(v16, v17, 0)
            v8.Parent = workspace.Effects
            local v18 = v8.Mesh
            local v19 = 5 * p2
            local v20 = 5 * p2
            v18.Scale = Vector3.new(0.1, v19, v20)
            _G.tween(v8, {
                v6 / 2,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 0
            })
            _G.tween(v8.Mesh, {
                v6,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0.1, 0, 0)
            })
            _G.destroy(v8, v6)
            _G.tween(u5, {
                v6,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v7
            })
            task.delay(v6, function() --[[ Line: 30 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                _G.PlaySound(u5, script.kenTrain.IcicleHitFloor, {
                    ["Pitch"] = math.random(90, 110) / 100
                })
                _G.customEmit(u5)
                _G.tween(u5, {
                    2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(u5, 2)
            end)
        end
    end
}