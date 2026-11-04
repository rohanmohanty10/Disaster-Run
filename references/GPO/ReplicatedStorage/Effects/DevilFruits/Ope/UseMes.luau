 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
function v1.start(_, u4, p5, p6, p7, u8, _) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(u4.PrimaryPart.Position) then
        local v9 = script
        local v10 = u4.HumanoidRootPart
        local u11 = game.Workspace.Effects:WaitForChild("prepMesHandPart" .. u4.Name, 3)
        if u11 ~= nil then
            game:GetService("TweenService"):Create(u11.shockSound, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }, true):Play()
            _G.destroy(u11, 0.9)
            _G.PlaySound(u4.PrimaryPart, script.OpeMesDash)
            local v12 = RaycastParams.new()
            v12.FilterType = Enum.RaycastFilterType.Whitelist
            v12.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            v12.IgnoreWater = true
            local v13 = workspace:Raycast(p6.Position, CFrame.new(p6.Position, p6.Position - Vector3.new(0, 1000, 0)).LookVector * 5, v12)
            if v13 ~= nil and v13.Instance ~= nil then
                local v14 = v9.floorPart:Clone()
                v14.CFrame = CFrame.lookAt(v13.Position, v13.Position + v13.Normal, p6.LookVector) * CFrame.Angles(0, 0, 3.141592653589793)
                v14.Parent = workspace.Effects
                _G.destroy(v14, 1.5)
                v14.dustCloud.Color = ColorSequence.new(v13.Instance.Color)
                v14.dustSpike.Color = ColorSequence.new(v13.Instance.Color)
                _G.customEmit(v14, true)
            end
            local v15 = v9.beamPart:Clone()
            local v16 = v15.middleAttach
            local v17 = -(p5 * 2.5) / 2
            v16.Position = Vector3.new(0, 0, v17)
            local v18 = v15.stopAttach
            local v19 = -p5 * 2.5
            v18.Position = Vector3.new(0, 0, v19)
            v15.CFrame = p6 * CFrame.Angles(0, 3.141592653589793, 0)
            v15.Parent = workspace.Effects
            _G.destroy(v15, 3)
            game:GetService("TweenService"):Create(v15.Beam, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["TextureSpeed"] = 0.5,
                ["Brightness"] = 1,
                ["LightEmission"] = 0
            }, true):Play()
            game:GetService("TweenService"):Create(v15.BGbeam, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }, true):Play()
            game:GetService("TweenService"):Create(v15.Beam, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }, true):Play()
            _G.customEmit(v15.middleAttach, true)
            game:GetService("TweenService"):Create(v15.middleAttach.glowBurst, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["LightEmission"] = 0
            }, true):Play()
            v15.startAttach.flareBurst:Emit(15)
            game:GetService("TweenService"):Create(v15.startAttach.flareBurst, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["LightEmission"] = 0
            }, true):Play()
            game:GetService("TweenService"):Create(v15.lightningBurst, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["LightEmission"] = 0
            }, true):Play()
            game:GetService("TweenService"):Create(v15.electricityBurst, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["LightEmission"] = 0
            }, true):Play()
            _G.customEmit(v15.electricityBurst)
            _G.customEmit(v15.lightningBurst)
            _G.customEmit(v15.lineBurst)
            _G.customEmit(v15.orbBurst)
            local u20 = Instance.new("NumberValue")
            u20.Value = 5
            game:GetService("TweenService"):Create(u20, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Value"] = 0
            }, true):Play()
            _G.destroy(u20, 1)
            task.spawn(function() --[[ Line: 127 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                while u20.Value > 0.01 do
                    task.wait()
                end
            end)
            u11.centerAttach.waveAbsorb.Enabled = false
            for _, v21 in pairs(u11.centerAttach:GetChildren()) do
                game:GetService("TweenService"):Create(v21, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Rate"] = 0
                }, true):Play()
            end
            for _, v22 in pairs(u11:GetChildren()) do
                if v22:IsA("ParticleEmitter") then
                    game:GetService("TweenService"):Create(v22, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ["Rate"] = 0
                    }, true):Play()
                end
            end
            local v23 = Instance.new("Attachment")
            v23.WorldCFrame = v15.middleAttach.WorldCFrame
            v23.Parent = workspace.Terrain
            local v24 = Instance.new("Attachment")
            v24.Parent = u11
            local v25 = u2.new(v23, v24, 25)
            v25.CurveSize0 = 0
            v25.CurveSize1 = 0
            v25.PulseSpeed = 10
            v25.AnimationSpeed = 0
            v25.PulseLength = 3
            v25.FadeLength = 0.8
            v25.Thickness = 0.2
            v25.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
            v25.MinTransparency = 0
            v25.Frequency = 5
            v25.MinThicknessMultiplier = 0.75
            v25.MaxThicknessMultiplier = 1
            v25.MinRadius = 0
            v25.MaxRadius = 1
            v25.Velocity = (v24.WorldPosition - v23.WorldPosition).Unit * 100
            local v26 = u3.new(v25)
            v26.MaxDistance = 5
            v26.MinDistance = 4
            v26.MaxSparkCount = 10
            v26.MaxSpeed = 10
            for _ = 1, 3 do
                local v27 = p6 * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3))
                local v28 = Instance.new("Attachment")
                v28.Parent = workspace.Terrain
                _G.destroy(v28, 1)
                v28.WorldCFrame = v27
                local v29 = v28
                local v30 = Instance.new("Attachment")
                v30.Parent = workspace.Terrain
                _G.destroy(v30, 1)
                if v10 then
                    v30.Parent = v10
                else
                    v30.WorldCFrame = p6
                end
                local v31 = v30
                local v32 = u2.new(v29, v31, 10)
                v32.CurveSize0 = 0
                v32.CurveSize1 = 0
                v32.PulseSpeed = 10
                v32.AnimationSpeed = 5
                v32.PulseLength = 2
                v32.FadeLength = 0.8
                v32.Thickness = 0.2
                v32.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                v32.MinTransparency = 0
                v32.Frequency = 0.5
                v32.MinThicknessMultiplier = 0.75
                v32.MaxThicknessMultiplier = 1
                v32.MinRadius = 0
                v32.MaxRadius = 5
                v32.Velocity = (v31.WorldPosition - v29.WorldPosition).Unit * 100
                local v33 = u3.new(v32)
                v33.MaxDistance = 10
                v33.MinDistance = 4
                v33.MaxSparkCount = 12
                v33.MaxSpeed = 1
            end
            local u34 = {}
            if p7 then
                game.Lighting.BlurF.Size = 20
                game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Size"] = 0
                }, true):Play()
                if _G.cameraShakeEnabled == true then
                    task.spawn(function() --[[ Line: 228 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                        --]]
                        for v35 = 10, 0, -1 do
                            local v36 = v35 / 30
                            local v37 = u4.Humanoid
                            local v38 = Random.new():NextNumber(-2, 2) * v36
                            local v39 = Random.new():NextNumber(-2, 2) * v36
                            local v40 = Random.new():NextNumber(-2, 2) * v36
                            v37.CameraOffset = Vector3.new(v38, v39, v40)
                            task.wait(0.025)
                        end
                        u4.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                    end)
                end
                local u41
                if p7 == game.Players.LocalPlayer.Character then
                    u41 = v9.cameraPart:Clone()
                    u41.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 1.5707963267948966, 0)
                    u41.Parent = workspace.Effects
                    _G.customEmit(u41)
                    _G.destroy(u41, 6.6)
                    task.spawn(function() --[[ Line: 253 ]]
                        --[[
                        Upvalues:
                            [1] = u41
                        --]]
                        for v42 = 1, 8 do
                            if u41.Parent ~= nil then
                                if v42 ~= 8 then
                                    local v43 = u41["attach" .. v42 + 1]
                                    local v44 = v43.Position
                                    v43.Position = u41["attach" .. v42].Position
                                    if v42 == 1 or v42 == 7 then
                                        game:GetService("TweenService"):Create(v43, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Position"] = v44
                                        }, true):Play()
                                    else
                                        game:GetService("TweenService"):Create(v43, TweenInfo.new(0.02, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Position"] = v44
                                        }, true):Play()
                                    end
                                end
                                local u45 = u41["beam" .. v42]
                                if v42 == 1 or v42 == 8 then
                                    if v42 == 1 then
                                        game:GetService("TweenService"):Create(u45, TweenInfo.new(0.025, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Width0"] = 0,
                                            ["Width1"] = 0.075
                                        }, true):Play()
                                        task.delay(0.025, function() --[[ Line: 301 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u45
                                            --]]
                                            game:GetService("TweenService"):Create(u45, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                ["Width0"] = 0,
                                                ["Width1"] = 0
                                            }, true):Play()
                                        end)
                                        task.wait(0.05)
                                    elseif v42 == 8 then
                                        game:GetService("TweenService"):Create(u45, TweenInfo.new(0.025, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Width0"] = 0.075,
                                            ["Width1"] = 0
                                        }, true):Play()
                                        task.delay(0.025, function() --[[ Line: 315 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u45
                                            --]]
                                            game:GetService("TweenService"):Create(u45, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                ["Width0"] = 0,
                                                ["Width1"] = 0
                                            }, true):Play()
                                        end)
                                        task.wait(0.05)
                                    end
                                else
                                    game:GetService("TweenService"):Create(u45, TweenInfo.new(0.025, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        ["Width0"] = 0.075,
                                        ["Width1"] = 0.075
                                    }, true):Play()
                                    task.delay(0.025, function() --[[ Line: 287 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u45
                                        --]]
                                        game:GetService("TweenService"):Create(u45, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                            ["Width0"] = 0,
                                            ["Width1"] = 0
                                        }, true):Play()
                                    end)
                                    task.wait(0.02)
                                end
                            end
                        end
                    end)
                else
                    u41 = nil
                end
                local u46 = tick()
                local u47 = {}
                local u48 = 1
                local u49 = nil
                u49 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 334 ]]
                    --[[
                    Upvalues:
                        [1] = u41
                        [2] = u46
                        [3] = u34
                        [4] = u47
                        [5] = u48
                        [6] = u49
                    --]]
                    if _G.cameraShakeEnabled == true and u41 then
                        u41.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 1.5707963267948966, 0)
                    end
                    if tick() - u46 > 0.025 then
                        for v50, v51 in pairs(u34) do
                            local v52 = u47[v50]
                            v51.Thickness = v52.Value
                            if u48 % 12 == 11 and v52.Value >= 0.05 then
                                v51.Thickness = v51.Thickness * (90 / u48)
                            elseif v52.Value < 0.01 then
                                table.remove(u34, v50)
                                v51:Destroy()
                                if #u34 == 0 then
                                    u49:Disconnect()
                                end
                            end
                        end
                        u48 = u48 + 1
                    end
                end)
                local v53 = v9.hitPart:Clone()
                local v54 = CFrame.new
                local v55 = p7.PrimaryPart.Position
                local v56 = v10.Position.X
                local v57 = p7.PrimaryPart.Position.Y
                local v58 = v10.Position.Z
                v53.CFrame = v54(v55, (Vector3.new(v56, v57, v58))) * CFrame.Angles(0, 3.141592653589793, 0)
                v53.Parent = workspace.Effects
                _G.destroy(v53, 4)
                v53.OpeMesHit.Playing = true
                for _ = 1, 20 do
                    local v59 = Random.new():NextNumber(6, 15)
                    local v60 = v53.CFrame * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793)) * CFrame.new(0, 0, v59).Position
                    local v61 = Instance.new("Attachment")
                    v61.Parent = v53
                    local v62 = Instance.new("Attachment")
                    v62.Parent = v53
                    local v63 = u2.new(v61, v62, 10)
                    v63.MaxRadius = 2
                    v63.PulseSpeed = 20
                    v63.AnimationSpeed = 0
                    v63.Thickness = 1
                    v63.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                    v63.ColorOffsetSpeed = 1
                    table.insert(u34, v63)
                    game:GetService("TweenService"):Create(v62, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        ["WorldPosition"] = v60
                    }, true):Play()
                    game:GetService("TweenService"):Create(v61, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {}, true):Play()
                    local v64 = Instance.new("NumberValue")
                    v64.Name = "thicknessVal"
                    v64.Value = 1
                    game:GetService("TweenService"):Create(v64, TweenInfo.new(Random.new():NextNumber(0.9, 1.2), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        ["Value"] = 0
                    }, true):Play()
                    v64.Parent = workspace.Effects
                    _G.destroy(v64, 2)
                    table.insert(u47, v64)
                    local v65 = Instance.new("IntValue")
                    v65.Name = "intValue"
                    v65.Value = 1
                    v65.Parent = v64
                    _G.destroy(v65, 6)
                end
                _G.customEmit(v53, true)
                task.delay(0.05, function() --[[ Line: 430 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u8
                        [3] = u11
                    --]]
                    if u4 == game.Players.LocalPlayer.Character then
                        u8.Parent = u4
                    end
                    if u8 then
                        for _, v66 in pairs(u11:GetChildren()) do
                            if v66:IsA("ParticleEmitter") then
                                v66.Parent = u8.opeHeart.Glass
                            end
                        end
                    end
                end)
            end
            for v67 = 1, 5 do
                task.wait(v67 * 0.0125)
                v15.Beam.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.2, 1),
                    NumberSequenceKeypoint.new(0.8, 1),
                    NumberSequenceKeypoint.new(1, 1)
                })
                task.wait(v67 * 0.0125)
                v15.Beam.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.2, 0),
                    NumberSequenceKeypoint.new(0.8, 0),
                    NumberSequenceKeypoint.new(1, 1)
                })
            end
        end
    else
        return
    end
end
return v1