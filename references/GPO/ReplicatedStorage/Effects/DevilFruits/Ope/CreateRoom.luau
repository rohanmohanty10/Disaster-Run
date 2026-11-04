 

return {
    ["start"] = function(_, u1, u2, u3) --[[ Name: start, Line 3 ]]
        local u4 = game.Players.LocalPlayer.Character == u1
        game.Workspace.Effects:WaitForChild("room" .. u1.Name):Destroy()
        local v5 = script
        local _ = u1.HumanoidRootPart
        local u6 = v5.bubbleMesh:Clone()
        u6:SetAttribute("roomSize", u2)
        u6:SetAttribute("originCFrame", u3)
        u6.Name = "roomBubble" .. u1.Name
        u6.CFrame = u3 * CFrame.new(1, 0.3, -3)
        u6.Parent = workspace.Effects
        u6.OpeRoomClose.RollOffMaxDistance = u2 / 2 + 125
        u6.OpeRoomAmbience.RollOffMaxDistance = u2 / 2 + 125
        u6.OpeRoomExpand.RollOffMaxDistance = u2 + 125
        u6.OpeRoomExpand:Play()
        u6.OpeRoomAmbience:Play()
        if (workspace.CurrentCamera.CFrame.Position - u3.Position).Magnitude <= u2 then
            game.Lighting.BlurF.Size = 10
            game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                ["Size"] = 0
            }, true):Play()
        end
        if _G.cameraShakeEnabled == true then
            task.spawn(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                for v7 = 30, 0, -1 do
                    local v8 = v7 / 60
                    local v9 = u1.Humanoid
                    local v10 = Random.new():NextNumber(-0.25, 0.25) * v8
                    local v11 = Random.new():NextNumber(-0.25, 0.25) * v8
                    local v12 = Random.new():NextNumber(-0.25, 0.25) * v8
                    v9.CameraOffset = Vector3.new(v10, v11, v12)
                    task.wait(0.025)
                end
                u1.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
            end)
        end
        local u13 = u2 / 1.2 * 0.94
        for _, v14 in pairs(u6:GetChildren()) do
            if v14:IsA("Attachment") then
                local v15 = game:GetService("TweenService")
                local v16 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v17 = {}
                local v18 = v14.Position.X * u13
                local v19 = v14.Position.Z * u13
                v17.Position = Vector3.new(v18, 0, v19)
                v15:Create(v14, v16, v17, true):Play()
            elseif v14:IsA("Beam") then
                game:GetService("TweenService"):Create(v14, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CurveSize0"] = v14.CurveSize0 * u13,
                    ["CurveSize1"] = v14.CurveSize1 * u13,
                    ["Width0"] = v14.Width0 * u13 * 1,
                    ["Width1"] = v14.Width1 * u13 * 1
                }, true):Play()
            elseif v14:IsA("ParticleEmitter") and v14.Name == "outerCircles" then
                v14.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.786 * u13, 0.221 * u13), NumberSequenceKeypoint.new(1, 0, 0) })
            end
        end
        game:GetService("TweenService"):Create(u6.centerAttach.floorFill, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["Rate"] = 40
        }, true):Play()
        u6.centerAttach.floorFill.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7 * u13, 0), NumberSequenceKeypoint.new(1, 0.7 * u13, 0) })
        u6.centerAttach.floorWave.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 0.7 * u13, 0) })
        u6.centerAttach.waveBurst.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 0.5 * u13, 0.2 * u13) })
        u6.centerAttach.waveBurst:Emit(5)
        u6.centerAttach.fullWaveBurst.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 0.5 * u13, 0.2 * u13) })
        u6.centerAttach.fullWaveBurst:Emit(10)
        u6.centerAttach.electricitySurround.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.06 * u13, 0.04 * u13), NumberSequenceKeypoint.new(1, 0.06 * u13, 0.04 * u13) })
        u6.centerAttach.electricitySurround.Speed = NumberRange.new(2 * u13, 8 * u13)
        game:GetService("TweenService"):Create(u6.centerAttach.electricitySurround, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["Rate"] = 0
        }, true):Play()
        game:GetService("TweenService"):Create(u6, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = Vector3.new(u2, u2, u2),
            ["CFrame"] = u3,
            ["Color"] = Color3.fromRGB(87, 155, 194)
        }, true):Play()
        local v20 = u2 * 0.01
        local u21 = Instance.new("Model")
        u21.Parent = u6
        for v22 = 1, 10 do
            local v23 = v5.outerPart:Clone()
            v23.CFrame = u6.CFrame * CFrame.Angles(0, 0.6283185307179586 * v22, 0) * CFrame.new(0, 0, u6.Size.X * 0.5)
            v23.Anchored = false
            v23.Name = v22
            v23.Parent = u21
            local v24 = {}
            for _, v25 in ipairs(v23.electricitySurround.Size.Keypoints) do
                local v26 = NumberSequenceKeypoint.new
                local v27 = v25.Time
                local v28 = v25.Value * v20
                local v29 = v25.Envelope * v20
                table.insert(v24, v26(v27, v28, v29))
            end
            v23.electricitySurround.Size = NumberSequence.new(v24)
            v23.electricitySurround.Speed = NumberRange.new(v23.electricitySurround.Speed.Min * v20, v23.electricitySurround.Speed.Max * v20)
            local v30 = v23.electricitySurround
            local v31 = v23.electricitySurround.Acceleration.X * v20
            local v32 = v23.electricitySurround.Acceleration.Y * v20
            local v33 = v23.electricitySurround.Acceleration.Z * v20
            v30.Acceleration = Vector3.new(v31, v32, v33)
            game:GetService("TweenService"):Create(v23.topAttach, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Position"] = Vector3.new(0, 0, 0)
            }, true):Play()
            v23.topAttach.impactBurst.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.1, 0.125 * u13, 0.0225 * u13), NumberSequenceKeypoint.new(1, 0.0675 * u13, 0 * u13) })
            v23.topAttach.impactBurst.Speed = NumberRange.new(-0.5 * u13, 0.5 * u13)
            v23.topAttach.impactBurst:Emit(5)
            for _, v34 in pairs(v23.centerAttach:GetChildren()) do
                game:GetService("TweenService"):Create(v34, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Rate"] = v34.Rate * 10
                }, true):Play()
            end
            v23.centerAttach.dustThrow.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1 * u13, 0.02 * u13), NumberSequenceKeypoint.new(1, 0.1 * u13, 0.02 * u13) })
            v23.centerAttach.dustThrow.Speed = NumberRange.new(0.25 * u13, 0.3 * u13)
            v23.centerAttach.rockThrow.Speed = NumberRange.new(0.8 * u13, 1.5 * u13)
            v23.centerAttach.rockThrow.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0, 0),
                NumberSequenceKeypoint.new(0.0288, 0.016 * u13, 0.0017 * u13),
                NumberSequenceKeypoint.new(0.0762, 0.02 * u13, 0.0021 * u13),
                NumberSequenceKeypoint.new(0.13, 0.022 * u13, 0.0021 * u13),
                NumberSequenceKeypoint.new(1, 0, 0)
            })
            local v35, _, _ = _G.getRayFloor(v23.CFrame, 15)
            if v35 then
                local v36 = game.ReplicatedStorage.Refrences.Ope.rockDebris["rockModel" .. Random.new():NextInteger(1, 5)]:Clone()
                v36.Name = v22
                v36:SetPrimaryPartCFrame(v23.CFrame * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793)))
                v36.top.Color = v35.Color
                v36.top.Material = v35.Material
                v36.Parent = u21
                local v37 = v36.PrimaryPart.attach1
                local v38 = -0.02 * u13
                v37.Position = Vector3.new(0, 0, v38)
                local v39 = v36.PrimaryPart.attach2
                local v40 = 0.02 * u13
                v39.Position = Vector3.new(0, 0, v40)
                local v41 = v36.PrimaryPart.Position
                for _, v42 in pairs(v36:GetDescendants()) do
                    if v42:IsA("BasePart") then
                        v42.Size = v42.Size * u13
                        local v43 = v42.Position - v41
                        local v44 = v42.CFrame - v42.Position
                        v42.CFrame = CFrame.new(v41 + v43 * u13) * v44
                    end
                end
                v36.PrimaryPart.WeldConstraint.Enabled = true
                local v45 = Instance.new("WeldConstraint")
                v45.Part0 = v36.PrimaryPart
                v45.Part1 = u6
                v45.Parent = v36
                local v46 = Instance.new("CFrameValue")
                v46.Parent = v36
                game:GetService("TweenService"):Create(v46, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Value"] = CFrame.new(Random.new():NextNumber(-0.0675, 0.0675) * u13, Random.new():NextNumber(0.017, 0.18) * u13, Random.new():NextNumber(-0.033, 0.08) * u13) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
                }, true):Play()
                _G.destroy(v46, 6)
            end
            local v47 = Instance.new("WeldConstraint")
            v47.Part0 = v23
            v47.Part1 = u6
            v47.Parent = v23
        end
        task.delay(0.3, function() --[[ Line: 212 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            for _, v48 in pairs(u21:GetChildren()) do
                if v48:IsA("Model") then
                    game:GetService("TweenService"):Create(v48.Value, TweenInfo.new(Random.new():NextNumber(0.9, 1.1), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        ["Value"] = CFrame.new(Random.new():NextNumber(-4, 4), Random.new():NextNumber(-9, -10), Random.new():NextNumber(-2, 6)) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
                    }, true):Play()
                    _G.destroy(v48, 1.1)
                end
            end
        end)
        local u49 = Instance.new("NumberValue")
        u49.Value = 0.5
        game:GetService("TweenService"):Create(u49, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Value"] = 0.5
        }, true):Play()
        u49.Parent = u6
        local u50 = false
        local u51 = 0
        local u52 = 1
        task.spawn(function() --[[ Line: 236 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u52
                [3] = u50
                [4] = u21
                [5] = u13
                [6] = u51
                [7] = u49
            --]]
            while u6.Parent == workspace.Effects do
                if u52 % 32 == 1 and u50 then
                    game:GetService("TweenService"):Create(u6, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                        ["Color"] = Color3.fromRGB(107, 175, 214)
                    }, true):Play()
                    if u52 < 33 then
                        for _, v53 in pairs(u21:GetChildren()) do
                            if v53:IsA("Model") then
                                game:GetService("TweenService"):Create(v53.Value, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                    ["Value"] = CFrame.new(Random.new():NextNumber(-0.0675, 0.0675) * u13, Random.new():NextNumber(0.017, 0.18) * u13, Random.new():NextNumber(-0.033, 0.08) * u13) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
                                }, true):Play()
                            end
                        end
                    else
                        local _ = u52 == 33
                    end
                end
                for _, v54 in pairs(u21:GetChildren()) do
                    local v55 = u6.CFrame * CFrame.Angles(0, 0.6283185307179586 * v54.Name + u51, 0) * CFrame.new(0, 0, u6.Size.X * u49.Value)
                    if v54:IsA("Model") then
                        if v54:FindFirstChild("WeldConstraint") then
                            v54.WeldConstraint.Enabled = false
                            v54:SetPrimaryPartCFrame(v55 * v54.Value.Value)
                            v54.WeldConstraint.Enabled = true
                        end
                    else
                        v54.WeldConstraint.Enabled = false
                        v54.CFrame = v55
                        v54.WeldConstraint.Enabled = true
                    end
                end
                u51 = u51 + 0.05235987755982988
                u52 = u52 + 1
                task.wait(0.0125)
            end
        end)
        local u56 = RaycastParams.new()
        u56.FilterDescendantsInstances = { workspace.Ships, workspace.Env, workspace.Islands }
        u56.FilterType = Enum.RaycastFilterType.Include
        u56.IgnoreWater = true
        task.spawn(function() --[[ Line: 305 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u6
                [3] = u3
                [4] = u4
                [5] = u1
                [6] = u56
            --]]
            local v57 = u2
            local v58 = nil
            local v59 = false
            local v60 = {}
            local v61 = nil
            local v62 = nil
            while u6.Name ~= "leftover" do
                if (game.Workspace.Camera.CFrame.Position - u3.Position).Magnitude < v57 * 0.5 and not v59 then
                    game:GetService("SoundService"):PlayLocalSound(script.OpeEnterExitRoom)
                    v59 = true
                elseif (game.Workspace.Camera.CFrame.Position - u3.Position).Magnitude > v57 * 0.5 and v59 then
                    game:GetService("SoundService"):PlayLocalSound(script.OpeEnterExitRoom)
                    v59 = false
                end
                local v63
                if u4 == true then
                    table.clear(v60)
                    v63 = game.Workspace.Effects:FindFirstChild("rockOpeGroup" .. u1.Name)
                    if v63 then
                        for _, v64 in pairs(v63:GetChildren()) do
                            if v64:IsA("Model") then
                                table.insert(v60, v64)
                            end
                        end
                    elseif v63 or not v61 then
                        v63 = v61
                    else
                        v63 = nil
                    end
                    local _ = v63 == nil
                    local v65 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
                    local v66 = _G.getTargets(game.Players.LocalPlayer)
                    local v67 = {}
                    for v68 = 1, #v66 do
                        if v66[v68] ~= nil then
                            local v69 = v66[v68].Parent
                            if v69 ~= nil then
                                local v70 = game.Players:GetPlayerFromCharacter(v69)
                                if v70 == nil then
                                    if v69:FindFirstChild("Boss") == nil and (v69:FindFirstChild("SeaNPC") == nil and v69:FindFirstChild("motionLess") == nil) then
                                        table.insert(v67, v69)
                                    end
                                else
                                    local v71 = v70.Character
                                    local v72 = game.ReplicatedStorage:FindFirstChild("Stats" .. v70.Name)
                                    if v71 and (v71.PrimaryPart ~= nil and (table.find(v60, v71) == nil and (v72.Settings.PVPMode.Value == true and v65.Settings.PVPMode.Value == true))) then
                                        table.insert(v67, v71)
                                    end
                                end
                            end
                        end
                    end
                    for v73 = 1, #v67 do
                        local v74 = v67[v73]
                        if (v74.Parent == workspace.NPCs or (v74.Parent == workspace.PlayerCharacters or v74.Parent == workspace.Ragdolls)) and ((v74.PrimaryPart.Position - u3.Position).Magnitude < v57 / 2 and (v74:FindFirstChild("SafeFF") == nil and table.find(v60, v74) == nil)) then
                            table.insert(v60, v74)
                        end
                    end
                    local v75 = game.Workspace.Camera.CFrame.Position
                    local v76 = CFrame.new(v75, _G.MouseCF.Position).LookVector * 2000
                    local v77 = workspace:Raycast(v75, v76, u56)
                    local v78
                    if v77 == nil then
                        v78 = CFrame.new(v75, _G.MouseCF.Position) * CFrame.new(0, 0, -100).Position
                    else
                        v78 = v77.Position
                    end
                    local v79 = _G.check:inspect(u1)
                    if _G.opeToolSelected == nil or _G.canuse == false then
                        v79 = false
                    end
                    if v78 == nil or #v60 == 0 then
                        if (#v60 == 0 and v58 ~= nil or v79 == false) and (v58 and v58.Parent ~= nil) then
                            v58:Destroy()
                            v62 = nil
                            v58 = nil
                        end
                    else
                        local v80 = Instance.new("Part")
                        v80.Anchored = true
                        v80.CanCollide = false
                        v80.Size = Vector3.new(50, 50, 0.01)
                        v80.Transparency = 1
                        v80.CFrame = CFrame.new(v78, workspace.CurrentCamera.CFrame.Position)
                        v80.Parent = workspace.Effects
                        _G.destroy(v80, 0.01)
                        local v81 = nil
                        for v82, v83 in pairs(v60) do
                            local v84 = (v83.Parent == nil or v83.PrimaryPart and (v83.PrimaryPart.Position - u3.Position).Magnitude > v57 / 2) and true or false
                            if (v83:GetAttribute("shotRock") and true or v84) == true then
                                table.remove(v60, v82)
                            end
                        end
                        for v85, v86 in pairs(v60) do
                            if v86.PrimaryPart ~= nil then
                                local v87 = u1.PrimaryPart.Position
                                local v88 = v86.PrimaryPart.Position
                                local v89 = (v87 - v88).Magnitude
                                local v90 = Ray.new(v87, (v88 - v87).unit * v89)
                                local v91, _, _ = _G.raycastWhitelist(v90, { workspace.Islands, workspace.Env, workspace.Ships })
                                if not v91 then
                                    local v92 = RaycastParams.new()
                                    v92.FilterDescendantsInstances = { v80 }
                                    v92.FilterType = Enum.RaycastFilterType.Whitelist
                                    v92.IgnoreWater = true
                                    local v93 = game.Workspace.Camera.CFrame.Position
                                    local v94 = CFrame.new(v93, v86.PrimaryPart.Position).LookVector * 1000
                                    local v95 = workspace:Raycast(v93, v94, v92)
                                    if v95 ~= nil then
                                        if v81 == nil then
                                            v81 = v85
                                        elseif v81 ~= nil then
                                            local v96 = CFrame.new(v93, v60[v81].PrimaryPart.Position).LookVector * 1000
                                            if (workspace:Raycast(v93, v96, v92).Position - v80.Position).Magnitude > (v95.Position - v80.Position).Magnitude then
                                                v81 = v85
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if v81 == nil or (v60[v81] == nil or v79 ~= true) then
                            if (v81 == nil and v58 or v79 == false) and (v58 and v58.Parent ~= nil) then
                                v58:Destroy()
                                v62 = nil
                                v58 = nil
                            end
                        else
                            local v97 = v60[v81]
                            if v58 == nil then
                                v58 = script.Parent.Shambles.shamblesIndicator:Clone()
                                local v98 = v97.PrimaryPart.Size.Magnitude
                                local v99 = v97.PrimaryPart.Size.Magnitude
                                local v100 = v97.PrimaryPart.Size.Magnitude
                                v58.Size = Vector3.new(v98, v99, v100)
                                v58.CFrame = v97.PrimaryPart.CFrame
                                v58.Parent = workspace.Effects
                                v58.WeldConstraint.Part1 = v97.PrimaryPart
                            elseif v58 == nil or v97 == nil then
                                v97 = v62
                            else
                                v58.WeldConstraint.Part1 = nil
                                local v101 = v97.PrimaryPart.Size.Magnitude
                                local v102 = v97.PrimaryPart.Size.Magnitude
                                local v103 = v97.PrimaryPart.Size.Magnitude
                                v58.Size = Vector3.new(v101, v102, v103)
                                v58.CFrame = v97.PrimaryPart.CFrame
                                v58.WeldConstraint.Part1 = v97.PrimaryPart
                            end
                            local v104 = v97:FindFirstChild("Humanoid")
                            if v97 == nil or not v104 then
                                v62 = v97
                            else
                                local v105
                                if v104 and v104:FindFirstChild("BodyHeightScale") then
                                    local v106 = v104.BodyDepthScale.Value
                                    local v107 = v104.BodyHeightScale.Value
                                    local v108 = v104.BodyWidthScale.Value
                                    v105 = Vector3.new(v106, v107, v108)
                                else
                                    v105 = 1
                                end
                                v58.Size = Vector3.new(5.5, 5.5, 5.5) * v105
                                if v97:IsDescendantOf(workspace.Effects) then
                                    v58:Destroy()
                                    v62 = nil
                                    v58 = nil
                                else
                                    v62 = v97
                                end
                            end
                        end
                    end
                    _G.shamblesTarget = v62
                else
                    v63 = v61
                end
                task.wait()
                v61 = v63
            end
            if v58 then
                v58:Destroy()
            end
        end)
        task.wait(0.4)
        u50 = true
    end
}