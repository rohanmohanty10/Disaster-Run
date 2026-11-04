 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        local v2 = p1.cf
        local v3 = p1.char
        if _G.checkRenderDistance(v2.p) ~= false then
            local v4 = Ray.new(v2.p, v2.UpVector * -20)
            local v5, v6, _ = _G.raycastWhitelist(v4, { workspace.Env, workspace.Ships, workspace.Islands })
            if v5 then
                local v7 = CFrame.new(v6)
                local v8 = v2 * CFrame.new(0, -v3.Humanoid.HipHeight / 2, -1)
                _G.PlayEffect("GroundRocks", nil, v8, math.random(15, 20), 4, 20, 2)
                local u9 = v7.Position
                local v10 = script.dust:Clone()
                v10.Parent = workspace.Effects
                v10.CFrame = CFrame.new(u9)
                v10.Attachment.sm2.Color = ColorSequence.new(v5.Color)
                v10.Attachment.Rocks.Color = ColorSequence.new(v5.Color)
                v10.Attachment.sm2:Emit(40)
                v10.Attachment.Rocks:Emit(20)
                _G.destroy(v10, 3)
                local v11 = script.Part:Clone()
                v11.Parent = workspace.Effects
                v11.CFrame = v8 * CFrame.Angles(-1.5707963267948966, 0, 0)
                _G.tween(v11.PointLight, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 75,
                    ["Brightness"] = 0
                })
                _G.destroy(v11, 0.5)
                _G.PlaySound(v3.Head, script.gauss_electro2)
                _G.PlaySound(v3.Head, script.downsmash)
                _G.PlayEffect("Shockwave2", nil, v8 * CFrame.new(0, 50, 0), v8 * CFrame.new(0, 0, 0), BrickColor.new("Toothpaste"), Vector3.new(55, 0, 55), Vector3.new(10, 2, 10), 0.2, 0, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
                _G.PlayEffect("Shockwave2", nil, v8, v8, BrickColor.new("Toothpaste"), Vector3.new(45, 0, 45), Vector3.new(10, 2, 10), 0.25, 0, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
                local u12 = 15
                for _ = 1, 10 do
                    local v13 = BrickColor.new("Cyan").Color
                    if math.random(1, 2) == 1 then
                        v13 = BrickColor.new("Baby blue").Color
                    end
                    local v14 = {
                        ["color"] = v13,
                        ["color2"] = BrickColor.new("Baby blue").Color,
                        ["ti"] = math.random(100, 400) / 1000,
                        ["decay"] = math.random(100, 200) / 1000,
                        ["bends"] = 2,
                        ["fork_bends"] = 1,
                        ["fork_chance"] = 0,
                        ["transparency"] = 0.5,
                        ["thickness"] = math.random(10, 75) / 200,
                        ["max_depth"] = 50
                    }
                    local v15 = _G.PlayEffect
                    local v16 = math.random(-u12, u12)
                    local v17 = math.random(20, 65)
                    local v18 = math.random
                    local v19 = -u12
                    v15("Lightning", nil, u9, u9 + Vector3.new(v16, v17, v18(v19, u12)), v14)
                    game["Run Service"].Heartbeat:Wait()
                end
                task.spawn(function() --[[ Line: 59 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u9
                    --]]
                    u12 = 35
                    for _ = 1, 10 do
                        local v20 = BrickColor.new("Cyan").Color
                        if math.random(1, 2) == 1 then
                            v20 = BrickColor.new("Baby blue").Color
                        end
                        local v21 = {
                            ["color"] = v20,
                            ["color2"] = BrickColor.new("Baby blue").Color,
                            ["ti"] = math.random(100, 200) / 1000,
                            ["decay"] = math.random(100, 200) / 1000,
                            ["bends"] = 2,
                            ["fork_bends"] = 1,
                            ["fork_chance"] = 0,
                            ["transparency"] = 0.5,
                            ["thickness"] = math.random(10, 75) / 200,
                            ["max_depth"] = 50
                        }
                        local v22 = math.random(-u12, u12)
                        local v23 = math.random(5, 10)
                        local v24 = math.random
                        local v25 = -u12
                        local v26 = u12
                        local v27 = Vector3.new(v22, v23, v24(v25, v26))
                        _G.PlayEffect("Lightning", nil, u9 + v27 / 2, u9 + v27, v21)
                    end
                end)
            end
        end
    end
}