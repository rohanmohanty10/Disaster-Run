 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        Random.new()
        game:GetService("RunService")
        local v2 = game:GetService("TweenService")
        game:GetService("Debris")
        local v3 = script.BariGrip:Clone()
        local v4 = v3.Sphere
        local v5 = v3.BariVFX
        v3.Parent = workspace.Effects
        v5.CFrame = p1.HumanoidRootPart.CFrame
        v4.CFrame = v5.CFrame * CFrame.new(0, 1.831, 0)
        v2:Create(v4, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
            ["Transparency"] = 0.5
        }):Play()
        _G.PlaySound(p1.PrimaryPart, script.BariGripSFX)
        task.wait(0.6)
        v2:Create(v4, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
            ["Size"] = Vector3.new(8, 4, 8),
            ["CFrame"] = v4.CFrame * CFrame.new(0, -3, 0)
        }):Play()
        task.wait(0.05)
        _G.customEmit(v5)
        v2:Create(v4, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
            ["Transparency"] = 1
        }):Play()
        task.wait(0.15)
        for _, v6 in pairs(p1:GetDescendants()) do
            if v6:IsA("MeshPart") or v6:IsA("Decal") then
                v2:Create(v6, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                    ["Transparency"] = 1
                }):Play()
            end
        end
        _G.destroy(v3, 1)
    end
}