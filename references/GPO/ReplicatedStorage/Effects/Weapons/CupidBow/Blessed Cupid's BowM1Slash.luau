 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
Random.new()
local u3 = require(v2.Modules.Client.WeaponVFXRecolor)
function v1.start(_, _, p4, _, _) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v5 = script.Fx:Clone()
    u3.apply(v5, p4.Parent)
    v5.CFrame = p4.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(3.141592653589793, 0, 0)
    v5.Parent = workspace.Effects
    _G.destroy(v5, 3)
    _G.customEmit(v5)
    local v6 = script.Arrow:Clone()
    u3.apply(v6, p4.Parent)
    v6.CFrame = p4.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(1.5707963267948966, 0, 0)
    v6.Parent = workspace.Effects
    _G.tween(v6, {
        0.2,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v6.CFrame * CFrame.new(0, -7, 0)
    })
    _G.destroy(v6, 0.2)
end
return v1