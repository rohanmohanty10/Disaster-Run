 

local v1 = {}
local function u4(p2) --[[ Line: 3 ]]
    for _, v3 in p2:GetDescendants() do
        if v3:IsA("ParticleEmitter") then
            _G.customEmit(v3)
        end
    end
end
function v1.start(_, p5, _) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if _G.checkRenderDistance(p5.PrimaryPart.Position) ~= false then
        game:GetService("TweenService")
        local v6 = script.ScorpionSting:Clone()
        local v7 = v6.VFX
        v6.Parent = workspace.Effects
        v7.Parent = p5.HumanoidRootPart
        v7.CFrame = p5.HumanoidRootPart.CFrame
        u4(v7)
        _G.destroy(v6, 2.5)
    end
end
return v1