 

local u1 = require(script.Bezier)
local u2 = game:GetService("RunService")
local v3 = {}
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Whitelist
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u35(p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local u6 = p5.CFrame * CFrame.new(0, 0, 3)
    task.spawn(function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u4
        --]]
        for v7 = 0, -7, -0.5 do
            if v7 ~= 0 and (v7 <= -2 or v7 >= 2) then
                local v8 = v7 < 0 and -v7 * 8 or v7 * 8
                local v9 = u6 * CFrame.new(v7 * 22 / 7, 3, -v8)
                local v10 = workspace:Raycast(v9.Position, v9.UpVector * Vector3.new(0, -15, 0), u4)
                if v10 then
                    local u11 = script.coneRocks:GetChildren()[math.random(1, #script.coneRocks:GetChildren())]:Clone()
                    local v12 = CFrame.new(v10.Position, v10.Normal)
                    local v13 = CFrame.Angles
                    local v14 = math.random(-360, 360)
                    local v15 = math.rad(v14)
                    local v16 = math.random(-360, 360)
                    local v17 = math.rad(v16)
                    local v18 = math.random(-360, 360)
                    u11:PivotTo(v12 * v13(v15, v17, (math.rad(v18))))
                    u11.Floor.Color = v10.Instance.Color
                    u11.PrimaryPart.Anchored = true
                    local v19 = u11.PrimaryPart
                    v19.Position = v19.Position + Vector3.new(0, -8, 0)
                    u11.Parent = workspace
                    _G.tween(u11.PrimaryPart, {
                        0.15,
                        "EntranceProductive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Position"] = u11.PrimaryPart.Position + Vector3.new(0, 8, 0)
                    })
                    task.delay(3, function() --[[ Line: 29 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                        --]]
                        for _, v20 in u11:GetChildren() do
                            _G.tween(v20, {
                                0.35,
                                "EntranceProductive",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Size"] = Vector3.new(0, 0, 0),
                                ["Transparency"] = 1
                            })
                        end
                        _G.destroy(u11, 1)
                    end)
                end
                task.wait(0.025)
            end
        end
    end)
    task.spawn(function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u4
        --]]
        for v21 = 0, 7, 0.5 do
            if v21 ~= 0 and (v21 <= -2 or v21 >= 2) then
                local v22 = v21 < 0 and -v21 * 8 or v21 * 8
                local v23 = u6 * CFrame.new(v21 * 22 / 7, 0, -v22)
                local v24 = workspace:Raycast(v23.Position, v23.UpVector * Vector3.new(0, -15, 0), u4)
                if v24 then
                    warn("e")
                    local u25 = script.coneRocks:GetChildren()[math.random(1, #script.coneRocks:GetChildren())]:Clone()
                    local v26 = CFrame.new(v24.Position, v24.Normal)
                    local v27 = CFrame.Angles
                    local v28 = math.random(-360, 360)
                    local v29 = math.rad(v28)
                    local v30 = math.random(-360, 360)
                    local v31 = math.rad(v30)
                    local v32 = math.random(-360, 360)
                    u25:PivotTo(v26 * v27(v29, v31, (math.rad(v32))))
                    u25.Floor.Color = v24.Instance.Color
                    u25.PrimaryPart.Anchored = true
                    local v33 = u25.PrimaryPart
                    v33.Position = v33.Position + Vector3.new(0, -8, 0)
                    u25.Parent = workspace
                    _G.tween(u25.PrimaryPart, {
                        0.15,
                        "EntranceProductive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Position"] = u25.PrimaryPart.Position + Vector3.new(0, 8, 0)
                    })
                    task.delay(3, function() --[[ Line: 57 ]]
                        --[[
                        Upvalues:
                            [1] = u25
                        --]]
                        for _, v34 in u25:GetChildren() do
                            _G.tween(v34, {
                                0.35,
                                "EntranceProductive",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Size"] = Vector3.new(0, 0, 0),
                                ["Transparency"] = 1
                            })
                        end
                        _G.destroy(u25, 1)
                    end)
                end
                task.wait(0.025)
            end
        end
    end)
end
function v3.start(_, p36) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u35
        [2] = u1
        [3] = u2
    --]]
    if _G.checkRenderDistance(p36.PrimaryPart.Position) ~= false then
        local u37 = p36.PrimaryPart.CFrame * CFrame.new(0, 0, 0)
        for u38 = 1, 2 do
            task.spawn(function() --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u38
                --]]
                local v39 = script.trail:Clone()
                v39.CFrame = u37 * CFrame.new(0, 0, -10)
                v39.Parent = workspace.Effects
                local v40 = u38 == 1 and 17 or 20
                for v41 = 0, 1000, 15 do
                    local v42 = u38 == 1 and v41 and v41 or -v41
                    local v43 = u37
                    local v44 = CFrame.new
                    local v45 = math.rad(v41)
                    local v46 = v40 * math.cos(v45)
                    local v47 = math.rad(v42)
                    v39.CFrame = v43 * v44(v46, v40 * math.sin(v47), -(v41 / 15))
                    task.wait()
                end
                _G.destroy(v39, 1)
            end)
        end
        local v48 = script.Weffect:Clone()
        v48.CFrame = u37 * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0)
        v48.Parent = workspace.Effects
        local v49 = _G.tween
        local v50 = {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v51 = {
            ["Size"] = Vector3.new(30, 0.5, 30)
        }
        local v52 = u37 * CFrame.new(0, 0, -6)
        local v53 = CFrame.Angles
        local v54 = math.random(0, 180)
        v51.CFrame = v52 * v53(1.5707963267948966, math.rad(v54), 0)
        v49(v48, v50, v51)
        _G.tween(v48, {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v48, 0.5)
        local v55 = script.Wefect2:Clone()
        v55.CFrame = u37 * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0)
        v55.Parent = workspace.Effects
        local v56 = _G.tween
        local v57 = {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v58 = {
            ["Size"] = Vector3.new(20, 2, 20)
        }
        local v59 = u37 * CFrame.new(0, 0, -5)
        local v60 = CFrame.Angles
        local v61 = math.random(0, 180)
        v58.CFrame = v59 * v60(1.5707963267948966, math.rad(v61), 0)
        v56(v55, v57, v58)
        _G.tween(v55, {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v55, 0.5)
        local v62 = script.expand1:Clone()
        v62.CFrame = u37 * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
        v62.Parent = workspace.Effects
        local v63 = _G.tween
        local v64 = {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v65 = {
            ["Size"] = Vector3.new(30, 50, 30)
        }
        local v66 = u37 * CFrame.new(0, 0, -25)
        local v67 = CFrame.Angles
        local v68 = math.random(0, 180)
        v65.CFrame = v66 * v67(1.5707963267948966, math.rad(v68), 0)
        v63(v62, v64, v65)
        _G.tween(v62, {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v62, 0.3)
        local u69 = script.expand2:Clone()
        u69.CFrame = u37 * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0)
        u69.Parent = workspace.Effects
        _G.tween(u69, {
            0.3,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(20, 50, 20),
            ["Transparency"] = 0.9,
            ["CFrame"] = u37 * CFrame.new(0, 0, -30) * CFrame.Angles(1.5707963267948966, 0.2617993877991494, 0)
        })
        task.delay(0.2, function() --[[ Line: 148 ]]
            --[[
            Upvalues:
                [1] = u69
            --]]
            _G.tween(u69, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
        end)
        _G.destroy(u69, 1)
        u35(p36.PrimaryPart)
        local function v74(p70, p71) --[[ Line: 111 ]]
            local v72 = p70.Keypoints
            for v73 = 1, #v72 do
                v72[v73] = NumberSequenceKeypoint.new(v72[v73].Time, v72[v73].Value * p71, v72[v73].Envelope * p71)
            end
            return NumberSequence.new(v72)
        end
        for u75 = 4, 24, 3 do
            local v76 = u75 / 12
            local v77 = math.clamp(v76, 1, 6)
            local v78 = u37 * CFrame.new(0, -2, -(u75 * 2.5))
            local v79 = RaycastParams.new()
            v79.FilterType = Enum.RaycastFilterType.Whitelist
            v79.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            local v80 = workspace:Raycast(v78.Position + Vector3.new(0, 3, 0), v78.UpVector * Vector3.new(0, -10, 0), v79)
            if v80 then
                local v81 = script.Rocks:GetChildren()
                local v82 = v81[math.random(1, #v81)]:Clone()
                v82:PivotTo(v78)
                v82.Floor.Color = v80.Instance.Color
                v82.Parent = workspace.Effects
                local v83 = math.random(-1, 1)
                local v84 = v83 == 0 and -1 or v83
                local v85 = v82.Rock
                local v86 = v84 * math.random(20, 30)
                local v87 = math.random(60, 90)
                local v88 = math.random
                v85.Velocity = Vector3.new(v86, v87, v88(-20, 20))
                local v89 = v82.Rock
                local v90 = math.random(-5, 5)
                local v91 = math.random(-5, 5)
                local v92 = math.random
                v89.RotVelocity = Vector3.new(v90, v91, v92(-5, 5)) * 2
                local v93 = nil
                local v94 = nil
                for _, v95 in ipairs(script.rocktrail:GetChildren()) do
                    local v96 = v95:Clone()
                    if v96.Name == "A0" then
                        v93 = v96.Trail
                        v93.Attachment0 = v96
                    else
                        v94 = v96
                    end
                    v96.Parent = v82.Rock
                end
                v93.Attachment1 = v94
                _G.destroy(v82, 5)
            end
            local v97 = script.MeshPart:Clone()
            v97.CFrame = u37 * CFrame.new(0, 0, -(u75 * 2.5)) * CFrame.Angles(1.5707963267948966, 0, 0)
            v97.Parent = workspace.Effects
            local v98 = _G.tween
            local v99 = {
                0.3,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v100 = {
                ["Size"] = Vector3.new(15, 0.5, 15) * v77,
                ["Transparency"] = 1
            }
            local v101 = u37 * CFrame.new(0, 0, -(u75 * 2.5))
            local v102 = CFrame.Angles
            local v103 = math.random(0, 180)
            v100.CFrame = v101 * v102(1.5707963267948966, math.rad(v103), 0)
            v98(v97, v99, v100)
            _G.destroy(v97, 0.3)
            local v104 = script.swirltwo:Clone()
            local v105 = u37 * CFrame.new(0, 0, -(u75 * 2.5))
            local v106 = CFrame.Angles
            local v107 = math.random(0, 180)
            v104.CFrame = v105 * v106(1.5707963267948966, math.rad(v107), 0)
            v104.Parent = workspace.Effects
            local v108 = _G.tween
            local v109 = {
                0.3,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v110 = {
                ["Size"] = Vector3.new(20, 0.5, 20) * v77
            }
            local v111 = u37 * CFrame.new(0, 0, -(u75 * 2.5))
            local v112 = CFrame.Angles
            local v113 = math.random(0, 180)
            v110.CFrame = v111 * v112(1.5707963267948966, math.rad(v113), 0)
            v108(v104, v109, v110)
            _G.tween(v104, {
                0.2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v104, 0.5)
            local v114 = script.Weffect:Clone()
            v114.CFrame = u37 * CFrame.new(0, 0, -(u75 * 2.5)) * CFrame.Angles(1.5707963267948966, 0, 0)
            v114.Parent = workspace.Effects
            local v115 = _G.tween
            local v116 = {
                0.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v117 = {
                ["Size"] = Vector3.new(30, 0.5, 30)
            }
            local v118 = u37 * CFrame.new(0, 0, -(u75 * 2.5))
            local v119 = CFrame.Angles
            local v120 = math.random(0, 180)
            v117.CFrame = v118 * v119(1.5707963267948966, math.rad(v120), 0)
            v115(v114, v116, v117)
            _G.tween(v114, {
                0.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v114, 0.5)
            local v121 = script.Wefect2:Clone()
            v121.CFrame = u37 * CFrame.new(0, 0, -(u75 * 2.5)) * CFrame.Angles(1.5707963267948966, 0, 0)
            v121.Parent = workspace.Effects
            local v122 = _G.tween
            local v123 = {
                0.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v124 = {
                ["Size"] = Vector3.new(20, 2, 20)
            }
            local v125 = u37 * CFrame.new(0, 0, -(u75 * 2.5))
            local v126 = CFrame.Angles
            local v127 = math.random(0, 180)
            v124.CFrame = v125 * v126(1.5707963267948966, math.rad(v127), 0)
            v122(v121, v123, v124)
            _G.tween(v121, {
                0.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v121, 0.5)
            task.spawn(function() --[[ Line: 214 ]]
                --[[
                Upvalues:
                    [1] = u75
                    [2] = u37
                --]]
                local v128 = u75 % 2 == 0 and 2 or 1
                local v129 = u37 * CFrame.new(0, 0, -(u75 * 2.5))
                local v130 = CFrame.Angles
                local v131 = math.random(0, 360)
                local v132 = math.rad(v131)
                local v133 = math.random(0, 360)
                local v134 = math.rad(v133)
                local v135 = math.random(0, 360)
                local v136 = v129 * v130(v132, v134, (math.rad(v135)))
                local v137 = script.trail:Clone()
                v137.CFrame = v136
                v137.Parent = workspace.Effects
                for v138 = 0, 600, 15 do
                    local v139 = (v128 == 1 and 15 or 25) - v138 / 100
                    local v140 = v128 == 1 and v138 and v138 or -v138
                    local v141 = CFrame.new
                    local v142 = math.rad(v138)
                    local v143 = v139 * math.cos(v142)
                    local v144 = math.rad(v140)
                    v137.CFrame = v136 * v141(v143, v139 * math.sin(v144), 0)
                    task.wait()
                end
                _G.destroy(v137, 1)
            end)
            local v145 = script.AirCannon:Clone()
            v145.CFrame = u37 * CFrame.new(0, 0, -(u75 * 2.5))
            v145.Parent = workspace.Effects
            v145.Size = v145.Size * v77
            for _, v146 in ipairs(v145:GetDescendants()) do
                if v146:IsA("ParticleEmitter") then
                    v146.Size = v74(v146.Size, v77)
                    v146.ZOffset = v146.ZOffset * v77
                    v146.Acceleration = v146.Acceleration * v77
                    local v147 = v146.Speed
                    v146.Speed = NumberRange.new(v147.Min * v77, v147.Max * v77)
                end
            end
            _G.tween(v145, {
                2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v145.CFrame * CFrame.Angles(0, 0, -0.2617993877991494)
            })
            _G.customEmit(v145)
            _G.destroy(v145, 3)
            if (u37 * CFrame.new(0, 0, -(u75 * 2.5)).Position - workspace.CurrentCamera.CFrame.Position).Magnitude < 50 then
                local v148 = script.effectdof:Clone()
                v148.Parent = game:GetService("Lighting")
                _G.destroy(v148, 0.1)
            end
            for _ = 1, 3 do
                task.spawn(function() --[[ Line: 246 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u75
                        [3] = u1
                        [4] = u2
                    --]]
                    local v149 = script.ChargeTrail:Clone()
                    v149.Position = u37 * CFrame.new(0, 0, -(u75 * 2.5)).Position
                    v149.Parent = workspace.Effects
                    local v150 = v149.CFrame
                    local v151 = math.random(-700, 700) / 30
                    local v152 = v150 + Vector3.new(v151, 0, 0)
                    local v153 = u37 * CFrame.new(0, 0, -(u75 * 2.5)).Position
                    local v154 = math.random(-700, 700) / 20
                    local v155 = math.random(100, 600) / 25
                    local v156 = math.random(-700, 700) / 20
                    local v157 = v153 + Vector3.new(v154, v155, v156)
                    local v158 = (v152.Position - v157).Magnitude
                    local v159 = math.random(-v158 / 12.2, v158 / 8.2)
                    local v160 = math.random(-v158 / 8, v158 / 4.6)
                    local v161 = -math.random(v158 / 8, v158)
                    local v162 = Vector3.new(v159, v160, v161)
                    local v163 = v152.Position + v152.LookVector * v158 / 12 + v162
                    local v164 = math.random(-v158 / 4.2, v158 / 8.2)
                    local v165 = math.random(-v158 / 3, v158)
                    local v166 = math.random
                    local v167 = -v158 / 7.6
                    local v168 = v158 / 4.6
                    local v169 = Vector3.new(v164, v165, v166(v167, v168))
                    local v170 = v152.Position + v152.LookVector * v158 / 7 + v169
                    local v171 = u1.new(v152.Position, v163, v170, v157)
                    local v172 = 1
                    while v172 ~= v158 do
                        local _ = v149.Position
                        local v173 = u2.Heartbeat:Wait()
                        local v174 = v172 / v158
                        local v175 = v171:Get(v174)
                        if v174 >= 1 or v149 == nil then
                            break
                        end
                        v149.CFrame = CFrame.new(v175, v171:Get(v172 + 120 * v173 / v158))
                        v172 = v172 + 120 * v173
                    end
                    _G.destroy(v149, 0.4)
                end)
            end
            task.wait(0.04)
        end
    end
end
return v3