 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.Torso.Position) then
        local v4 = p2.Torso.CFrame
        local v5 = script.MeteorTravel:Clone()
        v5:PivotTo(v4)
        v5.Ring.Size = Vector3.new(1.5, 1, 1.5) * p3
        v5.Flames.Size = Vector3.new(1.3, 0.75, 1.3) * p3
        v5.Swirl.Size = Vector3.new(2, 0.8, 2) * p3
        v5.Ring.CFrame = v5.root.CFrame * CFrame.new(0, p3 * 2, 0)
        v5.Swirl.CFrame = v5.root.CFrame * CFrame.new(0, p3 * 2, 0) * CFrame.Angles(3.14, 0, 0)
        v5.Flames.CFrame = v5.root.CFrame * CFrame.new(0, p3 * 2, 0) * CFrame.Angles(0, 0, 1.51)
        v5.Parent = workspace.Effects
        _G.tween(v5.Ring, {
            0.4,
            "Quart",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(3.8, 0.1, 3.8) * p3,
            ["Transparency"] = 1
        })
        _G.tween(v5.Flames, {
            0.25,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.Flames.CFrame * CFrame.new(p3, 0, 0),
            ["Size"] = Vector3.new(4.8, 3.9, 4.8) * p3,
            ["Transparency"] = 1
        })
        _G.tween(v5.Swirl, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v5.Swirl.CFrame * CFrame.new(0, -p3, 0) * CFrame.Angles(0, -1.51, 0),
            ["Size"] = v5.Swirl.Size * 5,
            ["Transparency"] = 1
        })
        _G.destroy(v5, 0.4)
    end
end
return v1