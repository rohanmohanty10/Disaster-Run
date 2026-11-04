 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 18 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            for _ = 1, 12 do
                local v2 = script.ball:Clone()
                local v3 = math.random(5, 10)
                local v4 = CFrame.new(p1.Position) * CFrame.new(0, 0, 0)
                local v5 = CFrame.Angles
                local v6 = math.random(-360, 360)
                v2.CFrame = v4 * v5(0, math.rad(v6), 0)
                local v7 = v2.CFrame * CFrame.new(math.random(-2, 2), math.random(1, 2), -math.random(-2, 2))
                v2.CFrame = CFrame.new(v2.Position, v7.Position) * CFrame.new(0, v3 / 2, 0)
                local v8 = v3 * 2
                v2.Size = Vector3.new(4, v8, 4) * math.random(10, 100) / 100
                v2.Parent = workspace.Effects
                _G.tween(v2, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["CFrame"] = v2.CFrame * CFrame.new(0, v3, 0)
                })
                _G.destroy(v2, 0.25)
            end
            for _ = 1, 20 do
                local u9 = script.ball:Clone()
                u9.Anchored = false
                u9.Size = Vector3.new(5, 5, 5)
                u9.Size = u9.Size * math.random(25, 60) / 100
                local v10 = CFrame.new(p1.Position)
                local v11 = CFrame.Angles
                local v12 = math.random(-360, 360)
                local v13 = math.rad(v12)
                local v14 = math.random(-360, 360)
                local v15 = math.rad(v14)
                local v16 = math.random(-360, 360)
                u9.CFrame = v10 * v11(v13, v15, (math.rad(v16)))
                u9.Parent = workspace.Effects
                local v17 = math.random(-25, 25)
                local v18 = math.random(50, 100)
                local v19 = math.random
                u9.Velocity = Vector3.new(v17, v18, v19(-25, 25))
                local v20 = math.random(-5, 5)
                local v21 = math.random(-5, 5)
                local v22 = math.random
                u9.RotVelocity = Vector3.new(v20, v21, v22(-5, 5))
                spawn(function() --[[ Line: 48 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                    --]]
                    task.wait(math.random(100, 500) / 1000)
                    _G.tween(u9, {
                        0.5,
                        "Smoother",
                        Enum.EasingDirection.In,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = Vector3.new(0, 0, 0)
                    })
                    _G.destroy(u9, 0.5)
                end)
            end
        end
    end
}