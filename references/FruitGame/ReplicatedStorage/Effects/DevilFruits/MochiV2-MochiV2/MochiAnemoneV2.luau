 

Emit = _G.Emit
TweenCreate = _G.tween
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u2 = RaycastParams.new()
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u2.FilterType = Enum.RaycastFilterType.Whitelist
return {
    ["start"] = function(_, p3, u4, u5, u6, p7, p8) --[[ Name: start, Line 17 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if _G.checkRenderDistance(p3) then
            local v9 = p8 or game.Players.LocalPlayer.Character
            local u10 = Random.new()
            local u11 = CFrame.new(p3)
            local u12 = u4 * (u5 * 0.1) / 1.5
            local u13 = script.MochiThing:Clone()
            u1.apply(u13, v9)
            u13.Size = Vector3.new()
            u13.RigidConstraint.Attachment1 = p7
            local v14 = u13.RigidConstraint.Attachment0
            local v15 = u10:NextNumber(-360, 360)
            local v16 = u10:NextNumber(-360, 360)
            v14.Orientation = Vector3.new(v15, v16, u10:NextNumber(-360, 360))
            u13.Parent = workspace.Effects
            _G.PlaySound(u13.CFrame, script.MochiHandBubble, nil, true)
            TweenCreate(u13, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(2, 2, 2)
            })
            task.delay(u12 * 0.5, function() --[[ Line: 43 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u12
                --]]
                TweenCreate(u13, {
                    u12 * 0.5,
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
            local v17 = u13.AnimationController
            local u18 = v17.Animator:LoadAnimation(v17.Animation)
            u18:Play()
            u18:AdjustSpeed(10)
            task.delay(u12, function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u13
                --]]
                u18:Destroy()
                u13:Destroy()
                u13 = nil
            end)
            task.spawn(function() --[[ Line: 57 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u5
                    [3] = u10
                    [4] = u11
                    [5] = u2
                    [6] = u6
                --]]
                for _ = 1, u4 do
                    task.spawn(function() --[[ Line: 60 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u10
                            [3] = u11
                            [4] = u2
                            [5] = u6
                        --]]
                        for _ = 1, u5 do
                            local v19 = u10:NextInteger(5, 10)
                            local v20 = (u11 * CFrame.Angles(0, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, -v19)).Position
                            local v21 = workspace:Raycast(v20 + Vector3.new(0, 20, 0), Vector3.new(-0, -45, -0), u2)
                            if v21 then
                                local v22 = v21.Instance
                                local v23 = v22.Size.X
                                local v24 = v22.Size.Y
                                local v25 = v22.Size.Z
                                local v26 = math.max(v23, v25)
                                local v27 = v22.Size.Y
                                local v28 = v24 / (v26 ^ 2 + v27 ^ 2) ^ 0.5
                                local v29 = math.deg(v28)
                                local v30 = v21.Normal
                                local v31 = v21.Position
                                local v32
                                if math.floor(v29) == 1 then
                                    v32 = u10:NextInteger(15, 25)
                                else
                                    v32 = u10:NextInteger(5, 15)
                                end
                                local v33 = CFrame.Angles
                                local v34 = math.rad(v32)
                                local v35 = -v32
                                local v36 = v33(v34, 0, (math.rad(v35)))
                                local v37
                                if v21 then
                                    v37 = CFrame.new(v31, v31 + v30) * CFrame.Angles(-1.5707963267948966, 0, 0)
                                else
                                    v37 = CFrame.new(v31)
                                end
                                local v38 = v37 * CFrame.Angles(0, 6.283185307179586 * math.random(), 0)
                                local v39 = CFrame.new(0, u10:NextNumber(18, 25), 0)
                                if typeof(v38) == "Vector3" then
                                    v38 = CFrame.new(v38)
                                end
                                local v40 = v38 * v36 * v39
                                local v41 = CFrame.new(v40.Position, v31)
                                local v42 = (v40.Position - v31).Magnitude
                                local _ = (v40.Position - v31).Unit
                                local v43 = v41 * CFrame.new(0, 0, 0.5) * CFrame.Angles(0, 0, 3.141592653589793 * math.random())
                                local v44 = nil
                                if v21 then
                                    v44 = v21.Instance and {
                                        ["CFrame"] = CFrame.new(v21.Position, v21.Position + v21.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0),
                                        ["Position"] = v21.Position,
                                        ["Normal"] = v21.Normal
                                    } or v44
                                end
                                local v45 = math.random(1, 2)
                                _G.PlayEffect("PowerMochiArm", nil, {
                                    ["startCFrame"] = v43,
                                    ["FistTimeToArrive"] = 0.1,
                                    ["Distance"] = v42,
                                    ["modelScale"] = Random.new():NextNumber(0.8, 0.9),
                                    ["instant"] = true,
                                    ["hitCFrame"] = v44,
                                    ["hakiColor"] = u6,
                                    ["HandSide"] = v45 == 1 and "Right" or "Left"
                                })
                                task.wait(0.15)
                            end
                        end
                    end)
                    task.wait(u10:NextNumber(0.04, 0.05))
                end
            end)
        end
    end
}