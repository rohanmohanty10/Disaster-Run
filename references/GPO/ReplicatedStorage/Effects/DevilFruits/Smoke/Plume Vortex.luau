 

local u1 = {
    "rbxassetid://18743940286",
    "rbxassetid://18743940109",
    "rbxassetid://18743939853",
    "rbxassetid://18743939294",
    "rbxassetid://18743938951",
    "rbxassetid://18743938792",
    "rbxassetid://18743938433",
    "rbxassetid://18743938143",
    "rbxassetid://18743937781",
    "rbxassetid://18743937481",
    "rbxassetid://18743937199",
    "rbxassetid://18743936946",
    "rbxassetid://18743936656",
    "rbxassetid://18743936404",
    "rbxassetid://18743936205",
    "rbxassetid://18743935894",
    ""
}
local v2 = RaycastParams.new()
v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = workspace.Env:GetDescendants()
local u3 = game:GetService("RunService")
local u4 = script
local v5 = {}
local u6 = game:GetService("TweenService")
local u7 = Random.new()
function v5.start(_, p8, u9, p10, p11, p12, u13) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u7
        [4] = u6
        [5] = u1
    --]]
    local u14 = Instance.new("Folder")
    u14.Name = "EffectsFolder"
    u14.Parent = workspace.Effects
    p8:WaitForChild("HumanoidRootPart")
    local v15 = u4.ArmSmoke:Clone()
    local v16 = u4.ArmSmoke:Clone()
    local v17 = p8:WaitForChild("RightHand")
    local v18 = p8:WaitForChild("LeftHand")
    local v19 = {
        v17,
        v18,
        p8:WaitForChild("RightLowerArm"),
        p8:WaitForChild("LeftLowerArm"),
        p8:WaitForChild("RightUpperArm"),
        (p8:WaitForChild("LeftUpperArm"))
    }
    v15.Weld.Part0 = v17
    v16.Weld.Part0 = v18
    v15.Parent = u14
    v16.Parent = u14
    local u20 = script.VFX:Clone()
    u20:ScaleTo(u13)
    local v21 = u20.Burst
    local v22 = u9.Position
    local v23 = -3 * u13
    v21.Position = v22 + Vector3.new(0, v23, 0)
    v21.Parent = u14
    for _, v24 in pairs(v21:GetDescendants()) do
        if v24:IsA("ParticleEmitter") then
            v24:Emit(v24:GetAttribute("EmitCount"))
        end
    end
    local v25 = _G.PlaySound(u9, script.SmokeUlt)
    v25.Parent = v21
    task.wait(0.2)
    local v26 = u20.SmokeBurst
    v26.Position = v21.Position
    v26.Parent = u14
    for _, v27 in pairs(v26:GetDescendants()) do
        if v27:IsA("ParticleEmitter") then
            v27:Emit(v27:GetAttribute("EmitCount"))
        end
    end
    for _, v28 in pairs(v15:GetDescendants()) do
        if v28:IsA("ParticleEmitter") then
            v28.Enabled = false
        end
    end
    for _, v29 in pairs(v16:GetDescendants()) do
        if v29:IsA("ParticleEmitter") then
            v29.Enabled = false
        end
    end
    task.wait(0.12)
    task.wait(p11 - 0.2 + 0.12)
    local u30 = os.clock()
    local v42 = u3.Heartbeat:Connect(function() --[[ Line: 129 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u7
            [3] = u13
            [4] = u20
            [5] = u9
            [6] = u14
            [7] = u6
            [8] = u1
        --]]
        if os.clock() - u30 > 0.03 then
            u30 = os.clock()
            local v31 = u7:NextNumber(5, 12) * u13
            local v32 = u20.Wind:Clone()
            v32.CFrame = u9 * CFrame.Angles(0, u7:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, v31, 0)
            v32.Parent = u14
            local v33 = u7:NextNumber(3, 12)
            v32.Mesh.Scale = Vector3.new(v33, v31, v33) * u13
            u6:Create(v32.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }):Play()
            local v34 = u7:NextNumber(5, 15)
            local v35 = u6
            local v36 = v32.Mesh
            local v37 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v38 = {}
            local v39 = v32.Mesh.Scale
            local v40 = u7:NextNumber(5, 25)
            v38.Scale = v39 + Vector3.new(v34, v40, v34) * u13
            v35:Create(v36, v37, v38):Play()
            for _, v41 in u1 do
                v32.Decal.Texture = v41
                task.wait(0.015)
            end
        end
    end)
    local v43 = u20.BigSmoke
    v43.CFrame = u9 * CFrame.new(0, 12 * u13, 0)
    v43.Parent = u14
    local v44 = u6
    local v45 = TweenInfo.new(p10 + 2, Enum.EasingStyle.Linear)
    local v46 = {}
    local v47 = v43.Orientation
    local v48 = p10 * -360
    v46.Orientation = v47 + Vector3.new(0, v48, 0)
    v44:Create(v43, v45, v46):Play()
    repeat
        task.wait()
    until p8:GetAttribute(p12) == nil
    for _, v49 in v19 do
        _G.bodyTransSection(p8, v49, true)
    end
    u6:Create(v25, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Volume"] = 0
    }):Play()
    _G.destroy(v25, 0.25)
    for _, v50 in pairs(v43:GetDescendants()) do
        if v50:IsA("ParticleEmitter") then
            v50.Enabled = false
        end
    end
    v42:Disconnect()
    task.wait(3.5)
    _G.destroy(u20, 2)
    u14:Destroy()
end
return v5