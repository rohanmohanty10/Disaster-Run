 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.PrimaryPart.Position) then
        local v3 = p2.PrimaryPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.51, 0, 0)
        local v4
        if p2.Name == "BatDoll" then
            v4 = script.DSlam:Clone()
        else
            v4 = script.NSlam:Clone()
        end
        v4:PivotTo(v3)
        v4.Parent = workspace.Effects
        _G.tween(v4.SwirlA, {
            0.5,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v4.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
            ["Size"] = Vector3.new(50, 50, 4),
            ["Transparency"] = 1
        })
        _G.tween(v4.SwirlB, {
            0.3,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v4.SwirlB.CFrame * CFrame.Angles(0, 0, -3.13),
            ["Size"] = Vector3.new(55, 55, 5),
            ["Transparency"] = 1
        })
        _G.tween(v4.Spike, {
            0.15,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v4.Spike.CFrame * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(8, 64, 8),
            ["Transparency"] = 1
        })
        if p2.Name == "BatDoll" then
            v4.root.Attachment.Core:Emit(1)
            v4.root.Attachment.FillStar:Emit(1)
            v4.root.Attachment.HollowStar:Emit(3)
            _G.PlaySound(p2.PrimaryPart, script.Slam, {
                ["PlaybackSpeed"] = 5,
                ["Volume"] = 0.35
            })
        else
            _G.PlaySound(p2.PrimaryPart, script.SoundNoob, {
                ["PlaybackSpeed"] = Random.new():NextNumber(1, 1.15)
            })
            _G.PlaySound(p2.PrimaryPart, script.Slam)
        end
        v4.root.Attachment.Smoke:Emit(3)
        _G.destroy(v4, 0.6)
    end
end
return v1