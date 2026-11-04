 

local v1 = {}
local u2 = require(script.LightningBolt)
function v1.start(_, p3, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p4.Position) then
        local v5 = script.LightningParticles:Clone()
        v5.CFrame = p3.HumanoidRootPart.CFrame
        v5.Parent = workspace.Effects
        for _, v6 in v5:GetChildren() do
            v6:Emit(2)
        end
        _G.destroy(v5, 4)
        local v7 = {}
        local v8 = p4.Position + Vector3.new(0, 1, 0)
        local v9 = p4.upVector
        v7.WorldPosition = v8
        v7.WorldAxis = v9
        for _ = 1, 2 do
            for v10 = 0, 6.2, 1.25 do
                local v11 = {}
                local v12 = p4 * CFrame.Angles(0, v10, 0) * CFrame.new(v10 * 16 + 10, v10 * 8 + 85, 0)
                local v13 = v12.Position
                local v14 = v12.upVector
                v11.WorldPosition = v13
                v11.WorldAxis = v14
                local v15 = u2.new(v7, v11, 5)
                v15.MinRadius = 4.7
                v15.MaxRadius = 12.1
                v15.Frequency = 14
                v15.AnimationSpeed = 6
                v15.Thickness = 4
                v15.MinThicknessMultiplier = 0.25
                v15.MaxThicknessMultiplier = 1
                v15.ContractFrom = 0.52
                v15.PulseSpeed = Random.new():NextNumber(7.5, 12)
                v15.PulseLength = 1
                v15.FadeLength = 0.46
                v15.Color = Color3.new(0.164706, 0, 0)
                v15.ColorOffsetSpeed = 16
                v15.OuterColor = Color3.new(1, 0, 0.0156863)
            end
            _G.PlaySound(p3.HumanoidRootPart, script.Lightning)
            task.wait(0.18)
        end
    end
end
return v1