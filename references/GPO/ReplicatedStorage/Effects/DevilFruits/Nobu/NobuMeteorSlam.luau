 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.PrimaryPart.Position) then
        local v4 = CFrame.new((p2.PrimaryPart.CFrame * CFrame.new(0, p3 * 0.46, 0)).Position)
        local v5 = script.MeteorImpact:Clone()
        v5:PivotTo(v4)
        v5.Parent = workspace.Effects
        _G.tween(v5.SwirlA, {
            2.5,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
            ["Size"] = Vector3.new(16, 16, 0.65) * p3,
            ["Transparency"] = 1
        })
        _G.tween(v5.SwirlB, {
            2,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.SwirlB.CFrame * CFrame.Angles(0, 0, 3.13),
            ["Size"] = Vector3.new(15.2, 15.2, 1.4) * p3,
            ["Transparency"] = 1
        })
        _G.tween(v5.Spike, {
            0.25,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(9, 32, 9) * p3,
            ["Transparency"] = 1
        })
        _G.tween(v5.Multi, {
            1.2,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.Multi.CFrame * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(8.7, 6.5, 8.7) * p3,
            ["Transparency"] = 1
        })
        _G.tween(v5.Ring, {
            0.9,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.Ring.CFrame * CFrame.new(0, p3, 0),
            ["Size"] = Vector3.new(15.7, 0.2, 15.7) * p3,
            ["Transparency"] = 1
        })
        _G.PlaySound(p2.PrimaryPart, script.Slam, {
            ["PlaybackSpeed"] = 0.75 + (1 - p3 / 75) * 0.6
        })
        _G.destroy(v5, 1.8)
    end
end
return v1