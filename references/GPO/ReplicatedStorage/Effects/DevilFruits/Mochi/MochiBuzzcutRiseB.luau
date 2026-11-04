 

return {
    ["start"] = function(_, u1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(u1.HumanoidRootPart.Position) then
            _G.PlaySound(u1.HumanoidRootPart, script.MochiBuzzSpin)
            _G.PlaySound(u1.HumanoidRootPart, script.WooshB)
            local v2 = script.MRiseB:Clone()
            v2:PivotTo(u1.HumanoidRootPart.CFrame)
            v2.Parent = workspace.Effects
            local v3, _, _ = _G.getRayFloor(v2.PrimaryPart.CFrame, 20)
            if v3 then
                v2.root.Attachment.sm2.Color = ColorSequence.new(v3.Color)
                _G.customEmit(v2.root.Attachment.sm2)
            end
            _G.destroy(v2, 2)
            local v4 = {
                0.3,
                "Linear",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }
            local v5 = {
                0.55,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            _G.tween(v2.SwirlA, {
                0.6,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v2.SwirlA.CFrame * CFrame.Angles(0, 0, 3.13),
                ["Size"] = Vector3.new(80, 80, 4),
                ["Transparency"] = 1
            })
            _G.tween(v2.SwirlLinger, v5, {
                ["Size"] = Vector3.new(12, 35, 12),
                ["Transparency"] = 1,
                ["CFrame"] = v2.SwirlLinger.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(v2.TravelSwirl, {
                1.25,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(45, 12, 10),
                ["Transparency"] = 1,
                ["CFrame"] = v2.TravelSwirl.CFrame * CFrame.new(23, 0, 0) * CFrame.Angles(3.13, 0, 0)
            })
            _G.tween(v2.Ring, v4, {
                ["Size"] = Vector3.new(18, 0.05, 18),
                ["Transparency"] = 1,
                ["CFrame"] = v2.Ring.CFrame * CFrame.new(0, 12, 0)
            })
            _G.tween(v2.tornado1, v4, {
                ["Size"] = Vector3.new(2, 30, 2),
                ["Transparency"] = 1,
                ["CFrame"] = v2.tornado1.CFrame * CFrame.new(0, -15, 0) * CFrame.Angles(0, -3.13, 0)
            })
            _G.tween(v2.SwooshA.Mesh, v4, {
                ["Scale"] = Vector3.new(25, 48, 26)
            })
            _G.tween(v2.SwooshA, {
                0.45,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v2.SwooshA.CFrame * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(v2.SwooshA.Decal, {
                0.45,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(v2.Radius.Mesh, v4, {
                ["Scale"] = Vector3.new(70, 0, 70)
            })
            _G.tween(v2.Radius.Decal, v4, {
                ["Transparency"] = 1
            })
            local v6 = 1 - u1.Humanoid.BodyWidthScale.Value
            local v7 = 1 - u1.Humanoid.BodyDepthScale.Value
            local v8 = 1 - u1.Humanoid.BodyHeightScale.Value
            if v6 < v7 then
                v7 = v6 or v7
            end
            local u9 = script.DarkenEye:Clone()
            u9.root.Weld.Part1 = u1.Head
            local v10 = u9.fakehead
            local v11 = 1.25 - v7
            local v12 = 1.25 - v8
            local v13 = 1.25 - v7
            v10.Size = Vector3.new(v11, v12, v13)
            u9.eye1.Size = Vector3.new(0.2, 0, 0)
            u9.eye2.Size = u9.eye1.Size
            u9.eye1.Transparency = 1.5
            u9.eye2.Transparency = 1.5
            u9.Parent = workspace.Effects
            _G.customEmit(v2)
            delay(0.6, function() --[[ Line: 57 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u1
                --]]
                _G.tween(u9.eye1, {
                    0.6,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0.6, 0.25, 0.1),
                    ["Transparency"] = 0
                })
                _G.tween(u9.eye2, {
                    0.6,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0.6, 0.25, 0.1),
                    ["Transparency"] = 0
                })
                wait(0.4)
                _G.PlaySound(u1.HumanoidRootPart, script.PhoBuildup)
                u9.eye1.Beam.Enabled = true
                u9.eye2.Beam.Enabled = true
            end)
            _G.destroy(u9, 3)
        end
    end
}