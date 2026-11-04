 

local u1 = game:GetService("TweenService")
local v2 = {}
local u3 = {
    "LeftFoot",
    "RightFoot",
    "LeftLowerLeg",
    "RightLowerLeg",
    "LeftUpperLeg",
    "RightUpperLeg",
    "LeftHand",
    "RightHand",
    "LowerTorso",
    "LeftLowerArm",
    "RightLowerArm",
    "UpperTorso",
    "LeftUpperArm",
    "RightUpperArm",
    "FakeHead"
}
local u4 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u5 = setmetatable({}, {
    ["__mode"] = "k"
})
local function u8(p6) --[[ Line: 21 ]]
    p6:SetAttribute("FreezeFX", true)
    for _, v7 in ipairs(p6:GetDescendants()) do
        v7:SetAttribute("FreezeFX", true)
    end
end
local function u17(p9, p10) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v11 = p9:FindFirstChild("FakeHead")
    local v12 = p10:FindFirstChild("Head", true)
    local v13 = p9:FindFirstChild("Head")
    p10:FindFirstChild("FakeHead", true)
    local v14 = v11:Clone()
    v14.Name = "FakeHead"
    v14.Anchored = false
    v14.CanCollide = false
    v14.Massless = true
    v14:SetAttribute("FreezeFX", true)
    v14.Parent = p10
    local v15 = v13.CFrame:ToObjectSpace(v11.CFrame)
    v14.CFrame = v12.CFrame * v15
    local v16 = Instance.new("WeldConstraint")
    v16.Part0 = v14
    v16.Part1 = v12
    v16.Parent = v14
    u8(v14)
end
local function u20(p18) --[[ Line: 59 ]]
    for _, v19 in ipairs(p18:GetDescendants()) do
        if v19:GetAttribute("FreezeFX") == true then
            v19:Destroy()
        end
    end
end
local function u27(p21, p22) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u20
        [3] = u8
    --]]
    u17(p21, p22)
    for _, v23 in ipairs(p21:GetChildren()) do
        if v23:IsA("BasePart") and v23.Name ~= "FakeHead" then
            local v24 = p22:FindFirstChild(v23.Name, true)
            if v24 and v24:IsA("BasePart") then
                u20(v24)
                for _, v25 in ipairs(v23:GetDescendants()) do
                    if v25 ~= v23 then
                        local v26 = v25:Clone()
                        if v26:IsA("BaseWrap") then
                            if v24:IsA("MeshPart") then
                                v26.Parent = v24
                                u8(v26)
                            else
                                v26:Destroy()
                            end
                        elseif v26:IsA("Decal") or v26:IsA("Texture") then
                            v26.Parent = v24
                            v26.Color3 = Color3.fromRGB(700, 500, 1000)
                            u8(v26)
                        elseif v25.Parent == v23 or (v25:IsA("Attachment") or (v25:IsA("PointLight") or (v25:IsA("SpotLight") or v25:IsA("SurfaceLight")))) then
                            v26.Parent = v24
                            u8(v26)
                        else
                            v26:Destroy()
                        end
                    end
                end
            end
        end
    end
end
local function u30(p28) --[[ Line: 114 ]]
    for _, v29 in ipairs(p28:GetDescendants()) do
        if v29:GetAttribute("FreezeFX") ~= false then
            if (v29:IsA("Decal") or v29:IsA("Texture")) and v29.Name ~= "face" then
                if v29:GetAttribute("OrigTransparency") == nil then
                    v29:SetAttribute("OrigTransparency", v29.Transparency)
                end
            elseif (v29:IsA("PointLight") or (v29:IsA("SpotLight") or v29:IsA("SurfaceLight"))) and v29:GetAttribute("OrigBrightness") == nil then
                v29:SetAttribute("OrigBrightness", v29.Brightness)
            end
        end
    end
end
local function u33(p31) --[[ Line: 130 ]]
    for _, v32 in ipairs(p31:GetDescendants()) do
        if v32:GetAttribute("FreezeFX") ~= false then
            if (v32:IsA("Decal") or v32:IsA("Texture")) and v32.Name ~= "face" then
                v32.Transparency = 1
            elseif v32:IsA("PointLight") or (v32:IsA("SpotLight") or v32:IsA("SurfaceLight")) then
                v32.Enabled = true
                v32.Brightness = 0
            end
        end
    end
end
local function u42(p34, p35) --[[ Line: 153 ]]
    local v36 = p34.Keypoints
    if #v36 == 0 then
        return 0, 0
    end
    if p35 <= v36[1].Time then
        return v36[1].Value, v36[1].Envelope
    end
    if v36[#v36].Time <= p35 then
        return v36[#v36].Value, v36[#v36].Envelope
    end
    for v37 = 1, #v36 - 1 do
        local v38 = v36[v37]
        local v39 = v36[v37 + 1]
        if v38.Time <= p35 and p35 <= v39.Time then
            local v40 = v39.Time - v38.Time
            local v41 = v40 <= 0 and 0 or (p35 - v38.Time) / v40
            return v38.Value + (v39.Value - v38.Value) * v41, v38.Envelope + (v39.Envelope - v38.Envelope) * v41
        end
    end
    return v36[#v36].Value, v36[#v36].Envelope
end
local function u47(p43) --[[ Line: 173 ]]
    local v44 = table.create(#p43.Keypoints)
    for v45, v46 in ipairs(p43.Keypoints) do
        v44[v45] = NumberSequenceKeypoint.new(v46.Time, 1, v46.Envelope)
    end
    return NumberSequence.new(v44)
end
local function u59(p48, p49, p50) --[[ Line: 181 ]]
    --[[
    Upvalues:
        [1] = u42
    --]]
    local v51 = p49.Keypoints
    local v52 = table.create(#v51)
    for v53, v54 in ipairs(v51) do
        local v55, v56 = u42(p48, v54.Time)
        local v57, v58 = u42(p49, v54.Time)
        v52[v53] = NumberSequenceKeypoint.new(v54.Time, v55 + (v57 - v55) * p50, v56 + (v58 - v56) * p50)
    end
    return NumberSequence.new(v52)
end
local function u67(u60, u61, u62, p63) --[[ Line: 198 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u59
    --]]
    u60.Transparency = u61
    local u64 = Instance.new("NumberValue")
    u64.Value = 0
    local v65 = u1:Create(u64, TweenInfo.new(p63, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Value"] = 1
    })
    local u66 = u64:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 209 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u59
            [3] = u61
            [4] = u62
            [5] = u64
        --]]
        u60.Transparency = u59(u61, u62, u64.Value)
    end)
    v65.Completed:Connect(function() --[[ Line: 212 ]]
        --[[
        Upvalues:
            [1] = u66
            [2] = u64
            [3] = u60
            [4] = u62
        --]]
        if u66 then
            u66:Disconnect()
        end
        u64:Destroy()
        u60.Transparency = u62
    end)
    v65:Play()
    return v65
end
function v2.start(_, u68) --[[ Line: 234 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u67
        [3] = u47
        [4] = u27
        [5] = u30
        [6] = u33
        [7] = u3
        [8] = u1
        [9] = u4
        [10] = u20
    --]]
    local v69 = script:FindFirstChild("Rig")
    local v70 = u68.Humanoid
    local v71 = u68.HumanoidRootPart.CFrame
    v70.EvaluateStateMachine = false
    local v72 = script:FindFirstChild("Storm"):Clone()
    v72.CFrame = CFrame.lookAt(v71.Position + v71.RightVector * 10, v71.Position)
    v72.Parent = workspace.Effects
    for _, v73 in v72:GetChildren() do
        if v73:IsA("Beam") then
            local v74 = u5[v73]
            if v74 == nil then
                v74 = v73.Transparency
                u5[v73] = v74
            end
            u67(v73, u47(v74), v74, 0.5)
        end
    end
    _G.PlaySound(v71, script.Blizzard)
    task.wait(0.15)
    u27(v69, u68)
    u30(u68)
    u33(u68)
    task.spawn(function() --[[ Line: 257 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u68
            [3] = u1
            [4] = u4
        --]]
        for _, v75 in ipairs(u3) do
            local v76 = u68:FindFirstChild(v75, true)
            if v76 and v76:IsA("BasePart") then
                for _, v77 in ipairs(script.fx:GetChildren()) do
                    if v77:IsA("ParticleEmitter") then
                        local v78 = v77:Clone()
                        v78.Parent = v76
                        v78.Enabled = true
                        v78:Emit(v78:GetAttribute("EmitCount"))
                        v78:SetAttribute("FreezeFX", true)
                    end
                end
                for _, v79 in ipairs(v76:GetDescendants()) do
                    if v79:GetAttribute("FreezeFX") ~= false then
                        if (v79:IsA("Decal") or v79:IsA("Texture")) and v79.Name ~= "face" then
                            u1:Create(v79, u4, {
                                ["Transparency"] = v79:GetAttribute("OrigTransparency") or 0
                            }):Play()
                        elseif v79:IsA("PointLight") or (v79:IsA("SpotLight") or v79:IsA("SurfaceLight")) then
                            local v80 = v79:GetAttribute("OrigBrightness") * 0.5
                            v79.Enabled = true
                            u1:Create(v79, u4, {
                                ["Brightness"] = v80
                            }):Play()
                        end
                    end
                end
            end
            task.wait(0.07)
        end
    end)
    task.wait(1)
    for _, v81 in ipairs(v72:GetDescendants()) do
        if v81:IsA("ParticleEmitter") then
            u1:Create(v81, TweenInfo.new(1.5), {
                ["Rate"] = 0
            }):Play()
        end
    end
    for _, v82 in v72:GetChildren() do
        if v82:IsA("Beam") then
            local v83 = u5[v82]
            if v83 == nil then
                v83 = v82.Transparency
                u5[v82] = v83
            end
            local v84 = u47(v83)
            u67(v82, v82.Transparency, v84, 1.5)
        end
    end
    _G.destroy(v72, 3)
    task.wait(1.65)
    local v85 = script.Burst:Clone()
    v85:PivotTo(u68.HumanoidRootPart.CFrame * CFrame.new(0, -2.7, 0))
    v85.Parent = workspace.Effects
    _G.customEmit(v85)
    _G.destroy(v85, 3)
    u20(u68)
    local v86 = {}
    for _, v87 in ipairs(u68:GetDescendants()) do
        if (v87:IsA("BasePart") or v87:IsA("Decal")) and v87.Transparency ~= 1 then
            v86[v87] = v87.Transparency
            _G.tween(v87, {
                0.1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Transparency"] = 1
            })
        end
    end
    local v88 = script.Rocks:GetChildren()
    for _ = 1, 10 do
        local v89 = v88[math.random(1, #v88)]:Clone()
        v89.Position = u68.HumanoidRootPart.Position
        v89.CanCollide = false
        v89.Anchored = false
        v89.CollisionGroup = "Players"
        v89.Name = "Debris"
        local v90 = math.random(-360, 360)
        local v91 = math.random(-360, 360)
        local v92 = math.random
        v89.Orientation = Vector3.new(v90, v91, v92(-360, 360))
        v89.CanCollide = true
        v89.Size = v89.Size * (math.random(70, 110) / 100)
        v89.Parent = workspace.Effects
        local v93 = math.random(-20, 20)
        local v94 = math.random(10, 35)
        local v95 = math.random
        v89.AssemblyLinearVelocity = Vector3.new(v93, v94, v95(-20, 20)) * (math.random(50, 145) / 100)
        v89.AssemblyAngularVelocity = v89.CFrame.LookVector * 10
        u1:Create(v89, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1), {
            ["Transparency"] = 1
        }):Play()
        for _, v96 in v89:GetChildren() do
            u1:Create(v96, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1), {
                ["Transparency"] = 1
            }):Play()
        end
        _G.destroy(v89, 5)
    end
end
return v2