 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) then
            local v2 = script
            local u3 = workspace.Effects:FindFirstChild("opeThornFloorPart" .. p1.Name)
            if u3 ~= nil then
                local v4 = workspace.Effects["opeThornRocks" .. p1.Name]
                local u5 = u3.CFrame
                v4:Destroy()
                u3.Name = "done"
                for _, v6 in pairs(u3:GetChildren()) do
                    if v6:IsA("ParticleEmitter") then
                        v6.Enabled = false
                    end
                end
                for _, v7 in pairs(u3.centerAttach:GetChildren()) do
                    v7.Enabled = false
                end
                local u8 = v2.opeSpike:Clone()
                local v9 = 0.5333333333333333 + u3.Size.X / 30
                local v10 = u8.PrimaryPart.Position
                for _, v11 in pairs(u8:GetDescendants()) do
                    if v11:IsA("BasePart") then
                        v11.Size = v11.Size * v9
                        local v12 = v11.Position - v10
                        local v13 = v11.CFrame - v11.Position
                        v11.CFrame = CFrame.new(v10 + v12 * v9) * v13
                    end
                end
                u8.PrimaryPart.WeldConstraint.Enabled = true
                local u14 = Random.new():NextNumber(-3.141592653589793, 3.141592653589793)
                u8.PrimaryPart.CFrame = u5 * CFrame.new(0, -u8.PrimaryPart.Size.Y * 0.6, 0) * CFrame.Angles(0, u14, 0)
                local v15, _, _ = _G.getRayFloor(CFrame.new(u5.Position + Vector3.new(0, 5, 0)), 50)
                if v15 then
                    _G.matchMaterial(u8.outerShell, v15)
                end
                u8.Parent = workspace.Effects
                _G.destroy(u8, 2)
                game:GetService("TweenService"):Create(u8.PrimaryPart, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = u5 * CFrame.new(0, u8.PrimaryPart.Size.Y * 0.45, 0) * CFrame.Angles(0, u14, 0)
                }, true):Play()
                local u16 = v2.eruptPart:Clone()
                u16.Size = u3.Size
                u16.CFrame = u5
                local v17, _, _ = _G.getRayFloor(CFrame.new(u3.Position + Vector3.new(0, 5, 0)), 25)
                if v17 then
                    u16.dustBurst.Color = ColorSequence.new(v17.Color)
                    u16.dustSpikeBurst.Color = ColorSequence.new(v17.Color)
                    u16.powderBurst.Color = ColorSequence.new(v17.Color)
                    u16.rockBurst.Color = ColorSequence.new(v17.Color)
                    u16.finishAttach.burstWave1.Color = ColorSequence.new(v17.Color)
                    u16.finishAttach.dustBurst.Color = ColorSequence.new(v17.Color)
                    u16.finishAttach.powderBurst.Color = ColorSequence.new(v17.Color)
                    u16.centerAttach.fallDust.Color = ColorSequence.new(v17.Color)
                end
                u16.Parent = workspace.Effects
                _G.destroy(u16, 4)
                for _, v18 in pairs(u16:GetChildren()) do
                    if v18:IsA("ParticleEmitter") then
                        v18:Emit(v18.Rate * v9)
                    end
                end
                for _, v19 in pairs(u16.centerAttach:GetChildren()) do
                    v19:Emit(v19.Rate * v9)
                end
                local u20 = game.Players.LocalPlayer
                local u21 = (u20.Character.HumanoidRootPart.Position - u3.Position).Magnitude
                if u21 < 30 then
                    local v22 = 1 - u21 / 30
                    game.Lighting.BlurF.Size = 20 * v22
                    game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                        ["Size"] = 0
                    }, true):Play()
                    if _G.cameraShakeEnabled == true then
                        task.spawn(function() --[[ Line: 95 ]]
                            --[[
                            Upvalues:
                                [1] = u21
                                [2] = u20
                            --]]
                            for v23 = 30 - u21, 0, -1 do
                                local v24 = v23 / 30
                                local v25 = u20.Character.Humanoid
                                local v26 = Random.new():NextNumber(-2, 2) * v24
                                local v27 = Random.new():NextNumber(-2, 2) * v24
                                local v28 = Random.new():NextNumber(-2, 2) * v24
                                v25.CameraOffset = Vector3.new(v26, v27, v28)
                                task.wait(0.025)
                            end
                            u20.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                        end)
                    end
                end
                for _ = 1, 4 do
                    local v29 = game.ReplicatedStorage.Refrences.Ope.rockDebris["rockModel" .. Random.new():NextInteger(1, 5)]:Clone()
                    v29:SetPrimaryPartCFrame(u5 * CFrame.Angles(0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0) * CFrame.new(0, 0, 4.5) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793)))
                    if v17 then
                        _G.matchMaterial(v29.rock, v17)
                        _G.matchMaterial(v29.top, v17)
                    end
                    v29.Parent = workspace.Effects
                    _G.destroy(v29, 3)
                    local v30 = Random.new():NextNumber(40, 90) * v9
                    local v31 = v29.PrimaryPart.Position
                    for _, v32 in pairs(v29:GetDescendants()) do
                        if v32:IsA("BasePart") then
                            v32.Size = v32.Size * v30
                            local v33 = v32.Position - v31
                            local v34 = v32.CFrame - v32.Position
                            v32.CFrame = CFrame.new(v31 + v33 * v30) * v34
                        end
                    end
                    v29.rock.WeldConstraint.Enabled = true
                    local v35 = Instance.new("BodyVelocity")
                    v35.MaxForce = Vector3.new(inf, inf, inf)
                    local v36 = u5.UpVector
                    local v37 = Random.new():NextNumber(-0.3, 0.3)
                    local v38 = Random.new():NextNumber(-0.3, 0.3)
                    local v39 = Random.new()
                    v35.Velocity = (v36 + Vector3.new(v37, v38, v39:NextNumber(-0.3, 0.3))) * Random.new():NextNumber(80, 100) * v9
                    v35.Parent = v29.PrimaryPart
                    local v40 = v29.PrimaryPart
                    local v41 = Random.new():NextNumber(-10, 10)
                    local v42 = Random.new():NextNumber(-10, 10)
                    local v43 = Random.new()
                    v40.AssemblyAngularVelocity = Vector3.new(v41, v42, v43:NextNumber(-10, 10))
                    _G.destroy(v35, 0.01)
                end
                task.wait(0.2)
                game:GetService("TweenService"):Create(u16.centerAttach.fallDust, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Rate"] = 500
                }, true):Play()
                u3.rockTension.Rate = 0
                u3.rockTension.Enabled = true
                game:GetService("TweenService"):Create(u3.rockTension, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Rate"] = 100
                }, true):Play()
                task.delay(0.8, function() --[[ Line: 162 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u3
                    --]]
                    u16.centerAttach.fallDust.Enabled = false
                    u3.rockTension.Enabled = false
                    task.wait(0.05)
                    _G.customEmit(u16.finishAttach, true)
                end)
                local u44 = Instance.new("NumberValue")
                u44.Value = u8.PrimaryPart.Size.Y * 0.45
                _G.destroy(u44, 1.1)
                game:GetService("TweenService"):Create(u44, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Value"] = -u8.PrimaryPart.Size.Y * 0.6
                }, true):Play()
                local u45 = Instance.new("NumberValue")
                u45.Value = 0
                _G.destroy(u45, 1.1)
                game:GetService("TweenService"):Create(u45, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ["Value"] = 1
                }, true):Play()
                local u46 = tick()
                local u47 = nil
                u47 = game:GetService("RunService").Stepped:Connect(function() --[[ Line: 187 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                        [2] = u8
                        [3] = u44
                        [4] = u47
                        [5] = u5
                        [6] = u45
                        [7] = u14
                    --]]
                    if tick() - u46 > 0.0125 then
                        if u8 and (u8.PrimaryPart ~= nil and u44.Value <= -u8.PrimaryPart.Size.Y * 0.58) or u8 and u8.PrimaryPart == nil then
                            u8:Destroy()
                            u47:Disconnect()
                        else
                            u8.PrimaryPart.CFrame = u5 * CFrame.new(Random.new():NextNumber(-u45.Value, u45.Value), u44.Value, Random.new():NextNumber(-u45.Value, u45.Value)) * CFrame.Angles(0, u14, 0)
                        end
                        u46 = tick()
                    end
                end)
            end
        else
            return
        end
    end
}