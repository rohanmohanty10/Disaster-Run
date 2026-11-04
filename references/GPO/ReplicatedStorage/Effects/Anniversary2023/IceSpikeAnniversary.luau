 

game:GetService("Players")
game:GetService("RunService")
local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
function v1.start(_, p4, _, p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v6 = script.IceSpike:Clone()
    v6.CFrame = CFrame.new(p4.Position) * CFrame.Angles(3.141592653589793, 0, 0)
    local v7 = u3:NextNumber(0.5, 1)
    local v8 = v6.Size
    local v9 = u3:NextNumber(0.75, 1.25)
    v6.Size = v8 * Vector3.new(v7, v9, v7)
    v6.CanCollide = false
    v6.Parent = workspace.Effects
    u2:Create(v6, TweenInfo.new(p5, Enum.EasingStyle.Linear), {
        ["Position"] = p4.TargetPosition
    }):Play()
    task.wait(p5)
    _G.PlayEffect("GroundRocks4", nil, {
        ["Segments"] = 25,
        ["Position"] = p4.TargetPosition + Vector3.new(0, 5, 0),
        ["DistanceRandomness"] = Vector2.new(0.5, 1),
        ["Duration"] = 3,
        ["TweenDuration"] = 1,
        ["Radius"] = 25,
        ["Direction"] = Vector3.new(0, -35, 0)
    })
    local v10 = script.Explosion:Clone()
    v10.CFrame = CFrame.new(p4.TargetPosition)
    _G.scaleParticle(v10, 0.5, true)
    v10.Parent = workspace.Effects
    _G.PlaySound(v10, script["Audio/IcicleSmash" .. math.random(1, 3)])
    _G.customEmit(v10)
    v6:Destroy()
    _G.destroy(v10, 9)
end
return v1