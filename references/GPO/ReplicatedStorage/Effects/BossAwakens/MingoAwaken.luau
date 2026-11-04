 

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
    local v17 = u4:NextNumber(p7[1], p7[1])
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
    if _G.checkRenderDistance(p29.Position, 1000) == false then
        return
    elseif not u28 or u28.PrimaryPart ~= nil then
        _G.PlayEffect("CameraHideUI", nil, true)
        _G.PlayEffect("ScreenFade", nil, 0.25, true)
        task.wait(0.2)
        u28:WaitForChild("RightHand", 3)
        u28.HumanoidRootPart.Anchored = true
        local v30 = script["Audio/MingoIntroCutscene"]:Clone()
        v30.Parent = workspace
        v30:Play()
        _G.destroy(v30, 11)
        local u31 = script.CutsceneStuff:Clone()
        u31:PivotTo(p29)
        u31.Parent = workspace.Effects
        u31:WaitForChild("FlyRight", 2)
        local u43 = {
            {
                ["Frame"] = 44,
                ["Function"] = function(p32) --[[ Name: Function, Line 104 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    for _ = 1, 3 do
                        local u33 = String(p32.RightHand, u31.FlyRight.Position, { 5, 15 }, 3)
                        task.delay(1, function() --[[ Line: 108 ]]
                            --[[
                            Upvalues:
                                [1] = u33
                            --]]
                            FadeoutString(u33, 0.086)
                        end)
                    end
                end
            },
            {
                ["Frame"] = 108,
                ["Function"] = function(p34) --[[ Name: Function, Line 116 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    for _ = 1, 3 do
                        local u35 = String(p34.LeftHand, u31.FlyLeft.Position, { 5, 15 }, 3)
                        task.delay(1.13333333, function() --[[ Line: 120 ]]
                            --[[
                            Upvalues:
                                [1] = u35
                            --]]
                            FadeoutString(u35, 0.086)
                        end)
                    end
                end
            },
            {
                ["Frame"] = 204,
                ["Function"] = function(p36) --[[ Name: Function, Line 128 ]]
                    local u37 = script.Smoke:Clone()
                    u37.CFrame = p36.RightFoot.CFrame * CFrame.new(-0.5, 0, 0)
                    u37.Parent = workspace.Effects
                    local v38 = Instance.new("WeldConstraint")
                    v38.Part0 = u37
                    v38.Part1 = p36.RightFoot
                    v38.Parent = u37
                    task.delay(0.616666667, function() --[[ Line: 138 ]]
                        --[[
                        Upvalues:
                            [1] = u37
                        --]]
                        local v39 = next
                        local v40, v41 = u37:GetDescendants()
                        for _, v42 in v39, v40, v41 do
                            if v42:IsA("ParticleEmitter") then
                                v42.Enabled = false
                            end
                        end
                        task.wait(4.65)
                        u37:Destroy()
                    end)
                end
            }
        }
        u28:SetPrimaryPartCFrame(p29 * CFrame.new(0, 1.25, 0))
        local u44 = script.CamReAdd:Clone()
        u44:SetPrimaryPartCFrame(p29 * CFrame.new(-2, 0, -3))
        u44.Parent = workspace.Effects
        local u45 = u44.Humanoid:LoadAnimation(script.Camera)
        u45:Play()
        pcall(function() --[[ Line: 159 ]]
            --[[
            Upvalues:
                [1] = u28
            --]]
            u28.Humanoid:LoadAnimation(script.Character):Play()
        end)
        for v46 = 1, #u43 do
            local u47 = u43[v46]
            if u47.Frame then
                task.delay(u47.Frame / 60, function() --[[ Line: 168 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u28
                    --]]
                    u47.Function(u28)
                end)
            else
                task.spawn(function() --[[ Line: 172 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u28
                    --]]
                    u47.Function(u28)
                end)
            end
        end
        local u48 = nil
        local u49 = tick()
        local u50 = workspace.CurrentCamera.CFrame
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        workspace.CurrentCamera.CFrame = u44.Cam.CFrame
        local u51 = false
        u48 = u3.RenderStepped:Connect(function() --[[ Line: 188 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u45
                [3] = u51
                [4] = u44
                [5] = u48
                [6] = u50
                [7] = u31
                [8] = u43
            --]]
            if tick() - u49 >= u45.Length - 0.25 and u51 == false then
                u51 = true
                task.spawn(function() --[[ Line: 191 ]]
                    _G.PlayEffect("ScreenFade", nil, 0.5, true)
                    task.wait(0.25)
                    _G.PlayEffect("CameraHideUI", nil, false)
                end)
            end
            if tick() - u49 < u45.Length then
                workspace.CurrentCamera.CFrame = u44.Cam.CFrame
            else
                u48:Disconnect()
                u44:Destroy()
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                workspace.CurrentCamera.CFrame = u50
                u31:Destroy()
                table.clear(u43)
            end
        end)
    end
end
return v1