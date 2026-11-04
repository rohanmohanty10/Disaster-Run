 

game:GetService("TweenService")
game:GetService("Debris")
local u1 = Random.new()
require(script.Parent.Shared)
local u2 = script.VFX
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v4 = p3.Result
        local v5 = p3.Position
        local v6 = v4.Color
        local v7 = u2.Explosion:Clone()
        v7.CFrame = v4 and CFrame.new(v4.Position, v4.Position + v4.Normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.01, 0) or CFrame.new(v5)
        v7.CFrame = v7.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
        if v6 then
            _G.recolorParticles(v7, v6)
        end
        v7.Parent = workspace.Effects
        _G.tween(v7.PointLight, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 60,
            ["Brightness"] = 0
        })
        _G.customEmit(v7)
        _G.destroy(v7, 5)
        local v8 = v7.Position
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 20,
            ["Position"] = v8 + Vector3.new(0, 2, 0),
            ["DistanceRandomness"] = Vector2.new(0.3, 1),
            ["Duration"] = 4,
            ["TweenDuration"] = 1,
            ["Radius"] = 20,
            ["Direction"] = -v4.Normal * 45,
            ["Angle"] = -0.7853981633974483
        })
        local v9 = u1:NextNumber(1.5, 2.4)
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 10,
            ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * v9,
            ["Position"] = v8,
            ["Direction"] = Vector3.new(0, 15, 0),
            ["RaycastDirection"] = -v4.Normal * 35,
            ["Size"] = Vector3.new(0.4, 0.4, 0.4) * v9,
            ["TrailEnabled"] = true
        })
        _G.PlaySound(v7, script.SoulPrometheusDrillBlastExplode)
        _G.shakenear(v7.Position, 175, 150, 75, -1)
    end
}