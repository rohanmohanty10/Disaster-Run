 

local v1 = {}
local _ = workspace.Effects
game:GetService("TweenService")
local u2 = script.Buzzcut
local u3 = workspace.Effects
local u4 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
function v1.start(_, p5, u6) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
    --]]
    local u7 = u6.char
    local u8 = u6.hakiColor
    if p5 == "colorServerBuzzcutArm" then
        local v9 = u6.buzzcutArm
        _G.PlayEffect("3SSRecolor", nil, v9, u8, "isRed")
        u4.apply(v9, u7)
        return
    elseif p5 == "fakeArm" then
        local u10 = script.BuzzcutArm:Clone()
        _G.PlayEffect("3SSRecolor", nil, u10, u8, "isRed")
        u4.apply(u10, u7)
        u10:PivotTo(u7.PrimaryPart.CFrame)
        local v11 = Instance.new("Motor6D")
        v11.Part0 = u7.RightLowerArm
        v11.Part1 = u10.RootPart
        v11.C0 = CFrame.new(-0.530860901, -15, -0.0271453857, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        v11.C1 = CFrame.new(0, 0.05, 0)
        v11.Parent = u10.RootPart
        u10:ScaleTo(0.001)
        u10.Parent = workspace.Effects
        task.spawn(function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u6
            --]]
            game:GetService("RunService").PreAnimation:Wait()
            local v12 = u10.AnimationController:LoadAnimation(script.Start)
            v12:Play(0)
            v12:AdjustSpeed(u6.animSpeed)
            u10:ScaleTo(1)
        end)
        u10:FindFirstChild("Trails", true)
        u10:FindFirstChild("Wind2EnabledTillTop", true)
        local v13 = u10:FindFirstChild("5_Arm", true)
        local u14 = u10:FindFirstChild("16_Arm", true)
        local _ = v13.CFrame
        u10:FindFirstChild("Retract", true)
        local v15 = u6.invisibleTime - workspace:GetServerTimeNow()
        local v16 = u6.hakiTime - workspace:GetServerTimeNow()
        task.delay(v15, function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            local v17 = u10:GetDescendants()
            for v18 = 1, #v17 do
                if v17[v18]:IsA("BasePart") then
                    v17[v18].Transparency = 1
                end
            end
            _G.destroy(u10, 5)
        end)
        _G.PlaySound(u7.PrimaryPart, script.MochiV2BuzzcutStart)
        task.delay(v16, function() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u4
                [3] = u7
                [4] = u14
                [5] = u10
            --]]
            local v19 = script.hakiParticle.HAKI:Clone()
            _G.PlayEffect("3SSRecolor", nil, v19, u8, "isRed")
            v19.HakiPointLight.Color = u8
            u4.apply(v19, u7)
            v19.Parent = u14
            _G.customEmit(v19)
            local v20 = v19.HakiPointLight
            _G.PlaySound(u7.HumanoidRootPart, script.MochiV2BuzzcutHakiOn)
            u10.HakiGlow.Transparency = 0
            u10.HakiGlow.Color = u8
            u10.Middle.Color = Color3.new(0.156863, 0.0980392, 0.133333)
            u10.Middle.Material = Enum.Material.Metal
            u4.apply(u10.HakiGlow, u7)
            _G.tween(u10.HakiGlow, {
                0.35,
                "Quad",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(v20, {
                0.35,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 55,
                ["Brightness"] = 0
            })
        end)
        return
    elseif p5 == "charge" then
        local v21 = u6.char
        local v22 = u6.arm
        local u23 = u2.ChargeImpact.ChargeImpact:Clone()
        local v24 = u2.Windburst.Wind2EnabledTillTop:Clone()
        local v25 = v22:FindFirstChild("Wind2EnabledTillTop", true)
        local v26 = u2.HeadStar.Eye:Clone()
        local v27 = u2.BuzzcutCharge:Clone()
        local v28 = u2.BuzzcutCharge2:Clone()
        local v29 = v22:FindFirstChild("Particles", true)
        local v30 = v22:FindFirstChild("Particles2", true)
        _G.PlayEffect("3SSRecolor", nil, u23, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v26, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v27, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v28, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v29, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v30, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v24, u8, "isRed")
        _G.PlayEffect("3SSRecolor", nil, v22, u8, "isRed")
        u4.apply(u23, u7)
        u4.apply(v24, u7)
        u4.apply(v26, u7)
        u4.apply(v27, u7)
        u4.apply(v28, u7)
        u4.apply(v29, u7)
        u4.apply(v30, u7)
        u4.apply(v22, u7)
        u23.Parent = v22.RootPart:FindFirstChild("16_Arm", true)
        v24.Parent = v22.RootPart:FindFirstChild("16_Arm", true)
        local v31 = Instance.new("Highlight")
        v31.Name = "ChargeHighlight"
        v31.OutlineTransparency = 0.5
        v31.DepthMode = Enum.HighlightDepthMode.Occluded
        v31.FillColor = Color3.fromRGB(13, 25, 60)
        v31.OutlineColor = u8
        local v32 = u4.getWeaponColors(v21)
        if v32 then
            if v32["d4e5f6a7-b8c9-0123-4567-890abcdef012_fill"] then
                local v33, v34 = pcall(Color3.fromHex, v32["d4e5f6a7-b8c9-0123-4567-890abcdef012_fill"])
                if v33 then
                    v31.FillColor = v34
                end
            end
            if v32["d4e5f6a7-b8c9-0123-4567-890abcdef012_outline"] then
                local v35, v36 = pcall(Color3.fromHex, v32["d4e5f6a7-b8c9-0123-4567-890abcdef012_outline"])
                if v35 then
                    v31.OutlineColor = v36
                end
            end
        end
        v31.Parent = v21
        _G.customEmit(u23)
        _G.particleEnabled(v24, true)
        _G.particleEnabled(v25, false)
        v26.Parent = v21.Head
        v27:PivotTo(v21:GetPivot() * CFrame.new(0, -2, 0) * CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966))
        v28:PivotTo(CFrame.new(v21:GetPivot().Position) * CFrame.new(0, -2, 0) * CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966))
        _G.particleEnabled(v27, true)
        _G.particleEnabled(v28, true)
        _G.particleEnabled(v30, true)
        _G.particleEnabled(v29, true)
        v27.Parent = u3
        v28.Parent = u3
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 18,
            ["Position"] = v21.PrimaryPart.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 1,
            ["TweenDuration"] = 2,
            ["Radius"] = 15,
            ["Direction"] = Vector3.new(0, -35, 0)
        })
        task.delay(1.2, function() --[[ Line: 170 ]]
            --[[
            Upvalues:
                [1] = u23
            --]]
            u23:Destroy()
        end)
        _G.PlaySound(u7.PrimaryPart, script.MochiV2BuzzcutDrop)
        repeat
            task.wait()
        until v21:GetAttribute("buzzcutCharging") == nil or v21:IsDescendantOf(game) == false
        v31:Destroy()
        _G.particleEnabled(v28, false)
        _G.particleEnabled(v26, false)
        _G.particleEnabled(v30, false)
        _G.particleEnabled(v24, false)
        _G.particleEnabled(v29, false)
        _G.destroy({ v26, v27, v28 }, 3)
        return
    elseif p5 == "startSwing" then
        local v37 = u6.char
        local v38 = u6.arm
        local v39 = tick()
        local v40 = RaycastParams.new()
        v40.FilterType = Enum.RaycastFilterType.Include
        v40.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
        local v41 = v37.PrimaryPart
        local v42 = v38:FindFirstChild("16_Arm", true)
        local v43 = v38:FindFirstChild("5_Arm", true)
        local v44 = Random.new()
        local v45 = script.GroundFireTrail:Clone()
        _G.PlayEffect("3SSRecolor", nil, v45, u8, "isRed")
        u4.apply(v45, v37)
        local v46 = v45.MochiV2UltGroundScrapeLoop
        _G.particleEnabled(v45, false)
        v45.CFrame = v42.WorldCFrame
        v45.Parent = workspace.Effects
        local v47 = script.MochiV2BuzzcutLoop:Clone()
        v47.Parent = v37.PrimaryPart
        v47:Play()
        local v48 = 0
        while v37.PrimaryPart ~= nil and v37:IsDescendantOf(workspace) ~= false do
            local v49 = (v43.WorldPosition - v37.PrimaryPart.Position).Magnitude
            local v50, v51, v52 = _G.getRayFloor(CFrame.new(v42.WorldCFrame.Position + Vector3.new(0, 5, 0)), 25)
            if v50 then
                v45.CFrame = CFrame.new(v51, v51 + v52) * CFrame.Angles(-1.5707963267948966, 0, 0)
                if v45.Impact.Enabled == false then
                    _G.particleEnabled(v45, true, true)
                end
                local v53 = script.dustGround:Clone()
                v53.CFrame = CFrame.new(v51)
                v53.groundSmoke.Acceleration = v43.WorldCFrame.LookVector * -30
                _G.recolorParticles(v53, v50.Color)
                v53.Parent = workspace.Effects
                _G.destroy(v53, 3)
                _G.customEmit(v53)
                if v46.IsPlaying == false then
                    v46:Play()
                end
            else
                if v45.Impact.Enabled == true then
                    _G.particleEnabled(v45, false, true)
                end
                if v46.IsPlaying == true then
                    v46:Stop()
                end
            end
            if tick() - v39 >= 0.3 then
                local _ = v43.CFrame.Y / 0.7
                local v54 = u2.WindMeshes:Clone()
                u4.apply(v54, v37)
                local v55 = v54:GetChildren()
                for v56 = 1, #v55 do
                    local v57 = v55[v56]
                    local v58 = v55[v56].Size.Y
                    v57.Size = Vector3.new(v49, v58, v49)
                    local v59 = v55[v56].Mesh
                    local v60 = v55[v56].Mesh.Scale.Y + v49
                    v59.Scale = Vector3.new(v49, v60, v49)
                end
                _G.destroy(v54, 5)
                for v61 = 1, 5 do
                    local v62 = math.random(2, 5) / 10
                    local v63 = math.random(50, 100) / 100
                    local v64 = math.random(180, 360)
                    local u65 = v54:FindFirstChild("WindMesh" .. tostring(v61))
                    local v66 = u65.Mesh.Scale.X
                    local v67 = u65.Mesh.Scale.Y + 15
                    local v68 = u65.Mesh.Scale.Z
                    local v69 = Vector3.new(v66, v67, v68) * v63
                    u65.Mesh.Scale = Vector3.new(0, 0, 0)
                    u65.CFrame = v37.PrimaryPart.CFrame
                    u65.Parent = u3
                    _G.tween(u65.Mesh, {
                        v62,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = v69
                    })
                    _G.tween(u65.Decal, {
                        v62,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(u65, {
                        v62,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = u65.CFrame * CFrame.Angles(0, math.rad(v64), 0)
                    })
                    task.delay(0.4, function() --[[ Line: 293 ]]
                        --[[
                        Upvalues:
                            [1] = u65
                        --]]
                        u65:Destroy()
                    end)
                end
                local v70 = u2.Windburst:Clone()
                u4.apply(v70, v37)
                v70.CFrame = v37.PrimaryPart.CFrame
                v70.Parent = u3
                _G.customEmit(v70)
                _G.destroy(v70, 4)
                v39 = tick()
            end
            if v42 and tick() - v48 >= 0.1 then
                if _G.checkRenderDistance(v37.PrimaryPart.CFrame, 200) == true then
                    for _ = 1, 2 do
                        local v71 = v37.PrimaryPart.CFrame:Lerp(v42.WorldCFrame, math.random(0, 100) / 100)
                        local v72, v73, _ = _G.getRayFloor(v71, 15)
                        local v74 = CFrame.new(v71.Position, v71.Position + -v42.WorldCFrame.LookVector)
                        if v72 then
                            local _ = -v41.AssemblyLinearVelocity.Unit
                            local v75 = v44:NextInteger(-20, 20)
                            local v76 = v73 + Vector3.new(v75, 0, v44:NextInteger(-20, 20))
                            local v77 = _G.PlayEffect
                            local v78 = {
                                ["Position"] = v76,
                                ["Velocity"] = v74.LookVector * (v49 * 2 + 15) + Vector3.new(0, 50, 0),
                                ["AngularVelocity"] = Random.new():NextUnitVector() * 15,
                                ["Material"] = v72.Material
                            }
                            local v79 = math.random(2)
                            local v80 = math.random(2)
                            local v81 = math.random
                            v78.Size = Vector3.new(v79, v80, v81(2))
                            v78.Color = v72.Color
                            v77("CreateRock", nil, v78)
                        end
                        local v82 = v74.LookVector * v49
                        local v83 = _G.PlayEffect
                        local v84 = math.random(500, 800) / 1000
                        local v85 = math.random(5, 30)
                        v83("MochiImpactDroplet", nil, v74, 1, 2, 25, v84, 0.7, v82 + Vector3.new(0, v85, 0), v37)
                    end
                end
                v48 = tick()
            end
            task.wait()
            if v37:GetAttribute("buzzcutSwing") == nil or v37.PrimaryPart == nil then
                break
            end
        end
        _G.tween(v47, {
            3,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v47, 3)
        _G.tween(v46, {
            3,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.particleEnabled(v45, false, true)
        _G.destroy(v45, 3)
    elseif p5 == "impact" then
        local u86 = u6.hitCFrame
        local u87 = u8 or Color3.fromRGB(255, 13, 0)
        local u88 = Color3.fromRGB(0, 0, 0)
        local v93, v94, v95 = pcall(function() --[[ Line: 370 ]]
            --[[
            Upvalues:
                [1] = u87
                [2] = u88
                [3] = u4
                [4] = u7
            --]]
            local v89 = Instance.new("Part")
            v89.Color = u87
            v89:SetAttribute("UniqueID", "a1b2c3d4-e5f6-7890-abcd-ef1234567890")
            local v90 = Instance.new("Part")
            v90.Color = u88
            v90:SetAttribute("UniqueID", "c3d4e5f6-a7b8-9012-cdef-123456789012")
            v90.Parent = v89
            u4.apply(v89, u7)
            local v91 = v89.Color
            local v92 = v90.Color
            v89:Destroy()
            return v91, v92
        end)
        local u96, u97
        if v93 then
            u87 = v94 or u87
            u88 = v95 or u88
            u96 = u87
            u97 = u88
        else
            u96 = u87
            u97 = u88
        end
        local u98 = u8 or Color3.fromRGB(255, 13, 0)
        local v102, v103 = pcall(function() --[[ Line: 391 ]]
            --[[
            Upvalues:
                [1] = u98
                [2] = u4
                [3] = u7
            --]]
            local v99 = Instance.new("Highlight")
            v99.OutlineColor = u98
            v99:SetAttribute("UniqueID", "b2c3d4e5-f6a7-8901-bcde-f12345678901")
            local v100 = Instance.new("Part")
            v99.Parent = v100
            u4.apply(v100, u7)
            local v101 = v99.OutlineColor
            v100:Destroy()
            return v101
        end)
        local v104
        if v102 then
            v104 = v103 or u98
        else
            v104 = u98
        end
        local u105 = script.Buzzcut.BuzzcutImpact:Clone()
        _G.PlayEffect("3SSRecolor", nil, u105, u8, "isRed")
        u105.CFrame = u86 * CFrame.Angles(0, 3.141592653589793, 0)
        u105.PointLight.Color = u8
        u4.apply(u105, u7)
        u105.Parent = u3
        _G.customEmit(u105)
        local v106 = (workspace.CurrentCamera.CFrame.Position - u86.Position).Magnitude < 300
        if v106 == true then
            _G.camShake:Shake(_G.camShake.Presets.PunchHeavy)
        end
        local u107 = CFrame.new(u86.Position + Vector3.new(0, 5, 0))
        local u108 = Random.new()
        local u109 = Instance.new("Model")
        u109.Parent = workspace.Effects
        local u110 = Instance.new("Highlight")
        u110.FillColor = Color3.fromRGB(0, 0, 0)
        u110.OutlineColor = v104
        u110.FillTransparency = -1
        u110.OutlineTransparency = -5
        u110.DepthMode = Enum.HighlightDepthMode.Occluded
        u110.Parent = u109
        _G.PlaySound(u86, script.MochiV2BuzzcutBoom)
        local v111 = script.invert:Clone()
        v111.CFrame = u86
        v111.Color = u8
        u4.apply(v111, u7)
        v111.Parent = workspace.Effects
        _G.tween(v111, {
            0.5,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(150, 150, 150),
            ["Transparency"] = 1
        })
        _G.destroy(v111, 0.5)
        for _ = 1, 20 do
            local v112 = CFrame.Angles
            local v113 = math.random(0, 360)
            local v114 = u107 * v112(0, math.rad(v113), 0) * CFrame.new(0, 0, u108:NextInteger(10, 40))
            local v115, v116, v117 = _G.getRayFloor(v114, 15)
            if v115 then
                u108:NextInteger(4, 5)
                local v118 = _G.PlayEffect
                local v119 = {
                    ["PartCount"] = 1,
                    ["RandomVelocityMagnitude"] = Vector2.new(-25, 25),
                    ["Position"] = v116
                }
                local v120 = u108:NextInteger(100, 150)
                v119.Direction = Vector3.new(0, v120, 0)
                v119.RaycastDirection = Vector3.new(0, -15, 0)
                v119.Size = Vector3.new(5, 5, 2.5)
                v119.TrailEnabled = true
                v119.Duration = u108:NextInteger(0.5, 1)
                function v119.customFunction(u121) --[[ Line: 471 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                    --]]
                    pcall(function() --[[ Line: 472 ]]
                        --[[
                        Upvalues:
                            [1] = u121
                            [2] = u109
                        --]]
                        u121.Parent = u109
                    end)
                end
                v118("RockDebris", nil, v119)
                local v122 = _G.PlayEffect
                local v123 = u108:NextInteger(75, 125)
                v122("MochiImpactDroplet", nil, v114, 1, 1.5, 35, 1, 1, Vector3.new(0, v123, 0), u7)
                if v115 then
                    local v124 = script.DustShockwave2:Clone()
                    _G.recolorParticles(v124, v115.Color)
                    v124.CFrame = CFrame.new(v116, v116 + v117) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v124.Parent = workspace.Effects
                    _G.customEmit(v124)
                    _G.destroy(v124, 5)
                end
            end
        end
        task.delay(0.3, function() --[[ Line: 492 ]]
            --[[
            Upvalues:
                [1] = u110
                [2] = u109
            --]]
            _G.tween(u110, {
                0.35,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            })
            _G.destroy(u110, 0.35)
            _G.destroy(u109, 10)
        end)
        local v125 = u2.Shockwave:Clone()
        u4.apply(v125, u7)
        v125:SetPrimaryPartCFrame(u86 * CFrame.Angles(0, 0, -1.5707963267948966) * CFrame.new(0, 5, 0))
        v125.Parent = workspace.Effects
        _G.destroy(v125, 5)
        local v126 = v125:GetChildren()
        for v127 = 1, #v126 do
            local u128 = v126[v127]
            local v129 = u128.Size
            u128.Size = v129 / 2 + Vector3.new(0, 30, 0)
            u128.Parent = u3
            _G.tween(u128, {
                0.8,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = v129
            })
            task.delay(1.3, function() --[[ Line: 513 ]]
                --[[
                Upvalues:
                    [1] = u128
                --]]
                u128:Destroy()
            end)
        end
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 25,
            ["Position"] = u86.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.25, 1),
            ["Duration"] = 5,
            ["TweenDuration"] = 1,
            ["Radius"] = 40,
            ["Direction"] = Vector3.new(0, -35, 0),
            ["Angle"] = -0.7853981633974483
        })
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 13,
            ["Position"] = u86.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 5,
            ["TweenDuration"] = 1,
            ["Radius"] = 12,
            ["Direction"] = Vector3.new(0, -35, 0),
            ["Angle"] = 0.7853981633974483
        })
        u105.PointLight.Color = u8
        u4.apply(u105.PointLight, u7)
        _G.tween(u105.PointLight, {
            0.5,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 60,
            ["Brightness"] = 0
        })
        local v130 = u2.WindMeshes:Clone()
        u4.apply(v130, u7)
        v130:ScaleTo(2)
        v130.Parent = workspace.Effects
        _G.destroy(v130, 3)
        for v131 = 1, 5 do
            local v132 = math.random(2, 5) / 2
            local v133 = math.random(50, 100) / 100
            local v134 = math.random(180, 360)
            local u135 = v130:FindFirstChild("WindMesh" .. tostring(v131))
            local v136 = u135.Mesh.Scale.X
            local v137 = u135.Mesh.Scale.Y + 60
            local v138 = u135.Mesh.Scale.Z
            local v139 = Vector3.new(v136, v137, v138) * v133
            u135.Mesh.Scale = v139 / 4
            u135.CFrame = u86 * CFrame.Angles(0, 0, -1.5707963267948966)
            u135.Decal.Transparency = 0.85
            u135.Parent = u3
            _G.tween(u135.Mesh, {
                v132,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = v139
            })
            _G.tween(u135.Decal, {
                v132,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(u135, {
                v132,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u135.CFrame * CFrame.Angles(0, math.rad(v134), 0)
            })
            task.delay(5, function() --[[ Line: 569 ]]
                --[[
                Upvalues:
                    [1] = u135
                --]]
                u135:Destroy()
            end)
        end
        Random.new()
        task.delay(0.3, function() --[[ Line: 575 ]]
            --[[
            Upvalues:
                [1] = u107
                [2] = u108
                [3] = u97
                [4] = u96
                [5] = u86
            --]]
            local v140 = 5
            for v141 = 1, 6 do
                local v142 = v141 * 120
                local v143 = math.rad(v142)
                local _ = u107 * CFrame.Angles(0, v143, 0)
                for v144 = 1, 4 do
                    local v145 = (v144 - 1) * 90
                    local v146 = math.rad(v145)
                    local v147 = u107 * CFrame.Angles(0, v146, 0) * CFrame.new(0, 0, u108:NextInteger(v140 / 4, v140))
                    local v148, v149, _ = _G.getRayFloor(v147, 15)
                    if v148 then
                        local v150 = CFrame.new(v149)
                        local v151 = (v150.Position - u107.Position).Unit
                        local v152 = v151.X
                        local v153 = u108:NextNumber(1, 2)
                        local v154 = v151.Z
                        local v155 = Vector3.new(v152, v153, v154).Unit
                        local v156 = u108:NextNumber(70, 85)
                        _G.PlayEffect("DeadLightning", nil, {
                            ["StartPosition"] = v150.Position,
                            ["EndPosition"] = v150.Position + v155 * v156,
                            ["Points"] = 3,
                            ["Size"] = math.random(300, 400) / 150,
                            ["RandomSize"] = NumberRange.new(0.75, 1),
                            ["Offset"] = NumberRange.new(-20, 20),
                            ["MainColor"] = u97,
                            ["GlowColor"] = u96,
                            ["Inverted"] = true,
                            ["LightningDuration"] = 0.1,
                            ["Branches"] = true,
                            ["WaitFunction"] = function(p157, _) --[[ Name: WaitFunction, Line 624 ]]
                                if p157 % 2 == 0 then
                                    task.wait(math.random(100, 300) / 10000)
                                end
                            end
                        })
                    end
                    task.wait()
                end
                _G.PlaySound(u86, script["MochiV2Lightning" .. math.random(1, 3)], {
                    ["RandomPitch"] = true
                })
                v140 = v140 * 1.4
                task.wait(0.3)
            end
        end)
        if v106 == true then
            task.delay(0.1, function() --[[ Line: 721 ]]
                local u158 = script.ImpactFrame:Clone()
                local u159 = script.ImpactFrame2:Clone()
                u158.Parent = workspace.CurrentCamera
                task.delay(0.1, function() --[[ Line: 726 ]]
                    --[[
                    Upvalues:
                        [1] = u158
                        [2] = u159
                    --]]
                    u158:Destroy()
                    u159.Parent = workspace.CurrentCamera
                    task.delay(0.1, function() --[[ Line: 729 ]]
                        --[[
                        Upvalues:
                            [1] = u159
                        --]]
                        u159:Destroy()
                    end)
                end)
            end)
        end
        task.delay(10, function() --[[ Line: 737 ]]
            --[[
            Upvalues:
                [1] = u105
            --]]
            u105:Destroy()
        end)
    end
end
return v1