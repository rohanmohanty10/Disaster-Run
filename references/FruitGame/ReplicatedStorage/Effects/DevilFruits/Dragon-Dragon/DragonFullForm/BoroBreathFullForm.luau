 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = script.Parent.Parent:WaitForChild("Rocks"):GetChildren()
local u5 = game.Players.LocalPlayer
local v6 = game:GetService("ReplicatedStorage")
local _ = CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -6, -18)
local u7 = CFrame.new(0, 2, -4)
local u8 = require(v6.Modules.CameraShaker)
function PlayAnim(p9, p10)
    local v11 = (p9:FindFirstChild("Humanoid") or p9:FindFirstChild("AnimationController")).Animator:LoadAnimation(script[p10])
    v11:Play(0, 1, 1)
    return v11
end
local function u14() --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v12 = Instance.new("ColorCorrectionEffect")
    v12.Parent = game.Lighting
    local v13 = Instance.new("BloomEffect")
    v13.Parent = game.Lighting
    u2:Create(v12, TweenInfo.new(0.39999999999999997), {
        ["Brightness"] = -0.25,
        ["Contrast"] = 0.75,
        ["Saturation"] = 0.2,
        ["TintColor"] = Color3.fromRGB(255, 216, 181)
    }):Play()
    u2:Create(v13, TweenInfo.new(0.39999999999999997), {
        ["Size"] = 36,
        ["Intensity"] = 1.75,
        ["Threshold"] = 1.5
    }):Play()
    _G.destroy(v12, 0.39999999999999997)
    _G.destroy(v13, 0.39999999999999997)
end
local u15 = _G.customEmit
local function u20(p16, p17, p18) --[[ Line: 54 ]]
    for _, v19 in p16:GetDescendants() do
        if (v19:IsA("ParticleEmitter") or v19:IsA("Trail")) and not (p18 and table.find(p18, v19.Name)) then
            v19.Enabled = p17
        end
    end
end
local v21 = RaycastParams.new()
local v22 = { workspace.Islands, workspace.Env, workspace.Ships }
local v23 = Enum.RaycastFilterType.Include
v21.FilterDescendantsInstances = v22
v21.FilterType = v23
function v1.start(_, u24, p25) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u20
        [3] = u2
        [4] = u3
        [5] = u15
        [6] = u14
        [7] = u5
        [8] = u8
        [9] = u4
    --]]
    local u26 = p25.PlayerDragonModel
    local v27 = p25.serverStartTime
    local v28 = p25.Remote
    local v29 = workspace:GetServerTimeNow() - v27
    local v30 = p25.ChargeTime
    if u24.PrimaryPart == nil then
        return
    else
        if u26 == nil then
            u26 = workspace.Effects:WaitForChild(u24.Name .. "DragonModel", 1)
        end
        if u26 then
            local u31 = u26.PrimaryPart:FindFirstChild("Head", true).TransformedWorldCFrame * u7
            local u32 = Random.new()
            local v33 = PlayAnim(u26, "Charge")
            local u34 = Instance.new("Model")
            local u35 = script.Sphere:Clone()
            u35:PivotTo(u31)
            u35:ScaleTo(0.01)
            u35.Parent = u34
            local u36 = v30 - v29
            _G.PlayEffect("TweenModel", nil, u35, TweenInfo.new(u36, Enum.EasingStyle.Quad), script.Sphere:GetScale())
            local u37 = u35.ChargeAura
            local u38 = script.SmallCharge:Clone()
            u38.CFrame = u37.CFrame
            u38.Parent = u34
            u34.Parent = workspace.Effects
            local v39 = _G.PlaySound(u37, script.DragonBoroBreathStart)
            task.delay(u36, function() --[[ Line: 126 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u37
                --]]
                u20(u37, false)
            end)
            for _, u40 in u35.Beams:GetChildren() do
                local u41 = u40.Width0
                local u42 = u40.Width1
                u40.Width0 = 0
                u40.Width1 = 0
                task.delay(0.35, function() --[[ Line: 134 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u40
                        [3] = u32
                        [4] = u36
                        [5] = u41
                        [6] = u42
                    --]]
                    local v43 = {
                        ["Width0"] = u41,
                        ["Width1"] = u42
                    }
                    u2:Create(u40, TweenInfo.new(u32:NextNumber(-0.1, 0.1) + u36 - 0.35), v43):Play()
                end)
            end
            task.spawn(function() --[[ Line: 142 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u35
                    [3] = u36
                    [4] = u31
                    [5] = u7
                    [6] = u38
                    [7] = u37
                    [8] = u3
                --]]
                local v44 = os.clock()
                local v45 = u26.PrimaryPart:FindFirstChild("Head", true)
                local v46 = u35.Inner.SideFires:QueryDescendants("ParticleEmitter")
                while os.clock() - v44 <= u36 do
                    local v47 = (os.clock() - v44) / u36
                    local v48 = math.clamp(v47, 0, 1)
                    local v49 = v48 * 12
                    local v50 = v48 * 1
                    if v45 then
                        u31 = v45.WorldCFrame * u7 * CFrame.new(0, v50, -v49)
                    end
                    u35:PivotTo(u31)
                    u38.CFrame = u37.CFrame
                    for v51 = 1, #v46 do
                        v46[v51].Acceleration = u31.LookVector * -400
                    end
                    u3.RenderStepped:Wait()
                end
            end)
            local u52 = nil
            task.delay(u36 / 2, function() --[[ Line: 178 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u37
                    [3] = u2
                    [4] = u36
                --]]
                u52 = script.DragonBoroBreathChargeLoop:Clone()
                u52.Parent = u37
                u52:Play()
                u2:Create(u52, TweenInfo.new(u36), {
                    ["RollOffMinDistance"] = 300,
                    ["Volume"] = 1.25
                }):Play()
            end)
            task.wait(u36)
            local v53 = u52
            repeat
                task.wait()
            until v28:GetAttribute("EndCFrame") ~= nil
            local function u57(p54, p55) --[[ Line: 192 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local v56 = p55 == nil and 0.3 or p55
                u2:Create(p54, TweenInfo.new(v56, Enum.EasingStyle.Quad), {
                    ["Volume"] = 0
                }):Play()
                _G.destroy(p54, v56)
            end
            local u58 = v28:GetAttribute("EndCFrame")
            local u59 = v28:GetAttribute("explosionCFrame")
            v33:Stop()
            if u26:IsDescendantOf(game) == false or u24 and u24.PrimaryPart == nil then
                u35:Destroy()
            else
                PlayAnim(u26, "Release")
                u35:ScaleTo(u35:GetScale() + 0.1)
                _G.particleEnabled(u35.Inner, false)
                _G.destroy(u35.Inner, 3)
                local v60 = script.ShootAura:Clone()
                v60.CFrame = u35:GetPivot()
                v60.Parent = u34
                u15(v60.Start)
                local u61 = CFrame.new(u31.Position, u58.Position)
                local v62 = CFrame.new(u24.PrimaryPart.Position, u58.Position)
                local v63 = RaycastParams.new()
                local v64 = _G.getTargetsWithENV(u24)
                local v65 = Enum.RaycastFilterType.Include
                v63.FilterDescendantsInstances = v64
                v63.FilterType = v65
                local u66 = workspace:Raycast(v62.Position, v62.LookVector * 5000, v63)
                v60.CFrame = u61
                local _ = (u58.Position - u31.Position).Magnitude
                local v67 = v28:GetAttribute("Distance")
                local u68 = TweenInfo.new(v67 / 475, Enum.EasingStyle.Linear)
                local u69 = script.Beam:Clone()
                u69:PivotTo(u61)
                local v70 = u69.Main.End
                local v71 = v67 / 2
                v70.Position = Vector3.new(0, 0, v71)
                local v72 = u69.Main.Start
                local v73 = v67 / 2
                v72.Position = Vector3.new(0, 0, v73)
                u69.Parent = u34
                _G.PlaySound(v60, script.DragonBoroBreathShoot)
                local v74 = u2
                local v75 = u69.Main.End
                local v76 = {}
                local v77 = -v67 / 2
                v76.Position = Vector3.new(0, 0, v77)
                v74:Create(v75, u68, v76):Play()
                local u78 = script.DragonBoroBreathTravel:Clone()
                u78.Parent = u69.Main.End
                u78:Play()
                u15(u69.Main)
                for _, u79 in u69:GetChildren() do
                    if u79.Name == "Main" then
                        u79.Size = Vector3.new(1, 1, v67)
                        u79.CFrame = u79.CFrame * CFrame.new(0, 0, -v67 / 2)
                    elseif u79.Name == "BeamForward" then
                        for _, v80 in u79:GetDescendants() do
                            if v80:IsA("Attachment") then
                                u2:Create(v80, TweenInfo.new(u68.Time / 2), {
                                    ["Position"] = v80.Position
                                }):Play()
                                v80.Position = Vector3.new(0, 0, 0)
                            elseif v80:IsA("Beam") then
                                local v81 = v80.Width0
                                local v82 = v80.Width1
                                v80.Width0 = v81
                                v80.Width1 = v82
                                u2:Create(v80, TweenInfo.new(u68.Time / 2), {
                                    ["Width0"] = v81,
                                    ["Width1"] = v82
                                }):Play()
                            end
                        end
                        u79.CFrame = u61
                        u2:Create(u79, u68, {
                            ["CFrame"] = CFrame.lookAlong(u58.Position, u79.CFrame.LookVector) * CFrame.Angles(0, 0, u32:NextNumber(-3.141592653589793, 3.141592653589793))
                        }):Play()
                    elseif u79:IsA("BasePart") then
                        local v83 = u79.Size.X
                        local v84 = -v67 / 2
                        u79.Size = Vector3.new(v83, 0, v83)
                        local u85 = u79.Size
                        local u86 = u79.CFrame
                        local u87 = u79.CFrame * CFrame.new(0, v84, 0)
                        local u88 = Vector3.new(v83, v67, v83)
                        local u89 = {}
                        for _, v90 in u79:GetChildren() do
                            if v90:IsA("Attachment") then
                                u89[v90] = v90.Position
                            end
                        end
                        local u91 = nil
                        local u92 = os.clock()
                        local u93 = 0
                        u91 = u3.Heartbeat:Connect(function(p94) --[[ Line: 317 ]]
                            --[[
                            Upvalues:
                                [1] = u92
                                [2] = u68
                                [3] = u93
                                [4] = u91
                                [5] = u2
                                [6] = u79
                                [7] = u86
                                [8] = u87
                                [9] = u85
                                [10] = u88
                                [11] = u89
                            --]]
                            local v95 = (os.clock() - u92) / u68.Time
                            u93 = u93 + p94 * (720 / u68.Time)
                            if v95 >= 1 then
                                u91:Disconnect()
                            else
                                local v96 = u2:GetValue(v95, u68.EasingStyle, u68.EasingDirection)
                                local v97 = u93
                                local v98 = math.sin(v97) * Vector3.new(0.1, 0, 0.1)
                                u79.CFrame = u86:Lerp(u87, v96)
                                u79.Size = u85:Lerp(u88, v96) + u85 * v98
                                for v99, v100 in u89 do
                                    v99.Position = (v100 + v100 * v98) * Vector3.new(1, 0, 1)
                                    local v101 = v99.Position
                                    local v102 = u79.Size.Y / 2 * (v99:HasTag("End") and -1 or 1)
                                    v99.Position = v101 + Vector3.new(0, v102, 0)
                                end
                            end
                        end)
                    end
                end
                u57(v53)
                u57(v39)
                local u103 = tick()
                local u104 = script.DragonUltBreathLoopFront:Clone()
                u104.Parent = u35.PrimaryPart
                u104:Play()
                task.spawn(function() --[[ Line: 421 ]]
                    --[[
                    Upvalues:
                        [1] = u61
                        [2] = u103
                        [3] = u68
                        [4] = u69
                        [5] = u32
                        [6] = u34
                        [7] = u2
                    --]]
                    local v105 = u61.Position
                    while tick() - u103 < u68.Time do
                        local v106 = u69.Main.End.WorldPosition
                        local v107 = (v105 - v106).Magnitude
                        local _ = u69.Main.End
                        local v108 = (u61.Position - v106).Magnitude
                        if math.random(1, 2) == 1 then
                            local v109 = _G.PlayEffect
                            local v110 = {
                                ["Direction"] = -u61.LookVector
                            }
                            local v111 = (u61 * CFrame.new(0, 0, -(v108 + 50))).Position
                            local v112 = math.random(-35, 35) / 2
                            local v113 = math.random(-35, 35) / 2
                            local v114 = math.random(-35, 35) / 10
                            v110.Position = v111 + Vector3.new(v112, v113, v114)
                            v110.Color = Color3.fromRGB(255, 67, 17)
                            v110.Brightness = 16
                            v110.Speed = math.random(100, 300)
                            v110.Width = math.random(500, 1000) / 10
                            v110.Texture = "rbxassetid://125130391312772"
                            v110.Duration = u32:NextNumber(1, 2)
                            v110.Amplitude = u32:NextNumber(15, 60)
                            v109("CustomAirTrail", nil, v110)
                        end
                        if v107 >= 150 then
                            local v115 = TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
                            local v116 = script.WindMesh:Clone()
                            v116.CFrame = u61 * CFrame.new(0, 0, -(v108 + 50)) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
                            v116.Parent = u34
                            local v117 = v116.Size.X * 3
                            u2:Create(v116, v115, {
                                ["CFrame"] = v116.CFrame * CFrame.new(0, -100, 0),
                                ["Size"] = Vector3.new(v117, 5, v117),
                                ["Transparency"] = 1
                            }):Play()
                            v116.Size = v116.Size * u32:NextNumber(0.05, 0.1)
                            _G.destroy(v116, 2)
                        else
                            v106 = v105
                        end
                        task.wait()
                        v105 = v106
                    end
                end)
                task.spawn(function() --[[ Line: 483 ]]
                    --[[
                    Upvalues:
                        [1] = u61
                        [2] = u103
                        [3] = u68
                        [4] = u69
                        [5] = u32
                        [6] = u34
                        [7] = u2
                    --]]
                    local v118 = u61.Position
                    while tick() - u103 < u68.Time do
                        local v119 = u69.Main.End.WorldPosition
                        if (v118 - v119).Magnitude >= 3 then
                            local v120 = (u61.Position - v119).Magnitude
                            local v121 = CFrame.Angles(u32:NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
                            local u122 = script.ColorWave:Clone()
                            u122.CFrame = u61 * CFrame.new(0, 0, -v120) * CFrame.Angles(0, -1.5707963267948966, 0) * v121
                            u122.Parent = u34
                            local u123 = script.ColorWave:Clone()
                            u123.CFrame = u61 * CFrame.new(0, 0, -v120) * CFrame.Angles(0, -1.5707963267948966, 0) * v121
                            u123.Parent = u34
                            u2:Create(u122.Mesh, TweenInfo.new(u32:NextNumber(0.35, 0.55)), {
                                ["Scale"] = Vector3.new(0.13, 0.189, 0.183) * u32:NextNumber(1, 1.25)
                            }):Play()
                            u2:Create(u123.Mesh, TweenInfo.new(u32:NextNumber(0.35, 0.55)), {
                                ["Scale"] = Vector3.new(0.106, 0.154, 0.149) * u32:NextNumber(1, 1.25)
                            }):Play()
                            task.delay(u32:NextNumber(0.1, 0.2), function() --[[ Line: 516 ]]
                                --[[
                                Upvalues:
                                    [1] = u2
                                    [2] = u122
                                    [3] = u32
                                    [4] = u123
                                --]]
                                u2:Create(u122.Decal, TweenInfo.new(u32:NextNumber(0.45, 0.6)), {
                                    ["Transparency"] = 1
                                }):Play()
                                u2:Create(u123.Decal, TweenInfo.new(u32:NextNumber(0.45, 0.6)), {
                                    ["Transparency"] = 1
                                }):Play()
                            end)
                            local v124 = u122.Mesh
                            v124.Scale = v124.Scale * u32:NextNumber(0.1, 0.125)
                            local v125 = u123.Mesh
                            v125.Scale = v125.Scale * u32:NextNumber(0.05, 0.1)
                            _G.destroy(u123, 1)
                            _G.destroy(u122, 1)
                        else
                            v119 = v118
                        end
                        task.wait()
                        v118 = v119
                    end
                end)
                task.delay(u68.Time, function() --[[ Line: 533 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u78
                        [3] = u2
                        [4] = u104
                        [5] = u66
                        [6] = u59
                        [7] = u58
                        [8] = u14
                        [9] = u24
                        [10] = u34
                        [11] = u20
                        [12] = u32
                        [13] = u5
                        [14] = u8
                        [15] = u15
                        [16] = u4
                    --]]
                    u57(u78)
                    u2:Create(u104, TweenInfo.new(0.5), {
                        ["Volume"] = 0
                    }):Play()
                    if u66 then
                        if u59 then
                            u58 = u59
                            warn("using explosiobn cframe")
                        end
                        task.spawn(u14)
                        local u126 = u58 * CFrame.Angles(-1.5707963267948966, 0, 0)
                        local v127 = (workspace.CurrentCamera.CFrame.Position - u126.Position).Magnitude < 1000
                        local u128 = u24 == game.Players.LocalPlayer.Character and true or v127
                        local u129 = script.PreExplosion:Clone()
                        u129:PivotTo(u126)
                        u129:ScaleTo(0.001)
                        u129.Parent = u34
                        _G.destroy(u129, 1.1)
                        _G.PlaySound(u126, script.DragonUltPreExplosion)
                        task.delay(0.075, function() --[[ Line: 575 ]]
                            --[[
                            Upvalues:
                                [1] = u129
                                [2] = u20
                                [3] = u2
                                [4] = u32
                            --]]
                            for _, v130 in u129:GetChildren() do
                                if v130.Name == "Particles" then
                                    v130.Parent = workspace.Effects
                                    _G.destroy(v130, 5)
                                    task.delay(0.27499999999999997, u20, v130, false)
                                    if v130:FindFirstChild("Light") then
                                        _G.destroy(v130.Light, 0.27499999999999997)
                                    end
                                elseif v130:IsA("BasePart") and (v130.Name ~= "Wind" and v130.Name ~= "Shockwave") then
                                    local v131 = v130.Size
                                    local v132 = v130.CFrame
                                    v130.CFrame = v130.CFrame * CFrame.new(0, -v131.Y * 0.2, 0)
                                    v130.Size = v130.Size * 1.1
                                    u2:Create(v130, TweenInfo.new(0.26249999999999996, Enum.EasingStyle.Exponential), {
                                        ["Size"] = v131 * 0.85,
                                        ["CFrame"] = CFrame.lookAlong((v132 * CFrame.new(0, v131.Y * 0.1, 0)).Position, v132.LookVector, v132.UpVector)
                                    }):Play()
                                    _G.destroy(v130, 0.27499999999999997)
                                elseif v130:IsA("BasePart") and v130.Name == "Wind" then
                                    local v133 = v130.Mesh.Scale
                                    local v134 = v130.CFrame
                                    v130.Mesh.Scale = v133 * 0.225
                                    u2:Create(v130, TweenInfo.new(0.475, Enum.EasingStyle.Exponential), {
                                        ["CFrame"] = CFrame.lookAlong((v134 * CFrame.new(0, v133.Y * 0.1, 0)).Position, v134.LookVector, v134.UpVector) * CFrame.Angles(u32:NextNumber(2.670353755551324, 4.241150082346221), 0, 0)
                                    }):Play()
                                    u2:Create(v130.Mesh, TweenInfo.new(0.5249999999999999 - u32:NextNumber(0.1, 0.2)), {
                                        ["Scale"] = v133 * u32:NextNumber(1, 1.25)
                                    }):Play()
                                    u2:Create(v130.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                                        ["Transparency"] = 1
                                    }):Play()
                                    _G.destroy(v130, 1.2)
                                elseif v130:IsA("BasePart") and v130.Name == "Shockwave" then
                                    v130:Destroy()
                                end
                            end
                        end)
                        local v135 = Instance.new("NumberValue")
                        v135.Value = 0.001
                        v135.Changed:Connect(function(p136) --[[ Line: 651 ]]
                            --[[
                            Upvalues:
                                [1] = u129
                                [2] = u126
                            --]]
                            u129:ScaleTo(p136)
                            u129:PivotTo(u126 * CFrame.new(0, 1.5 * p136, 0))
                        end)
                        _G.destroy(v135, 1)
                        u2:Create(v135, TweenInfo.new(0.075), {
                            ["Value"] = 2
                        }):Play()
                        _G.customEmit(u129)
                        _G.particleEnabled(u129, true)
                        task.spawn(function() --[[ Line: 671 ]]
                            --[[
                            Upvalues:
                                [1] = u129
                                [2] = u2
                            --]]
                            os.clock()
                            for _ = 1, 5 do
                                local u137 = script.Ring:Clone()
                                u137:ScaleTo(2)
                                u137:PivotTo(u129:GetPivot() * CFrame.new(0, 50, 0))
                                u137.Parent = workspace.Effects
                                local v138 = TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                                local v139 = Instance.new("NumberValue")
                                v139.Value = 0.001
                                v139.Changed:Connect(function(p140) --[[ Line: 686 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u137
                                        [2] = u129
                                    --]]
                                    local _ = 1.001 - p140
                                    u137:PivotTo(u129:GetPivot() * CFrame.new(0, (15 + 35 * p140) * 2, 0))
                                end)
                                for _, v141 in u137.Ring.Beams:GetChildren() do
                                    u2:Create(v141, TweenInfo.new(0.22749999999999998), {
                                        ["Width0"] = 0,
                                        ["Width1"] = 0
                                    }):Play()
                                    u2:Create(v141, v138, {
                                        ["CurveSize0"] = 0,
                                        ["CurveSize1"] = 0
                                    }):Play()
                                end
                                for _, v142 in u137.Ring:GetChildren() do
                                    if v142:IsA("Attachment") then
                                        u2:Create(v142, v138, {
                                            ["Position"] = Vector3.new(0, 0, 0)
                                        }):Play()
                                    end
                                end
                                u2:Create(v139, TweenInfo.new(0.2975, Enum.EasingStyle.Cubic), {
                                    ["Value"] = 1
                                }):Play()
                                _G.destroy(v139, 1)
                                _G.destroy(u137, 3)
                                task.wait(0.11666666666666667)
                            end
                        end)
                        task.spawn(function() --[[ Line: 714 ]]
                            --[[
                            Upvalues:
                                [1] = u32
                                [2] = u129
                                [3] = u2
                            --]]
                            os.clock()
                            for _ = 1, 6 do
                                local v143 = CFrame.Angles(u32:NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
                                local v144 = script.UpMesh:Clone()
                                v144:PivotTo(u129:GetPivot() * CFrame.new(0, 50, 0) * CFrame.Angles(0, 0, -1.5707963267948966) * v143)
                                v144.Parent = workspace.Effects
                                u2:Create(v144.Decal, TweenInfo.new(0.1925), {
                                    ["Transparency"] = 1
                                }):Play()
                                u2:Create(v144.Mesh, TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    ["Scale"] = Vector3.new(0, 0, 0)
                                }):Play()
                                u2:Create(v144, TweenInfo.new(0.21, Enum.EasingStyle.Cubic), {
                                    ["CFrame"] = u129:GetPivot() * CFrame.new(0, 100, 0) * CFrame.Angles(0, 0, -1.5707963267948966) * v143
                                }):Play()
                                _G.destroy(v144, 1.5)
                                task.wait(0.0875)
                            end
                        end)
                        if u66 and u66.Instance then
                            local v145 = u66.Position
                            _G.PlaySound(CFrame.new(v145), script.DragonBoroBreathExplosion)
                        end
                        task.delay(0.35, function() --[[ Line: 745 ]]
                            --[[
                            Upvalues:
                                [1] = u129
                                [2] = u66
                                [3] = u58
                                [4] = u24
                                [5] = u5
                                [6] = u34
                                [7] = u2
                                [8] = u128
                                [9] = u8
                                [10] = u15
                                [11] = u32
                                [12] = u4
                                [13] = u20
                            --]]
                            _G.particleEnabled(u129, false)
                            if u66 and u66.Instance then
                                local v146 = u66.Instance
                                local v147 = u66.Normal
                                local _ = u66.Position
                                task.spawn(function() --[[ Line: 769 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u58
                                        [2] = u24
                                        [3] = u5
                                        [4] = u34
                                        [5] = u2
                                        [6] = u128
                                        [7] = u8
                                        [8] = u66
                                        [9] = u15
                                        [10] = u32
                                    --]]
                                    if u58 and (u24 == u5.Character or (u24:GetPivot().Position - u58.Position).Magnitude <= 150) then
                                        local v148 = script.HitSphere:Clone()
                                        v148.Parent = u34
                                        v148.CFrame = u58
                                        v148.Size = Vector3.new(0, 0, 0)
                                        local v149 = script.Cylinder:Clone()
                                        v149.CFrame = u58 * CFrame.Angles(1.5707963267948966, 0, 0)
                                        v149.Size = Vector3.new(32, 0, 32)
                                        v149.Parent = u34
                                        u2:Create(v148, TweenInfo.new(0.1111111111111111), {
                                            ["Size"] = Vector3.new(164, 164, 164),
                                            ["CFrame"] = u58 * CFrame.new(0, 0, -82)
                                        }):Play()
                                        u2:Create(v149, TweenInfo.new(0.125), {
                                            ["Size"] = Vector3.new(0, 800, 0)
                                        }):Play()
                                        local v150 = Instance.new("Highlight")
                                        v150.FillColor = Color3.new()
                                        v150.FillTransparency = 0
                                        v150.OutlineTransparency = 1
                                        v150.DepthMode = Enum.HighlightDepthMode.Occluded
                                        v150.Parent = u34
                                        local v151
                                        if u128 == true then
                                            v151 = Instance.new("ColorCorrectionEffect")
                                            v151.Contrast = 50
                                            v151.Saturation = -1
                                            v151.Parent = game.Lighting
                                        else
                                            v151 = nil
                                        end
                                        task.wait(0.0625)
                                        v150.FillColor = Color3.new(1, 1, 1)
                                        if v151 then
                                            v151.Contrast = -50
                                        end
                                        task.wait(0.0625)
                                        v148:Destroy()
                                        v150:Destroy()
                                        v149:Destroy()
                                        if v151 then
                                            v151:Destroy()
                                        end
                                        if u128 == true then
                                            _G.camShake:ShakeSustain(u8.Presets.WindBreak)
                                            task.delay(0.35, function() --[[ Line: 817 ]]
                                                _G.camShake:StopSustained(2)
                                            end)
                                        end
                                    end
                                    local v152 = script.Explosion:Clone()
                                    v152:PivotTo(u58 * CFrame.new(0, 0, -20.8) * CFrame.Angles(-1.5707963267948966, 0, 0))
                                    v152:ScaleTo(3.7)
                                    _G.recolorParticles(v152, u66.Instance.Color)
                                    v152.Part.FloorExplosion.WorldCFrame = u58 * CFrame.Angles(-1.5707963267948966, 0, 0)
                                    v152.Parent = u34
                                    task.spawn(u15, v152.Part)
                                    local v153 = script.Burnt:Clone()
                                    v153:ScaleTo(u32:NextNumber(0.65, 0.85) * 2)
                                    v153:PivotTo(u58)
                                    for _, u154 in v153:GetDescendants() do
                                        if u154:IsA("Decal") then
                                            if u154.Parent.Name == "Mark" then
                                                task.delay(4.35, function() --[[ Line: 840 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u2
                                                        [2] = u154
                                                    --]]
                                                    u2:Create(u154, TweenInfo.new(2), {
                                                        ["Color3"] = Color3.new()
                                                    }):Play()
                                                end)
                                            end
                                            task.delay(5.35, function() --[[ Line: 845 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u2
                                                    [2] = u154
                                                    [3] = u32
                                                --]]
                                                u2:Create(u154, TweenInfo.new(u32:NextNumber(0.75, 1)), {
                                                    ["Transparency"] = 1
                                                }):Play()
                                            end)
                                        elseif u154:IsA("BasePart") then
                                            u154.Size = u154.Size * 3.5
                                        end
                                    end
                                    v153.Parent = u34
                                    _G.destroy(v153, 8.35)
                                    local u155 = script.FloorBurn:Clone()
                                    u155.CFrame = u58 * CFrame.Angles(-1.5707963267948966, 0, 0)
                                    u155.Parent = workspace.Effects
                                    task.delay(5.35, function() --[[ Line: 864 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u2
                                            [2] = u155
                                        --]]
                                        u2:Create(u155.PointLight, TweenInfo.new(1), {
                                            ["Brightness"] = 0
                                        }):Play()
                                        _G.particleEnabled(u155, false)
                                        _G.destroy(u155, 7)
                                    end)
                                end)
                                local _ = u32:NextInteger(16, 19) * 2
                                local v156 = u66.Position + u66.Normal * 0.01
                                _G.PlayEffect("GroundRocks4", nil, {
                                    ["Segments"] = 15,
                                    ["Position"] = v156,
                                    ["DistanceRandomness"] = Vector2.new(0.5, 1),
                                    ["Duration"] = 5,
                                    ["TweenDuration"] = 3,
                                    ["Radius"] = 110,
                                    ["Direction"] = -u66.Normal * 30,
                                    ["Angle"] = -0.5235987755982988
                                })
                                for _ = 1, 5 do
                                    for _ = 1, 3 do
                                        local u157 = u4[math.random(1, #u4)]:Clone()
                                        u157:PivotTo(u58)
                                        u157:ScaleTo(u32:NextNumber(0.9, 1.3) * 2)
                                        u20(u157, true)
                                        for _, u158 in u157:GetChildren() do
                                            _G.matchMaterial(u158, v146)
                                            u158.Anchored = false
                                            task.delay(2, function() --[[ Line: 968 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u2
                                                    [2] = u158
                                                    [3] = u157
                                                --]]
                                                u2:Create(u158, TweenInfo.new(0.5), {
                                                    ["Size"] = Vector3.new(0, 0, 0)
                                                }):Play()
                                                for _, v159 in u157:GetDescendants() do
                                                    if v159:IsA("Attachment") then
                                                        u2:Create(v159, TweenInfo.new(0.5), {
                                                            ["Position"] = Vector3.new(0, 0, 0)
                                                        }):Play()
                                                    end
                                                end
                                            end)
                                        end
                                        u157.Parent = u34
                                        local v160 = Instance.new("BodyVelocity")
                                        local v161 = Instance.new("BodyAngularVelocity")
                                        v160.MaxForce = Vector3.new(999999, 999999, 999999)
                                        v161.MaxTorque = Vector3.new(999999, 999999, 999999)
                                        local v162 = u32:NextNumber(-120, 120)
                                        local v163 = u32:NextNumber(45, 130)
                                        local v164 = u32
                                        local v165 = Vector3.new(v162, v163, v164:NextNumber(-120, 120)) * 1.3333333333333333 + v147 * u32:NextNumber(22.5, 37.5) * 1.3333333333333333
                                        local v166 = u32:NextUnitVector() * u32:NextNumber(6, 15)
                                        v160.Velocity = v165
                                        v161.AngularVelocity = v166
                                        local v167 = u157.PrimaryPart
                                        local v168 = u157.PrimaryPart
                                        v160.Parent = v167
                                        v161.Parent = v168
                                        _G.destroy(v161, 0.125)
                                        _G.destroy(v160, 0.145)
                                        _G.destroy(u157, 4)
                                    end
                                    for _ = 1, 3 do
                                        local u169 = script.Debris:Clone()
                                        u169.CFrame = u58
                                        u169.Size = u169.Size * (u32:NextNumber(0.325, 0.55) * 2)
                                        u169.CanCollide = true
                                        _G.matchMaterial(u169, v146)
                                        u169.Parent = u34
                                        task.delay(3, function() --[[ Line: 1000 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u169
                                                [2] = u2
                                            --]]
                                            _G.particleEnabled(u169, false)
                                            u2:Create(u169, TweenInfo.new(0.5), {
                                                ["Size"] = Vector3.new(0, 0, 0)
                                            }):Play()
                                            for _, v170 in u169:GetDescendants() do
                                                if v170:IsA("Attachment") then
                                                    u2:Create(v170, TweenInfo.new(0.5), {
                                                        ["Position"] = Vector3.new(0, 0, 0)
                                                    }):Play()
                                                end
                                            end
                                        end)
                                        local v171 = Instance.new("BodyVelocity")
                                        local v172 = Instance.new("BodyAngularVelocity")
                                        v171.MaxForce = Vector3.new(999999, 999999, 999999)
                                        v172.MaxTorque = Vector3.new(999999, 999999, 999999)
                                        local v173 = u32:NextNumber(-120, 120)
                                        local v174 = u32:NextNumber(45, 130)
                                        local v175 = u32
                                        local v176 = Vector3.new(v173, v174, v175:NextNumber(-120, 120)) * 1.3333333333333333 + v147 * u32:NextNumber(22.5, 37.5) * 1.3333333333333333
                                        local v177 = u32:NextUnitVector() * u32:NextNumber(6, 15)
                                        v171.Velocity = v176
                                        v172.AngularVelocity = v177
                                        v171.Parent = u169
                                        v172.Parent = u169
                                        _G.destroy(v172, 0.125)
                                        _G.destroy(v171, 0.145)
                                        _G.destroy(u169, 5)
                                    end
                                    task.wait(0.1)
                                end
                            end
                        end)
                        _G.destroy(u129, 3)
                    end
                end)
                task.wait(u68.Time + 0.2)
                u20(v60, false)
                u20(u38, false)
                local v178 = TweenInfo.new(0.515, Enum.EasingStyle.Quad)
                for _, u179 in u69:GetDescendants() do
                    if u179:IsA("BasePart") then
                        local v180 = u2
                        local v181 = {}
                        local v182 = u179.Size.Y
                        v181.Size = Vector3.new(0, v182, 0)
                        v180:Create(u179, v178, v181):Play()
                        task.delay(v178.Time, function() --[[ Line: 1038 ]]
                            --[[
                            Upvalues:
                                [1] = u179
                            --]]
                            u179.Transparency = 1
                        end)
                    elseif u179:IsA("Beam") then
                        u2:Create(u179, v178, {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        }):Play()
                    end
                end
                for _, v183 in u35:GetDescendants() do
                    if v183:IsA("BasePart") then
                        u2:Create(v183, v178, {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                    end
                end
                u20(u69, false)
                for _, v184 in u35.Beams:GetChildren() do
                    u2:Create(v184, TweenInfo.new(u32:NextNumber(0.325, 0.425)), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end
                _G.destroy(u34, v178.Time + 6)
            end
        else
            warn("nild ragon")
            return
        end
    end
end
return v1