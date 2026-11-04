 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local v4 = game:GetService("ReplicatedStorage")
script:WaitForChild("Animations")
script:WaitForChild("Models")
script:WaitForChild("SFX")
local u5 = script:WaitForChild("VFX")
script:WaitForChild("Other")
workspace:WaitForChild("Effects")
local u6 = require(script.Parent:WaitForChild("Shared"))
local u7 = require(script.Parent.NapSoulLightning)
local u8 = require(game.ReplicatedStorage.Modules.CameraShaker)
local u9 = require(v4.Modules.VFXUtility.highlight_emit)
local u10 = Random.new()
local u11 = RaycastParams.new()
u11.FilterType = Enum.RaycastFilterType.Include
u11.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
function v1.start(_, u12, p13) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u10
        [4] = u11
        [5] = u7
        [6] = u8
        [7] = u9
        [8] = u6
        [9] = u3
    --]]
    local v14 = p13.State
    local u15 = u12:FindFirstChild("Soul CleaverSword")
    local v16 = u12:GetAttribute("SoulCleaverBlazed") == true
    local v17 = u12 == game.Players.LocalPlayer.Character
    local u18 = script.SFX.Normal
    if v14 ~= "Hold" then
        if v14 == "Shoot" then
            local u19 = p13.startCFrame
            local u20 = p13.Speed
            local v21 = p13.serverTime
            local u22 = p13.SlashStart
            local _ = workspace:GetServerTimeNow() - v21
            local u23, v24, v25, u26
            if u12:GetAttribute("SoulCleaverBlazed") == true then
                u23 = u5.FireVariants.FireHakiProjectile:Clone()
                v24 = u5.FireVariants.FireProjectileHakiBurst:Clone()
                ColorSequence.new(Color3.fromRGB(255, 98, 55))
                local _ = u5.FireVariants.FireElecHit
                v25 = u5.FireVariants.FireInitialHakaiSlash:Clone()
                u26 = Color3.fromRGB(255, 135, 105)
            else
                u23 = u5.HakiProjectile:Clone()
                v24 = u5.ProjectileHakiBurst:Clone()
                ColorSequence.new(Color3.fromRGB(195, 145, 255))
                local _ = u5.ElecHit
                v25 = u5.InitialHakaiSlash:Clone()
                u26 = Color3.fromRGB(195, 145, 255)
            end
            v25.CFrame = u12.HumanoidRootPart.CFrame * CFrame.new(0, 0, -9) * CFrame.Angles(0, 3.141592653589793, 0)
            v25.Parent = workspace.Effects
            _G.customEmit(v25)
            _G.destroy(v25, 3)
            u6.LightningSlash(u12.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0.2617993877991494), v16)
            if v17 == true then
                _G.camShake:StopSustained(0.2)
            end
            local v27 = u18.NapoleonIkokuShoot
            if p13.Charged then
                v27 = u18.NapoleonIkokuChargedShoot
            end
            local v28 = _G.PlaySound(u12.PrimaryPart, v27)
            task.wait(u22 - workspace:GetServerTimeNow())
            u23.CFrame = u19
            u23.Parent = workspace.Effects
            v24.CFrame = u23.CFrame
            v24.Parent = workspace.Effects
            _G.customEmit(v24)
            _G.destroy(v24, 3)
            _G.shakenear(u12.PrimaryPart.Position, 125, 75, 45, -0.5)
            v28.Parent = u23
            local u29 = p13.Duration or 1
            local u30 = false
            local u31 = RaycastParams.new()
            u31.FilterType = Enum.RaycastFilterType.Include
            u31.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
            task.spawn(function() --[[ Line: 395 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u23
                    [3] = u3
                    [4] = u31
                    [5] = u22
                    [6] = u29
                    [7] = u20
                    [8] = u30
                    [9] = u2
                    [10] = u10
                    [11] = u19
                    [12] = u26
                --]]
                local v32 = { u5.Spikey1, u5.Spikey2 }
                local v33 = u23:GetDescendants()
                local u34 = nil
                local u35 = 0
                local u36 = u23
                local v48 = u3.Heartbeat:Connect(function() --[[ Line: 404 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u34
                        [3] = u36
                        [4] = u31
                    --]]
                    if tick() - u35 >= 0.05 then
                        u34 = workspace:Raycast(u36.Position + Vector3.new(0, 1, 0), Vector3.new(0, -15, 0), u31)
                        u35 = tick()
                        if u34 and u34.Instance then
                            local v37 = u36
                            local v38 = u34.Position
                            local v39 = u34.Instance
                            local v40 = _G.PlayEffect
                            local v41 = {}
                            local v42 = math.random(-4, 4)
                            local v43 = math.random
                            v41.Position = v38 + Vector3.new(v42, 0, v43(-4, 4))
                            v41.Velocity = (Vector3.new(0, 1, 0)):Cross(v37.CFrame.LookVector) * (math.random(2) == 1 and 1 or -1) * math.random(25, 35) + Vector3.new(0, 1, 0) * math.random(30, 90)
                            v41.AngularVelocity = Random.new():NextUnitVector() * 3
                            v41.TargetPart = u34.Instance
                            v41.Material = v39.Material
                            local v44 = math.random(2)
                            local v45 = math.random(2)
                            local v46 = math.random
                            v41.Size = Vector3.new(v44, v45, v46(2))
                            v41.Color = v39.Color
                            v40("CreateRock", nil, v41)
                            local v47 = script.Dust:Clone()
                            _G.recolorParticles(v47, u34.Instance.Color)
                            v47.CFrame = CFrame.new(u34.Position, (u36.CFrame * CFrame.new(0, 0, -30)).Position)
                            v47.Anchored = true
                            v47.Parent = workspace.Effects
                            _G.customEmit(v47)
                            _G.destroy(v47, 5)
                        end
                    end
                end)
                local v49 = tick()
                while true do
                    local v50 = workspace:GetServerTimeNow() - u22
                    local v51 = u29
                    local v52 = u20 * math.clamp(v50, 0, v51)
                    local v53 = v50 * 360
                    if u29 <= v50 then
                        u30 = true
                        for _, v54 in v33 do
                            if v54:IsA("ParticleEmitter") then
                                v54.Enabled = false
                            elseif v54:IsA("Beam") then
                                u2:Create(v54, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                }):Play()
                            end
                        end
                        u2:Create(u23.Light.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            ["Brightness"] = 0
                        }):Play()
                        _G.destroy(u23, 1)
                        break
                    end
                    for _, v55 in v33 do
                        if v55:IsA("Beam") then
                            v55.CurveSize1 = u10:NextNumber(7.5, 12.5)
                            v55.Width0 = u10:NextNumber(1.5, 3.5)
                            v55.Width1 = u10:NextNumber(15, 25)
                        end
                    end
                    u23.CFrame = u19 * CFrame.new(0, 0, -v52) * CFrame.Angles(0, 0, (math.rad(v53)))
                    if tick() - v49 >= 0.1 then
                        v49 = tick()
                        for v56 = 1, 2 do
                            local v57 = u10:NextNumber(5, 15)
                            local v58 = u10:NextNumber(25, 55)
                            local v59
                            if v56 == 1 then
                                v59 = v32[math.random(1, #v32)]:Clone()
                                if v59.Name == "Spikey2" then
                                    local v60 = u23.CFrame
                                    local v61 = CFrame.Angles
                                    local v62 = u10:NextNumber(-180, 180)
                                    v59.CFrame = v60 * v61(0, 3.141592653589793, (math.rad(v62)))
                                else
                                    local v63 = u23.CFrame
                                    local v64 = CFrame.Angles
                                    local v65 = u10:NextNumber(-180, 180)
                                    v59.CFrame = v63 * v64(0, 0, (math.rad(v65)))
                                end
                                local v66 = u2
                                local v67 = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                                local v68 = {
                                    ["CFrame"] = v59.CFrame * CFrame.new(0, 0, 5)
                                }
                                local v69 = v59.Size.Z * 5
                                v68.Size = Vector3.new(v58, v58, v69)
                                v68.Transparency = 1
                                v68.Color = Color3.fromRGB(32, 7, 34)
                                v66:Create(v59, v67, v68):Play()
                            else
                                v59 = u5.Swirly1:Clone()
                                local v70 = u23.CFrame
                                local v71 = CFrame.Angles
                                local v72 = u10:NextNumber(-180, 180)
                                v59.CFrame = v70 * v71(0, 0, (math.rad(v72)))
                                local v73 = u2
                                local v74 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                local v75 = {
                                    ["CFrame"] = v59.CFrame * CFrame.new(0, 0, 5) * CFrame.Angles(0, 0, 1.5707963267948966)
                                }
                                local v76 = v59.Size.Z * 5
                                v75.Size = Vector3.new(v58, v58, v76)
                                v75.Transparency = 1
                                v75.Color = Color3.fromRGB(32, 7, 34)
                                v73:Create(v59, v74, v75):Play()
                            end
                            v59.Transparency = 0
                            v59.Color = u26
                            local v77 = v57 * u10:NextNumber(1, 1.5)
                            v59.Size = Vector3.new(v57, v57, v77)
                            v59.Parent = workspace.Effects
                            _G.destroy(v59, 0.5)
                        end
                    end
                    task.wait()
                    if u23 == nil or u23.Parent == nil then
                        break
                    end
                end
                if v48 then
                    v48:Disconnect()
                end
            end)
            local v78 = {
                u5.Swirl1,
                u5.Swirl2,
                u5.Swirl3,
                u5.Swirl4
            }
            local v79 = {
                -90,
                90,
                -180,
                180
            }
            for _ = 1, 2 do
                local v80 = u10:NextNumber(0.5, 1)
                local v81 = u5.Swirl5:Clone()
                v81.Transparency = 0
                v81.Color = u26
                local v82 = u23.CFrame
                local v83 = CFrame.Angles
                local v84 = u10:NextNumber(-180, 180)
                v81.CFrame = v82 * v83(1.5707963267948966, math.rad(v84), 0)
                v81.Size = Vector3.new(0, 0, 0)
                v81.Parent = workspace.Effects
                local v85 = u2
                local v86 = TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
                local v87 = {}
                local v88 = v81.CFrame * CFrame.new(0, 20, 0)
                local v89 = CFrame.Angles
                local v90 = v79[math.random(1, #v79)]
                v87.CFrame = v88 * v89(0, math.rad(v90), 0)
                local v91 = 25 * v80
                local v92 = 50 * v80
                local v93 = 25 * v80
                v87.Size = Vector3.new(v91, v92, v93)
                v87.Transparency = 1
                v87.Color = Color3.fromRGB(0, 0, 0)
                v85:Create(v81, v86, v87):Play()
                task.delay(0.25, v81.Destroy, v81)
            end
            for _ = 1, 3 do
                local v94 = u10:NextNumber(0.65, 1.5)
                local v95 = v78[math.random(1, #v78)]:Clone()
                v95.Transparency = 0.9
                v95.Color = Color3.fromRGB(255, 255, 255)
                local v96 = u23.CFrame
                local v97 = CFrame.Angles
                local v98 = u10:NextNumber(-180, 180)
                v95.CFrame = v96 * v97(1.5707963267948966, math.rad(v98), 0)
                v95.Size = Vector3.new(0, 0, 0)
                v95.Parent = workspace.Effects
                local v99 = u2
                local v100 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                local v101 = {}
                local v102 = v95.CFrame * CFrame.new(0, 5 * u10:NextNumber(1, 2.5), 0)
                local v103 = CFrame.Angles
                local v104 = v79[math.random(1, #v79)]
                v101.CFrame = v102 * v103(0, math.rad(v104), 0)
                local v105 = 25 * v94
                local v106 = 25 * v94
                local v107 = 25 * v94
                v101.Size = Vector3.new(v105, v106, v107)
                v101.Transparency = 1
                v99:Create(v95, v100, v101):Play()
                task.delay(0.5, v95.Destroy, v95)
            end
        end
        return
    end
    local u108 = u12:GetAttribute("SoulCleaverBlazed") == true
    local v109 = p13.ServerStartCharge
    local u110, u111, v112
    if u108 == true then
        u110 = u5.FireVariants.FireElectricityCharging:Clone()
        u110.Name = "ElectricityCharging"
        u111 = ColorSequence.new(Color3.fromRGB(255, 122, 55))
        v112 = u5.FireVariants.FireGroundElectricityCharge
        local _ = u5.FireVariants.FireElecHit
    else
        u110 = u5.ElectricityCharging:Clone()
        u111 = ColorSequence.new(Color3.fromRGB(102, 42, 255))
        v112 = u5.GroundElectricityCharge
        local _ = u5.ElecHit
    end
    if u15 then
        u110.Weld.Part0 = u15.RootPart
        for _, v113 in pairs(u110:GetDescendants()) do
            if v113:IsA("ParticleEmitter") then
                v113.Rate = 1
                v113.Enabled = true
            end
        end
        u110.Parent = u15
    else
        u110:Destroy()
        u110 = nil
    end
    _G.PlaySound(u12.PrimaryPart, u18.NapoleonIkokuStart)
    local u114
    if u15 then
        u114 = u15:QueryDescendants("BasePart")
    else
        u114 = nil
    end
    local u115 = tick()
    local u116 = false
    local u117 = nil
    local u118 = 0.1
    local v128 = task.spawn(function() --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u118
            [2] = u116
            [3] = u115
            [4] = u117
            [5] = u2
            [6] = u18
            [7] = u12
            [8] = u15
            [9] = u114
            [10] = u10
            [11] = u11
            [12] = u7
            [13] = u111
            [14] = u108
        --]]
        while task.wait(u118) do
            if u116 == false and (tick() - u115 >= 2 and u117) then
                u2:Create(u117, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                }):Play()
                _G.destroy(u117, 0.25)
                u117 = u18.NapoleonIkokuChargeLoop:Clone()
                u117.Parent = u12.PrimaryPart
                u117:Play()
                u116 = true
            end
            if u15 then
                local u119 = u114[math.random(#u114)]
                local u120 = CFrame.new(u119.Size * u10:NextUnitVector() / 2)
                local v121 = u119.CFrame * u120.Position
                local v122 = u10:NextUnitVector() * 15 - Vector3.new(0, 15, 0)
                local u123 = workspace:Raycast(v121, v122, u11)
                if u123 then
                    local v124 = u123.Position
                    local u125 = (Vector3.new(0, 1, 0)):Cross((v124 - v121).Unit):Cross(Vector3.new(0, 1, 0))
                    local u126 = Instance.new("Attachment")
                    u126.WorldCFrame = CFrame.lookAlong(v121, u125)
                    u126.Parent = workspace.Terrain
                    local v127 = Instance.new("Attachment")
                    v127.WorldCFrame = CFrame.lookAlong(v124, -u125)
                    v127.Parent = workspace.Terrain
                    u7.new({
                        ["Attachment0"] = u126,
                        ["Attachment1"] = v127,
                        ["CurveSize0"] = 5,
                        ["CurveSize1"] = 5,
                        ["Width"] = NumberRange.new(0.5, 1),
                        ["Duration"] = 0.1,
                        ["BeamColor"] = u111
                    })
                    task.delay(0.1, function() --[[ Line: 151 ]]
                        --[[
                        Upvalues:
                            [1] = u123
                            [2] = u108
                        --]]
                        _G.PlayEffect("NapLightningHitFloor", nil, u123, u108)
                    end)
                    task.delay(1, v127.Destroy, v127)
                    task.delay(1, u126.Destroy, u126)
                    task.spawn(function() --[[ Line: 159 ]]
                        --[[
                        Upvalues:
                            [1] = u126
                            [2] = u119
                            [3] = u120
                            [4] = u125
                        --]]
                        while u126.Parent do
                            u126.WorldCFrame = CFrame.lookAlong(u119.CFrame * u120.Position, u125)
                            task.wait()
                        end
                    end)
                end
            end
        end
    end)
    local u129 = nil
    task.wait(0.25)
    u117 = u18.NapoleonIkokuChargeLoop:Clone()
    u117.Parent = u12.PrimaryPart
    u117:Play()
    if v17 == true then
        _G.camShake:ShakeSustain(u8.Presets.HakaiSlashHold)
    end
    local v130 = workspace
    local v131 = u12.HumanoidRootPart.Position
    local v132 = -(u12.PrimaryPart.Size.Y + u12.Humanoid.HipHeight)
    local v133 = v130:Raycast(v131, Vector3.new(0, v132, 0), u11)
    local v134, v135
    if v133 then
        u129 = v112:Clone()
        u129.Position = v133.Position
        v134 = u117
        v135 = u118
        for _, v136 in u129:GetDescendants() do
            if v136:IsA("ParticleEmitter") then
                v136.Enabled = true
                local v137 = u2:Create(v136, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    ["Rate"] = v136.Rate
                })
                v136.Rate = 1
                v137:Play()
            end
        end
        u129.Parent = workspace.Effects
    else
        v134 = u117
        v135 = u118
    end
    local u138 = false
    if v128 ~= nil then
        task.spawn(function() --[[ Line: 202 ]]
            --[[
            Upvalues:
                [1] = u138
                [2] = u110
                [3] = u129
            --]]
            for v139 = 1, 5 do
                if u138 == true then
                    break
                end
                if u110 then
                    for _, v140 in pairs(u110:QueryDescendants("ParticleEmitter")) do
                        v140.Rate = v140.Rate + 10
                        v140:Emit(v140.Rate / 4)
                    end
                end
                if u138 == true and u129 then
                    for _, v141 in u129:GetDescendants() do
                        if v141:IsA("ParticleEmitter") or v141:IsA("Beam") then
                            v141.Enabled = false
                        end
                    end
                    task.delay(1, u129.Destroy, u129)
                end
                task.wait(0.1 / v139)
            end
            if u138 ~= true then
            end
        end)
    end
    tick()
    local v142 = false
    while true do
        if v142 == false and workspace:GetServerTimeNow() - v109 >= 1 then
            u2:Create(v134, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
            _G.destroy(v134, 0.25)
            u117 = u18.NapoleonIkokuChargeLoop:Clone()
            u117.Parent = u12.PrimaryPart
            u117:Play()
            v142 = true
            local v143 = u111.Keypoints[1].Value
            u9.tweenHighlight(u12, v143, v143, 0.25, Enum.HighlightDepthMode.Occluded, "In", 0.1)
            local v144 = u12.PrimaryPart.CFrame.UpVector
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 15,
                ["Position"] = u12.PrimaryPart.Position,
                ["DistanceRandomness"] = Vector2.new(0.4, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 8,
                ["Direction"] = -v144 * 15,
                ["Angle"] = -0.7853981633974483
            })
            local v145 = u12.PrimaryPart.Size.Y + u12.Humanoid.HipHeight
            local v146, v147, v148 = _G.getRayFloor(u12.PrimaryPart.CFrame, v145)
            if v146 then
                local v149 = CFrame.new(v147, v147 + v148) * CFrame.Angles(3.141592653589793, 0, 0)
                local v150 = Instance.new("Model")
                local v151 = script.Parent.NapHahaba.ChargeVFX.Hit
                if u108 then
                    v151 = script.Parent.NapHahaba.ChargeVFX.FireHit
                end
                local v152 = v151:Clone()
                v152.Parent = v150
                v150:ScaleTo(1.35)
                v150.Parent = workspace.Effects
                v152.CFrame = v149
                _G.customEmit(v152)
                _G.destroy(v150, 3)
            end
            local v153 = script.SFX.Charge1Normal
            if u108 == true then
                v153 = script.SFX.Charge1Fire
            end
            u118 = v135 / 2
            _G.PlaySound(u12.PrimaryPart, v153).Parent = u12.PrimaryPart
            v135 = u118
            v134 = u117
        end
        task.wait()
        if u12:GetAttribute("NapHakaiHold") == nil then
            u2:Create(v134, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
            _G.destroy(v134, 0.25)
            if u110 then
                _G.particleEnabled(u110, false)
                _G.destroy(u110, 3)
            end
            if u129 then
                for _, v154 in u129:GetDescendants() do
                    if v154:IsA("ParticleEmitter") or v154:IsA("Beam") then
                        v154.Enabled = false
                    end
                end
                _G.destroy(u129, 2)
            end
            task.defer(task.cancel, v128)
            return
        end
    end
end
return v1