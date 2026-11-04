 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        Random.new()
        game:GetService("RunService")
        local u2 = game:GetService("TweenService")
        local v3 = script.ToriGrip.ToriVFX:Clone()
        v3.Parent = workspace.Effects
        v3.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(0, -3.1, 0)
        _G.PlaySound(p1.PrimaryPart, script.PhoenixGripSFX)
        for _, u4 in pairs(v3:GetDescendants()) do
            if u4:IsA("ParticleEmitter") then
                task.spawn(function() --[[ Line: 18 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                    --]]
                    u4.Enabled = true
                    task.wait(2.5)
                    u4.Enabled = false
                end)
            end
        end
        for _, u5 in pairs(v3.Body:GetDescendants()) do
            if u5:IsA("ParticleEmitter") then
                task.spawn(function() --[[ Line: 28 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                    --]]
                    task.wait(2)
                    u5.Enabled = false
                end)
            end
        end
        for _, u6 in pairs(p1:GetDescendants()) do
            if u6:IsA("MeshPart") or u6:IsA("Decal") then
                task.spawn(function() --[[ Line: 37 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u6
                    --]]
                    u2:Create(u6, TweenInfo.new(1.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.5), {
                        ["Transparency"] = 1
                    }):Play()
                end)
            end
        end
        _G.destroy(v3, 4)
    end
}