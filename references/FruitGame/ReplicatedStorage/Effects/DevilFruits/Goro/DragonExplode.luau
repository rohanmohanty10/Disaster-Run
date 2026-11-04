 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
require(game.ReplicatedStorage.Modules.GLightning)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
local u4 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
function v1.start(_, p5, p6) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    if _G.checkRenderDistance(p5.Position) ~= false then
        for _ = 1, 10 do
            local v7 = Instance.new("Attachment")
            _G.destroy(v7, 1)
            v7.Parent = workspace.Terrain
            if typeof(p5) == "CFrame" then
                v7.WorldCFrame = p5
            end
            if typeof(p5) == "Vector3" then
                v7.Position = p5
            end
            local v8 = CFrame.Angles
            local v9 = math.random(-360, 360)
            local v10 = math.rad(v9)
            local v11 = math.random(-360, 360)
            local v12 = math.rad(v11)
            local v13 = math.random(-360, 360)
            local v14 = p5 * v8(v10, v12, (math.rad(v13))) * CFrame.new(0, 50, 0)
            local v15 = Instance.new("Attachment")
            _G.destroy(v15, 1)
            v15.Parent = workspace.Terrain
            if typeof(v14) == "CFrame" then
                v15.WorldCFrame = v14
            end
            if typeof(v14) == "Vector3" then
                v15.Position = v14
            end
            local _ = math.random(250, 750) / 1000
            local v16 = u2.new(v7, v15, 10)
            local v17 = math.random(5, 10)
            v16.CurveSize0 = 0
            v16.CurveSize1 = v17
            v16.PulseSpeed = 12
            v16.AnimationSpeed = math.random(15, 20)
            v16.PulseLength = 4
            v16.FadeLength = 0.8
            v16.Thickness = 2
            v16.Color = _G.filterColor(p6, Color3.fromRGB(89, 161, 255))
            v16.Frequency = math.random(2, 5)
            v16.MinThicknessMultiplier = 0.1
            v16.MaxThicknessMultiplier = 1
            v16.MinRadius = 0
            v16.MaxRadius = 12.5
            v16.ContractFrom = 0.5
            local v18 = u3.new(v16)
            v18.MaxDistance = 50
            v18.MinDistance = 25
            v18.MaxSparkCount = 2
            v18.MaxSpeed = 5
        end
        local v19 = script.Part2:Clone()
        v19.Parent = workspace.Effects
        v19.CFrame = p5
        _G.tween(v19.Attachment.PointLight, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 60,
            ["Brightness"] = 0
        })
        _G.destroy(v19, 0.5)
        local v20 = script.sphere:Clone()
        v20.Parent = workspace.Effects
        v20.CFrame = p5
        _G.tween(v20.Mesh, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(80, 80, 80)
        })
        _G.tween(v20, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v20, 0.25)
        u4.new(p5.Position, 2, 0, _G.filterColor(p6, Color3.fromRGB(9, 137, 207)), _G.filterColor(p6, Color3.fromRGB(9, 137, 207)))
    end
end
return v1