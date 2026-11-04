 

return {
    ["start"] = function(_, u1, u2, u3, p4, p5) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(u1.Position) ~= false then
            local u6 = nil
            local u7 = script.Paw:Clone()
            local u8 = CFrame.Angles(-1.5707963267948966, 0, 0)
            u7.CFrame = u1.CFrame * u8 * CFrame.new(0, 0, -u7.Size.Z / 2)
            if p5 then
                u7.Transparency = p5
            end
            u7.Parent = workspace.Effects
            _G.customEmit(u7)
            if p4 then
                u7.Color = p4
                local v9 = u7:GetDescendants()
                for v10 = 1, #v9 do
                    if v9[v10]:IsA("ParticleEmitter") then
                        v9[v10].Color = ColorSequence.new(p4)
                    end
                end
            end
            _G.tween(u7, { u3, "Quad", "Out" }, {
                ["Size"] = Vector3.new(0.577, 0.526, 0.406),
                ["Transparency"] = 0.35
            })
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = u7.CFrame,
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = 3,
                ["minThick"] = 0.05,
                ["maxThick"] = 0.4,
                ["part"] = u7,
                ["color"] = u7.Color,
                ["am"] = 20
            })
            local u11 = tick()
            local u12 = false
            u6 = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 36 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u11
                    [3] = u3
                    [4] = u6
                    [5] = u7
                    [6] = u1
                    [7] = u8
                    [8] = u12
                --]]
                if u2:IsDescendantOf(game) == false or tick() - u11 >= u3 * 1.25 then
                    u6:Disconnect()
                    u6 = nil
                    u7.Start2.Swirls2.Enabled = false
                    _G.tween(u7, { 0.25, "Quad", "Out" }, {
                        ["Size"] = Vector3.new(0, 0, 0),
                        ["Transparency"] = 1
                    })
                    _G.destroy(u7, 3)
                else
                    u7.CFrame = u1.CFrame * u8 * CFrame.new(0, 0, -u7.Size.Z / 2)
                    if u3 <= tick() - u11 and u12 == false then
                        u12 = true
                        _G.tween(u7, { 0.1, "Quad", "Out" }, {
                            ["Transparency"] = 1
                        })
                        task.wait(0.1)
                        u7.Material = Enum.Material.Neon
                        _G.tween(u7, { 0.1, "Quad", "Out" }, {
                            ["Transparency"] = 0
                        })
                    end
                    u7.Start2.Swirls2.Size = NumberSequence.new(u7.Size.X * 1.2, 0)
                end
            end)
        end
    end
}