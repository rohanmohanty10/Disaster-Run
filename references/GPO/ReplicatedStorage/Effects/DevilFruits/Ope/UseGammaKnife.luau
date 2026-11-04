 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, u3, u4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.PrimaryPart.Position) then
        local u5 = script
        local v6 = u3.HumanoidRootPart
        local u7 = game.Workspace.Effects:WaitForChild("opeKnife" .. u3.Name)
        u7.Name = "done"
        u7:SetAttribute("knifeShot", true)
        u7.spikeMeshFront.Size = Vector3.new(0.5, 2, 0.5)
        u7.spikeMeshBack.Size = Vector3.new(0.5, 2, 0.5)
        local _ = game.Players.LocalPlayer.Character == u3 or game.Players.LocalPlayer.Character == u4
        game:GetService("TweenService"):Create(u7.spikeMeshFront, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Size"] = Vector3.new(0.5, 6, 0.5)
        }, true):Play()
        local u8 = false
        for _, v9 in pairs(u7.Part.centerAttach:GetChildren()) do
            v9.Enabled = false
        end
        _G.customEmit(u7.Part.fireAttach, true)
        for _, v10 in pairs(u7.Part:GetChildren()) do
            if v10:IsA("ParticleEmitter") then
                if v10.Name == "burstParticle" then
                    v10.Enabled = true
                else
                    v10.Enabled = false
                end
            end
        end
        u7.Part.fireAttach.spikeGlow.Rate = 20
        u7.Part.spikeGlowAttach.centerGlow.Enabled = true
        local u11 = Instance.new("Part")
        u11.Size = Vector3.new(2, 2, 1)
        u11.Transparency = 0.05
        u11.Anchored = true
        u11.CanCollide = false
        u11.CFrame = v6.CFrame * CFrame.new(0, 0, -20)
        u11.Parent = workspace.Effects
        u11.Transparency = 1
        if u4 then
            u11.CFrame = u4.PrimaryPart.CFrame
            if u4:FindFirstChild("UpperTorso") then
                _G.customWeld(u11, u4.UpperTorso, CFrame.new(), u11)
            end
        end
        local _ = (u7.PrimaryPart.Position - u11.Position).Magnitude
        local u12 = u11.CFrame
        game:GetService("TweenService"):Create(u7.Part, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Size"] = Vector3.new(0.5, 8, 0.5)
        }, true):Play()
        local u13 = u5.cameraPart:Clone()
        u13.CFrame = game.Workspace.Camera.CFrame
        u13.Parent = workspace.Effects
        if u8 then
            u13.greenFill:Emit(6)
            _G.customEmit(u13.electricitySurround)
            u13.pulseWave:Emit(2)
            game:GetService("TweenService"):Create(u13.electricitySurround, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
                ["Rate"] = 500
            }, true):Play()
            game:GetService("TweenService"):Create(u13.greenFill, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
                ["Rate"] = 10
            }, true):Play()
        end
        _G.destroy(u13, 7)
        if _G.cameraShakeEnabled == true then
            task.spawn(function() --[[ Line: 115 ]]
                for v14 = 10, 0, -1 do
                    local v15 = v14 / 30
                    local v16 = game.Players.LocalPlayer.Character.Humanoid
                    local v17 = Random.new():NextNumber(-2, 2) * v15
                    local v18 = Random.new():NextNumber(-2, 2) * v15
                    local v19 = Random.new():NextNumber(-2, 2) * v15
                    v16.CameraOffset = Vector3.new(v17, v18, v19)
                    task.wait(0.025)
                end
                game.Players.LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
            end)
        end
        local u20 = {}
        local u21 = {}
        local u22 = tick()
        local v27 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 136 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u13
                [3] = u22
                [4] = u20
                [5] = u21
            --]]
            if u7.PrimaryPart and u7.PrimaryPart.WeldConstraint.Enabled then
                u7.spikeMeshFront.WeldConstraint.Enabled = false
                u7.spikeMeshFront.CFrame = u7.spikeMeshBack.CFrame * CFrame.new(0, -u7.spikeMeshFront.Size.Y / 2 - u7.spikeMeshBack.Size.Y / 2, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                u7.spikeMeshFront.WeldConstraint.Enabled = true
            end
            u13.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -1)
            if tick() - u22 > 0.0125 then
                for v23, v24 in pairs(u20) do
                    local v25 = v24.thicknessVal
                    local v26 = u21[v23]
                    if v25.Value > 0.01 then
                        v26.Thickness = v25.Value
                    else
                        table.remove(u20, v23)
                        table.remove(u21, v23)
                        v26:Destroy()
                    end
                end
                u22 = tick()
            end
        end)
        if u4 and true or false then
            local u28 = u5.absorbPart:Clone()
            u28.CFrame = u11.CFrame
            u28.Parent = workspace.Effects
            _G.customWeld(u28, u4.UpperTorso, CFrame.new(), u28)
            _G.destroy(u28, 7)
            for _, v29 in pairs(u28.explodeAttach:GetChildren()) do
                v29:Emit(v29.Rate * 0.1)
            end
            for _ = 1, 10 do
                local v30 = RaycastParams.new()
                v30.FilterType = Enum.RaycastFilterType.Whitelist
                v30.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
                v30.IgnoreWater = true
                local v31 = u7.PrimaryPart.Position
                local v32 = Random.new():NextNumber(-3, 3)
                local v33 = Random.new():NextNumber(-3, 3)
                local v34 = Random.new()
                local v35 = v31 + Vector3.new(v32, v33, v34:NextNumber(-3, 3))
                local v36 = workspace:Raycast(u28.Position, CFrame.new(u28.Position, v35).LookVector * 15, v30)
                local v37
                if v36 == nil then
                    v37 = CFrame.new(u7.PrimaryPart.Position, v35) * CFrame.new(0, 0, -15)
                else
                    v37 = CFrame.new(v36.Position, u7.PrimaryPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                end
                local v38 = u5.offPart:Clone()
                v38.CFrame = v37
                v38.lightning1.Enabled = false
                v38.lightningSpikes.Enabled = false
                v38.orbDrop.Enabled = false
                v38.Parent = workspace.Effects
                _G.destroy(v38, 7)
                table.insert(u20, v38)
                local v39 = Instance.new("NumberValue")
                v39.Name = "thicknessVal"
                v39.Value = Random.new():NextNumber(2, 2.6)
                game:GetService("TweenService"):Create(v39, TweenInfo.new(Random.new():NextNumber(0.2, 0.35), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Value"] = 0
                }, true):Play()
                v39.Parent = v38
                _G.destroy(v39, 7)
                local v40 = u2.new(u7.Part.centerAttach, v38.attach2, 12)
                v40.MaxRadius = 2
                v40.PulseSpeed = 20
                v40.AnimationSpeed = 20
                v40.Thickness = v39.Value
                v40.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                v40.GivenParent = u7
                table.insert(u21, v40)
            end
            task.delay(0.1, function() --[[ Line: 238 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u12
                    [3] = u28
                    [4] = u3
                    [5] = u13
                    [6] = u4
                    [7] = u5
                    [8] = u20
                    [9] = u2
                    [10] = u21
                    [11] = u8
                    [12] = u11
                --]]
                u7.PrimaryPart.WeldConstraint.Enabled = false
                for _, v41 in pairs(u7:GetChildren()) do
                    if v41:IsA("BasePart") then
                        v41.Anchored = true
                    end
                end
                u7.Part.Anchored = true
                u7.spikeMeshFront.Anchored = true
                u7.spikeMeshBack.Anchored = true
                u7.middleSphere.Anchored = true
                game:GetService("TweenService"):Create(u7.Part.spikeGlowAttach.centerGlow, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Rate"] = 0
                }, true):Play()
                game:GetService("TweenService"):Create(u7.spikeMeshFront, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Position"] = u12.Position,
                    ["Size"] = Vector3.new(0, 0, 0)
                }, true):Play()
                game:GetService("TweenService"):Create(u7.spikeMeshBack, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Position"] = u12.Position,
                    ["Size"] = Vector3.new(0, 0, 0)
                }, true):Play()
                game:GetService("TweenService"):Create(u7.Part, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Position"] = u12.Position,
                    ["Size"] = Vector3.new(0, 0, 0)
                }, true):Play()
                for _, v42 in pairs(u7.Part:GetChildren()) do
                    if v42:IsA("ParticleEmitter") and v42.Name == "burstParticle" then
                        game:GetService("TweenService"):Create(v42, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                            ["Rate"] = 0
                        }, true):Play()
                    end
                end
                u7.Part.fireAttach.spikeGlow.Enabled = false
                for _, v43 in pairs(u28.growAttach:GetChildren()) do
                    v43.Enabled = true
                    game:GetService("TweenService"):Create(v43, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        ["Rate"] = v43.Rate * 100
                    }, true):Play()
                end
                for _, v44 in pairs(u28.storedAttach:GetChildren()) do
                    v44.Enabled = true
                    game:GetService("TweenService"):Create(v44, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        ["Rate"] = v44.Rate * 100
                    }, true):Play()
                end
                _G.PlaySound(u3.PrimaryPart, script.GammaStabHitPlayerCharge)
                task.wait(0.6)
                for _, v45 in pairs(u28.growAttach:GetChildren()) do
                    v45.Enabled = true
                    game:GetService("TweenService"):Create(v45, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        ["Rate"] = 0
                    }, true):Play()
                end
                task.wait(0.72)
                game:GetService("TweenService"):Create(u13.electricitySurround, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Rate"] = 500
                }, true):Play()
                game:GetService("TweenService"):Create(u13.greenFill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Rate"] = 5
                }, true):Play()
                task.wait(0.18)
                if (u3 == game.Players.LocalPlayer.Character and true or u4 == game.Players.LocalPlayer.Character) == true then
                    game.Lighting.ColorCorrectionF.Brightness = 0.2
                    game.Lighting.ColorCorrectionF.Contrast = 1
                    game.Lighting.ColorCorrectionF.Saturation = 1
                    game.Lighting.ColorCorrectionF.TintColor = Color3.fromRGB(0, 189, 76)
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Brightness"] = 0,
                        ["Contrast"] = 0,
                        ["Saturation"] = 0,
                        ["TintColor"] = Color3.fromRGB(255, 255, 255)
                    }, true):Play()
                end
                u13.pulseWave:Emit(20)
                u13.outerPulse:Emit(5)
                u13.greenFill.Enabled = true
                u13.electricitySurround.Enabled = true
                u13.pulseWave.Enabled = true
                u13.stopPulse.Enabled = true
                _G.customWeld(u7.PrimaryPart, u4.UpperTorso, CFrame.new(), u7)
                _G.PlaySound(u3.PrimaryPart, script.GammaEndExplosionKnockback)
                local v46 = RaycastParams.new()
                v46.FilterType = Enum.RaycastFilterType.Include
                v46.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
                v46.IgnoreWater = true
                for _ = 1, 10 do
                    local v47 = u7.PrimaryPart.Position
                    local v48 = Random.new():NextNumber(-3, 3)
                    local v49 = Random.new():NextNumber(-3, 3)
                    local v50 = Random.new()
                    local v51 = v47 + Vector3.new(v48, v49, v50:NextNumber(-3, 3))
                    local v52 = workspace:Raycast(u28.Position, CFrame.new(u28.Position, v51).LookVector * 30, v46)
                    local v53
                    if v52 == nil then
                        v53 = CFrame.new(u7.PrimaryPart.Position, v51) * CFrame.new(0, 0, -30)
                    else
                        v53 = CFrame.new(v52.Position, u7.PrimaryPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                    end
                    local v54 = u5.offPart:Clone()
                    v54.CFrame = v53
                    v54.lightning1.Enabled = false
                    v54.lightningSpikes.Enabled = false
                    v54.orbDrop.Enabled = false
                    v54.Parent = workspace.Effects
                    _G.customWeld(v54, u4.UpperTorso, CFrame.new(), v54)
                    _G.destroy(v54, 7)
                    local v55 = u20
                    table.insert(v55, v54)
                    local v56 = Instance.new("NumberValue")
                    v56.Name = "thicknessVal"
                    v56.Value = Random.new():NextNumber(12, 15)
                    game:GetService("TweenService"):Create(v56, TweenInfo.new(Random.new():NextNumber(0.2, 0.35), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Value"] = 0
                    }, true):Play()
                    v56.Parent = v54
                    _G.destroy(v56, 7)
                    local v57 = u2.new(u7.Part.centerAttach, v54.attach2, 12)
                    v57.MaxRadius = 2
                    v57.PulseSpeed = 20
                    v57.AnimationSpeed = 20
                    v57.Thickness = v56.Value
                    v57.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                    v57.GivenParent = u7
                    local v58 = u21
                    table.insert(v58, v57)
                end
                for _, v59 in pairs(u28.storedAttach:GetChildren()) do
                    v59.Enabled = false
                end
                for _, v60 in pairs(u28.explodeBurstAttach:GetChildren()) do
                    v60:Emit(v60.Rate)
                end
                local u61 = Instance.new("NumberValue")
                u61.Value = 1
                game:GetService("TweenService"):Create(u61, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Value"] = 0.3
                }, true):Play()
                _G.destroy(u61, 7)
                for _, v62 in pairs(u28.explodeAttach:GetChildren()) do
                    v62.Enabled = true
                    game:GetService("TweenService"):Create(v62, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ["Rate"] = v62.Rate * 0.5
                    }, true):Play()
                end
                _G.PlaySound(u4.PrimaryPart, script.GammaEndElectrocute).Parent = u4.PrimaryPart
                if (workspace.CurrentCamera.CFrame.Position - u28.CFrame.Position).Magnitude >= 100 then
                    _G.particleEnabled(u13, false, true)
                end
                local u63 = true
                task.spawn(function() --[[ Line: 421 ]]
                    --[[
                    Upvalues:
                        [1] = u63
                        [2] = u8
                        [3] = u28
                        [4] = u61
                        [5] = u7
                        [6] = u5
                        [7] = u20
                        [8] = u2
                        [9] = u21
                    --]]
                    while u63 do
                        if _G.cameraShakeEnabled == true and u8 == true then
                            local v64 = game.Players.LocalPlayer.Character.Humanoid
                            local v65 = Random.new():NextNumber(-2, 2)
                            local v66 = Random.new():NextNumber(-2, 2)
                            local v67 = Random.new()
                            v64.CameraOffset = Vector3.new(v65, v66, v67:NextNumber(-2, 2))
                        end
                        u28.explodeAttach.backGlow.Size = NumberSequence.new(25 * u61.Value)
                        u28.explodeAttach.centerGlow.Size = NumberSequence.new(20 * u61.Value)
                        u28.explodeAttach.largeLightningSpikes.Size = NumberSequence.new(10 * u61.Value)
                        u28.explodeAttach.lightning1.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 4.25 * u61.Value, 0.851 * u61.Value), NumberSequenceKeypoint.new(1, 4.25 * u61.Value, 0.851 * u61.Value) })
                        u28.explodeAttach.lineBursts.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3.89 * u61.Value, 0.739 * u61.Value), NumberSequenceKeypoint.new(1, 0, 0) })
                        u28.explodeAttach.lightningSpikes.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 5.26 * u61.Value, 0.97 * u61.Value),
                            NumberSequenceKeypoint.new(0.0742, 4.03 * u61.Value, 1.08 * u61.Value),
                            NumberSequenceKeypoint.new(0.181, 3.17 * u61.Value, 1.31 * u61.Value),
                            NumberSequenceKeypoint.new(0.319, 2.87 * u61.Value, 1.38 * u61.Value),
                            NumberSequenceKeypoint.new(1, 2.91 * u61.Value, 1.38 * u61.Value)
                        })
                        u28.explodeAttach.backWaves.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0, 0),
                            NumberSequenceKeypoint.new(0.2, 12.23 * u61.Value, 3.25 * u61.Value),
                            NumberSequenceKeypoint.new(0.42, 18.97 * u61.Value, 4 * u61.Value),
                            NumberSequenceKeypoint.new(0.65, 22.09 * u61.Value, 4.87 * u61.Value),
                            NumberSequenceKeypoint.new(1, 24.67 * u61.Value, 5.43 * u61.Value)
                        })
                        u28.explodeAttach.outerWaves2.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0, 0),
                            NumberSequenceKeypoint.new(0.2, 12.23 * u61.Value, 3.25 * u61.Value),
                            NumberSequenceKeypoint.new(0.42, 18.97 * u61.Value, 4 * u61.Value),
                            NumberSequenceKeypoint.new(0.65, 22.09 * u61.Value, 4.87 * u61.Value),
                            NumberSequenceKeypoint.new(1, 24.67 * u61.Value, 5.43 * u61.Value)
                        })
                        local v68 = RaycastParams.new()
                        v68.FilterType = Enum.RaycastFilterType.Whitelist
                        v68.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
                        v68.IgnoreWater = true
                        local v69 = u7.PrimaryPart.Position
                        local v70 = Random.new():NextNumber(-3, 3)
                        local v71 = Random.new():NextNumber(-3, 3)
                        local v72 = Random.new()
                        local v73 = v69 + Vector3.new(v70, v71, v72:NextNumber(-3, 3))
                        local v74 = workspace:Raycast(u28.Position, CFrame.new(u28.Position, v73).LookVector * 20 * u61.Value, v68)
                        local v75
                        if v74 == nil then
                            v75 = CFrame.new(u7.PrimaryPart.Position, v73) * CFrame.new(0, 0, -20 * u61.Value)
                        else
                            v75 = CFrame.new(v74.Position, u7.PrimaryPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                        end
                        local v76 = u5.offPart:Clone()
                        v76.CFrame = v75
                        v76.lightning1.Enabled = false
                        v76.lightningSpikes.Enabled = false
                        v76.orbDrop.Enabled = false
                        v76.Parent = workspace.Effects
                        _G.destroy(v76, 7)
                        local v77 = u20
                        table.insert(v77, v76)
                        local v78 = Instance.new("NumberValue")
                        v78.Name = "thicknessVal"
                        v78.Value = Random.new():NextNumber(1.5, 2)
                        game:GetService("TweenService"):Create(v78, TweenInfo.new(Random.new():NextNumber(0.2, 0.4), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ["Value"] = 0
                        }, true):Play()
                        v78.Parent = v76
                        _G.destroy(v78, 7)
                        local v79 = u2.new(u7.Part.centerAttach, v76.attach2, 12)
                        v79.MaxRadius = 2
                        v79.PulseSpeed = 20
                        v79.AnimationSpeed = 20
                        v79.Thickness = v78.Value
                        v79.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                        v79.GivenParent = u7
                        local v80 = u21
                        table.insert(v80, v79)
                        task.wait(0.00625)
                    end
                    if u8 == true and _G.cameraShakeEnabled == true then
                        task.spawn(function() --[[ Line: 519 ]]
                            for v81 = 20, 0, -1 do
                                local v82 = v81 / 30
                                local v83 = game.Players.LocalPlayer.Character.Humanoid
                                local v84 = Random.new():NextNumber(-4, 4) * v82
                                local v85 = Random.new():NextNumber(-4, 4) * v82
                                local v86 = Random.new():NextNumber(-4, 4) * v82
                                v83.CameraOffset = Vector3.new(v84, v85, v86)
                                task.wait(0.025)
                            end
                            game.Players.LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                        end)
                    end
                end)
                task.wait(2)
                u63 = false
                if u8 then
                    u13.outerPulse:Emit(5)
                    u13.pulseWave.Enabled = false
                    u13.stopPulse.Enabled = false
                    u13.electricitySurround.Rate = 30
                    u13.greenFill.Rate = 3
                    game:GetService("TweenService"):Create(u13.electricitySurround, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["Rate"] = 0
                    }, true):Play()
                    game:GetService("TweenService"):Create(u13.greenFill, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["Rate"] = 0
                    }, true):Play()
                end
                if u8 == true then
                    game.Lighting.BlurF.Size = 30
                    game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Size"] = 0
                    }, true):Play()
                end
                u28.explodeBurstAttach.flashGlow.Lifetime = NumberRange.new(0.5)
                u28.explodeBurstAttach.flashGlow:Emit(15)
                for _, v87 in pairs(u28.explodeAttach:GetChildren()) do
                    v87.Enabled = false
                end
                _G.customEmit(u28.dissipateAttach, true)
                local u88 = u5.bodyPart:Clone()
                u88.CFrame = u11.CFrame
                u88.Parent = workspace.Effects
                _G.destroy(u88, 7)
                u88.WeldConstraint.Part1 = u11
                local u89 = Instance.new("NumberValue")
                u89.Value = 1
                game:GetService("TweenService"):Create(u89, TweenInfo.new(2.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Value"] = 0
                }, true):Play()
                _G.destroy(u89, 7)
                local u90 = true
                task.spawn(function() --[[ Line: 586 ]]
                    --[[
                    Upvalues:
                        [1] = u90
                        [2] = u88
                        [3] = u89
                        [4] = u3
                        [5] = u11
                        [6] = u28
                        [7] = u5
                        [8] = u20
                        [9] = u2
                        [10] = u7
                        [11] = u21
                    --]]
                    while u90 do
                        u88.lightning1.Rate = 80 * u89.Value
                        u88.smoke.Rate = 40 * u89.Value
                        u88.backSmoke.Rate = 20 * u89.Value
                        u88.detailSmoke.Rate = 6 * u89.Value
                        local v91 = RaycastParams.new()
                        v91.FilterType = Enum.RaycastFilterType.Blacklist
                        v91.FilterDescendantsInstances = { u3, workspace.Effects }
                        v91.IgnoreWater = true
                        local v92 = u11.CFrame * CFrame.new(Random.new():NextNumber(-u11.Size.X / 2, u11.Size.X / 2), Random.new():NextNumber(-u11.Size.Y / 2, u11.Size.Y / 2), Random.new():NextNumber(-u11.Size.Z / 2, u11.Size.Z / 2)).Position
                        local v93 = u11.Position
                        local v94 = Random.new():NextNumber(-3, 3)
                        local v95 = Random.new():NextNumber(-3, 3)
                        local v96 = Random.new()
                        local v97 = v93 + Vector3.new(v94, v95, v96:NextNumber(-3, 3))
                        local v98 = workspace:Raycast(v92, CFrame.new(u28.Position, v97).LookVector * 10, v91)
                        local v99
                        if v98 == nil then
                            v99 = CFrame.new(v92, v97) * CFrame.new(0, 0, -10)
                        else
                            v99 = CFrame.new(v98.Position, u11.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                        end
                        local v100 = u5.offPart:Clone()
                        v100.CFrame = v99
                        v100.lightning1.Enabled = false
                        v100.lightningSpikes.Enabled = false
                        v100.orbDrop.Enabled = false
                        v100.Parent = workspace.Effects
                        _G.destroy(v100, 7)
                        local v101 = u20
                        table.insert(v101, v100)
                        local v102 = Instance.new("Attachment")
                        v102.Position = v92 - u11.Position
                        v102.Parent = u11
                        local v103 = Instance.new("NumberValue")
                        v103.Name = "thicknessVal"
                        v103.Value = Random.new():NextNumber(1, 1.3)
                        game:GetService("TweenService"):Create(v103, TweenInfo.new(Random.new():NextNumber(0.15, 0.2), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ["Value"] = 0
                        }, true):Play()
                        v103.Parent = v100
                        _G.destroy(v103, 7)
                        local v104 = u2.new(v102, v100.attach2, 12)
                        v104.MaxRadius = 2
                        v104.PulseSpeed = 20
                        v104.AnimationSpeed = 20
                        v104.Thickness = v103.Value
                        v104.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                        v104.GivenParent = u7
                        local v105 = u21
                        table.insert(v105, v104)
                        task.wait(0.05 + (0.2 - 0.2 * u89.Value))
                    end
                end)
                task.wait(2.5)
                u88.lightning1.Enabled = false
                u88.smoke.Enabled = false
                u88.backSmoke.Enabled = false
                u88.detailSmoke.Enabled = false
                u90 = false
            end)
            task.wait(8)
            v27:Disconnect()
        else
            task.wait(0.4)
            game:GetService("TweenService"):Create(u7.spikeMeshFront, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new(0, 0, 0)
            }, true):Play()
            game:GetService("TweenService"):Create(u7.spikeMeshBack, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new(0, 0, 0)
            }, true):Play()
            for _, v106 in pairs(u7.Part:GetChildren()) do
                if v106:IsA("ParticleEmitter") then
                    game:GetService("TweenService"):Create(v106, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ["Rate"] = 0
                    }, true):Play()
                end
            end
            for _, v107 in pairs(u7.Part.spikeGlowAttach:GetChildren()) do
                game:GetService("TweenService"):Create(v107, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["Rate"] = 0
                }, true):Play()
            end
            game:GetService("TweenService"):Create(u7.Part.fireAttach.spikeGlow, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["Rate"] = 0
            }, true):Play()
            task.wait(0.65)
            _G.customEmit(u7.Part.burstAttach, true)
            task.wait(2)
            v27:Disconnect()
        end
    end
end
return v1