 

local u1 = game:GetService("TweenService")
local u2 = Random.new()
local u3 = require(script.SwirlyParticle)
local u4 = require(script.Parent.FloatingRock)
local u5 = require(script.Parent.Parent.GalaxyImpactLightning)
require(script.EndParticles)
local v6 = {}
local u7 = RaycastParams.new()
u7.FilterType = Enum.RaycastFilterType.Include
u7.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u12(p8, p9) --[[ Line: 20 ]]
    local u10 = script.Parent.Flash.ColorCorrectionIMPACT:Clone()
    u10.Parent = game.Lighting
    local u11 = Instance.new("Highlight")
    u11.DepthMode = Enum.HighlightDepthMode.Occluded
    u11.FillColor = Color3.fromRGB(255, 30, 10)
    u11.FillTransparency = -1.5
    u11.Enabled = true
    u11.OutlineTransparency = 1
    if p9 then
        u11.FillColor = p9
    end
    u11.Parent = workspace
    task.delay(p8 or 0.05, function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u10
        --]]
        u11:Destroy()
        u10:Destroy()
    end)
end
local function u31(u13, p14) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local u15 = script.ShockwaveBeam:Clone()
    u15.CFrame = u13
    u15.Parent = workspace.Effects
    local u16 = TweenInfo.new(math.random(300, 600) / 1000, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v17 = u2:NextNumber(150, 200)
    local v18 = math.random(1500, 2000) / 2
    local v19 = NumberSequence.new(0)
    local v20 = v17 * 4 / 3
    task.spawn(function() --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u15
            [3] = u16
            [4] = u1
            [5] = u13
        --]]
        local v21 = u2:NextNumber(1, 2) * 3.141592653589793 * (math.random(2) == 1 and 1 or -1)
        local v22 = 0
        while u15.Parent do
            local v23 = task.wait()
            v22 = v22 + v23 / u16.Time
            u1:Create(u15, TweenInfo.new(v23, Enum.EasingStyle.Linear), {
                ["CFrame"] = u13 * CFrame.Angles(0, v21 * v22, 0)
            }):Play()
        end
    end)
    for _, v24 in u15:GetChildren() do
        local v25 = v24["1"]
        local v26 = v24["2"]
        local v27 = v24.Beam
        v27.Color = ColorSequence.new(p14)
        v27.Width0 = v18
        v27.Width1 = 0
        v27.Transparency = v19
        v27.CurveSize0 = -v20 * 1 / 3
        v27.CurveSize1 = -v27.CurveSize0
        v27.TextureLength = math.random(2, 3)
        u1:Create(v27, u16, {
            ["CurveSize0"] = -v20,
            ["CurveSize1"] = v20,
            ["Width0"] = 0,
            ["Width1"] = 0,
            ["TextureLength"] = 0
        }):Play()
        local v28 = v24.Name == "Attachment" and Vector3.new(1, 0, 0) or Vector3.new(0, 0, 0)
        v25.Position = v28 + Vector3.new(0, 0, 1) * v17 * 1 / 1.5
        v26.Position = -(v28 + Vector3.new(0, 0, 1) * v17 * 1 / 1.5)
        for _, v29 in { v25, v26 } do
            local v30 = v29 == v25 and 1 or -1
            u1:Create(v29, u16, {
                ["Position"] = v28 + Vector3.new(0, 0, 1) * v17 * v30
            }):Play()
        end
    end
    _G.destroy(u15, u16.Time)
end
function v6.Initialize(_, u32, u33) --[[ Line: 157 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u4
        [5] = u5
        [6] = u31
        [7] = u7
        [8] = u12
    --]]
    local u34 = Instance.new("Model")
    u34.Name = "Pillar"
    local v35 = Instance.new("Highlight")
    v35.Parent = u34
    v35.FillColor = Color3.fromRGB(255, 255, 255)
    v35.FillTransparency = -0.5
    v35.OutlineTransparency = 1
    v35.DepthMode = Enum.HighlightDepthMode.Occluded
    u34.Parent = workspace.Effects
    local v36 = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 1, 0))
    local function v48(p37) --[[ Line: 178 ]]
        --[[
        Upvalues:
            [1] = u32
            [2] = u33
            [3] = u1
        --]]
        for v38 = 1, 5 do
            local v39 = Instance.new("Part")
            v39.Shape = Enum.PartType.Cylinder
            v39.Size = Vector3.new(200, 50, 50)
            local v40 = CFrame.new
            local v41 = u32
            local v42 = (v38 - 1) * 200 + 100
            v39.CFrame = v40(v41 + Vector3.new(0, v42, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
            v39.Material = Enum.Material.Neon
            v39.CanCollide = false
            v39.CastShadow = false
            v39.Anchored = true
            v39.Color = u33
            v39.Parent = p37
            local v43 = v38 / 15
            local v44 = u1
            local v45 = TweenInfo.new(v43)
            local v46 = {}
            local v47 = v39.Size.X
            v46.Size = Vector3.new(v47, 0, 0)
            v44:Create(v39, v45, v46):Play()
            _G.destroy(v39, v43)
        end
    end
    v48(u34)
    for _ = 0, 15 do
        local v49 = math.random(-50, 500)
        local v50 = Instance.new("Part")
        local v51 = Instance.new("SpecialMesh")
        v51.MeshType = Enum.MeshType.Sphere
        v51.Parent = v50
        v50.Anchored = true
        v50.CanCollide = false
        v50.Material = Enum.Material.Neon
        v50.Color = u33
        v50.CFrame = v36 * CFrame.Angles(0, 1.5707963267948966, 0) + v36.LookVector * v49 + u32 + u2:NextUnitVector() * math.random(75, 100)
        local v52 = u2:NextNumber(20, 30)
        local v53 = v52 * 10
        v50.Size = Vector3.new(v53, v52, v52)
        v50.CastShadow = false
        v50.Parent = u34
        u1:Create(v50, TweenInfo.new(math.random(150, 250) / 1000), {
            ["Size"] = Vector3.new(0, 0, 0),
            ["Position"] = v50.Position + v36.LookVector * v50.Size.X
        }):Play()
        _G.destroy(v50, 0.25)
        local v54 = math.random(-50, 100)
        local v55 = (v36 * CFrame.Angles(0, 1.5707963267948966, 0) + v36.LookVector * v54 + u32 + u2:NextUnitVector() * math.random(100, 200)).Position
        local v56 = script.Star:Clone()
        v56.Size = Vector3.new(10, 10, 35) * u2:NextNumber(5, 10) + u2:NextUnitVector():Abs() * 50
        v56.CFrame = CFrame.new(v55, workspace.Camera.CFrame.Position)
        v56.Color = u33
        v56.Parent = u34
        local v57 = u2:NextNumber(0.1, 0.25)
        u1:Create(v56, TweenInfo.new(v57), {
            ["Size"] = Vector3.new(0, 0, 0)
        }):Play()
        _G.destroy(v56, v57)
    end
    _G.PlaySound(CFrame.new(u32), script.GalaxyImpactExplosionFlash)
    _G.tween(workspace.CurrentCamera, {
        0.3,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["FieldOfView"] = 100
    })
    task.wait(0.1)
    _G.shakenear(u32, 500, 150, 300, -1)
    local u58 = script.Burst:Clone()
    for _, v59 in u58:GetDescendants() do
        if v59:IsA("ParticleEmitter") and v59:GetAttribute("hakiColor") then
            v59.Color = ColorSequence.new(u33)
        end
    end
    u58:SetPrimaryPartCFrame(CFrame.new(u32))
    u58.Parent = workspace.Effects
    _G.PlaySound(u58.PrimaryPart, script.GalaxyImpactPillarExplosionA)
    _G.customEmit(u58)
    local u60 = script.Impact:Clone()
    u60.Position = u32
    u60.Size = Vector3.new(200, 2000, 200)
    u60.Color = Color3.new(1, 1, 1)
    u60.Parent = workspace.Effects
    u1:Create(u60, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        ["Size"] = Vector3.new(0, 1, 0) * u60.Size.Y
    }):Play()
    task.delay(5, function() --[[ Line: 295 ]]
        --[[
        Upvalues:
            [1] = u58
        --]]
        u58:Destroy()
    end)
    task.delay(0.3, function() --[[ Line: 299 ]]
        --[[
        Upvalues:
            [1] = u60
        --]]
        u60:Destroy()
    end)
    local v61 = script.Pillar:Clone()
    local v62 = Instance.new("Highlight")
    v62.FillColor = Color3.fromRGB(255, 219, 188)
    v62.OutlineColor = Color3.fromRGB(0, 0, 0)
    v62.OutlineTransparency = 1
    v62.FillTransparency = -0.5
    v62.Enabled = false
    v62.DepthMode = Enum.HighlightDepthMode.Occluded
    v62.Parent = v61["3"]
    local v63, v64, v65 = u33:ToHSV()
    local u66 = {}
    for _, v67 in {
        v61["1"],
        v61["2"],
        v61["3"],
        v61.Main
    } do
        v67.Color = Color3.fromHSV(v63, v64, v65)
        v65 = v65 * 0.85
    end
    _G.recolorParticles(v61, u33, "hakiColor")
    v61.core.Color = Color3.new(1, 1, 1)
    local u68 = v61.Main
    local _ = u68.Size
    v61:PivotTo(CFrame.new(u32))
    local u69 = u68.Size
    for _, v70 in v61:GetChildren() do
        if v70 ~= u68 then
            u66[v70] = {
                ["InitialSize"] = v70.Size,
                ["TransparencyRatio"] = v70.Transparency / u68.Transparency,
                ["Ratio"] = v70.Size / u68.Size,
                ["Offset"] = v70.Position - u68.Position
            }
        end
    end
    u68:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 342 ]]
        --[[
        Upvalues:
            [1] = u68
            [2] = u69
            [3] = u66
        --]]
        task.defer(function() --[[ Line: 343 ]]
            --[[
            Upvalues:
                [1] = u68
                [2] = u69
                [3] = u66
            --]]
            local v71 = u68.Size / u69
            for v72, v73 in pairs(u66) do
                v72.Size = v73.Ratio * u68.Size
                v72.Position = u68.Position + v73.Offset * v71
                v72.Transparency = u68.Transparency
            end
            local v74 = u68.Attachment.a:GetChildren()
            for _, v75 in v74 do
                local v76 = 6.283185307179586 / #v74
                v75.Width0 = math.cos(v76) * u68.Size.X / 2
                v75.Width1 = v75.Width0
            end
            local v77 = u68.Attachment.RedAura
            for _, v78 in u68.Attachment:GetChildren() do
                if v77 ~= v78 and v78:IsA("Attachment") then
                    local v79 = v78["1"]
                    local v80 = u68.Size.Y / 2
                    local v81 = u68.Size.X / 2 + 1
                    v79.Position = Vector3.new(0, v80, v81)
                    local v82 = v78["2"]
                    local v83 = -u68.Size.Y / 2
                    local v84 = u68.Size.X / 2
                    v82.Position = Vector3.new(0, v83, v84)
                end
            end
            v77.Top.Position = Vector3.new(0, 1, 0) * u68.Size.Y / 2
            v77.Bottom.Position = Vector3.new(0, 1, 0) * -u68.Size.Y / 2
        end)
    end)
    u68.Size = Vector3.new(50, 2000, 50)
    v61.Parent = workspace.Effects
    local v85 = 95 - u68.Size.X
    u1:Create(u68, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        ["Size"] = u68.Size + Vector3.new(v85, 0, v85)
    }):Play()
    task.spawn(function() --[[ Line: 386 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u68
            [3] = u34
            [4] = u33
            [5] = u4
            [6] = u2
        --]]
        local v86 = tick()
        while tick() - v86 <= 1 do
            local v87 = u3.new
            local v88 = {
                ["Target"] = u68,
                ["Duration"] = Random.new():NextNumber(0.2, 2),
                ["Parent"] = u34
            }
            local v89 = math.random
            v88.Size = Vector3.new(5, 5, v89(30, 40))
            v88.HeightMult = math.random(10, 300) / 300
            v88.Color = u33
            local v90 = v87(v88)
            u4.new({
                ["Position"] = CFrame.Angles(0, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, -u68.Size.Z).Position + u68.Position + Vector3.new(0, 1, 0),
                ["Height"] = Vector3.new(0, 1, 0) * u2:NextNumber(50, 600),
                ["Duration"] = u2:NextNumber(0.25, 0.5),
                ["Size"] = u2:NextUnitVector():Abs() * math.random(35, 60)
            })
            v90:start()
            task.wait(0.02)
        end
    end)
    task.spawn(function() --[[ Line: 411 ]]
        --[[
        Upvalues:
            [1] = u68
            [2] = u32
            [3] = u5
            [4] = u33
        --]]
        for _ = 1, 7 do
            for v91 = 1, 5 do
                local v92 = CFrame.Angles(0, 6.283185307179586 * v91 / 5, 0) * CFrame.new(0, 0, -u68.Size.X).Position + u32
                u5:CreateLightning({
                    ["Start"] = v92 - Vector3.new(0, 1000, 0),
                    ["End"] = v92 + Vector3.new(0, 1000, 0),
                    ["InnerColor"] = Color3.new(1, 1, 1),
                    ["OuterColor"] = u33,
                    ["OuterTransparency"] = 1,
                    ["Amount"] = 4,
                    ["Resolution"] = 2,
                    ["OffsetRadius"] = 20,
                    ["Duration"] = 0.14285714285714285,
                    ["Width"] = 30
                })
            end
            task.wait(0.14285714285714285)
        end
    end)
    task.spawn(function() --[[ Line: 439 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u31
            [3] = u32
            [4] = u2
        --]]
        local v93, v94, v95 = u33:ToHSV()
        local v96 = v94 * 255 + 50
        local v97 = Color3.fromHSV
        local v98 = v96 / 255
        local v99 = v97(v93, math.clamp(v98, 0, 1), v95)
        for _ = 1, 15 do
            local v100 = u31
            local v101 = CFrame.new(u32 + Vector3.new(0, 10, 0))
            local v102 = CFrame.Angles
            local v103 = u2:NextNumber(-8, 8)
            local v104 = math.rad(v103)
            local v105 = 6.283185307179586 * math.random()
            local v106 = u2:NextNumber(-8, 8)
            v100(v101 * v102(v104, v105, (math.rad(v106))), v99)
            task.wait(0.05333333333333334)
        end
    end)
    task.spawn(function() --[[ Line: 454 ]]
        --[[
        Upvalues:
            [1] = u68
            [2] = u1
        --]]
        local v107 = TweenInfo.new(2, Enum.EasingStyle.Circular)
        local u108 = {
            v107.Time,
            v107.EasingStyle,
            v107.EasingDirection,
            0,
            false,
            0
        }
        tick()
        local v109 = tick() + 1
        for v110 = 1, 5 do
            local v111 = 5 - v110 + 1
            local v112 = script.Shockwave:Clone()
            local v113 = u68.CFrame * CFrame.new(0, v110 * 100, 0)
            local v114 = CFrame.Angles
            local v115 = math.random(0, 360)
            v112:PivotTo(v113 * v114(0, math.rad(v115), 0))
            v112:ScaleTo(v111)
            _G.customEmit(v112)
            v112.Parent = workspace.Effects
            local v116 = v112.Shockwave
            for _, u117 in { v116.Ring2.Attachment1, v116.Ring2.Attachment2 } do
                local v118 = v111 * 20
                u117.bf1.Width0 = v118
                u117.bf1.Width1 = v118
                u117.bf2.Width0 = v118
                u117.bf2.Width1 = v118
                u1:Create(u117["1"], v107, {
                    ["Position"] = Vector3.new(0, 200, 0)
                }):Play()
                u1:Create(u117["2"], v107, {
                    ["Position"] = Vector3.new(-0, -200, -0)
                }):Play()
                _G.tween(u117.bf1, u108, {
                    ["Transparency"] = NumberSequence.new(1),
                    ["CurveSize0"] = 266.6666666666667,
                    ["CurveSize1"] = -266.6666666666667
                })
                _G.tween(u117.bf2, u108, {
                    ["Transparency"] = NumberSequence.new(1),
                    ["CurveSize0"] = -266.6666666666667,
                    ["CurveSize1"] = 266.6666666666667
                })
                task.delay(v109 - tick(), function() --[[ Line: 521 ]]
                    --[[
                    Upvalues:
                        [1] = u117
                        [2] = u108
                    --]]
                    _G.tween(u117.bf1, u108, {
                        ["Transparency"] = NumberSequence.new(1),
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                    _G.tween(u117.bf2, u108, {
                        ["Transparency"] = NumberSequence.new(1),
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end)
            end
            _G.destroy(v112, 2)
            task.wait(0.15)
        end
    end)
    local v119 = u32 + Vector3.new(0, 3, 0)
    local v120 = workspace:Raycast(v119, Vector3.new(0, -15, 0), u7)
    if v120 then
        local _ = v120.Position + Vector3.new(0, 0.1, 0)
        local u121 = script.miscImpact:Clone()
        u121.Position = u32
        u121.Parent = workspace.Effects
        _G.recolorParticles(u121, u33, "hakiColor")
        local u122 = script.MainFloor:Clone()
        _G.recolorParticles(u122, u33, "hakiColor")
        u122.Position = u32
        _G.recolorParticles(u122.AttachmentGround1, v120.Instance.Color)
        _G.recolorParticles(u122.AttachmentGround2, v120.Instance.Color)
        u122.Parent = workspace.Effects
        for _, v123 in u122:GetDescendants() do
            if v123:IsA("Beam") then
                _G.tween(v123, {
                    1.5,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = NumberSequence.new(1)
                })
            end
        end
        task.delay(1, function() --[[ Line: 574 ]]
            --[[
            Upvalues:
                [1] = u122
                [2] = u121
            --]]
            _G.particleEnabled(u122, false)
            _G.particleEnabled(u121, false)
            local v124 = { u122, u121 }
            _G.destroy(v124, 10)
        end)
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 40,
            ["Position"] = v120.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.2, 1),
            ["Duration"] = 8,
            ["TweenDuration"] = 1,
            ["Radius"] = 130,
            ["Direction"] = Vector3.new(0, -15, 0)
        })
    end
    for _, v125 in u68.Attachment2:GetDescendants() do
        if v125:IsA("Beam") then
            _G.tween(v125, {
                3,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = NumberSequence.new(1)
            })
        end
    end
    for _, v126 in u68.Attachment.RedAura:GetDescendants() do
        if v126:IsA("Beam") then
            _G.tween(v126, {
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = NumberSequence.new(1)
            })
        end
    end
    task.wait(1)
    _G.tween(workspace.CurrentCamera, {
        0.3,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["FieldOfView"] = 70
    })
    u12(nil, u33)
    v48(u34)
    for _ = 0, 15 do
        local v127 = math.random(-50, 500)
        local v128 = Instance.new("Part")
        local v129 = Instance.new("SpecialMesh")
        v129.MeshType = Enum.MeshType.Sphere
        v129.Parent = v128
        v128.Anchored = true
        v128.CanCollide = false
        v128.Material = Enum.Material.Neon
        v128.Color = u33
        v128.CFrame = v36 * CFrame.Angles(0, 1.5707963267948966, 0) + v36.LookVector * v127 + u32 + u2:NextUnitVector() * math.random(75, 100)
        local v130 = u2:NextNumber(20, 30)
        local v131 = v130 * 10
        v128.Size = Vector3.new(v131, v130, v130)
        v128.CastShadow = false
        v128.Parent = u34
        u1:Create(v128, TweenInfo.new(math.random(150, 250) / 1000), {
            ["Size"] = Vector3.new(0, 0, 0),
            ["Position"] = v128.Position + v36.LookVector * v128.Size.X
        }):Play()
        _G.destroy(v128, 0.25)
    end
    _G.particleEnabled(u68, false, true)
    u1:Create(u68, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), {
        ["Size"] = u68.Size + Vector3.new(200, 0, 200),
        ["Transparency"] = 1
    }):Play()
    _G.destroy(u34, 5)
    _G.destroy(v61, 5)
end
return v6