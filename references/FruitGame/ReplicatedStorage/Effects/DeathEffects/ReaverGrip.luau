 

local v1 = {}
game:GetService("Lighting")
local u2 = game:GetService("TweenService")
local u3 = Random.new()
function TrailFade(u4, p5)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u6 = Instance.new("NumberValue")
    u6:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u6
        --]]
        u4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u6.Value), NumberSequenceKeypoint.new(1, u6.Value) })
    end)
    u6.Value = 0
    u2:Create(u6, TweenInfo.new(p5, Enum.EasingStyle.Linear), {
        ["Value"] = 1
    }):Play()
end
function BeamFade(p7, p8, p9)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = next
    local v11, v12 = p7:GetDescendants()
    for _, u13 in v10, v11, v12 do
        if u13:IsA("Beam") then
            if p8 then
                local v14 = u13.Width0
                local v15 = u13.Width1
                u13.Width0 = 0
                u13.Width1 = 0
                local u16 = u13.Transparency.Keypoints[2].Time
                local v17 = u13.Transparency.Keypoints[2].Value
                local u18 = Instance.new("NumberValue")
                u18:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 41 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u16
                        [3] = u18
                    --]]
                    u13.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(u16, u18.Value), NumberSequenceKeypoint.new(1, 1) })
                end)
                u18.Value = 1
                u2:Create(u18, TweenInfo.new(u16, Enum.EasingStyle.Linear), {
                    ["Value"] = v17
                }):Play()
                u2:Create(u13, TweenInfo.new(u16, Enum.EasingStyle.Linear), {
                    ["Width0"] = v14,
                    ["Width1"] = v15
                }):Play()
            else
                local u19 = Instance.new("NumberValue")
                local u20 = u13.Transparency.Keypoints[2].Time
                local v21 = u13.Transparency.Keypoints[2].Value
                u19:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 61 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u20
                        [3] = u19
                    --]]
                    u13.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(u20, u19.Value), NumberSequenceKeypoint.new(1, 1) })
                end)
                u19.Value = v21
                u2:Create(u19, TweenInfo.new(p9, Enum.EasingStyle.Linear), {
                    ["Value"] = 1
                }):Play()
                u2:Create(u13, TweenInfo.new(p9, Enum.EasingStyle.Linear), {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                }):Play()
            end
        end
    end
end
function v1.start(_, u22, _) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    _G.PlaySound(u22.PrimaryPart, script["Audio/SoulFlamesGrip (1)"])
    local _, v23, _ = _G.getRayFloor(u22.PrimaryPart.CFrame, 5)
    local v24 = (u22.PrimaryPart.Position - v23).Magnitude
    local v25 = script.Floor:Clone()
    v25.Position = u22.HumanoidRootPart.Position - Vector3.new(0, v24, 0)
    v25.Parent = workspace.Effects
    local u26 = Instance.new("Color3Value")
    u26.Value = Color3.fromRGB(57, 29, 121)
    local u27 = Instance.new("NumberValue")
    u27.Value = 11
    local u28 = Instance.new("NumberValue")
    u28.Value = 15
    local u29 = Instance.new("NumberValue")
    u29.Value = 0
    local u30 = Instance.new("NumberValue")
    u30.Value = 0.5
    tick()
    local function v63(p31) --[[ Line: 109 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u28
            [3] = u27
            [4] = u2
            [5] = u26
            [6] = u30
            [7] = u29
        --]]
        local u32 = script.Trail:Clone()
        u32.Attachment.Trail.Lifetime = u3:NextNumber(0.1, 0.6)
        local u33 = Instance.new("NumberValue")
        u33.Value = u3:NextNumber(0, 360)
        u33.Parent = u32
        local u34 = Instance.new("NumberValue")
        u34.Value = u3:NextNumber(u28.Value - 2, u28.Value + 2)
        u34.Parent = u32
        local u35 = Instance.new("NumberValue")
        u35.Value = u3:NextNumber(u27.Value - 2, u27.Value + 2)
        u35.Parent = u32
        local v36 = u3:NextNumber(0, 360)
        local v37 = math.rad(v36)
        local v38 = math.cos(v37) * u3:NextNumber(4, 6)
        local v39 = math.rad(v36)
        local v40 = math.sin(v39) * u3:NextNumber(4, 6)
        local u41 = p31.HumanoidRootPart.Position + Vector3.new(v38, -5, v40)
        local v42 = u3:NextNumber(0.6, 0.9)
        u2:Create(u33, TweenInfo.new(v42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Value"] = u33.Value + u3:NextNumber(100, 170)
        }):Play()
        u2:Create(u34, TweenInfo.new(v42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Value"] = 0
        }):Play()
        u2:Create(u35, TweenInfo.new(v42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Value"] = 0
        }):Play()
        local v43 = u33.Value
        local v44 = math.rad(v43)
        local v45 = math.cos(v44) * u34.Value
        local v46 = u33.Value
        local v47 = math.rad(v46)
        local v48 = math.sin(v47) * u34.Value
        local v49 = u41.X + v45
        local v50 = u41.Y + u35.Value
        local v51 = u41.Z + v48
        u32.Position = Vector3.new(v49, v50, v51)
        u32.Parent = workspace.Effects
        u33:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 145 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u34
                [3] = u35
                [4] = u32
                [5] = u41
                [6] = u26
                [7] = u30
                [8] = u29
            --]]
            local v52 = u33.Value
            local v53 = math.rad(v52)
            local v54 = math.cos(v53) * u34.Value
            local v55 = u33.Value
            local v56 = math.rad(v55)
            local v57 = math.sin(v56) * u34.Value
            local v58 = u35.Value
            local v59 = u32
            local v60 = u41.X + v54
            local v61 = u41.Y + v58
            local v62 = u41.Z + v57
            v59.Position = Vector3.new(v60, v61, v62)
            u32.Attachment.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u26.Value), ColorSequenceKeypoint.new(1, u26.Value) })
            u32.Attachment.Trail.Brightness = u30.Value
            u32.Attachment.Trail.LightEmission = u29.Value
        end)
        task.delay(0.5, function() --[[ Line: 163 ]]
            --[[
            Upvalues:
                [1] = u32
            --]]
            TrailFade(u32.Attachment.Trail, 0.25)
            task.wait(0.25)
            u32:Destroy()
        end)
    end
    u2:Create(u26, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Value"] = Color3.fromRGB(102, 34, 157)
    }):Play()
    u2:Create(u27, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Value"] = 25
    }):Play()
    u2:Create(u28, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Value"] = 9
    }):Play()
    for v64 = 1, 23 do
        v63(u22)
        task.wait(1 / (v64 / 0.4))
    end
    task.wait(0.2)
    u2:Create(u30, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Value"] = 10
    }):Play()
    u2:Create(u29, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Value"] = 0.5
    }):Play()
    local v65 = script.Floor2:Clone()
    v65.Position = u22.HumanoidRootPart.Position - Vector3.new(0, v24, 0)
    v65.Parent = workspace.Effects
    BeamFade(v65, true, 0.25)
    local u66 = true
    task.spawn(function() --[[ Line: 193 ]]
        --[[
        Upvalues:
            [1] = u66
            [2] = u22
            [3] = u3
            [4] = u26
            [5] = u2
            [6] = u30
            [7] = u29
        --]]
        while u66 do
            local u67 = script.Trail:Clone()
            local v68 = u22.HumanoidRootPart.Position
            local v69 = u3:NextNumber(-6, 6)
            local v70 = u3
            u67.Position = v68 + Vector3.new(v69, -3, v70:NextNumber(-6, 6))
            u67.Parent = workspace.Effects
            u67.Attachment.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u26.Value), ColorSequenceKeypoint.new(1, u26.Value) })
            u67.Attachment.Trail.Lifetime = u3:NextNumber(0.25, 0.67)
            local u71 = Instance.new("Vector3Value")
            u71.Value = u67.Position
            u71.Parent = u67
            local v72 = u3:NextNumber(0.9, 1.75)
            local v73 = u2
            local v74 = TweenInfo.new(v72)
            local v75 = {}
            local v76 = u71.Value
            local v77 = u3:NextNumber(-10, 10)
            local v78 = u3:NextNumber(50, 75)
            local v79 = u3
            v75.Value = v76 + Vector3.new(v77, v78, v79:NextNumber(-10, 10))
            v73:Create(u71, v74, v75):Play()
            local u80 = Instance.new("NumberValue")
            u80.Value = 0
            u80.Parent = u67
            local v81 = u2
            local v82 = TweenInfo.new(v72)
            local v83 = {
                ["Value"] = u3:NextNumber(10, 20)
            }
            v81:Create(u80, v82, v83):Play()
            u71:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 220 ]]
                --[[
                Upvalues:
                    [1] = u67
                    [2] = u71
                    [3] = u80
                    [4] = u26
                    [5] = u30
                    [6] = u29
                --]]
                local v84 = u67
                local v85 = u71.Value.X
                local v86 = u80.Value
                local v87 = v85 + math.sin(v86)
                local v88 = u71.Value.Y
                local v89 = u71.Value.Z
                local v90 = u80.Value
                local v91 = v89 + math.cos(v90)
                v84.Position = Vector3.new(v87, v88, v91)
                u67.Attachment.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u26.Value), ColorSequenceKeypoint.new(1, u26.Value) })
                u67.Attachment.Trail.Brightness = u30.Value
                u67.Attachment.Trail.LightEmission = u29.Value
            end)
            task.delay(v72 - 0.25, function() --[[ Line: 236 ]]
                --[[
                Upvalues:
                    [1] = u67
                --]]
                TrailFade(u67.Attachment.Trail, 0.25)
                task.wait(0.25)
                u67:Destroy()
            end)
            task.wait()
        end
    end)
    task.wait(1)
    local v92 = script.Hand:Clone()
    v92:SetPrimaryPartCFrame(u22.PrimaryPart.CFrame * CFrame.new(0, 3, -3.25) * CFrame.Angles(0, 3.141592653589793, 0))
    v92.Parent = workspace.Effects
    v92.AnimationController:LoadAnimation(script.Grab):Play()
    for _ = 1, 15 do
        local v93 = u22.PrimaryPart.Position
        local v94 = u3:NextNumber(-3, 3)
        local v95 = u3
        local v96 = v93 + Vector3.new(v94, 0.25, v95:NextNumber(-3, 3))
        local v97 = u22.Head.Position.X
        local v98 = v96.Y
        local v99 = u22.Head.Position.Z
        local v100 = Vector3.new(v97, v98, v99)
        local v101 = CFrame.new(v96, v100)
        local v102 = u3:NextNumber(-8, 8)
        local u103 = script.Hand2:Clone()
        local v104 = next
        local v105, v106 = u103:GetDescendants()
        for _, v107 in v104, v105, v106 do
            if v107:IsA("BasePart") then
                v107.Size = v107.Size + Vector3.new(0, v102, 0)
            end
        end
        u103:SetPrimaryPartCFrame(v101)
        u103.Parent = workspace.Effects
        u103.AnimationController:LoadAnimation(script.Grab):Play()
        task.delay(1.2, function() --[[ Line: 276 ]]
            --[[
            Upvalues:
                [1] = u103
            --]]
            u103:Destroy()
        end)
    end
    task.wait(0.95)
    u22.PrimaryPart.Anchored = true
    u2:Create(u22.PrimaryPart, TweenInfo.new(0.25), {
        ["CFrame"] = u22.PrimaryPart.CFrame * CFrame.new(0, -6, 0)
    }):Play()
    task.wait(0.25)
    v92:Destroy()
    local v108 = next
    local v109, v110 = v25:GetDescendants()
    for _, v111 in v108, v109, v110 do
        if v111:IsA("ParticleEmitter") then
            v111.Enabled = false
        end
    end
    local v112 = next
    local v113, v114 = v65:GetDescendants()
    for _, v115 in v112, v113, v114 do
        if v115:IsA("ParticleEmitter") then
            v115.Enabled = false
        end
    end
    BeamFade(v65, false, 1.5)
    u66 = false
    task.wait(2.5)
    v25:Destroy()
    v65:Destroy()
end
return v1