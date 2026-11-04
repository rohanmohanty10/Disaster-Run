 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p3, _, p4, _) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) then
        local u5 = script
        local u6 = p3.HumanoidRootPart
        local u7 = Instance.new("Model")
        u7.Parent = workspace.Effects
        _G.destroy(u7, 4)
        u7.PrimaryPart = p4.PrimaryPart
        local v8 = u5.shockSound:Clone()
        v8.Parent = u7.PrimaryPart
        v8.Playing = true
        _G.destroy(v8, 0.6)
        local v9 = u5.shockSound:Clone()
        v9.Parent = u6
        v9.Playing = true
        _G.destroy(v9, 0.6)
        local v10
        if u7.PrimaryPart.Anchored == false then
            u7.PrimaryPart.Anchored = true
            v10 = false
        else
            v10 = true
        end
        local u11 = u5.bodyPart:Clone()
        u11.CFrame = CFrame.new(u7.PrimaryPart.Position, u7.PrimaryPart.Position + Vector3.new(0, 100, 0)) * CFrame.Angles(1.5707963267948966, 0, 0)
        u11.Parent = workspace.Effects
        _G.destroy(u11, 4)
        local u12 = u7.PrimaryPart.Size.Magnitude * 0.15
        for _, v13 in pairs(u11:GetChildren()) do
            if v13:IsA("ParticleEmitter") then
                local v14 = {}
                for _, v15 in ipairs(v13.Size.Keypoints) do
                    local v16 = NumberSequenceKeypoint.new
                    local v17 = v15.Time
                    local v18 = v15.Value * u12
                    local v19 = v15.Envelope * u12
                    table.insert(v14, v16(v17, v18, v19))
                end
                v13.Size = NumberSequence.new(v14)
                v13.Speed = NumberRange.new(v13.Speed.Min * u12, v13.Speed.Max * u12)
                local v20 = v13.Acceleration.X * u12
                local v21 = v13.Acceleration.Y * u12
                local v22 = v13.Acceleration.Z * u12
                v13.Acceleration = Vector3.new(v20, v21, v22)
            end
        end
        for _, v23 in pairs(u11.centerAttach:GetChildren()) do
            local v24 = {}
            for _, v25 in ipairs(v23.Size.Keypoints) do
                local v26 = NumberSequenceKeypoint.new
                local v27 = v25.Time
                local v28 = v25.Value * u12
                local v29 = v25.Envelope * u12
                table.insert(v24, v26(v27, v28, v29))
            end
            v23.Size = NumberSequence.new(v24)
            v23.Speed = NumberRange.new(v23.Speed.Min * u12, v23.Speed.Max * u12)
            local v30 = v23.Acceleration.X * u12
            local v31 = v23.Acceleration.Y * u12
            local v32 = v23.Acceleration.Z * u12
            v23.Acceleration = Vector3.new(v30, v31, v32)
        end
        local u33 = Instance.new("Model")
        u33.Parent = workspace.Effects
        _G.destroy(u33, 4)
        local v34 = Instance.new("Highlight")
        v34.Name = "shamblesHighlight"
        v34.OutlineTransparency = 0.8
        v34.DepthMode = Enum.HighlightDepthMode.Occluded
        v34.FillTransparency = 0.05
        v34.OutlineColor = Color3.fromRGB(0, 0, 0)
        v34.FillColor = Color3.fromRGB(255, 255, 255)
        v34.Parent = u33
        local u35 = u5.bodyPart:Clone()
        u35.CFrame = CFrame.new(u6.Position, u6.Position + Vector3.new(0, 100, 0)) * CFrame.Angles(1.5707963267948966, 0, 0)
        u35.Parent = workspace.Effects
        _G.destroy(u35, 4)
        local u36 = true
        task.delay(0.3, function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u36
                [2] = u35
                [3] = u11
            --]]
            u36 = false
            u35.electricitySurround.Rate = 0
            u35.starSurround.Rate = 0
            u11.electricitySurround.Rate = 0
            u11.starSurround.Rate = 0
        end)
        task.spawn(function() --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u36
                [2] = u6
                [3] = u5
                [4] = u2
                [5] = u33
                [6] = u7
            --]]
            while u36 do
                local v37 = u6
                for _ = 1, 2 do
                    local v38 = RaycastParams.new()
                    v38.FilterType = Enum.RaycastFilterType.Blacklist
                    v38.FilterDescendantsInstances = { u6.Parent, workspace.Effects }
                    v38.IgnoreWater = true
                    local v39 = v37.Position
                    local v40 = Random.new():NextNumber(-3, 3)
                    local v41 = Random.new():NextNumber(-3, 3)
                    local v42 = Random.new()
                    local v43 = v39 + Vector3.new(v40, v41, v42:NextNumber(-3, 3))
                    local v44 = workspace:Raycast(v37.Position, CFrame.new(v37.Position, v43).LookVector * 8, v38)
                    local v45
                    if v44 == nil then
                        v45 = CFrame.new(v37.Position, v43) * CFrame.new(0, 0, -8)
                    else
                        v45 = CFrame.new(v44.Position, v37.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                    end
                    local v46 = u5.offPart:Clone()
                    v46.CFrame = v45
                    v46.lightning1.Enabled = false
                    v46.lightningSpikes.Enabled = false
                    v46.orbDrop.Enabled = false
                    v46.Parent = workspace.Effects
                    _G.destroy(v46, 0.2)
                    local u47 = Instance.new("NumberValue")
                    u47.Value = Random.new():NextNumber(1, 1.3)
                    game:GetService("TweenService"):Create(u47, TweenInfo.new(Random.new():NextNumber(0.15, 0.2), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Value"] = 0
                    }, true):Play()
                    _G.destroy(u47, 4)
                    local v48 = Instance.new("Attachment")
                    v48.Parent = v37
                    _G.destroy(v48, 0.3)
                    local u49 = u2.new(v48, v46.attach2, 12)
                    u49.MaxRadius = 2
                    u49.PulseSpeed = 20
                    u49.AnimationSpeed = 20
                    u49.Thickness = u47.Value
                    u49.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 135, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 135, 197)) })
                    u49.GivenParent = u33
                    local u50 = tick()
                    local u51 = nil
                    u51 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 146 ]]
                        --[[
                        Upvalues:
                            [1] = u50
                            [2] = u47
                            [3] = u49
                            [4] = u51
                        --]]
                        if tick() - u50 > 0.0125 then
                            if u47.Value > 0.01 then
                                u49.Thickness = u47.Value
                            else
                                u49:Destroy()
                                u51:Disconnect()
                            end
                            u50 = tick()
                        end
                    end)
                    v37 = u7.PrimaryPart
                end
                task.wait(0.025)
            end
        end)
        task.wait(0.3)
        game:GetService("TweenService"):Create(v9, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Volume"] = 0
        }, true):Play()
        game:GetService("TweenService"):Create(v8, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Volume"] = 0
        }, true):Play()
        local v52 = u5["OpeShambles&Teleport"]:Clone()
        v52.Parent = u7.PrimaryPart
        v52.Playing = true
        _G.destroy(v52, 2)
        local v53 = u5["OpeShambles&Teleport"]:Clone()
        v53.Parent = u6
        v53.Playing = true
        _G.destroy(v53, 2)
        _G.customEmit(u35, true)
        _G.customEmit(u11, true)
        local u54 = u6
        for _ = 1, 2 do
            local u55 = {}
            for _, v56 in pairs(u6.Parent:GetChildren()) do
                if v56:IsA("BasePart") then
                    local u57 = Instance.new("Model")
                    u57.Parent = workspace.Effects
                    table.insert(u55, u57)
                    _G.destroy(u57, 0.4)
                    local v58 = Instance.new("Part")
                    v58.Size = Vector3.new(1, 1, 1)
                    v58.Transparency = 1
                    v58.Anchored = true
                    v58.CanCollide = false
                    local v59 = u6.Position.X
                    local v60 = v56.Position.Y
                    local v61 = u6.Position.Z
                    v58.Position = Vector3.new(v59, v60, v61)
                    v58.Parent = workspace.Effects
                    _G.destroy(v58, 0.4)
                    u57.PrimaryPart = v58
                    local u62 = v56:Clone()
                    u62.CFrame = v56.CFrame
                    u62.Name = "partClone"
                    u62.Material = Enum.Material.Neon
                    u62.Anchored = false
                    u62.CanCollide = false
                    u62.Size = v56.Size * 1.05
                    u62.Color = Color3.fromRGB(0, 0, 0)
                    u62:ClearAllChildren()
                    u62.Parent = u57
                    _G.destroy(u62, 0.4)
                    local v63 = game:GetService("TweenService")
                    local v64 = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                    local v65 = {}
                    local v66 = Random.new()
                    v65.Size = Vector3.new(0, 0, v66:NextNumber(4, 6))
                    v63:Create(u62, v64, v65, true):Play()
                    game:GetService("TweenService"):Create(u62, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        ["Transparency"] = 1
                    }, true):Play()
                    local v67 = Random.new():NextNumber(-0.2, 0.2)
                    local v68 = Random.new():NextNumber(-0.2, 0.2)
                    local u69 = Instance.new("CFrameValue")
                    u69.Value = u57.PrimaryPart.CFrame
                    u69.Name = "originVal"
                    u69.Parent = u57
                    local v70 = game:GetService("TweenService")
                    local v71 = TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                    local v72 = {}
                    local v73 = u57.PrimaryPart.CFrame
                    local v74 = Random.new():NextNumber(-2, 2)
                    v72.Value = v73 + Vector3.new(v67, v74, v68)
                    v70:Create(u69, v71, v72, true):Play()
                    _G.destroy(u69, 0.4)
                    task.delay(0.15, function() --[[ Line: 256 ]]
                        --[[
                        Upvalues:
                            [1] = u62
                            [2] = u69
                            [3] = u57
                        --]]
                        local v75 = game:GetService("TweenService")
                        local v76 = u62
                        local v77 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                        local v78 = {}
                        local v79 = Random.new()
                        v78.Size = Vector3.new(0, 0, v79:NextNumber(1, 2))
                        v75:Create(v76, v77, v78, true):Play()
                        game:GetService("TweenService"):Create(u69, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            ["Value"] = u57.PrimaryPart.CFrame
                        }, true):Play()
                    end)
                    local v80 = Instance.new("NumberValue")
                    v80.Value = 0
                    v80.Name = "turnVal"
                    v80.Parent = u57
                    game:GetService("TweenService"):Create(v80, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Value"] = Random.new():NextNumber(3.141592653589793, 9.42477796076938)
                    }, true):Play()
                    _G.destroy(v80, 0.4)
                    local v81 = Instance.new("CFrameValue")
                    v81.Name = "offsetVal"
                    v81.Value = v58.CFrame:ToObjectSpace(u62.CFrame)
                    v81.Parent = u57
                    game:GetService("TweenService"):Create(v81, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        ["Value"] = CFrame.new(0, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
                    }, true):Play()
                    _G.destroy(v81, 0.4)
                    local v82 = Instance.new("WeldConstraint")
                    v82.Part0 = u62
                    v82.Part1 = v58
                    v82.Parent = u62
                end
            end
            local u83 = tick()
            local u84 = nil
            task.delay(0.4, function() --[[ Line: 303 ]]
                --[[
                Upvalues:
                    [1] = u84
                --]]
                u84:Disconnect()
            end)
            u84 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 306 ]]
                --[[
                Upvalues:
                    [1] = u83
                    [2] = u55
                --]]
                if tick() - u83 > 0.0125 then
                    for _, v85 in pairs(u55) do
                        if v85:FindFirstChild("partClone") and (v85.originVal and v85.offsetVal) then
                            v85.PrimaryPart.CFrame = v85.originVal.Value * CFrame.Angles(0, v85.turnVal.Value, 0)
                            v85.partClone.WeldConstraint.Enabled = false
                            v85.partClone.CFrame = v85.PrimaryPart.CFrame * v85.offsetVal.Value
                            v85.partClone.WeldConstraint.Enabled = true
                        end
                    end
                    u83 = tick()
                end
            end)
            u6 = u7.PrimaryPart
        end
        for _ = 1, 2 do
            local u86 = u5.appearPart:Clone()
            u86.CFrame = CFrame.new(u6.Position, u6.Position + Vector3.new(0, 100, 0)) * CFrame.Angles(1.5707963267948966, 0, 0)
            u86.Parent = workspace.Effects
            _G.destroy(u86, 1.2)
            game:GetService("TweenService"):Create(u86, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(4, 4, 4)
            }, true):Play()
            game:GetService("TweenService"):Create(u86.electricitySurround, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Rate"] = 100
            }, true):Play()
            _G.customEmit(u86.centerAttach, true)
            task.delay(0.4, function() --[[ Line: 366 ]]
                --[[
                Upvalues:
                    [1] = u86
                    [2] = u6
                    [3] = u54
                    [4] = u12
                --]]
                u86.electricitySurround.Enabled = false
                if u6 == u54 then
                    for _, v87 in pairs(u86:GetChildren()) do
                        if v87:IsA("ParticleEmitter") then
                            local v88 = {}
                            for _, v89 in ipairs(v87.Size.Keypoints) do
                                local v90 = NumberSequenceKeypoint.new
                                local v91 = v89.Time
                                local v92 = v89.Value * u12
                                local v93 = v89.Envelope * u12
                                table.insert(v88, v90(v91, v92, v93))
                            end
                            v87.Size = NumberSequence.new(v88)
                            v87.Speed = NumberRange.new(v87.Speed.Min * u12, v87.Speed.Max * u12)
                            local v94 = v87.Acceleration.X * u12
                            local v95 = v87.Acceleration.Y * u12
                            local v96 = v87.Acceleration.Z * u12
                            v87.Acceleration = Vector3.new(v94, v95, v96)
                        end
                    end
                    for _, v97 in pairs(u86.burstAttach:GetChildren()) do
                        local v98 = {}
                        for _, v99 in ipairs(v97.Size.Keypoints) do
                            local v100 = NumberSequenceKeypoint.new
                            local v101 = v99.Time
                            local v102 = v99.Value * u12
                            local v103 = v99.Envelope * u12
                            table.insert(v98, v100(v101, v102, v103))
                        end
                        v97.Size = NumberSequence.new(v98)
                        v97.Speed = NumberRange.new(v97.Speed.Min * u12, v97.Speed.Max * u12)
                        local v104 = v97.Acceleration.X * u12
                        local v105 = v97.Acceleration.Y * u12
                        local v106 = v97.Acceleration.Z * u12
                        v97.Acceleration = Vector3.new(v104, v105, v106)
                    end
                end
                _G.customEmit(u86.burstAttach, true)
            end)
            u6 = u54
        end
        task.wait(0.3)
        if not v10 then
            u7.PrimaryPart.Anchored = false
        end
    end
end
return v1