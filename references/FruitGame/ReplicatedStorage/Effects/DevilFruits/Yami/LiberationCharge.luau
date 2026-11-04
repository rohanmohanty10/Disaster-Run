 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) == false then
            return
        end
        local v3 = p1.PrimaryPart.CFrame * CFrame.new(0, 20, 0)
        while true do
            local v4 = Instance.new("Attachment")
            local v5 = math.random(-360, 360)
            local v6 = math.random(-360, 360)
            local v7 = math.random
            v4.Orientation = Vector3.new(v5, v6, v7(-360, 360))
            v4.Parent = p1.PrimaryPart
            local v8 = Instance.new("Attachment")
            local v9 = math.random(-360, 360)
            local v10 = math.random(-360, 360)
            local v11 = math.random
            v8.Orientation = Vector3.new(v9, v10, v11(-360, 360))
            local v12 = math.random(-25, 25)
            local v13 = math.random(10, 60)
            local v14 = math.random
            v8.Position = Vector3.new(v12, v13, v14(-25, 25))
            v8.Parent = p1.PrimaryPart
            local v15 = script.beam:Clone()
            v15.Parent = p1.PrimaryPart
            v15.Attachment0 = v4
            v15.Attachment1 = v8
            v15.CurveSize0 = math.random(5, 15)
            if math.random(1, 2) == 1 then
                v15.CurveSize0 = -v15.CurveSize0
            end
            v15.CurveSize1 = v15.CurveSize0 * -2
            v15.Width0 = math.random(10, 20)
            _G.tween(v15, {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v15.CurveSize0 * -2,
                ["CurveSize1"] = v15.CurveSize1 * 2,
                ["Width0"] = 0
            })
            _G.tween(v8, {
                1,
                "Sine",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["Position"] = Vector3.new()
            })
            _G.destroy({ v4, v8, v15 }, 1)
            local v16 = v3 * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)) * CFrame.new(0, 0, 100)
            local v17 = Ray.new(v3.Position, CFrame.new(v3.Position, v16.Position).LookVector * (v3.Position - v16.Position).Magnitude)
            local v18, v19, _ = _G.raycastWhitelist(v17, { workspace.Islands, workspace.Env, workspace.Ships })
            if v18 then
                local v20 = script.Part:Clone()
                _G.matchMaterial(v20, v18)
                v20.Transparency = 1
                local v21 = math.random(5, 10)
                local v22 = v21 / (math.random(90, 200) / 100)
                local v23 = v21 / (math.random(90, 200) / 100)
                local v24 = v21 / (math.random(90, 200) / 100)
                v20.Size = Vector3.new(v22, v23, v24)
                v20.CFrame = CFrame.new(v19) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                v20.Parent = workspace.Effects
                local v25 = 0.25 + (v3.Position - v16.Position).Magnitude / 250
                _G.tween(v20, {
                    v25,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v3 * CFrame.new(0, math.random(-15, 20), 0) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                })
                _G.tween(v20, {
                    v25 / 2,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 0
                })
                _G.tween(v20.Mesh, {
                    v25,
                    "Cubic",
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new()
                })
                _G.destroy(v20, v25)
            end
            game["Run Service"].Heartbeat:Wait()
            if p2 == nil or (p2.Parent == nil or p2.Name == "done") then
                return
            end
        end
    end
}