 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = workspace.Env:GetDescendants()
local u2 = game:GetService("RunService")
local u3 = script
local v4 = {}
local u5 = game:GetService("TweenService")
local u6 = Random.new()
function v4.start(_, p7, u8, u9) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u1
        [4] = u6
        [5] = u2
    --]]
    local u10 = Instance.new("Folder")
    u10.Name = "EffectsFolder"
    u10.Parent = workspace.Effects
    local v11 = p7:WaitForChild("HumanoidRootPart")
    local v12 = u3.ArmSmoke:Clone()
    local v13 = p7:WaitForChild("RightHand")
    p7:WaitForChild("LeftHand")
    local v14 = p7:WaitForChild("RightLowerArm")
    p7:WaitForChild("LeftLowerArm")
    local v15 = p7:WaitForChild("RightUpperArm")
    p7:WaitForChild("LeftUpperArm")
    local v16 = { v13, v14, v15 }
    v12.Weld.Part0 = v13
    v12.Parent = u10
    for _, v17 in v16 do
        u5:Create(v17, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            ["Transparency"] = 1
        }):Play()
    end
    task.wait(0.2)
    local v18 = workspace:Raycast((v11.CFrame * CFrame.new(0, 0, -3)).Position, Vector3.new(0, -10, 0), u1)
    local v19 = u3.FloorHit:Clone()
    v19.CFrame = v18 and CFrame.lookAt(v18.Position, v18.Position + v18.Normal) or v11.CFrame * CFrame.new(0, -3, -3) * CFrame.Angles(1.5707963267948966, 0, 0)
    v19.Parent = u10
    for _, v20 in pairs(v19:GetDescendants()) do
        if v20:IsA("ParticleEmitter") then
            v20:Emit(v20:GetAttribute("EmitCount"))
        end
    end
    for _, v21 in pairs(v12:GetDescendants()) do
        if v21:IsA("ParticleEmitter") then
            v21.Enabled = false
        end
    end
    for _, v22 in v16 do
        u5:Create(v22, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            ["Transparency"] = 0
        }):Play()
    end
    task.spawn(function() --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u9
            [3] = u6
            [4] = u3
            [5] = u10
            [6] = u2
        --]]
        local u23 = (u8 - u9).Magnitude
        for _ = 1, 3 do
            task.spawn(function() --[[ Line: 107 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u9
                    [3] = u6
                    [4] = u23
                    [5] = u3
                    [6] = u10
                    [7] = u2
                --]]
                u8 = u8
                local v24 = u8
                local v25 = v24 + (u9 - v24) * 0.3
                local v26 = u6:NextNumber(-30, 30) * u23 / 60
                local v27 = u6:NextNumber(10, 30)
                local v28 = u6:NextNumber(-22, 22) * u23 / 50
                local v29 = v25 + Vector3.new(v26, v27, v28)
                local v30 = u8
                local v31 = v30 + (u9 - v30) * 0.6
                local v32 = u6:NextNumber(-30, 30) * u23 / 60
                local v33 = u6:NextNumber(10, 30)
                local v34 = u6:NextNumber(-22, 22) * u23 / 50
                local v35 = v31 + Vector3.new(v32, v33, v34)
                local v36 = u9
                local v37 = u3.Snake:Clone()
                v37.Position = u8
                v37.Parent = u10
                for v38 = 0, 1, 150 / (u8 - u9).Magnitude / (1 / u2.Heartbeat:Wait()) do
                    local v39 = u8 + (v29 - u8) * v38
                    local v40 = v29 + (v35 - v29) * v38
                    local v41 = v35 + (v36 - v35) * v38
                    local v42 = v39 + (v40 - v39) * v38
                    local v43 = v42 + (v40 + (v41 - v40) * v38 - v42) * v38
                    if v44 ~= v43 then
                        v37.CFrame = CFrame.lookAt(v44, v43)
                        u2.Heartbeat:Wait()
                        local v44 = v43
                    end
                end
                for _, v45 in pairs(v37:GetDescendants()) do
                    if v45:IsA("ParticleEmitter") then
                        v45.Enabled = false
                    end
                end
                local v46 = u3.SmokeExplosion:Clone()
                v46.Position = v37.Position
                v46.Parent = u10
                for _, v47 in pairs(v46:GetDescendants()) do
                    if v47:IsA("ParticleEmitter") then
                        v47:Emit(v47:GetAttribute("EmitCount"))
                    end
                end
            end)
            task.wait(u6:NextNumber(0.015, 0.04))
        end
    end)
    task.wait(3.5)
    u10:Destroy()
end
return v4