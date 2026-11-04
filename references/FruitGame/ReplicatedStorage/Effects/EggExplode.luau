 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            local v2 = p1:Clone()
            p1:Destroy()
            local v3 = v2.PrimaryPart.CFrame
            local _ = v2.PrimaryPart.Color
            local v4 = nil
            v2.PrimaryPart:BreakJoints()
            v2.PrimaryPart:Destroy()
            v2.Parent = workspace.Effects
            _G.destroy(v2, 2)
            _G.PlayEffect("BombExplosion", nil, v3, -5, 15, 0.25, 0.75, 300, 15, v4)
            local v5 = v2.Cracks:GetChildren()
            for v6 = 1, #v5 do
                local v7 = v5[v6]
                local v8 = math.random(-45, 45)
                local v9 = math.random(60, 125)
                local v10 = math.random
                v7.Velocity = Vector3.new(v8, v9, v10(-45, 45))
                local v11 = v5[v6]
                local v12 = math.random(-5, 5)
                local v13 = math.random(-5, 5)
                local v14 = math.random
                v11.RotVelocity = Vector3.new(v12, v13, v14(-45, 45))
            end
            local v15 = script.Part:Clone()
            v15.CFrame = v3
            if v4 then
                v15.Color = v4
            end
            v15.Parent = workspace.Effects
            v15.Mesh.Scale = Vector3.new(6.25, 6.25, 6.25)
            _G.tween(v15.Mesh, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Scale"] = Vector3.new(25, 25, 25) * math.random(70, 110) / 100
            })
            _G.tween(v15, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v15, 0.25)
        end
    end
}