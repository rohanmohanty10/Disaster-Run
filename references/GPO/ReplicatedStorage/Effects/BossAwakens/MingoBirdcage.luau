 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = Random.new()
function String(p5, p6, p7, p8, p9)
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v10 = p9 or 1
    local v11 = u4:NextNumber(-p8, p8)
    local v12 = u4:NextNumber(-p8, p8)
    local v13 = u4
    local v14 = -p8
    local v15 = p6 + Vector3.new(v11, v12, v13:NextNumber(v14, p8))
    local v16 = script.Beam:Clone()
    local v17 = u4:NextNumber(p7[1], p7[2])
    v16.Start.Start.Beam.CurveSize0 = v17
    v16.Start.Start.Beam.CurveSize1 = -v17
    v16.Start.CFrame = CFrame.new(p5.Position, v15) * CFrame.new(u4:NextNumber(-0.1, 0.1), u4:NextNumber(-0.1, 0.1), u4:NextNumber(-0.1, 0.1))
    v16.End.Position = v16.Start.Position
    v16.Parent = workspace.Effects
    u2:Create(v16.End, TweenInfo.new(u4:NextNumber(0.15, 0.3) * v10), {
        ["Position"] = v15
    }):Play()
    u2:Create(v16.Start.Start.Beam, TweenInfo.new(u4:NextNumber(0.4, 0.7) * v10, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        ["CurveSize0"] = 0,
        ["CurveSize1"] = 0
    }):Play()
    local v18 = Instance.new("WeldConstraint")
    v18.Name = "Weld"
    v18.Part0 = v16.Start
    v18.Part1 = p5
    v18.Parent = v16.Start
    return v16
end
function FadeoutString(u19, p20)
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    u19.Start.Weld:Destroy()
    u19.Start.Anchored = true
    local v21 = next
    local v22, v23 = u19:GetDescendants()
    local v24 = p20 or 0.15
    for _, u25 in v21, v22, v23 do
        if u25:IsA("Beam") then
            local u26 = Instance.new("NumberValue")
            u26:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u26
                --]]
                u25.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u26.Value), NumberSequenceKeypoint.new(0.675, u26.Value), NumberSequenceKeypoint.new(1, 1) })
            end)
            u26.Value = 0
            u2:Create(u26, TweenInfo.new(v24, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                ["Value"] = 1
            }):Play()
            local v27 = u4:NextNumber(2, 5)
            u25.CurveSize0 = v27
            u25.CurveSize1 = -v27
            u2:Create(u25, TweenInfo.new(v24), {
                ["CurveSize0"] = v27,
                ["CurveSize1"] = -v27
            }):Play()
        end
    end
    task.delay(v24, function() --[[ Line: 72 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        u19:Destroy()
    end)
end
function v1.start(_, u28, p29) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if _G.checkRenderDistance(p29.Position, 1000) ~= false then
        _G.PlayEffect("CameraHideUI", nil, true)
        _G.PlayEffect("ScreenFade", nil, 0.25, true)
        task.wait(0.2)
        u28:WaitForChild("RightHand", 3)
        u28.HumanoidRootPart.Anchored = true
        local v30 = script.StringBossSpawnA:Clone()
        v30.Parent = workspace
        v30:Play()
        _G.destroy(v30, 11)
        local u31 = script.CutsceneStuff:Clone()
        u31:PivotTo(p29)
        u31.Parent = workspace.Effects
        u31:WaitForChild("Right", 2)
        local u53 = {
            {
                ["Function"] = function(p32) --[[ Name: Function, Line 101 ]]
                    local u33 = script.Smoke:Clone()
                    u33.CFrame = p32.RightFoot.CFrame * CFrame.new(-0.5, 0, 0)
                    u33.Parent = workspace.Effects
                    local v34 = Instance.new("WeldConstraint")
                    v34.Part0 = u33
                    v34.Part1 = p32.RightFoot
                    v34.Parent = u33
                    task.delay(0.616666667, function() --[[ Line: 111 ]]
                        --[[
                        Upvalues:
                            [1] = u33
                        --]]
                        local v35 = next
                        local v36, v37 = u33:GetDescendants()
                        for _, v38 in v35, v36, v37 do
                            if v38:IsA("ParticleEmitter") then
                                v38.Enabled = false
                            end
                        end
                        task.wait(4.65)
                        u33:Destroy()
                    end)
                end
            },
            {
                ["Frame"] = 112,
                ["Function"] = function(p39) --[[ Name: Function, Line 124 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    for _ = 1, 3 do
                        local u40 = String(p39.RightHand, u31.Right.Position, { 5, 15 }, 3)
                        task.delay(2.23333333, function() --[[ Line: 128 ]]
                            --[[
                            Upvalues:
                                [1] = u40
                            --]]
                            FadeoutString(u40, 0.086)
                        end)
                    end
                end
            },
            {
                ["Frame"] = 198,
                ["Function"] = function(p41) --[[ Name: Function, Line 136 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    for _ = 1, 3 do
                        local u42 = String(p41.LeftHand, u31.Left.Position, { 5, 15 }, 3)
                        task.delay(0.8, function() --[[ Line: 140 ]]
                            --[[
                            Upvalues:
                                [1] = u42
                            --]]
                            FadeoutString(u42, 0.086)
                        end)
                    end
                end
            },
            {
                ["Frame"] = 246,
                ["Function"] = function(p43) --[[ Name: Function, Line 148 ]]
                    local u44 = script.Launch:Clone()
                    u44.CFrame = CFrame.new(p43.UpperTorso.Position) * CFrame.Angles(0, 0, -0.6981317007977318)
                    u44.Parent = workspace.Effects
                    _G.customEmit(u44)
                    task.delay(5, function() --[[ Line: 155 ]]
                        --[[
                        Upvalues:
                            [1] = u44
                        --]]
                        u44:Destroy()
                    end)
                end
            },
            {
                ["Frame"] = 318,
                ["Function"] = function(p45) --[[ Name: Function, Line 163 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    for _ = 1, 3 do
                        local u46 = String(p45.RightHand, u31.Right2.Position, { 1, 4 }, 0.25)
                        local u47 = String(p45.LeftHand, u31.Left2.Position, { 1, 4 }, 0.25)
                        task.delay(0.35, function() --[[ Line: 168 ]]
                            --[[
                            Upvalues:
                                [1] = u46
                                [2] = u47
                            --]]
                            FadeoutString(u46)
                            FadeoutString(u47)
                        end)
                    end
                end
            },
            {
                ["Frame"] = 343,
                ["Function"] = function(p48) --[[ Name: Function, Line 178 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    local v49 = script.LandImpact:Clone()
                    v49.CFrame = CFrame.new((u31.Left2.Position + u31.Right2.Position) / 2, p48.UpperTorso.Position) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966) * CFrame.new(0, -0.5, 0)
                    v49.Parent = workspace.Effects
                    _G.customEmit(v49)
                    task.wait(4.65)
                    v49:Destroy()
                end
            },
            {
                ["Frame"] = 438,
                ["Function"] = function(p50) --[[ Name: Function, Line 197 ]]
                    local u51 = workspace.Effects:WaitForChild("Island Birdcage", 3):WaitForChild("birdcageMesh", 3)
                    if u51 ~= nil then
                        for _ = 1, 6 do
                            local u52 = String(p50.RightHand, u51.Attachment.WorldPosition, { 5, 7 }, 3, 0.05)
                            task.spawn(function() --[[ Line: 204 ]]
                                --[[
                                Upvalues:
                                    [1] = u51
                                    [2] = u52
                                --]]
                                u51.Destroying:Wait()
                                FadeoutString(u52, 0.086)
                            end)
                        end
                    end
                end
            }
        }
        u28:SetPrimaryPartCFrame(p29 * CFrame.new(0, 1.25, 0))
        local u54 = script.CamReAdd:Clone()
        u54:SetPrimaryPartCFrame(p29 * CFrame.new(0, 0, -3))
        u54.Parent = workspace.Effects
        local u55 = u54.Humanoid:LoadAnimation(script.Camera)
        u55:Play()
        u28.Humanoid:LoadAnimation(script.Character):Play()
        for v56 = 1, #u53 do
            local u57 = u53[v56]
            if u57.Frame then
                task.delay(u57.Frame / 60, function() --[[ Line: 229 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u28
                    --]]
                    u57.Function(u28)
                end)
            else
                task.spawn(function() --[[ Line: 233 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u28
                    --]]
                    u57.Function(u28)
                end)
            end
        end
        local u58 = nil
        local u59 = tick()
        local u60 = workspace.CurrentCamera.CFrame
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        workspace.CurrentCamera.CFrame = u54.Cam.CFrame
        local u61 = false
        u58 = u3.RenderStepped:Connect(function() --[[ Line: 248 ]]
            --[[
            Upvalues:
                [1] = u59
                [2] = u55
                [3] = u61
                [4] = u54
                [5] = u58
                [6] = u60
                [7] = u31
                [8] = u53
            --]]
            if tick() - u59 >= u55.Length - 0.25 and u61 == false then
                u61 = true
                task.spawn(function() --[[ Line: 252 ]]
                    _G.PlayEffect("ScreenFade", nil, 0.5, true)
                    task.wait(0.25)
                    _G.PlayEffect("CameraHideUI", nil, false)
                end)
            end
            if tick() - u59 < u55.Length then
                workspace.CurrentCamera.CFrame = u54.Cam.CFrame
            else
                u58:Disconnect()
                u54:Destroy()
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                workspace.CurrentCamera.CFrame = u60
                u31:Destroy()
                table.clear(u53)
            end
        end)
    end
end
return v1