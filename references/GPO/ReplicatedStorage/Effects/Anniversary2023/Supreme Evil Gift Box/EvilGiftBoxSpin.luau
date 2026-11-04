 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = script.Parent
return {
    ["start"] = function(_, p3, p4) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v5 = u2["100%"]["SUPER EVIL SPIN"].SpinParticles:Clone()
        v5.Parent = workspace.Effects
        _G.destroy(v5, 10)
        _G.customWeld(v5, p3.PrimaryPart, CFrame.new(0, -8, 0), v5)
        for _, v6 in v5.Attachment:GetChildren() do
            if v6:IsA("ParticleEmitter") then
                v6:Emit(1)
                v6.Enabled = true
            end
        end
        local v7 = tick()
        repeat
            local u8 = Random.new():NextNumber(0.5, 1)
            local u9 = u2.SmokeMeshDeformed:Clone()
            u9.Transparency = 1
            local v10 = p3.PrimaryPart.CFrame * CFrame.new(0, -8, 0)
            local v11 = CFrame.Angles
            local v12 = Random.new():NextNumber(-2.5, 2.5)
            local v13 = math.rad(v12)
            local v14 = Random.new():NextNumber(-179, 179)
            local v15 = math.rad(v14)
            local v16 = Random.new():NextNumber(-2.5, 2.5)
            u9.CFrame = v10 * v11(v13, v15, (math.rad(v16)))
            u9.Mesh.Scale = Vector3.new(-65, -25, -65)
            u9.Parent = workspace.Effects
            _G.destroy(u9, u8)
            local v17 = Random.new():NextNumber(-140, -120)
            task.spawn(function() --[[ Line: 36 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u9
                    [3] = u8
                --]]
                u1:Create(u9, TweenInfo.new(u8 / 4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Transparency"] = 0.95
                }):Play()
                task.wait(u8 / 4)
                u1:Create(u9, TweenInfo.new(u8 - u8 / 4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                }):Play()
            end)
            u1:Create(u9, TweenInfo.new(u8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = u9.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
            }):Play()
            u1:Create(u9.Mesh, TweenInfo.new(u8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(v17, -10, v17)
            }):Play()
            task.wait(0.1)
        until p4 <= tick() - v7
        _G.particleEnabled(v5.Attachment, false)
        _G.destroy(v5, 1)
    end
}