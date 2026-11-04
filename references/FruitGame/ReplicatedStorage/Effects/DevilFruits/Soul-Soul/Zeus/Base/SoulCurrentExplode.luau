 

game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local v1 = RaycastParams.new()
v1.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v1.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 13 ]]
        local v3 = CFrame.new(p2)
        local v4, v5, v6 = _G.getRayFloor(CFrame.new(p2), 14)
        local v7 = script.Lightning_Explode:Clone()
        v7.CFrame = v3
        if v4 then
            _G.recolorParticles(v7, v4.Color)
            v7.Floor.WorldCFrame = CFrame.new(v5, v5 + v6) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v5 + Vector3.new(0, 2, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 15,
                ["Direction"] = -v6 * 45,
                ["Angle"] = -0.6108652381980153
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 4,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                ["Position"] = v5,
                ["Direction"] = Vector3.new(0, 45, 0),
                ["RaycastDirection"] = -v6 * 15,
                ["Size"] = Vector3.new(0.6, 0.6, 0.6),
                ["TrailEnabled"] = true
            })
        else
            v7.Floor:Destroy()
        end
        v7.Parent = workspace.Effects
        _G.customEmit(v7)
        _G.destroy(v7, 5)
        _G.shakenear(v3.Position, 125, 65, 75, -1)
        _G.tween(v7.PointLight, {
            0.35,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0,
            ["Range"] = 40
        })
    end
}