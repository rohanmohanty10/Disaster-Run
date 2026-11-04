 

return {
    ["start"] = function(_, p1, p2, p3, p4) --[[ Name: start, Line 3 ]]
        local v5 = p1.StartOrg
        local v6 = p1.duration
        local v7 = script.Bullet:Clone()
        v7.CFrame = CFrame.new(v5.Position, p2.Position)
        v7.Parent = workspace.Effects
        _G.tween(v7, {
            v6,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v7.CFrame * CFrame.new(0, 0, -p1.distance)
        })
        _G.destroy(v7, v6 + 1)
        task.wait(v6)
        v7.Transparency = 1
        _G.PlaySound(p2, script["LargeCannonBoom" .. math.random(1, 3)], {
            ["RandomPitch"] = true
        })
        _G.shakenear(p2.Position, 125, 100, 100, -1)
        local v8 = script.Explosion:Clone()
        if p4 == true or p3 == nil then
            v8.Attachment.Ray:Destroy()
            v8.Attachment.Rocks:Destroy()
            v8.Attachment.Realistic:Destroy()
        end
        if p3 ~= nil then
            _G.recolorParticles(v8, p3)
        end
        v8.CFrame = p2
        v8.Parent = workspace.Effects
        _G.customEmit(v8)
        _G.destroy(v8, 5)
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 15,
            ["Position"] = p2.Position + Vector3.new(0, 2, 0),
            ["DistanceRandomness"] = Vector2.new(0.25, 1),
            ["Duration"] = 4,
            ["TweenDuration"] = 1,
            ["Radius"] = 25,
            ["Direction"] = p2.UpVector * -15,
            ["Angle"] = -0.4363323129985824
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 6,
            ["RandomVelocityMagnitude"] = Vector2.new(-80, 80),
            ["Position"] = p2.Position + Vector3.new(0, 2, 0),
            ["Direction"] = p2.UpVector * math.random(35, 45),
            ["RaycastDirection"] = p2.UpVector * -15,
            ["Size"] = Vector3.new(0.875, 1.5, 0.875),
            ["TrailEnabled"] = true
        })
        _G.tween(v8.PointLight, {
            0.35,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 50,
            ["Brightness"] = 0
        })
    end
}