 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            local v2 = p1:Clone()
            p1:Destroy()
            v2.Parent = workspace.Effects
            v2.PrimaryPart:BreakJoints()
            local v3 = v2.Cracks:GetChildren()
            for v4 = 1, #v3 do
                v3[v4].Parent = workspace.Effects
                v3[v4].Anchored = false
                _G.tween(v3[v4], {
                    1,
                    "Quad",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0)
                })
                local v5 = v3[v4]
                local v6 = math.random(-25, 25)
                local v7 = math.random(5, 50)
                local v8 = math.random
                v5.Velocity = Vector3.new(v6, v7, v8(-25, 25))
                local v9 = v3[v4]
                local v10 = math.random(-5, 5)
                local v11 = math.random(-5, 5)
                local v12 = math.random
                v9.RotVelocity = Vector3.new(v10, v11, v12(-25, 25))
                _G.destroy(v3[v4], 1)
            end
            local v13 = script.Part:Clone()
            v13.CFrame = v2:GetModelCFrame()
            v13.Parent = workspace.Effects
            _G.tween(v13, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(8, 8, 8),
                ["Transparency"] = 1
            })
            _G.destroy(v13, 0.25)
        end
    end
}