 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        local _ = workspace.CurrentCamera
        Random.new()
        game:GetService("RunService")
        local u2 = game:GetService("TweenService")
        game:GetService("Debris")
        local v3 = script.MeroGrip:Clone()
        local u4 = v3.MeroVFX
        u4.CFrame = p1.HumanoidRootPart.CFrame
        v3.Parent = workspace.Effects
        _G.PlaySound(p1.PrimaryPart, script.MeroGripSFX)
        for u5 = 1, 7 do
            local v6 = script.Arrows:Clone()
            local u7 = v6.Arrow
            v6.Parent = v3
            u7.CFrame = u4.CFrame * CFrame.new(math.random(-15, 15), math.random(6, 15), math.random(-15, 15))
            u7.CFrame = CFrame.lookAt(u7.Position, u4.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
            task.spawn(function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u7
                    [3] = u4
                    [4] = u5
                --]]
                u2:Create(u7, TweenInfo.new(0.15), {
                    ["Transparency"] = 0
                }):Play()
                u2:Create(u7, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, 0.35), {
                    ["Position"] = u4.Position
                }):Play()
                task.wait(0.55)
                if u5 == 1 then
                    _G.customEmit(u4)
                end
                task.wait(0.05)
                u7.Transparency = 1
            end)
        end
        _G.destroy(v3, 3)
    end
}