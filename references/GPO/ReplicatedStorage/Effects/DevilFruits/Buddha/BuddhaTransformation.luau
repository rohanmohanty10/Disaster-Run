 

Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local _ = _G.ToggleInvis
local _ = Enum.EasingStyle
local _ = Enum.EasingDirection
require(script.InitiateVFX)
local v1 = {}
local u2 = Random.new()
local function u4() --[[ Line: 12 ]]
    local v3 = Instance.new("Highlight")
    v3.Enabled = false
    v3.OutlineTransparency = 1
    v3.DepthMode = Enum.HighlightDepthMode.Occluded
    v3.FillTransparency = 1
    v3.OutlineColor = Color3.fromRGB(255, 253, 244)
    v3.FillColor = Color3.fromRGB(255, 255, 253)
    return v3
end
function v1.start(_, u5, p6, p7, p8) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local u9 = u5.Humanoid
    local u10 = u5.PrimaryPart
    local u11 = workspace.CurrentCamera
    local u12 = u5 == game.Players.LocalPlayer.Character
    if p6 == "Half" then
        if p7 == true then
            local u13 = u4()
            u13.Enabled = true
            u13.Parent = u5
            local _, u14, v15 = unpack(p8)
            local u16 = v15 or 0.5
            task.spawn(function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u16
                --]]
                for _ = 1, 6 do
                    Emit(u14.Charge, true)
                    task.wait(u16 / 6)
                end
            end)
            Emit(u14.In, false, u16)
            TweenCreate(u14.Charge.PointLight, TweenInfo.new(u16 * 2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                ["Brightness"] = 2
            })
            TweenCreate(u14.PointLight, TweenInfo.new(u16 * 2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                ["Brightness"] = 2
            })
            TweenCreate(u13, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            })
            task.delay(u16, function() --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                tick()
                local v17 = u5:GetPivot()
                u5.Archivable = true
                local u18 = script.CharClone:Clone()
                u18.PrimaryPart.Anchored = true
                local v19 = u18.AnimationController
                local v20 = u18.PrimaryPart
                for _, u21 in u18:GetDescendants() do
                    if u21:IsA("BasePart") and u21 ~= u18.PrimaryPart then
                        for _, v22 in u21:GetDescendants() do
                            if v22:IsA("Decal") or v22:IsA("Attachment") then
                                v22:Destroy()
                            end
                        end
                        u21.Color = Color3.new(1, 0.91722, 0.42237)
                        u21.Material = Enum.Material.Neon
                        TweenCreate(u21, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 0
                        })
                        task.delay(0.2, function() --[[ Line: 111 ]]
                            --[[
                            Upvalues:
                                [1] = u21
                            --]]
                            TweenCreate(u21, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {
                                ["Transparency"] = 1
                            })
                        end)
                    end
                end
                u18:ScaleTo(1)
                u18:PivotTo(v17 * CFrame.new(0, -1.5, 0))
                local v23 = Instance.new("Highlight")
                v23.Enabled = false
                v23.OutlineTransparency = 1
                v23.DepthMode = Enum.HighlightDepthMode.Occluded
                v23.FillTransparency = 1
                v23.OutlineColor = Color3.fromRGB(255, 241, 184)
                v23.FillColor = Color3.fromRGB(255, 254, 210)
                v23.Parent = u18
                u18.Parent = workspace.Effects
                TweenCreate(u18.Highlight, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["FillTransparency"] = 0.15,
                    ["OutlineTransparency"] = 0
                })
                task.delay(0.15, function() --[[ Line: 142 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    TweenCreate(u18.Highlight, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["FillTransparency"] = 1,
                        ["OutlineTransparency"] = 1
                    })
                end)
                TweenCreate(v20, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CFrame"] = v20.CFrame * CFrame.new(0, 1, 0)
                })
                task.spawn(function() --[[ Line: 157 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    local v24 = tick()
                    repeat
                        local v25 = (tick() - v24) / 0.45
                        u18:ScaleTo(1 + game.TweenService:GetValue(v25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) * 2)
                        task.wait()
                    until u18.Head.Transparency >= 1
                    u18:Destroy()
                end)
                local v26 = v19.Animator:LoadAnimation(script.Animations.Hybird)
                v26:Play(0.01, 1, 1)
                v26.TimePosition = 0.5333333333333333
                v26:AdjustWeight(5)
                u5.Archivable = false
            end)
            task.delay(u16, function() --[[ Line: 180 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u5
                    [3] = u2
                --]]
                task.delay(0.7, u13.Destroy, u13)
                TweenCreate(u13, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["FillTransparency"] = 1,
                    ["OutlineTransparency"] = 1
                })
                local v27, v28, _ = _G.getRayFloor(u5.PrimaryPart.CFrame, 25)
                if v27 then
                    local v29 = script.Half.ShockMedium:Clone()
                    v29:PivotTo(CFrame.new(v28 + Vector3.new(0, 2, 0)))
                    v29.Parent = workspace.Effects
                    Emit(v29:GetDescendants(), true)
                    task.delay(0.9, v29.Destroy, v29)
                    for _ = 1, 3 do
                        task.wait(0.05)
                        local v30 = script.Wind2:Clone()
                        v30.CFrame = CFrame.new(v28 + Vector3.new(0, 2, 0)) * CFrame.Angles(0, u2:NextNumber(0, 3.141592653589793), 0)
                        v30.Parent = workspace.Effects
                        local v31 = u2:NextInteger(5, 12)
                        TweenCreate(v30.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            ["Scale"] = v30.Mesh.Scale + Vector3.new(v31, 3, v31)
                        })
                        TweenCreate(v30.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0.1), {
                            ["Transparency"] = 1
                        })
                        TweenCreate(v30, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            ["CFrame"] = v30.CFrame * CFrame.Angles(0, 120, 0)
                        })
                        task.delay(0.7, v30.Destroy, v30)
                    end
                end
            end)
        else
            local v32, _ = unpack(p8)
            local v33 = v32.Transformation
            v32.Parent = workspace.Effects
            for _, v34 in v32:GetDescendants() do
                if v34:IsA("ParticleEmitter") then
                    v34:Clear()
                end
            end
            local v35 = u4()
            v35.Parent = u5
            v35.Enabled = true
            Emit(v33.Out, true)
            Emit(v32.Enable, false)
            TweenCreate(v33.Charge.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 0
            })
            TweenCreate(v33.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 0
            })
            TweenCreate(v35, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            })
            TweenCreate(v35, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            })
            task.delay(1, v35.Destroy, v35)
        end
    else
        if p6 == "Full" and p7 == true then
            local _, u36, u37, _, _ = unpack(p8)
            local u38 = u9.Animator:LoadAnimation(script.Animations.Full)
            u38:Play(0.1, 1, 1)
            local u39 = script.Full.PT2:Clone()
            local u40 = u4()
            local v41 = script.Full.CameraSubject:Clone()
            v41:PivotTo(u5:GetPivot() + Vector3.new(0, 1, 0))
            u36:PivotTo(u5:GetPivot())
            u40.Enabled = true
            v41.Parent = workspace.Effects
            u40.Parent = u5
            task.spawn(function() --[[ Line: 297 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u37
                --]]
                local v42 = {}
                for _, v43 in u36.In:GetChildren() do
                    local v44 = v43.Size
                    local v45 = {}
                    if not v42[v43.Name] then
                        v42[v43.Name] = v44
                    end
                    for _, v46 in v43.Size.Keypoints do
                        v45[#v45 + 1] = NumberSequenceKeypoint.new(v46.Time, v46.Value * 3, v46.Envelope)
                    end
                    _G.tween(v43, { u37, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }, {
                        ["Size"] = NumberSequence.new(v45)
                    })
                end
                for _ = 1, 6 do
                    Emit(u36.Charge, true)
                    for _, v47 in u36.Charge:GetChildren() do
                        local v48 = v47.Size
                        local v49 = {}
                        if not v42[v47.Name] then
                            v42[v47.Name] = v48
                        end
                        for _, v50 in v47.Size.Keypoints do
                            v49[#v49 + 1] = NumberSequenceKeypoint.new(v50.Time, v50.Value * 1.05, v50.Envelope)
                        end
                        v47.Size = NumberSequence.new(v49)
                    end
                    task.wait(u37 / 6)
                end
            end)
            Emit(u36.In, false, u37)
            Emit(u36, false, u37)
            TweenCreate(u36.In, TweenInfo.new(u37, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ["WorldCFrame"] = u36.In.WorldCFrame * CFrame.new(0, 20, 0)
            })
            TweenCreate(v41, TweenInfo.new(u37, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ["Position"] = v41.Position + Vector3.new(0, 34, 0)
            })
            TweenCreate(u40, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            })
            if u12 == true then
                u11.CameraType = Enum.CameraType.Track
                u11.CameraSubject = v41
            end
            u10.Anchored = true
            task.delay(0, function() --[[ Line: 366 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u10
                    [3] = u2
                    [4] = u37
                --]]
                tick()
                local v51 = u5:GetPivot()
                u5.Archivable = true
                local u52 = 3
                for v53 = 1, 6 do
                    u52 = u52 + v53 / 6 * 1.75
                    local u54 = script.CharClone:Clone()
                    u54.PrimaryPart.Anchored = true
                    local v55 = u54.AnimationController
                    local v56 = u54.PrimaryPart
                    for _, u57 in u54:GetDescendants() do
                        if u57:IsA("BasePart") and u57 ~= u54.PrimaryPart then
                            for _, v58 in u57:GetDescendants() do
                                if v58:IsA("Decal") or v58:IsA("Attachment") then
                                    v58:Destroy()
                                end
                            end
                            TweenCreate(u57, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Transparency"] = 0.5
                            })
                            task.delay(0.6, function() --[[ Line: 411 ]]
                                --[[
                                Upvalues:
                                    [1] = u57
                                --]]
                                TweenCreate(u57, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false), {
                                    ["Color"] = Color3.new(0.682353, 0.615686, 0.286275),
                                    ["Transparency"] = 1
                                })
                            end)
                        end
                    end
                    u54:ScaleTo(u52)
                    u54:PivotTo(v51 * CFrame.new(0, u52 * 1.5, 0))
                    u54.Parent = workspace.Effects
                    TweenCreate(v56, TweenInfo.new(0.39999999999999997, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ["CFrame"] = v56.CFrame * CFrame.new(0, u52 * 2 - 3, 0)
                    })
                    v55.Animator:LoadAnimation(script.Animations.Full):Play(0.1, 1, u52 / 3)
                    local v59, v60, _ = _G.getRayFloor(u10.CFrame, 50)
                    if v59 then
                        local v61 = script.Wind2:Clone()
                        v61.Decal.Transparency = 0.15
                        local v62 = v61.Mesh
                        v62.Scale = v62.Scale * (u52 / 2)
                        v61.Size = Vector3.new(10, 0.1, 10) * u52
                        v61.CFrame = CFrame.new(v60) * CFrame.Angles(0, u2:NextNumber(0, 3.141592653589793), 0)
                        v61.Parent = workspace.Effects
                        TweenCreate(v61.Mesh, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Scale"] = v61.Mesh.Scale + Vector3.new(25, 7.5, 25)
                        })
                        TweenCreate(v61.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
                            ["Transparency"] = 1
                        })
                        TweenCreate(v61, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["CFrame"] = v61.CFrame * CFrame.Angles(0, 2.0943951023931953, 0) + Vector3.new(0, -2, 0)
                        })
                        v61.Trails.Speed = NumberRange.new(u52 * 15, u52 * 45)
                        v61.Trails.Enabled = true
                        _G.destroy(v61, 1)
                    end
                    task.spawn(function() --[[ Line: 457 ]]
                        --[[
                        Upvalues:
                            [1] = u54
                            [2] = u52
                        --]]
                        local v63 = tick()
                        repeat
                            u54:ScaleTo(u52 + (tick() - v63) / 0.6 * 2)
                            task.wait()
                        until u54.Head.Transparency >= 1
                        u54:Destroy()
                    end)
                    task.wait(u37 / 6 * 1 / 1.5)
                end
                u5.Archivable = false
            end)
            task.delay(u37, function() --[[ Line: 481 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u36
                    [3] = u5
                    [4] = u10
                    [5] = u12
                    [6] = u11
                    [7] = u9
                    [8] = u40
                    [9] = u39
                    [10] = u2
                --]]
                task.delay(0.25, u38.AdjustSpeed, u38, 0.5)
                task.delay(1.5, u38.Stop, u38, 0.25)
                u36.In.Trails2:Emit(50)
                for _, v64 in u5:GetDescendants() do
                    if v64:IsA("BasePart") then
                        local v65 = u36.In.Stars:Clone()
                        v65.Speed = NumberRange.new(0)
                        v65.Enabled = false
                        v65.Parent = v64
                        v65:Emit(1)
                        _G.destroy(v65, 1)
                    end
                end
                task.delay(0.4, function() --[[ Line: 508 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u12
                        [3] = u11
                        [4] = u9
                    --]]
                    u10.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    u10.Anchored = false
                    if u12 == true then
                        u11.CameraType = Enum.CameraType.Custom
                        u11.CameraSubject = u9
                    end
                end)
                TweenCreate(u40, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ["FillTransparency"] = 1,
                    ["OutlineTransparency"] = 1
                })
                TweenCreate(u36.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ["Brightness"] = 5,
                    ["Range"] = 60
                })
                for _, v66 in u39:GetChildren() do
                    if v66:IsA("BasePart") then
                        local v67 = v66:Clone()
                        v67:PivotTo(u5:GetPivot())
                        v67.Parent = workspace.Effects
                        local v68
                        if v67.Name == "Ball" or v67.Name == "ForceField" then
                            v68 = v67.Size
                            v67.Size = Vector3.new(0, 0, 0)
                        else
                            v68 = v67.Mesh.Scale + Vector3.new(25, 5, 25)
                            local v69 = v67.Mesh
                            local v70 = v67.Mesh.Scale.Y
                            v69.Scale = Vector3.new(0, v70, 0)
                        end
                        if v67.Name == "Glow" then
                            TweenCreate(v67.Mesh, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v68 + Vector3.new(15, 0, 15)
                            })
                            TweenCreate(v67.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0.1), {
                                ["Transparency"] = 1
                            })
                        elseif v67.Name == "Ring2" then
                            TweenCreate(v67.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v68
                            })
                            TweenCreate(v67.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                                ["Transparency"] = 1
                            })
                        elseif v67.Name == "Cone" then
                            TweenCreate(v67.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v68
                            })
                            TweenCreate(v67.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), {
                                ["Transparency"] = 1
                            })
                        elseif v67.Name == "Ball" then
                            TweenCreate(v67, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Transparency"] = 1,
                                ["Size"] = v68 * 7
                            })
                        elseif v67.Name == "ForceField" then
                            TweenCreate(v67, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Transparency"] = 1,
                                ["Size"] = v68 * 10
                            })
                        else
                            TweenCreate(v67.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v68
                            })
                            TweenCreate(v67.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Transparency"] = 1
                            })
                        end
                    end
                end
                local v71, v72, _ = _G.getRayFloor(u10.CFrame, 50)
                if v71 then
                    local v73 = script.Full.ShockBig:Clone()
                    v73:PivotTo(CFrame.new(v72 + Vector3.new(0, 5, 0)))
                    v73.Parent = workspace.Effects
                    local v74 = script.Wind2:Clone()
                    v74.Decal.Transparency = 0.15
                    local v75 = v74.Mesh
                    v75.Scale = v75.Scale * 2
                    v74.CFrame = CFrame.new(v72 + Vector3.new(0, 4, 0)) * CFrame.Angles(0, u2:NextNumber(0, 3.141592653589793), 0)
                    v74.Parent = workspace.Effects
                    Emit(v73:GetDescendants(), true)
                    TweenCreate(v74.Mesh, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Scale"] = v74.Mesh.Scale + Vector3.new(50, 15, 50)
                    })
                    TweenCreate(v74.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
                        ["Transparency"] = 1
                    })
                    TweenCreate(v74, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["CFrame"] = v74.CFrame * CFrame.Angles(0, 2.0943951023931953, 0) + Vector3.new(0, -2, 0)
                    })
                    task.delay(0.9, v73.Destroy, v73)
                    task.delay(0.7, v74.Destroy, v74)
                end
                task.delay(2.5, u39.Destroy, u39)
                task.delay(2, u40.Destroy, u40)
            end)
            if u5 == game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.CameraMaxZoomDistance = 150
            end
        end
        return
    end
end
return v1