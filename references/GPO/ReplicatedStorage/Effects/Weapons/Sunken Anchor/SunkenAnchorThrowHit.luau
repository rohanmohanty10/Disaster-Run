 

local v1 = {}
game:GetService("Players")
function v1.start(_, p2, p3, p4) --[[ Line: 4 ]]
    task.wait(p4)
    local v5 = script.hitWall:Clone()
    v5.CFrame = p2 * CFrame.Angles(0, -1.5707963267948966, 0)
    _G.recolorParticles(v5, p3)
    v5.Parent = workspace.Effects
    _G.customEmit(v5)
    _G.destroy(v5, 5)
    _G.PlaySound(p2, script["Audio/AnchorThrowHitSurface"], {
        ["RandomPitch"] = true
    })
    _G.PlayEffect("GroundRocks4", nil, {
        ["Segments"] = 14,
        ["Position"] = (p2 + p2.LookVector * 3).Position,
        ["DistanceRandomness"] = Vector2.new(0.5, 1),
        ["Duration"] = 3,
        ["TweenDuration"] = 1,
        ["Radius"] = 6,
        ["Direction"] = -p2.LookVector * 15
    })
    _G.PlayEffect("RockDebris", nil, {
        ["PartCount"] = 4,
        ["RandomVelocityMagnitude"] = Vector2.new(-25, 25),
        ["Position"] = (p2 + p2.LookVector * 3).Position,
        ["Direction"] = p2.LookVector * 45,
        ["RaycastDirection"] = -p2.LookVector * 15,
        ["Size"] = Vector3.new(0.5, 0.5, 0.5),
        ["TrailEnabled"] = true
    })
end
return v1