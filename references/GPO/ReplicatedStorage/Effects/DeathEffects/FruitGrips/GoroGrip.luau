 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        local _ = workspace.CurrentCamera
        Random.new()
        game:GetService("RunService")
        local v2 = game:GetService("TweenService")
        game:GetService("Debris")
        local v3 = script.GoroGrip:Clone()
        local u4 = v3.Bolt
        local u5 = v3.Lightning
        _G.PlaySound(p1.PrimaryPart, script.GoroGripSFX)
        u4.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(-12, 15, 12)
        u4.CFrame = CFrame.lookAt(u4.Position, p1.HumanoidRootPart.Position) * CFrame.Angles(0, 1.5707963267948966, 0)
        u5.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, 0, 3.141592653589793)
        v3.Parent = workspace.Effects
        v2:Create(u4, TweenInfo.new(0.15), {
            ["Transparency"] = 0
        }):Play()
        local v6 = v2:Create(u4, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, 0.35), {
            ["Position"] = p1.HumanoidRootPart.Position
        })
        v6:Play()
        v6.Completed:Wait()
        _G.customEmit(u4.HitS)
        for _, u7 in pairs(u5:GetDescendants()) do
            if u7:IsA("ParticleEmitter") then
                task.spawn(function() --[[ Line: 35 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u4
                        [3] = u5
                    --]]
                    u7.Enabled = true
                    task.wait(1.75)
                    u4.Transparency = 1
                    u4:Destroy()
                    u5.Swirls.Crescent2.Enabled = false
                    task.wait(0.75)
                    u7.Enabled = false
                end)
            end
        end
        task.delay(1.75, function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            _G.customEmit(u5)
        end)
        _G.destroy(v3, 4)
    end
}