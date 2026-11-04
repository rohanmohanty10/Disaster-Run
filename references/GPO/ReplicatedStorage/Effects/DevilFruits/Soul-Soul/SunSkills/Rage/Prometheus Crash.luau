 

local v1 = {}
local _ = game.Players.LocalPlayer
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = game:GetService("Lighting")
script:WaitForChild("Animations")
script:WaitForChild("Models")
local u5 = script:WaitForChild("SFX")
local u6 = script:WaitForChild("VFX")
script:WaitForChild("Other")
local u7 = require(script.Parent:WaitForChild("Shared"))
local u8 = require(game.ReplicatedStorage.Modules.Maid)
local u9 = Random.new()
local u10 = workspace.CurrentCamera
local u11 = workspace:WaitForChild("Effects")
local u12 = {
    Enum.NormalId.Back,
    Enum.NormalId.Front,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Top,
    Enum.NormalId.Bottom
}
function Apply(p13, p14)
    --[[
    Upvalues:
        [1] = u12
    --]]
    p13.Material = p14.Instance.Material
    p13.Color = p14.Instance.Color
    if p14.Instance:FindFirstChildWhichIsA("Texture") then
        local v15 = p14.Instance:FindFirstChildWhichIsA("Texture")
        for _, v16 in next, u12 do
            local v17 = v15:Clone()
            v17.Face = v16
            v17.Parent = p13
        end
    end
end
local function u20(u18) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u7
    --]]
    if (u10.CFrame.Position - u18.Position).Magnitude <= u18.Range then
        local u19 = u7.camShake:StartShake(u18.Magnitude, u18.Roughness, u18.FadeInTime)
        task.delay(u18.Duration or u18.FadeInTime, function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
            --]]
            u19:StartFadeOut(u18.FadeTime)
            u19 = nil
        end)
    end
end
local function u22() --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v21 = Instance.new("ColorCorrectionEffect")
    v21.Enabled = true
    v21.Parent = u4
    u2:Create(v21, TweenInfo.new(0.35), {
        ["Contrast"] = 1,
        ["Saturation"] = -1,
        ["Brightness"] = -0.1,
        ["TintColor"] = Color3.new(1, 1, 1)
    }):Play()
    return v21
end
local function u24() --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v23 = Instance.new("ColorCorrectionEffect")
    v23.Enabled = true
    v23.Parent = u4
    task.delay(2, v23.Destroy, v23)
    v23.Contrast = 2
    v23.Saturation = -1
    task.wait(0.09)
    v23.Contrast = -2
    task.wait(0.007)
    v23.Contrast = 2
    v23.Saturation = 1
    v23.TintColor = Color3.fromRGB(255, 85, 0)
    u2:Create(v23, TweenInfo.new(0.35), {
        ["Contrast"] = 0,
        ["Saturation"] = 0,
        ["TintColor"] = Color3.new(1, 1, 1)
    }):Play()
end
local function u27(p25) --[[ Line: 103 ]]
    for _, v26 in p25:GetDescendants() do
        if v26:IsA("ParticleEmitter") then
            v26.Enabled = false
            v26:Emit(v26:GetAttribute("EmitCount") or 3)
        end
    end
end
local function u31(p28, p29) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, v30 in p28:GetDescendants() do
        if v30:IsA("ParticleEmitter") or (v30:IsA("Beam") or v30:IsA("Trail")) then
            v30.Enabled = p29
        elseif v30:IsA("PointLight") and not p29 then
            u2:Create(v30, TweenInfo.new(0.5), {
                ["Brightness"] = 0
            }):Play()
        end
    end
end
local u32 = RaycastParams.new()
u32.FilterType = Enum.RaycastFilterType.Include
u32.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function ReturnRaycast(p33, p34)
    --[[
    Upvalues:
        [1] = u32
    --]]
    local v35 = (p33.PrimaryPart.Position - p34).Magnitude
    local v36 = CFrame.new(p33.PrimaryPart.Position, p34)
    local v37 = CFrame.new(p34) + v36.LookVector * -5
    local v38 = workspace:Raycast(v37.Position, v36.LookVector * 6, u32)
    if v38 then
        return {
            ["CF"] = CFrame.new(v38.Position, v38.Position + v38.Normal),
            ["Raycast"] = v38,
            ["Direction"] = v36
        }
    end
    local v39 = CFrame.new(p33.PrimaryPart.Position) + v36.LookVector * (v35 + 5)
    local v40 = workspace:Raycast(v39.Position, v36.LookVector * -6, u32)
    return v40 and {
        ["CF"] = CFrame.new(v40.Position, v40.Position + v40.Normal),
        ["Raycast"] = v40,
        ["Direction"] = v36
    } or {
        ["CF"] = CFrame.new(p34),
        ["Direction"] = v36
    }
end
function v1.start(_, u41, u42, p43, u44, u45) --[[ Line: 162 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u6
        [3] = u31
        [4] = u5
        [5] = u3
        [6] = u32
        [7] = u20
        [8] = u2
        [9] = u8
        [10] = u10
        [11] = u22
        [12] = u9
        [13] = u24
        [14] = u27
    --]]
    local u46 = u41.HumanoidRootPart
    local v47 = u11[u41.Name .. "\'s Clouds"]
    local u48 = v47.Prometheus
    local u49 = {}
    u48:SetAttribute("CustomMovement", true)
    u49.State = "Start"
    u49.StartTick = u42
    local u50 = u48.RageModel
    local v51 = Instance.new("BoolValue")
    v51.Name = "PrometheusTempStop"
    v51.Parent = v47
    u49.TempStop = v51
    local v52 = u50.AttachedPart
    local u53 = u6.FX_Charge:Clone()
    u53:PivotTo(v52.CFrame * CFrame.new(0, 0.5, 1))
    u53.PrimaryPart.Anchored = true
    u53.Parent = workspace.Effects
    local u54 = Instance.new("BoolValue")
    u54.Parent = u53
    _G.customWeld(u53.PrimaryPart, v52, CFrame.new(), u54)
    local v55 = u6.FX_Travel:Clone()
    v55:PivotTo(v52.CFrame)
    v55.PrimaryPart.Anchored = true
    u31(v55, false)
    v55.Parent = u48
    local u56 = Instance.new("BoolValue")
    u56.Parent = v55
    _G.customWeld(v55.PrimaryPart, v52, CFrame.new(), u56)
    u49.FX_Charge = u53
    u49.FX_Travel = v55
    u49.CamShake = _G.camShake:StartShake(0.3, 10, 0.5)
    u49.FX_GroundAttach = u6.FX_ChargeCharDust.Attachment:Clone()
    u49.FX_GroundAttach.Parent = workspace.Terrain
    local u57 = _G.PlaySound(u44, u5.SoulPrometheusUltStart)
    u57.Parent = u44
    local u58 = 0
    u49.Connection = u3.Heartbeat:Connect(function(p59) --[[ Line: 215 ]]
        --[[
        Upvalues:
            [1] = u42
            [2] = u46
            [3] = u49
            [4] = u44
            [5] = u32
            [6] = u45
            [7] = u58
            [8] = u48
            [9] = u53
        --]]
        local v60 = workspace:GetServerTimeNow()
        local v61 = (v60 - u42) / 4
        local v62 = math.clamp(v61, 0, 1)
        local v63 = 1 - v62
        local v64 = (v60 - u42) / 0.2
        math.clamp(v64, 0, 1)
        local v65 = CFrame.new
        local v66 = u46.CFrame
        local v67 = CFrame.Angles
        local v68 = v62 * 720
        local v69 = v65(v66 * v67(0, math.rad(v68), 0) * CFrame.new(0, v62 * 20 + 2.4000000000000004, v63 * 35).Position, u46.CFrame * CFrame.new(0, 5, -5000).Position)
        if u49.FX_GroundAttach then
            local v70 = u49.FX_GroundAttach
            local v71 = u44
            local v72 = workspace:Raycast(v71.Position, Vector3.new(0, -25, 0), u32)
            if v72 and v72.Instance then
                v70.WorldCFrame = CFrame.new(v72.Position, v72.Position + v72.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
            end
            if v72 and v72.Instance then
                _G.recolorParticles(v70, v72.Instance.Color)
                _G.particleEnabled(v70, true)
            else
                _G.particleEnabled(v70, false)
            end
        end
        u44.CFrame = u44.CFrame:Lerp(v69, 0.8 * p59)
        local v73 = 1 + (u45 - 1) * v62
        local v74 = u45
        local v75 = math.clamp(v73, 1, v74)
        if tick() - u58 >= 0.1 then
            u48:ScaleTo(v75)
            u53:ScaleTo(v75)
            u58 = tick()
        end
    end)
    local u76 = u50.AnimationController:LoadAnimation(script.Animations.PrometheusULT)
    local u77 = nil
    u77 = p43.OnClientEvent:Connect(function(_, u78) --[[ Line: 253 ]]
        --[[
        Upvalues:
            [1] = u77
            [2] = u20
            [3] = u44
            [4] = u49
            [5] = u31
            [6] = u56
            [7] = u53
            [8] = u2
            [9] = u57
            [10] = u5
            [11] = u76
            [12] = u11
            [13] = u41
            [14] = u8
            [15] = u6
            [16] = u54
            [17] = u10
            [18] = u22
            [19] = u9
            [20] = u24
            [21] = u27
            [22] = u3
            [23] = u50
            [24] = u32
        --]]
        u77:Disconnect()
        local _ = u78.MaxScale
        local u79 = u78.Scale
        local u80 = u78.PrecomputedTrajectory
        local u81 = u78.ServerStartTime
        local _ = u78.perBounceScaleIncrease
        task.wait(u81 - workspace:GetServerTimeNow())
        u20({
            ["Range"] = 125 + u79 * 60,
            ["Position"] = u44.CFrame.Position,
            ["Magnitude"] = 1,
            ["Roughness"] = 5,
            ["Duration"] = 0.4,
            ["FadeTime"] = 0.1,
            ["FadeInTime"] = 0.1
        })
        if u49.Connection then
            u49.Connection:Disconnect()
            u49.Connection = nil
        end
        if u49.CamShake then
            u49.CamShake:StartFadeOut(0.1)
            u49.CamShake = nil
        end
        if u49.FX_GroundAttach then
            u31(u49.FX_GroundAttach, false)
            _G.destroy(u49.FX_GroundAttach, 3)
        end
        if u49.FX_Charge then
            u31(u49.FX_Charge, false)
            _G.destroy(u49.FX_Charge, 4)
            u49.FX_Charge.Parent = workspace.Effects
            u49.FX_Charge.PrimaryPart.Anchored = true
        end
        if u49.FX_Travel then
            u49.FX_Travel.PrimaryPart.Anchored = true
            u31(u49.FX_Travel, true)
        end
        u56:Destroy()
        _G.PlayEffect("TweenParticles", nil, u53, NumberSequence.new(0), 0.25)
        u2:Create(u57, TweenInfo.new(0.25), {
            ["Volume"] = 0
        }):Play()
        _G.PlaySound(u44, u5.SoulPrometheusUltLaunch).Parent = u44
        if u76 and u76.IsPlaying == false then
            u76:Play()
        end
        local u82 = u11[u41.Name .. "\'s Clouds"]
        local u83 = u82.Prometheus
        u44.CFrame = u78.StartCFrame
        u83:ScaleTo(u78.Scale)
        local u84 = u8.new()
        local u85 = u44
        local u86 = u6.TravelLines:Clone()
        u86:PivotTo(u44.CFrame)
        u86.PrimaryPart.Anchored = true
        u86.Parent = u83
        local u87 = 1
        local u88 = false
        local _ = workspace:GetServerTimeNow() - u81
        local u89 = nil
        local u90 = nil
        local function u178(p91) --[[ Line: 340 ]]
            --[[
            Upvalues:
                [1] = u88
                [2] = u54
                [3] = u10
                [4] = u79
                [5] = u2
                [6] = u49
                [7] = u22
                [8] = u76
                [9] = u83
                [10] = u44
                [11] = u5
                [12] = u20
                [13] = u84
                [14] = u6
                [15] = u86
                [16] = u9
                [17] = u24
                [18] = u31
                [19] = u82
            --]]
            if not u88 then
                u88 = true
                u54:Destroy()
                local u92 = (u10.CFrame.Position - p91.position).Magnitude <= 250 + u79 * 60
                if u92 then
                    u2:Create(u10, TweenInfo.new(0.7), {
                        ["FieldOfView"] = 58
                    }):Play()
                    u49.ScreenDim = u22()
                end
                if u76 then
                    u76:Stop()
                    u76:Destroy()
                end
                u83:GetScale()
                _G.PlaySound(u44, u5.SoulPrometheusUltBoom7)
                u20({
                    ["Range"] = 250 + u79 * 60,
                    ["Position"] = u44.CFrame.Position,
                    ["Magnitude"] = 2,
                    ["Roughness"] = 5,
                    ["Duration"] = 0.8,
                    ["FadeTime"] = 0.2,
                    ["FadeInTime"] = 0.1
                })
                u84:Destroy()
                local u93 = CFrame.new(p91.position, p91.position + p91.normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.01, 0)
                local v94 = u6.Start:Clone()
                local v95 = v94.PrimaryPart
                v95.CFrame = u93 * CFrame.Angles(0, 0, 0.00017453292519943296)
                v95.Attachment.PointLight.Brightness = 50
                v95.Attachment.PointLight.Range = 20
                v95.Attachment.Ground.TimeScale = 0
                v94:ScaleTo(u79)
                local v96 = v95.Size.X
                local v97 = v95.Size.X
                v95.Size = Vector3.new(v96, 1, v97)
                v94.Parent = workspace.Effects
                u2:Create(v95.Attachment.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Brightness"] = 0,
                    ["Range"] = v95.Attachment.PointLight.Range * 1.4,
                    ["Color"] = Color3.fromRGB(181, 104, 53)
                }):Play()
                local v98 = next
                local v99, v100 = v94:GetDescendants()
                for _, u101 in v98, v99, v100 do
                    if u101:IsA("ParticleEmitter") then
                        u101:Emit(u101:GetAttribute("EmitCount"))
                    elseif u101:IsA("PointLight") then
                        local v102 = u101.Brightness
                        u101.Brightness = 0
                        u2:Create(u101, TweenInfo.new(0.075, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                            ["Brightness"] = v102
                        }):Play()
                        task.delay(0.05, function() --[[ Line: 420 ]]
                            --[[
                            Upvalues:
                                [1] = u2
                                [2] = u101
                            --]]
                            u2:Create(u101, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                                ["Brightness"] = 0
                            }):Play()
                        end)
                    end
                end
                _G.destroy(v94, 5)
                _G.particleEnabled(u86, false)
                _G.destroy(u86, 4)
                local v103 = script.Bubble:Clone()
                v103.Size = v103.Size * u79
                v103.CFrame = u93
                local v104 = Instance.new("Highlight")
                v104.Enabled = false
                v104.Parent = v103
                v103.Transparency = v103.Transparency * u79
                v103.Parent = workspace.Effects
                u2:Create(v103, TweenInfo.new(0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Transparency"] = 5
                }):Play()
                _G.destroy(v103, 0.16)
                local v105 = {
                    Enum.EasingStyle.Sine,
                    Enum.EasingStyle.Quad,
                    Enum.EasingStyle.Quint,
                    Enum.EasingStyle.Cubic,
                    Enum.EasingStyle.Quart
                }
                local v106 = { u6.Swirl1, u6.Swirl2, u6.Swirl3 }
                for _ = 1, 16 do
                    local v107 = u9:NextNumber(20, 30) * u79 * 0.8
                    local v108 = u9:NextNumber(1, 1.5)
                    u9:NextNumber(0.75, 2.5)
                    local u109 = u9:NextNumber(35, 100) * u79 * 0.8
                    local u110 = v106[math.random(1, #v106)]:Clone()
                    u110.Transparency = 0
                    u110.Color = Color3.fromRGB(181, 104, 53)
                    local v111 = CFrame.Angles
                    local v112 = u9:NextNumber(-180, 180)
                    u110.CFrame = u93 * v111(0, math.rad(v112), 0) * CFrame.new(0, 3 + v108 / 4, 0)
                    local v113 = v107 * v108
                    u110.Size = Vector3.new(v107, v113, v107)
                    u110.Parent = workspace.Effects
                    local v114 = u2
                    local v115 = TweenInfo.new(0.33, v105[math.random(1, #v105)], Enum.EasingDirection.Out)
                    local v116 = {}
                    local v117 = u9:NextNumber(1, 5)
                    v116.Size = Vector3.new(u109, v117, u109)
                    v116.Position = u93.Position
                    v116.Color = Color3.fromRGB(255, 144, 75)
                    local u118 = v114:Create(u110, v115, v116)
                    local v119 = u2
                    local v120 = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                    local v121 = {}
                    local v122 = u110.Rotation
                    local v123 = ({ -360, 360 })[math.random(1, 2)]
                    v121.Rotation = v122 + Vector3.new(0, v123, 0)
                    v119:Create(u110, v120, v121):Play()
                    u118:Play()
                    _G.destroy(u110, 0.55)
                    task.delay(0.275, function() --[[ Line: 479 ]]
                        --[[
                        Upvalues:
                            [1] = u118
                            [2] = u109
                            [3] = u9
                            [4] = u2
                            [5] = u110
                            [6] = u93
                        --]]
                        u118:Cancel()
                        local v124 = u109 / 1.5 * u9:NextNumber(1.15, 1.5)
                        u9:NextNumber(10, 20)
                        local v125 = u2
                        local v126 = u110
                        local v127 = TweenInfo.new(0.275, Enum.EasingStyle.Circular, Enum.EasingDirection.In)
                        local v128 = {}
                        local v129 = u93.Position
                        local v130 = v124 / 2
                        v128.Position = v129 + Vector3.new(0, v130, 0)
                        v125:Create(v126, v127, v128):Play()
                        local v131 = u2
                        local v132 = u110
                        local v133 = TweenInfo.new(0.275, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                        local v134 = {}
                        local v135 = v124 + 40
                        v134.Size = Vector3.new(0, v135, 0)
                        v131:Create(v132, v133, v134):Play()
                        u2:Create(u110, TweenInfo.new(0.1375, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ["Color"] = Color3.fromRGB(255, 106, 0)
                        }):Play()
                    end)
                    task.wait(0.01)
                end
                task.wait(0.45)
                if u49.ScreenDim then
                    u2:Create(u49.ScreenDim, TweenInfo.new(0.6), {
                        ["Contrast"] = 0,
                        ["Saturation"] = 0,
                        ["Brightness"] = 0,
                        ["TintColor"] = Color3.new(1, 1, 1)
                    }):Play()
                    _G.destroy(u49.ScreenDim, 1)
                end
                v95.Attachment.Ground:Clear()
                if (u10.CFrame.Position - p91.position).Magnitude <= 125 + u79 * 60 then
                    task.spawn(u24)
                end
                if u92 then
                    u2:Create(u10, TweenInfo.new(0.4), {
                        ["FieldOfView"] = 100
                    }):Play()
                    task.delay(0.58, function() --[[ Line: 515 ]]
                        --[[
                        Upvalues:
                            [1] = u92
                            [2] = u2
                            [3] = u10
                        --]]
                        if u92 then
                            u2:Create(u10, TweenInfo.new(0.6), {
                                ["FieldOfView"] = 70
                            }):Play()
                        end
                    end)
                end
                u20({
                    ["Range"] = 250 + u79 * 60,
                    ["Position"] = u44.CFrame.Position,
                    ["Magnitude"] = 2,
                    ["Roughness"] = 7,
                    ["Duration"] = 0.8,
                    ["FadeTime"] = 0.2,
                    ["FadeInTime"] = 0.1
                })
                _G.PlaySound(u93, u5.SoulPrometheusUltBoom8)
                local v136 = u6.Explosion:Clone()
                v136:PivotTo(u93)
                v136:PivotTo(v136:GetPivot() * CFrame.Angles(0, math.random(-360, 360), 0))
                v136:ScaleTo(u79)
                if p91.hitPart then
                    _G.recolorParticles(v136, p91.hitPart.Color)
                end
                v136.Parent = workspace.Effects
                _G.destroy(v136, 6)
                local v137 = script.Bubble:Clone()
                v137.CFrame = u93
                local v138 = Instance.new("Highlight")
                v138.Enabled = false
                v138.Parent = v137
                v137.Size = Vector3.new(20, 20, 20)
                v137.Transparency = v137.Transparency * u79
                v137.Parent = workspace.Effects
                u2:Create(v137, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Size"] = script.Bubble.Size * u79 * 1.5,
                    ["Transparency"] = 1
                }):Play()
                _G.destroy(v137, 0.3)
                local v139 = v136.PrimaryPart.Position
                local v140 = u79 * 3
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 20 + v140,
                    ["Position"] = v139 + Vector3.new(0, 2, 0),
                    ["DistanceRandomness"] = Vector2.new(0.3, 1),
                    ["Duration"] = 5,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 20 * v140,
                    ["Direction"] = -p91.normal * 45,
                    ["Angle"] = -1.0471975511965976
                })
                local v141 = u9:NextNumber(1.5, 2.4) * v140
                local v142 = _G.PlayEffect
                local v143 = {
                    ["PartCount"] = 20,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * v140,
                    ["Position"] = v139
                }
                local v144 = 15 * v140
                v143.Direction = Vector3.new(0, v144, 0)
                v143.RaycastDirection = -p91.normal * 35
                v143.Size = Vector3.new(0.4, 0.4, 0.4) * v141
                v143.TrailEnabled = true
                v142("RockDebris", nil, v143)
                for _, v145 in v136:GetDescendants() do
                    if v145:IsA("ParticleEmitter") then
                        v145:Emit(v145:GetAttribute("EmitCount") or 25)
                        v145.Enabled = false
                    elseif v145:IsA("PointLight") then
                        u2:Create(v145, TweenInfo.new(1.4), {
                            ["Range"] = 0
                        }):Play()
                    end
                end
                local v146 = { Enum.EasingStyle.Cubic, Enum.EasingStyle.Quart, Enum.EasingStyle.Circular }
                for _ = 1, 6 do
                    for v147 = 1, 2 do
                        local u148 = v106[math.random(1, #v106)]:Clone()
                        u148.Transparency = 0
                        local u149 = u9:NextNumber(0.35, 0.75)
                        local v150 = u9:NextNumber(15, 30) * u79
                        local v151 = u9:NextNumber(65, 100) * u79
                        local v152 = Color3.fromRGB(0, 0, 0)
                        local v153 = v146[math.random(1, #v146)]
                        local v154
                        if v147 == 2 then
                            v151 = u9:NextNumber(100, 125)
                            u149 = u149 / 2
                            v152 = Color3.fromRGB(255, 85, 0)
                            u148.Transparency = u9:NextNumber(0.85, 0.975)
                            v153 = Enum.EasingStyle.Sine
                            v154 = {
                                -45,
                                45,
                                -90,
                                90
                            }
                        else
                            v154 = {
                                -90,
                                90,
                                -180,
                                180
                            }
                        end
                        local v155 = u93 * CFrame.new(0, v150 / 2, 0)
                        local v156 = CFrame.Angles
                        local v157 = u9:NextNumber(-179, 179)
                        local u158 = v155 * v156(0, math.rad(v157), 0)
                        u148.CFrame = u158
                        u148.Color = v152
                        local v159 = v150 / 6
                        local v160 = v150 / 6
                        u148.Size = Vector3.new(v159, v150, v160)
                        u148.Parent = workspace.Effects
                        local v161 = v154[math.random(1, #v154)]
                        local u162 = math.rad(v161)
                        local v163 = u93.Position
                        local v164 = v151 / u9:NextNumber(3, 5)
                        local u165 = v163 + Vector3.new(0, v164, 0)
                        local u166 = tick()
                        local u167 = u158.Position
                        local u168 = nil
                        u168 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 632 ]]
                            --[[
                            Upvalues:
                                [1] = u148
                                [2] = u166
                                [3] = u149
                                [4] = u167
                                [5] = u165
                                [6] = u162
                                [7] = u158
                                [8] = u168
                            --]]
                            if u148 and u148.Parent then
                                local v169 = tick() - u166
                                local v170 = v169 / u149
                                local v171 = math.min(v170, 1)
                                local v172 = u167:Lerp(u165, v171)
                                local v173 = u162 * (v169 / u149) * 2
                                u148.CFrame = CFrame.new(v172) * (u158 - u158.Position) * CFrame.Angles(0, v173, 0)
                                if v171 >= 1 then
                                    u168:Disconnect()
                                    return
                                end
                            else
                                u168:Disconnect()
                            end
                        end)
                        local v174 = u2
                        local v175 = TweenInfo.new(u149, v153, Enum.EasingDirection.Out)
                        local v176 = {}
                        local v177 = v151 / u9:NextNumber(1, 5)
                        v176.Size = Vector3.new(v151, v177, v151)
                        v174:Create(u148, v175, v176):Play()
                        u2:Create(u148, TweenInfo.new(u149, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1,
                            ["Color"] = v152
                        }):Play()
                        _G.destroy(u148, u149)
                    end
                end
                if u49.FX_Travel then
                    u31(u49.FX_Travel, false)
                    task.delay(4, u49.FX_Travel.Destroy, u49.FX_Travel)
                end
                u83:ScaleTo(1)
                task.delay(0.5, function() --[[ Line: 661 ]]
                    --[[
                    Upvalues:
                        [1] = u49
                        [2] = u83
                        [3] = u82
                        [4] = u31
                    --]]
                    if u49.TempStop then
                        u49.TempStop:Destroy()
                    end
                    u83:SetAttribute("CustomMovement", nil)
                    task.wait(0.5)
                    if not u82:FindFirstChild("PrometheusTempStop") then
                        u31(u83.AttachedPart.SkillTrail, false)
                    end
                end)
            end
        end
        local function u225(p179) --[[ Line: 676 ]]
            --[[
            Upvalues:
                [1] = u89
                [2] = u85
                [3] = u83
                [4] = u88
                [5] = u6
                [6] = u79
                [7] = u86
                [8] = u27
                [9] = u44
                [10] = u5
                [11] = u20
                [12] = u2
                [13] = u9
            --]]
            if not u89 then
                u89 = u85.CFrame
            end
            if p179.bouncesRemaining == 1 then
                local v180 = 50 * ((u83:GetScale() + p179.scaleIncrease) * 0.65) / 400 * 2.3 / 1
                task.delay(v180, function() --[[ Line: 706 ]]
                    --[[
                    Upvalues:
                        [1] = u88
                        [2] = u6
                        [3] = u79
                        [4] = u85
                        [5] = u86
                        [6] = u27
                        [7] = u44
                        [8] = u5
                    --]]
                    if not u88 then
                        local v181 = u6.FX_Final:Clone()
                        v181:ScaleTo(u79 * 1.05)
                        v181:PivotTo(u85:GetPivot())
                        v181.Parent = workspace.Effects
                        local v182 = u86.Part.L4
                        v182.Rate = v182.Rate * 2
                        u27(v181)
                        _G.destroy(v181, 5)
                        _G.PlaySound(u44, u5.SoulPrometheusUltBoomInAir6).Parent = u44
                    end
                end)
            end
            if p179.bouncesRemaining > 0 then
                u20({
                    ["Range"] = 125 + u79 * 60,
                    ["Position"] = u44.CFrame.Position,
                    ["Magnitude"] = 0.18,
                    ["Roughness"] = 14,
                    ["Duration"] = 0.3,
                    ["FadeTime"] = 0.09,
                    ["FadeInTime"] = 0.05
                })
                local u183 = CFrame.new(p179.position, p179.position + p179.normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.1, 0)
                local v184 = u6.Bounce:Clone()
                v184:PivotTo(u183)
                local v185 = u83:GetScale() - 2 + u79 / 150 + 0.8
                local v186 = math.max(1, v185)
                v184:ScaleTo(v186)
                if p179.hitPart then
                    _G.recolorParticles(v184, p179.hitPart.Color)
                end
                v184.Parent = workspace.Effects
                u2:Create(v184.PrimaryPart.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Range"] = v184.PrimaryPart.PointLight.Range * 2,
                    ["Brightness"] = 0
                }):Play()
                _G.destroy(v184, 5)
                _G.customEmit(v184)
                local v187 = v184.PrimaryPart.Position
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 17,
                    ["Position"] = v187 + Vector3.new(0, 2, 0),
                    ["DistanceRandomness"] = Vector2.new(0.3, 1),
                    ["Duration"] = 4,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 20 * v186,
                    ["Direction"] = -p179.normal * 45,
                    ["Angle"] = -0.7853981633974483
                })
                local v188 = u9:NextNumber(1.5, 2.4) * v186
                local v189 = _G.PlayEffect
                local v190 = {
                    ["PartCount"] = 7,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * math.clamp(v188, 1, 4),
                    ["Position"] = v187
                }
                local v191 = 15 * v186
                v190.Direction = Vector3.new(0, v191, 0)
                v190.RaycastDirection = -p179.normal * 35
                v190.Size = Vector3.new(0.4, 0.4, 0.4) * v188
                v190.TrailEnabled = true
                v189("RockDebris", nil, v190)
                local v192 = {
                    Enum.EasingStyle.Sine,
                    Enum.EasingStyle.Quad,
                    Enum.EasingStyle.Quint,
                    Enum.EasingStyle.Cubic,
                    Enum.EasingStyle.Quart
                }
                local v193 = { u6.Swirl1, u6.Swirl2, u6.Swirl3 }
                for _ = 1, 2 do
                    local v194 = v184:GetScale()
                    local u195 = p179.bouncesRemaining == 1 and 0.6 or 0.4
                    local _ = u9:NextNumber(20, 30) * v194 * 0.55
                    local v196 = u9:NextNumber(1, 1.5)
                    u9:NextNumber(0.75, 2.5)
                    local u197 = u9:NextNumber(50, 60) * v194 * 0.65
                    local u198 = v193[math.random(1, #v193)]:Clone()
                    u198.Transparency = -2
                    u198.Color = Color3.fromRGB(181, 104, 53)
                    local v199 = CFrame.Angles
                    local v200 = u9:NextNumber(-180, 180)
                    u198.CFrame = u183 * v199(0, math.rad(v200), 0) * CFrame.new(0, 3 + v196 / 7, 0)
                    local v201 = u197 / 2
                    local v202 = 2 + u197 / 15
                    local v203 = u197 / 2
                    u198.Size = Vector3.new(v201, v202, v203)
                    u198.Parent = workspace.Effects
                    local u204 = u2:Create(u198, TweenInfo.new(u195 / 2 * 1.2, v192[math.random(1, #v192)], Enum.EasingDirection.Out), {
                        ["Color"] = Color3.fromRGB(255, 144, 75)
                    })
                    local v205 = u2
                    local v206 = TweenInfo.new(u195, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
                    local v207 = {}
                    local v208 = u198.Rotation
                    local v209 = ({ -360, 360 })[math.random(1, 2)]
                    v207.Rotation = v208 + Vector3.new(0, v209, 0)
                    v205:Create(u198, v206, v207):Play()
                    u204:Play()
                    local v210 = u2
                    local v211 = TweenInfo.new(u195, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                    local v212 = {}
                    local v213 = u198.Size.Y
                    v212.Size = Vector3.new(u197, v213, u197)
                    v212.Position = u183.Position
                    v212.Transparency = 0
                    v210:Create(u198, v211, v212):Play()
                    _G.destroy(u198, u195)
                    task.delay(u195 / 2, function() --[[ Line: 815 ]]
                        --[[
                        Upvalues:
                            [1] = u204
                            [2] = u197
                            [3] = u9
                            [4] = u2
                            [5] = u198
                            [6] = u195
                            [7] = u183
                        --]]
                        u204:Cancel()
                        local v214 = u197 / 1.5 * u9:NextNumber(1.15, 1.5)
                        u9:NextNumber(10, 20)
                        local v215 = u2
                        local v216 = u198
                        local v217 = TweenInfo.new(u195 / 2, Enum.EasingStyle.Circular, Enum.EasingDirection.In)
                        local v218 = {}
                        local v219 = u183.Position
                        local v220 = v214 / 4
                        v218.Position = v219 + Vector3.new(0, v220, 0)
                        v215:Create(v216, v217, v218):Play()
                        u2:Create(u198, TweenInfo.new(u195 / 4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ["Color"] = Color3.fromRGB(255, 106, 0)
                        }):Play()
                    end)
                end
                u83:ScaleTo(u83:GetScale() + p179.scaleIncrease)
                local v221 = _G.PlaySound
                local v222 = u44
                local v223 = u5
                local v224 = 6 - p179.bouncesRemaining
                v221(v222, v223["SoulPrometheusUltBoom" .. math.clamp(v224, 1, 5)]).Parent = u44
            end
        end
        u84:AddTask(u3.Heartbeat:Connect(function(p226) --[[ Line: 831 ]]
            --[[
            Upvalues:
                [1] = u85
                [2] = u88
                [3] = u84
                [4] = u81
                [5] = u80
                [6] = u178
                [7] = u87
                [8] = u90
                [9] = u9
                [10] = u78
                [11] = u225
                [12] = u89
                [13] = u50
                [14] = u86
                [15] = u6
                [16] = u83
                [17] = u2
                [18] = u49
                [19] = u32
            --]]
            if u85 and u85.Parent then
                local v227 = (workspace:GetServerTimeNow() - u81) * 1
                local v228 = u80.totalDuration
                local v229 = math.clamp(v227, 0, v228)
                if u80.totalDuration <= v229 or u88 then
                    if not u88 and u80.finalExplosionPoint then
                        u178(u80.finalExplosionPoint)
                    end
                else
                    if u87 <= #u80.bouncePoints then
                        local v230 = u80.bouncePoints[u87]
                        if v230.time <= v229 then
                            local v231 = CFrame.Angles
                            local v232 = u9:NextNumber(-3, 3) * u78.BounceRotateSpeed * p226
                            local v233 = math.rad(v232)
                            local v234 = u9:NextNumber(-3, 3) * u78.BounceRotateSpeed * p226
                            local v235 = math.rad(v234)
                            local v236 = u9:NextNumber(-3, 3) * u78.BounceRotateSpeed * p226
                            u90 = v231(v233, v235, (math.rad(v236)))
                            u87 = u87 + 1
                            pcall(u225, v230)
                        end
                    end
                    if u80.allPositions and #u80.allPositions > 0 then
                        local v237 = v229 / u80.totalDuration * (#u80.allPositions - 1)
                        local v238 = math.floor(v237) + 1
                        local v239 = v238 + 1
                        local v240 = #u80.allPositions
                        local v241 = math.min(v239, v240)
                        local v242 = v237 - math.floor(v237)
                        local v243 = #u80.allPositions
                        local v244 = math.min(v238, v243)
                        local v245 = math.max(1, v244)
                        local v246 = #u80.allPositions
                        local v247 = math.min(v241, v246)
                        local v248 = math.max(1, v247)
                        local v249 = nil
                        local v250 = nil
                        if u80.allPositions[v245] and (u80.allPositions[v248] and v245 ~= v248) then
                            local v251 = u80.allPositions[v245].position
                            local v252 = u80.allPositions[v248].position
                            local v253 = u80.allPositions[v245].velocity or Vector3.new(0, 0, 1)
                            local v254 = u80.allPositions[v248].velocity or Vector3.new(0, 0, 1)
                            v249 = v251:Lerp(v252, v242)
                            v250 = v253:Lerp(v254, v242)
                        elseif u80.allPositions[v245] then
                            local v255 = u80.allPositions[v245]
                            v249 = v255.position
                            v250 = v255.velocity or Vector3.new(0, 0, 1)
                        end
                        if v249 and v250 then
                            if u89 then
                                u89 = u89 * u90
                                local v256 = u89.LookVector
                                u85.CFrame = CFrame.new(v249, v249 + v256)
                            else
                                u85.CFrame = CFrame.new(v249, v249 + v250)
                            end
                            local v257 = u50:FindFirstChild("AttachedPart")
                            if not v257 then
                                return
                            end
                            local v258 = CFrame.new(0, 0, -v257.Size.X / 2)
                            local v259 = v257.Position
                            u86.PrimaryPart.CFrame = CFrame.new(v259, v259 + v250) * v258
                            if v250.Y >= 0 then
                                _G.particleEnabled(u86, false)
                            else
                                _G.particleEnabled(u86, true)
                                local v260 = u6.travelSwirl:Clone()
                                local v261 = CFrame.new(v259, v259 + v250) * v258 * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
                                local v262 = CFrame.Angles
                                local v263 = u9:NextNumber(0, 360)
                                v260.CFrame = v261 * v262(0, math.rad(v263), 0)
                                v260.Size = v260.Size * u83:GetScale() * u9:NextNumber(0.8, 1.1)
                                local v264 = { Color3.fromRGB(170, 75, 37), Color3.fromRGB(179, 96, 51), Color3.fromRGB(213, 115, 61) }
                                v260.Color = v264[math.random(1, #v264)]
                                v260.Parent = workspace.Effects
                                local v265 = u2
                                local v266 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                local v267 = {}
                                local v268 = v260.CFrame
                                local v269 = CFrame.Angles
                                local v270 = u9:NextNumber(45, 180)
                                v267.CFrame = v268 * v269(0, math.rad(v270), 0)
                                v267.Size = v260.Size * u9:NextNumber(0.5, 0.7)
                                v265:Create(v260, v266, v267):Play()
                                _G.destroy(v260, u9:NextNumber(0.1, 0.125))
                            end
                            if u49.FX_Travel then
                                u49.FX_Travel.PrimaryPart.CFrame = u50.AttachedPart.CFrame
                                local v271 = u49.FX_Travel.FX.Floor
                                local v272 = workspace:Raycast(u85.Position, Vector3.new(0, -25, 0), u32)
                                if v272 then
                                    v271.WorldCFrame = CFrame.new(v272.Position, v272.Position + v272.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                                end
                                if v272 and v272.Instance then
                                    _G.recolorParticles(u49.FX_Travel, v272.Instance.Color)
                                    _G.particleEnabled(v271, true)
                                else
                                    _G.particleEnabled(v271, false)
                                end
                            end
                        end
                    end
                end
            else
                if not u88 then
                    u88 = true
                    u84:Destroy()
                end
                return
            end
        end))
    end)
end
return v1