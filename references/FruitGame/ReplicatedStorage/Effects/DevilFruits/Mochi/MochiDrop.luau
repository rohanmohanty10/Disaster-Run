 

local function u8(p1, p2, p3, p4) --[[ Line: 9 ]]
    if typeof(p1) == "Vector3" then
        p1 = CFrame.new(p1) or p1
    end
    local v5 = 6.283185307179586 / p4 * p3
    local v6 = p2 * math.cos(v5)
    local v7 = p2 * math.sin(v5)
    return p1:ToWorldSpace(CFrame.new(v6, 0, v7))
end
Emit = _G.Emit
return {
    ["start"] = function(_, p9, p10, p11, p12) --[[ Name: start, Line 25 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if p11 and game.Players.LocalPlayer == p11 then
            return
        elseif _G.checkRenderDistance(p9) then
            local u13 = Random.new()
            if p12 then
                local u14 = p10 * 0.15
                local u15 = script.MochiThing:Clone()
                u15.Size = Vector3.new()
                local v16 = u15.RigidConstraint.Attachment0
                local v17 = u13:NextNumber(-360, 360)
                local v18 = u13:NextNumber(-360, 360)
                v16.Orientation = Vector3.new(v17, v18, u13:NextNumber(-360, 360))
                u15.RigidConstraint.Attachment1 = p12
                u15.Parent = workspace.Effects
                _G.tween(u15, {
                    0.5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(2, 2, 2)
                })
                task.delay(u14 * 0.8, function() --[[ Line: 237 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                        [2] = u14
                    --]]
                    _G.tween(u15, {
                        u14 * 0.5,
                        "Quad",
                        Enum.EasingDirection.In,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = Vector3.new(),
                        ["Transparency"] = 1
                    })
                end)
                local v19 = u15.AnimationController
                local u20 = v19.Animator:LoadAnimation(v19.Animation)
                u20:Play()
                u20:AdjustSpeed(10)
                task.delay(u14 * 1.5, function() --[[ Line: 249 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u15
                    --]]
                    u20:Destroy()
                    u15:Destroy()
                    u15 = nil
                end)
            else
                local v21 = script.Sounds
                local u22 = v21.Shoot:GetChildren()
                local u23 = v21.Hit:GetChildren()
                local v24 = v21.MochiFountainStart
                local v25 = CFrame.new(p9)
                _G.PlaySound(v25, v24, nil, true)
                local function u31(p26) --[[ Line: 85 ]]
                    local v27 = workspace:Raycast(p26 + Vector3.new(0, 5, 0), Vector3.new(0, -20, 0), _G.RayParams)
                    if v27 then
                        p26 = v27.Position
                    end
                    local v28 = not v27 and Vector3.new(0, 1, 0) or v27.Normal
                    if v27 then
                        local u29 = script.BeanWind:Clone()
                        u29.CFrame = CFrame.new(p26, p26 + v28) * CFrame.Angles(1.5707963267948966, 0, 0)
                        local v30 = u29.Mesh
                        v30.Scale = v30.Scale / 2.5
                        u29.Parent = workspace.Effects
                        _G.tween(u29.Mesh, {
                            0.5,
                            "Cubic",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Scale"] = u29.Mesh.Scale * Vector3.new(1.5, 1.2, 1.5)
                        })
                        _G.tween(u29.Decal, {
                            0.5,
                            "Quad",
                            Enum.EasingDirection.InOut,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1
                        })
                        task.delay(0.4, function() --[[ Line: 104 ]]
                            --[[
                            Upvalues:
                                [1] = u29
                            --]]
                            u29:Destroy()
                        end)
                    end
                end
                local function u40(p32) --[[ Line: 44 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                    --]]
                    local v33 = u13:NextInteger(6, 10)
                    local v34 = (CFrame.new(p32) * CFrame.Angles(0, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, -v33)).Position
                    local v35 = workspace:Raycast(v34 + Vector3.new(0, 5, 0), Vector3.new(0, -20, 0), _G.RayParams)
                    if v35 then
                        v34 = v35.Position
                    end
                    local v36 = not v35 and Vector3.new(0, 1, 0) or v35.Normal
                    if v35 then
                        local u37 = script.sphere:Clone()
                        u37.CFrame = CFrame.new(v34, v34 + v36) * CFrame.Angles(1.5707963267948966, 0, 0)
                        u37.Size = Vector3.new()
                        u37.Parent = workspace.Effects
                        local v38 = u13:NextNumber(0.25, 0.35)
                        _G.tween(u37, {
                            v38,
                            "Sine",
                            Enum.EasingDirection.In,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 0.4
                        })
                        _G.tween(u37, {
                            v38,
                            "Back",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Size"] = Vector3.new(1, 1, 1) * u13:NextNumber(1.25, 1.8) * Vector3.new(1, 0.5, 1)
                        })
                        task.delay(u13:NextNumber(0.6, 1.2), function() --[[ Line: 73 ]]
                            --[[
                            Upvalues:
                                [1] = u13
                                [2] = u37
                            --]]
                            local v39 = u13:NextNumber(0.4, 0.6)
                            _G.tween(u37, {
                                v39,
                                "Quad",
                                Enum.EasingDirection.InOut,
                                0,
                                false,
                                0
                            }, {
                                ["Transparency"] = 1,
                                ["Size"] = Vector3.new()
                            })
                            task.delay(v39, function() --[[ Line: 80 ]]
                                --[[
                                Upvalues:
                                    [1] = u37
                                --]]
                                u37:Destroy()
                            end)
                        end)
                    end
                end
                for v41 = 1, p10 do
                    local u42 = u8(v25, 4, v41, p10)
                    local u43 = u8(v25, 20, v41, p10)
                    local v44 = workspace:Raycast(u42.Position + Vector3.new(0, 8, 0), Vector3.new(0, -20, 0), _G.RayParams)
                    local u45
                    if v44 then
                        u45 = v44.Normal
                    else
                        u45 = Vector3.new()
                    end
                    local u46 = workspace:Raycast(u43.Position + Vector3.new(0, 8, 0), Vector3.new(0, -20, 0), _G.RayParams)
                    local u47
                    if u46 then
                        u47 = u46.Normal
                    else
                        u47 = Vector3.new()
                    end
                    local u48
                    if u46 then
                        u48 = u46.Position
                    else
                        u48 = u43.Position
                    end
                    if u46 then
                        local v49 = (u46.Position - u43.Position).Magnitude
                        if u46.Position.Y < u43.Position.Y then
                            v49 = -v49
                        end
                        u43 = u43 + Vector3.new(0, v49, 0)
                    end
                    local _ = (u43.Position - u42.Position).Magnitude
                    local v50 = CFrame.new(u42.Position, u43.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                    task.delay(0.25, function() --[[ Line: 132 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                            [2] = u45
                            [3] = u22
                            [4] = u13
                        --]]
                        local u51 = script.Part:Clone()
                        u51.CFrame = CFrame.new(u42.Position, u42.Position + u45) * CFrame.Angles(1.5707963267948966, 0, 0)
                        u51.Parent = workspace.Effects
                        Emit(u51.Attachment, true)
                        Emit(u51, true)
                        _G.PlaySound(u51, u22[u13:NextInteger(1, #u22)], nil, true)
                        task.delay(2.2, function() --[[ Line: 141 ]]
                            --[[
                            Upvalues:
                                [1] = u51
                            --]]
                            u51:Destroy()
                        end)
                    end)
                    tick()
                    local u52 = script.MochiStick:Clone()
                    local u53 = u52.Drop
                    local v54 = u52.AnimationController
                    local u55 = u53.MochiStickStrand
                    local u56 = u53.Attachment
                    u52:PivotTo(v50 + Vector3.new(0, 35, 0))
                    u52.Parent = workspace.Effects
                    u53.CFrame = v50 + Vector3.new(0, -20, 0)
                    local u57 = v54:LoadAnimation(v54.Animation)
                    u57:Play(0, 1, 0.9)
                    _G.tween(u53, {
                        u57.Length / 4 / u57.Speed,
                        "Cubic",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = u53.CFrame + Vector3.new(0, 34.5, 0)
                    })
                    u57:GetMarkerReachedSignal("Peak"):Connect(function() --[[ Line: 165 ]]
                        --[[
                        Upvalues:
                            [1] = u57
                            [2] = u43
                            [3] = u48
                            [4] = u53
                        --]]
                        u57:AdjustSpeed(1.25)
                        local v58 = (u43.Position.Y - u48.Y) * 2
                        local v59 = _G.tween
                        local v60 = u53
                        local v61 = {
                            u57.Length / 4 / u57.Speed,
                            "Sine",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }
                        local v62 = {}
                        local v63 = u53.CFrame
                        local v64 = -v58
                        v62.CFrame = v63 + Vector3.new(0, v64, 0)
                        v59(v60, v61, v62)
                    end)
                    u57:GetMarkerReachedSignal("End"):Connect(function() --[[ Line: 175 ]]
                        --[[
                        Upvalues:
                            [1] = u57
                            [2] = u56
                            [3] = u53
                            [4] = u55
                            [5] = u48
                            [6] = u47
                            [7] = u46
                            [8] = u23
                            [9] = u13
                            [10] = u31
                            [11] = u40
                            [12] = u52
                        --]]
                        task.delay(0.25, function() --[[ Line: 176 ]]
                            --[[
                            Upvalues:
                                [1] = u57
                            --]]
                            u57:AdjustSpeed(0)
                        end)
                        Emit(u56, false)
                        _G.tween(u53, {
                            0.4,
                            "Cubic",
                            Enum.EasingDirection.In,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1
                        })
                        local v65 = u55.TransformedWorldCFrame.Position * Vector3.new(1, 0, 1)
                        local v66 = u48.Y
                        local v67 = v65 + Vector3.new(0, v66, 0)
                        local u68 = script.Impact:Clone()
                        u68.CFrame = CFrame.new(v67, v67 + u47) * CFrame.Angles(1.5707963267948966, 0, 0)
                        if u46 and u46.Instance ~= nil then
                            u68.Attachment.Rocks.Color = ColorSequence.new(u46.Instance.Color)
                            u68.Attachment.sm2.Color = u68.Attachment.Rocks.Color
                        else
                            u68.Attachment.sm2:Destroy()
                            u68.Attachment.Rocks:Destroy()
                        end
                        u68.Parent = workspace.Effects
                        Emit(u68.Attachment, true)
                        Emit(u68, true)
                        _G.PlaySound(u68, u23[u13:NextInteger(1, #u23)], nil, true)
                        _G.shakenear(u68.Position, 75, 35, 70, -1)
                        _G.PlayEffect("GroundRocks2", nil, CFrame.new(u68.Position + Vector3.new(0, 3, 0)), 15, 10, 1, 0, 10)
                        task.delay(2.6, function() --[[ Line: 203 ]]
                            --[[
                            Upvalues:
                                [1] = u68
                            --]]
                            u68:Destroy()
                        end)
                        task.spawn(u31, u55.TransformedWorldCFrame.Position + Vector3.new(0, 3, 0))
                        for _ = 1, 5 do
                            task.spawn(u40, u55.TransformedWorldCFrame.Position + Vector3.new(0, 3, 0))
                        end
                        task.delay(1, function() --[[ Line: 208 ]]
                            --[[
                            Upvalues:
                                [1] = u52
                                [2] = u57
                            --]]
                            u52:Destroy()
                            u57:Destroy()
                        end)
                    end)
                    task.spawn(function() --[[ Line: 211 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                            [2] = u56
                            [3] = u55
                        --]]
                        while u52:IsDescendantOf(workspace) do
                            u56.WorldCFrame = u55.TransformedWorldCFrame
                            game["Run Service"].RenderStepped:Wait()
                        end
                    end)
                    task.wait(0.25)
                end
            end
        else
            return
        end
    end
}