 

Emit = _G.Emit
TweenCreate = _G.tween
local u1 = RaycastParams.new()
u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u1.FilterType = Enum.RaycastFilterType.Whitelist
return {
    ["start"] = function(_, p2, u3, u4, p5, p6) --[[ Name: start, Line 16 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p6 and game.Players.LocalPlayer == p6 then
            return
        elseif _G.checkRenderDistance(p2) then
            local u7 = Random.new()
            local u8 = CFrame.new(p2)
            local u9 = script.BarrageSmash:GetChildren()
            local u10 = script.Whoosh:GetChildren()
            local u11 = u3 * (u4 * 0.1) / 1.5
            local u12 = script.MochiThing:Clone()
            u12.Size = Vector3.new()
            u12.RigidConstraint.Attachment1 = p5
            local v13 = u12.RigidConstraint.Attachment0
            local v14 = u7:NextNumber(-360, 360)
            local v15 = u7:NextNumber(-360, 360)
            v13.Orientation = Vector3.new(v14, v15, u7:NextNumber(-360, 360))
            u12.Parent = workspace.Effects
            _G.PlaySound(u12.CFrame, script.MochiHandBubble, nil, true)
            TweenCreate(u12, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(2, 2, 2)
            })
            task.delay(u11 * 0.5, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u11
                --]]
                TweenCreate(u12, {
                    u11 * 0.5,
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
            local v16 = u12.AnimationController
            local u17 = v16.Animator:LoadAnimation(v16.Animation)
            u17:Play()
            u17:AdjustSpeed(10)
            task.delay(u11, function() --[[ Line: 57 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u12
                --]]
                u17:Destroy()
                u12:Destroy()
                u12 = nil
            end)
            task.spawn(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u4
                    [3] = u7
                    [4] = u8
                    [5] = u1
                    [6] = u9
                    [7] = u10
                --]]
                for _ = 1, u3 do
                    task.spawn(function() --[[ Line: 63 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u7
                            [3] = u8
                            [4] = u1
                            [5] = u9
                            [6] = u10
                        --]]
                        for _ = 1, u4 do
                            local v18 = u7:NextInteger(5, 10)
                            local v19 = (u8 * CFrame.Angles(0, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, -v18)).Position
                            local v20 = workspace:Raycast(v19 + Vector3.new(0, 20, 0), Vector3.new(-0, -45, -0), u1)
                            if v20 then
                                local v21 = v20.Instance
                                local v22 = v21.Size.X
                                local v23 = v21.Size.Y
                                local v24 = v21.Size.Z
                                local v25 = math.max(v22, v24)
                                local v26 = v21.Size.Y
                                local v27 = v23 / (v25 ^ 2 + v26 ^ 2) ^ 0.5
                                local v28 = math.deg(v27)
                                local v29 = math.floor(v28)
                                local v30 = v20.Normal
                                local v31 = v20.Position
                                local v32
                                if v29 == 1 then
                                    v32 = u7:NextInteger(15, 25)
                                else
                                    v32 = u7:NextInteger(5, 15)
                                end
                                local v33 = CFrame.Angles
                                local v34 = math.rad(v32)
                                local v35 = -v32
                                local v36 = v33(v34, 0, (math.rad(v35)))
                                local v37
                                if v20 then
                                    v37 = CFrame.new(v31, v31 + v30) * CFrame.Angles(-1.5707963267948966, 0, 0)
                                else
                                    v37 = CFrame.new(v31)
                                end
                                local v38 = v37 * CFrame.Angles(0, 6.283185307179586 * math.random(), 0)
                                local v39 = CFrame.new(0, u7:NextNumber(18, 25), 0)
                                if typeof(v38) == "Vector3" then
                                    v38 = CFrame.new(v38)
                                end
                                local u40 = v38 * v36 * v39
                                local v41 = CFrame.new(u40.Position, v31)
                                local v42 = (u40.Position - v31).Magnitude
                                local _ = (u40.Position - v31).Unit
                                local u43 = script.Hit:Clone()
                                if v20 then
                                    u43.CFrame = CFrame.new(v31, v31 + v20.Normal) * CFrame.Angles(-1.5707963267948966, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0.05, 0)
                                end
                                local u44 = script.Dough:Clone()
                                u44.CFrame = v41 * CFrame.new(0, 0, 0.5) * CFrame.Angles(0, 0, 3.141592653589793 * math.random())
                                u44.Size = u44.Size / 10
                                u44.flour:SetAttribute("EmitCount", 0)
                                local u45 = script.MochiArm:Clone()
                                u45.CFrame = v41 * CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, 6.283185307179586 * math.random())
                                u43.Attachment.Dust.Color = ColorSequence.new(v20.Instance.Color)
                                u43.Attachment.circledust.Color = ColorSequence.new(v20.Instance.Color)
                                u43.Attachment.Rocks.Color = ColorSequence.new(v20.Instance.Color)
                                u43.Parent = workspace.Effects
                                u44.Parent = workspace.Effects
                                u45.Parent = workspace.Effects
                                _G.customEmit(u44)
                                task.delay(0.2, function() --[[ Line: 138 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u44
                                    --]]
                                    local v46 = TweenCreate(u44, {
                                        0.15,
                                        "Sine",
                                        Enum.EasingDirection.In,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Size"] = Vector3.new(),
                                        ["CFrame"] = u44.CFrame * CFrame.Angles(0, 0, 3.141592653589793)
                                    })
                                    _G.destroy(u44, 1.65)
                                    v46.Completed:Wait()
                                    v46:Destroy()
                                    u44.flour:SetAttribute("EmitCount", 30)
                                    task.delay(1.5, function() --[[ Line: 153 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u44
                                        --]]
                                        u44:Destroy()
                                        u44 = nil
                                    end)
                                end)
                                TweenCreate(u44, {
                                    0.2,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Size"] = script.Dough.Size * 1.1,
                                    ["CFrame"] = u44.CFrame * CFrame.Angles(0, 0, 4.71238898038469)
                                })
                                local u47 = TweenCreate(u45.LeftRoot.LeftExtend, {
                                    v42 / 155,
                                    "Linear",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Position"] = u45.LeftRoot.LeftExtend.Position + Vector3.new(0, v42, 0)
                                })
                                u47.Completed:Connect(function() --[[ Line: 168 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u47
                                        [2] = u7
                                        [3] = u40
                                        [4] = u9
                                        [5] = u43
                                        [6] = u45
                                    --]]
                                    u47:Destroy()
                                    if u7:NextInteger(1, 3) % 2 == 1 then
                                        _G.PlaySound(u40, u9[u7:NextInteger(1, #u9)], nil, true)
                                    end
                                    u43.Decal.Transparency = 0
                                    _G.customEmit(u43)
                                    TweenCreate(u43.Decal, {
                                        1.25,
                                        "Quad",
                                        Enum.EasingDirection.In,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Transparency"] = 1
                                    })
                                    _G.destroy(u43, 3)
                                    _G.customEmit(u45.LeftRoot.LeftExtend)
                                    task.wait(0.1)
                                    TweenCreate(u45, {
                                        0.1,
                                        "Cubic",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Transparency"] = 1
                                    })
                                    _G.destroy(u45, 0.1)
                                end)
                                if u7:NextInteger(1, 3) % 2 == 1 then
                                    _G.PlaySound(u40, u10[u7:NextInteger(1, #u10)], nil, true)
                                end
                                task.wait(0.15)
                            end
                        end
                    end)
                    task.wait(u7:NextNumber(0.04, 0.05))
                end
            end)
        end
    end
}