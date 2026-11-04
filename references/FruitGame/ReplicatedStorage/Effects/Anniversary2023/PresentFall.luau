 

game:GetService("Players")
local u1 = game:GetService("RunService")
local v2 = {}
game:GetService("TweenService")
Random.new()
function v2.start(_, p3) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = p3.Model
    local v5 = p3.StartCFrame
    local v6 = p3.EndCFrame
    local v7 = p3.Angle
    _G.PlaySound(v4.PrimaryPart, script["Audio/PresentFall"]).Parent = v4.PrimaryPart
    local v8 = 0
    repeat
        local v9 = v8 + u1.Heartbeat:Wait() / p3.Duration
        v8 = math.min(v9, 1)
        local v10 = v7:Lerp(Vector3.new(), v8)
        v4:PivotTo(v5:Lerp(v6, v8) * CFrame.Angles(v10.X, v10.Y, v10.Z))
    until v8 == 1
    v4:PivotTo(v6)
    _G.PlayEffect("PresentLandEffect", nil, {
        ["CFrame"] = v6 * CFrame.new(0, -v4.PrimaryPart.Size.Y / 2 + 0.5, 0),
        ["Scale"] = v4:GetScale()
    })
end
return v2