 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            local u3 = script.MSwing:Clone()
            u3:PivotTo(p1.HumanoidRootPart.CFrame)
            _G.destroy(u3, 2)
            local v4 = p2 * 6.5
            local v5 = p2 * 2
            local v6 = 60 + v4
            local v7 = 60 + v4
            local v8 = 4 + p2
            local v9 = Vector3.new(v6, v7, v8)
            local v10 = 17 + v5
            local v11 = 72 + v4
            local v12 = 18 + v5
            local v13 = Vector3.new(v10, v11, v12)
            local v14 = 60 + v4
            local v15 = 0.5 + p2
            local v16 = 65 + v4
            local v17 = Vector3.new(v14, v15, v16)
            local v18 = 40 + v5
            local v19 = 3 + p2
            local v20 = 40 + v5
            local v21 = Vector3.new(v18, v19, v20)
            u3.root.Attachment.sm2.Speed = NumberRange.new(120 + v5, 150 + v4)
            local v22 = u3.root.Attachment2
            local v23 = v5 * 0.375
            v22.Position = Vector3.new(0, v23, 0)
            u3.root.Attachment2.Swirl.Size = NumberSequence.new(0, 5 + v4)
            u3.Parent = workspace.Effects
            _G.customEmit(u3.root.Attachment2.Swirl)
            script.MochiBuzzSpin.RollOffMaxDistance = 64 + v4 * 32
            _G.PlaySound(p1.HumanoidRootPart, script.MochiBuzzSpin)
            local v24 = {
                0.3,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            _G.tween(u3.SwirlA, {
                0.6,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u3.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
                ["Size"] = v9,
                ["Transparency"] = 1
            })
            _G.tween(u3.SwirlB, {
                0.4,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u3.SwirlB.CFrame * CFrame.Angles(0, 0, 3.13),
                ["Size"] = v9 + Vector3.new(5, 5, 1),
                ["Transparency"] = 1
            })
            _G.tween(u3.SliceA, {
                0.25,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v17,
                ["CFrame"] = u3.SliceA.CFrame * CFrame.Angles(0, 3.13, 0),
                ["Transparency"] = 1
            })
            _G.tween(u3.SliceB, {
                0.4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v17,
                ["CFrame"] = u3.SliceB.CFrame * CFrame.Angles(0, -3.13, 0),
                ["Transparency"] = 1
            })
            _G.tween(u3.Tornado, {
                0.3,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v21,
                ["Transparency"] = 1,
                ["CFrame"] = u3.Tornado.CFrame * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(u3.SwooshA.Mesh, v24, {
                ["Scale"] = v13
            })
            local v25 = _G.tween
            local v26 = u3.Radius.Mesh
            local v27 = {}
            local v28 = 60 + v4
            local v29 = 60 + v4
            v27.Scale = Vector3.new(v28, 0, v29)
            v25(v26, v24, v27)
            _G.tween(u3.Radius.Decal, v24, {
                ["Transparency"] = 1
            })
            local v30, _, _ = _G.getRayFloor(u3.PrimaryPart.CFrame, 20)
            if v30 then
                u3.root.Attachment.sm2.Color = ColorSequence.new(v30.Color)
                _G.customEmit(u3.root.Attachment.sm2)
            end
            task.spawn(function() --[[ Line: 53 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                local v31 = game:GetService("RunService").Heartbeat
                local v32 = u3.SwooshA.CFrame
                local v33 = 0
                while v33 < 0.75 do
                    local v34 = v33 * 1.33333333
                    local v35 = v34 * (2 - v34)
                    u3.SwooshA.CFrame = v32 * CFrame.Angles(0, v35 * 14, 0)
                    u3.SwooshA.Decal.Transparency = v35 + 0.1
                    v33 = v33 + v31:Wait()
                end
            end)
        end
    end
}