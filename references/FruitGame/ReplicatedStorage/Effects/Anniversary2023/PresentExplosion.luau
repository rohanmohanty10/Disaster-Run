 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("ReplicatedStorage")
function v1.start(_, p2) --[[ Line: 8 ]]
    local v3 = Instance.new("Model")
    local v4 = script.OpeningEffect:Clone()
    v4.CFrame = p2.CFrame + Vector3.new(0, 0.5, 0)
    v4.Parent = v3
    v3:ScaleTo(p2.Scale or 1)
    v3.Parent = workspace.Effects
    _G.customEmit(v4)
    _G.destroy(v3, 4)
    _G.PlaySound(v4, script.BoxOpen, {
        ["RollOffMaxDistance"] = script.BoxOpen.RollOffMaxDistance
    })
end
return v1