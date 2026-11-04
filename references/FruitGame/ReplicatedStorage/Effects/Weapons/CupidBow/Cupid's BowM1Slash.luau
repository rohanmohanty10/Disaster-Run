 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
Random.new()
function v1.start(_, _, p2, _, _) --[[ Line: 6 ]]
    local v3 = script.Fx:Clone()
    v3.CFrame = p2.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(3.141592653589793, 0, 0)
    v3.Parent = workspace.Effects
    _G.destroy(v3, 3)
    _G.customEmit(v3)
    local v4 = script.Arrow:Clone()
    v4.CFrame = p2.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(1.5707963267948966, 0, 0)
    v4.Parent = workspace.Effects
    _G.tween(v4, {
        0.2,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v4.CFrame * CFrame.new(0, -7, 0)
    })
    _G.destroy(v4, 0.2)
end
return v1