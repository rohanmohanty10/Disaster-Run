 

local v1 = {}
game:GetService("Debris")
local u2 = script.VFX:GetScale()
local u3 = script.VFX
local u13 = {
    ["Linear"] = function(p4) --[[ Name: Linear, Line 9 ]]
        return p4
    end,
    ["Quad"] = function(p5) --[[ Name: Quad, Line 10 ]]
        return p5 * p5
    end,
    ["Cubic"] = function(p6) --[[ Name: Cubic, Line 11 ]]
        return p6 * p6 * p6
    end,
    ["Quart"] = function(p7) --[[ Name: Quart, Line 12 ]]
        return p7 * p7 * p7 * p7
    end,
    ["Quint"] = function(p8) --[[ Name: Quint, Line 13 ]]
        return p8 * p8 * p8 * p8 * p8
    end,
    ["Sine"] = function(p9) --[[ Name: Sine, Line 14 ]]
        local v10 = p9 * 3.141592653589793 / 2
        return 1 - math.cos(v10)
    end,
    ["Exp"] = function(p11) --[[ Name: Exp, Line 15 ]]
        if p11 == 0 then
            return 0
        end
        local v12 = 10 * (p11 - 1)
        return math.pow(2, v12)
    end
}
local function u17(p14, p15, p16) --[[ Line: 42 ]]
    if p16 == "In" then
        return p15(p14)
    elseif p16 == "Out" then
        return 1 - p15(1 - p14)
    elseif p16 == "InOut" then
        if p14 < 0.5 then
            return p15(p14 * 2) / 2
        else
            return 1 - p15((1 - p14) * 2) / 2
        end
    else
        return p14
    end
end
function DisableBeams(p18, u19, p20, p21)
    --[[
    Upvalues:
        [1] = u13
        [2] = u17
    --]]
    if p18 then
        local u22 = u13[p20 or "Linear"] or u13.Linear
        local u23 = p21 or "Out"
        for _, u24 in pairs(p18:GetDescendants()) do
            if u24:IsA("Beam") then
                task.spawn(function() --[[ Line: 68 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                        [2] = u19
                        [3] = u17
                        [4] = u22
                        [5] = u23
                    --]]
                    local v25 = u24
                    local v26 = v25.Transparency.Keypoints
                    local v27 = {}
                    for v28, v29 in ipairs(v26) do
                        v27[v28] = v29.Value
                    end
                    local v30 = tick()
                    while true do
                        local v31 = (tick() - v30) / u19
                        local v32 = math.clamp(v31, 0, 1)
                        local v33 = u17(v32, u22, u23)
                        local v34 = {}
                        for v35, v36 in ipairs(v26) do
                            local v37 = v27[v35] + (1 - v27[v35]) * v33
                            v34[v35] = NumberSequenceKeypoint.new(v36.Time, v37)
                        end
                        v25.Enabled = false
                        v25.Transparency = NumberSequence.new(v34)
                        v25.Enabled = true
                        task.wait()
                        if v32 >= 1 then
                            return
                        end
                    end
                end)
            end
        end
    end
end
local u38 = game:GetService("TweenService")
function TweenProperty(p39, p40, p41, p42, p43, p44)
    --[[
    Upvalues:
        [1] = u38
    --]]
    if p39 then
        if p44 == nil then
            p44 = false
        end
        return u38:Create(p39, TweenInfo.new(p40, Enum.EasingStyle[p41], Enum.EasingDirection[p42], 0, p44), p43)
    end
end
function TweenVelocity(p45, p46, p47, p48, p49, p50, p51, p52)
    local v53 = p52 or Instance.new("BodyVelocity")
    v53.Parent = p45
    v53.Velocity = p46
    v53.MaxForce = p48
    return {
        ["Velocity"] = v53,
        ["Tween"] = TweenProperty(v53, p51, p49, p50, {
            ["Velocity"] = p47
        })
    }
end
local function u59(p54, p55, p56, p57) --[[ Line: 127 ]]
    for _, u58 in pairs(p54:GetDescendants()) do
        if u58:IsA("Beam") then
            TweenProperty(u58, p55, p56, p57, {
                ["Width0"] = 0,
                ["Width1"] = 0
            }):Play()
            task.delay(p55, function() --[[ Line: 131 ]]
                --[[
                Upvalues:
                    [1] = u58
                --]]
                u58.Enabled = false
            end)
        end
    end
end
function EnableBeams(p60, p61)
    for _, v62 in pairs(p60:GetDescendants()) do
        if v62:IsA("Beam") then
            v62.Enabled = true
            local v63 = v62.Brightness
            local v64 = v62.LightEmission
            v62.Brightness = 0
            v62.LightEmission = 1
            local v65 = TweenInfo.new(p61)
            game:GetService("TweenService"):Create(v62, v65, {
                ["LightEmission"] = v64,
                ["Brightness"] = v63
            }):Play()
        end
        if v62:IsA("Trail") then
            v62.Enabled = true
        end
    end
end
local function u74(p66, p67) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v68 = u3.Ring1:Clone()
    v68.CFrame = p66 * CFrame.new(0, 0, -15 * p67) * CFrame.Angles(1.5707963267948966, 0, 0)
    local v69 = Instance.new("Model")
    v69.Parent = workspace.Effects
    local v70 = v68.Parent
    v68.Parent = v69
    v69:ScaleTo(p67)
    v68.Parent = v70
    v69:Destroy()
    v68.Parent = workspace.Effects
    TweenProperty(v68, 1, "Quad", "Out", {
        ["CFrame"] = p66 * CFrame.Angles(1.5707963267948966, 0, 0),
        ["Size"] = v68.Size * 1.25
    }):Play()
    TweenProperty(v68, 1, "Sine", "Out", {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v68, 1)
    local v71 = u3.Wind2:Clone()
    v71.CFrame = p66 * CFrame.new(0, 0, -3 * p67) * CFrame.Angles(0, -1.5707963267948966, 0)
    local v72 = v71.Wind2Mesh
    v72.Scale = v72.Scale * p67
    v71.Transparency = 0.5
    v71.Parent = workspace.Effects
    TweenProperty(v71, 0.34, "Cubic", "Out", {
        ["CFrame"] = v71.CFrame * CFrame.new(-6.162 * p67, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
    }):Play()
    TweenProperty(v71, 0.34, "Sine", "Out", {
        ["Transparency"] = 1
    }):Play()
    TweenProperty(v71.Wind2Mesh, 0.34, "Cubic", "Out", {
        ["Scale"] = Vector3.new(2.237, 0.363, 0.363) * p67
    }):Play()
    _G.destroy(v71, 0.34)
    local v73 = u3.Swirl1:Clone()
    v73.CFrame = p66 * CFrame.new(0, 0, -3 * p67) * CFrame.Angles(1.5707963267948966, 0, 0)
    v73.Size = v73.Size * p67
    v73.Transparency = 0.825
    v73.Parent = workspace.Effects
    TweenProperty(v73, 1.27, "Quad", "Out", {
        ["Size"] = Vector3.new(23, 41.295, 23) * p67,
        ["CFrame"] = v73.CFrame * CFrame.new(0, -17.7 * p67, 0) * CFrame.Angles(0, 1.7453292519943295, 0)
    }):Play()
    TweenProperty(v73, 1.27, "Sine", "Out", {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v73, 1.27)
end
local function u78(p75) --[[ Line: 200 ]]
    local v76 = RaycastParams.new()
    v76.FilterType = Enum.RaycastFilterType.Include
    v76.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    local v77 = workspace:Raycast(p75, Vector3.new(0, -25, 0), v76)
    if v77 then
        return true, v77
    else
        return false
    end
end
local function u93(p79, p80) --[[ Line: 235 ]]
    local v81 = #p80 - 1
    local v82 = Vector3.new()
    for v83 = 0, v81 do
        local v84 = 1 - p79
        local v85 = v81 - v83
        local v86 = math.pow(v84, v85) * math.pow(p79, v83)
        local v87
        if v83 == 0 or v83 == v81 then
            v87 = 1
        elseif v81 < v83 then
            v87 = 0
        else
            local v88 = 1
            for v89 = v81, v81 - v83 + 1, -1 do
                v88 = v88 * v89
            end
            local v90 = 1
            for v91 = 1, v83 do
                v90 = v90 * v91
            end
            v87 = v88 / v90
        end
        local v92 = v86 * v87
        v82 = v82 + p80[v83 + 1] * v92
    end
    return v82
end
local function u104(p94, p95, p96) --[[ Line: 247 ]]
    --[[
    Upvalues:
        [1] = u93
    --]]
    local v97 = tick()
    local v98 = 0
    while v98 < p96 and p94:GetAttribute("HitboxHit") == nil do
        local v99 = (v98 + 0.01) / p96
        local v100 = math.min(1, v99)
        local v101 = v98 / p96
        local v102 = u93(math.min(1, v101), p95)
        local v103 = u93(v100, p95)
        p94.CFrame = CFrame.new(v102)
        p94.CFrame = CFrame.lookAt(p94.Position, v103)
        task.wait()
        v98 = tick() - v97
    end
end
function CreateRandomBezier(u105, u106, u107, p108, p109, u110, u111)
    --[[
    Upvalues:
        [1] = u104
    --]]
    local u112 = nil
    local v113 = CFrame.lookAt(u107, p108)
    local v114 = v113.RightVector * math.random(-p109, p109)
    local v115 = math.random(p109 / 2, p109)
    local v116 = v113.UpVector * v115
    local u117, u118
    if u106 == "Quadratic" then
        u117 = p108
        u118 = u107:Lerp(u117, math.random(10, 90) * 0.01) + v114 + v116
    else
        u118 = nil
        u117 = nil
    end
    if u106 == "Cubic" then
        u112 = p108
        local v119 = math.random(10, 35) * 0.01
        local v120 = math.random(40, 65) * 0.01
        local v121 = v113.RightVector * math.random(-p109, p109)
        local v122 = v113.UpVector * math.random(v115 / 4, v115)
        u118 = u107:Lerp(u112, v119) + v114 + v116
        u117 = u107:Lerp(u112, v120) + v121 + v122
    end
    task.spawn(function() --[[ Line: 304 ]]
        --[[
        Upvalues:
            [1] = u106
            [2] = u107
            [3] = u118
            [4] = u117
            [5] = u112
            [6] = u104
            [7] = u105
            [8] = u110
            [9] = u111
        --]]
        os.clock()
        local v123 = nil
        local v124
        if u106 == "Quadratic" then
            v124 = { u107, u118, u117 }
        else
            v124 = u106 == "Cubic" and {
                u107,
                u118,
                u117,
                u112
            } or v123
        end
        u104(u105, v124, u110)
        u111()
    end)
end
local u169 = {
    ["Start"] = function(u125) --[[ Line: 318 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local _ = u125.Humanoid
        local u126 = u125.HumanoidRootPart
        u125:WaitForChild("Head")
        _G.PlaySound(u125.PrimaryPart, script.WaterRapierSharkSlashStart).Parent = u125.PrimaryPart
        task.delay(0.26, function() --[[ Line: 325 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u126
                [3] = u125
            --]]
            local v127 = u3.Windup.Attachment:Clone()
            v127.Parent = u126
            _G.destroy(v127, 3)
            _G.customEmit(v127)
            _G.customEmit(u125["Swordfish Rapier"])
        end)
    end,
    ["Shoot"] = function(p128, p129) --[[ Line: 333 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u74
            [3] = u2
            [4] = u59
        --]]
        local v130 = u3.Pierce:Clone()
        v130.CFrame = p129 * CFrame.new(0, -2, 0)
        local v131, _, _ = _G.getRayFloor(p129, 7)
        if v131 then
            _G.recolorParticles(v130, v131.Color)
        else
            v130:FindFirstChild("Rocks", true):Destroy()
        end
        v130.Parent = workspace.Effects
        _G.customEmit(v130)
        _G.destroy(v130, 4)
        DisableBeams(v130, 1.5, "Quad", "Out")
        for _, v132 in pairs(v130:GetDescendants()) do
            if v132:IsA("Beam") then
                TweenProperty(v132, 1.5, "Quad", "Out", {
                    ["TextureSpeed"] = -0.2
                }):Play()
            end
        end
        u74(p129, 1 * u2)
        local v133 = u3.Beams:Clone()
        v133:PivotTo(v130.CFrame * CFrame.Angles(1.5707963267948966, 0, 0))
        v133.Parent = workspace.Effects
        _G.destroy(v133, 0.5)
        for _, v134 in pairs(v133:GetDescendants()) do
            if v134:IsA("Attachment") and v134.Name == "Main" then
                local v135 = math.random(-360, 360)
                v134.Orientation = Vector3.new(0, v135, 0)
                local v136 = v134.Parent.Beam
                v136.Width0 = v136.Width0 * 3
                local v137 = v134.Parent.Beam
                v137.Width1 = v137.Width1 * 3
                local v138 = TweenProperty
                local v139 = {}
                local v140 = v134.Orientation
                local v141 = math.random(-180, 180)
                v139.Orientation = v140 + Vector3.new(0, v141, 0)
                v138(v134, 0.275, "Cubic", "Out", v139):Play()
                u59(v134.Parent, 0.2, "Sine", "Out")
            end
        end
        _G.PlaySound(p128.PrimaryPart, script.WaterRapierSharkSlashDash).Parent = p128.PrimaryPart
    end,
    ["End"] = function(_, u142, u143, p144) --[[ Line: 379 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u78
        --]]
        local u145 = u142.PrimaryPart
        if u145 then
            local u146 = false
            local v147 = u142.Humanoid:LoadAnimation(script.charLoop)
            v147:Play()
            local u148 = u142:FindFirstChild("UpperTorso") or u142.PrimaryPart
            local u149 = u3.Bubble:Clone()
            u149:PivotTo(CFrame.new(u148.Position) * CFrame.Angles(1.5707963267948966, 0, 0))
            u149:ScaleTo(0.5)
            u149.Parent = workspace.Effects
            _G.customEmit(u149.Sphere)
            local u150 = u149.Sphere
            local u151 = true
            pcall(function() --[[ Line: 18 ]]
                --[[
                Upvalues:
                    [1] = u150
                    [2] = u151
                --]]
                local u152 = u150:GetDescendants()
                for u153 = 1, #u152 do
                    if u152[u153]:IsA("ParticleEmitter") then
                        local v154 = u152[u153]:GetAttribute("EmitDelay") or 0
                        task.delay(v154, function() --[[ Line: 23 ]]
                            --[[
                            Upvalues:
                                [1] = u152
                                [2] = u153
                                [3] = u151
                            --]]
                            u152[u153].Enabled = u151
                        end)
                    end
                end
            end)
            EnableBeams(u149["3"], 0.5)
            TweenProperty(u149["3"].Attachment, 5, "Linear", "Out", {
                ["Orientation"] = u149["3"].Orientation + Vector3.new(0, -1800, 0)
            }):Play()
            task.spawn(function() --[[ Line: 404 ]]
                --[[
                Upvalues:
                    [1] = u149
                    [2] = u148
                    [3] = u146
                    [4] = u142
                --]]
                while true do
                    u149:PivotTo(CFrame.new(u148.Position) * CFrame.Angles(1.5707963267948966, 0, 0))
                    if u146 then
                        break
                    end
                    task.wait()
                    if u146 or u142:GetAttribute("CallDeepBubble") == nil then
                        break
                    end
                end
            end)
            task.wait(0.35)
            local v155 = 25 * u2
            local v156 = CFrame.new(u145.Position)
            local u157 = {
                v156 * CFrame.new(v155, 0, v155),
                v156 * CFrame.new(-v155, 0, v155),
                v156 * CFrame.new(-v155, 0, -v155),
                v156 * CFrame.new(v155, 0, -v155)
            }
            for u158 = 1, p144 do
                task.spawn(function() --[[ Line: 441 ]]
                    --[[
                    Upvalues:
                        [1] = u157
                        [2] = u158
                        [3] = u78
                        [4] = u3
                        [5] = u145
                        [6] = u149
                        [7] = u143
                    --]]
                    local v159, v160 = u78(u157[u158].Position)
                    if v159 and v160.Instance then
                        local v161 = u3.SharkSpawn:Clone()
                        v161.Position = v160.Position
                        _G.recolorParticles(v161, v160.Instance.Color)
                        v161.Parent = workspace.Effects
                        _G.destroy(v161, 2)
                        _G.customEmit(v161)
                        local u162 = u3.Shark:Clone()
                        u162.Primary.CFrame = v161.CFrame
                        u162.Parent = workspace.Effects
                        local function v163() --[[ Line: 458 ]]
                            --[[
                            Upvalues:
                                [1] = u145
                                [2] = u149
                                [3] = u162
                            --]]
                            _G.PlaySound(u145, script.SharkHit)
                            _G.customEmit(u149.Explosion)
                            u162:Destroy()
                        end
                        _G.PlaySound(v161.CFrame, script.WaterRapierSharkSlashSharkSpawn, {
                            ["RandomPitch"] = true
                        }).Parent = u162.Primary
                        CreateRandomBezier(u162.Primary, "Cubic", v160.Position, u145.Position, 25, u143, v163)
                    end
                end)
                task.wait(0.1)
            end
            task.wait(u143)
            v147:Stop()
            u149.Sphere.Transparency = 1
            local u164 = false
            pcall(function() --[[ Line: 18 ]]
                --[[
                Upvalues:
                    [1] = u149
                    [2] = u164
                --]]
                local u165 = u149:GetDescendants()
                for u166 = 1, #u165 do
                    if u165[u166]:IsA("ParticleEmitter") then
                        local v167 = u165[u166]:GetAttribute("EmitDelay") or 0
                        task.delay(v167, function() --[[ Line: 23 ]]
                            --[[
                            Upvalues:
                                [1] = u165
                                [2] = u166
                                [3] = u164
                            --]]
                            u165[u166].Enabled = u164
                        end)
                    end
                end
            end)
            EnableBeams(u149.Explosion, 0.25)
            for _, v168 in pairs(u149:GetDescendants()) do
                if v168:IsA("Beam") then
                    TweenProperty(v168, 0.5, "Quad", "Out", {
                        ["TextureSpeed"] = 0.2
                    }):Play()
                end
            end
            task.wait(0.25)
            DisableBeams(u149, 1)
            TweenProperty(u149.Sphere, 0.1, "Sine", "InOut", {
                ["CFrame"] = u149.Sphere.CFrame
            }, true):Play()
            _G.destroy(u149, 3)
            local _ = true
        end
    end
}
function v1.start(_, p170, p171, ...) --[[ Line: 499 ]]
    --[[
    Upvalues:
        [1] = u169
    --]]
    if u169[p171] then
        u169[p171](p170, ...)
    end
end
return v1