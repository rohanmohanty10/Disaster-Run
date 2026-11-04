 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p1.p) ~= false then
            local v2 = CFrame.new(p1.p) * CFrame.new(math.random(-2, 2), 0, math.random(-2, 2))
            local v3 = Ray.new(v2.p, v2.UpVector * -10)
            local _, v4, v5 = _G.raycastWhitelist(v3, { workspace.Islands, workspace.Env, workspace.Ships })
            local u6 = script.ball:Clone()
            local v7 = CFrame.new(v4, v4 + v5)
            local v8 = CFrame.Angles
            local v9 = math.random(-360, 360)
            u6.CFrame = v7 * v8(1.5707963267948966, math.rad(v9), 0)
            local v10 = math.random(200, 800) / 50
            u6.Size = Vector3.new(v10, 7, v10) / 2
            u6.Parent = workspace.Effects
            local v11 = _G.tween
            local v12 = {
                0.5,
                "Back",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v13 = {}
            local v14 = math.random(100, 200) / 100
            v13.Size = Vector3.new(v10, v14, v10)
            v11(u6, v12, v13)
            _G.tween(u6, {
                2,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u6.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
            })
            spawn(function() --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                task.wait(1)
                _G.tween(u6, {
                    0.5,
                    "Smooth",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Color"] = Color3.fromRGB(0, 0, 0)
                })
                _G.destroy(u6, 0.5)
            end)
        end
    end
}