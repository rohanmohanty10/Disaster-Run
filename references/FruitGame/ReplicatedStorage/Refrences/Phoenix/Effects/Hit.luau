 

game:GetService("RunService")
workspace:WaitForChild("Effects")
game:GetService("TweenService")
local u1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
local u2 = game:GetService("ReplicatedStorage"):WaitForChild("Phoenix")
local u3 = require(u2.Effects.Flare)
local u4 = require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local u5 = workspace.CurrentCamera
return function(p6, p7, p8, p9) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
        [3] = u2
        [4] = u4
        [5] = u3
    --]]
    local v10 = p6 or CFrame.new()
    local v11 = math.min(15, p7 or 10)
    local v12 = p8 or 1
    local v13 = v10.p or Vector3.new()
    if (u5.CFrame.p - v13).Magnitude < 35 + v11 * 7 then
        if p9 then
            u1.PlaySound(v10, u2.Sounds["Audio/PhoUltFinalHit"], {
                ["PlaybackSpeed"] = 1 / v12
            })
        else
            u1.PlaySound(v10, u2.Sounds["Audio/PhoUltHit1"], {
                ["PlaybackSpeed"] = 1.25
            })
        end
        local v14 = (u5.CFrame.p - v10.p).Magnitude / (v11 * 2.75 + 25)
        if v14 < 1 then
            local v15 = 1 - v14
            u4({
                ["RotationInfluence"] = Vector3.new(0, 0, 1),
                ["Roughness"] = 8 * v15,
                ["Magnitude"] = 6 * v15,
                ["FadeIn"] = v12 * 2,
                ["FadeOut"] = v12 * 0.75
            })
        end
        local v16 = Instance.new("Attachment", workspace.Terrain)
        v16.CFrame = v10
        local v17 = u2.Particles.Hit:Clone()
        v17.ZOffset = v11 * 0.1
        v17.Lifetime = NumberRange.new(v12)
        v17.Size = u1.ScaleParticleSize(v17.Size.Keypoints, v11 * 1.125)
        v17.Parent = v16
        local v18 = u2.Particles.Hit2:Clone()
        v18.ZOffset = v11 * 0.1
        v18.Lifetime = NumberRange.new(v12)
        v18.Size = u1.ScaleParticleSize(v18.Size.Keypoints, v11 * 1.125)
        v18.Parent = v16
        v17:Emit(1)
        v18:Emit(1)
        local v19 = script.Part.Attachment:Clone()
        v19.Parent = workspace.Terrain
        v19.CFrame = v10
        local v20 = v19:GetChildren()
        for v21 = 1, #v20 do
            v20[v21]:Emit(15)
        end
        local v22 = u3
        local v23 = Color3.fromRGB(255, 170, 0)
        local v24 = v11 * 0.5
        v22(v10, v23, v11, math.min(12, v24), v11 * 0.75, v11 * 1.25, v12 * 0.5, v12 * v12 * 0.25)
        task.wait(v12 + 1)
        v19:Destroy()
        v16:Destroy()
    end
end