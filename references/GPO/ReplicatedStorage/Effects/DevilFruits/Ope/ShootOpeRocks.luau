 

return {
    ["start"] = function(_, p1, p2, _, u3, u4) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(u3.PrimaryPart.Position) then
            local u5 = script
            local _ = u3.Parent == workspace.NPCs
            local u6 = game.Workspace.Effects:FindFirstChild("roomBubble" .. u3.Name)
            if u6 then
                local u7 = #p1:GetChildren() - 1
                local u8 = 0
                for _, v9 in pairs(p1:GetChildren()) do
                    if v9:IsA("Model") then
                        _G.destroy(v9, 6)
                        v9:SetAttribute("shotRock", true)
                        if v9.PrimaryPart ~= nil then
                            local v10 = v9.PrimaryPart.Size.Magnitude * 0.15
                            for _, v11 in pairs(u5.prepParticles:GetChildren()) do
                                local v12 = v11:Clone()
                                local v13 = {}
                                for _, v14 in ipairs(v12.Size.Keypoints) do
                                    local v15 = NumberSequenceKeypoint.new
                                    local v16 = v14.Time
                                    local v17 = v14.Value * v10
                                    local v18 = v14.Envelope * v10
                                    table.insert(v13, v15(v16, v17, v18))
                                end
                                v12.Size = NumberSequence.new(v13)
                                v12.Speed = NumberRange.new(v12.Speed.Min * v10, v12.Speed.Max * v10)
                                local v19 = v12.Acceleration.X * v10
                                local v20 = v12.Acceleration.Y * v10
                                local v21 = v12.Acceleration.Z * v10
                                v12.Acceleration = Vector3.new(v19, v20, v21)
                                v12.Parent = v9.PrimaryPart.centerAttach
                                _G.destroy(v12, 6)
                                _G.customEmit(v12, true)
                            end
                            game:GetService("TweenService"):Create(v9.Highlight, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ["FillTransparency"] = 0
                            }, true):Play()
                        end
                    end
                end
                task.wait(0.35)
                local u22 = p1:Clone()
                u22.Parent = workspace.Effects
                p1:Destroy()
                _G.destroy(u22, 30)
                for _, u23 in pairs(u22:GetChildren()) do
                    if u23:IsA("Model") then
                        for _, v24 in pairs(u23.PrimaryPart:GetChildren()) do
                            if v24:IsA("ParticleEmitter") then
                                v24.Enabled = false
                            end
                        end
                        local u25 = u23.PrimaryPart.Size.Magnitude * 0.15
                        u23.PrimaryPart.centerAttach.turningWave.Enabled = false
                        game:GetService("TweenService"):Create(u23.Highlight, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["FillTransparency"] = 0.6
                        }, true):Play()
                        u23.PrimaryPart.Anchored = false
                        local v26 = CFrame.new(u23.PrimaryPart.Position, p2)
                        local v27 = u5.launchPart:Clone()
                        v27.CFrame = v26
                        v27.Parent = workspace.Effects
                        _G.destroy(v27, 1.05)
                        _G.PlaySound(v27, script.OpeTactWhoosh, {
                            ["Pitch"] = math.random(90, 110) / 100
                        })
                        for _, v28 in pairs(v27.Attachment:GetChildren()) do
                            local v29 = {}
                            for _, v30 in ipairs(v28.Size.Keypoints) do
                                local v31 = NumberSequenceKeypoint.new
                                local v32 = v30.Time
                                local v33 = v30.Value * u25
                                local v34 = v30.Envelope * u25
                                table.insert(v29, v31(v32, v33, v34))
                            end
                            v28.Size = NumberSequence.new(v29)
                            v28.Speed = NumberRange.new(v28.Speed.Min * u25, v28.Speed.Max * u25)
                            local v35 = v28.Acceleration.X * u25
                            local v36 = v28.Acceleration.Y * u25
                            local v37 = v28.Acceleration.Z * u25
                            v28.Acceleration = Vector3.new(v35, v36, v37)
                        end
                        _G.customEmit(v27, true)
                        _G.destroy(v27, 1.5)
                        local v38 = Instance.new("BodyVelocity")
                        v38.MaxForce = Vector3.new(inf, inf, inf)
                        v38.Velocity = v26.LookVector * 150
                        v38.Parent = u23.PrimaryPart
                        local v39 = Instance.new("Attachment")
                        local v40 = u23.PrimaryPart.Size.Magnitude * 0.5
                        v39.Position = Vector3.new(v40, 0, 0)
                        v39.Parent = u23.PrimaryPart
                        local v41 = Instance.new("Attachment")
                        local v42 = -u23.PrimaryPart.Size.Magnitude * 0.5
                        v41.Position = Vector3.new(v42, 0, 0)
                        v41.Parent = u23.PrimaryPart
                        local v43 = u5.Trail:Clone()
                        v43.Attachment0 = v39
                        v43.Attachment1 = v41
                        v43.Parent = u23
                        u23.PrimaryPart.lightningLineBurst.Enabled = true
                        u23.PrimaryPart.rockTrail.Enabled = true
                        u23.PrimaryPart.dustTrail.Enabled = true
                        local u44 = u5.shockwavePart:Clone()
                        u44.CFrame = v26 * CFrame.Angles(0, -1.5707963267948966, 0)
                        u44.Anchored = false
                        u44.Parent = workspace.Effects
                        _G.destroy(u44, 0.15)
                        local v45 = game:GetService("TweenService")
                        local v46 = u44.Mesh
                        local v47 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local v48 = {}
                        local v49 = 0.3 * u25
                        local v50 = 0.0625 * u25
                        local v51 = 0.0625 * u25
                        v48.Scale = Vector3.new(v49, v50, v51)
                        v45:Create(v46, v47, v48, true):Play()
                        game:GetService("TweenService"):Create(u44.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 0.9
                        }, true):Play()
                        local v52 = Instance.new("WeldConstraint")
                        v52.Part0 = u44
                        v52.Part1 = u23.PrimaryPart
                        v52.Parent = u44
                        local v53 = u5.shockwavePart:Clone()
                        v53.CFrame = v26 * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
                        v53.Decal.Texture = "rbxassetid://8723466268"
                        v53.Decal.Transparency = 0.8
                        v53.Parent = workspace.Effects
                        _G.destroy(v53, 0.3)
                        local v54 = game:GetService("TweenService")
                        local v55 = v53.Mesh
                        local v56 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local v57 = {}
                        local v58 = 1 * u25
                        local v59 = 0.4 * u25
                        local v60 = 0.4 * u25
                        v57.Scale = Vector3.new(v58, v59, v60)
                        v54:Create(v55, v56, v57, true):Play()
                        game:GetService("TweenService"):Create(v53.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1,
                            ["Color3"] = Color3.fromRGB(255, 255, 255)
                        }, true):Play()
                        for _ = 1, 3 do
                            local v61 = Random.new():NextNumber(0.25, 0.8)
                            local v62 = Random.new():NextNumber(0.2, 0.3)
                            local v63 = u5.shockwavePart:Clone()
                            v63.CFrame = v26 * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
                            v63.Decal.Texture = "rbxassetid://8909210011"
                            v63.Decal.Transparency = 0
                            v63.Parent = workspace.Effects
                            _G.destroy(v63, v61)
                            game:GetService("TweenService"):Create(v63, TweenInfo.new(v61, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["CFrame"] = v63.CFrame * CFrame.Angles(2.5132741228718345, 0, 0) * CFrame.new(-Random.new():NextNumber(4, 6), 0, 0)
                            }, true):Play()
                            local v64 = game:GetService("TweenService")
                            local v65 = v63.Mesh
                            local v66 = TweenInfo.new(v61, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local v67 = {}
                            local v68 = 0.05 * u25
                            local v69 = v62 * u25
                            local v70 = v62 * u25
                            v67.Scale = Vector3.new(v68, v69, v70)
                            v64:Create(v65, v66, v67, true):Play()
                            game:GetService("TweenService"):Create(v63.Decal, TweenInfo.new(v61, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1,
                                ["Color3"] = Color3.fromRGB(255, 255, 255)
                            }, true):Play()
                        end
                        for _ = 1, 4 do
                            local v71 = Random.new():NextNumber(0.2, 0.8)
                            local v72 = Random.new():NextNumber(0.35, 0.5)
                            local v73 = u5.shockwavePart:Clone()
                            v73.CFrame = v26 * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
                            v73.Decal.Texture = "rbxassetid://3916186365"
                            v73.Decal.Transparency = 0
                            v73.Parent = workspace.Effects
                            _G.destroy(v73, v71)
                            game:GetService("TweenService"):Create(v73, TweenInfo.new(v71, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["CFrame"] = v73.CFrame * CFrame.Angles(2.5132741228718345, 0, 0)
                            }, true):Play()
                            local v74 = game:GetService("TweenService")
                            local v75 = v73.Mesh
                            local v76 = TweenInfo.new(v71, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local v77 = {}
                            local v78 = 0.05 * u25
                            local v79 = v72 * u25
                            local v80 = v72 * u25
                            v77.Scale = Vector3.new(v78, v79, v80)
                            v74:Create(v75, v76, v77, true):Play()
                            game:GetService("TweenService"):Create(v73.Decal, TweenInfo.new(v71, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1,
                                ["Color3"] = Color3.fromRGB(255, 255, 255)
                            }, true):Play()
                        end
                        for _ = 1, 4 do
                            local v81 = Random.new():NextNumber(0.2, 0.8)
                            local v82 = Random.new():NextNumber(0.5, 0.6)
                            local v83 = u5.shockwavePart:Clone()
                            v83.CFrame = v26 * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
                            v83.Decal.Texture = "rbxassetid://3916186365"
                            v83.Decal.Transparency = 0.5
                            v83.Parent = workspace.Effects
                            _G.destroy(v83, v81)
                            game:GetService("TweenService"):Create(v83, TweenInfo.new(v81, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["CFrame"] = v83.CFrame * CFrame.Angles(2.5132741228718345, 0, 0)
                            }, true):Play()
                            local v84 = game:GetService("TweenService")
                            local v85 = v83.Mesh
                            local v86 = TweenInfo.new(v81, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local v87 = {}
                            local v88 = 0.05 * u25
                            local v89 = v82 * u25
                            local v90 = v82 * u25
                            v87.Scale = Vector3.new(v88, v89, v90)
                            v84:Create(v85, v86, v87, true):Play()
                            game:GetService("TweenService"):Create(v83.Decal, TweenInfo.new(v81, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1,
                                ["Color3"] = Color3.fromRGB(255, 255, 255)
                            }, true):Play()
                        end
                        local u91 = 30 * u25
                        task.spawn(function() --[[ Line: 252 ]]
                            --[[
                            Upvalues:
                                [1] = u91
                                [2] = u44
                                [3] = u5
                                [4] = u25
                                [5] = u4
                                [6] = u3
                                [7] = u23
                                [8] = u6
                                [9] = u8
                                [10] = u7
                                [11] = u22
                            --]]
                            local function u109(p92, p93) --[[ Line: 255 ]]
                                --[[
                                Upvalues:
                                    [1] = u91
                                    [2] = u44
                                    [3] = u5
                                    [4] = u25
                                    [5] = u4
                                    [6] = u3
                                --]]
                                local v94 = (workspace.CurrentCamera.CFrame.Position - p93).Magnitude
                                if v94 < u91 then
                                    local v95 = 1 - v94 / u91
                                    game.Lighting.BlurF.Size = 20 * v95
                                    game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                                        ["Size"] = 0
                                    }, true):Play()
                                end
                                p92.PrimaryPart.Anchored = true
                                _G.destroy(p92, 1)
                                u44:Destroy()
                                p92.PrimaryPart.centerAttach.wavePulse.Enabled = false
                                for _, v96 in pairs(p92.PrimaryPart:GetChildren()) do
                                    if v96:IsA("ParticleEmitter") then
                                        v96.Enabled = false
                                    end
                                end
                                for _, v97 in pairs(p92:GetChildren()) do
                                    if v97:IsA("MeshPart") then
                                        v97.Transparency = 1
                                    end
                                end
                                local v98 = u5.hitPart:Clone()
                                v98.CFrame = p92.PrimaryPart.CFrame
                                v98.Parent = workspace.Effects
                                for _, v99 in pairs(v98.Attachment:GetChildren()) do
                                    local v100 = {}
                                    for _, v101 in ipairs(v99.Size.Keypoints) do
                                        local v102 = NumberSequenceKeypoint.new
                                        local v103 = v101.Time
                                        local v104 = v101.Value * u25
                                        local v105 = v101.Envelope * u25
                                        table.insert(v100, v102(v103, v104, v105))
                                    end
                                    v99.Size = NumberSequence.new(v100)
                                    v99.Speed = NumberRange.new(v99.Speed.Min * u25, v99.Speed.Max * u25)
                                    local v106 = v99.Acceleration.X * u25
                                    local v107 = v99.Acceleration.Y * u25
                                    local v108 = v99.Acceleration.Z * u25
                                    v99.Acceleration = Vector3.new(v106, v107, v108)
                                    if v99:GetAttribute("recolor") then
                                        v99.Color = ColorSequence.new(p92.top.Color)
                                    end
                                    v99:Emit(v99.Rate * 0.6)
                                end
                                _G.destroy(v98, 2.3)
                                _G.PlaySound(v98, script["OpeTactBoom" .. math.random(1, 3)], {
                                    ["Pitch"] = math.random(90, 110) / 100,
                                    ["RollOffMaxDistance"] = 125 + p92.PrimaryPart.Size.Magnitude * 5
                                })
                                if u4 and u3 == game.Players.LocalPlayer.Character then
                                    u4:FireServer(p92.PrimaryPart.CFrame, "explosion")
                                end
                                _G.shakenear(p93, 50 + p92.top.Size.Magnitude * 1.5, 35 * u25, 40 * u25, -1)
                            end
                            u23.PrimaryPart.OpeTactFloatLoop:Stop()
                            local v110 = u23.PrimaryPart.CFrame
                            local v111 = RaycastParams.new()
                            v111.FilterType = Enum.RaycastFilterType.Include
                            v111.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
                            v111.IgnoreWater = true
                            local u112 = false
                            while u23.Parent ~= nil do
                                if u6 and (u6:IsDescendantOf(game.Workspace.Effects) and ((u6.Position - u23.PrimaryPart.Position).Magnitude < u6.Size.X / 2 and not u112)) then
                                    local v113 = (v110.Position - u23.PrimaryPart.Position).Magnitude
                                    local v114 = workspace:Raycast(v110.Position, (v110.Position - u23.PrimaryPart.Position).unit * -v113, v111)
                                    if v114 ~= nil then
                                        u8 = u8 + 1
                                        u23:PivotTo(CFrame.new(v114.Position))
                                        u109(u23, u23.PrimaryPart.Position)
                                        break
                                    end
                                    v110 = u23.PrimaryPart.CFrame
                                elseif not u112 and (u23.PrimaryPart:FindFirstChild("BodyVelocity") and u23:GetAttribute("gotEnd") == nil) then
                                    u23:SetAttribute("gotEnd", true)
                                    u23.PrimaryPart.BodyVelocity:Destroy()
                                    local u115 = nil
                                    u115 = u23.PrimaryPart.Touched:Connect(function(p116) --[[ Line: 358 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u112
                                            [2] = u115
                                            [3] = u8
                                            [4] = u109
                                            [5] = u23
                                        --]]
                                        if p116:IsDescendantOf(workspace.Islands) or (p116:IsDescendantOf(workspace.Env) or p116:IsDescendantOf(workspace.Ships)) then
                                            u112 = true
                                            u115:Disconnect()
                                            u115 = nil
                                            u8 = u8 + 1
                                            u109(u23, u23.PrimaryPart.Position)
                                        end
                                    end)
                                    break
                                end
                                if u8 == u7 then
                                    u23.Parent = workspace.Effects
                                    _G.destroy(u23, 3)
                                    if u22 ~= nil then
                                        u22:Destroy()
                                    end
                                    break
                                end
                                game["Run Service"].Stepped:Wait()
                            end
                        end)
                    end
                end
            end
        else
            return
        end
    end
}