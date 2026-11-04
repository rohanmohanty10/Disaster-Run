 

local u1 = game:GetService("RunService")
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u6(p3, p4) --[[ Line: 19 ]]
    for _, v5 in pairs(p3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            if v5:GetAttribute("ChangeColor") == true then
                v5.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p4), ColorSequenceKeypoint.new(1, p4) })
            end
            _G.customEmit(v5)
        end
    end
end
local function u10(p7, p8) --[[ Line: 29 ]]
    for _, v9 in pairs(p7:GetDescendants()) do
        if v9:IsA("ParticleEmitter") then
            v9.Enabled = p8
        end
    end
end
local u11 = script
local v12 = {}
local u13 = game:GetService("TweenService")
local u14 = Random.new()
function v12.start(_, u15, u16, p17) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u11
        [3] = u14
        [4] = u13
        [5] = u6
        [6] = u1
        [7] = u10
    --]]
    local u18 = Instance.new("Folder")
    u18.Parent = workspace.Effects
    u18.Name = "EffectsFolder"
    _G.PlayEffect("GroundRocks4", nil, {
        ["Segments"] = 15,
        ["Position"] = (u15 * CFrame.new(0, 0, -3)).Position,
        ["DistanceRandomness"] = Vector2.new(0.5, 1),
        ["Duration"] = 3,
        ["TweenDuration"] = 1,
        ["Radius"] = 11,
        ["Direction"] = Vector3.new(0, -35, 0)
    })
    local u19 = workspace:Raycast((u15 * CFrame.new(0, 0, -3)).Position, Vector3.new(0, -10, 0), u2)
    if u19 then
        warn("Is this the new skill")
        local u20 = u11.X:Clone()
        u20.CFrame = CFrame.lookAt(u19.Position, u19.Position + u15.LookVector)
        u20.Parent = u18
        _G.destroy(u20.PL, u16 * 3 / 8)
        _G.tween(u20.PL.PointLight, {
            0.3,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 25,
            ["Brightness"] = 0
        })
        task.spawn(function() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u20
                [3] = u14
                [4] = u19
                [5] = u18
                [6] = u13
            --]]
            for _ = 0, 8 do
                local u21 = u11.Rock:Clone()
                u21.CFrame = u20.CFrame * CFrame.new(0, 2, 0) * CFrame.Angles(u14:NextNumber(0, 6.283185307179586), u14:NextNumber(0, 6.283185307179586), u14:NextNumber(0, 6.283185307179586))
                u21.Size = Vector3.new(1, 1, 1) * u14:NextNumber(0.3, 1.5)
                u21.Material = u19.Instance.Material
                u21.Color = u19.Instance.Color
                local v22 = Instance.new("BodyVelocity")
                v22.MaxForce = Vector3.new(1, 1, 1) * (1 / 0)
                v22.Velocity = (u20.CFrame.UpVector * u14:NextNumber(10, 30) + u20.CFrame.LookVector * u14:NextNumber(-20, 20) + u20.CFrame.RightVector * u14:NextNumber(-20, 20)) * 2
                v22.Parent = u21
                u21.Parent = u18
                _G.destroy(v22, math.random(100, 300) / 1000)
                task.delay(u14:NextNumber(0.2, 0.5), function() --[[ Line: 107 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u13
                        [3] = u21
                    --]]
                    task.wait(u14:NextNumber(0.2, 0.4))
                    local v23 = u13:Create(u21, TweenInfo.new(u14:NextNumber(0.3, 0.6), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Size"] = Vector3.new(0, 0, 0)
                    })
                    v23:Play()
                    task.wait(0.6)
                    u21:Destroy()
                    v23:Destroy()
                end)
            end
        end)
        u6(u20, u19.Instance.Color)
        local v24 = u11.SlashDebree:Clone()
        v24.CFrame = u20.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)
        v24.Parent = u18
        u6(v24)
        local v25 = u11.SlashDebree:Clone()
        v25.CFrame = u20.CFrame * CFrame.Angles(0, 2.356194490192345, 0)
        v25.Parent = u18
        u6(v25)
        for _ = 1, 7 do
            task.spawn(function() --[[ Line: 142 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u14
                    [3] = u20
                    [4] = u18
                    [5] = u1
                --]]
                local v26 = u11.MiniSlashTrail:Clone()
                local u27 = 0
                local u28 = -u14:NextNumber(100, 150)
                local u29 = u20.CFrame * CFrame.new(u14:NextNumber(-4, 4), 0, u14:NextNumber(-4, 4))
                local u30 = u29.Position
                local u31 = nil
                local u32 = nil
                v26.Position = u30
                local u33 = u14:NextNumber(0, 360)
                local u34 = u14:NextNumber(5, 10) * u14:NextNumber(-60, 60)
                local u35 = u14:NextNumber(2, 5)
                local u36 = u14:NextNumber(2, 5)
                local u37 = u14:NextNumber(2, 5)
                local u38 = u11.MiniSlashTrail:Clone()
                u38.Parent = u18
                local u39 = nil
                local u40 = tick()
                u39 = u1.Heartbeat:Connect(function(p41) --[[ Line: 169 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u29
                        [3] = u27
                        [4] = u31
                        [5] = u28
                        [6] = u32
                        [7] = u38
                        [8] = u33
                        [9] = u35
                        [10] = u36
                        [11] = u37
                        [12] = u34
                        [13] = u40
                        [14] = u14
                        [15] = u39
                    --]]
                    u30 = (u29 * CFrame.new(0, -u27, 0)).Position
                    u31 = (u29 * CFrame.new(0, -u27 - u28, 0)).Position
                    u32 = CFrame.lookAt(u30, u31)
                    u27 = u27 + u28 * p41
                    local v42 = u38
                    local v43 = u32
                    local v44 = CFrame.new
                    local v45 = u33
                    local v46 = math.rad(v45)
                    local v47 = math.sin(v46) * u35
                    local v48 = u33
                    local v49 = math.rad(v48)
                    local v50 = math.cos(v49) * u36
                    local v51 = u33
                    local v52 = math.rad(v51)
                    v42.CFrame = v43 * v44(v47, v50, math.cos(v52) * u37)
                    u33 = u33 + u34 * p41
                    if tick() - u40 >= u14:NextNumber(0.05, 0.15) then
                        u39:Disconnect()
                        _G.particleEnabled(u38, false)
                    end
                end)
            end)
        end
        local u53 = nil
        local u54 = tick()
        local u55 = u14:NextNumber(0.02, 0.05)
        local u56 = {}
        local u57 = 0
        u53 = u1.Heartbeat:Connect(function(p58) --[[ Line: 205 ]]
            --[[
            Upvalues:
                [1] = u54
                [2] = u16
                [3] = u56
                [4] = u53
                [5] = u55
                [6] = u57
                [7] = u14
                [8] = u20
                [9] = u11
                [10] = u18
                [11] = u13
            --]]
            if u16 <= tick() - u54 and #u56 == 0 then
                u53:Disconnect()
            else
                if u55 <= tick() - u54 and u57 < 10 then
                    u57 = u57 + 1
                    u55 = u55 + u14:NextNumber(0.02, 0.05)
                    local u59 = (u20.CFrame * CFrame.new(u14:NextNumber(-20, 20), u14:NextNumber(0, 20), u14:NextNumber(-20, 20))).Position
                    local u60 = (u20.CFrame * CFrame.new(u14:NextNumber(-20, 20), u14:NextNumber(0, 20), u14:NextNumber(-20, 20))).Position
                    local u61 = (u20.CFrame * CFrame.new(u14:NextNumber(-20, 20), u14:NextNumber(0, 20), u14:NextNumber(-20, 20))).Position
                    local u62 = u20.Position
                    local u63 = u11.WindupBezier:Clone()
                    u63.Position = u59
                    u63.Parent = u18
                    local u64 = u14:NextNumber(0.25, 0.5)
                    u13:Create(u63.Trail, TweenInfo.new(u64), {
                        ["MaxLength"] = 0.1
                    }):Play()
                    local v65 = { u63.A0, u63.A1 }
                    for v66 = 1, #v65 do
                        u13:Create(v65[v66], TweenInfo.new(u64), {
                            ["Position"] = v65[v66].Position / 10
                        }):Play()
                    end
                    local u67 = 0
                    local v79 = {
                        ["Finished"] = false,
                        ["Update"] = function(p68, p69) --[[ Name: Update, Line 253 ]]
                            --[[
                            Upvalues:
                                [1] = u67
                                [2] = u64
                                [3] = u59
                                [4] = u60
                                [5] = u61
                                [6] = u62
                                [7] = u63
                            --]]
                            u67 = u67 + p69
                            local v70 = u67 / u64
                            local v71 = math.clamp(v70, 0, 1)
                            local v72 = u59
                            local v73 = v72 + (u60 - v72) * v71
                            local v74 = u60
                            local v75 = v74 + (u61 - v74) * v71
                            local v76 = u61
                            local v77 = v76 + (u62 - v76) * v71
                            local v78 = v73 + (v75 - v73) * v71
                            u63.Position = v78 + (v75 + (v77 - v75) * v71 - v78) * v71
                            if v71 == 1 then
                                p68.Finished = true
                            end
                        end
                    }
                    local v80 = u56
                    table.insert(v80, v79)
                end
                for v81 = #u56, 1, -1 do
                    if u56[v81].Finished then
                        table.remove(u56, v81)
                    else
                        u56[v81]:Update(p58)
                    end
                end
            end
        end)
    end
    task.wait(u16 * 3 / 8)
    local u82 = u11.FloorWind:Clone()
    if u19 then
        u82.CFrame = CFrame.lookAt(u19.Position, u19.Position + u19.Normal) * CFrame.new(0, 0.5, 0)
    else
        u82.CFrame = u15 * CFrame.new(0, -3, -3) * CFrame.Angles(1.5707963267948966, 0, 0)
    end
    u82.Parent = u18
    u6(u82)
    local v83 = u11.BeamPart:Clone()
    v83.CFrame = u82.CFrame
    v83.Parent = u18
    v83.Beam.Attachment0 = v83.a
    v83.Beam.Attachment1 = v83.b
    local v84 = u13:Create(v83.b, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = Vector3.new(0, 0, -15)
    })
    local v85 = u13:Create(v83.Beam, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Width0"] = 0
    })
    v84:Play()
    v85:Play()
    if #p17 > 0 then
        for v86 = 1, #p17 do
            local u87 = p17[v86]
            task.spawn(function() --[[ Line: 318 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u11
                    [3] = u14
                    [4] = u15
                    [5] = u87
                    [6] = u18
                    [7] = u6
                    [8] = u16
                    [9] = u2
                    [10] = u13
                --]]
                local u88 = tick()
                local u89 = tick()
                local u90 = nil
                local u91 = nil
                u90 = u1.Heartbeat:Connect(function(p92) --[[ Line: 323 ]]
                    --[[
                    Upvalues:
                        [1] = u91
                        [2] = u89
                        [3] = u11
                        [4] = u14
                        [5] = u15
                        [6] = u87
                        [7] = u18
                        [8] = u6
                        [9] = u88
                        [10] = u16
                        [11] = u90
                        [12] = u2
                        [13] = u13
                    --]]
                    u91 = 1 / p92
                    if tick() - u89 >= 0.04 then
                        u89 = tick()
                        task.spawn(function() --[[ Line: 328 ]]
                            --[[
                            Upvalues:
                                [1] = u11
                                [2] = u14
                                [3] = u15
                                [4] = u87
                                [5] = u18
                                [6] = u91
                                [7] = u6
                            --]]
                            local v93 = u11.Ghost:Clone()
                            local v94 = u14:NextNumber(0, 6.283185307179586)
                            local v95 = u14:NextNumber(0, 15)
                            local v96 = u15 * CFrame.new(math.sin(v94) * v95, 0, math.cos(v94) * v95)
                            local v97 = v96.Position
                            local v98 = (v96 * CFrame.new(u14:NextNumber(-2, 2), u14:NextNumber(12, 25), u14:NextNumber(-2, 2))).Position
                            local v99 = (u87.PrimaryPart.CFrame * CFrame.new(u14:NextNumber(-10, 10), u14:NextNumber(-10, 10), u14:NextNumber(-10, 10))).Position
                            local v100 = u87.PrimaryPart.Position
                            v93.Position = v97
                            v93.Parent = u18
                            for v101 = 0, 1, 0.08 / (u91 / 60) do
                                local v102 = v97 + (v98 - v97) * v101
                                local v103 = v98 + (v99 - v98) * v101
                                local v104 = v99 + (v100 - v99) * v101
                                local v105 = v102 + (v103 - v102) * v101
                                v93.Position = v105 + (v103 + (v104 - v103) * v101 - v105) * v101
                                task.wait()
                            end
                            local v106 = u11.SlashPart:Clone()
                            v106.CFrame = u87.PrimaryPart.CFrame * CFrame.new(u14:NextNumber(-2, 2), u14:NextNumber(-2, 2), u14:NextNumber(-2, 2)) * CFrame.Angles(u14:NextNumber(0, 6.283185307179586), u14:NextNumber(0, 6.283185307179586), u14:NextNumber(0, 6.283185307179586))
                            v106.Parent = u18
                            u6(v106)
                            v93.Position = v100
                        end)
                    end
                    if tick() - u88 >= u16 * 5 / 8 then
                        u90:Disconnect()
                        local v107 = u11.Explosion:Clone()
                        v107.CFrame = u87.PrimaryPart.CFrame
                        task.wait(0.3)
                        v107.Parent = u18
                        u6(v107)
                        local v108 = workspace:Raycast(v107.Position, Vector3.new(0, -10, 0), u2)
                        if v108 then
                            local v109 = u11.FloorWindEmit:Clone()
                            v109.CFrame = CFrame.lookAt(v108.Position, v108.Position + v108.Normal)
                            v109.Parent = u18
                            u6(v109, v108.Instance.Color)
                        end
                        u13:Create(v107.PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ["Brightness"] = 0
                        }):Play()
                    end
                    task.wait(u14:NextNumber(0.04, 0.06))
                end)
            end)
        end
    end
    local v110 = tick()
    repeat
        task.spawn(function() --[[ Line: 403 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u14
                [3] = u82
                [4] = u18
                [5] = u1
            --]]
            local u111 = u11.BlackMiniTrail:Clone()
            local u112 = 0
            local u113 = -u14:NextNumber(50, 110)
            local u114 = u82.CFrame * CFrame.new(u14:NextNumber(-4, 4), u14:NextNumber(-4, 4), 0)
            local u115 = u114.Position
            local u116 = nil
            local u117 = nil
            u111.Position = u115
            local u118 = u14:NextNumber(0, 360)
            local v119 = math.random(0, 1) == 0 and -1 or 1
            local u120 = u14:NextNumber(5, 10) * u14:NextNumber(20, 60) * v119
            local u121 = u14:NextNumber(3, 7)
            local u122 = u14:NextNumber(3, 7)
            local u123 = u14:NextNumber(3, 7)
            u111.Parent = u18
            local u124 = nil
            local u125 = tick()
            u124 = u1.Heartbeat:Connect(function(p126) --[[ Line: 436 ]]
                --[[
                Upvalues:
                    [1] = u115
                    [2] = u114
                    [3] = u112
                    [4] = u116
                    [5] = u113
                    [6] = u117
                    [7] = u111
                    [8] = u118
                    [9] = u121
                    [10] = u122
                    [11] = u123
                    [12] = u120
                    [13] = u125
                    [14] = u14
                    [15] = u124
                --]]
                u115 = (u114 * CFrame.new(0, 0, u112)).Position
                u116 = (u114 * CFrame.new(0, 0, u112 + u113)).Position
                u117 = CFrame.lookAt(u115, u116)
                u112 = u112 + u113 * p126
                local v127 = u111
                local v128 = u117
                local v129 = CFrame.new
                local v130 = u118
                local v131 = math.rad(v130)
                local v132 = math.sin(v131) * u121
                local v133 = u118
                local v134 = math.rad(v133)
                local v135 = math.cos(v134) * u122
                local v136 = u118
                local v137 = math.rad(v136)
                v127.CFrame = v128 * v129(v132, v135, math.cos(v137) * u123)
                u118 = u118 + u120 * p126
                if tick() - u125 >= u14:NextNumber(0.2, 0.5) then
                    u124:Disconnect()
                    for _, v138 in pairs(u111:GetDescendants()) do
                        if v138:IsA("ParticleEmitter") then
                            v138.Enabled = false
                        end
                    end
                end
            end)
        end)
        task.wait(u14:NextNumber(0.02, 0.06))
    until tick() - v110 >= u16 * 5 / 8
    u10(u82, false)
    task.wait(3)
    u18:Destroy()
end
return v12