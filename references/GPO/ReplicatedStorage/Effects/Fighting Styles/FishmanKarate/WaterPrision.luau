 

return {
    ["start"] = function(_, u1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(u1.LowerTorso.Position) ~= false then
            local u3 = script.b1:Clone()
            u3.CFrame = u1.LowerTorso.CFrame
            u3.Parent = workspace.Effects
            local u4 = nil
            u4 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 13 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u4
                    [3] = u1
                --]]
                if u3.Parent ~= workspace.Effects then
                    u4:Disconnect()
                end
                if u1:FindFirstChild("LowerTorso") then
                    u3.CFrame = u1.LowerTorso.CFrame
                else
                    u4:Disconnect()
                    u4 = nil
                end
            end)
            _G.PlaySound(u3, script.WaterTrap)
            u3.Size = Vector3.new(7, 7, 7)
            _G.tween(u3, {
                0.25,
                "Smooth",
                Enum.EasingDirection.Out,
                -1,
                true,
                0
            }, {
                ["Size"] = Vector3.new(10, 10, 10),
                ["Color"] = Color3.fromRGB(138, 199, 255),
                ["Transparency"] = 0.4
            })
            local u5 = p2 == nil and 1.2 or p2
            task.spawn(function() --[[ Line: 32 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                --]]
                task.wait(u5)
                _G.PlaySound(u3, script.BubblePop)
                task.wait(0.30000000000000004)
                u3.Material = Enum.Material.SmoothPlastic
                _G.tween(u3, {
                    0.25,
                    "EntranceExpressive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(12, 12, 12)
                })
                _G.destroy(u3, 0.25)
                local v6 = u3
                for v7 = 1, 10 do
                    local v8 = script.sphere:Clone()
                    v8.Parent = workspace.Effects
                    v8.CFrame = v6.CFrame
                    v8.Color = script.b1.Color
                    v8.Material = Enum.Material.Glass
                    local v9 = math.random(100, 500) / 100
                    v8.Mesh.Scale = Vector3.new(v9, v9, v9)
                    if v7 % 2 == 1 then
                        v8.Color = Color3.fromRGB(255, 255, 255)
                    end
                    _G.tween(v8.Mesh, {
                        0.45,
                        "EntranceExpressive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(0, 0, 0)
                    })
                    _G.tween(v8, {
                        0.45,
                        "EntranceExpressive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = v8.CFrame * CFrame.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
                    })
                    _G.destroy(v8, 0.45)
                end
            end)
        end
    end
}