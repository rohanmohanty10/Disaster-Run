 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            _G.PlaySound(p1.HumanoidRootPart, script.StompS)
            local u2 = script.Stomp:Clone()
            u2:PivotTo(p1.HumanoidRootPart.CFrame)
            _G.customEmit(u2.root.Attachment.Sparkles)
            u2.Parent = workspace.Effects
            _G.destroy(u2, 2)
            local v3 = {
                0.48,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local u4 = {
                0.3,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            _G.tween(u2.SwirlA, {
                0.8,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u2.SwirlA.CFrame * CFrame.Angles(0, 0, 3.13),
                ["Size"] = Vector3.new(20, 20, 2),
                ["Transparency"] = 1
            })
            _G.tween(u2.SwirlB, {
                1.1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u2.SwirlB.CFrame * CFrame.Angles(0, 0, -2.13),
                ["Size"] = Vector3.new(27, 27, 3),
                ["Transparency"] = 1
            })
            _G.tween(u2.Ring, v3, {
                ["Size"] = Vector3.new(18, 0.1, 18),
                ["Transparency"] = 1,
                ["CFrame"] = u2.Ring.CFrame * CFrame.new(0, 4.75, 0)
            })
            _G.tween(u2.Spike, u4, {
                ["Size"] = Vector3.new(0.2, 16, 0.2),
                ["Transparency"] = 1,
                ["CFrame"] = u2.Spike.CFrame * CFrame.new(0, 6, 0)
            })
            _G.tween(u2.Tornado, v3, {
                ["Size"] = Vector3.new(24, 3.5, 24),
                ["Transparency"] = 1,
                ["CFrame"] = u2.Tornado.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(u2.Radius.Mesh, v3, {
                ["Scale"] = Vector3.new(22, 0, 22)
            })
            _G.tween(u2.Radius.Decal, v3, {
                ["Transparency"] = 1
            })
            local v5, _, _ = _G.getRayFloor(u2.PrimaryPart.CFrame, 20)
            if v5 then
                u2.root.Attachment.sm2.Color = ColorSequence.new(v5.Color)
                _G.customEmit(u2.root.Attachment.sm2)
            end
            spawn(function() --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u4
                --]]
                local v6 = u2.LightningParticles:GetChildren()
                local v7 = Random.new()
                local v8 = 0
                local v9 = 0
                local v10 = 100
                while v8 < 0.8 do
                    local v11 = task.wait(0.0333333)
                    v8 = v8 + v11
                    v9 = v9 + v11
                    for v12 = 1, #v6 do
                        v6[v12]:Emit(1)
                    end
                    local v13 = v8 * 25 + 7
                    u2.LightningParticles.Size = Vector3.new(v13, 4, v13)
                    if v9 > 0.14 then
                        v9 = v9 - 0.14
                        local v14 = v7:NextNumber(-v13, v13) * 0.25
                        local v15 = script.AirLines:Clone()
                        v15.CFrame = u2.root.CFrame * CFrame.new(v14, 4, v14) * CFrame.Angles(0, 0, 1.570795)
                        v15.Parent = u2
                        _G.tween(v15, u4, {
                            ["Size"] = Vector3.new(0.5, 40, 41),
                            ["Transparency"] = 1,
                            ["CFrame"] = v15.CFrame * CFrame.new(-8, 0, 0),
                            ["Color"] = Color3.new(0.168627, 0, 0)
                        })
                    end
                    v10 = v10 * 1.25
                    u2.root.Attachment.spin2.RotSpeed = NumberRange.new(v10, v10 * 1.5)
                    u2.root.Attachment.spin2:Emit(1)
                    local v16 = u2.root.Attachment.Lines
                    local v17 = v10 / 2
                    v16.Acceleration = Vector3.new(0, v17, 0)
                    u2.root.Attachment.Lines:Emit(6)
                end
            end)
        end
    end
}