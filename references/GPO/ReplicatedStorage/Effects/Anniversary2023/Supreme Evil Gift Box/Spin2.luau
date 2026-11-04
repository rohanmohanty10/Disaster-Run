 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
local u2 = game:GetService("Debris")
local u3 = script.Parent
return {
    ["start"] = function(_, u4) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        task.spawn(function() --[[ Line: 10 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
                [3] = u2
            --]]
            local v5 = u3["50%"]["Spinning Box Slam"].SpinFX:Clone()
            v5.CFrame = u4.PrimaryPart.CFrame * CFrame.new(0, 10, 0)
            v5.Parent = workspace.Effects
            for _, v6 in v5.Attachment:GetChildren() do
                if v6:IsA("ParticleEmitter") then
                    v6:Emit(1)
                    v6.Enabled = true
                end
            end
            task.wait(1.5)
            for _, v7 in v5.Attachment:GetChildren() do
                if v7:IsA("ParticleEmitter") then
                    v7.Enabled = false
                end
            end
            u2:AddItem(v5, 1.5)
        end)
        for _ = 1, 20 do
            local u8 = Random.new():NextNumber(0.5, 1)
            local u9 = u3.HalfSmokeMeshDeformed:Clone()
            u9.Transparency = 1
            local v10 = u4.PrimaryPart.CFrame * CFrame.new(0, 10, 0)
            local v11 = CFrame.Angles
            local v12 = Random.new():NextNumber(-5, 5)
            local v13 = math.rad(v12)
            local v14 = Random.new():NextNumber(-179, 179)
            local v15 = math.rad(v14)
            local v16 = Random.new():NextNumber(-5, 5)
            u9.CFrame = v10 * v11(v13, v15, (math.rad(v16)))
            u9.Mesh.Scale = Vector3.new(-65, -25, -65)
            u9.Mesh.Offset = Vector3.new(0, 0, 32.5)
            u9.Parent = workspace.Effects
            u2:AddItem(u9, u8)
            local v17 = Random.new():NextNumber(-120, -100)
            task.spawn(function() --[[ Line: 42 ]]
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
                ["Scale"] = Vector3.new(v17, -10, v17),
                ["Offset"] = Vector3.new(0, 0, 50)
            }):Play()
            task.wait(0.05)
        end
    end
}