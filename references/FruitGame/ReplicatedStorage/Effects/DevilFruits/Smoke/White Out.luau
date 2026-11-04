 

local v1 = RaycastParams.new()
v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = workspace.Env:GetDescendants()
local u2 = game:GetService("RunService")
local u3 = script
local v4 = {}
local u5 = game:GetService("TweenService")
local u6 = Random.new()
function v4.start(_, p7, p8, p9) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
        [3] = u5
        [4] = u2
    --]]
    local v10 = Instance.new("Folder")
    v10.Name = "EffectsFolder"
    v10.Parent = workspace.Effects
    local u11 = p7:WaitForChild("HumanoidRootPart")
    local v12 = CFrame.new(p8.Position)
    local u13 = p7:WaitForChild("RightHand")
    local u14 = p7:WaitForChild("LeftHand")
    local v15 = {
        u13,
        u14,
        p7:WaitForChild("RightLowerArm"),
        p7:WaitForChild("LeftLowerArm"),
        p7:WaitForChild("RightUpperArm"),
        (p7:WaitForChild("LeftUpperArm"))
    }
    task.spawn(function() --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u13
            [3] = u14
            [4] = u11
            [5] = u6
        --]]
        for _ = 1, 6 do
            task.spawn(function() --[[ Line: 79 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u13
                    [3] = u14
                    [4] = u11
                    [5] = u6
                --]]
                local u16 = u3.ExpandingArmSmoke:Clone()
                local u17 = math.random(0, 1) == 1 and u13.Position or u14.Position
                local v18 = u11.Position
                local v19 = u6:NextNumber(-50, 50)
                local v20 = u6:NextNumber(-50, 50)
                local v21 = u6
                local u22 = v18 + Vector3.new(v19, v20, v21:NextNumber(-50, 50))
                local v23 = u11.Position
                local v24 = u6:NextNumber(-50, 50)
                local v25 = u6:NextNumber(-50, 50)
                local v26 = u6
                local u27 = v23 + Vector3.new(v24, v25, v26:NextNumber(-50, 50))
                local u28 = u11.Position
                u16.Position = u17
                u16.Parent = workspace.Effects
                local u29 = 0
                local u30 = nil
                u30 = game["Run Service"].Heartbeat:Connect(function(p31) --[[ Line: 92 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u28
                        [3] = u11
                        [4] = u17
                        [5] = u22
                        [6] = u27
                        [7] = u16
                        [8] = u30
                    --]]
                    u29 = u29 + p31 * 3
                    local v32 = u29
                    u29 = math.clamp(v32, 0, 1)
                    u28 = u11.Position
                    local v33 = u17
                    local v34 = u29
                    local v35 = v33 + (u22 - v33) * v34
                    local v36 = u22
                    local v37 = u29
                    local v38 = v36 + (u27 - v36) * v37
                    local v39 = u27
                    local v40 = u29
                    local v41 = v39 + (u28 - v39) * v40
                    local v42 = u29
                    local v43 = v35 + (v38 - v35) * v42
                    local v44 = u29
                    local v45 = u29
                    u16.Position = v43 + (v38 + (v41 - v38) * v44 - v43) * v45
                    if u29 >= 1 then
                        local v46 = u16
                        for _, v47 in pairs(v46:GetDescendants()) do
                            if v47:IsA("ParticleEmitter") then
                                v47.Enabled = false
                            end
                        end
                        _G.destroy(u16, 2)
                        u30:Disconnect()
                        u30 = nil
                    end
                end)
            end)
            task.wait(u6:NextNumber(0.02, 0.04))
        end
    end)
    task.wait(0.4)
    local v48 = u3.ArmSmoke:Clone()
    local v49 = u3.ArmSmoke:Clone()
    v48.Weld.Part0 = u13
    v49.Weld.Part0 = u14
    v48.Parent = v10
    v49.Parent = v10
    for _, v50 in v15 do
        _G.bodyTransSection(p7, v50)
    end
    local v51 = u3.SmokeExplosion:Clone()
    v51.CFrame = v12
    v51.Parent = v10
    for _, v52 in pairs(v51:GetDescendants()) do
        if v52:IsA("ParticleEmitter") then
            v52:Emit(v52:GetAttribute("EmitCount"))
        end
    end
    local u53 = u3.BigSmoke:Clone()
    u53.CFrame = v12 * CFrame.new(0, 10, 0)
    local v54 = u5
    local v55 = TweenInfo.new(p9 + 3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local v56 = {}
    local v57 = u53.Orientation
    local v58 = p9 * 360
    v56.Orientation = v57 + Vector3.new(0, v58, 0)
    v54:Create(u53, v55, v56):Play()
    local v59 = u53.Size
    u53.Size = Vector3.new(0, 0, 0)
    u53.Parent = v10
    u5:Create(u53, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Size"] = v59
    }):Play()
    local u60 = os.clock()
    local v76 = u2.Heartbeat:Connect(function() --[[ Line: 160 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u3
            [3] = u53
            [4] = u6
            [5] = u5
        --]]
        if os.clock() - u60 > 0.04 then
            u60 = os.clock()
            local v61 = u3.Wind:Clone()
            local v62 = u53.CFrame
            local v63 = CFrame.Angles
            local v64 = u6:NextNumber(-10, 10)
            local v65 = math.rad(v64)
            local v66 = u6:NextNumber(0, 3.141592653589793)
            local v67 = u6:NextNumber(-10, 10)
            v61.CFrame = v62 * v63(v65, v66, (math.rad(v67)))
            local v68 = u6:NextNumber(15, 45)
            local v69 = u6:NextNumber(10, 30)
            v61.Size = Vector3.new(v68, v69, v68)
            v61.Parent = workspace.Effects
            local v70 = u6:NextNumber(25, 35)
            u5:Create(v61, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                ["Transparency"] = u6:NextNumber(0.9, 0.98)
            }):Play()
            local v71 = u5
            local v72 = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
            local v73 = {}
            local v74 = v61.Orientation
            local v75 = u6:NextNumber(180, 360)
            v73.Orientation = v74 + Vector3.new(0, v75, 0)
            v73.Size = v61.Size + Vector3.new(v70, 0, v70)
            v71:Create(v61, v72, v73):Play()
            task.wait(0.15)
            u5:Create(v61, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v61, 0.15)
        end
    end)
    repeat
        task.wait()
    until p7:GetAttribute("WhiteOutHold") == nil
    for _, v77 in v15 do
        _G.bodyTransSection(p7, v77, true)
    end
    for _, v78 in pairs(v48:GetDescendants()) do
        if v78:IsA("ParticleEmitter") then
            v78.Enabled = false
        end
    end
    for _, v79 in pairs(v49:GetDescendants()) do
        if v79:IsA("ParticleEmitter") then
            v79.Enabled = false
        end
    end
    v76:Disconnect()
    for _, v80 in pairs(u53:GetDescendants()) do
        if v80:IsA("ParticleEmitter") then
            v80.Enabled = false
        end
    end
    task.wait(3.5)
    v10:Destroy()
end
return v4