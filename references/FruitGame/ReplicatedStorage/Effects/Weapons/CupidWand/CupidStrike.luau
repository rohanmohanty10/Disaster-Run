 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
require(game.ReplicatedStorage.Modules.GLightning)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
function v1.start(_, p4, p5, p6) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(p5.Position) ~= false then
        local v7 = Instance.new("Attachment")
        v7.Parent = workspace.Terrain
        _G.destroy(v7, 5)
        v7.WorldCFrame = p4
        local v8 = Instance.new("Attachment")
        v8.Parent = workspace.Terrain
        _G.destroy(v8, 5)
        v8.WorldCFrame = p5
        local v9 = u2.new(v7, v8, 20)
        v9.CurveSize0 = 0
        v9.CurveSize1 = 0
        v9.PulseSpeed = 20
        v9.AnimationSpeed = 5
        v9.PulseLength = 4
        v9.FadeLength = 0.3
        v9.Thickness = 1
        v9.Color = Color3.fromRGB(255, 147, 147)
        v9.MinTransparency = 0
        v9.Frequency = 1
        v9.MinThicknessMultiplier = 0.1
        v9.MaxThicknessMultiplier = 1
        v9.MinRadius = 0
        v9.MaxRadius = 3
        v9.Velocity = (v8.WorldPosition - v7.WorldPosition).Unit * 100
        local v10 = u3.new(v9)
        v10.MaxDistance = 20
        v10.MinDistance = 4
        v10.MaxSparkCount = 6
        v10.MaxSpeed = 10
        local v11 = script.hit:Clone()
        v11.CFrame = p5
        if p6 and typeof(p6) == "Color3" then
            v11.Attachment.Smoke.Color = ColorSequence.new(p6)
            v11.Attachment.Rocks.Color = ColorSequence.new(p6)
        end
        v11.Parent = workspace.Effects
        _G.customEmit(v11)
        _G.destroy(v11, 3)
        _G.tween(v11.Attachment.PointLight, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 35,
            ["Brightness"] = 0
        })
        _G.PlayEffect("GroundRocks2", nil, CFrame.new(p5.Position + Vector3.new(0, 3, 0)), 15, 5, 1, 0, 2)
        _G.PlaySound(p5, script["c" .. math.random(1, 2)])
    end
end
return v1