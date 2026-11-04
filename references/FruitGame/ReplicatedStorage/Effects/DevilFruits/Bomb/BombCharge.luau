 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v3 = tick()
            local v4 = 50
            local v5 = 0
            local v6 = 0
            while v4 > 3 do
                local v7 = tick() - v3
                v3 = tick()
                v4 = v4 - v7 * 4
                if tick() - v5 >= 0.25 then
                    local v8 = p2:Clone()
                    v8.CFrame = p1.CFrame
                    v8.Mesh.Scale = v8.Mesh.Scale * 3
                    v8.Anchored = true
                    v8.Charge:Destroy()
                    v8.Transparency = 0.5
                    v8.Color = Color3.fromRGB(255, 255, 255)
                    v8:BreakJoints()
                    v8.Parent = workspace.Effects
                    _G.tween(v8, {
                        0.5,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(v8.Mesh, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(0, 0, 0)
                    })
                    _G.destroy(v8, 0.5)
                    v5 = tick()
                end
                if tick() - v6 >= 0.0075 then
                    local v9 = script.cyn:Clone()
                    v9.CFrame = p1.CFrame * CFrame.new(math.random(-v4, v4), math.random(-v4, v4), math.random(-v4, v4))
                    v9.CFrame = CFrame.new(v9.Position, p1.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    local v10 = (v9.Position - p1.Position).Magnitude
                    local v11 = math.random(50, 150) / 100
                    v9.Mesh.Scale = Vector3.new(v11, v10, v11)
                    if math.random(1, 2) == 1 then
                        v9.Color = Color3.fromRGB(0, 0, 0)
                    end
                    v9.Parent = workspace.Effects
                    _G.tween(v9.Mesh, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(0, 0, 0),
                        ["Offset"] = Vector3.new(0, v10, 0)
                    })
                    _G.destroy(v9, 0.25)
                    v6 = tick()
                end
                game["Run Service"].Heartbeat:Wait()
                if p2 == nil or p2.Parent == nil then
                    break
                end
            end
        end
    end
}