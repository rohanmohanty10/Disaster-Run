 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Debris")
game:GetService("ReplicatedStorage"):WaitForChild("ClientImpacts"):WaitForChild("Soru")
function v1.start(_, p2) --[[ Line: 11 ]]
    local v3 = p2.Origin
    local v4 = script.sorun:Clone()
    v4.CFrame = CFrame.new(v3)
    v4.Parent = workspace.Effects
    local v5 = script.Sound:Clone()
    v5.Parent = v4
    v5:Play()
    _G.destroy(v5, 2)
    for _, v6 in pairs(v4:GetDescendants()) do
        if v6:IsA("ParticleEmitter") then
            _G.customEmit(v6)
        end
    end
    task.wait(5)
    v4:Destroy()
end
return v1