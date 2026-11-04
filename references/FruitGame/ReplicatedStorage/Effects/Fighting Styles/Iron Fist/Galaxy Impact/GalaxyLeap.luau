 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = workspace.CurrentCamera
local u4 = Random.new()
require(script.Parent.GalaxyImpactLightning)
local u5 = script["galaxy impact"]
local v6 = RaycastParams.new()
v6.FilterType = Enum.RaycastFilterType.Include
v6.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u23(u7, p8) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u1
    --]]
    local u9 = u5.Shockwave:Clone()
    u9.CFrame = u7
    u9.Parent = workspace.Effects
    local u10 = TweenInfo.new(1)
    local v11 = NumberSequence.new(0.95)
    task.spawn(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u10
            [3] = u1
            [4] = u9
            [5] = u7
        --]]
        local v12 = u4:NextNumber(0, 2) * 3.141592653589793
        for v13 = 1, 5 do
            local v14 = u10.Time / 5
            local v15 = v13 / 5
            u1:Create(u9, TweenInfo.new(v14, Enum.EasingStyle.Linear), {
                ["CFrame"] = u7 * CFrame.Angles(0, v12 * v15, 0)
            }):Play()
            task.wait(v14)
        end
    end)
    for _, v16 in u9:GetChildren() do
        local v17 = v16["1"]
        local v18 = v16["2"]
        local v19 = v16.Beam
        v19.Color = ColorSequence.new(p8)
        v19.Width0 = 0
        v19.Width1 = 0
        v19.Transparency = v11
        v19.CurveSize0 = 13.333333333333336
        v19.CurveSize1 = 13.333333333333336
        v19.TextureLength = math.random(100, 150) / 100
        u1:Create(v19, u10, {
            ["CurveSize0"] = -66.66666666666667,
            ["CurveSize1"] = 66.66666666666667,
            ["TextureLength"] = 1
        }):Play()
        u1:Create(v19, TweenInfo.new(u10.Time / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
            ["Width0"] = 300,
            ["Width1"] = 300
        }):Play()
        local v20 = v16.Name == "Attachment" and Vector3.new(1, 0, 0) or Vector3.new(0, 0, 0)
        v17.Position = v20 + Vector3.new(0, 0, 10)
        v18.Position = -(v20 + Vector3.new(0, 0, 10))
        for _, v21 in { v17, v18 } do
            local v22 = v21 == v17 and 1 or -1
            u1:Create(v21, u10, {
                ["Position"] = v16.Position + Vector3.new(0, 0, 50) * v22
            }):Play()
        end
    end
    _G.destroy(u9, u10.Time)
end
return {
    ["start"] = function(_, u24, p25, u26, p27) --[[ Name: start, Line 105 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
            [3] = u5
            [4] = u4
            [5] = u23
            [6] = u2
        --]]
        local u28 = p25 or Color3.new(1, 0.611765, 0.223529)
        local u29 = u24.HumanoidRootPart
        local u30 = u24.Humanoid
        local v31 = u30.Animator
        local u32 = p27.animSpeed
        local v33 = v31:LoadAnimation(script.jump)
        v33:Play()
        v33:AdjustSpeed(u32)
        _G.PlaySound(u24.PrimaryPart, script["1GalaxyImpactStartJump"]).Parent = u24.PrimaryPart
        local u34 = nil
        tick()
        local u35 = {}
        local function u46(p36) --[[ Line: 130 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u24
                [3] = u34
                [4] = u1
                [5] = u28
                [6] = u26
            --]]
            if u35[p36] then
                return
            else
                u35[p36] = true
                if p36 == "woosh" then
                    _G.PlaySound(u24.PrimaryPart, script["3GalaxyImpactPunchWhoosh"])
                    task.wait(1.3)
                    u34 = script.Air_Resistance:Clone()
                    u34.CFrame = u24.RightHand.CFrame
                    local u37 = Instance.new("Weld")
                    u37.Part0 = u34
                    u37.Part1 = u24.RightHand
                    u37.Parent = u34
                    u34.Parent = workspace.Effects
                    _G.particleEnabled(u34, false)
                    _G.destroy(u34, 0.75)
                    for _, u38 in u34:GetDescendants() do
                        if u38:IsA("Beam") then
                            u1:Create(u38, TweenInfo.new(0.375, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Width0"] = u38.Width0 * 2,
                                ["Width1"] = u38.Width1 * 2
                            }):Play()
                            task.delay(0.375, function() --[[ Line: 155 ]]
                                --[[
                                Upvalues:
                                    [1] = u1
                                    [2] = u38
                                --]]
                                u1:Create(u38, TweenInfo.new(0.375, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    ["TextureSpeed"] = u38.TextureSpeed * 2,
                                    ["Width0"] = 0,
                                    ["Width1"] = 0,
                                    ["CurveSize0"] = u38.CurveSize0 * 5,
                                    ["CurveSize1"] = u38.CurveSize1 * 5
                                }):Play()
                                u1:Create(u38.Attachment1, TweenInfo.new(0.375, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    ["Position"] = u38.Attachment1.Position * 5 + Vector3.new(15, 0, 0)
                                }):Play()
                            end)
                        end
                    end
                    task.wait(0.375)
                    local u44 = game["Run Service"].Heartbeat:Connect(function(p39) --[[ Line: 163 ]]
                        --[[
                        Upvalues:
                            [1] = u37
                        --]]
                        local v40 = u37
                        local v41 = v40.C0
                        local v42 = CFrame.Angles
                        local v43 = 400 * p39
                        v40.C0 = v41 * v42(0, math.rad(v43), 0)
                    end)
                    task.delay(0.75, function() --[[ Line: 167 ]]
                        --[[
                        Upvalues:
                            [1] = u44
                        --]]
                        u44:Disconnect()
                        u44 = nil
                    end)
                else
                    local v45 = u24.RightHand.CFrame
                    _G.PlayEffect("GalaxyShoot", nil, u24, v45.Position, v45.Position - Vector3.new(0, 100, 0), u28, u26)
                end
            end
        end
        v33:GetMarkerReachedSignal("woosh"):Connect(function() --[[ Line: 179 ]]
            --[[
            Upvalues:
                [1] = u46
            --]]
            u46("woosh")
        end)
        v33:GetMarkerReachedSignal("shoot"):Connect(function() --[[ Line: 183 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u24
                [3] = u28
                [4] = u26
            --]]
            if not u35.shoot then
                u35.shoot = true
                local v47 = u24.RightHand.CFrame
                _G.PlayEffect("GalaxyShoot", nil, u24, v47.Position, v47.Position - Vector3.new(0, 100, 0), u28, u26)
            end
        end)
        task.delay(7.8 / u32, function() --[[ Line: 187 ]]
            --[[
            Upvalues:
                [1] = u46
            --]]
            u46("woosh")
        end)
        task.delay(9.1 / u32, function() --[[ Line: 191 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u24
                [3] = u28
                [4] = u26
            --]]
            if not u35.shoot then
                u35.shoot = true
                local v48 = u24.RightHand.CFrame
                _G.PlayEffect("GalaxyShoot", nil, u24, v48.Position, v48.Position - Vector3.new(0, 100, 0), u28, u26)
            end
        end)
        local u49 = game.Players.LocalPlayer.Character == u24
        task.spawn(function() --[[ Line: 197 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u29
                [3] = u32
                [4] = u30
                [5] = u3
                [6] = u26
            --]]
            if game.Players.LocalPlayer.Character == u24 ~= false then
                local v50 = script.NormalCam:Clone()
                local v51 = v50.AnimationController.Animator
                v50:PivotTo(u29.CFrame)
                v50.Parent = workspace.Effects
                local v52 = v51:LoadAnimation(script.camera)
                v52:Play()
                v52:AdjustSpeed(u32)
                local v53 = tick()
                _G.PlayEffect("CameraHideUI", nil, true)
                u30.AutoRotate = false
                u3.CameraType = Enum.CameraType.Scriptable
                local _ = u29.CFrame - u29.CFrame.Position
                while tick() - v53 < 11.74 do
                    v50:PivotTo(u29.CFrame)
                    u3.CFrame = v50.Cam.CFrame
                    game["Run Service"].RenderStepped:Wait()
                end
                u3.CameraType = Enum.CameraType.Custom
                v50:Destroy()
                _G.PlayEffect("CameraHideUI", nil, false)
                u30.AutoRotate = true
                if u26 then
                    u26:FireServer("over")
                end
                warn(tick() - v53)
            end
        end)
        local _ = u29.Position
        local v54 = p27.Goal
        local v55 = (u29.Position - v54).Magnitude / 1000
        local _ = v55 / 15
        os.clock()
        local v56 = u5.Charge:Clone()
        local v57 = u5.Aura:Clone()
        _G.recolorParticles(v56, u28, "hakiColor")
        _G.recolorParticles(v57, u28, "hakiColor")
        v56:SetPrimaryPartCFrame(CFrame.new(u24.UpperTorso.Position))
        local v58, v59, v60 = _G.getRayFloor(u24.PrimaryPart.CFrame, 8)
        local v61 = v59 + Vector3.new(0, 0.1, 0)
        if v58 then
            local v62 = u5.LeapVFX:Clone()
            v62:SetPrimaryPartCFrame(CFrame.new(v61, v61 + v60) * CFrame.Angles(1.5707963267948966, 0, 0))
            _G.recolorParticles(v62, u28, "hakiColor")
            v62.Parent = workspace.Effects
            _G.customEmit(v62)
            _G.destroy(v62, 5)
            v56.Part.Position = v61
        else
            local v63 = u24.PrimaryPart.Position
            local v64 = u24.Humanoid.HipHeight * 2
            local v65 = v63 - Vector3.new(0, v64, 0)
            v56.Part.Position = v65
        end
        local v66 = Instance.new("Weld")
        v66.Part0 = v56.PrimaryPart
        v66.Part1 = u24.UpperTorso
        v66.Parent = v56.PrimaryPart
        v56.Part2.Position = u24.PrimaryPart.Position
        v56.Parent = workspace.Effects
        v57.CFrame = u29.CFrame
        v57.Parent = workspace.Effects
        _G.particleEnabled(v57, false)
        local v67 = Instance.new("Weld")
        v67.Part0 = v57
        v67.Part1 = u29
        v67.Parent = v57
        _G.particleEnabled(v56, true)
        task.wait(0.75)
        _G.particleEnabled(v56, false)
        task.delay(2.6, _G.particleEnabled, v57, false)
        local v68 = u5.Trail:Clone()
        _G.recolorParticles(v68, u28, "hakiColor")
        v68.CFrame = u24.PrimaryPart.CFrame
        local v69 = Instance.new("Weld")
        v69.Part0 = v68
        v69.Part1 = u24.UpperTorso
        v69.Parent = v68
        v68.Parent = workspace.Effects
        local v70 = Instance.new("Highlight")
        v70.FillTransparency = -1
        v70.OutlineTransparency = -1
        v70.FillColor = u28
        v70.OutlineColor = u28
        v70.Parent = u24
        _G.tween(v70, {
            v55,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        })
        _G.destroy(v70, v55)
        u1:Create(u29, TweenInfo.new(v55, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            ["CFrame"] = CFrame.new(v54)
        }):Play()
        _G.PlaySound(u24.PrimaryPart, script.JumpPeak).Parent = u24.PrimaryPart
        local u71 = u28
        local v72 = 0
        while v72 <= v55 do
            v72 = v72 + task.wait()
        end
        _G.PlayEffect("TweenParticles", nil, v68, NumberSequence.new(0), 0.25)
        _G.particleEnabled(v68, false, true)
        _G.destroy(v68, 3)
        _G.particleEnabled(v57, false)
        _G.destroy(v56, 3)
        local u73 = u5.Scene:Clone()
        u73:PivotTo(CFrame.new(u29.Position) * CFrame.new(0, 75, 0) * CFrame.Angles(1.5707963267948966, 0, 0))
        _G.recolorParticles(u73, u71, "hakiColor")
        _G.recolorParticles(u73.Beams.Attachment.Attachment, ColorSequence.new({ ColorSequenceKeypoint.new(0, u71), ColorSequenceKeypoint.new(0.75, u71), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), "hakiColor")
        task.wait(0.25)
        _G.PlaySound(u24.PrimaryPart, script.PreStar).Parent = u24.PrimaryPart
        local u74 = {
            Color3.fromRGB(186, 85, 211),
            Color3.fromRGB(138, 43, 226),
            Color3.fromRGB(135, 206, 250),
            Color3.fromRGB(144, 238, 144),
            Color3.fromRGB(255, 255, 224),
            Color3.fromRGB(255, 165, 79),
            Color3.fromRGB(255, 102, 102)
        }
        local u75 = 0
        task.spawn(function() --[[ Line: 408 ]]
            --[[
            Upvalues:
                [1] = u74
                [2] = u4
                [3] = u24
                [4] = u5
                [5] = u1
                [6] = u75
            --]]
            for u76 = 1, #u74 do
                local u77 = u4:NextNumber(0.25, 0.35)
                u4:NextNumber(3, 7)
                local u78 = u74[u76]
                local u79 = u24.RightHand.Position
                local u80 = u5.StarTrail:Clone()
                local u81 = u80.Part
                for _, v82 in u80:GetDescendants() do
                    if v82:IsA("ParticleEmitter") or v82:IsA("Trail") then
                        v82.Color = ColorSequence.new(u74[u76])
                    end
                end
                task.spawn(function() --[[ Line: 422 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u1
                        [3] = u79
                        [4] = u24
                        [5] = u81
                        [6] = u80
                        [7] = u77
                        [8] = u5
                        [9] = u78
                        [10] = u76
                        [11] = u74
                        [12] = u75
                    --]]
                    local u83 = 6.283185307179586 * math.random()
                    local u84 = math.random(100, 120)
                    local u85 = u4:NextNumber(0.2, 1.5)
                    local v86 = u4:NextNumber(-150, 150)
                    math.rad(v86)
                    local v87 = u4:NextNumber(-150, 150)
                    math.rad(v87)
                    local u88 = u4:NextNumber(-100, 100)
                    local function v93(p89) --[[ Line: 430 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u84
                            [3] = u79
                            [4] = u24
                            [5] = u85
                            [6] = u83
                            [7] = u88
                        --]]
                        local v90 = u1:GetValue(p89, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                        local v91 = 1 - v90
                        local v92 = u84 * v91
                        u79 = u24.RightHand.Position
                        return (CFrame.new(u79) * CFrame.Angles(0, u85 * 3.141592653589793 * v90 + u83, 0) * CFrame.new(0, u88 * v91, -v92)).Position
                    end
                    u81.Position = v93(0)
                    u80.Parent = workspace.Effects
                    local v94 = 0
                    while v94 <= 1 do
                        local v95 = task.wait()
                        v94 = v94 + v95 / u77
                        u1:Create(u81, TweenInfo.new(v95, Enum.EasingStyle.Linear), {
                            ["CFrame"] = CFrame.new(v93(v94), (v93(v94 + v95))),
                            ["Size"] = Vector3.new(25, 25, 125) * (1 - v94)
                        }):Play()
                        local v96 = 1 - v94
                        u81.Trail.WidthScale = NumberSequence.new(v96 * 2, 0)
                    end
                    local v97 = u5.starFinished:Clone()
                    _G.recolorParticles(v97, u78)
                    local v98 = u24.RightHand.CFrame
                    local v99 = CFrame.Angles
                    local v100 = math.random(0, 360)
                    local v101 = math.rad(v100)
                    local v102 = math.random(0, 360)
                    local v103 = math.rad(v102)
                    local v104 = math.random(0, 360)
                    v97.CFrame = v98 * v99(v101, v103, (math.rad(v104)))
                    if u76 >= #u74 then
                        _G.scaleParticle(v97, 4, true)
                    end
                    v97.Parent = workspace.Effects
                    _G.customEmit(v97)
                    _G.destroy(v97, 4)
                    u80:Destroy()
                    u75 = u75 + 1
                    if u75 == 1 then
                        _G.PlaySound(v97, script.FirstStarA)
                    elseif u75 == #u74 then
                        _G.PlaySound(v97, script.LastStarA)
                    else
                        _G.PlaySound(v97, script.otherstars, {
                            ["Pitch"] = (u75 - 1) * 0.05 + 1
                        })
                    end
                    local v105 = Instance.new("Highlight")
                    v105.FillTransparency = -1
                    v105.OutlineTransparency = -1
                    v105.FillColor = u78
                    v105.OutlineColor = u78
                    v105.Parent = u24
                    _G.tween(v105, {
                        0.25,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["OutlineTransparency"] = 1,
                        ["FillTransparency"] = 1
                    })
                    _G.destroy(v105, 0.25)
                end)
                task.wait(u77 / 2)
            end
        end)
        repeat
            task.wait()
        until #u74 <= u75
        local u106 = u5.AuraColorable:Clone()
        _G.recolorParticles(u106, u71, "hakiColor")
        u106.PrimaryPart.CFrame = u24.RightHand.CFrame
        u106.Parent = workspace.Effects
        _G.customEmit(u73.Beams.emit)
        local v107 = Instance.new("Weld")
        v107.Part0 = u106.PrimaryPart
        v107.Part1 = u24.RightHand
        v107.Parent = u106.PrimaryPart
        _G.customEmit(u106.PrimaryPart)
        local u108 = u5.Aura2:Clone()
        u108.CFrame = u29.CFrame
        local u109 = Instance.new("Weld")
        u109.Part0 = u108
        u109.Part1 = u24.HumanoidRootPart
        u109.Parent = u108
        _G.recolorParticles(u108, u71, "hakiColor")
        u108.Parent = workspace.Effects
        for _, v110 in u106:GetDescendants() do
            if v110:IsA("ParticleEmitter") then
                v110:SetAttribute("OriginalZOffset", v110.ZOffset)
            end
        end
        local u122 = game["Run Service"].Heartbeat:Connect(function(p111) --[[ Line: 536 ]]
            --[[
            Upvalues:
                [1] = u109
                [2] = u29
                [3] = u49
                [4] = u106
            --]]
            local v112 = u109
            local v113 = v112.C0
            local v114 = CFrame.Angles
            local v115 = 50 * p111
            v112.C0 = v113 * v114(0, math.rad(v115), 0)
            local v116 = (u29.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
            local v117 = math.clamp(v116, 0, 200)
            local v118 = v117 / 25
            local v119 = math.max(1, v118)
            if u49 == false then
                for _, v120 in u106:GetDescendants() do
                    if v120:IsA("ParticleEmitter") then
                        v120.ZOffset = v119 > 1 and v120:GetAttribute("OriginalZOffset") + v117 or v120:GetAttribute("OriginalZOffset")
                        local v121 = v120.ZOffset
                        v120.ZOffset = math.clamp(v121, -50, 50)
                    end
                end
                u106:ScaleTo(v119)
            end
        end)
        task.spawn(function() --[[ Line: 556 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u29
                [3] = u4
                [4] = u71
            --]]
            for _ = 1, 30 do
                local v123 = u23
                local v124 = u29.CFrame
                local v125 = CFrame.Angles
                local v126 = u4:NextNumber(-35, 35)
                local v127 = math.rad(v126)
                local v128 = 6.283185307179586 * math.random()
                local v129 = u4:NextNumber(-35, 35)
                v123(v124 * v125(v127, v128, (math.rad(v129))), u71)
                task.wait(0.16666666666666666)
            end
        end)
        task.delay(6, function() --[[ Line: 567 ]]
            --[[
            Upvalues:
                [1] = u106
                [2] = u108
                [3] = u122
            --]]
            for _, v130 in u106:GetDescendants() do
                if v130:IsA("ParticleEmitter") then
                    _G.tween(v130, {
                        0.25,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = NumberSequence.new(0)
                    })
                end
            end
            _G.particleEnabled(u108, false)
            _G.PlayEffect("TweenParticles", nil, u108, NumberSequence.new(0), 0.25)
            local v131 = { u106, u108 }
            _G.destroy(v131, 2)
            task.wait(2)
            u122:Disconnect()
            u122 = nil
        end)
        _G.particleEnabled(u73, false)
        _G.particleEnabled(u73.Part.AttachmentMain.BottomParticles, true)
        if u49 == false then
            _G.particleEnabled(u73.StarySky, true)
        end
        u73.Parent = workspace.Effects
        task.spawn(function() --[[ Line: 590 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u1
                [3] = u73
            --]]
            local v132 = u5.Scene:GetScale()
            local v133 = 0
            while v133 <= 1 do
                v133 = v133 + task.wait() / 2
                u73:ScaleTo(u1:GetValue(v133, Enum.EasingStyle.Quint, Enum.EasingDirection.Out) * v132)
            end
        end)
        local u134 = workspace.Terrain.Clouds
        local u135 = u134.Cover
        local u136 = u134.Density
        local u137 = u134.Color
        local u138 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v139 = {}
        for _, v140 in ipairs(u73:GetDescendants()) do
            if v140:IsA("ParticleEmitter") and v140.Parent ~= u73.StarySky then
                v140.TimeScale = 1
                u1:Create(v140, TweenInfo.new(0.4, u138.EasingStyle), {
                    ["TimeScale"] = v140.TimeScale
                }):Play()
            elseif v140:IsA("Beam") then
                u1:Create(v140, u138, {
                    ["Width0"] = v140:GetAttribute("Width0"),
                    ["Width1"] = v140:GetAttribute("Width1")
                }):Play()
                local v141 = u1:Create(v140, u138, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
                table.insert(v139, v141)
            end
        end
        local v142, v143
        if u49 == true then
            local u144 = u5.StarySky:Clone()
            _G.particleEnabled(u144, true)
            _G.customEmit(u144)
            u144.Parent = workspace.Effects
            v142 = u2.RenderStepped:Connect(function() --[[ Line: 637 ]]
                --[[
                Upvalues:
                    [1] = u144
                    [2] = u3
                --]]
                u144.Position = Vector3.new(0, 100, 0) + u3.CFrame.Position
            end)
            v143 = u144
        else
            v143 = nil
            v142 = nil
        end
        if game.Lighting.Atmosphere:GetAttribute("galaxyImpact") == nil then
            local u145 = game.Lighting.Atmosphere.Color
            local u146 = game.Lighting.Atmosphere.Decay
            game.Lighting.Atmosphere:SetAttribute("galaxyImpact", true)
            u1:Create(game.Lighting.Atmosphere, u138, {
                ["Color"] = Color3.fromRGB(0, 0, 0),
                ["Decay"] = Color3.fromRGB(0, 0, 0)
            }):Play()
            u1:Create(u134, TweenInfo.new(1), {
                ["Cover"] = 1,
                ["Density"] = 1,
                ["Color"] = Color3.fromRGB(0, 0, 0)
            }):Play()
            task.delay(6, function() --[[ Line: 651 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u138
                    [3] = u145
                    [4] = u146
                    [5] = u134
                    [6] = u135
                    [7] = u136
                    [8] = u137
                --]]
                local v147 = {
                    ["Color"] = u145,
                    ["Decay"] = u146
                }
                u1:Create(game.Lighting.Atmosphere, u138, v147):Play()
                local v148 = {
                    ["Cover"] = u135,
                    ["Density"] = u136,
                    ["Color"] = u137
                }
                u1:Create(u134, TweenInfo.new(1), v148):Play()
                task.delay(u138.Time, function() --[[ Line: 655 ]]
                    game.Lighting.Atmosphere:SetAttribute("galaxyImpact", nil)
                end)
            end)
        end
        task.wait(6)
        if v143 then
            _G.particleEnabled(v143, false)
            v142:Disconnect()
            for _, v149 in v143:GetDescendants() do
                if v149:IsA("ParticleEmitter") then
                    _G.tween(v149, {
                        0.25,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = NumberSequence.new(0)
                    })
                end
            end
            _G.destroy(v143, 3)
        end
        for _, v150 in v139 do
            v150:Play()
        end
        _G.particleEnabled(u73, false)
        _G.destroy(v57, 2)
        _G.destroy(u73, 4)
        task.wait(4)
        u24.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
}