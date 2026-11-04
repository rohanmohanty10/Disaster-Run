 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
function v1.start(_, p4, p5, p6) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(p5.Position) == false then
        return
    elseif p6 == nil then
        return
    elseif p6:FindFirstChild("UpperTorso") ~= nil then
        local v7 = Instance.new("Attachment")
        _G.destroy(v7, 1)
        v7.Parent = workspace.Terrain
        v7.WorldCFrame = p4
        local v8 = p6.UpperTorso
        local v9 = Instance.new("Attachment")
        _G.destroy(v9, 1)
        v9.Parent = workspace.Terrain
        if v8 then
            v9.Parent = v8
        else
            v9.WorldCFrame = p5
        end
        local v10 = game.Players:GetPlayerFromCharacter(p6)
        local v11 = script.PointLight:Clone()
        v11.Parent = v9
        _G.tween(v11, {
            0.2,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 15,
            ["Brightness"] = 0
        })
        _G.destroy(v11, 0.2)
        local v12 = u2.new(v7, v9, 25)
        v12.CurveSize0 = 0
        v12.CurveSize1 = 0
        v12.PulseSpeed = 10
        v12.AnimationSpeed = 5
        v12.PulseLength = 2
        v12.FadeLength = 0.8
        v12.Thickness = 1
        v12.Color = _G.filterColor(v10, Color3.fromRGB(89, 161, 255))
        v12.MinTransparency = 0
        v12.Frequency = 0.5
        v12.MinThicknessMultiplier = 0.75
        v12.MaxThicknessMultiplier = 1
        v12.MinRadius = 0
        v12.MaxRadius = 5
        v12.Velocity = (v9.WorldPosition - v7.WorldPosition).Unit * 100
        local v13 = u3.new(v12)
        v13.MaxDistance = 5
        v13.MinDistance = 4
        v13.MaxSparkCount = 10
        v13.MaxSpeed = 10
        for _ = 1, 3 do
            local v14 = p5 * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3))
            local v15 = Instance.new("Attachment")
            _G.destroy(v15, 1)
            v15.Parent = workspace.Terrain
            v15.WorldCFrame = v14
            local v16 = p6.UpperTorso
            local v17 = Instance.new("Attachment")
            _G.destroy(v17, 1)
            v17.Parent = workspace.Terrain
            if v16 then
                v17.Parent = v16
            else
                v17.WorldCFrame = p5
            end
            local v18 = u2.new(v15, v17, 10)
            v18.CurveSize0 = 0
            v18.CurveSize1 = 0
            v18.PulseSpeed = 10
            v18.AnimationSpeed = 5
            v18.PulseLength = 2
            v18.FadeLength = 0.8
            v18.Thickness = 1
            v18.Color = _G.filterColor(v10, Color3.fromRGB(89, 161, 255))
            v18.MinTransparency = 0
            v18.Frequency = 0.5
            v18.MinThicknessMultiplier = 0.75
            v18.MaxThicknessMultiplier = 1
            v18.MinRadius = 0
            v18.MaxRadius = 5
            v18.Velocity = (v17.WorldPosition - v15.WorldPosition).Unit * 100
            local v19 = u3.new(v18)
            v19.MaxDistance = 6
            v19.MinDistance = 4
            v19.MaxSparkCount = 3
            v19.MaxSpeed = 10
        end
    end
end
return v1