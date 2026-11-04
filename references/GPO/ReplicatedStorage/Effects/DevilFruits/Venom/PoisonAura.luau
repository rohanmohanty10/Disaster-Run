 

local v1 = {}
game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local _ = script.Parent.Puddles.Purple
local u2 = script.Animations
game.Players.LocalPlayer:GetMouse()
function PlayAnim(p3, p4)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = (p3:FindFirstChild("Humanoid") or p3:FindFirstChild("AnimationController")).Animator:LoadAnimation(u2[p4])
    v5:Play(0, 1, 1)
    return v5
end
local function u11(p6) --[[ Line: 23 ]]
    local v7 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v8 = math.clamp(v7, 1, 10)
    for _, v9 in p6:GetDescendants() do
        if v9:IsA("ParticleEmitter") then
            local v10 = v9:GetAttribute("EmitCount") * (v8 / 10)
            v9:Emit((math.clamp(v10, 1, v9:GetAttribute("EmitCount"))))
        end
    end
end
function v1.start(_, p12) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if p12 then
        _G.PlaySound(p12.PrimaryPart, script.Sounds.VenomSwipeStart)
        PlayAnim(p12, "Swipe")
        local u13 = script.Holder:Clone()
        u13.CFrame = p12.RightLowerArm.CFrame
        u13.Parent = workspace.Effects
        local v14 = Instance.new("WeldConstraint")
        local v15 = p12.RightLowerArm
        v14.Parent = u13
        v14.Part0 = v15
        v14.Part1 = u13
        _G.destroy(u13, 1.5)
        task.delay(0.4, function() --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            for _, v16 in u13:GetDescendants() do
                if v16:IsA("ParticleEmitter") then
                    v16.Enabled = false
                end
            end
        end)
        task.wait(0.4)
        _G.PlaySound(p12.PrimaryPart, script.Sounds.VenomSwipeWhoosh)
        local v17 = script.Use:Clone()
        v17.CFrame = p12.PrimaryPart.CFrame
        v17.Parent = workspace.Effects
        u11(v17)
        _G.destroy(v17, 0.8)
        local u18 = script.PoisonAura:Clone()
        u18.CFrame = p12.PrimaryPart.CFrame
        u18.Parent = workspace.Effects
        local v19 = Instance.new("WeldConstraint")
        local v20 = p12.PrimaryPart
        v19.Parent = u18
        v19.Part0 = v20
        v19.Part1 = u18
        task.wait(5)
        _G.destroy(u18, 2)
        task.delay(0.4, function() --[[ Line: 77 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            for _, v21 in u18:GetDescendants() do
                if v21:IsA("ParticleEmitter") then
                    v21.Enabled = false
                end
            end
        end)
    end
end
return v1