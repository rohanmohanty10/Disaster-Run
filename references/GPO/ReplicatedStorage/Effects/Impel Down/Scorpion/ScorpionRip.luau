 

local v1 = {}
local function u5(p2, p3) --[[ Line: 3 ]]
    for _, v4 in p2:GetDescendants() do
        if v4:IsA("ParticleEmitter") then
            v4.Enabled = p3
        end
    end
end
function v1.start(_, u6, _) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if _G.checkRenderDistance(u6.PrimaryPart.Position) ~= false then
        game:GetService("TweenService")
        local v7 = script.ScorpionRip:Clone()
        local v8 = v7.VFX
        v7.Parent = workspace.Effects
        v8.Parent = u6.HumanoidRootPart
        v8.CFrame = u6.HumanoidRootPart.CFrame
        v8.Left.Parent = u6.LowerTorso
        v8.Right.Parent = u6.UpperTorso
        task.wait(1)
        u5(v8, true)
        task.wait(0.75)
        u5(v8, false)
        u6.Humanoid.Animator:LoadAnimation(v7:WaitForChild("RipAnim")):Play()
        task.delay(0.05, function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
            --]]
            u5(u6.LowerTorso.Left, true)
            u5(u6.UpperTorso.Right, true)
            task.wait(0.9)
            u5(u6.LowerTorso.Left, false)
            u5(u6.UpperTorso.Right, false)
        end)
        _G.destroy(v7, 1.15)
    end
end
return v1