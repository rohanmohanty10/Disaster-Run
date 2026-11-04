 

local v1 = {}
require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p2, _, _) --[[ Line: 5 ]]
    if _G.checkRenderDistance(p2.PrimaryPart.Position) then
        local v3 = script
        local v4 = p2.HumanoidRootPart
        local v5 = v3.handPart:Clone()
        v5.Anchored = false
        v5.Name = "prepMesHandPart" .. p2.Name
        v5.CFrame = v4.Parent.RightHand.CFrame
        v5.Parent = workspace.Effects
        _G.destroy(v5, 6)
        v5.shockSound.Playing = true
        local v6 = Instance.new("WeldConstraint")
        v6.Part0 = v5
        v6.Part1 = v4.Parent.RightHand
        v6.Parent = v5
        for _, v7 in pairs(v5:GetChildren()) do
            if v7:IsA("ParticleEmitter") then
                game:GetService("TweenService"):Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Rate"] = v7.Rate * 10
                }, true):Play()
            end
        end
        for _, v8 in pairs(v5.centerAttach:GetChildren()) do
            game:GetService("TweenService"):Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Rate"] = v8.Rate * 10
            }, true):Play()
        end
        game:GetService("TweenService"):Create(v5.centerAttach.waveAbsorb, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["Rate"] = 0
        }, true):Play()
    end
end
return v1