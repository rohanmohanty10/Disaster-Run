 

return {
    ["start"] = function(_, u1, _) --[[ Name: start, Line 3 ]]
        Random.new()
        game:GetService("RunService")
        local u2 = game:GetService("TweenService")
        game:GetService("Debris")
        local u3 = script.SunaGrip:Clone()
        local u4 = u3.SunaVFX
        u3.Parent = workspace.Effects
        u4.CFrame = u1.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
        u4.Whirl.InwardsShockwave.Enabled = true
        _G.PlaySound(u1.PrimaryPart, script.SunaGripSFX)
        task.wait(1)
        _G.customEmit(u4)
        for _, u5 in pairs(u4:GetDescendants()) do
            if u5:IsA("ParticleEmitter") then
                task.spawn(function() --[[ Line: 27 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u1
                        [3] = u3
                        [4] = u2
                        [5] = u4
                    --]]
                    u5.Enabled = false
                    u5.Enabled = true
                    for _, u6 in pairs(u1:GetDescendants()) do
                        if u6:IsA("MeshPart") or u6:IsA("Decal") then
                            task.spawn(function() --[[ Line: 32 ]]
                                --[[
                                Upvalues:
                                    [1] = u3
                                    [2] = u6
                                    [3] = u2
                                --]]
                                local v7 = u3.Sand:Clone()
                                v7.Parent = u6
                                v7.Enabled = true
                                u2:Create(u6, TweenInfo.new(1.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.5), {
                                    ["Transparency"] = 1
                                }):Play()
                                task.wait(1.5)
                                v7.Enabled = false
                            end)
                        end
                    end
                    task.wait(1.4)
                    u4.WhirlM.Whirl.Enabled = false
                    task.wait(0.25)
                    u5.Enabled = false
                end)
            end
        end
        _G.destroy(u3, 3.5)
    end
}