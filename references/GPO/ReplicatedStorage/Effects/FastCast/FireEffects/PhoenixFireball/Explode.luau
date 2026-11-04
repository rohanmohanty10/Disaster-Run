 

return {
    ["start"] = function(_, p1, _, p2, p3) --[[ Name: start, Line 4 ]]
        p2.back.Enabled = false
        p2.back:Clear()
        p2.back2.Enabled = false
        p2.back2:Clear()
        p2.spark1:Emit(15)
        p2.spark2:Emit(15)
        local v4 = math.random(15, 25)
        p2.Smoke.Size = NumberSequence.new(v4)
        p2.Smoke.Color = ColorSequence.new(p3.Color)
        p2.Smoke:Emit(25)
        p2.BurningPart.Transparency = NumberSequence.new(0)
        p2.Attachment.BurningPart.Transparency = NumberSequence.new(0)
        p2.Attachment.Ring.Size = NumberSequence.new(10, 50)
        p2.Attachment.Ring:Emit(1)
        local v5 = script.dust:Clone()
        v5.Parent = workspace.Effects
        v5.CFrame = p2.CFrame
        v5.Attachment.Rocks.Color = ColorSequence.new(p3.Color)
        _G.customEmit(v5)
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
        for _ = 1, 5 do
            local v6 = script.sphere:Clone()
            v6.Parent = workspace.Effects
            v6.CFrame = p1
            local v7 = math.random(250, 500) / 100
            v6.Mesh.Scale = Vector3.new(v7, v7, v7)
            _G.tween(v6, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v6.CFrame * CFrame.new(math.random(-10000, 10000) / 100, math.random(-10000, 10000) / 100, math.random(-10000, 10000) / 100)
            })
            _G.tween(v6.Mesh, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(v6, 1)
            local v8 = script.sphere:Clone()
            v8.Parent = workspace.Effects
            v8.CFrame = p1
            v8.Color = BrickColor.new("Br. yellowish orange").Color
            local v9 = math.random(250, 500) / 100
            v8.Mesh.Scale = Vector3.new(v9, v9, v9)
            _G.tween(v8, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v8.CFrame * CFrame.new(math.random(-5000, 5000) / 100, math.random(-5000, 5000) / 100, math.random(-5000, 5000) / 100)
            })
            _G.tween(v8.Mesh, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(v8, 1)
        end
    end
}