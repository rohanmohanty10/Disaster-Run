 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
require(game.ReplicatedStorage.Modules.GLightning)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
local u4 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
function v1.start(_, p5, p6, p7) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    if _G.checkRenderDistance(p5.Position) ~= false then
        for _ = 1, 10 do
            local v8 = Instance.new("Attachment")
            _G.destroy(v8, 1)
            v8.Parent = workspace.Terrain
            if typeof(p5) == "CFrame" then
                v8.WorldCFrame = p5
            end
            if typeof(p5) == "Vector3" then
                v8.Position = p5
            end
            local v9 = p5 * CFrame.new(math.random(-45, 45), math.random(12.5, 25) * 2, math.random(-45, 45))
            local v10 = Instance.new("Attachment")
            _G.destroy(v10, 1)
            v10.Parent = workspace.Terrain
            if typeof(v9) == "CFrame" then
                v10.WorldCFrame = v9
            end
            if typeof(v9) == "Vector3" then
                v10.Position = v9
            end
            local _ = math.random(250, 750) / 1000
            local v11 = u2.new(v8, v10, 10)
            local v12 = math.random(5, 10)
            v11.CurveSize0 = 0
            v11.CurveSize1 = v12
            v11.PulseSpeed = math.random(7, 12)
            v11.AnimationSpeed = math.random(15, 20)
            v11.PulseLength = math.random(1, 2)
            v11.FadeLength = 0.1
            v11.Thickness = 2
            v11.Color = _G.filterColor(p7, Color3.fromRGB(89, 161, 255))
            v11.Frequency = 5
            v11.MinThicknessMultiplier = 0.1
            v11.MaxThicknessMultiplier = 1
            v11.MinRadius = 0
            v11.MaxRadius = 12.5
            local v13 = u3.new(v11)
            v13.MaxDistance = 25
            v13.MinDistance = 12.5
            v13.MaxSparkCount = 2
            v13.MaxSpeed = 2
        end
        local v14 = script.Part2:Clone()
        v14.Parent = workspace.Effects
        v14.CFrame = p5
        _G.tween(v14.Attachment.PointLight, {
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
        _G.destroy(v14, 0.5)
        local v15 = script.sphere:Clone()
        v15.Parent = workspace.Effects
        v15.CFrame = p5
        _G.tween(v15.Mesh, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(65, 65, 65)
        })
        _G.tween(v15, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v15, 0.25)
        _G.PlayEffect("GroundRocks", nil, p5, 20, 4, 25, 5)
        u4.new(p5.Position, 0.8, 0, _G.filterColor(p7, Color3.fromRGB(9, 137, 207)), _G.filterColor(p7, Color3.fromRGB(9, 137, 207)))
        if p6 then
            local v16 = script.dust:Clone()
            v16.CFrame = p5
            v16.Attachment.sm2.Color = ColorSequence.new(p6.Color)
            v16.Attachment.Rocks.Color = ColorSequence.new(p6.Color)
            v16.Parent = workspace.Effects
            _G.customEmit(v16)
            _G.destroy(v16, 3)
            local v17 = p5 * CFrame.Angles(3.141592653589793, 0, 0)
            _G.PlayEffect("Shockwave2", nil, v17, v17 * CFrame.new(0, -4, 0), BrickColor.new("White"), Vector3.new(65, 2, 65), Vector3.new(32.5, 2, 32.5), 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        end
    end
end
return v1