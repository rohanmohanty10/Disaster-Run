 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local u3 = script:WaitForChild("VFX")
workspace:WaitForChild("Effects")
local u4 = require(script.Parent.NapSoulLightning)
local v5 = game:GetService("ReplicatedStorage")
local u6 = require(v5.Modules.VFXUtility.highlight_emit)
local u7 = require(script.Parent:WaitForChild("Shared"))
local u8 = RaycastParams.new()
u8.FilterType = Enum.RaycastFilterType.Include
u8.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
local u9 = Random.new()
local v10 = RaycastParams.new()
v10.FilterType = Enum.RaycastFilterType.Include
v10.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
function v1.start(_, u11, p12) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u9
        [3] = u8
        [4] = u4
        [5] = u2
        [6] = u6
        [7] = u7
    --]]
    local v13 = p12.State
    local v14 = u11:FindFirstChild(script.Parent.Name .. "Sword")
    local u15 = u11:GetAttribute("SoulCleaverBlazed") == true
    if u15 == false then
        u15 = nil
    end
    local v16, u17, u18
    if u15 then
        v16 = u3.FireVariants.FireElectricityCharging
        u17 = ColorSequence.new(Color3.fromRGB(255, 122, 55))
        u18 = Color3.fromRGB(255, 98, 55)
        local _ = u3.FireVariants.FireElecHit
    else
        v16 = u3.ElectricityCharging
        u17 = ColorSequence.new(Color3.fromRGB(102, 42, 255))
        u18 = Color3.fromRGB(151, 65, 255)
        local _ = u3.ElecHit
    end
    local v19 = script.SFX.Normal
    if v13 == "Start" then
        local v20, v21
        if u15 then
            v20 = u3.FireVariants.FireWindCharge
            v21 = u3.FireVariants.FireWindPressure:Clone()
        else
            v20 = u3.WindCharge
            v21 = u3.WindPressure:Clone()
        end
        local v22 = script.SFX.HitSFX.Normal
        if u15 == true then
            v22 = script.SFX.HitSFX.Fire
        end
        local u23
        if v14 then
            u23 = v16:Clone()
            u23.Weld.Part0 = v14.RootPart
            for _, v24 in pairs(u23:QueryDescendants("ParticleEmitter")) do
                v24.Rate = 5
                v24.Enabled = true
            end
            u23.Parent = workspace.Effects
        else
            u23 = nil
        end
        _G.PlaySound(u11.PrimaryPart, v19.NapoleonCircleSlashStart).Parent = u11.PrimaryPart
        local v25 = v19.NapoleonCircleSlashChargeLoop:Clone()
        v25.Parent = u11.PrimaryPart
        v25:Play()
        local u26 = 0.15
        local u27 = u11:QueryDescendants("BasePart")
        if v14 then
            u27 = v14:QueryDescendants("BasePart")
        end
        local v39 = task.spawn(function() --[[ Line: 120 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u27
                [3] = u9
                [4] = u8
                [5] = u23
                [6] = u4
                [7] = u17
                [8] = u15
            --]]
            while task.wait(u26) do
                local u28 = u27[math.random(#u27)]
                local u29 = CFrame.new(u28.Size * u9:NextUnitVector() / 2)
                local v30 = u28.CFrame * u29.Position
                local v31 = u9:NextUnitVector() * 15 - Vector3.new(0, 15, 0)
                local u32 = workspace:Raycast(v30, v31, u8)
                if u23 then
                    for _, v33 in pairs(u23:QueryDescendants("ParticleEmitter")) do
                        v33.Rate = v33.Rate + 0.5
                    end
                end
                if u32 then
                    local v34 = u32.Position
                    local u35 = (Vector3.new(0, 1, 0)):Cross((v34 - v30).Unit):Cross(Vector3.new(0, 1, 0))
                    local u36 = Instance.new("Attachment")
                    u36.WorldCFrame = CFrame.lookAlong(v30, u35)
                    u36.Parent = workspace.Terrain
                    local v37 = Instance.new("Attachment")
                    v37.WorldCFrame = CFrame.lookAlong(v34, -u35)
                    v37.Parent = workspace.Terrain
                    u4.new({
                        ["Attachment0"] = u36,
                        ["Attachment1"] = v37,
                        ["CurveSize0"] = 5,
                        ["CurveSize1"] = 5,
                        ["Width"] = NumberRange.new(0.5, 1),
                        ["Duration"] = 0.1,
                        ["BeamColor"] = u17
                    })
                    task.delay(0.1, function() --[[ Line: 164 ]]
                        --[[
                        Upvalues:
                            [1] = u32
                            [2] = u15
                            [3] = u9
                        --]]
                        _G.PlayEffect("NapLightningHitFloor", nil, u32, u15)
                        local v38 = u32.Normal
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 1,
                            ["RandomVelocityMagnitude"] = Vector2.new(-15, 15),
                            ["Position"] = u32.Position,
                            ["Direction"] = v38 * 35,
                            ["RaycastDirection"] = -v38 * 15,
                            ["Size"] = Vector3.new(1, 1, 1) * u9:NextNumber(0.2, 0.35),
                            ["TrailEnabled"] = true
                        })
                    end)
                    task.delay(1, v37.Destroy, v37)
                    task.delay(1, u36.Destroy, u36)
                    task.spawn(function() --[[ Line: 183 ]]
                        --[[
                        Upvalues:
                            [1] = u36
                            [2] = u28
                            [3] = u29
                            [4] = u35
                        --]]
                        while u36.Parent do
                            u36.WorldCFrame = CFrame.lookAlong(u28.CFrame * u29.Position, u35)
                            task.wait()
                        end
                    end)
                end
            end
        end)
        local _, v40, v41 = _G.getRayFloor(u11.PrimaryPart.CFrame, 7)
        v21.CFrame = CFrame.new(v40, v40 + v41) * CFrame.Angles(1.5707963267948966, 0, 0)
        v21.Parent = workspace.Effects
        _G.customEmit(v21)
        _G.destroy(v21, 1)
        local u42 = { u3.Swirly1, u3.Swirly2 }
        local u43 = {
            -90,
            90,
            -180,
            180
        }
        local function v64() --[[ Line: 205 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u42
                [3] = u11
                [4] = u18
                [5] = u2
                [6] = u43
            --]]
            for _ = 1, 6 do
                local v44 = u9:NextNumber(0.75, 1.5)
                local v45 = u9:NextNumber(2, 3.25)
                local v46 = u9:NextNumber(0.175, 0.3)
                local v47 = u42[math.random(1, #u42)]:Clone()
                local v48 = 5 * v44
                local v49 = 2.5 * v44
                local v50 = 5 * v44
                v47.Size = Vector3.new(v48, v49, v50)
                v47.CFrame = u11.HumanoidRootPart.CFrame * CFrame.new(0, u9:NextNumber(-2, 1), 0) * CFrame.Angles(0, u9:NextNumber(-180, -180), 0)
                if math.random(1, 2) == 2 then
                    v47.Color = u18
                else
                    v47.Color = Color3.fromRGB(185, 185, 185)
                end
                v47.Parent = workspace.Effects
                local v51 = u2
                local v52 = TweenInfo.new(v46, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                local v53 = {}
                local v54 = v47.Size.X * v45
                local v55 = v47.Size.Y * (v45 / u9:NextNumber(1, 1.5))
                local v56 = v47.Size.Z * v45
                v53.Size = Vector3.new(v54, v55, v56)
                local v57 = v47.CFrame * CFrame.new(0, -1, 0)
                local v58 = CFrame.Angles
                local v59 = u9:NextNumber(-2.5, 2.5)
                local v60 = math.rad(v59)
                local v61 = u43[math.random(1, #u43)]
                local v62 = math.rad(v61)
                local v63 = u9:NextNumber(-2.5, 2.5)
                v53.CFrame = v57 * v58(v60, v62, (math.rad(v63)))
                v53.Transparency = 1
                v51:Create(v47, v52, v53):Play()
                _G.destroy(v47, v46)
            end
        end
        v64()
        local _ = { u3.Rock }
        local v65 = u11.PrimaryPart.Size.Y + u11.Humanoid.HipHeight
        tick()
        local v66 = p12.startHold
        local v67 = false
        local v68 = 0
        local v69 = {
            -90,
            90,
            -180,
            180
        }
        local v70 = 0
        while true do
            if tick() - v68 >= 0.25 then
                local v71, v72, v73 = _G.getRayFloor(u11.PrimaryPart.CFrame, v65)
                local v74 = CFrame.new(v72, v72 + v73) * CFrame.Angles(1.5707963267948966, 0, 0)
                if v71 then
                    for _ = 1, 3 do
                        local v75 = u9:NextNumber(0.75, 1.5)
                        local v76 = u9:NextNumber(1.9, 2)
                        local v77 = u9:NextNumber(0.2, 0.25)
                        local v78 = u42[math.random(1, #u42)]:Clone()
                        local v79 = 5 * v75
                        local v80 = 2.5 * v75
                        local v81 = 5 * v75
                        v78.Size = Vector3.new(v79, v80, v81)
                        v78.CFrame = v74 * CFrame.new(0, u9:NextNumber(-1, 1), 0) * CFrame.Angles(0, u9:NextNumber(-180, -180), 0)
                        v78.Transparency = 0.9
                        if math.random(1, 2) == 2 then
                            v78.Color = u18
                        else
                            v78.Color = Color3.fromRGB(185, 185, 185)
                        end
                        v78.Parent = workspace.Effects
                        local v82 = u2
                        local v83 = TweenInfo.new(v77, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local v84 = {}
                        local v85 = v78.Size.X * v76
                        local v86 = v78.Size.Y * v76 / 2
                        local v87 = v78.Size.Z * v76
                        v84.Size = Vector3.new(v85, v86, v87)
                        local v88 = v78.CFrame
                        local v89 = CFrame.Angles
                        local v90 = u9:NextNumber(-2.5, 2.5)
                        local v91 = math.rad(v90)
                        local v92 = v69[math.random(1, #v69)]
                        local v93 = math.rad(v92)
                        local v94 = u9:NextNumber(-2.5, 2.5)
                        v84.CFrame = v88 * v89(v91, v93, (math.rad(v94)))
                        v84.Transparency = 1
                        v82:Create(v78, v83, v84):Play()
                        _G.destroy(v78, v77)
                    end
                    local v95 = v20:Clone()
                    v95.CFrame = v74
                    v95.PointLight.Color = u18
                    _G.recolorParticles(v95, v71.Color)
                    u2:Create(v95.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ["Range"] = 8,
                        ["Brightness"] = 0
                    }):Play()
                    v95.Parent = workspace.Effects
                    _G.customEmit(v95)
                    _G.destroy(v95, 1.25)
                end
                v68 = tick()
            end
            local v96 = workspace:GetServerTimeNow()
            if v96 - v66 >= 1 and v70 < 2 then
                v70 = v70 + 1
                local v97 = u17.Keypoints[1].Value
                u6.tweenHighlight(u11, v97, v97, 0.25, Enum.HighlightDepthMode.Occluded, "In", 0.1)
                local v98 = u11.PrimaryPart.CFrame.UpVector
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 15,
                    ["Position"] = u11.PrimaryPart.Position,
                    ["DistanceRandomness"] = Vector2.new(0.4, 1),
                    ["Duration"] = 4,
                    ["TweenDuration"] = 1,
                    ["Radius"] = v70 * 2 + 4,
                    ["Direction"] = -v98 * 15,
                    ["Angle"] = -0.7853981633974483
                })
                v64()
                local v99 = u26 / 2
                local v100, v101, v102 = _G.getRayFloor(u11.PrimaryPart.CFrame, v65)
                if v100 then
                    local v103 = CFrame.new(v101, v101 + v102) * CFrame.Angles(3.141592653589793, 0, 0)
                    local v104 = Instance.new("Model")
                    local v105 = script.ChargeVFX.Hit
                    if u15 then
                        v105 = script.ChargeVFX.FireHit
                    end
                    local v106 = v105:Clone()
                    v106.Parent = v104
                    v104:ScaleTo(v70 / 3 + 1)
                    v104.Parent = workspace.Effects
                    v106.CFrame = v103
                    _G.customEmit(v106)
                    _G.destroy(v104, 3)
                end
                if v67 == false then
                    u2:Create(v25, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ["Volume"] = 0
                    }):Play()
                    _G.destroy(v25, 0.1)
                    v25 = v19.NapoleonCircleSlashChargedChargeLoop:Clone()
                    v25.Parent = u11.PrimaryPart
                    v25:Play()
                    _G.PlaySound(u11.PrimaryPart, v22.Charge1).Parent = u11.PrimaryPart
                    u26 = v99
                    v67 = true
                else
                    v25.Pitch = 1.5
                    _G.PlaySound(u11.PrimaryPart, v22.Charge2).Parent = u11.PrimaryPart
                    u26 = v99
                end
            else
                v96 = v66
            end
            task.wait()
            if u11:GetAttribute("NapHahabaHold") == nil then
                break
            end
            v66 = v96
        end
        if u23 then
            _G.particleEnabled(u23, false)
            _G.destroy(u23, 3)
        end
        u2:Create(v25, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Volume"] = 0
        }):Play()
        _G.destroy(v25, 0.25)
        task.defer(task.cancel, v39)
    elseif v13 == "End" then
        local v107 = p12.Scale
        local v108 = Instance.new("Model")
        local v109
        if u15 then
            v109 = u3.FireVariants.FireElectricitySwing:Clone()
        else
            v109 = u3.ElectricitySwing:Clone()
        end
        v109.CFrame = u11.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        v109.Parent = v108
        v108:ScaleTo(v107)
        v108.Parent = workspace.Effects
        _G.customEmit(v108)
        u7.LightningSlash(u11.HumanoidRootPart.CFrame, u15, v107)
        local v110 = v19["SlashCharge" .. p12.ChargeCount]
        _G.PlaySound(u11.PrimaryPart, v110).Parent = u11.PrimaryPart
        _G.destroy(v108, 3)
    elseif v13 == "Hit" then
        local v111 = p12.Target
        local v112 = p12.alreadyHit
        local v113 = { u3.Swirly1, u3.Swirly2 }
        local v114 = p12.startCFrame
        local v115 = p12.targetPosition
        local v116 = script.SFX.HitSFX.Normal
        if u15 == true then
            v116 = script.SFX.HitSFX.Fire
        end
        _G.shakenear(u11.PrimaryPart.Position, 75, 75, 50, -0.5)
        if v112 == false then
            local v117 = { -180, 180 }
            local v118
            if u15 == true then
                v118 = u3.FireVariants.FireWindCharge2:Clone()
            else
                v118 = u3.WindCharge2:Clone()
            end
            for _ = 1, 10 do
                local v119 = u9:NextNumber(0.75, 1.5)
                local v120 = u9:NextNumber(2.5, 3)
                local v121 = u9:NextNumber(0.2, 0.5)
                local v122 = v113[math.random(1, #v113)]:Clone()
                local v123 = 1 * v119
                local v124 = 0.5 * v119
                local v125 = 1 * v119
                v122.Size = Vector3.new(v123, v124, v125)
                v122.CFrame = u11.HumanoidRootPart.CFrame * CFrame.new(0, u9:NextNumber(-1, 2), 0) * CFrame.Angles(0, u9:NextNumber(-180, -180), 0)
                if math.random(1, 2) == 2 then
                    v122.Color = u18
                else
                    v122.Color = Color3.fromRGB(185, 185, 185)
                end
                v122.Parent = workspace.Effects
                local v126 = u2
                local v127 = TweenInfo.new(v121, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                local v128 = {}
                local v129 = 7.5 * v120
                local v130 = 2.5 * (v120 / u9:NextNumber(1, 1.25))
                local v131 = 7.5 * v120
                v128.Size = Vector3.new(v129, v130, v131)
                local v132 = v122.CFrame * CFrame.new(0, -2, 0)
                local v133 = CFrame.Angles
                local v134 = u9:NextNumber(-2.5, 2.5)
                local v135 = math.rad(v134)
                local v136 = v117[math.random(1, #v117)]
                local v137 = math.rad(v136)
                local v138 = u9:NextNumber(-2.5, 2.5)
                v128.CFrame = v132 * v133(v135, v137, (math.rad(v138)))
                v128.Transparency = 1
                v126:Create(v122, v127, v128):Play()
                task.delay(v121, v122.Destroy, v122)
            end
            local v139 = { -275, 275 }
            for _ = 1, 5 do
                local v140 = u9:NextNumber(0.75, 1.5)
                local v141 = u9:NextNumber(3, 4)
                local v142 = u9:NextNumber(0.5, 1)
                local v143 = v113[math.random(1, #v113)]:Clone()
                local v144 = 1 * v140
                local v145 = 0.5 * v140
                local v146 = 1 * v140
                v143.Size = Vector3.new(v144, v145, v146)
                v143.CFrame = u11.HumanoidRootPart.CFrame * CFrame.new(0, u9:NextNumber(-2, -1), 0) * CFrame.Angles(0, u9:NextNumber(-180, -180), 0)
                if math.random(1, 2) == 2 then
                    v143.Color = u18
                else
                    v143.Color = Color3.fromRGB(185, 185, 185)
                end
                v143.Parent = workspace.Effects
                local v147 = u2
                local v148 = TweenInfo.new(v142, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                local v149 = {}
                local v150 = 12.5 * v141
                local v151 = 5 * (v141 / u9:NextNumber(1, 1.25))
                local v152 = 12.5 * v141
                v149.Size = Vector3.new(v150, v151, v152)
                local v153 = v143.CFrame * CFrame.new(0, -1, 0)
                local v154 = CFrame.Angles
                local v155 = u9:NextNumber(-2.5, 2.5)
                local v156 = math.rad(v155)
                local v157 = v139[math.random(1, #v139)]
                local v158 = math.rad(v157)
                local v159 = u9:NextNumber(-2.5, 2.5)
                v149.CFrame = v153 * v154(v156, v158, (math.rad(v159)))
                v149.Transparency = 1
                v147:Create(v143, v148, v149):Play()
                task.delay(v142, v143.Destroy, v143)
            end
            local v160, v161, v162 = _G.getRayFloor(v114, 7)
            local v163 = CFrame.new(v161, v161 + v162) * CFrame.Angles(1.5707963267948966, 0, 0)
            if v160 then
                v118.CFrame = v163
                _G.recolorParticles(v118, v160.Color)
                v118.Parent = workspace.Effects
                u2:Create(v118.PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Range"] = 25,
                    ["Brightness"] = 0
                }):Play()
                _G.customEmit(v118)
                _G.destroy(v118, 1.25)
            else
                v118:Destroy()
            end
        end
        local v164 = (v114.Position - v115).Magnitude
        local v165
        if u15 == true then
            v165 = u3.FireVariants.FireHit:Clone()
        else
            v165 = u3.Hit:Clone()
        end
        v165.CFrame = CFrame.new(v114.Position, v115 + Vector3.new(0, 2, 0)) * CFrame.new(0, 0, -v164) * CFrame.Angles(0, 3.141592653589793, 0)
        v165.Parent = workspace.Effects
        _G.customEmit(v165)
        _G.destroy(v165, 2)
        local v166 = v116.Hit
        if p12.MaxHit ~= nil then
            v166 = v116.MaxHit
        end
        _G.PlaySound(v165, v166, {
            ["RandomPitch"] = true
        })
        _G.PlayEffect("NapHakaiHit", nil, u11, v111, true)
    end
end
return v1