 

return {
    ["start"] = function(_, p1, u2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) then
            local u3 = script.floorPart:Clone()
            u3.CFrame = u2
            u3.Name = "opeThornFloorPart" .. p1.Name
            local v4, _, _ = _G.getRayFloor(CFrame.new(u3.Position + Vector3.new(0, 5, 0)), 25)
            if v4 then
                u3.dustTension.Color = ColorSequence.new(v4.Color)
                u3.dustSpikeTension.Color = ColorSequence.new(v4.Color)
                u3.rockTension.Color = ColorSequence.new(v4.Color)
                u3.powderTension.Color = ColorSequence.new(v4.Color)
                u3.centerAttach.circleWave.Color = ColorSequence.new(v4.Color)
                u3.centerAttach.wavePulse1.Color = ColorSequence.new(v4.Color)
            end
            u3.Parent = workspace.Effects
            local v5 = game:GetService("TweenService"):Create(u3, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new(30, 0.1, 30)
            }, true)
            v5:Play()
            _G.destroy(u3, 3)
            for _, v6 in pairs(u3:GetChildren()) do
                if v6:IsA("ParticleEmitter") then
                    game:GetService("TweenService"):Create(v6, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ["Rate"] = v6.Rate * 10
                    }, true):Play()
                end
            end
            for _, v7 in pairs(u3.centerAttach:GetChildren()) do
                game:GetService("TweenService"):Create(v7, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["Rate"] = v7.Rate * 10
                }, true):Play()
            end
            local v8 = Instance.new("Model")
            v8.Name = "opeThornRocks" .. p1.Name
            v8.Parent = workspace.Effects
            _G.destroy(v8, 2)
            local v9 = Instance.new("NumberValue")
            v9.Value = 0
            game:GetService("TweenService"):Create(v9, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["Value"] = 1
            }, true):Play()
            _G.destroy(v9, 2)
            local v10 = game.Players.LocalPlayer.Character
            local v11 = 1
            while v8.Parent ~= nil do
                if v11 % 10 == 1 then
                    local u12 = game.ReplicatedStorage.Refrences.Ope.rockDebris["rockModel" .. Random.new():NextInteger(1, 5)]:Clone()
                    u12.rock.Anchored = true
                    local u13 = Random.new():NextNumber(-3.141592653589793, 3.141592653589793)
                    local u14 = Random.new():NextNumber(u3.Size.X * 0.3, u3.Size.X * 0.4)
                    local u15 = CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
                    u12:SetPrimaryPartCFrame(u2 * CFrame.Angles(0, u13, 0) * CFrame.new(0, 0, u14) * CFrame.new(0, -4, 0) * u15)
                    local v16, _, _ = _G.getRayFloor(CFrame.new(u12.PrimaryPart.Position + Vector3.new(0, 5, 0)), 25)
                    if v16 then
                        _G.matchMaterial(u12.top, v16)
                        _G.matchMaterial(u12.rock, v16)
                    end
                    u12.Parent = v8
                    _G.destroy(u12, 2)
                    local v17 = Random.new():NextNumber(70, 130)
                    local v18 = u12.PrimaryPart.Position
                    for _, v19 in pairs(u12:GetDescendants()) do
                        if v19:IsA("BasePart") then
                            v19.Size = v19.Size * v17
                            local v20 = v19.Position - v18
                            local v21 = v19.CFrame - v19.Position
                            v19.CFrame = CFrame.new(v18 + v20 * v17) * v21
                        end
                    end
                    u12.rock.WeldConstraint.Enabled = true
                    local u22 = Instance.new("NumberValue")
                    u22.Value = -4
                    game:GetService("TweenService"):Create(u22, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ["Value"] = 0
                    }, true):Play()
                    _G.destroy(u22, 3)
                    local u23 = tick()
                    local u24 = tick()
                    local u25 = nil
                    u25 = game:GetService("RunService").Stepped:Connect(function() --[[ Line: 103 ]]
                        --[[
                        Upvalues:
                            [1] = u24
                            [2] = u12
                            [3] = u3
                            [4] = u23
                            [5] = u2
                            [6] = u13
                            [7] = u14
                            [8] = u22
                            [9] = u15
                            [10] = u25
                        --]]
                        if tick() - u24 > 0.0125 then
                            if u12.Parent == nil then
                                u25:Disconnect()
                            else
                                u3.centerAttach.electricityGlow.Size = NumberSequence.new(10 + (tick() - u23) * 4)
                                u12:SetPrimaryPartCFrame(u2 * CFrame.Angles(0, u13, 0) * CFrame.new(0, 0, u14) * CFrame.new(Random.new():NextNumber(-0.5, 0.5), u22.Value, Random.new():NextNumber(-0.5, 0.5)) * u15)
                            end
                            u24 = tick()
                        end
                    end)
                end
                if _G.cameraShakeEnabled == true then
                    local v26 = (workspace.CurrentCamera.CFrame.Position - u3.Position).Magnitude
                    if v26 < 30 then
                        local v27 = 1 - v26 / 30
                        local v28 = v10.Humanoid
                        local v29 = Random.new():NextNumber(-1, 1) * v27 * v9.Value
                        local v30 = Random.new():NextNumber(-1, 1) * v27 * v9.Value
                        local v31 = Random.new():NextNumber(-1, 1) * v27 * v9.Value
                        v28.CameraOffset = Vector3.new(v29, v30, v31)
                    end
                end
                v11 = v11 + 1
                task.wait(0.01)
            end
            v5:Cancel()
            v10.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
        end
    end
}