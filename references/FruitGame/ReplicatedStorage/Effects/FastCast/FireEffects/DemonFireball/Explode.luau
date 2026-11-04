 

return {
    ["start"] = function(_, p1, _, p2, p3) --[[ Name: start, Line 4 ]]
        p2.back.Enabled = false
        p2.back:Clear()
        p2.back2.Enabled = false
        p2.back2:Clear()
        local v4 = math.random(8, 15)
        p2.Smoke.Size = NumberSequence.new(v4)
        p2.Smoke.Color = ColorSequence.new(p3.Color)
        p2.Smoke:Emit(25)
        p2.BurningPart.Transparency = NumberSequence.new(0)
        local v5 = script.dust:Clone()
        v5.Parent = workspace.Effects
        v5.CFrame = p2.CFrame
        v5.Attachment.Rocks.Color = ColorSequence.new(p3.Color)
        v5.Attachment.Rocks:Emit(35)
        _G.destroy(v5, 2)
        _G.tween(v5.PointLight, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 40,
            ["Brightness"] = 0
        })
        for _ = 1, 10 do
            local v6 = script.sphere:Clone()
            v6.Parent = workspace.Effects
            v6.CFrame = p1
            local v7 = math.random(150, 300) / 100
            v6.Mesh.Scale = Vector3.new(v7, v7, v7)
            _G.tween(v6, {
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v6.CFrame * CFrame.new(math.random(-3000, 3000) / 100, math.random(-3000, 3000) / 100, math.random(-3000, 3000) / 100)
            })
            _G.tween(v6.Mesh, {
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(v6, 0.35)
            local v8 = script.sphere:Clone()
            v8.Parent = workspace.Effects
            v8.CFrame = p1
            v8.Color = Color3.fromRGB(255, 89, 89)
            local v9 = math.random(250, 500) / 100
            v8.Mesh.Scale = Vector3.new(v9, v9, v9)
            _G.tween(v8, {
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v8.CFrame * CFrame.new(math.random(-3000, 3000) / 100, math.random(-3000, 3000) / 100, math.random(-3000, 3000) / 100)
            })
            _G.tween(v8.Mesh, {
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(v8, 0.35)
        end
    end
}