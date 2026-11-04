 

local v1 = {}
local u2 = script.Parent.Assets.X
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local u4 = game:GetService("TweenService")
local u5 = game:GetService("Lighting")
local u6 = game["Run Service"]
local u7 = workspace.CurrentCamera
local u8 = u5:WaitForChild("Atmosphere")
local u9 = require(game.ReplicatedStorage.Modules.CameraShaker)
local function u18(p10, ...) --[[ Line: 13 ]]
    local v11 = { ... }
    local v12 = #v11 - 2
    if v12 >= 0 then
        local v13 = nil
        for v14 = 1, #v11 do
            local v15 = v12 + 1
            local v16 = (v14 == 1 or v14 == #v11) and 1 or v15
            local v17 = (1 - p10) ^ (v12 + 1 - (v14 - 1)) * p10 ^ (v12 - (-v14 + v12 + 1)) * v16 * v11[v14]
            if v13 then
                v13 = v13 + v17
            else
                v13 = v17
            end
        end
        return v13
    end
    warn("Not enough Points")
end
local function u22(p19) --[[ Line: 39 ]]
    local v20 = p19:GetDescendants()
    for v21 = 1, #v20 do
        if v20[v21]:IsA("BillboardGui") or v20[v21]:IsA("Tool") then
            v20[v21]:Destroy()
        end
    end
end
local function u106(p23, p24) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u22
        [4] = u4
        [5] = u9
        [6] = u7
        [7] = u5
        [8] = u8
        [9] = u6
        [10] = u18
    --]]
    p23.Archivable = true
    p24.Archivable = true
    local u25 = u3.new()
    local u26 = script.bubble:Clone()
    u26.Parent = workspace.Effects
    _G.customEmit(u26)
    u25:AddTask(u26)
    u25:AddTask(game["Run Service"].RenderStepped:Connect(function(_) --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        u26.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, -1, -1)
    end))
    local u27 = p23:Clone()
    local u28 = p24:Clone()
    local u29 = u2.UI:Clone()
    local u30 = u2.SwimTrail:Clone()
    local v31 = u29.MainFrame.ImpactFrames:GetChildren()
    local u32 = {}
    for v33 = 1, #v31 do
        v31[v33].Size = UDim2.new(0, 1, 0, 1)
        v31[v33].Position = UDim2.new(0, 1, 0, 1)
    end
    u29.Parent = game.Players.LocalPlayer.PlayerGui
    task.spawn(function() --[[ Line: 77 ]]
        --[[
        Upvalues:
            [1] = u29
        --]]
        local v34 = { u29 }
        game:GetService("ContentProvider"):PreloadAsync(v34)
    end)
    local v35 = u29:WaitForChild("MainFrame")
    local v36 = v35:WaitForChild("Black")
    local u37 = v35:WaitForChild("White")
    local u38 = v35:WaitForChild("ImpactFrames")
    local u39 = v35:WaitForChild("SpeedLines")
    local u40 = u2.CutsceneCameraRig:Clone()
    u40:PivotTo(u27.HumanoidRootPart.CFrame)
    u40.Parent = workspace.Effects
    local v41 = u2.Domain:Clone()
    local u42 = u2.Blood_Exploding.Attachment:Clone()
    u42.Parent = u28.UpperTorso
    local u43 = u2.Impact_CC:Clone()
    u43.Parent = workspace.CurrentCamera
    local u44 = u27:WaitForChild("HumanoidRootPart")
    local v45 = u28:WaitForChild("HumanoidRootPart")
    u22(u27)
    u22(u28)
    u27.Archivable = false
    u28.Archivable = false
    u44.Anchored = true
    v45.Anchored = true
    u30.Parent = workspace.Effects
    local v46 = Instance.new("Weld")
    v46.Part0 = u27.UpperTorso
    v46.Part1 = u30
    v46.Parent = u30
    u27:PivotTo(CFrame.new(0, 3000, 0))
    u28:PivotTo(u27.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3.25) * CFrame.Angles(0, 3.141592653589793, 0))
    u40:PivotTo(u27.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, 0))
    v41:PivotTo(u27.HumanoidRootPart.CFrame)
    u25:AddTask(u27)
    u25:AddTask(u28)
    u25:AddTask(u40)
    u25:AddTask(v41)
    u25:AddTask(u29)
    u25:AddTask(u30)
    u25:AddTask(u43)
    _G.PlayEffect("CameraHideUI", nil, true)
    v36.BackgroundTransparency = 0
    u4:Create(v36, TweenInfo.new(3.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
        ["BackgroundTransparency"] = 1
    }):Play()
    u28.Humanoid.EvaluateStateMachine = false
    u27.Humanoid.EvaluateStateMachine = false
    u27.Parent = workspace.Effects
    u28.Parent = workspace.Effects
    u40.Parent = workspace.Effects
    v41.Parent = workspace.Effects
    local u47 = u27.Humanoid:LoadAnimation(u2.AnimCutscene_Character)
    local u48 = u28.Humanoid:LoadAnimation(u2.AnimCutscene_Target)
    local u49 = u40.AnimationController:LoadAnimation(u40.Animation)
    tick()
    _G.particleEnabled(u27.PrimaryPart, false)
    task.wait(0.25)
    u29["Audio/FishKUltCombo"]:Play()
    local function u54(p50) --[[ Line: 169 ]]
        --[[
        Upvalues:
            [1] = u39
        --]]
        local v51 = tick()
        local v52 = p50 or 0.6
        while true do
            for v53 = 1, 2 do
                u39:WaitForChild(v53).Visible = true
                task.wait(0.1)
                u39:WaitForChild(v53).Visible = false
            end
            if v52 <= tick() - v51 then
                return
            end
        end
    end
    u47:Play()
    u48:Play()
    tick()
    u49:Play()
    u47.TimePosition = 0
    u48.TimePosition = 0
    u49.TimePosition = 0
    local u56 = u9.new(Enum.RenderPriority.Camera.Value, function(p55) --[[ Line: 190 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u40
        --]]
        u7.CFrame = u40.Cam.CFrame * CFrame.new(0, 1, 3) * p55
    end, true)
    u56.PositionInfluence = Vector3.new(2, 2, 2)
    u56:Start()
    u56:StartShake(1, 2, 0.04)
    local u57 = {
        ["Ambient"] = u5.Ambient,
        ["Brightness"] = u5.Brightness,
        ["ColorShift_Bottom"] = u5.ColorShift_Bottom,
        ["ColorShift_Top"] = u5.ColorShift_Top,
        ["OutdoorAmbient"] = u5.OutdoorAmbient
    }
    local u58 = {
        ["Density"] = u8.Density,
        ["Offset"] = u8.Offset,
        ["Color"] = u8.Color,
        ["Decay"] = u8.Decay,
        ["Glare"] = u8.Glare,
        ["Haze"] = u8.Haze
    }
    local v59 = {
        ["Ambient"] = Color3.fromRGB(89, 189, 255),
        ["Brightness"] = 1,
        ["ColorShift_Bottom"] = Color3.new(0, 0, 0),
        ["ColorShift_Top"] = Color3.fromRGB(149, 218, 255),
        ["OutdoorAmbient"] = Color3.fromRGB(147, 230, 255)
    }
    local v60 = {
        ["Density"] = 0.326,
        ["Offset"] = 0,
        ["Color"] = Color3.fromRGB(133, 212, 255),
        ["Decay"] = Color3.fromRGB(255, 255, 255),
        ["Glare"] = 0.1,
        ["Haze"] = 10
    }
    u4:Create(u5, TweenInfo.new(0), v59):Play()
    u4:Create(u8, TweenInfo.new(0), v60):Play()
    u7.FieldOfView = 60
    u4:Create(u7, TweenInfo.new(1), {
        ["FieldOfView"] = 70
    }):Play()
    u25:AddTask(u47.KeyframeReached:Connect(function(p61) --[[ Line: 243 ]]
        --[[
        Upvalues:
            [1] = u47
            [2] = u48
            [3] = u49
            [4] = u4
            [5] = u7
            [6] = u38
            [7] = u43
            [8] = u30
            [9] = u2
            [10] = u27
            [11] = u28
            [12] = u56
            [13] = u25
            [14] = u6
            [15] = u44
            [16] = u42
            [17] = u54
            [18] = u18
            [19] = u37
            [20] = u32
            [21] = u5
            [22] = u57
            [23] = u8
            [24] = u58
        --]]
        if p61 == "ImpactFrame" then
            u47:AdjustSpeed(0.3)
            u48:AdjustSpeed(0.3)
            u49:AdjustSpeed(0.3)
            u4:Create(u7, TweenInfo.new(0.5), {
                ["FieldOfView"] = 55
            }):Play()
            task.wait(0.4)
            task.spawn(function() --[[ Line: 253 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                for v62 = 1, 6 do
                    u38:WaitForChild(v62).Size = UDim2.new(1, 0, 1, 0)
                    u38:WaitForChild(v62).Position = UDim2.new(0, 0, 0, 0)
                    task.wait(0.042)
                    u38:WaitForChild(v62).Visible = false
                end
            end)
            u43.Enabled = true
            u47:AdjustSpeed(0.1)
            u48:AdjustSpeed(0.1)
            u49:AdjustSpeed(0.1)
            task.wait(0.01)
            u47:AdjustSpeed(1)
            u48:AdjustSpeed(1)
            u49:AdjustSpeed(1)
            task.wait(0.1)
            u47:AdjustSpeed(0.2)
            u48:AdjustSpeed(0.2)
            u49:AdjustSpeed(0.2)
            task.wait(0.252)
            for _, v63 in u30:GetDescendants() do
                if v63:IsA("ParticleEmitter") or v63:IsA("Trail") then
                    v63.Enabled = false
                end
            end
            task.delay(0, function() --[[ Line: 281 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u27
                    [3] = u28
                    [4] = u4
                    [5] = u7
                    [6] = u56
                    [7] = u38
                    [8] = u25
                    [9] = u6
                    [10] = u44
                    [11] = u43
                --]]
                local u64 = u2.HitEmit.Attachment:Clone()
                u64.WorldCFrame = CFrame.new(u27.UpperTorso.Position, u28.UpperTorso.Position) * CFrame.new(0, 0, -2) * CFrame.Angles(0, -0.24434609527920614, 0)
                u64.Parent = workspace.Terrain
                _G.destroy(u64, 5)
                _G.customEmit(u64)
                _G.particleEnabled(u64, false)
                u4:Create(u7, TweenInfo.new(0.4), {
                    ["FieldOfView"] = 80
                }):Play()
                task.delay(1.7, function() --[[ Line: 295 ]]
                    --[[
                    Upvalues:
                        [1] = u56
                        [2] = u38
                        [3] = u4
                        [4] = u7
                        [5] = u64
                        [6] = u27
                        [7] = u28
                        [8] = u2
                        [9] = u25
                        [10] = u6
                        [11] = u44
                    --]]
                    u56:StartShake(6, 0.5, 0.025, Vector3.new(1, 1, 1), Vector3.new(3, 3, 3))
                    u56:ShakeOnce(3, 0.5, 0.0215, 0.5, Vector3.new(0.4, 0.4, 0.4), Vector3.new(6, 6, 6))
                    task.spawn(function() --[[ Line: 299 ]]
                        --[[
                        Upvalues:
                            [1] = u38
                        --]]
                        for v65 = 6, 13 do
                            u38:WaitForChild(v65).Size = UDim2.new(1, 0, 1, 0)
                            u38:WaitForChild(v65).Position = UDim2.new(0, 0, 0, 0)
                            task.wait(0.042)
                            u38:WaitForChild(v65).Visible = false
                        end
                    end)
                    u4:Create(u7, TweenInfo.new(0.4), {
                        ["FieldOfView"] = 100
                    }):Play()
                    u64.WorldCFrame = CFrame.new(u27.UpperTorso.Position, u28.UpperTorso.Position) * CFrame.new(0, 0, -10) * CFrame.Angles(0, 0.4363323129985824, 0)
                    local v66 = u2.Small_Explosion.Attachment:Clone()
                    v66.WorldCFrame = u64.WorldCFrame
                    v66.Parent = workspace.Terrain
                    _G.destroy(v66, 5)
                    _G.customEmit(v66)
                    _G.particleEnabled(v66, false)
                    local v67 = u2.Small_Explosion.Attachment:Clone()
                    v67.WorldCFrame = u64.WorldCFrame
                    v67.Parent = workspace.Terrain
                    _G.destroy(v67, 5)
                    _G.customEmit(v67)
                    _G.particleEnabled(v67, false)
                    local u68 = 0
                    local u69 = {}
                    local u70 = tick()
                    u25:AddTask(u6.Heartbeat:Connect(function(p71) --[[ Line: 333 ]]
                        --[[
                        Upvalues:
                            [1] = u68
                            [2] = u69
                            [3] = u64
                            [4] = u70
                        --]]
                        u68 = u68 + 1 * p71
                        for v72, v73 in u69 do
                            local v74 = u64.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
                            local v75 = CFrame.Angles
                            local v76 = v72 * 120 - u68 * 750
                            v73.CFrame = v74 * v75(0, math.rad(v76), 0) * CFrame.new(0, 25 * ((tick() - u70) * 0.4), -7 - 25 * ((tick() - u70) * 3))
                        end
                    end))
                    for _ = 1, 3 do
                        local v77 = u2.CurveCharge_Soar:Clone()
                        v77.CFrame = u44.CFrame
                        v77.Parent = workspace.Effects
                        _G.destroy(v77, 2.5)
                        table.insert(u69, v77)
                    end
                    task.delay(0.4, function() --[[ Line: 349 ]]
                        --[[
                        Upvalues:
                            [1] = u69
                            [2] = u4
                        --]]
                        for _, v78 in u69 do
                            for _, v79 in v78:GetDescendants() do
                                if v79:IsA("ParticleEmitter") or v79:IsA("Trail") then
                                    v79.Enabled = false
                                elseif v79:IsA("Sound") and v79.IsPlaying then
                                    u4:Create(v79, TweenInfo.new(1), {
                                        ["Volume"] = 0
                                    }):Play()
                                end
                            end
                        end
                    end)
                    local v80 = u2.tornado:Clone()
                    v80:PivotTo(u64.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0))
                    v80.Parent = workspace.Effects
                    _G.destroy(v80, 5)
                    for _, u81 in v80:GetChildren() do
                        if u81.Name ~= "root" then
                            local u82 = u81.Size
                            u81.Size = Vector3.new(0, 0, 0)
                            if u81.Name == "Shock" then
                                u4:Create(u81, TweenInfo.new(0.9), {
                                    ["CFrame"] = u81.CFrame * CFrame.new(0, 0, 14) * CFrame.Angles(3.141592653589793, 0, 0),
                                    ["Size"] = u82 * 1.3,
                                    ["Transparency"] = 1
                                }):Play()
                            elseif u81.Name == "SwirlLinger" then
                                u4:Create(u81, TweenInfo.new(1), {
                                    ["CFrame"] = u81.CFrame * CFrame.Angles(3.141592653589793, 0, 0),
                                    ["Size"] = u82 * 1.3,
                                    ["Transparency"] = 1
                                }):Play()
                            elseif u81.Name == "slashswirl" or u81.Name == "Multi" then
                                u4:Create(u81, TweenInfo.new(1.2), {
                                    ["CFrame"] = u81.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                                    ["Size"] = u82 * 1.3,
                                    ["Transparency"] = 1
                                }):Play()
                            elseif u81.Name == "tornado1" or u81.Name == "tornado2" then
                                u4:Create(u81, TweenInfo.new(1.5), {
                                    ["CFrame"] = u81.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                                    ["Size"] = u82 * 1.3,
                                    ["Transparency"] = 1
                                }):Play()
                            elseif u81.Name == "FirstSwoosh" then
                                local u83 = u81.Mesh.Scale
                                u81.Mesh.Scale = Vector3.new(0, 0, 0)
                                task.delay(0.2, function() --[[ Line: 413 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u4
                                        [2] = u81
                                        [3] = u82
                                        [4] = u83
                                    --]]
                                    u4:Create(u81, TweenInfo.new(0.45), {
                                        ["CFrame"] = u81.CFrame * CFrame.new(5, 0, 5) * CFrame.Angles(0, -0.6108652381980153, 0),
                                        ["Size"] = u82 * 1.3
                                    }):Play()
                                    u4:Create(u81.Mesh, TweenInfo.new(0.4), {
                                        ["Scale"] = u83 * 1.25
                                    }):Play()
                                    u4:Create(u81.Decal, TweenInfo.new(0.4), {
                                        ["Transparency"] = 1
                                    }):Play()
                                end)
                            end
                        end
                    end
                    local v84 = u2.Small_Explosion.Attachment:Clone()
                    v84.WorldCFrame = u64.WorldCFrame
                    v84.Parent = workspace.Terrain
                    _G.destroy(v84, 5)
                    _G.customEmit(v84)
                    _G.particleEnabled(v84, false)
                end)
                u43.Enabled = true
                task.wait(0.07)
                u43.Contrast = 20
                task.wait(0.07)
                u43.Enabled = false
            end)
            u47:AdjustSpeed(0.2)
            u48:AdjustSpeed(0.2)
            u49:AdjustSpeed(0.2)
            u56:StartShake(6, 0.5, 0.025, Vector3.new(1, 1, 1), Vector3.new(1.75, 1.75, 1.75))
            u4:Create(u7, TweenInfo.new(0.5), {
                ["FieldOfView"] = 70
            }):Play()
            task.wait(1)
            task.delay(0.5, function() --[[ Line: 458 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u30
                --]]
                u56:StopSustained(0.5)
                for _, v85 in u30:GetChildren() do
                    if v85.Name == "SurgeBubble" then
                        v85.Enabled = true
                    end
                end
                task.wait(0.6)
                for _, v86 in u30:GetChildren() do
                    if v86.Name == "SurgeBubble" then
                        v86.Enabled = false
                    end
                end
                task.wait(1)
                for _, v87 in u30:GetChildren() do
                    if v87.Name == "SurgeBubble" then
                        v87.Enabled = true
                    end
                end
            end)
            u4:Create(u7, TweenInfo.new(2), {
                ["FieldOfView"] = 45
            }):Play()
            u47:AdjustSpeed(1)
            u48:AdjustSpeed(1)
            u49:AdjustSpeed(1)
            return
        end
        if p61 == "Hit" then
            _G.customEmit(u42)
            u4:Create(u7, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, 0, true), {
                ["FieldOfView"] = 64
            }):Play()
            u56:ShakeOnce(3, 0.5, 0.0215, 0.5, Vector3.new(0.4, 0.4, 0.4), Vector3.new(11, 11, 11))
            u54(0.1)
            return
        end
        if p61 ~= "FistCharge" then
            if p61 == "BubbleTrail" then
                for _, v88 in u30:GetChildren() do
                    if string.find(v88.Name, "Trail") or v88.Name == "SurgeBubble" then
                        v88.Enabled = true
                    end
                end
                task.wait(0.28)
                for _, v89 in u30:GetChildren() do
                    if string.find(v89.Name, "Trail") or v89.Name == "SurgeBubble" then
                        v89.Enabled = false
                    end
                end
                return
            elseif p61 == "Transition" then
                task.delay(0.35, u54, 2)
                task.wait(1.4)
                _G.particleEnabled(u30, false)
            elseif p61 == "TheEnd" then
                u47:AdjustSpeed(0.8)
                u48:AdjustSpeed(0.8)
                u49:AdjustSpeed(0.8)
                u4:Create(u37, TweenInfo.new(0.7), {
                    ["BackgroundTransparency"] = 0
                }):Play()
                task.wait(0.7)
                u4:Create(u37, TweenInfo.new(0.8), {
                    ["BackgroundTransparency"] = 1
                }):Play()
                u4:Create(u7, TweenInfo.new(0.25), {
                    ["FieldOfView"] = 70
                }):Play()
                u56:StopSustained(0.5)
                u56:Stop()
                u56 = nil
                for _, v90 in u32 do
                    v90.Enabled = true
                end
                u32 = nil
                u4:Create(u5, TweenInfo.new(0.25), u57):Play()
                u4:Create(u8, TweenInfo.new(0.25), u58):Play()
            end
        end
        task.delay(0.4, function() --[[ Line: 508 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u7
            --]]
            u4:Create(u7, TweenInfo.new(0.5), {
                ["FieldOfView"] = 85
            }):Play()
        end)
        local v91 = u2.Charge:Clone()
        v91.Parent = workspace.Effects
        local v92 = Instance.new("Weld")
        v92.Part0 = u27.RightHand
        v92.Part1 = v91
        v92.Parent = v91
        _G.particleEnabled(v91, true)
        local v93 = tick()
        task.delay(0.5, function() --[[ Line: 529 ]]
            --[[
            Upvalues:
                [1] = u30
            --]]
            for _, v94 in u30:GetChildren() do
                if v94.Name == "SurgeBubble" then
                    v94.Enabled = true
                end
            end
        end)
        local u95 = u27.UpperTorso
        local v96 = 0
        while true do
            if tick() - v96 >= 0.1 and tick() - v93 <= 1.2 then
                v96 = tick()
                task.spawn(function() --[[ Line: 540 ]]
                    --[[
                    Upvalues:
                        [1] = u95
                        [2] = u2
                        [3] = u27
                        [4] = u18
                    --]]
                    local v97 = u95.Position
                    local v98 = Random.new():NextNumber(-2, 2)
                    local v99 = Random.new():NextNumber(-3, 3)
                    local v100 = Random.new()
                    local v101 = v97 + Vector3.new(v98, v99, v100:NextNumber(-2, 2)) * Random.new():NextNumber(5, 7)
                    local v102 = u2.CurveCharge:Clone()
                    v102.CFrame = CFrame.new(v101) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                    v102.Parent = workspace.Effects
                    _G.destroy(v102, 1.5)
                    local v103 = 0
                    repeat
                        local v104 = v103 + task.wait() * 7
                        v103 = math.clamp(v104, 0, 1)
                        local v105 = {
                            [1] = v102.Position,
                            [1] = v102.CFrame * CFrame.new(1.35, 0, -1.6).Position,
                            [2] = v102.CFrame * CFrame.new(2.7, 0, -3.2).Position,
                            [3] = v102.CFrame * CFrame.new(4.050000000000001, 0, -4.800000000000001).Position,
                            [#v105 + 1] = u27.RightHand.Position
                        }
                        v102.Position = u18(v103, unpack(v105))
                    until v103 == 1
                    _G.particleEnabled(v102, false)
                end)
            end
            task.wait()
            if tick() - v93 >= 1.6 then
                _G.particleEnabled(v91, false)
                _G.destroy(v91, 5)
                return
            end
        end
    end))
    task.wait(10.58)
    if u56 then
        u56:StopSustained(0.5)
        u56:Stop()
    end
    _G.PlayEffect("CameraHideUI", nil, false)
    u25:Destroy()
end
function v1.start(_, u107, p108, p109, p110) --[[ Line: 647 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u6
        [4] = u4
        [5] = u106
    --]]
    if _G.checkRenderDistance(u107.PrimaryPart.Position) == false then
        return
    else
        task.spawn(function() --[[ Line: 653 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v111 = { u2 }
            game:GetService("ContentProvider"):PreloadAsync(v111)
        end)
        local u112 = u107.PrimaryPart
        local u113 = u3.new()
        local v114 = u3.new()
        tick()
        local u115 = Instance.new("Model")
        u115.Parent = workspace.Effects
        local u116 = RaycastParams.new()
        u116.FilterType = Enum.RaycastFilterType.Include
        u116.FilterDescendantsInstances = p110
        local u117 = u2.SharkRig:Clone()
        u117:ScaleTo(0.001)
        u117.Parent = u115
        u117.AnimationController.Animator:LoadAnimation(u117.Idle):Play(0.4)
        local u118 = u117.PrimaryPart.GroundAttach
        _G.particleEnabled(u117, true, true)
        local v119 = _G.PlaySound(u117.PrimaryPart, script["Audio/FishKSharkBombStart"])
        v119.Parent = u117.PrimaryPart
        task.spawn(function() --[[ Line: 691 ]]
            --[[
            Upvalues:
                [1] = u117
            --]]
            local v120 = tick()
            while true do
                local v121 = (tick() - v120) * 1
                u117:ScaleTo((math.clamp(v121, 0.01, 1)))
                if v121 >= 1 then
                    break
                end
                task.wait()
            end
        end)
        local v122 = {}
        local u123 = {}
        local u124 = nil
        local u125 = 0
        local u126 = {}
        local u127 = 0
        local u128 = 0
        local u129 = 0
        for _, v130 in u107:GetDescendants() do
            if v130:IsA("BasePart") and v130.Transparency < 1 then
                v122[v130] = v130.Transparency
            end
        end
        local u131 = tick()
        local _ = u112.CFrame * CFrame.new(0, 0, -8).Position
        local v132 = CFrame.new(u112.Position, p108).LookVector * 225
        local u133 = workspace:Raycast(u112.Position, CFrame.new(u112.Position, p108).LookVector * 275, u116)
        if u133 then
            local _ = u133.Position
        else
            local _ = CFrame.new(u112.Position, p108) * CFrame.new(0, 0, -275).Position
        end
        u112.Anchored = true
        local u134 = {
            ["Acceleration"] = Vector3.new(0, 0, 0),
            ["VelocityThreshold"] = 25,
            ["Gravity"] = Vector3.new(0, -200, 0),
            ["Duration"] = 5,
            ["Velocity"] = v132,
            ["Size"] = 2,
            ["Length"] = 4
        }
        local v135 = u2.CurveCharge_Soar:Clone()
        v135.CFrame = u112.CFrame
        table.insert(u123, v135)
        local v136 = u2.CurveCharge_Soar:Clone()
        v136.CFrame = u112.CFrame
        table.insert(u123, v136)
        local v137 = u107.Humanoid:LoadAnimation(script.charLoop)
        v137:Play()
        u113:AddTask(u6.Heartbeat:Connect(function(p138) --[[ Line: 745 ]]
            --[[
            Upvalues:
                [1] = u125
                [2] = u126
                [3] = u124
                [4] = u123
                [5] = u112
                [6] = u115
                [7] = u129
                [8] = u2
                [9] = u4
                [10] = u116
                [11] = u113
                [12] = u127
                [13] = u128
                [14] = u118
            --]]
            u125 = u125 + 1 * p138
            for _, v139 in u126 do
                local v140 = v139.CFrame
                local v141 = CFrame.Angles
                local v142 = 1650 * p138
                v139.CFrame = v140 * v141(0, math.rad(v142), 0)
            end
            if not u124 then
                for v143, v144 in u123 do
                    local v145 = u112.CFrame
                    local v146 = CFrame.Angles
                    local v147 = v143 * 180 + u125 * 450
                    v144.CFrame = v145 * v146(1.5707963267948966, math.rad(v147), 0) * CFrame.new(0, 15, -25)
                    v144.Parent = u115
                end
                if tick() - u129 >= 0.14 then
                    u129 = tick()
                    local v148 = u2.WindBurst:Clone()
                    v148.CFrame = u112.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v149 = v148.Mesh
                    v149.Scale = v149.Scale * 1.5
                    v148.Decal.Transparency = 0.5
                    v148.Parent = u115
                    local v150 = u126
                    table.insert(v150, v148)
                    u4:Create(v148.Mesh, TweenInfo.new(0.6), {
                        ["Scale"] = v148.Mesh.Scale * 1.5
                    }):Play()
                    u4:Create(v148.Decal, TweenInfo.new(0.8), {
                        ["Transparency"] = 1
                    }):Play()
                    local v151 = workspace:Raycast(u112.Position, Vector3.new(0, -35, 0), u116)
                    if v151 then
                        local v152 = u2.GroundSmokeTrail_Beam.Origin:Clone()
                        v152.Parent = workspace.Terrain
                        u113:AddTask(v152)
                        for _, u153 in v152:GetDescendants() do
                            if u153:IsA("Beam") then
                                local v154 = u153.Width0
                                local v155 = u153.Width1
                                u153.Width0 = 0
                                u153.Width1 = 0
                                u4:Create(u153, TweenInfo.new(0.8), {
                                    ["Width0"] = v154,
                                    ["Width1"] = v155
                                }):Play()
                                task.spawn(function() --[[ Line: 799 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u153
                                    --]]
                                    local v156 = tick()
                                    while true do
                                        local v157 = (tick() - v156) * 2
                                        u153.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4, v157), NumberSequenceKeypoint.new(1, 1) })
                                        if v157 >= 1 then
                                            break
                                        end
                                        task.wait()
                                    end
                                end)
                            elseif u153:IsA("Attachment") then
                                if u153.Name == "A" or u153.Name == "B" then
                                    u4:Create(u153, TweenInfo.new(1), {
                                        ["Position"] = u153.Position * 1.25
                                    }):Play()
                                elseif u153.Name == "L" or u153.Name == "R" then
                                    u4:Create(u153, TweenInfo.new(1), {
                                        ["Position"] = u153.Position * 1.5
                                    }):Play()
                                end
                            end
                        end
                        v152.WorldCFrame = CFrame.lookAt(v151.Position, v151.Position + v151.Normal, u112.CFrame.LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -1, 0)
                        for _, v158 in v152:GetChildren() do
                            local v159 = workspace:Raycast(v158.WorldPosition + Vector3.new(0, 4, 0), Vector3.new(0, -45, 0), u116)
                            if v159 then
                                local v160 = v159.Position.X
                                local v161 = v159.Position.Y
                                local v162 = v159.Position.Z
                                v158.WorldPosition = Vector3.new(v160, v161, v162) + Vector3.new(0, 2, 0)
                            end
                        end
                    end
                end
                if tick() - u127 >= 0.4 then
                    u127 = tick()
                    local v163 = u2.Shockwave:Clone()
                    v163.CFrame = u112.CFrame * CFrame.new(0, 0, -12) * CFrame.Angles(0, -1.5707963267948966, 0)
                    local v164 = v163.Mesh
                    v164.Scale = v164.Scale * 3.5
                    v163.Parent = workspace.Effects
                    _G.destroy(v163, 1)
                    u4:Create(v163.Mesh, TweenInfo.new(0.6), {
                        ["Scale"] = v163.Mesh.Scale * 1.5
                    }):Play()
                    u4:Create(v163, TweenInfo.new(1), {
                        ["CFrame"] = v163.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
                    }):Play()
                    u4:Create(v163.Decal, TweenInfo.new(0.8), {
                        ["Transparency"] = 1
                    }):Play()
                end
                local _ = tick() - u128 >= 0.3
                local v165 = workspace:Raycast(u112.Position, Vector3.new(0, -125, 0), u116)
                if v165 then
                    u118.WorldCFrame = CFrame.new(v165.Position, v165.Position + v165.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                end
                for _, v166 in u118:GetDescendants() do
                    if v166:IsA("ParticleEmitter") then
                        v166.Enabled = v165 and true or false
                    end
                end
            end
        end))
        v114:AddTask(u6.Heartbeat:Connect(function(p167) --[[ Line: 903 ]]
            --[[
            Upvalues:
                [1] = u124
                [2] = u131
                [3] = u134
                [4] = u112
                [5] = u116
                [6] = u107
                [7] = u133
                [8] = u117
            --]]
            if u124 ~= true then
                local v168 = tick() - u131
                local v169 = math.min(v168, 1)
                local v170 = u134
                local v171 = v169 * -255
                v170.Gravity = Vector3.new(0, v171, 0)
                local v172 = u134
                v172.Duration = v172.Duration - p167
                local v173 = u134
                v173.Acceleration = v173.Acceleration + u134.Gravity * p167 * math.max(0.1, v169)
                local v174 = u134
                v174.Velocity = v174.Velocity + u134.Acceleration * p167 * math.max(0.1, v169)
                local v175 = u134.Velocity.Unit * math.max(0.25, v169)
                local v176 = u134.Velocity.Magnitude
                local v177 = math.min(v176, 300)
                local v178 = u134.VelocityThreshold
                local v179 = math.max(v177, v178) * p167 * math.max(0.25, v169)
                local v180 = math.max(2, v179)
                local v181 = workspace:Raycast(u112.Position, v175 * v180, u116)
                if (v181 or u134.Duration <= 0) and (v181 and v181.Instance) then
                    local v182 = v181.Instance
                    if not v182:IsDescendantOf(u107) and v182.CanCollide or u134.Duration <= 0 then
                        u124 = true
                        u133 = v181
                        local v183 = v181.Normal * 3
                        local v184 = v181.Position + v183
                        local v185 = CFrame.new(v184, v184 + u134.Velocity.Unit * 9999)
                        if v185 == v185 then
                            u107:PivotTo(v185)
                        end
                        return
                    end
                end
                u107:PivotTo(CFrame.new(u112.Position + v175 * v180, u112.Position + u134.Velocity.Unit * 9999))
                u107.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                u107.PrimaryPart.Velocity = Vector3.new()
                u117:PivotTo(CFrame.new(u112.Position, u112.Position + v175) * CFrame.new(0, v169 * 12, v169 * 5 + -5) * CFrame.Angles(1.5707963267948966, 0, 0))
            end
        end))
        local v186 = os.clock()
        repeat
            task.wait()
        until u124 or (p109:GetAttribute("targetSelected") ~= nil or os.clock() - v186 > 7)
        if u124 or p109:GetAttribute("targetSelected") ~= nil then
            u124 = true
            v114:Destroy()
            for v187, v188 in v122 do
                v187.Transparency = v188
            end
            for _, v189 in u117:GetDescendants() do
                if v189:IsA("ParticleEmitter") or v189:IsA("Trail") then
                    v189.Enabled = false
                elseif v189:IsA("BasePart") then
                    u4:Create(v189, TweenInfo.new(0.5), {
                        ["Size"] = v189.Size * 1.25,
                        ["Transparency"] = 1
                    }):Play()
                elseif v189:IsA("Beam") then
                    u4:Create(v189, TweenInfo.new(0.5), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end
            end
            for _, v190 in u123 do
                _G.particleEnabled(v190, false)
            end
            local v191 = u2.Explode:Clone()
            v191.CFrame = u133 and CFrame.new(u133.Position, u133.Position + u133.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0) or u112.CFrame
            v191.Parent = u115
            _G.destroy(v191, 5)
            _G.customEmit(v191)
            _G.particleEnabled(v191, false)
            _G.PlaySound(v191, script["Audio/FishKSharkBombBoom"])
            v137:Stop()
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v191.Position + Vector3.new(0, 5, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 2,
                ["TweenDuration"] = 2,
                ["Radius"] = 35,
                ["Direction"] = Vector3.new(0, -15, 0)
            })
            if v119 then
                u4:Create(v119, TweenInfo.new(0.25), {
                    ["Volume"] = 0
                }):Play()
            end
            if p109:GetAttribute("targetSelected") == nil then
                local v192 = os.clock()
                repeat
                    task.wait()
                until p109:GetAttribute("targetSelected") ~= nil or os.clock() - v192 > 12
                if p109:GetAttribute("targetSelected") == nil then
                    warn("TIMEOUT: LeviathanPlunge second yield expired")
                    u113:Destroy()
                    for v193, v194 in v122 do
                        if v193 and v193.Parent then
                            v193.Transparency = v194
                        end
                    end
                    v137:Stop()
                    u112.Anchored = false
                    _G.destroy(u115, 0)
                    return
                end
            end
            local v195 = p109.Value
            if v195 then
                _G.destroy(u115, 13)
                if u107 == game.Players.LocalPlayer.Character or v195 == game.Players.LocalPlayer.Character then
                    tick()
                    u106(u107, v195)
                end
            end
            if p109.Value == nil then
                task.wait(0.25)
            end
            u112.Anchored = false
            task.wait(3)
            u113:Destroy()
            _G.destroy(u115, 3)
        else
            warn("TIMEOUT: LeviathanPlunge first yield expired")
            v114:Destroy()
            u113:Destroy()
            for v196, v197 in v122 do
                if v196 and v196.Parent then
                    v196.Transparency = v197
                end
            end
            v137:Stop()
            u112.Anchored = false
            _G.destroy(u115, 0)
        end
    end
end
return v1