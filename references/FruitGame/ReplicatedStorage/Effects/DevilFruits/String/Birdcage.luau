 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local function u26(p3, p4) --[[ Line: 12 ]]
    local v5 = {}
    for v6 = 1, 20 do
        local v7 = v6 / 20 * 360
        local v8 = script.Rock1:Clone()
        v8:ScaleTo(p4)
        local v9 = p3 * CFrame.new(0, -2 * p4, 0) * CFrame.Angles(0, math.rad(v7), 0) * CFrame.new(0, 0, -18 * p4) * CFrame.Angles(-0.3490658503988659, 0, 0)
        local v10 = CFrame.Angles
        local v11 = math.random(-15, 15)
        local v12 = math.rad(v11)
        local v13 = math.random(-15, 15)
        local v14 = math.rad(v13)
        local v15 = math.random(-15, 15)
        v8:PivotTo(v9 * v10(v12, v14, (math.rad(v15))))
        table.insert(v5, v8)
        v8.Parent = workspace.Effects
    end
    for v16 = 1, 28 do
        local v17 = v16 / 28 * 360
        local v18 = script.Rock2:Clone()
        v18:ScaleTo(p4)
        local v19 = p3 * CFrame.new(0, -1.5 * p4, 0) * CFrame.Angles(0, math.rad(v17), 0) * CFrame.new(0, 0, -15 * p4) * CFrame.Angles(0.3490658503988659, 0, 0)
        local v20 = CFrame.Angles
        local v21 = math.random(-15, 15)
        local v22 = math.rad(v21)
        local v23 = math.random(-15, 15)
        local v24 = math.rad(v23)
        local v25 = math.random(-15, 15)
        v18:PivotTo(v19 * v20(v22, v24, (math.rad(v25))))
        table.insert(v5, v18)
        v18.Parent = workspace.Effects
    end
    return v5
end
local u27 = RaycastParams.new()
u27.FilterType = Enum.RaycastFilterType.Include
u27.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, p28, p29, p30) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u2
        [3] = u26
    --]]
    if _G.checkRenderDistance(p29.Position) ~= false then
        local _ = game:GetService("Players").LocalPlayer
        local _ = p28.HumanoidRootPart
        local v31 = script.Origin:Clone()
        v31.CFrame = p29
        v31.Parent = workspace.Effects
        local v32 = workspace:Raycast((v31.CFrame * CFrame.new(0, 2, 0)).Position, Vector3.new(0, -50, 0), u27)
        if v32 then
            v31.Position = v32.Position
        end
        local v33 = {}
        local v34 = v31.CFrame
        local v35 = p30 == nil and 0 or p30
        local v36 = 40
        if v35 then
            v36 = v36 + v35
        end
        local u37 = v36 / 40
        local v38 = u37 * 250
        local v39 = Ray.new(v34.Position + Vector3.new(0, 10, 0), v34.upVector * -v38)
        local v40, v41, v42 = _G.raycastWhitelist(v39, { workspace.Islands, workspace.Ships, workspace.Env })
        local v43 = (v34.Position - v41).Magnitude
        local v44 = CFrame.new(v41, v41 + v42) * CFrame.Angles(-1.5707963267948966, 0, 0)
        _G.PlaySound(v31.CFrame, script.StringCage)
        local v45 = CFrame.new(0, 0, -v36)
        for v46 = 1, 60 do
            local v47 = v46 * 6
            local v48 = v31.CFrame * CFrame.Angles(0, math.rad(v47), 0) * v45
            local v49 = workspace
            local v50 = (v48 * CFrame.new(0, 2, 0)).Position
            local v51 = -v38
            local u52 = v49:Raycast(v50, Vector3.new(0, v51, 0), u27)
            if u52 then
                local v53 = CFrame.new(u52.Position, v31.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                local u54 = script.Start:Clone()
                u54.CFrame = v31.CFrame * CFrame.new(0, u37 * 30, 0)
                local v55 = u54.Origin
                local v56 = v47 - 90
                v55.Orientation = Vector3.new(0, v56, 0)
                local v57 = u54.Origin
                local v58 = u37 * 30
                v57.Position = Vector3.new(0, v58, 0)
                u54.Origin.Parent = v31
                u54.Parent = workspace.Effects
                u2:Create(u54.Beam, TweenInfo.new(2 + math.random(-50, 100) / 100, Enum.EasingStyle.Elastic), {
                    ["CurveSize0"] = 0,
                    ["CurveSize1"] = u37 * 40
                }):Play()
                table.insert(v33, u54)
                local u59 = 0.6 + math.random(-20, 20) / 100
                _G.tween(u54, { u59, "EntranceExpressive", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v53
                })
                task.spawn(function() --[[ Line: 103 ]]
                    --[[
                    Upvalues:
                        [1] = u59
                        [2] = u52
                        [3] = u54
                    --]]
                    task.wait(u59)
                    if u52.Instance ~= nil then
                        _G.PlayEffect("FloorTrail2", nil, u54, nil, Color3.fromRGB(213, 104, 14), Color3.fromRGB(0, 0, 0), 1, 0.1, nil, nil, 4)
                        u54.Start.Smoke.Color = ColorSequence.new(u52.Instance.Color)
                        u54.Start.Smoke.Enabled = true
                        u54.Start.Heat.Enabled = true
                    end
                end)
            end
        end
        for _, v60 in v31:GetChildren() do
            local v61 = u2
            local v62 = TweenInfo.new(2.05 + math.random(-5, 5) / 100, Enum.EasingStyle.Elastic, Enum.EasingDirection.In)
            local v63 = {}
            local v64 = -v43
            v63.Position = Vector3.new(0, v64, 0)
            v61:Create(v60, v62, v63):Play()
        end
        task.wait(0.6)
        _G.tween(v31, { 1.2, "Sine", Enum.EasingDirection.InOut }, {
            ["CFrame"] = v31.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
        })
        task.wait(0.2)
        for _, v65 in v33 do
            local v66 = _G.tween
            local v67 = { 1.1 + math.random(-10, 10) / 100, "Quad", Enum.EasingDirection.InOut }
            local v68 = {}
            local v69 = CFrame.new
            local v70 = v31.Position.X
            local v71 = v65.Position.Y
            local v72 = v31.Position.Z
            v68.CFrame = v69(Vector3.new(v70, v71, v72), v65.Position) * CFrame.new(0, 0, -v36 / 2)
            v66(v65, v67, v68)
        end
        task.wait(0.2)
        for _, v73 in v33 do
            u2:Create(v73.Beam, TweenInfo.new(3 + math.random(-50, 100) / 100, Enum.EasingStyle.Elastic), {
                ["CurveSize0"] = u37 * -2,
                ["CurveSize1"] = u37 * 10
            }):Play()
        end
        task.wait(1)
        _G.PlaySound(v31.CFrame, script.StringCageBoom)
        v31:Destroy()
        for v74, v75 in v33 do
            local v76 = v75.Start.Smoke
            v76.Enabled = false
            v76.Parent = workspace.Terrain
            local v77 = v75.Start.Heat
            v77.Enabled = false
            v77.Parent = workspace.Terrain
            _G.destroy(v76, 3)
            _G.destroy(v77, 3)
            v75:Destroy()
            v33[v74] = nil
        end
        local v78 = v44 * CFrame.new(0, -0.5, 0)
        local v79 = script.Dust:Clone()
        v79.CFrame = v78
        v79.Parent = workspace.Effects
        _G.customEmit(v79.ParticleEmitter)
        _G.destroy(v79, 3)
        if v40 then
            local v80 = script.ImpactModel:Clone()
            v80:ScaleTo(u37)
            v80:SetPrimaryPartCFrame(v78)
            v80.PrimaryPart.Attachment.Rocks.Color = ColorSequence.new(v40.Color)
            v80.PrimaryPart.Attachment.sm2.Color = ColorSequence.new(v40.Color)
            v80.Parent = workspace.Effects
            _G.customEmit(v80)
            _G.destroy(v80, 4)
        end
        local u81 = u26(v44 * CFrame.new(0, u37 * -1, 0), u37)
        for v82, v83 in u81 do
            local v84 = workspace
            local v85 = v83.PrimaryPart.Position
            local v86 = u37 * 6
            local v87 = v85 + Vector3.new(0, v86, 0)
            local v88 = u37 * -8
            local v89 = v84:Raycast(v87, Vector3.new(0, v88, 0), u27)
            if v89 then
                _G.matchMaterial(v83.Top, v89.Instance)
                v83:PivotTo(v83.PrimaryPart.CFrame * CFrame.new(0, u37 * -4, 0))
                local v90 = 0.05 + math.random(0, 50) / 1000
                if v83.Name == "Rock1" then
                    v90 = v90 + 0.06666666666666667
                end
                _G.tween(v83.PrimaryPart, { v90, "Quad", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v83.PrimaryPart.CFrame * CFrame.new(0, u37 * 4, 0)
                })
            else
                v83:Destroy()
                u81[v82] = nil
            end
        end
        task.delay(1.5, function() --[[ Line: 192 ]]
            --[[
            Upvalues:
                [1] = u81
                [2] = u37
            --]]
            for _, v91 in u81 do
                _G.tween(v91.PrimaryPart, { 0.5 + math.random(0, 200) / 1000, "Quint", Enum.EasingDirection.In }, {
                    ["CFrame"] = v91.PrimaryPart.CFrame * CFrame.new(0, u37 * -6, 0)
                })
                _G.destroy(v91, 0.6)
            end
        end)
        local v92 = script.Winds:Clone()
        local v93 = v92.Shockwave:Clone()
        v93.CFrame = v78
        v93.Parent = workspace.Effects
        local v94 = _G.tween
        local v95 = { 0.2, "Quad", Enum.EasingDirection.Out }
        local v96 = {}
        local v97 = u37 * 90
        local v98 = u37 * 0.25
        local v99 = u37 * 90
        v96.Size = Vector3.new(v97, v98, v99)
        v94(v93, v95, v96)
        _G.tween(v93.Decal, { 0.2, "Quad", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.destroy(v93, 0.2)
        local v100 = v92.Bean:Clone()
        local v101 = v78 * CFrame.new(0, 0.5, 0)
        local v102 = CFrame.Angles
        local v103 = math.random(0, 360)
        v100.CFrame = v101 * v102(0, math.rad(v103), 0)
        v100.Parent = workspace.Effects
        local v104 = _G.tween
        local v105 = v100.Mesh
        local v106 = { 1.2, "Quad", Enum.EasingDirection.Out }
        local v107 = {}
        local v108 = u37 * 25
        local v109 = u37 * 3.25
        local v110 = u37 * 25
        v107.Scale = Vector3.new(v108, v109, v110)
        v104(v105, v106, v107)
        _G.tween(v100, { 1.4, "Quad", Enum.EasingDirection.Out }, {
            ["CFrame"] = v100.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
        })
        _G.tween(v100.Decal, { 1.2, "Quad", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.destroy(v100, 1.2)
        local v111 = v92.White1:Clone()
        local v112 = CFrame.Angles
        local v113 = math.random(0, 360)
        v111.CFrame = v78 * v112(-1.5707963267948966, 0, (math.rad(v113))) * CFrame.new(0, 0, 2.5)
        v111.Parent = workspace.Effects
        local v114 = _G.tween
        local v115 = { 1, "Quad", Enum.EasingDirection.Out }
        local v116 = {
            ["Transparency"] = 1
        }
        local v117 = u37 * 70
        local v118 = u37 * 70
        local v119 = u37 * 6
        v116.Size = Vector3.new(v117, v118, v119)
        v116.CFrame = v111.CFrame * CFrame.new(0, 0, u37 * -5.7) * CFrame.Angles(0, 0, 1.5707963267948966)
        v114(v111, v115, v116)
        _G.destroy(v111, 1)
        local v120 = v92.White2:Clone()
        local v121 = CFrame.Angles
        local v122 = math.random(0, 360)
        v120.CFrame = v78 * v121(-1.5707963267948966, 0, (math.rad(v122))) * CFrame.new(0, 0, 3)
        v120.Parent = workspace.Effects
        local v123 = _G.tween
        local v124 = { 0.8, "Quad", Enum.EasingDirection.Out }
        local v125 = {
            ["Transparency"] = 1
        }
        local v126 = u37 * 60
        local v127 = u37 * 60
        local v128 = u37 * 6
        v125.Size = Vector3.new(v126, v127, v128)
        v125.CFrame = v120.CFrame * CFrame.new(0, 0, u37 * -6.2) * CFrame.Angles(0, 0, 1.5707963267948966)
        v123(v120, v124, v125)
        _G.destroy(v120, 0.8)
        local v129 = v92.White1:Clone()
        v129.CFrame = v111.CFrame * CFrame.Angles(0, 0, 3.141592653589793)
        v129.Parent = workspace.Effects
        local v130 = _G.tween
        local v131 = { 1.1333333333333335, "Quad", Enum.EasingDirection.Out }
        local v132 = {
            ["Transparency"] = 1
        }
        local v133 = u37 * 90
        local v134 = u37 * 90
        local v135 = u37 * 6
        v132.Size = Vector3.new(v133, v134, v135)
        v132.CFrame = v111.CFrame * CFrame.new(0, 0, u37 * -6.2) * CFrame.Angles(0, 0, -1.5707963267948966)
        v130(v129, v131, v132)
        _G.destroy(v129, 1.1333333333333335)
        local v136 = v92.Reds:Clone()
        v136.Parent = workspace.Effects
        local v137 = CFrame.Angles
        local v138 = math.random(0, 360)
        v136:PivotTo(v78 * v137(0, math.rad(v138), 0))
        for _, v139 in v136:GetChildren() do
            if v139.Name ~= "Root" then
                local v140 = u37 * 10
                local v141 = u37 * 10
                local v142 = u37 * 15
                v139.Size = Vector3.new(v140, v141, v142)
                local v143 = 0.5 + math.random(-10, 20) / 100
                local v144 = math.random(40, 50) * u37
                local v145 = v139.CFrame
                local v146 = CFrame.Angles
                local v147 = math.random(0, 360)
                v139.CFrame = v145 * v146(0, 0, (math.rad(v147)))
                _G.tween(v139, { v143, "Quad", Enum.EasingDirection.Out }, {
                    ["Size"] = Vector3.new(v144, v144, 0)
                })
                _G.tween(v139, { v143 + 0.2, "Sine", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v139.CFrame * CFrame.Angles(0, 0, -3.12413936106985)
                })
                _G.tween(v139, { v143, "Quint", Enum.EasingDirection.In }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v139, v143)
            end
        end
        _G.destroy(v136, 0.7)
    end
end
return v1