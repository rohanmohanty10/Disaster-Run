 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.HumanoidRootPart.Position) then
        local v4 = p2.HumanoidRootPart.CFrame
        _G.PlaySound(p2.HumanoidRootPart, script.Impact)
        local v5 = script.GroundStrike:Clone()
        v5:PivotTo(v4)
        v5.Spike.Color = p3
        v5.Particles.Sparkles.Color = ColorSequence.new(p3)
        _G.tween(v5.SwirlA, {
            1.4,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
            ["Size"] = Vector3.new(25, 25, 4),
            ["Transparency"] = 1
        })
        _G.tween(v5.SwirlB, {
            0.9,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.SwirlB.CFrame * CFrame.Angles(0, 0, -3.13),
            ["Size"] = Vector3.new(26, 26, 6),
            ["Transparency"] = 1
        })
        _G.tween(v5.Spike, {
            0.15,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.Spike.CFrame,
            ["Size"] = Vector3.new(1, 40, 6),
            ["Transparency"] = 1
        })
        v5.Parent = workspace.Effects
        local _ = v5.Particles
        _G.customEmit(v5)
        _G.destroy(v5, 1.3)
    end
end
return v1