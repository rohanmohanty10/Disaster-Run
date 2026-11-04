 

game:GetService("Players")
game:GetService("RunService")
local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
local function u9(p4) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v5 = p4:GetExtentsSize() / 2
    local _ = p4:GetPivot() * CFrame.new(v5.X * u3:NextNumber(-1, 1), v5.Y * u3:NextNumber(-1, 1), v5.Z * u3:NextNumber(-1, 1))
    local v6 = _G.PlayEffect
    local v7 = {
        ["PartCount"] = 1,
        ["RandomVelocityMagnitude"] = Vector2.new(-50, 50),
        ["Position"] = p4:GetPivot().Position,
        ["Direction"] = Vector3.new(0, -50, 0),
        ["RaycastDirection"] = Vector3.new(0, -100, 0)
    }
    local v8 = {
        ["Instance"] = {
            ["Material"] = p4.IceSpike.Material,
            ["Color"] = p4.IceSpike.Color
        }
    }
    v7.Hit = v8
    v7.Size = Vector3.new(1, 2, 1)
    v7.TrailEnabled = true
    v6("RockDebris", nil, v7)
end
function v1.start(_, p10) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u9
    --]]
    local v11 = p10.Ice
    local v12 = p10.ShakeDuration
    local v13 = v11:GetPivot()
    for _ = 1, 99 do
        u2:Create(v11.HumanoidRootPart, TweenInfo.new(v12 / 100 * 0.5, Enum.EasingStyle.Linear), {
            ["CFrame"] = v13 * CFrame.new(u3:NextNumber(-2.5, 2.5), u3:NextNumber(-2.5, 2.5), u3:NextNumber(-2.5, 2.5))
        }):Play()
        task.spawn(u9, v11)
        task.wait(v12 / 100)
    end
end
return v1