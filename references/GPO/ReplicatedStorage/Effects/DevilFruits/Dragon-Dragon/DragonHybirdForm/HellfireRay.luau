 

local u1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
game:GetService("Players")
local u4 = _G.customEmit
local function u9(p5, p6) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, v7 in p5:GetDescendants() do
        if v7:IsA("ParticleEmitter") then
            v7.Enabled = p6
        elseif v7:IsA("PointLight") then
            local v8 = v7:GetAttribute("originalbrightness")
            if not v8 then
                v7:SetAttribute("originalbrightness", v7.Brightness)
                v8 = v7.Brightness
            end
            u2:Create(v7, TweenInfo.new(0.15), {
                ["Brightness"] = p6 and v8 and v8 or 0
            }):Play()
        end
    end
end
local u10 = RaycastParams.new()
local v11 = Enum.RaycastFilterType.Include
local v12 = { workspace.Islands, workspace.Ships, workspace.Env }
u10.FilterType = v11
u10.FilterDescendantsInstances = v12
function u1.PlayAnim(_, p13, p14, p15) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u16 = p13.Humanoid:LoadAnimation(p14)
    local v17 = p13:FindFirstChild("DragonTailController", true)
    local u18
    if v17 == nil then
        u18 = nil
    else
        u18 = v17:LoadAnimation(p14)
    end
    u16:Play()
    if u18 then
        u18:Play()
        if p15 == nil then
            local u19 = nil
            u19 = u3.Heartbeat:Connect(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u18
                    [3] = u19
                --]]
                if u16.IsPlaying == true and u18.IsPlaying == false then
                    u18:Play()
                    u18.TimePosition = u16.TimePosition
                elseif u16.IsPlaying == false and u18.IsPlaying == true then
                    u18:Stop()
                    if u19 then
                        u19:Disconnect()
                        u19 = nil
                    end
                    return
                end
                u18.TimePosition = u16.TimePosition
                u18:AdjustSpeed(u16.Speed)
            end)
            u16.Stopped:Connect(function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u19
                --]]
                u18:Stop()
                if u19 then
                    u19:Disconnect()
                    u19 = nil
                end
            end)
            task.delay(15, function() --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                if u19 then
                    u19:Disconnect()
                    u19 = nil
                end
            end)
        end
        u16.Destroying:Connect(function() --[[ Line: 94 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18:Destroy()
        end)
    end
    return u16
end
function u1.start(_, u20, u21, _) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u9
        [3] = u4
        [4] = u3
        [5] = u2
        [6] = u10
    --]]
    local v22 = u20:GetPivot() * CFrame.new(0, 1.5, -0.5)
    local u23 = Random.new()
    local u24 = u20 == game.Players.LocalPlayer.Character
    local u25 = u20:FindFirstChild("Head")
    local u26 = {}
    local u27 = false
    local v28 = u1:PlayAnim(u20, script.Animations.Startup)
    local v29 = script.Charging:Clone()
    v29.CFrame = v22
    v29.Parent = workspace.Effects
    local v30 = Instance.new("Weld")
    v30.Part0 = u25
    v30.Part1 = v29
    v30.C0 = CFrame.new(0, 0, -1)
    v30.Parent = v29
    local v31 = _G.PlaySound(u25, script.DragonMiniBoroBreathStart)
    v31.Parent = u25
    table.insert(u26, v31)
    task.wait(0.25)
    u9(v29.Fire, true)
    _G.particleEnabled(v29, false)
    task.wait(0.5)
    _G.destroy(v29, 0.35)
    v28:Stop()
    local u32 = u1:PlayAnim(u20, script.Animations.Loop)
    local u33 = script.Shot:Clone()
    u33.CFrame = v22 * CFrame.Angles(-0.8975979010256552, 0, 0)
    u33.Parent = workspace.Effects
    local u34 = script.BeamEndEffect:Clone()
    u34.CFrame = v22 * CFrame.Angles(-0.8975979010256552, 0, 0)
    u34.Parent = workspace.Effects
    local u35 = script.TrailDecals:Clone()
    u35.CFrame = v22 * CFrame.Angles(-0.8975979010256552, 0, 0)
    u35.Parent = workspace.Effects
    local u36 = false
    os.clock()
    os.clock()
    u4(u33.Burst)
    local v37 = _G.PlaySound
    local v38 = script.DragonMiniBoroBreathShoot
    table.insert(u26, v37(u25, v38))
    local v39 = script.DragonMiniBoroBreathHoldLoop:Clone()
    v39.Parent = u25
    v39:Play()
    local u40 = script.DragonMiniBoroBreathLaserHitGround:Clone()
    u40.Parent = u35
    u40:Play()
    u40.Volume = 0
    table.insert(u26, v39)
    table.insert(u26, u40)
    local _ = u20:GetPivot() * CFrame.new(0, 0, -100)
    local function u44(p41) --[[ Line: 174 ]]
        --[[
        Upvalues:
            [1] = u35
        --]]
        local v42 = u35:GetChildren()
        for v43 = 1, #v42 do
            if v42[v43]:IsA("Trail") then
                v42[v43].Enabled = p41
            end
        end
    end
    local u45 = Vector3.new()
    local u46 = Vector3.new()
    _G.tween(u34.PointLight, {
        0.1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        -1,
        true,
        0
    }, {
        ["Range"] = 16
    })
    _G.tween(u34.CenterEnd.PointLight, {
        0.1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        -1,
        true,
        0
    }, {
        ["Range"] = 20
    })
    local u47 = nil
    u47 = u3.Heartbeat:Connect(function(_) --[[ Line: 192 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u20
            [3] = u21
            [4] = u34
            [5] = u32
            [6] = u1
            [7] = u33
            [8] = u2
            [9] = u23
            [10] = u47
            [11] = u9
            [12] = u44
            [13] = u26
            [14] = u25
            [15] = u35
            [16] = u46
            [17] = u36
            [18] = u40
            [19] = u45
            [20] = u10
            [21] = u24
        --]]
        if u27 == true then
            return
        else
            local v48 = RaycastParams.new()
            local v49 = Enum.RaycastFilterType.Include
            local v50 = _G.getTargetsWithENV(u20)
            v48.FilterType = v49
            v48.FilterDescendantsInstances = v50
            local v51 = u20:FindFirstChild("PB")
            if v51 == nil and u21:IsDescendantOf(game) ~= false or u27 then
                u33.CFrame = CFrame.new(u25.Position, (u20.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10000)).Position) * CFrame.new(0, 0, -2)
                local v52 = u33.CFrame.LookVector * 150
                local u53 = workspace:Raycast(u33.Position, v52, v48)
                if u53 and u53.Instance then
                    local u54 = _G.getTargetByPart(u53.Instance)
                    if not u36 then
                        u9(u34.CenterEnd, not u27)
                        u9(u33.End, false)
                    end
                    u36 = true
                    _G.particleEnabled(u34, true)
                    u40.Volume = 0.5
                    u33.End.Position = u53.Position
                    if not u46 then
                        u46 = u53.Position
                    end
                    if u54 == nil then
                        local v55 = u53.Position
                        local v56 = v55 - u46
                        if v56.Magnitude > 0.05 then
                            local v57 = v56.Unit
                            local v58 = u53.Normal:Cross(v57)
                            if v58.Magnitude > 0.001 then
                                u35.CFrame = CFrame.fromMatrix(v55 + u53.Normal * 0.05, v58, u53.Normal)
                                u44(true)
                            else
                                u44(false)
                            end
                            u46 = v55
                        else
                            u44(false)
                            u35.Position = v55 + u53.Normal * 0.05
                        end
                    else
                        u44(false)
                        u46 = u53.Position
                    end
                    CFrame.lookAt(u53.Position + u53.Normal * 0.05, u53.Position + u53.Normal)
                    u33.End.Orientation = u33.Orientation
                    u34.CenterEnd.WorldCFrame = CFrame.new(u53.Position, u53.Position + u53.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                    task.spawn(function() --[[ Line: 340 ]]
                        --[[
                        Upvalues:
                            [1] = u45
                            [2] = u53
                            [3] = u54
                            [4] = u23
                            [5] = u35
                            [6] = u33
                            [7] = u10
                            [8] = u2
                        --]]
                        if not u45 then
                            u45 = u53.Position
                        end
                        if (u45 - u53.Position).Magnitude <= 1 then
                            return
                        else
                            u45 = u53.Position
                            if u54 == nil then
                                for v59 = -1, 1, 2 do
                                    local v60 = v59 * u23:NextNumber(2.2, 2.75)
                                    local v61
                                    if u54 == nil then
                                        v61 = u35.Position + u35.CFrame.RightVector * v60
                                    else
                                        v61 = (u33.CFrame * CFrame.new(v60, 0, 0)).Position
                                    end
                                    local v62 = -u53.Normal * 10
                                    local v63 = v61 + u53.Normal * 2
                                    local v64 = workspace:Raycast(v63, v62, u10)
                                    if v64 then
                                        local _ = v64.Instance.Color
                                        local _ = v64.Material
                                        local u65 = Instance.new("Part")
                                        u65.Position = v64.Position
                                        u65.Orientation = u23:NextUnitVector() * 360
                                        u65.Size = Vector3.new(1, 1, 1) * u23:NextNumber(0.9, 1.1)
                                        u65.Anchored = true
                                        u65.CanCollide = false
                                        _G.matchMaterial(u65, v64.Instance)
                                        u65.Parent = workspace.Effects
                                        task.delay(1.3, function() --[[ Line: 383 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u2
                                                [2] = u65
                                                [3] = u23
                                            --]]
                                            local u66 = u2:Create(u65, TweenInfo.new(u23:NextNumber(0.4, 0.5)), {
                                                ["Size"] = Vector3.new(0, 0, 0)
                                            })
                                            u66:Play()
                                            u66.Completed:Once(function() --[[ Line: 387 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u66
                                                    [2] = u65
                                                --]]
                                                u66:Destroy()
                                                u65:Destroy()
                                            end)
                                        end)
                                    end
                                end
                            end
                        end
                    end)
                else
                    if u36 then
                        u9(u34.CenterEnd, false)
                        u9(u33.End, not u27)
                    end
                    u44(false)
                    u36 = false
                    local v67 = u33.Position + v52
                    _G.particleEnabled(u34, false)
                    u33.End.Position = v67
                    u33.End.Orientation = u33.Orientation
                    u40.Volume = 0
                    u46 = nil
                end
                if u21 and (u24 == true and u21:IsDescendantOf(game)) then
                    if u53 and u53.Instance then
                        u21:FireServer(CFrame.new(u53.Position))
                        return
                    end
                    u21:FireServer(nil)
                end
            else
                _G.particleEnabled(u34, false)
                u32:Stop()
                if not v51 then
                    u1:PlayAnim(u20, script.Animations.Release)
                end
                for _, v68 in u33.Beams:GetChildren() do
                    if v68:IsA("Beam") then
                        u2:Create(v68, TweenInfo.new(u23:NextNumber(0.25, 0.45)), {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        }):Play()
                    end
                end
                for _, v69 in u33.End.PeakBeams:GetChildren() do
                    if v69:IsA("Beam") then
                        u2:Create(v69, TweenInfo.new(u23:NextNumber(0.25, 0.45)), {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        }):Play()
                    end
                end
                task.delay(0.15, function() --[[ Line: 224 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u9
                        [3] = u34
                        [4] = u33
                        [5] = u44
                    --]]
                    u47:Disconnect()
                    u9(u34, false)
                    u9(u33, false)
                    u44(false)
                end)
                for v70 = 1, #u26 do
                    local v71 = u26[v70]
                    if v71 then
                        _G.tween(v71, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                        _G.destroy(v71, 0.25)
                    end
                end
                _G.PlaySound(u25, script.DragonMiniBoroBreathEnd)
                for _, v72 in u33:GetDescendants() do
                    if v72:IsA("PointLight") then
                        u2:Create(v72, TweenInfo.new(0.65), {
                            ["Brightness"] = 0
                        }):Play()
                    elseif v72:IsA("ParticleEmitter") then
                        v72.Enabled = false
                    elseif v72:IsA("Attachment") then
                        u2:Create(v72, TweenInfo.new(0.25), {
                            ["Position"] = Vector3.new(0, 0, 0)
                        })
                    end
                end
                if v51 == nil then
                    local v73 = script.BurstExplosion:Clone()
                    v73.CFrame = u34.CenterEnd.WorldCFrame
                    v73.Parent = workspace.Effects
                    _G.tween(v73.PointLight, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 25,
                        ["Brightness"] = 0
                    })
                    _G.customEmit(v73)
                    _G.destroy(v73, 5)
                end
                _G.destroy(u33, 1.45)
                _G.destroy(u34, 1.45)
                _G.destroy(u35, 5)
                u46 = nil
                u27 = true
            end
        end
    end)
end
return u1