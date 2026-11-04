 

local v1 = {}
require(script.Parent["Divine Retribution"].Release.InitiateVFX.CreateGroundRock)
function v1.start(_, p2, p3) --[[ Line: 4 ]]
    if _G.checkRenderDistance(p2.Position) ~= false then
        local v4 = script.FloorStomp:Clone()
        v4.CFrame = p2
        v4.Rock.Color = ColorSequence.new(p3)
        v4.SmokePar.Color = ColorSequence.new(p3)
        v4.Smoke.Color = ColorSequence.new(p3)
        v4.SmokePar2.Color = ColorSequence.new(p3)
        v4.Parent = workspace.Effects
        _G.customEmit(v4)
        _G.tween(v4.Decal, {
            2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.PlaySound(v4, script["BuddhaFullFormStep" .. math.random(1, 3)], {
            ["Pitch"] = math.random(90, 110) / 100
        })
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 25,
            ["Position"] = v4.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 1,
            ["TweenDuration"] = 1,
            ["Radius"] = 25,
            ["Direction"] = Vector3.new(0, -35, 0)
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 8,
            ["RandomVelocityMagnitude"] = Vector2.new(-75, 75) / 2,
            ["Position"] = v4.Position + Vector3.new(0, 5, 0),
            ["Direction"] = Vector3.new(0, 125, 0),
            ["RaycastDirection"] = Vector3.new(0, -30, 0),
            ["Size"] = Vector3.new(1.75, 3, 1.75),
            ["TrailEnabled"] = true
        })
        _G.destroy(v4, 3)
    end
end
return v1