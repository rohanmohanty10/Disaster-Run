 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            _G.PlaySound(p1.HumanoidRootPart, script.MochiBuzzSpin)
            _G.PlaySound(p1.HumanoidRootPart, script.WooshA)
            local v2 = script.MRiseA:Clone()
            v2:PivotTo(p1.HumanoidRootPart.CFrame)
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
                0.45,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            _G.tween(v2.SwirlA, {
                1.35,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v2.SwirlA.CFrame * CFrame.Angles(0, 0, 3.13),
                ["Size"] = Vector3.new(70, 70, 11),
                ["Transparency"] = 1
            })
            _G.tween(v2.SwirlLinger, {
                1,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(48, 25, 48),
                ["Transparency"] = 1,
                ["CFrame"] = v2.SwirlLinger.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(v2.Tornado, v5, {
                ["Size"] = Vector3.new(60, 8, 60),
                ["Transparency"] = 1,
                ["CFrame"] = v2.Tornado.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(v2.SwooshA.Mesh, v4, {
                ["Scale"] = Vector3.new(20, 70, 21)
            })
            _G.tween(v2.SwooshA, {
                0.4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v2.SwooshA.CFrame * CFrame.Angles(0, 3.13, 0)
            })
            _G.tween(v2.SwooshA.Decal, {
                0.4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.customEmit(v2)
        end
    end
}