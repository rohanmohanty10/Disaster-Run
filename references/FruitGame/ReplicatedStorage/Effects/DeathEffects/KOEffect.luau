 

local v1 = {}
local u2 = game:GetService("TweenService")
require(script.Parent.BodyTransparency)
local u3 = _G.customEmit
function v1.start(_, p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = Random.new()
    local v6 = CFrame.new(p4:GetPivot().Position)
    local v7 = script.Start:Clone()
    local v8 = workspace.Effects
    v7.CFrame = v6
    v7.Parent = v8
    u3(v7)
    _G.PlaySound(v7, script.KO)
    p4.PrimaryPart.Anchored = true
    task.wait(0.5)
    local v9 = script.SmashKO:Clone()
    v9:PivotTo(v6 * CFrame.new(0, -0.6, 0) * CFrame.Angles(0, -1.5707963267948966, 0))
    v9.Parent = workspace.Effects
    local v10 = v9.Lower.b.Position
    local v11 = v9.Lower.a.Position
    v9.Lower.a.Position = v10
    u2:Create(v9.Lower.a, TweenInfo.new(0.125), {
        ["Position"] = v11
    }):Play()
    for _, v12 in v9.Lower:GetChildren() do
        if v12:IsA("Beam") then
            local v13 = v5:NextNumber(0.9, 1.1) * 0.75
            u2:Create(v12, TweenInfo.new(v13, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }):Play()
        end
    end
    u3(v9.Beam)
    _G.destroy(v9, 5)
end
return v1