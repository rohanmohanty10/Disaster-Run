 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        local _ = workspace.CurrentCamera
        _G.PlaySound(p1.PrimaryPart, script.PikaGripSFX)
        Random.new()
        game:GetService("RunService")
        local u2 = game:GetService("TweenService")
        game:GetService("Debris")
        local v3 = script.PikaGrip:Clone()
        local u4 = v3.PikaVFX
        v3.Parent = workspace.Effects
        u4.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
        _G.customEmit(u4)
        for _, u5 in pairs(u4:GetDescendants()) do
            if u5:IsA("ParticleEmitter") then
                task.spawn(function() --[[ Line: 26 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u2
                        [3] = u4
                    --]]
                    u5.Enabled = true
                    task.wait(2.5)
                    u5.Enabled = false
                    u2:Create(u4.Decal.Magic, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                        ["Transparency"] = 1
                    }):Play()
                end)
            end
        end
        _G.destroy(v3, 6)
    end
}