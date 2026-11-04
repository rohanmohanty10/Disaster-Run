 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v3 = tick()
            local v4 = p1:Clone()
            v4:BreakJoints()
            v4:ClearAllChildren()
            v4.Anchored = true
            v4.Parent = workspace.Effects
            local v5 = script.sfx:Clone()
            v5.Parent = v4
            v5:Play()
            tick()
            local v6 = 10
            local v7 = 0
            local v8 = 0
            while v6 > 1 and (p2 ~= nil and p2.Parent ~= nil) do
                v4.CFrame = p1.CFrame
                local v9 = tick() - v3
                v3 = tick()
                v6 = v6 - v9 * 2
                if tick() - v7 >= 0.25 then
                    local v10 = script.Part:Clone()
                    v10.CFrame = p1.CFrame
                    v10.Mesh.Scale = Vector3.new(v6, v6, v6)
                    v10.Anchored = false
                    local v11 = Instance.new("Weld")
                    v11.Part0 = v4
                    v11.Part1 = v10
                    v11.Parent = v10
                    v10.Parent = workspace.Effects
                    v10.PointLight.Range = v6 * 2
                    _G.tween(v10.PointLight, {
                        0.5,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 0
                    })
                    _G.tween(v10, {
                        0.5,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(v10.Mesh, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(0, 0, 0)
                    })
                    _G.destroy(v10, 0.5)
                    v7 = tick()
                end
                if tick() - v8 >= 0.001 then
                    local v12 = script.cyn:Clone()
                    if math.random(1, 2) == 1 then
                        v12.Color = Color3.fromRGB(0, 0, 0)
                    end
                    v12.CFrame = p1.CFrame * CFrame.new(math.random(-v6, v6), math.random(-v6, v6), math.random(-v6, v6))
                    v12.CFrame = CFrame.new(v12.Position, p1.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v12.Anchored = true
                    local v13 = (v12.Position - p1.Position).Magnitude
                    local v14 = math.random(10, 50) / 100
                    v12.Mesh.Scale = Vector3.new(v14, v13, v14)
                    v12.Parent = workspace.Effects
                    _G.tween(v12.Mesh, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(0, 0, 0),
                        ["Offset"] = Vector3.new(0, v13, 0)
                    })
                    _G.destroy(v12, 0.25)
                    v8 = tick()
                end
                game["Run Service"].Heartbeat:Wait()
                if p2 == nil or p2.Parent == nil then
                    break
                end
            end
            v5:Destroy()
            _G.destroy(v4, 2)
        end
    end
}