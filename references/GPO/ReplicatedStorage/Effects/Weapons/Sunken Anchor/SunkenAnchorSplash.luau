 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        local v3, v4, v5 = _G.getRayFloor(p2, 8)
        if v3 ~= nil then
            local v6 = script:FindFirstChild(p1):Clone()
            local v7 = v4 + Vector3.new(0, 0.1, 0)
            local v8 = CFrame.new(v7, v7 + v5)
            local v9 = CFrame.Angles
            local v10 = math.random(0, 360)
            v6.CFrame = v8 * v9(-1.5725416560468908, math.rad(v10), 0)
            _G.recolorParticles(v6, v3.Color)
            v6.Parent = workspace.Effects
            if p1 == "travel" then
                _G.scaleParticle(v6, math.random(90, 120) / 100, true)
                _G.shakenear(v6.CFrame.Position, 30, 30, 35, -1)
                _G.PlaySound(v6, script["Audio/AnchorWaterBurstsGroundBurst"], {
                    ["RandomPitch"] = true
                })
            else
                _G.shakenear(v6.CFrame.Position, 80, 75, 75, -1)
                _G.PlaySound(v6, script["Audio/AnchorWaterBurstsFinalExplosion"], {
                    ["RandomPitch"] = true
                })
            end
            if p1 == "explode" then
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 24,
                    ["Position"] = v7 + Vector3.new(0, 1, 0),
                    ["DistanceRandomness"] = Vector2.new(0.25, 1),
                    ["Duration"] = 4,
                    ["TweenDuration"] = 2,
                    ["Radius"] = 12,
                    ["Direction"] = Vector3.new(0, -10, 0),
                    ["Angle"] = -0.5235987755982988
                })
            end
            _G.customEmit(v6)
            _G.destroy(v6, 5)
        end
    end
}