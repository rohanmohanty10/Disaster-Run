 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 5 ]]
        local v2 = p1.char
        local v3 = p1.cf
        if _G.checkRenderDistance(v3.p) ~= false then
            _G.PlaySound(v2.PrimaryPart, script.Sounds:GetChildren()[math.random(1, #script.Sounds:GetChildren())])
            local v4 = v2.HumanoidRootPart.Velocity.Y / 100
            local v5 = math.abs(v4)
            local v6 = v5 >= 10 and 10 or (v5 < 1 and 1 or v5)
            local v7 = script.SplashEffect:Clone()
            v7.Parent = workspace.Effects
            v7:PivotTo(CFrame.new(v3.p.X, workspace.Env.WaterStuff.Falls.Position.Y, v3.p.Z))
            v7.Effect2.CFrame = v7.Effect2.CFrame * CFrame.Angles(0, math.random(-360, 360), 0) * CFrame.new(0, v6, 0)
            v7.Effect3.CFrame = v7.Effect3.CFrame * CFrame.Angles(0, math.random(-360, 360), 0) * CFrame.new(0, v6, 0)
            v7.Effect1.Transparency = 0.3
            _G.tween(v7.Effect1, {
                0.625,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(7.2, 0.16, 7.2) * v6,
                ["Transparency"] = 1,
                ["CFrame"] = v7.Effect1.CFrame * CFrame.new(0, 5 * v6, 0)
            })
            _G.tween(v7.Effect2, {
                0.5625,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(9, 5, 9) * v6,
                ["Transparency"] = 1,
                ["Color"] = script.SplashEffect.Effect2.Color,
                ["CFrame"] = v7.Effect2.CFrame * CFrame.Angles(0, 45, 0)
            })
            _G.tween(v7.Effect3, {
                0.5625,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(8, 9, 8) * v6,
                ["Transparency"] = 1,
                ["Color"] = script.SplashEffect.Effect3.Color,
                ["CFrame"] = v7.Effect3.CFrame * CFrame.Angles(0, 45, 0)
            })
            local v8 = v7.Effect1:Clone()
            v8.Parent = v7
            v8.Transparency = 0
            _G.tween(v8, {
                0.9375,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(12, 0.2, 12) * v6,
                ["Transparency"] = 1
            })
            _G.destroy(v7, 2)
            local v9 = script.Part:Clone()
            v9.Parent = workspace.Effects
            v9.CFrame = v8.CFrame
            v9.LavaFlow.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2 * v6, 0), NumberSequenceKeypoint.new(0.7, 1.65 * v6, 0), NumberSequenceKeypoint.new(1, 0, 0) })
            v9.LavaFlow.Speed = NumberRange.new(20 * v6, 30 * v6)
            local v10 = v9.LavaFlow
            local v11 = -50 * v6
            v10.Acceleration = Vector3.new(0, v11, 0)
            local v12 = v6 / 2
            local v13 = v12 < 1 and 1 or v12
            v9.LavaFlow:Emit(15 * v13)
            _G.destroy(v9, 1.1)
        end
    end
}