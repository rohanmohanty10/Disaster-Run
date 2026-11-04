 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        local v3 = p2.cf
        local v4 = p2.mag
        local v5 = p2.old
        if _G.checkRenderDistance(v3.Position) ~= false then
            for v6 = 1, 2 do
                local v7 = v6 == 2 and -1 or 1
                local v8 = script.Path:Clone()
                local v9 = CFrame.Angles
                local v10 = v7 * 10
                local v11 = v3 * v9(0, math.rad(v10), 0) * CFrame.new(v7 * 4, 0, v4 / 2)
                v8.Size = Vector3.new(0, 0, 0)
                v8.Parent = workspace.Effects
                local v12 = CFrame.Angles
                local v13 = v7 * 10
                v8.CFrame = v3 * v12(0, math.rad(v13), 0) * CFrame.new(v7 * 4, 0, -v4 / 6)
                _G.tween(v8, {
                    0.25,
                    Enum.EasingStyle.Exponential,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v11,
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(0.1, 10, v4)
                })
                _G.destroy(v8, 1)
            end
            for _ = 1, 10 do
                local v14 = script.speedline:Clone()
                local v15 = math.random(10, 35) / 100
                local v16 = math.random(50, 120) / 10
                v14.Size = Vector3.new(v15, v16, v15)
                local v17 = CFrame.new(math.random(-3, 3), math.random(-3, 3), 0) * CFrame.Angles(1.5707963267948966, 0, 0)
                v14.CFrame = v5 * v17
                v14.Parent = workspace.Effects
                _G.tween(v14, {
                    0.2,
                    Enum.EasingStyle.Exponential,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v3 * v17,
                    ["Transparency"] = 1
                })
                _G.destroy(v14, 1)
                if math.random(1, 2) == 1 then
                    v14.Color = Color3.fromRGB(0, 0, 0)
                end
            end
            _G.PlayEffect("Flash", nil, p1, v3, v5, 0.25)
            local v18 = script.trailp:Clone()
            local v19 = (v5.Position - v3.Position).Magnitude
            v18.CFrame = CFrame.new(v5.Position, v3.Position) * CFrame.new(0, 0, -v19 / 2) * CFrame.Angles(1.5707963267948966, 0, 0)
            v18.Mesh.Scale = Vector3.new(1, v19, 1)
            v18.Parent = workspace.Effects
            _G.tween(v18, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.fromRGB(75, 87, 255)
            })
            local v20 = _G.tween
            local v21 = v18.Mesh
            local v22 = {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v23 = {
                ["Scale"] = Vector3.new(0, 0, 0)
            }
            local v24 = -v19 / 2
            v23.Offset = Vector3.new(0, v24, 0)
            v20(v21, v22, v23)
            _G.destroy(v18, 0.25)
            local v25 = Ray.new(v3.Position, v3.upVector * -10)
            local v26, v27, _ = _G.raycastIgnoreList(v25, {
                workspace.Effects,
                workspace.Projectiles,
                workspace.PlayerCharacters,
                workspace.NPCs,
                workspace.Ragdolls
            })
            if v26 then
                local v28 = script.dust:Clone()
                v28.CFrame = CFrame.new(v27, v5.Position)
                v28.Attachment.sm2.Speed = NumberRange.new(5, v19 * 4)
                v28.Attachment.sm2.Size = NumberSequence.new(v19 / 20, v19 / 10)
                v28.Attachment.sm2.Color = ColorSequence.new(v26.Color)
                v28.Parent = workspace.Effects
                _G.customEmit(v28)
                _G.destroy(v28, 2)
            end
        end
    end
}