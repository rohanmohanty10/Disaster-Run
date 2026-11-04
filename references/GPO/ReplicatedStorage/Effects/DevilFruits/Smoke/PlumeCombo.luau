 

local v1 = RaycastParams.new()
v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
local u2 = game:GetService("RunService")
local u3 = script
local v4 = {}
game:GetService("TweenService")
Random.new()
function v4.start(_, p5, p6, p7, _) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if p5 == nil then
        return
    elseif p6 == "Shoot" then
        local u8 = u3.SmokeProjectile:Clone()
        u8.CFrame = p7
        u8.Parent = workspace.Effects
        _G.PlaySound(u8, script["SmokePunches" .. math.random(1, 3)]).Parent = u8
        local v9 = u3.SmokeLaunch:Clone()
        v9.CFrame = u8.CFrame
        v9.Parent = workspace.Effects
        for _, v10 in pairs(v9:GetDescendants()) do
            if v10:IsA("ParticleEmitter") then
                v10:Emit(v10:GetAttribute("EmitCount"))
            end
        end
        _G.destroy(v9, 5)
        local u11 = nil
        local u12 = os.clock()
        local u13 = RaycastParams.new()
        u13.FilterType = Enum.RaycastFilterType.Include
        u13.RespectCanCollide = true
        u13.FilterDescendantsInstances = _G.getTargetsWithENV(p5)
        local u14 = nil
        u14 = u2.Heartbeat:Connect(function(p15) --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u8
                [3] = u13
                [4] = u12
                [5] = u14
                [6] = u3
            --]]
            u11 = workspace:Spherecast(u8.Position, 2, u8.CFrame.LookVector * 150 * p15, u13)
            if u11 or os.clock() - u12 >= 0.5 then
                u14:Disconnect()
                if u11 then
                    u8.Position = u11.Position
                    local v16 = u3.SmokeExplosion:Clone()
                    v16.CFrame = u8.CFrame
                    v16.Parent = workspace.Effects
                    for _, v17 in pairs(v16:GetDescendants()) do
                        if v17:IsA("ParticleEmitter") then
                            v17:Emit(v17:GetAttribute("EmitCount"))
                        end
                    end
                    _G.destroy(v16, 5)
                    _G.PlaySound(v16, script.HitSFX["hit" .. math.random(1, 3)], {
                        ["RandomPitch"] = true
                    })
                end
                local v18 = u8
                for _, v19 in pairs(v18:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") then
                        v19.Enabled = false
                    end
                end
            else
                u8.CFrame = u8.CFrame * CFrame.new(0, 0, -p15 * 150)
            end
        end)
    else
        local v20 = _G.PlaySound(p5.PrimaryPart, script.SmokePunchesStart)
        v20.Parent = p5.PrimaryPart
        task.wait(0.3846153846153846)
        local v21 = Instance.new("Folder")
        v21.Name = "EffectsFolder"
        v21.Parent = workspace.Effects
        p5:WaitForChild("HumanoidRootPart")
        local v22 = u3.ArmSmoke:Clone()
        local v23 = u3.ArmSmoke:Clone()
        local v24 = p5:WaitForChild("RightHand")
        local v25 = p5:WaitForChild("LeftHand")
        local v26 = {
            v24,
            v25,
            p5:WaitForChild("RightLowerArm"),
            p5:WaitForChild("LeftLowerArm"),
            p5:WaitForChild("RightUpperArm"),
            (p5:WaitForChild("LeftUpperArm"))
        }
        v22.Weld.Part0 = v24
        v23.Weld.Part0 = v25
        v22.Parent = v21
        v23.Parent = v21
        for _, v27 in v26 do
            _G.bodyTransSection(p5, v27)
        end
        repeat
            task.wait()
        until p5:GetAttribute("PlumeComboHold") == nil
        for _, v28 in v26 do
            _G.bodyTransSection(p5, v28, true)
        end
        if v20 then
            _G.tween(v20, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
        end
        for _, v29 in pairs(v22:GetDescendants()) do
            if v29:IsA("ParticleEmitter") then
                v29.Enabled = false
            end
        end
        for _, v30 in pairs(v23:GetDescendants()) do
            if v30:IsA("ParticleEmitter") then
                v30.Enabled = false
            end
        end
        task.wait(3.5)
        v21:Destroy()
    end
end
return v4