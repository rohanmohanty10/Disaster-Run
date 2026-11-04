 

local v1 = {}
game:GetService("TweenService")
function PlayAnim(p2, p3, p4)
    local v5 = (p2:FindFirstChild("Humanoid") or p2:FindFirstChild("AnimationController")).Animator:LoadAnimation(script[p3])
    v5:Play(0, 1, 1)
    if p4 then
        v5:AdjustSpeed(p4)
    end
    return v5
end
function v1.start(_, p6, p7, p8) --[[ Line: 34 ]]
    local v9 = p6.PrimaryPart.CFrame
    Random.new()
    local v10 = script.Chargeup:Clone()
    v10.CFrame = v9
    v10.Center.WorldCFrame = p6.UpperTorso.CFrame
    local v11 = v10.Floor
    local v12 = -(p6.Humanoid.HipHeight + p6.PrimaryPart.Size.Y / 2)
    v11.Position = Vector3.new(0, v12, 0)
    v10.Parent = workspace.Effects
    _G.customEmit(v10)
    PlayAnim(p6, "Activate", p8)
    _G.PlaySound(p6.PrimaryPart, script.DragonAuraStart).Parent = p6.PrimaryPart
    task.wait(p7 - workspace:GetServerTimeNow())
    local v13 = script.Activation:Clone()
    v13.CFrame = v9
    local v14, v15, v16 = _G.getRayFloor(CFrame.new(v9.Position), 7)
    if v14 == nil then
        v13.GroundAttachment:Destroy()
    else
        _G.recolorParticles(v13, v14.Color)
        local _ = v9.Position
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 12,
            ["Position"] = v15 + Vector3.new(0, 2, 0),
            ["DistanceRandomness"] = Vector2.new(0.3, 1),
            ["Duration"] = 4,
            ["TweenDuration"] = 1,
            ["Radius"] = 7,
            ["Direction"] = -v16 * 15,
            ["Angle"] = -0.7853981633974483
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 5,
            ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 1,
            ["Position"] = v15,
            ["Direction"] = Vector3.new(0, 25, 0),
            ["RaycastDirection"] = -v16 * 15,
            ["Size"] = Vector3.new(0.6, 0.6, 0.6),
            ["TrailEnabled"] = true
        })
    end
    v13.Parent = workspace.Effects
    _G.customEmit(v13)
    _G.destroy(v10, 2.5)
    _G.destroy(v13, 2.5)
end
return v1