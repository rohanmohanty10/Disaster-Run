 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.HumanoidRootPart.Position) then
        local _ = { 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In }
        local v4 = p2.HumanoidRootPart.CFrame
        local v5 = script.NSlam:Clone()
        local v6 = Random.new():NextNumber(-0.5, 0.5)
        local v7 = Random.new():NextNumber(-0.25, 0.25)
        v5:PivotTo(v4 * CFrame.new(v6, v6, v6) * CFrame.Angles(v7, v7, v7))
        v5.Parent = workspace.Effects
        _G.tween(v5.SwirlA, {
            0.45,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.SwirlA.CFrame * CFrame.Angles(0, 0, 3.13),
            ["Size"] = Vector3.new(30, 30, 4),
            ["Transparency"] = 1
        })
        _G.tween(v5.Spike, {
            0.12,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.Spike.CFrame * CFrame.Angles(0, 3.13, 0.5),
            ["Size"] = Vector3.new(0.1, 40, 0.1),
            ["Transparency"] = 1
        })
        if p3 then
            v5.root.Attachment.FillStar:Emit(2)
            v5.root.Attachment.HollowStar:Emit(1)
            local v8 = v6 > 0 and script.DollHitA or script.DollHitB
            _G.PlaySound(p2.HumanoidRootPart, v8, {
                ["PlaybackSpeed"] = 1.2 + v7
            })
            _G.PlaySound(p2.HumanoidRootPart, script.ImpactDoll, {
                ["PlaybackSpeed"] = 1.1 + v7
            })
        else
            _G.PlaySound(p2.HumanoidRootPart, script.Hit, {
                ["PlaybackSpeed"] = 1.05 + v7
            })
            _G.PlaySound(p2.HumanoidRootPart, script.Swing, {
                ["PlaybackSpeed"] = 1.1 + v7
            })
        end
        v5.root.Attachment.Smoke:Emit(12)
        local v9 = v5.SwooshA
        _G.tween(v9, { 0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut }, {
            ["CFrame"] = v9.CFrame * CFrame.Angles(0, -3.13, 0)
        })
        _G.tween(v9.Decal, { 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In }, {
            ["Transparency"] = 1
        })
        _G.tween(v9.Mesh, { 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(6.75, 20, 7)
        })
        _G.destroy(v5, 0.75)
    end
end
return v1