 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, u3, u4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.PrimaryPart.Position) then
        local u5 = game.Players.LocalPlayer.Character == u3 or game.Players.LocalPlayer.Character == u4
        task.spawn(function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
            --]]
            local u6 = u4:WaitForChild("camra", 3)
            if u6 ~= nil and u5 ~= false then
                local u7 = tick()
                local u8 = nil
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                u8 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 21 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u7
                        [3] = u8
                    --]]
                    workspace.CurrentCamera.CFrame = u6.CFrame
                    if tick() - u7 >= 5.25 then
                        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                        u8:Disconnect()
                        u8 = nil
                    end
                end)
            end
        end)
        task.wait(1.1)
        local u9 = script
        local _ = u3.HumanoidRootPart
        _G.PlaySound(u3.PrimaryPart, script.GammaCharge)
        if (workspace.CurrentCamera.CFrame.Position - u3.PrimaryPart.Position).Magnitude < 100 == true then
            game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                ["Brightness"] = 0.2,
                ["Contrast"] = 1,
                ["Saturation"] = 1,
                ["TintColor"] = Color3.fromRGB(0, 189, 76)
            }, true):Play()
        end
        local u10 = u9.gammaKnifeModel:Clone()
        u10.Name = "opeKnife" .. u3.Name
        u10:SetPrimaryPartCFrame(u3.LeftHand.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, 0, 0.15))
        local v11 = Instance.new("Highlight")
        v11.OutlineTransparency = 0.8
        v11.DepthMode = Enum.HighlightDepthMode.Occluded
        v11.FillTransparency = 0.05
        v11.OutlineColor = Color3.fromRGB(0, 0, 0)
        v11.FillColor = Color3.fromRGB(255, 255, 255)
        v11.Parent = u10
        u10.Parent = workspace.Effects
        _G.destroy(u10, 10)
        u10.PrimaryPart.Anchored = false
        local v12 = Instance.new("WeldConstraint")
        v12.Part0 = u10.PrimaryPart
        v12.Part1 = u3.LeftHand
        v12.Parent = u10.PrimaryPart
        local u13 = true
        for _, v14 in pairs(u10.Part.absorbAttach:GetChildren()) do
            v14.Enabled = true
            game:GetService("TweenService"):Create(v14, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Rate"] = v14.Rate * 30
            }, true):Play()
        end
        local u15 = Instance.new("NumberValue")
        u15.Value = 0
        game:GetService("TweenService"):Create(u15, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Value"] = 4
        }, true):Play()
        _G.destroy(u15, 3)
        local u16 = Instance.new("NumberValue")
        u16.Value = 1
        game:GetService("TweenService"):Create(u16, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["Value"] = 3
        }, true):Play()
        _G.destroy(u16, 3)
        local u17 = {}
        local u18 = {}
        local u19 = {}
        local u20 = {}
        local u21 = tick()
        local v32 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 105 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u19
                [3] = u20
                [4] = u17
                [5] = u18
                [6] = u10
            --]]
            if tick() - u21 > 0.0125 then
                for v22, v23 in pairs(u19) do
                    local v24 = v23.radVal
                    local v25 = u20[v22]
                    if v24.Value > 0 then
                        v23.Beam.Width0 = v24.Value * 7
                        v23.Beam.Width1 = v24.Value * 7
                        v23.outerBeam.Width0 = v24.Value * 9
                        v23.outerBeam.Width1 = v24.Value * 9
                        v25.MaxRadius = v24.Value * 2
                        v25.Thickness = v24.Value
                    else
                        table.remove(u19, v22)
                        table.remove(u20, v22)
                        v25:Destroy()
                    end
                end
                for v26, v27 in pairs(u17) do
                    local v28 = v27.thicknessVal
                    local v29 = u18[v26]
                    if v27.Name == "effectsOffPart" then
                        local v30 = v27.elapsedVal.Value
                        local v31 = v27.randTime.Value
                        if tick() - v30 < v31 and not u10:GetAttribute("knifeShot") then
                            if v28.Value > 0.01 then
                                v29.Thickness = v28.Value
                            else
                                table.remove(u17, v26)
                                table.remove(u18, v26)
                                v29:Destroy()
                                v27.lightning1.Enabled = false
                                v27.lightningSpikes.Enabled = false
                                v27.orbDrop.Enabled = false
                                _G.destroy(v27, 0.3)
                            end
                            u21 = tick()
                        elseif v31 < tick() - v30 or u10:GetAttribute("knifeShot") then
                            table.remove(u17, v26)
                            table.remove(u18, v26)
                            v29:Destroy()
                            v27.lightning1.Enabled = false
                            v27.lightningSpikes.Enabled = false
                            v27.orbDrop.Enabled = false
                            _G.destroy(v27, 0.3)
                        end
                    elseif v28.Value > 0.01 then
                        v29.Thickness = v28.Value
                    else
                        table.remove(u17, v26)
                        table.remove(u18, v26)
                        v29:Destroy()
                    end
                end
                u21 = tick()
            end
        end)
        local u33 = nil
        task.delay(0.6, function() --[[ Line: 199 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u16
                [3] = u15
                [4] = u13
                [5] = u3
                [6] = u9
                [7] = u17
                [8] = u2
                [9] = u18
                [10] = u33
            --]]
            for _, v34 in pairs(u10.Part.absorbAttach:GetChildren()) do
                v34.Enabled = true
                game:GetService("TweenService"):Create(v34, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Rate"] = 0
                }, true):Play()
            end
            game:GetService("TweenService"):Create(u16, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Value"] = 1
            }, true):Play()
            task.wait(0.4)
            game:GetService("TweenService"):Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Value"] = 0
            }, true):Play()
            task.wait(0.1)
            u13 = false
            task.wait(0.4)
            _G.PlaySound(u3.PrimaryPart, script.GammaStabWhoosh)
            _G.customEmit(u10.Part.burstAttach, true)
            u10.spikeMeshFront.Transparency = 0
            u10.spikeMeshBack.Transparency = 0
            for _, v35 in pairs(u10.Part.centerAttach:GetChildren()) do
                if v35.Name ~= "glowBurst" then
                    v35.Enabled = true
                end
            end
            for _, v36 in pairs(u10.Part:GetChildren()) do
                if v36:IsA("ParticleEmitter") or v36:IsA("Beam") then
                    v36.Enabled = true
                end
            end
            for _ = 1, 10 do
                local v37 = RaycastParams.new()
                v37.FilterType = Enum.RaycastFilterType.Blacklist
                v37.FilterDescendantsInstances = { u3, workspace.Effects }
                v37.IgnoreWater = true
                local v38 = u10.PrimaryPart.Position
                local v39 = Random.new():NextNumber(-3, 3)
                local v40 = Random.new():NextNumber(-3, 3)
                local v41 = Random.new()
                local v42 = v38 + Vector3.new(v39, v40, v41:NextNumber(-3, 3))
                local v43 = workspace:Raycast(u10.PrimaryPart.Position, CFrame.new(u10.PrimaryPart.Position, v42).LookVector * 15, v37)
                local v44
                if v43 == nil then
                    v44 = CFrame.new(u10.PrimaryPart.Position, v42) * CFrame.new(0, 0, -15)
                else
                    v44 = CFrame.new(v43.Position, u10.PrimaryPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                end
                local v45 = u9.offPart:Clone()
                v45.CFrame = v44
                v45.lightning1.Enabled = false
                v45.lightningSpikes.Enabled = false
                v45.orbDrop.Enabled = false
                v45.Parent = workspace.Effects
                _G.destroy(v45, 3)
                local v46 = u17
                table.insert(v46, v45)
                local v47 = Instance.new("NumberValue")
                v47.Name = "thicknessVal"
                v47.Value = Random.new():NextNumber(2, 2.6)
                game:GetService("TweenService"):Create(v47, TweenInfo.new(Random.new():NextNumber(0.2, 0.35), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Value"] = 0
                }, true):Play()
                v47.Parent = v45
                _G.destroy(v47, 3)
                local v48 = u2.new(u10.Part.centerAttach, v45.attach2, 12)
                v48.MaxRadius = 2
                v48.PulseSpeed = 20
                v48.AnimationSpeed = 20
                v48.Thickness = v47.Value
                v48.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                v48.GivenParent = u10
                local v49 = u18
                table.insert(v49, v48)
            end
            task.spawn(function() --[[ Line: 293 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u3
                    [3] = u9
                    [4] = u17
                    [5] = u2
                    [6] = u18
                    [7] = u33
                --]]
                local v50 = 1
                while u10.Part.Beam.Enabled == true and not u10:GetAttribute("knifeShot") do
                    local v51 = u10.spikeMeshFront
                    local v52 = Random.new():NextNumber(0.35, 0.65)
                    local v53 = Random.new():NextNumber(2, 2.2)
                    local v54 = Random.new()
                    v51.Size = Vector3.new(v52, v53, v54:NextNumber(0.35, 0.65))
                    local v55 = u10.spikeMeshBack
                    local v56 = Random.new():NextNumber(0.35, 0.65)
                    local v57 = Random.new():NextNumber(2, 2.2)
                    local v58 = Random.new()
                    v55.Size = Vector3.new(v56, v57, v58:NextNumber(0.35, 0.65))
                    if v50 % 8 == 1 then
                        u10.Part.centerAttach.flashGlow:Emit(1)
                    end
                    if v50 % 4 == 1 then
                        local v59 = RaycastParams.new()
                        v59.FilterType = Enum.RaycastFilterType.Blacklist
                        v59.FilterDescendantsInstances = { u3, workspace.Effects }
                        v59.IgnoreWater = true
                        local v60 = 0
                        repeat
                            local v61 = u10.PrimaryPart.Position
                            local v62 = Random.new():NextNumber(-3, 3)
                            local v63 = Random.new():NextNumber(-3, 3)
                            local v64 = Random.new()
                            local v65 = v61 + Vector3.new(v62, v63, v64:NextNumber(-3, 3))
                            local v66 = workspace:Raycast(u10.PrimaryPart.Position, CFrame.new(u10.PrimaryPart.Position, v65).LookVector * 15, v59)
                            v60 = v60 + 1
                        until v66 ~= nil or v60 > 20
                        if v60 <= 20 then
                            local v67 = u9.offPart:Clone()
                            v67.Name = "effectsOffPart"
                            v67.CFrame = CFrame.new(v66.Position, v66.Position + v66.Normal)
                            v67.Parent = workspace.Effects
                            _G.destroy(v67, 3)
                            local v68 = u17
                            table.insert(v68, v67)
                            local v69 = Instance.new("NumberValue")
                            v69.Name = "randTime"
                            v69.Value = Random.new():NextNumber(0.5, 0.7)
                            v69.Parent = v67
                            _G.destroy(v69, 3)
                            local v70 = (u10.PrimaryPart.Position - v66.Position).Magnitude
                            game:GetService("TweenService"):Create(v67, TweenInfo.new(v69.Value, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ["CFrame"] = v67.CFrame * CFrame.Angles(0, 0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793)) * CFrame.new(0, 5, 0)
                            }, true):Play()
                            local v71 = Instance.new("NumberValue")
                            v71.Name = "thicknessVal"
                            v71.Value = 0
                            game:GetService("TweenService"):Create(v71, TweenInfo.new(v69.Value, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                ["Value"] = Random.new():NextNumber(0.5, 0.6)
                            }, true):Play()
                            v71.Parent = v67
                            _G.destroy(v71, 3)
                            local v72 = u2.new(u10.Part.centerAttach, v67.attach2, v70 * 2)
                            v72.MaxRadius = 2
                            v72.PulseSpeed = 20
                            v72.CurveSize0 = Random.new():NextNumber(-v70, v70)
                            v72.CurveSize1 = Random.new():NextNumber(-v70, v70)
                            v72.AnimationSpeed = 10
                            v72.Thickness = v71.Value
                            v72.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                            v72.GivenParent = u10
                            local v73 = u18
                            table.insert(v73, v72)
                            local v74 = Instance.new("NumberValue")
                            v74.Name = "elapsedVal"
                            v74.Value = tick()
                            v74.Parent = v67
                            _G.destroy(v74, 3)
                        end
                    end
                    v50 = v50 + 1
                    task.wait(Random.new():NextNumber(0.025, 0.0375))
                end
                for _, v75 in pairs(u10.Part:GetChildren()) do
                    if v75:IsA("Beam") then
                        v75.Enabled = false
                    end
                end
                u33:Disconnect()
            end)
        end)
        local u76 = Instance.new("NumberValue")
        u76.Value = 5
        game:GetService("TweenService"):Create(u76, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["Value"] = 20
        }, true):Play()
        _G.destroy(u76, 3)
        task.spawn(function() --[[ Line: 411 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u10
                [3] = u15
                [4] = u13
                [5] = u3
                [6] = u76
                [7] = u9
                [8] = u19
                [9] = u16
                [10] = u2
                [11] = u20
            --]]
            local u77 = tick()
            u33 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 415 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u33
                    [3] = u77
                    [4] = u15
                    [5] = u13
                    [6] = u3
                    [7] = u76
                    [8] = u9
                    [9] = u19
                    [10] = u16
                    [11] = u2
                    [12] = u20
                --]]
                if u10:FindFirstChild("middleSphere") == nil then
                    u33:Disconnect()
                elseif tick() - u77 > 0.00625 then
                    local v78 = u15.Value - u15.Value * 0.875
                    local v79 = game:GetService("TweenService")
                    local v80 = u10.middleSphere
                    local v81 = TweenInfo.new(0.00625, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                    local v82 = {}
                    local v83 = Random.new():NextNumber(u15.Value - v78, u15.Value + v78)
                    local v84 = Random.new():NextNumber(u15.Value - v78, u15.Value + v78)
                    local v85 = Random.new()
                    local v86 = u15.Value - v78
                    local v87 = u15.Value + v78
                    v82.Size = Vector3.new(v83, v84, v85:NextNumber(v86, v87))
                    v79:Create(v80, v81, v82, true):Play()
                    if u13 then
                        local v88 = RaycastParams.new()
                        v88.FilterType = Enum.RaycastFilterType.Blacklist
                        v88.FilterDescendantsInstances = { u3, workspace.Effects }
                        v88.IgnoreWater = true
                        local v89 = u10.PrimaryPart.Position
                        local v90 = Random.new():NextNumber(-3, 3)
                        local v91 = Random.new():NextNumber(-3, 3)
                        local v92 = Random.new()
                        local v93 = v89 + Vector3.new(v90, v91, v92:NextNumber(-3, 3))
                        local v94 = workspace:Raycast(u10.PrimaryPart.Position, CFrame.new(u10.PrimaryPart.Position, v93).LookVector * u76.Value, v88)
                        local v95
                        if v94 == nil then
                            v95 = CFrame.new(u10.PrimaryPart.Position, v93) * CFrame.new(0, 0, -u76.Value)
                        else
                            v95 = CFrame.new(v94.Position, u10.PrimaryPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                        end
                        local u96 = u9.offPart:Clone()
                        u96.CFrame = v95
                        u96.Parent = workspace.Effects
                        local v97 = u19
                        table.insert(v97, u96)
                        _G.destroy(u96, 3)
                        local u98 = (u10.PrimaryPart.Position - v95.Position).Magnitude + 3
                        local u99 = Instance.new("NumberValue")
                        u99.Name = "radVal"
                        u99.Value = 0
                        game:GetService("TweenService"):Create(u99, TweenInfo.new(u98 * 0.01875, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ["Value"] = 1 * u16.Value
                        }, true):Play()
                        u99.Parent = u96
                        _G.destroy(u99, 3)
                        local v100 = u2.new(u96.attach2, u96.centerAttach, 8)
                        v100.MaxRadius = u99.Value
                        v100.PulseSpeed = 20
                        v100.AnimationSpeed = 20
                        v100.Thickness = 0
                        v100.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 189, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 189, 76)) })
                        v100.GivenParent = u10
                        local v101 = u20
                        table.insert(v101, v100)
                        game:GetService("TweenService"):Create(u96, TweenInfo.new(u98 * 0.0125, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ["CFrame"] = CFrame.new(u10.PrimaryPart.Position, v93)
                        }, true):Play()
                        local v102 = game:GetService("TweenService")
                        local v103 = u96.attach2
                        local v104 = TweenInfo.new(u98 * 0.014, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                        local v105 = {}
                        local v106 = -u98 * 1
                        v105.Position = Vector3.new(0, 0, v106)
                        local u107 = v102:Create(v103, v104, v105, true)
                        u107:Play()
                        task.delay(u98 * 0.00625, function() --[[ Line: 487 ]]
                            --[[
                            Upvalues:
                                [1] = u107
                                [2] = u99
                                [3] = u98
                                [4] = u96
                            --]]
                            u107:Cancel()
                            game:GetService("TweenService"):Create(u99, TweenInfo.new(u98 * 0.013, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                ["Value"] = -0.1
                            }, true):Play()
                            task.wait(u98 * 0.00625)
                            u96.lightning1.Enabled = false
                            u96.lightningSpikes.Enabled = false
                            u96.orbDrop.Enabled = false
                            game:GetService("TweenService"):Create(u96.attach2, TweenInfo.new(u98 * 0.00625, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Position"] = Vector3.new(0, 0, 0)
                            }, true):Play()
                        end)
                    end
                    u77 = tick()
                end
            end)
        end)
        task.wait(4)
        v32:Disconnect()
    end
end
return v1