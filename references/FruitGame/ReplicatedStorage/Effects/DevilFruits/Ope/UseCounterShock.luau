 

local v1 = {}
require(game.ReplicatedStorage.Modules.LightningBolt)
local function u6(p2) --[[ Line: 5 ]]
    for _, v3 in pairs(p2) do
        for _, v4 in pairs(v3.growAttach:GetChildren()) do
            v4.Enabled = false
        end
        for _, v5 in pairs(v3.burstAttach:GetChildren()) do
            v5.Enabled = false
        end
    end
end
function v1.start(_, u7, u8) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if _G.checkRenderDistance(u7.PrimaryPart.Position) then
        local v9 = script
        local v10 = u7.HumanoidRootPart
        local v11 = v10.Parent.RightHand
        local u12 = {}
        for _ = 1, 2 do
            local u13 = v9.handPart:Clone()
            u13.Anchored = false
            u13.CFrame = v11.CFrame
            u13.Parent = workspace.Effects
            _G.destroy(u13, 6)
            table.insert(u12, u13)
            local v14 = Instance.new("WeldConstraint")
            v14.Part0 = u13
            v14.Part1 = v11
            v14.Parent = u13
            u13.growAttach.shineAbsorb:Emit(1)
            for _, v15 in pairs(u13.growAttach:GetChildren()) do
                if v15.Name ~= "shineAbsorb" then
                    game:GetService("TweenService"):Create(v15, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Rate"] = v15.Rate * 40
                    }, true):Play()
                end
            end
            task.delay(0.75, function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u13
                --]]
                if u8.Value ~= nil then
                    for _, v16 in pairs(u13.burstAttach:GetChildren()) do
                        if v16.Name ~= "shineBurst" then
                            v16.Enabled = true
                        end
                    end
                    _G.customEmit(u13.burstAttach, true)
                end
            end)
            v11 = v10.Parent.LeftHand
        end
        local u17 = tick()
        local u18 = tick()
        local v21 = game:GetService("RunService").Stepped:Connect(function() --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u17
                [3] = u12
            --]]
            if tick() - u18 > 0.05 then
                local v19 = tick() - u17
                local _ = v19 + 1
                for _, v20 in pairs(u12) do
                    if v20:FindFirstChild("growAttach") then
                        v20.growAttach.lineInward.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3 - v19 * 1, 0.5 + v19 * 0.6), NumberSequenceKeypoint.new(1, 0, 0) })
                        v20.growAttach.lineInward.Squash = NumberSequence.new({ NumberSequenceKeypoint.new(0, -v19 * 2, 0), NumberSequenceKeypoint.new(1, -v19 * 2, 0) })
                        v20.growAttach.waveInward.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2.3 + v19 * 3, 0), NumberSequenceKeypoint.new(1, 0, 0) })
                        v20.growAttach.electricityGrow.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4 + v19 * 1, 0.2 + v19 * 1), NumberSequenceKeypoint.new(1, 0.4 + v19 * 1, 0.2 + v19 * 1) })
                    end
                end
                u18 = tick()
            end
        end)
        local v22 = os.clock()
        repeat
            task.wait()
        until u8.Value ~= nil or (u8.Name == "done" or os.clock() - v22 > 5)
        if u8.Value == nil and u8.Name ~= "done" then
            warn("TIMEOUT: UseCounterShock yield expired")
            v21:Disconnect()
            return
        elseif u8.Value == nil then
            v21:Disconnect()
            task.delay(0.2, function() --[[ Line: 120 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u12
                --]]
                u6(u12)
            end)
        else
            local v23 = u8.Value
            local v24 = v9.OpeCounterShockDash:Clone()
            v24.Parent = v10
            v24.Playing = true
            task.wait(0.25)
            local v25 = v9.OpeCounterShockGrab:Clone()
            v25.Parent = v10
            v25.Playing = true
            v21:Disconnect()
            _G.PlaySound(v23.PrimaryPart, script.CounterShockHit)
            local v26 = v9.spiralPart:Clone()
            v26.Decal.Texture = "rbxassetid://9240195666"
            v26.Decal.Transparency = 0
            v26.CFrame = v23.PrimaryPart.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 1.5707963267948966)
            v26.Parent = workspace.Effects
            _G.destroy(v26, 0.4)
            game:GetService("TweenService"):Create(v26, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CFrame"] = v26.CFrame * CFrame.Angles(-1.2566370614359172, 0, 0)
            }, true):Play()
            game:GetService("TweenService"):Create(v26.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(0.3, 0.8, 0.8)
            }, true):Play()
            game:GetService("TweenService"):Create(v26.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Transparency"] = 1,
                ["Color3"] = Color3.fromRGB(255, 255, 255)
            }, true):Play()
            for _ = 1, 1 do
                local v27 = Random.new():NextNumber(0.9, 1.4)
                local v28 = v9.spiralPart:Clone()
                v28.CFrame = v23.PrimaryPart.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 1.5707963267948966)
                v28.Parent = workspace.Effects
                _G.destroy(v28, 0.2 * v27)
                game:GetService("TweenService"):Create(v28.Mesh, TweenInfo.new(0.2 * v27, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Scale"] = Vector3.new(0.05, 0.8, 0.8)
                }, true):Play()
                game:GetService("TweenService"):Create(v28.Decal, TweenInfo.new(0.2 * v27, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1,
                    ["Color3"] = Color3.fromRGB(255, 255, 255)
                }, true):Play()
            end
            local u29 = v9.hitPart:Clone()
            u29.CFrame = v23.PrimaryPart.CFrame
            u29.Parent = workspace.Effects
            _G.destroy(u29, 6)
            _G.customEmit(u29.startAttach, true)
            u29.finalizeAttach.lineLightning:Emit(3)
            u29.centerAttach.shineBurst:Emit(5)
            u29.centerAttach.electricityBurst:Emit(20)
            local v30 = RaycastParams.new()
            v30.FilterType = Enum.RaycastFilterType.Whitelist
            v30.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            v30.IgnoreWater = true
            local v31 = workspace:Raycast(u29.Position, CFrame.new(u29.Position, u29.Position - Vector3.new(0, 1000, 0)).LookVector * 5, v30)
            local v32
            if v31 == nil then
                v32 = nil
            else
                v32 = v9.outFloorPart:Clone()
                v32.CFrame = CFrame.new(v31.Position, v31.Position + v31.Normal)
                v32.Parent = workspace.Effects
                _G.destroy(v32, 6)
                for _, v33 in pairs(v32:GetChildren()) do
                    _G.customEmit(v33, true)
                    v33.Rate = v33.Rate * 4
                    v33.Enabled = true
                end
            end
            local v34 = v9.skeletonModel:Clone()
            _G.destroy(v34, 5)
            local u35 = Instance.new("Model")
            _G.destroy(u35, 6)
            for _, v36 in pairs(v23:GetChildren()) do
                if v36:IsA("BasePart") and (v36 ~= v23.PrimaryPart and v34:FindFirstChild(v36.Name .. "Bone")) then
                    local v37 = v36:Clone()
                    v37.CFrame = v36.CFrame
                    v37:BreakJoints()
                    v37.Anchored = true
                    v37.CanCollide = false
                    if v37.Name ~= "Head" then
                        v37:ClearAllChildren()
                    end
                    v37.Parent = u35
                    v37:SetAttribute("originSize", v37.Size)
                    _G.destroy(v37, 6)
                    _G.customWeld(v37, v36, CFrame.new(), v37)
                    local v38 = v34[v36.Name .. "Bone"]
                    v38.Anchored = true
                    v38.CFrame = v36.CFrame
                    _G.customWeld(v38, v36, CFrame.new(), v38)
                end
            end
            u35.Parent = workspace.Effects
            v34.Parent = workspace.Effects
            local u39 = Instance.new("Highlight")
            u39.Name = "flashHighlight"
            u39.OutlineTransparency = 1
            u39.DepthMode = Enum.HighlightDepthMode.Occluded
            u39.FillColor = Color3.fromRGB(0, 0, 0)
            u39.Parent = u35
            local u40 = Instance.new("Highlight")
            u40.Name = "skeletonHighlight"
            u40.OutlineTransparency = 1
            u40.FillTransparency = 0
            u40.FillColor = Color3.fromRGB(255, 255, 255)
            u40.Parent = v34
            local u41 = v23 == game.Players.LocalPlayer.Character
            if u41 == false then
                u41 = u7 == game.Players.LocalPlayer.Character
            end
            if u41 == true then
                game.Lighting.ColorCorrectionF.Brightness = 0.3
                game.Lighting.BlurF.Size = 15
                game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Size"] = 5
                }, true):Play()
            end
            local u42 = nil
            local u43
            if u41 == true then
                local u44 = v9.cameraPart:Clone()
                u44.CFrame = game.Workspace.CurrentCamera.CFrame
                u44.Parent = workspace.Effects
                _G.destroy(u44, 6)
                task.delay(6, function() --[[ Line: 280 ]]
                    --[[
                    Upvalues:
                        [1] = u42
                    --]]
                    u42:Disconnect()
                    u42 = nil
                end)
                local _ = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 284 ]]
                    --[[
                    Upvalues:
                        [1] = u44
                    --]]
                    u44.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1)
                end)
                u43 = u44
            else
                u43 = nil
            end
            local u45 = 1
            task.spawn(function() --[[ Line: 290 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u39
                    [3] = u40
                    [4] = u45
                    [5] = u41
                    [6] = u43
                    [7] = u35
                    [8] = u7
                --]]
                while u29.Parent ~= nil and u29.centerAttach.electricitySurround.Enabled == true do
                    u39.FillTransparency = 0
                    u40.FillTransparency = 0
                    game:GetService("TweenService"):Create(u40, TweenInfo.new(0.03125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["FillTransparency"] = 1
                    }, true):Play()
                    if u45 % 2 == 1 and u41 == true then
                        game.Lighting.ColorCorrectionF.TintColor = Color3.fromRGB(255, 217, 66)
                        game.Lighting.ColorCorrectionF.Brightness = 0.1
                        game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["TintColor"] = Color3.fromRGB(100, 100, 100),
                            ["Brightness"] = -0.2
                        }, true):Play()
                        u43.pulseWave:Emit(1)
                        u43.lineBurst:Emit(10)
                        u43.lineGrow:Emit(2)
                    end
                    for _ = 1, 2 do
                        for _, v46 in pairs(u35:GetChildren()) do
                            if v46:IsA("BasePart") then
                                v46.Size = v46:GetAttribute("originSize") * Random.new():NextNumber(1, 1.6)
                            end
                        end
                        if u7:FindFirstChild("Humanoid") and _G.cameraShakeEnabled == true then
                            local v47 = u7.Humanoid
                            local v48 = Random.new():NextNumber(-2, 2)
                            local v49 = Random.new():NextNumber(-2, 2)
                            local v50 = Random.new()
                            v47.CameraOffset = Vector3.new(v48, v49, v50:NextNumber(-2, 2))
                        end
                        task.wait(0.03125)
                    end
                    u45 = u45 + 1
                end
                if u41 == true then
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["TintColor"] = Color3.fromRGB(50, 50, 50)
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["TintColor"] = Color3.fromRGB(255, 255, 255),
                        ["Brightness"] = 0
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Size"] = 0
                    }, true):Play()
                    if _G.cameraShakeEnabled == true then
                        for v51 = 15, 0, -1 do
                            local v52 = v51 / 30
                            local v53 = u7.Humanoid
                            local v54 = Random.new():NextNumber(-2, 2) * v52
                            local v55 = Random.new():NextNumber(-2, 2) * v52
                            local v56 = Random.new():NextNumber(-2, 2) * v52
                            v53.CameraOffset = Vector3.new(v54, v55, v56)
                            task.wait(0.025)
                        end
                        u7.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                    end
                end
            end)
            task.wait(0.75)
            u29.smokeEmitter.Enabled = true
            task.wait(0.25)
            u35:Destroy()
            if v32 then
                for _, v57 in pairs(v32:GetChildren()) do
                    v57.Enabled = false
                end
            end
            u29.groundAttach.wavePulse.Enabled = false
            for _, v58 in pairs(u29.centerAttach:GetChildren()) do
                v58.Enabled = false
            end
            u6(u12)
            _G.customEmit(u29.finalizeAttach, true)
            u39.FillColor = Color3.fromRGB(76, 76, 76)
            game:GetService("TweenService"):Create(u39, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 0.5
            }, true):Play()
            game:GetService("TweenService"):Create(u29.smokeEmitter, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Rate"] = 0
            }, true):Play()
            task.wait(0.05)
            game:GetService("TweenService"):Create(u39, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 1
            }, true):Play()
        end
    else
        return
    end
end
return v1