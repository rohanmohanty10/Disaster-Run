 

local u1 = {
    "rbxassetid://15070515736",
    "rbxassetid://15070515616",
    "rbxassetid://15070515508",
    "rbxassetid://15070515335",
    "rbxassetid://15070507939",
    "rbxassetid://15070507731",
    "rbxassetid://15070507525",
    "rbxassetid://15070507286",
    "rbxassetid://15070507127",
    "rbxassetid://15070506849",
    "rbxassetid://15070499930",
    "rbxassetid://15070499653",
    "rbxassetid://15070499438",
    "rbxassetid://15070499249",
    "rbxassetid://15070499115",
    "rbxassetid://15070498981",
    ""
}
local u2 = {
    "rbxassetid://15089187410",
    "rbxassetid://15089187223",
    "rbxassetid://15089187053",
    "rbxassetid://15089186867",
    "rbxassetid://15089180588",
    "rbxassetid://15089180409",
    "rbxassetid://15089180262",
    "rbxassetid://15089180094",
    "rbxassetid://15089179910",
    "rbxassetid://15089179676",
    "rbxassetid://15089173537",
    "rbxassetid://15089173398",
    "rbxassetid://15089173215",
    "rbxassetid://15089173068",
    "rbxassetid://15089172908",
    "rbxassetid://15089172717",
    ""
}
local u3 = game:GetService("RunService")
local u4 = Random.new()
local u5 = RaycastParams.new()
u5.FilterType = Enum.RaycastFilterType.Include
u5.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u6 = script
local function u26(_, _, p7, p8, p9) --[[ Line: 68 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
        [3] = u3
    --]]
    local u10 = u4:NextNumber(5, 10)
    local u11 = u4:NextNumber(5, 10)
    local u12 = 0
    local u13 = 6.283185307179586 * math.random()
    local u14 = 9.42477796076938 * math.random() * (p9 == "Second" and 1 or -1)
    local u15 = u4:NextNumber(15, 20)
    local u16 = p7 * (p9 == "Second" and CFrame.Angles(0, 0, 0) or CFrame.Angles(0, 0, 1.5707963267948966))
    local u17 = u6.MiniSlashTrail:Clone()
    u17.CFrame = u16 * CFrame.new(math.sin(u13) * u10, 0, math.cos(u13) * u11)
    u17.Parent = p8
    local u18 = u4:NextNumber(0.3, 0.5)
    local u19 = u18
    local u20 = (math.random(2) == 1 and 1 or -1) * math.random()
    local u21 = nil
    u21 = u3.Heartbeat:Connect(function(p22) --[[ Line: 86 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u21
            [3] = u17
            [4] = u19
            [5] = u13
            [6] = u14
            [7] = u10
            [8] = u15
            [9] = u11
            [10] = u12
            [11] = u20
            [12] = u16
        --]]
        if u18 <= 0 then
            u21:Disconnect()
            _G.particleEnabled(u17, false)
        else
            local v23 = u18 / u19
            u13 = u13 + u14 * p22 * v23
            u10 = u10 + u15 * p22 * v23
            u11 = u11 + u15 * p22 * v23
            u12 = u12 + u15 * p22 * v23 * u20
            local v24 = u13
            local v25 = u13
            u17.CFrame = u16 * CFrame.new(math.sin(v24) * u10, u12 * (u19 - u18) / u19, math.cos(v25) * u11)
            u18 = u18 - p22
        end
    end)
end
local v27 = {}
local u28 = game:GetService("TweenService")
local u29 = {}
function v27.start(_, p30, u31, u32, p33) --[[ Line: 114 ]]
    --[[
    Upvalues:
        [1] = u29
        [2] = u6
        [3] = u1
        [4] = u4
        [5] = u28
        [6] = u3
        [7] = u26
        [8] = u2
        [9] = u5
    --]]
    local v34 = u31
    if not u29[u32] then
        u29[u32] = {}
    end
    if p30 == "First" then
        local u35 = Instance.new("Folder")
        u35.Parent = workspace.Effects
        u35.Name = "EffectsFolder"
        local u36 = u6.GreenSlash:Clone()
        u36.CFrame = u31 * CFrame.Angles(0, 0, 1.5707963267948966)
        u36.Decal.Texture = ""
        u36.Parent = workspace.Effects
        local v37 = u6.Shine:Clone()
        v37.Position = u31.Position
        v37.Parent = u35
        task.delay(0.15, function() --[[ Line: 136 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u31
                [3] = u35
            --]]
            local v38 = u6.SlashTip:Clone()
            v38.CFrame = u31 * CFrame.new(0, 0, -10)
            v38.Parent = u35
            _G.customEmit(v38)
        end)
        _G.customEmit(v37)
        task.spawn(function() --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u36
            --]]
            for _, v39 in pairs(u1) do
                u36.Decal.Texture = v39
                task.wait(0.01)
            end
        end)
        local u40 = u6.SlashTrail:Clone()
        if #p33 > 0 then
            for v41 = 1, #p33 do
                local u42 = p33[v41]
                task.spawn(function() --[[ Line: 161 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u6
                        [3] = u31
                        [4] = u35
                        [5] = u42
                        [6] = u28
                    --]]
                    for _ = 1, 5 do
                        task.delay(u4:NextNumber(0.1, 0.4), function() --[[ Line: 163 ]]
                            --[[
                            Upvalues:
                                [1] = u6
                                [2] = u31
                                [3] = u4
                                [4] = u35
                                [5] = u42
                            --]]
                            local v43 = u6.EnemySoulBits:Clone()
                            v43.Position = (u31 * CFrame.new(0, 0, 4) * CFrame.new(u4:NextNumber(-10, 10), u4:NextNumber(-10, 10), u4:NextNumber(-10, 10))).Position
                            v43.Parent = u35
                            v43.Trail.Enabled = true
                            local v44 = v43.Position
                            local v45 = (u31 * CFrame.new(0, 0, -3)).Position
                            local v46 = u42.PrimaryPart.Position
                            for v47 = 0, 1, 0.15 do
                                local v48 = v44 + (v45 - v44) * v47
                                v43.Position = v48 + (v45 + (v46 - v45) * v47 - v48) * v47
                                task.wait()
                            end
                            for _, v49 in pairs(v43:GetDescendants()) do
                                if v49:IsA("ParticleEmitter") or v49:IsA("Trail") then
                                    v49.Enabled = false
                                end
                            end
                            v43.Position = v46
                        end)
                    end
                    task.delay(0.15, function() --[[ Line: 192 ]]
                        --[[
                        Upvalues:
                            [1] = u28
                            [2] = u42
                        --]]
                        local v50 = Instance.new("Highlight")
                        v50.OutlineTransparency = 1
                        v50.DepthMode = Enum.HighlightDepthMode.Occluded
                        v50.FillTransparency = 1
                        v50.FillColor = Color3.fromRGB(68, 255, 26)
                        local v51 = {
                            ["FillTransparency"] = v50.FillTransparency
                        }
                        local v52 = u28:Create(v50, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), v51)
                        v50.FillTransparency = 1
                        v50.Parent = u42
                        v52:Play()
                        task.wait(0.4)
                        v52:Destroy()
                        v50:Destroy()
                    end)
                end)
            end
        end
        local u53 = 0
        local u54 = tick()
        task.spawn(function() --[[ Line: 228 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u53
                [3] = u40
                [4] = u3
                [5] = u54
                [6] = u6
                [7] = u35
                [8] = u28
            --]]
            local v55 = u31
            local v56 = CFrame.new
            local v57 = u53
            local v58 = math.rad(v57)
            local v59 = -math.cos(v58) * 10
            local v60 = u53
            local v61 = math.rad(v60)
            local u62 = v55 * v56(0, v59, math.sin(v61) * 10).Position
            u40.Position = u62
            u40.Parent = workspace.Effects
            _G.destroy(u40, 5)
            local u63 = nil
            local u64 = nil
            u64 = u3.Heartbeat:Connect(function(p65) --[[ Line: 243 ]]
                --[[
                Upvalues:
                    [1] = u54
                    [2] = u64
                    [3] = u40
                    [4] = u62
                    [5] = u31
                    [6] = u53
                    [7] = u63
                --]]
                if tick() - u54 >= 0.2 then
                    u64:Disconnect()
                    _G.particleEnabled(u40, false)
                end
                local v66 = u31
                local v67 = CFrame.new
                local v68 = u53
                local v69 = math.rad(v68)
                local v70 = -math.cos(v69) * 10
                local v71 = u53
                local v72 = math.rad(v71)
                u62 = v66 * v67(0, v70, math.sin(v72) * 10).Position
                local v73 = u31
                local v74 = CFrame.new
                local v75 = u53 + -1260 * p65
                local v76 = math.rad(v75)
                local v77 = -math.cos(v76) * 10
                local v78 = u53 + -1260 * p65
                local v79 = math.rad(v78)
                u63 = v73 * v74(0, v77, math.sin(v79) * 10).Position
                u40.CFrame = CFrame.lookAt(u62, u63)
                u53 = u53 + -1260 * p65
            end)
            local v80, v81, v82 = _G.getRayFloor(u31 * CFrame.new(0, 0, -9), 10)
            if v80 then
                local u83 = u6.FloorSlashed:Clone()
                u83.CFrame = CFrame.lookAt(v81, v81 + u31.LookVector, v82)
                u83.Parent = u35
                _G.customEmit(u83)
                local u84 = u28:Create(u83.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["Color3"] = Color3.new(0, 0, 0)
                })
                u84:Play()
                task.delay(0.7, function() --[[ Line: 273 ]]
                    --[[
                    Upvalues:
                        [1] = u84
                        [2] = u28
                        [3] = u83
                    --]]
                    u84:Destroy()
                    task.wait(0.3)
                    local v85 = u28:Create(u83.Decal, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1
                    })
                    v85:Play()
                    task.wait(0.8)
                    v85:Destroy()
                    u83:Destroy()
                end)
            end
        end)
        local v86 = u53
        for _ = 1, 6 do
            u26(v86, u40, v34, u35, p30)
            task.wait(u4:NextNumber(0, 0.05))
        end
        _G.destroy(u35, 4)
    elseif p30 == "Second" then
        local u87 = Instance.new("Folder")
        u87.Parent = workspace.Effects
        u87.Name = "EffectsFolder"
        local u88 = u31 * CFrame.Angles(0, -1.0471975511965976, 1.5707963267948966)
        local u89 = u6.GreenSlash:Clone()
        u89.CFrame = u88 * CFrame.Angles(0, 0, 1.5707963267948966)
        u89.Decal.Texture = ""
        u89.Parent = workspace.Effects
        local v90 = u6.Shine:Clone()
        v90.Position = u88.Position
        v90.Parent = u87
        _G.customEmit(v90)
        task.spawn(function() --[[ Line: 316 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u89
            --]]
            for _, v91 in pairs(u1) do
                u89.Decal.Texture = v91
                task.wait(0.01)
            end
        end)
        local u92 = u6.SlashTrail:Clone()
        if #p33 > 0 then
            for v93 = 1, #p33 do
                local u94 = p33[v93]
                task.spawn(function() --[[ Line: 330 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u88
                        [3] = u4
                        [4] = u87
                        [5] = u94
                        [6] = u32
                        [7] = u28
                        [8] = u92
                        [9] = u3
                        [10] = u2
                    --]]
                    task.spawn(function() --[[ Line: 334 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                            [2] = u88
                            [3] = u4
                            [4] = u87
                        --]]
                        for _ = 1, 10 do
                            task.spawn(function() --[[ Line: 336 ]]
                                --[[
                                Upvalues:
                                    [1] = u6
                                    [2] = u88
                                    [3] = u4
                                    [4] = u87
                                --]]
                                local v95 = u6.StabWindupBezier:Clone()
                                local v96 = (u88 * CFrame.new(u4:NextNumber(-10, 10), u4:NextNumber(-10, 10), u4:NextNumber(-10, 10))).Position
                                local v97 = (u88 * CFrame.new(u4:NextNumber(-10, 10), u4:NextNumber(-10, 10), u4:NextNumber(-10, 10))).Position
                                local v98 = (u88 * CFrame.new(u4:NextNumber(-10, 10), u4:NextNumber(-10, 10), u4:NextNumber(-10, 10))).Position
                                local v99 = u88.Position
                                v95.Position = v96
                                v95.Parent = u87
                                for v100 = 0, 1, 0.1 do
                                    local v101 = v96 + (v97 - v96) * v100
                                    local v102 = v97 + (v98 - v97) * v100
                                    local v103 = v98 + (v99 - v98) * v100
                                    local v104 = v101 + (v102 - v101) * v100
                                    v95.Position = v104 + (v102 + (v103 - v102) * v100 - v104) * v100
                                    task.wait()
                                end
                            end)
                            task.wait(u4:NextNumber(0.05, 0.08))
                        end
                    end)
                    task.delay(0, function() --[[ Line: 366 ]]
                        --[[
                        Upvalues:
                            [1] = u94
                            [2] = u32
                            [3] = u6
                            [4] = u87
                            [5] = u28
                            [6] = u92
                            [7] = u4
                            [8] = u3
                            [9] = u2
                        --]]
                        local v105 = CFrame.new
                        local v106 = u94.PrimaryPart.Position
                        local v107 = u32.PrimaryPart.Position.X
                        local v108 = u94.PrimaryPart.Position.Y
                        local v109 = u32.PrimaryPart.Position.Z
                        local v110 = v105(v106, (Vector3.new(v107, v108, v109)))
                        local u111 = u6.ConeStab:Clone()
                        u111.CFrame = v110 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 8)
                        u111.Decal.Texture = ""
                        u111.Parent = u87
                        u111.Mesh.Scale = Vector3.new(0, 0, 0)
                        u28:Create(u111.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ["Scale"] = Vector3.new(15, 15, 10)
                        }):Play()
                        local v112 = u28:Create(u111.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Scale"] = Vector3.new(0, 0, 7)
                        })
                        u28:Create(u111, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["CFrame"] = u111.CFrame * CFrame.new(0, 0, -5)
                        }):Play()
                        v112:Play()
                        local u113 = u6.StabParticle:Clone()
                        u113.CFrame = v110
                        u113.Parent = u87
                        _G.customEmit(u113)
                        for _ = 1, 6 do
                            task.spawn(function() --[[ Line: 402 ]]
                                --[[
                                Upvalues:
                                    [1] = u6
                                    [2] = u92
                                    [3] = u4
                                    [4] = u113
                                    [5] = u87
                                    [6] = u3
                                --]]
                                local v114 = u6.MiniSlashTrail:Clone()
                                local _ = u92.CFrame
                                local u115 = 0
                                local u116 = -u4:NextNumber(30, 70)
                                local u117 = u113.CFrame * CFrame.new(u4:NextNumber(-4, 4), u4:NextNumber(-4, 4), 0)
                                local u118 = u117.Position
                                local u119 = nil
                                local u120 = nil
                                v114.Position = u118
                                local u121 = u4:NextNumber(0, 360)
                                local u122 = u4:NextNumber(5, 10) * u4:NextNumber(-60, 60)
                                local u123 = u4:NextNumber(2, 5)
                                local u124 = u4:NextNumber(2, 5)
                                local u125 = u4:NextNumber(2, 5)
                                local u126 = u6.MiniSlashTrail:Clone()
                                u126.Parent = u87
                                local u127 = nil
                                local u128 = tick()
                                u127 = u3.Heartbeat:Connect(function(p129) --[[ Line: 431 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u118
                                        [2] = u117
                                        [3] = u115
                                        [4] = u119
                                        [5] = u116
                                        [6] = u120
                                        [7] = u126
                                        [8] = u121
                                        [9] = u123
                                        [10] = u124
                                        [11] = u125
                                        [12] = u122
                                        [13] = u128
                                        [14] = u4
                                        [15] = u127
                                    --]]
                                    u118 = (u117 * CFrame.new(0, 0, -u115)).Position
                                    u119 = (u117 * CFrame.new(0, 0, -u115 - u116)).Position
                                    u120 = CFrame.lookAt(u118, u119)
                                    u115 = u115 + u116 * p129
                                    local v130 = u126
                                    local v131 = u120
                                    local v132 = CFrame.new
                                    local v133 = u121
                                    local v134 = math.rad(v133)
                                    local v135 = math.sin(v134) * u123
                                    local v136 = u121
                                    local v137 = math.rad(v136)
                                    local v138 = math.cos(v137) * u124
                                    local v139 = u121
                                    local v140 = math.rad(v139)
                                    v130.CFrame = v131 * v132(v135, v138, math.cos(v140) * u125)
                                    u121 = u121 + u122 * p129
                                    if tick() - u128 >= u4:NextNumber(0.3, 0.5) then
                                        u127:Disconnect()
                                        _G.particleEnabled(u126, false)
                                    end
                                end)
                            end)
                        end
                        local v141, v142, _ = _G.getRayFloor(v110, 10)
                        if v141 then
                            warn("found ground")
                            local v143 = u6.StabWindEmit:Clone()
                            v143.CFrame = CFrame.lookAt(v142, v142 + u94.PrimaryPart.CFrame.LookVector + Vector3.new(0, -0.05, 0))
                            v143.Parent = u87
                            for _, v144 in pairs(v143:GetDescendants()) do
                                if v144:IsA("ParticleEmitter") then
                                    v144.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v141.Color), ColorSequenceKeypoint.new(1, v141.Color) })
                                end
                            end
                            _G.customEmit(v143)
                        end
                        task.spawn(function() --[[ Line: 477 ]]
                            --[[
                            Upvalues:
                                [1] = u2
                                [2] = u111
                            --]]
                            for _, v145 in pairs(u2) do
                                u111.Decal.Texture = v145
                                task.wait(0.01)
                            end
                        end)
                        local v146 = u6.SecondImpact:Clone()
                        v146.CFrame = v110 * CFrame.Angles(3.141592653589793, 0, 0)
                        v146.Parent = u87
                        for _, v147 in pairs(v146:GetDescendants()) do
                            if v147:IsA("ParticleEmitter") then
                                if v147:GetAttribute("ReColor") == true and v141 then
                                    v147.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v141.Color), ColorSequenceKeypoint.new(1, v141.Color) })
                                end
                                _G.customEmit(v147)
                            end
                        end
                    end)
                end)
            end
        end
        local u148 = 0
        local u149 = tick()
        task.spawn(function() --[[ Line: 511 ]]
            --[[
            Upvalues:
                [1] = u88
                [2] = u148
                [3] = u92
                [4] = u3
                [5] = u149
                [6] = u5
                [7] = u6
                [8] = u87
            --]]
            local v150 = u88
            local v151 = CFrame.new
            local v152 = u148
            local v153 = math.rad(v152)
            local v154 = -math.cos(v153) * 10
            local v155 = u148
            local v156 = math.rad(v155)
            local u157 = v150 * v151(0, v154, math.sin(v156) * 10).Position
            u92.Position = u157
            u92.Parent = workspace.Effects
            local u158 = nil
            local u159 = nil
            local u160 = nil
            u160 = u3.Heartbeat:Connect(function(p161) --[[ Line: 523 ]]
                --[[
                Upvalues:
                    [1] = u149
                    [2] = u160
                    [3] = u92
                    [4] = u157
                    [5] = u88
                    [6] = u148
                    [7] = u158
                    [8] = u159
                    [9] = u5
                    [10] = u6
                    [11] = u87
                --]]
                if tick() - u149 >= 0.2 then
                    u160:Disconnect()
                    _G.particleEnabled(u92, false)
                end
                local v162 = u88
                local v163 = CFrame.new
                local v164 = u148
                local v165 = math.rad(v164)
                local v166 = -math.cos(v165) * 10
                local v167 = u148
                local v168 = math.rad(v167)
                u157 = v162 * v163(0, v166, math.sin(v168) * 10).Position
                local v169 = u88
                local v170 = CFrame.new
                local v171 = u148 + -1260 * p161
                local v172 = math.rad(v171)
                local v173 = -math.cos(v172) * 10
                local v174 = u148 + -1260 * p161
                local v175 = math.rad(v174)
                u158 = v169 * v170(0, v173, math.sin(v175) * 10).Position
                u159 = workspace:Raycast(u158, Vector3.new(0, -10, 0), u5)
                if u159 and u159.Normal.Y == 1 then
                    local v176 = workspace:Raycast(u88.Position, Vector3.new(0, -10, 0), u5)
                    if v176 and v176.Position then
                        local v177 = u6.FloorWindEmit:Clone()
                        v177.CFrame = CFrame.lookAt(u159.Position, v176.Position)
                        v177.Parent = u87
                        for _, v178 in pairs(v177:GetDescendants()) do
                            if v178:IsA("ParticleEmitter") then
                                v178.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u159.Instance.Color), ColorSequenceKeypoint.new(1, u159.Instance.Color) })
                                _G.customEmit(v178)
                            end
                        end
                    end
                end
                u92.CFrame = CFrame.lookAt(u157, u158)
                u148 = u148 + -1260 * p161
                task.wait()
            end)
        end)
        local v179 = u148
        for _ = 1, 6 do
            u26(v179, u92, v34, u87, p30)
            task.wait(u4:NextNumber(0, 0.05))
        end
        _G.destroy(u87, 4)
    end
end
return v27