 

local u1 = _G.Emit
local u2 = _G.Ess.Tween
local u3 = Random.new()
local function u5() --[[ Line: 6 ]]
    local v4 = Instance.new("Highlight")
    v4.Enabled = false
    v4.OutlineTransparency = 1
    v4.DepthMode = Enum.HighlightDepthMode.Occluded
    v4.FillTransparency = 1
    v4.OutlineColor = Color3.fromRGB(255, 253, 244)
    v4.FillColor = Color3.fromRGB(255, 255, 253)
    return v4
end
local u63 = {
    ["Half"] = function(p6, p7, _, _, p8) --[[ Name: Half, Line 71 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u1
            [3] = u2
        --]]
        local v9 = p6.PrimaryPart
        local v10 = p6.Humanoid
        if p7 then
            local v11 = p7.Transformation
            p7.Parent = workspace.Effects
            for _, v12 in p7:GetDescendants() do
                if v12:IsA("ParticleEmitter") then
                    v12:Clear()
                end
            end
            local v13 = u5()
            v13.Parent = p6
            v13.Enabled = true
            u1(v11.Out, true)
            u1(p7.Enable, false)
            u2(v11.Charge.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 0
            })
            u2(v11.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 0
            })
            u2(v13, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            })
            u2(v13, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            })
            task.delay(1, v13.Destroy, v13)
            _G.destroy(p7, 3)
        else
            v10.Animator:LoadAnimation(_G.AnimationsFolder.HalfForm.Transform):Play(0.01, 1, 1)
            local v14 = p8 or 0.5
            local v15 = script.Half.Aura:Clone()
            local v16 = script.Half.Transformation:Clone()
            v15.RigidConstraint.Attachment1 = v9.RootRigAttachment
            v16.RigidConstraint.Attachment1 = v15.RigidConstraint.Attachment1
            v16.PointLight.Brightness = 0
            v16.Charge.PointLight.Brightness = 0
            v15.Parent = p6
            v16.Parent = v15
            u2(v16.Charge.PointLight, TweenInfo.new(v14 * 2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                ["Brightness"] = 2
            })
            u2(v16.PointLight, TweenInfo.new(v14 * 2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                ["Brightness"] = 2
            })
            task.delay(v14, function() --[[ Line: 150 ]] end)
        end
    end,
    ["Full"] = function(u17, p18, _, _) --[[ Name: Full, Line 159 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u5
            [4] = u3
        --]]
        local u19 = u17.Humanoid
        local u20 = u17.PrimaryPart
        local u21 = workspace.CurrentCamera
        if p18 then
            local v22 = p18.Transformation
            p18.RigidConstraint.Enabled = false
            p18.Anchored = true
            v22.Parent = workspace.Effects
            p18.Parent = workspace.Effects
            local v23 = workspace:Raycast(u20.Position + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), _G.RaycastParams)
            if v23 then
                u1(v22.Out, true)
                p18:PivotTo(CFrame.new(v23.Position))
            end
            u1(p18:GetDescendants(), false)
            u2(v22.PointLight, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 0
            })
            task.delay(2, p18.Destroy, p18)
        else
            local u24 = u19.Animator:LoadAnimation(_G.AnimationsFolder.FullForm.Pose)
            u24:Play(0.1, 1, 1)
            local u25 = script.Full.PT2:Clone()
            local u26 = script.Full.Aura:Clone()
            local u27 = script.Full.Transformation:Clone()
            local u28 = u5()
            local v29 = script.Full.CameraSubject:Clone()
            u26.RigidConstraint.Attachment1 = u20.RootRigAttachment
            u27.RigidConstraint.Attachment1 = u26.RigidConstraint.Attachment0
            v29:PivotTo(u17:GetPivot() + Vector3.new(0, 1, 0))
            u27:PivotTo(u17:GetPivot())
            u28.Enabled = true
            v29.Parent = workspace.Effects
            u27.Parent = workspace.Effects
            u26.Parent = u17
            u28.Parent = u17
            task.spawn(function() --[[ Line: 223 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u1
                --]]
                local v30 = {}
                for _, v31 in u27.In:GetChildren() do
                    local v32 = v31.Size
                    local v33 = {}
                    if not v30[v31.Name] then
                        v30[v31.Name] = v32
                    end
                    for _, v34 in v31.Size.Keypoints do
                        v33[#v33 + 1] = NumberSequenceKeypoint.new(v34.Time, v34.Value * 3, v34.Envelope)
                    end
                    _G.tween(v31, { 2.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }, {
                        ["Size"] = NumberSequence.new(v33)
                    })
                end
                for _ = 1, 6 do
                    u1(u27.Charge, true)
                    for _, v35 in u27.Charge:GetChildren() do
                        local v36 = v35.Size
                        local v37 = {}
                        if not v30[v35.Name] then
                            v30[v35.Name] = v36
                        end
                        for _, v38 in v35.Size.Keypoints do
                            v37[#v37 + 1] = NumberSequenceKeypoint.new(v38.Time, v38.Value * 1.05, v38.Envelope)
                        end
                        v35.Size = NumberSequence.new(v37)
                    end
                    task.wait(0.35833333333333334)
                end
            end)
            u1(u27.In, false, 2.15)
            u1(u27, false, 2.15)
            u2(u27.In, TweenInfo.new(2.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ["WorldCFrame"] = u27.In.WorldCFrame * CFrame.new(0, 16, 0)
            })
            u2(v29, TweenInfo.new(2.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ["Position"] = v29.Position + Vector3.new(0, 34, 0)
            })
            u2(u28, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            })
            u21.CameraType = Enum.CameraType.Track
            u21.CameraSubject = v29
            u20.Anchored = true
            task.delay(0, function() --[[ Line: 290 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u2
                --]]
                tick()
                local v39 = u17:GetPivot()
                u17.Archivable = true
                local u40 = 2
                for v41 = 1, 6 do
                    u40 = u40 + v41 / 6 * 1.5
                    local u42 = script.CharClone:Clone()
                    u42.PrimaryPart.Anchored = true
                    local v43 = u42.AnimationController
                    local v44 = u42.PrimaryPart
                    for _, u45 in u42:GetDescendants() do
                        if u45:IsA("BasePart") and u45 ~= u42.PrimaryPart then
                            for _, v46 in u45:GetDescendants() do
                                if v46:IsA("Decal") or v46:IsA("Attachment") then
                                    v46:Destroy()
                                end
                            end
                            u2(u45, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Transparency"] = 0.5
                            })
                            task.delay(0.6, function() --[[ Line: 341 ]]
                                --[[
                                Upvalues:
                                    [1] = u2
                                    [2] = u45
                                --]]
                                u2(u45, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false), {
                                    ["Color"] = Color3.new(0.682353, 0.615686, 0.286275),
                                    ["Transparency"] = 1
                                })
                            end)
                        end
                    end
                    u42:ScaleTo(u40)
                    u42:PivotTo(v39 * CFrame.new(0, u40 * 1.5, 0))
                    u42.Parent = workspace.Effects
                    u2(v44, TweenInfo.new(0.39999999999999997, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ["CFrame"] = v44.CFrame * CFrame.new(0, u40 * 2 - 3, 0)
                    })
                    task.spawn(function() --[[ Line: 360 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                            [2] = u40
                        --]]
                        local v47 = tick()
                        repeat
                            u42:ScaleTo(u40 + (tick() - v47) / 0.6 * 2)
                            task.wait()
                        until u42.Head.Transparency >= 1
                        u42:Destroy()
                    end)
                    v43.Animator:LoadAnimation(_G.AnimationsFolder.FullForm.Pose):Play(0.1, 1, u40 / 3)
                    task.wait(0.2388888888888889)
                end
                u17.Archivable = false
            end)
            task.delay(2.15, function() --[[ Line: 387 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u27
                    [3] = u26
                    [4] = u20
                    [5] = u21
                    [6] = u19
                    [7] = u2
                    [8] = u28
                    [9] = u25
                    [10] = u17
                    [11] = u3
                    [12] = u1
                --]]
                task.delay(0.25, u24.AdjustSpeed, u24, 0.5)
                task.delay(1.5, u24.Stop, u24, 0.25)
                u27.Parent = u26
                task.delay(0.4, function() --[[ Line: 397 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u21
                        [3] = u19
                    --]]
                    u20.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    u20.Anchored = false
                    u21.CameraType = Enum.CameraType.Custom
                    u21.CameraSubject = u19
                end)
                u2(u28, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ["FillTransparency"] = 1,
                    ["OutlineTransparency"] = 1
                })
                u2(u27.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ["Brightness"] = 0,
                    ["Range"] = 25
                })
                for _, v48 in u25:GetChildren() do
                    if v48:IsA("BasePart") then
                        local v49 = v48:Clone()
                        v49:PivotTo(u17:GetPivot())
                        v49.Parent = workspace.Effects
                        local v50
                        if v49.Name == "Ball" or v49.Name == "ForceField" then
                            v50 = v49.Size
                            v49.Size = Vector3.new(0, 0, 0)
                        else
                            v50 = v49.Mesh.Scale + Vector3.new(25, 5, 25)
                            local v51 = v49.Mesh
                            local v52 = v49.Mesh.Scale.Y
                            v51.Scale = Vector3.new(0, v52, 0)
                        end
                        if v49.Name == "Glow" then
                            u2(v49.Mesh, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v50 + Vector3.new(15, 0, 15)
                            })
                            u2(v49.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0.1), {
                                ["Transparency"] = 1
                            })
                        elseif v49.Name == "Ring2" then
                            u2(v49.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v50
                            })
                            u2(v49.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                                ["Transparency"] = 1
                            })
                        elseif v49.Name == "Cone" then
                            u2(v49.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v50
                            })
                            u2(v49.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), {
                                ["Transparency"] = 1
                            })
                        elseif v49.Name == "Ball" then
                            u2(v49, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Transparency"] = 1,
                                ["Size"] = v50 * 5
                            })
                        elseif v49.Name == "ForceField" then
                            u2(v49, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Transparency"] = 1,
                                ["Size"] = v50 * 15
                            })
                        else
                            u2(v49.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Scale"] = v50
                            })
                            u2(v49.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                                ["Transparency"] = 1
                            })
                        end
                    end
                end
                local v53 = workspace:Raycast(u20.Position, Vector3.new(0, -45, 0), _G.RaycastParams)
                if v53 then
                    local v54 = script.Full.ShockBig:Clone()
                    v54:PivotTo(CFrame.new(v53.Position + Vector3.new(0, 5, 0)))
                    v54.Parent = workspace.Effects
                    local v55 = script.Wind2:Clone()
                    v55.Decal.Transparency = 0.15
                    local v56 = v55.Mesh
                    v56.Scale = v56.Scale * 2
                    v55.CFrame = CFrame.new(v53.Position + Vector3.new(0, 4, 0)) * CFrame.Angles(0, u3:NextNumber(0, 3.141592653589793), 0)
                    v55.Parent = workspace.Effects
                    u1(v54:GetDescendants(), true)
                    u2(v55.Mesh, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Scale"] = v55.Mesh.Scale + Vector3.new(50, 15, 50)
                    })
                    u2(v55.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
                        ["Transparency"] = 1
                    })
                    u2(v55, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["CFrame"] = v55.CFrame * CFrame.Angles(0, 2.0943951023931953, 0) + Vector3.new(0, -2, 0)
                    })
                    task.delay(0.9, v54.Destroy, v54)
                    task.delay(0.7, v55.Destroy, v55)
                end
                task.delay(2.5, u25.Destroy, u25)
                task.delay(2, u28.Destroy, u28)
            end)
        end
    end,
    ["Transformation"] = function(p57, p58, p59, p60, p61, p62) --[[ Name: Transformation, Line 535 ]]
        --[[
        Upvalues:
            [1] = u63
        --]]
        if p57:GetScale() > 1 and p59 then
            p57:PivotTo(p57:GetPivot() * CFrame.new(0, -2.4 * p57:GetScale(), 0))
            u63[p58](p57, p59, p60, p61, p62)
        else
            u63[p58](p57, p59, p60, p61, p62)
        end
    end
}
return u63