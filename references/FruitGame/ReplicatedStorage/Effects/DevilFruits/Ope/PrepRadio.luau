 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p3, _, _) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) then
        local v4 = script
        local v5 = p3.HumanoidRootPart
        local v6 = v4.handle:Clone()
        v6.Anchored = true
        v6.Name = "swordRadioKnife" .. p3.Name
        v6.CFrame = v5.Parent.RightHand.CFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
        v6.Parent = workspace.Effects
        _G.destroy(v6, 6)
        local v7 = Instance.new("WeldConstraint")
        v7.Part0 = v6
        v7.Part1 = v5.Parent.RightHand
        v7.Parent = v6
        v6.Anchored = false
        local u8 = u2.new(v6.bottomAttach, v6.middleAttach, 3)
        u8.MaxRadius = 0.1
        u8.PulseSpeed = 20
        u8.AnimationSpeed = 20
        u8.MinTransparency = 0.2
        u8.MaxTransparency = 0.3
        function u8.RadialProfileFunction(p9) --[[ Line: 32 ]]
            local v10 = -5000 * (p9 - 0.35) ^ 10
            return math.exp(v10)
        end
        u8.Thickness = 0.1
        u8.MinThicknessMultiplier = 0.3
        u8.MaxThicknessMultiplier = 1
        u8.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 50, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(183, 60, 207)) })
        local u11 = u2.new(v6.middleAttach, v6.pointAttach, 8)
        u11.MaxRadius = 0.5
        u11.PulseSpeed = 20
        u11.AnimationSpeed = 20
        u11.MinTransparency = 0.2
        u11.MaxTransparency = 0.3
        function u11.RadialProfileFunction(p12) --[[ Line: 49 ]]
            local v13 = -5000 * (p12 - 0.35) ^ 10
            return math.exp(v13)
        end
        u11.ContractFrom = 0.8
        u11.Thickness = 0.1
        u11.MinThicknessMultiplier = 0.3
        u11.MaxThicknessMultiplier = 1
        u11.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 50, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(183, 60, 207)) })
        local u14 = u2.new(v6.leftAttach, v6.rightAttach, 4)
        u14.MaxRadius = 0.5
        u14.PulseSpeed = 20
        u14.AnimationSpeed = 20
        u14.MinTransparency = 0.2
        u14.MaxTransparency = 0.3
        function u14.RadialProfileFunction(p15) --[[ Line: 68 ]]
            local v16 = -5000 * (p15 - 0.35) ^ 10
            return math.exp(v16)
        end
        u14.Thickness = 0.1
        u14.MinThicknessMultiplier = 0.6
        u14.MaxThicknessMultiplier = 1
        u14.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 50, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(183, 60, 207)) })
        v6.Destroying:Connect(function() --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u11
                [3] = u14
            --]]
            u8:Destroy()
            u11:Destroy()
            u14:Destroy()
        end)
        game:GetService("TweenService"):Create(v6.pointAttach, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            ["Position"] = Vector3.new(-4.85, 0, 0)
        }, true):Play()
        game:GetService("TweenService"):Create(v6.leftAttach, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            ["Position"] = Vector3.new(-0.5, 0, 0.7)
        }, true):Play()
        game:GetService("TweenService"):Create(v6.rightAttach, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            ["Position"] = Vector3.new(-0.5, 0, -0.7)
        }, true):Play()
        game:GetService("TweenService"):Create(v6.middlePart, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            ["Size"] = Vector3.new(5.3, 0.1, 0.1)
        }, true):Play()
        for _, v17 in pairs(v6.middlePart:GetChildren()) do
            if v17:IsA("ParticleEmitter") then
                v17.Enabled = true
                game:GetService("TweenService"):Create(v17, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["Rate"] = v17.Rate * 10
                }, true):Play()
            end
        end
        task.wait(0.3)
        v6.middlePart.swirlAbsorb.Enabled = false
        task.wait(0.2)
        v6.middleBeam.Enabled = true
        v6.middlePart.electricityAbsorb.Enabled = false
        v6.middlePart.waveAbsorb.Enabled = false
        _G.customEmit(v6.middlePart.orbBurst)
        _G.customEmit(v6.middlePart.glowBurst)
        _G.customEmit(v6.middlePart.electricityBurst)
        _G.customEmit(v6.middlePart.formLineBurst)
        _G.customEmit(v6.middlePart.burstWave1)
        _G.customEmit(v6.middlePart.burstWave2)
        _G.customEmit(v6.middlePart.burstWave3)
        _G.customEmit(v6.middlePart.burstWave4)
        _G.customEmit(v6.burstAttach, true)
        u8.Thickness = 0.3
        u11.Thickness = 0.3
        u14.Thickness = 0.3
        game:GetService("TweenService"):Create(v6.pointAttach, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 100000, true), {
            ["Position"] = Vector3.new(-4.6, 0, 0)
        }, true):Play()
        game:GetService("TweenService"):Create(v6.leftAttach, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 100000, true), {
            ["Position"] = Vector3.new(-0.5, 0, 0.8)
        }, true):Play()
        game:GetService("TweenService"):Create(v6.rightAttach, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 100000, true), {
            ["Position"] = Vector3.new(-0.5, 0, -0.8)
        }, true):Play()
    end
end
return v1