 

local u1 = game:GetService("RunService")
local u2 = require(game:GetService("ReplicatedStorage").Modules.EffectsUtil)
local u3 = game:GetService("TweenService")
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Whitelist
u4.FilterDescendantsInstances = { workspace.Env, workspace.Islands }
local v5 = {}
local u6 = Random.new()
function rAngle()
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6:NextNumber(0, 6.283185307179586)
end
function debrisRock(p7, p8, p9)
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v10 = workspace:Raycast(p8.Position + Vector3.new(0, 6, 0), Vector3.new(0, -8, 0), u4)
    if v10 then
        local v11 = p7:Clone()
        v11:PivotTo(CFrame.new(v10.Position) * CFrame.Angles(u6:NextNumber(0, 6.283185307179586), u6:NextNumber(0, 6.283185307179586), u6:NextNumber(0, 6.283185307179586)))
        _G.matchMaterial(v11.Bot, v10.Instance)
        local v12 = math.random(50, 125) / 100
        local v13 = v11.Bot
        v13.Size = v13.Size * v12
        v11.Bot.Trail.Color = ColorSequence.new(v11.Bot.Color)
        v11.Parent = workspace.Effects
        local v14 = v11.Bot
        local v15 = u6:NextNumber(-1, 1)
        local v16 = u6:NextNumber(0, 1)
        local v17 = u6
        v14:ApplyImpulse(Vector3.new(v15, v16, v17:NextNumber(-1, 1)) * p9 / 2)
        _G.destroy(v11, 5)
    end
end
function trails(p18, u19, u20)
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
        [3] = u3
    --]]
    task.wait(u6:NextNumber(0, 0.3))
    local u21 = script.TrailPart:Clone()
    local v22 = u6:NextNumber(10, 15)
    local v23 = Vector3.new(v22, 0, 0)
    local v24 = u6:NextNumber(-6, 6)
    local v25 = Vector3.new(v24, 0, 0)
    local v26 = u21.Attachment1
    v26.Position = v26.Position + v23
    local v27 = u21.Attachment2
    v27.Position = v27.Position + v23
    u21.Trail.Color = p18
    u21.CFrame = u19
    local u28 = 0
    local u29 = u6:NextNumber(0.5, 1)
    local u30 = u19 * CFrame.new(0, u6:NextNumber(3, 7), 0)
    local u31 = u6:NextNumber(200, 350)
    local u32 = nil
    u32 = u1.Heartbeat:Connect(function(p33) --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u29
            [3] = u3
            [4] = u21
            [5] = u19
            [6] = u30
            [7] = u31
            [8] = u20
            [9] = u32
        --]]
        u28 = u28 + p33
        local v34 = u28 / u29
        local v35 = math.clamp(v34, 0, 1)
        local v36 = u3:GetValue(v35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v37 = u3:GetValue(v35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v38 = u21
        local v39 = u19:Lerp(u30, v36)
        local v40 = CFrame.Angles
        local v41 = u31 * v37 * u20
        v38.CFrame = v39 * v40(0, math.rad(v41), 0)
        if u29 <= u28 then
            u32:Disconnect()
        end
    end)
    local v42 = { 0.7, "Circular", Enum.EasingDirection.Out }
    u21.Parent = workspace.Effects
    _G.tween(u21.Attachment1, v42, {
        ["Position"] = u21.Attachment1.Position + v25
    })
    _G.tween(u21.Attachment2, v42, {
        ["Position"] = u21.Attachment2.Position + v25
    })
    task.delay(u6:NextNumber(0.1, 0.6), function() --[[ Line: 64 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u6
        --]]
        _G.tween(u21.Trail, { u6:NextNumber(0.2, 0.5), "Sine", Enum.EasingDirection.Out }, {
            ["WidthScale"] = NumberSequence.new(0)
        })
    end)
    _G.destroy(u21, 2)
end
function v5.start(_, p43, u44) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u2
    --]]
    if _G.checkRenderDistance(p43.PrimaryPart.Position) ~= false then
        local u45 = p43.HumanoidRootPart
        local u46 = CFrame.new(0, 0, -1.5)
        _G.PlaySound(u45, script.DragonBreath)
        task.wait(0.4166666666666667)
        local u47 = u45.CFrame * u46 * CFrame.new(0, -2.9, 0)
        if u44 then
            for u48 = 1, 25 do
                task.spawn(function() --[[ Line: 83 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u6
                        [3] = u48
                    --]]
                    local v49 = script.Flash:Clone()
                    v49.Parent = workspace.Effects
                    local v50 = u47
                    local v51 = CFrame.Angles
                    local v52 = u6:NextNumber(0, 360)
                    v49.CFrame = v50 * v51(0, math.rad(v52), 0) * CFrame.new(0, u48 / 100, 0)
                    v49.Size = v49.Size * u6:NextNumber(0.75, 1.25)
                    local v53 = u6:NextNumber(0.1, 0.6)
                    _G.tween(v49, { v53, "Quad", Enum.EasingDirection.Out }, {
                        ["Size"] = v49.Size * 2.52
                    })
                    _G.tween(v49.Decal, { v53, "Sine", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v49, 2)
                end)
            end
        end
        local u54 = script.Crater:Clone()
        if not u44 then
            u54.PointLight.Enabled = false
        end
        u54.Decal.Transparency = 1
        u54.Colored.Transparency = 1
        u54.CFrame = u45.CFrame * CFrame.new(0, -2.95, 0) * u46 * CFrame.Angles(0, u6:NextNumber(0, 6.283185307179586), 0)
        u54.Size = Vector3.new(25, 0.05, 25)
        u54.Parent = workspace.Effects
        _G.tween(u54, { 0.05, "Quint", Enum.EasingDirection.Out }, {
            ["Size"] = script.Crater.Size
        })
        _G.tween(u54.Decal, { 0.1, "Quart", Enum.EasingDirection.Out }, {
            ["Transparency"] = 0
        })
        if u44 then
            _G.tween(u54.Colored, { 0.1, "Quart", Enum.EasingDirection.Out }, {
                ["Transparency"] = 0
            })
        end
        _G.tween(u54.PointLight, { 1.5, "Sine", Enum.EasingDirection.Out }, {
            ["Brightness"] = 0
        })
        task.delay(0.5, function() --[[ Line: 112 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u54
            --]]
            if u44 then
                _G.tween(u54.Colored, { 1, "Quad", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
            end
            task.wait(0.5)
            _G.tween(u54.Decal, { 2, "Sine", Enum.EasingDirection.In }, {
                ["Transparency"] = 1
            })
            _G.destroy(u54, 2)
        end)
        task.spawn(function() --[[ Line: 121 ]]
            --[[
            Upvalues:
                [1] = u45
                [2] = u46
                [3] = u4
                [4] = u6
            --]]
            local v55 = script.Crack:Clone()
            local v56 = u45.CFrame * CFrame.new(0, -4, 0) * u46
            local v57 = CFrame.Angles
            local v58 = math.random(0, 360)
            v55:SetPrimaryPartCFrame(v56 * v57(0, math.rad(v58), 0))
            v55.Parent = workspace.Effects
            for _, v59 in pairs(v55:GetChildren()) do
                if v59.Name ~= "Root" then
                    local v60 = workspace:Raycast(v59.PrimaryPart.Position + Vector3.new(0, 2, 0), Vector3.new(0, -5, 0), u4)
                    if v60 then
                        _G.matchMaterial(v59.Top, v60.Instance)
                        v59.PrimaryPart.CFrame = v59.PrimaryPart.CFrame - v59.PrimaryPart.Position + v60.Position
                        v59.PrimaryPart.CFrame = v59.PrimaryPart.CFrame * CFrame.new(0, -4.25, 0)
                    else
                        v59:Destroy()
                    end
                end
            end
            for v61 = 1, 4 do
                for _, v62 in pairs(v55:GetChildren()) do
                    if v62.Name == tostring(v61) then
                        local v63 = _G.tween
                        local v64 = v62.PrimaryPart
                        local v65 = { 0.1 + u6:NextNumber(0, 0.1), "EntranceExpressive", "Out" }
                        local v66 = {}
                        local v67 = v62.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
                        local v68 = CFrame.Angles
                        local v69 = u6:NextNumber(-10, 10)
                        local v70 = math.rad(v69)
                        local v71 = u6:NextNumber(-10, 10)
                        local v72 = math.rad(v71)
                        local v73 = u6:NextNumber(-10, 10)
                        v66.CFrame = v67 * v68(v70, v72, (math.rad(v73)))
                        v63(v64, v65, v66)
                    end
                end
            end
            task.wait(1.5)
            _G.destroy(v55, 2)
            for _, v74 in pairs(v55:GetChildren()) do
                task.wait(0.03333333333333333)
                if v74.Name ~= "Root" then
                    _G.tween(v74.PrimaryPart, { 1, "Quart", "In" }, {
                        ["CFrame"] = v74.PrimaryPart.CFrame * CFrame.new(0, -4, 0)
                    })
                end
            end
        end)
        local v75 = script.GroundWind:Clone()
        v75.CFrame = u45.CFrame * CFrame.new(0, -2.75, 0) * u46 * CFrame.Angles(0, rAngle(), 0)
        v75.Mesh.Scale = Vector3.new(5, 0.25, 5)
        v75.Parent = workspace.Effects
        _G.tween(v75.Mesh, { 1.2, "Quart", Enum.EasingDirection.Out }, {
            ["Scale"] = script.GroundWind.Mesh.Scale * 1.1
        })
        _G.tween(v75.Decal, { 1, "Sine", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        local v76 = _G.tween
        local v77 = { 1.5, "Quart", Enum.EasingDirection.Out }
        local v78 = {}
        local v79 = v75.CFrame * CFrame.new(0, -0.3, 0)
        local v80 = CFrame.Angles
        local v81 = 90 + u6:NextNumber(-20, 20)
        v78.CFrame = v79 * v80(0, math.rad(v81), 0)
        v76(v75, v77, v78)
        _G.destroy(v75, 2)
        for _ = 1, 5 do
            local v82 = script.Ring:Clone()
            v82.CFrame = u45.CFrame * CFrame.new(0, -5, 0) * u46 * CFrame.Angles(rAngle(), rAngle(), rAngle())
            v82.Mesh.Scale = Vector3.new(0.05, 0.2, 0.2)
            local v83 = u6:NextNumber(0.4, 0.7)
            v82.Decal.Transparency = 0
            v82.Parent = workspace.Effects
            local v84 = _G.tween
            local v85 = v82.Mesh
            local v86 = { v83 + 0.2, "Quart", Enum.EasingDirection.Out }
            local v87 = {}
            local v88 = script.Ring.Mesh.Scale
            local v89 = u6:NextNumber(1, 3)
            v87.Scale = v88 * Vector3.new(v89, 1, 1) * u6:NextNumber(0.8, 1)
            v84(v85, v86, v87)
            _G.tween(v82.Decal, { v83, "Sine", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            local v90 = _G.tween
            local v91 = { v83 + 0.3, "Quad", Enum.EasingDirection.Out }
            local v92 = {}
            local v93 = v82.CFrame
            local v94 = CFrame.Angles
            local v95 = u6:NextNumber(-720, 720)
            local v96 = math.rad(v95)
            local v97 = u6:NextNumber(-720, 720)
            local v98 = math.rad(v97)
            local v99 = u6:NextNumber(-720, 720)
            v92.CFrame = v93 * v94(v96, v98, (math.rad(v99)))
            v90(v82, v91, v92)
            _G.destroy(v82, 2)
        end
        task.wait(1)
        local v100 = script.ForceField:Clone()
        v100.CFrame = u45.CFrame * CFrame.new(0, -7, 0) * u46
        v100.Size = Vector3.new(0, 0, 0)
        v100.Parent = workspace.Effects
        _G.tween(v100, { 0.66, "Quart", Enum.EasingDirection.Out }, {
            ["Size"] = script.ForceField.Size * 1.25
        })
        _G.tween(v100, { 0.4, "Sine", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        _G.destroy(v100, 1)
        local v101 = script.Shockwave:Clone()
        local v102 = v101.Mesh
        v102.Scale = v102.Scale * Vector3.new(0.5, 1, 0.5)
        v101.CFrame = u45.CFrame * CFrame.new(0, -1, 0) * u46
        v101.Parent = workspace.Effects
        _G.tween(v101.Mesh, { 0.4, "Quart", Enum.EasingDirection.Out }, {
            ["Scale"] = v101.Mesh.Scale * Vector3.new(2.5, 1, 2.5)
        })
        _G.tween(v101, { 0.4, "Quart", Enum.EasingDirection.Out }, {
            ["CFrame"] = v101.CFrame * CFrame.new(0, -2, 0)
        })
        _G.tween(v101.Decal, { 0.2, "Quad", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        _G.destroy(v101, 2)
        for u103 = 1, 4 do
            task.spawn(function() --[[ Line: 198 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u103
                    [3] = u45
                    [4] = u46
                    [5] = u4
                --]]
                task.wait(u6:NextInteger(0, 3) / 60)
                local v104 = u103 / 4 * 360 + 45
                local v105 = script.PillarSmall:Clone()
                local v106 = v105.Rock
                v106.CFrame = u45.CFrame * CFrame.new(0, -3, 0) * u46 * CFrame.Angles(0, math.rad(v104), 0) * CFrame.new(0, -10, -10) * CFrame.Angles(-0.3490658503988659, 0, 0) * CFrame.Angles(0, rAngle(), 0)
                local v107 = workspace:Raycast(v106.Position + Vector3.new(0, 12, 0), Vector3.new(0, -5, 0), u4)
                if v107 then
                    _G.matchMaterial(v105.Top, v107.Instance)
                    v106.CFrame = v106.CFrame - v106.Position + v107.Position + Vector3.new(0, -9.5, 0)
                    v105.Parent = workspace.Effects
                    local v108 = _G.tween
                    local v109 = { 0.1 + u6:NextNumber(0, 0.1), "Quart", Enum.EasingDirection.Out }
                    local v110 = {}
                    local v111 = v106.CFrame * CFrame.new(0, 5, 0)
                    local v112 = CFrame.Angles
                    local v113 = u6:NextNumber(-10, 10)
                    local v114 = math.rad(v113)
                    local v115 = u6:NextNumber(-10, 10)
                    local v116 = math.rad(v115)
                    local v117 = u6:NextNumber(-10, 10)
                    v110.CFrame = v111 * v112(v114, v116, (math.rad(v117)))
                    v108(v106, v109, v110)
                    task.wait(u6:NextNumber(1.6, 2))
                    game:GetService("TweenService"):Create(v106, TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        ["CFrame"] = v106.CFrame * CFrame.new(0, -3, 0)
                    }):Play()
                    _G.destroy(v105, 2)
                else
                    v106:Destroy()
                end
            end)
        end
        task.wait(0.4)
        for v118 = 1, 12 do
            local v119 = v118 / 4 * 360
            local u120 = u45.CFrame * u46 * CFrame.Angles(0, math.rad(v119), 0)
            task.spawn(function() --[[ Line: 228 ]]
                --[[
                Upvalues:
                    [1] = u120
                --]]
                trails(ColorSequence.new(Color3.fromRGB(0, 0, 0)), u120, -1)
            end)
            task.spawn(function() --[[ Line: 231 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u120
                --]]
                local v121 = u44 and ColorSequence.new(Color3.fromRGB(255, 54, 28)) or ColorSequence.new(Color3.new(1, 1, 1))
                trails(v121, u120, 1)
            end)
        end
        local u122 = script.Crater:Clone()
        u122.Decal.Transparency = 1
        u122.Colored.Transparency = 1
        u122.CFrame = u45.CFrame * CFrame.new(0, -2.92, 0) * u46 * CFrame.Angles(0, u6:NextNumber(0, 6.283185307179586), 0)
        u122.Size = Vector3.new(25, 0.05, 25)
        u122.Parent = workspace.Effects
        if not u44 then
            u122.Colored.Color3 = Color3.fromRGB(1000, 1000, 1000)
            u122.PointLight.Color = Color3.new(1, 1, 1)
        end
        _G.tween(u122, { 0.1, "Quint", Enum.EasingDirection.Out }, {
            ["Size"] = script.Crater.Size * 1.1
        })
        _G.tween(u122.Decal, { 0.1, "Quart", Enum.EasingDirection.Out }, {
            ["Transparency"] = 0
        })
        _G.tween(u122.Colored, { 0.1, "Quart", Enum.EasingDirection.Out }, {
            ["Transparency"] = 0
        })
        _G.tween(u122.PointLight, { 1.5, "Sine", Enum.EasingDirection.Out }, {
            ["Brightness"] = 0
        })
        task.delay(0.5, function() --[[ Line: 251 ]]
            --[[
            Upvalues:
                [1] = u122
            --]]
            _G.tween(u122.Colored, { 1, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            task.wait(1)
            _G.tween(u122.Decal, { 1, "Sine", Enum.EasingDirection.In }, {
                ["Transparency"] = 1
            })
            _G.destroy(u122, 2)
        end)
        local v123 = script.GroundWind:Clone()
        v123.CFrame = u45.CFrame * CFrame.new(0, -2.75, 0) * u46 * CFrame.Angles(0, rAngle(), 0)
        v123.Mesh.Scale = Vector3.new(5, 0.25, 5)
        v123.Parent = workspace.Effects
        _G.tween(v123.Mesh, { 1.2, "Quart", Enum.EasingDirection.Out }, {
            ["Scale"] = script.GroundWind.Mesh.Scale * 1.3
        })
        _G.tween(v123.Decal, { 1, "Sine", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        local v124 = _G.tween
        local v125 = { 1.5, "Quart", Enum.EasingDirection.Out }
        local v126 = {}
        local v127 = v123.CFrame * CFrame.new(0, -0.3, 0)
        local v128 = CFrame.Angles
        local v129 = 90 + u6:NextNumber(-20, 20)
        v126.CFrame = v127 * v128(0, math.rad(v129), 0)
        v124(v123, v125, v126)
        _G.destroy(v123, 2)
        for _ = 1, 5 do
            local v130 = script.Ring:Clone()
            v130.CFrame = u45.CFrame * CFrame.new(0, -5, 0) * u46 * CFrame.Angles(rAngle(), rAngle(), rAngle())
            v130.Mesh.Scale = Vector3.new(0.05, 0.2, 0.2)
            local v131 = u6:NextNumber(0.4, 0.7)
            v130.Decal.Transparency = 0.4
            v130.Parent = workspace.Effects
            local v132 = _G.tween
            local v133 = v130.Mesh
            local v134 = { v131 + 0.2, "Quart", Enum.EasingDirection.Out }
            local v135 = {}
            local v136 = script.Ring.Mesh.Scale
            local v137 = u6:NextNumber(1, 3)
            v135.Scale = v136 * Vector3.new(v137, 1, 1) * u6:NextNumber(1, 1.3)
            v132(v133, v134, v135)
            _G.tween(v130.Decal, { v131, "Sine", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            local v138 = _G.tween
            local v139 = { v131 + 0.3, "Quad", Enum.EasingDirection.Out }
            local v140 = {}
            local v141 = v130.CFrame
            local v142 = CFrame.Angles
            local v143 = u6:NextNumber(-720, 720)
            local v144 = math.rad(v143)
            local v145 = u6:NextNumber(-720, 720)
            local v146 = math.rad(v145)
            local v147 = u6:NextNumber(-720, 720)
            v140.CFrame = v141 * v142(v144, v146, (math.rad(v147)))
            v138(v130, v139, v140)
            _G.destroy(v130, 2)
        end
        for u148 = 1, 4 do
            task.spawn(function() --[[ Line: 281 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u148
                    [3] = u45
                    [4] = u46
                    [5] = u4
                --]]
                task.wait(u6:NextInteger(0, 5) / 60)
                local v149 = u148 / 4 * 360
                local v150 = script.PillarBig:Clone()
                local v151 = v150.Rock
                v151.CFrame = u45.CFrame * CFrame.new(0, -3, 0) * u46 * CFrame.Angles(0, math.rad(v149), 0) * CFrame.new(0, -10, -10) * CFrame.Angles(-0.3490658503988659, 0, 0) * CFrame.Angles(0, rAngle(), 0)
                local v152 = workspace:Raycast(v151.Position + Vector3.new(0, 12, 0), Vector3.new(0, -5, 0), u4)
                if v152 then
                    _G.matchMaterial(v150.Top, v152.Instance)
                    v151.CFrame = v151.CFrame - v151.Position + v152.Position + Vector3.new(0, -10, 0)
                    v150.Parent = workspace.Effects
                    local v153 = _G.tween
                    local v154 = { 0.2 + u6:NextNumber(0, 0.1), "Quart", Enum.EasingDirection.Out }
                    local v155 = {}
                    local v156 = v151.CFrame * CFrame.new(0, 5, 0)
                    local v157 = CFrame.Angles
                    local v158 = u6:NextNumber(-10, 10)
                    local v159 = math.rad(v158)
                    local v160 = u6:NextNumber(-10, 10)
                    local v161 = math.rad(v160)
                    local v162 = u6:NextNumber(-10, 10)
                    v155.CFrame = v156 * v157(v159, v161, (math.rad(v162)))
                    v153(v151, v154, v155)
                    for _ = 1, 15 do
                        debrisRock(script.DebrisRock, u45.CFrame * CFrame.new(0, -3, 0) * u46 * CFrame.Angles(0, math.rad(v149), 0) * CFrame.new(0, 0, -6), Vector3.new(0.2, 0.4, 0.2))
                    end
                    task.wait(u6:NextNumber(1.25, 1.75))
                    game:GetService("TweenService"):Create(v151, TweenInfo.new(0.76, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        ["CFrame"] = v151.CFrame * CFrame.new(0, -5, 0)
                    }):Play()
                    _G.destroy(v150, 2)
                else
                    v151:Destroy()
                end
            end)
        end
        local v163 = script.Particles:Clone()
        if not u44 then
            v163.Attachment.ParticleEmitter:Destroy()
            v163.Attachment.Ring.Color = ColorSequence.new(Color3.new(1, 1, 1))
            v163.Burst.Color = ColorSequence.new(Color3.new(1, 1, 1))
            v163.Burst.Transparency = NumberSequence.new(0.9, 1)
        end
        v163.CFrame = u45.CFrame * CFrame.new(0, -3, 0) * u46
        v163.Parent = workspace.Effects
        u2:Emit(v163)
        _G.destroy(v163, 2)
    end
end
return v5