 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = {}
local u4 = Random.new()
local u5 = {
    ["Meshes"] = {},
    ["Winds"] = {},
    ["Rocks"] = {},
    ["Tornados"] = {}
}
local u6 = nil
local u7 = 0
local u8 = RaycastParams.new()
local v9 = { workspace.Islands, workspace.Env, workspace.Ships }
local v10 = Enum.RaycastFilterType.Include
u8.FilterDescendantsInstances = v9
u8.FilterType = v10
local u11 = {}
local u12 = {}
local u13 = {}
local u14 = math.cos
local u15 = math.sin
local u16 = math.rad
function Toggle(p17, p18)
    for _, v19 in p17:GetDescendants() do
        if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
            v19.Enabled = p18
        end
    end
end
function GetFromCache(p20, _, p21)
    local v22 = p21 and "fire" or "normal"
    if not p20[v22] then
        p20[v22] = {}
    end
    if #p20[v22] > 0 then
        return table.remove(p20[v22])
    else
        return nil
    end
end
function ReturnToCache(p23, p24, p25)
    local v26 = p25 and "fire" or "normal"
    if not p23[v26] then
        p23[v26] = {}
    end
    if #p23[v26] < 10 then
        p24.Parent = nil
        local v27 = p23[v26]
        table.insert(v27, p24)
    else
        p24:Destroy()
    end
end
function SpawnWind(p28, p29, p30)
    --[[
    Upvalues:
        [1] = u4
        [2] = u12
        [3] = u2
        [4] = u5
        [5] = u7
        [6] = u6
    --]]
    Random.new(p30)
    local v31 = CFrame.new(0, u4:NextNumber(-p28.Size.Y / 2, p28.Size.Y / 2), 0)
    local v32 = CFrame.Angles(0, u4:NextNumber(0, -3.141592653589793, 3.141592653589793, 0), 0)
    local u33 = u4:NextInteger(1, 4)
    local u34 = u12[u33] and table.remove(u12[u33]) or script["Wind" .. u33]:Clone()
    u34.CFrame = p28.CFrame * v31 * v32
    u34.Decal.Transparency = u4:NextNumber(0.5, 0.85)
    u34.Decal.Color3 = p29
    u34.Parent = workspace.Effects
    local v35 = u4:NextNumber(0.35, 0.425)
    local u36 = u2:Create(u34.Decal, TweenInfo.new(v35), {
        ["Transparency"] = 1
    })
    local u37 = u2:Create(u34.Mesh, TweenInfo.new(u4:NextNumber(0.425, 0.525), Enum.EasingStyle.Quint), {
        ["Scale"] = u34.Mesh.Scale * u4:NextNumber(1.75, 2.75)
    })
    u36:Play()
    u37:Play()
    local v38 = u34.Mesh
    v38.Scale = v38.Scale * u4:NextNumber(0.15, 0.25)
    local u39 = Instance.new("NumberValue")
    u39.Value = 0
    local v40 = u2:Create(u39, TweenInfo.new(0.4), {
        ["Value"] = u4:NextNumber(p28.Size.Y / 2, p28.Size.Y)
    })
    v40:Play()
    v40.Completed:Connect(function() --[[ Line: 92 ]]
        --[[
        Upvalues:
            [1] = u39
        --]]
        u39:Destroy()
    end)
    local v41 = u5.Winds
    table.insert(v41, {
        ["Mesh"] = u34,
        ["Base"] = p28,
        ["Height"] = u39,
        ["Pos"] = v31,
        ["Ang"] = v32,
        ["Rotation"] = 0,
        ["WindIndex"] = u33
    })
    u7 = u7 + 1
    if not u6 then
        StartMainLoop()
    end
    u36.Completed:Once(function() --[[ Line: 112 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u37
            [3] = u12
            [4] = u33
            [5] = u34
        --]]
        u36:Destroy()
        u37:Destroy()
        if not u12[u33] then
            u12[u33] = {}
        end
        if #u12[u33] < 10 then
            u34.Parent = nil
            u34.Decal.Transparency = 0.5
            u34.Mesh.Scale = Vector3.new(1, 1, 1)
            local v42 = u12[u33]
            local v43 = u34
            table.insert(v42, v43)
        else
            u34:Destroy()
        end
    end)
end
function StartMainLoop()
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
        [3] = u7
        [4] = u5
        [5] = u16
        [6] = u2
        [7] = u13
        [8] = u14
        [9] = u15
    --]]
    if u6 then
        u6:Disconnect()
        u6 = nil
    end
    u6 = u1.Heartbeat:Connect(function(p44) --[[ Line: 134 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u6
            [3] = u5
            [4] = u16
            [5] = u2
            [6] = u13
            [7] = u14
            [8] = u15
        --]]
        if u7 <= 0 then
            u6:Disconnect()
            u6 = nil
        else
            local v45 = {}
            local v46 = {}
            local v47 = workspace:GetServerTimeNow()
            local v48 = #u5.Meshes
            if v48 > 0 then
                for v49 = v48, 1, -1 do
                    local v50 = u5.Meshes[v49]
                    if v50.Mesh and v50.Mesh.Parent then
                        v45[#v45 + 1] = v50.Mesh
                        v46[#v46 + 1] = v50.Base.CFrame * CFrame.new(0, v50.Height.Value, 0) * v50.Pos * v50.Ang
                    else
                        table.remove(u5.Meshes, v49)
                        u7 = u7 - 1
                    end
                end
            end
            local v51 = #u5.Winds
            if v51 > 0 then
                for v52 = v51, 1, -1 do
                    local v53 = u5.Winds[v52]
                    if v53.Mesh and v53.Mesh.Parent then
                        v53.Rotation = v53.Rotation + p44 * 180
                        v45[#v45 + 1] = v53.Mesh
                        v46[#v46 + 1] = v53.Base.CFrame * CFrame.new(0, v53.Height.Value, 0) * v53.Pos * v53.Ang * CFrame.Angles(0, u16(v53.Rotation), 0)
                    else
                        table.remove(u5.Winds, v52)
                        u7 = u7 - 1
                    end
                end
            end
            local v54 = #u5.Rocks
            if v54 > 0 then
                for v55 = v54, 1, -1 do
                    local u56 = u5.Rocks[v55]
                    local v57 = u56.Base
                    if v47 - u56.Clock >= u56.Time or not v57:IsDescendantOf(workspace) then
                        u56.AngularVelocity:Destroy()
                        u56.Pos:Destroy()
                        Toggle(u56.Rock, false)
                        u2:Create(u56.Rock, TweenInfo.new(0.425), {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                        task.delay(0.5, function() --[[ Line: 188 ]]
                            --[[
                            Upvalues:
                                [1] = u13
                                [2] = u56
                            --]]
                            if #u13 < 20 then
                                u56.Rock.Parent = nil
                                u56.Rock.Size = Vector3.new(0, 0, 0)
                                Toggle(u56.Rock, false)
                                local v58 = u13
                                local v59 = {
                                    ["Rock"] = u56.Rock,
                                    ["FireMode"] = u56.FireMode
                                }
                                table.insert(v58, v59)
                            else
                                u56.Rock:Destroy()
                            end
                        end)
                        table.remove(u5.Rocks, v55)
                        u7 = u7 - 1
                    else
                        u56.Angle = u56.Angle - 720 * p44 / u56.Time / 2
                        u56.YMod = u56.YMod + u56.YSpeed * p44 / u56.Time
                        local v60 = u16(u56.Angle)
                        local v61 = u14(v60) * u56.Radius
                        local v62 = u15(v60) * u56.Radius
                        local v63 = Vector3.new(v61, 0, v62)
                        local v64 = u56.Pos
                        local v65 = v57.Position + v63
                        local v66 = v57.Size.Y / 2
                        local v67 = v65 - Vector3.new(0, v66)
                        local v68 = u56.YMod * v57.Size.Y
                        v64.Position = v67 + Vector3.new(0, v68)
                    end
                end
            end
            local v69 = #u5.Tornados
            if v69 > 0 then
                for v70 = v69, 1, -1 do
                    local v71 = u5.Tornados[v70]
                    if -v71.TornadoSpeed * v71.LocalSpeed > 0 and v71.StartAngle >= v71.EndAngle or -v71.TornadoSpeed * v71.LocalSpeed < 0 and v71.StartAngle <= v71.EndAngle then
                        Toggle(v71.Emitter, false)
                        Toggle(v71.Outer, false)
                        local v72 = v71.Emitter:FindFirstChild("TwisterSFX")
                        if v72 then
                            u2:Create(v72, TweenInfo.new(1), {
                                ["Volume"] = 0
                            }):Play()
                        end
                        _G.destroy(v71.Emitter, 2.5)
                        _G.destroy(v71.Outer, 2.5)
                        table.remove(u5.Tornados, v70)
                        u7 = u7 - 1
                    else
                        if v47 - v71.RockRate >= 0.15 then
                            v71.RockRate = v47
                            SpawnRock(v71.Outer, v71.FireMode)
                        end
                        if v47 - v71.MeshRate >= 0.15 then
                            v71.MeshRate = v47
                            SpawnMesh(v71.Outer, v71.HitColor)
                        end
                        local v73 = v71.TornadoData
                        v71.RotationAngle = v71.RotationAngle + p44 * v73.RotSpeed
                        v71.StartAngle = v71.StartAngle - p44 * v73.TornadoSpeed * v71.LocalSpeed
                        local v74 = u16(v71.StartAngle)
                        local v75 = v71.Center * CFrame.new(u14(v74) * v73.Radius, 0, u15(v74) * v73.Radius)
                        v45[#v45 + 1] = v71.Emitter
                        v46[#v46 + 1] = v75
                        v45[#v45 + 1] = v71.Outer
                        v46[#v46 + 1] = v71.Emitter.CFrame * CFrame.new(0, v71.Outer.Size.Y / 2, 0) * CFrame.Angles(0, u16(v71.RotationAngle), 0)
                    end
                end
            end
            if #v45 > 0 then
                workspace:BulkMoveTo(v45, v46, Enum.BulkMoveMode.FireCFrameChanged)
            end
        end
    end)
end
function SpawnMesh(p76, p77)
    --[[
    Upvalues:
        [1] = u4
        [2] = u11
        [3] = u2
        [4] = u5
        [5] = u7
        [6] = u6
    --]]
    local v78 = CFrame.new(0, -p76.Size.Y / 2, 0)
    local v79 = CFrame.Angles(0, u4:NextNumber(0, -3.141592653589793, 3.141592653589793, 0), 0)
    local u80 = u4:NextInteger(1, 2)
    local u81 = u11[u80] and table.remove(u11[u80]) or script["Mesh" .. u80]:Clone()
    u81.CFrame = p76:GetPivot() * v78 * v79
    u81.Parent = workspace.Effects
    u81.Transparency = 0.75
    u81.Color = p77:Lerp(Color3.new(0.85, 0.85, 0.85), 0.125)
    local v82 = u4:NextNumber(0.35, 0.425)
    local v83 = u2:Create(u81, TweenInfo.new(v82), {
        ["Transparency"] = 1,
        ["Size"] = u81.Size * u4:NextNumber(1.75, 2.65)
    })
    v83:Play()
    u81.Size = u81.Size * u4:NextNumber(0.2, 0.3)
    local u84 = Instance.new("NumberValue")
    u84.Value = 0
    u2:Create(u84, TweenInfo.new(0.4), {
        ["Value"] = u4:NextNumber(p76.Size.Y / 2, p76.Size.Y)
    }):Play()
    local v85 = u5.Meshes
    table.insert(v85, {
        ["Mesh"] = u81,
        ["Base"] = p76,
        ["Height"] = u84,
        ["Pos"] = v78,
        ["Ang"] = v79,
        ["MeshIndex"] = u80
    })
    u7 = u7 + 1
    if not u6 then
        StartMainLoop()
    end
    v83.Completed:Connect(function() --[[ Line: 309 ]]
        --[[
        Upvalues:
            [1] = u84
            [2] = u11
            [3] = u80
            [4] = u81
        --]]
        u84:Destroy()
        if not u11[u80] then
            u11[u80] = {}
        end
        if #u11[u80] < 10 then
            u81.Parent = nil
            u81.Transparency = 0
            u81.Size = Vector3.new(1, 1, 1)
            local v86 = u11[u80]
            local v87 = u81
            table.insert(v86, v87)
        else
            u81:Destroy()
        end
    end)
end
function SpawnRock(p88, p89)
    --[[
    Upvalues:
        [1] = u4
        [2] = u16
        [3] = u14
        [4] = u15
        [5] = u8
        [6] = u13
        [7] = u2
        [8] = u5
        [9] = u7
        [10] = u6
    --]]
    local _ = Enum.Material.Rock
    Color3.fromRGB(98, 83, 71)
    local v90 = u4:NextNumber(8, 24)
    local v91 = u4:NextNumber(0, 360)
    local v92 = u14((u16(v91))) * v90
    local v93 = u15((u16(v91))) * v90
    local v94 = Vector3.new(v92, 0, v93)
    local v95 = workspace:Raycast(p88.Position + v94, Vector3.new(0, -76, 0), u8)
    if not (v95 and v95.Instance) then
        return
    end
    local _ = v95.Material
    local _ = v95.Instance.Color
    local v96 = Vector3.new(1, 1, 1) * u4:NextNumber(2.75, 4.75)
    local v97 = nil
    for v98 = #u13, 1, -1 do
        if u13[v98].FireMode == p89 then
            v97 = table.remove(u13, v98).Rock
            break
        end
    end
    local v99 = v97 or script[p89 and "FireRocks" or "FloatingRocks"]:Clone()
    _G.matchMaterial(v99, v95.Instance)
    v99.CanCollide = false
    v99.CastShadow = false
    v99.Size = Vector3.new(0, 0, 0)
    v99.Anchored = false
    local v100 = p88.Position + v94
    local v101 = p88.Size.Y / 2
    v99.Position = v100 - Vector3.new(0, v101)
    local v102 = v99:FindFirstChild("BodyPosition") or Instance.new("BodyPosition")
    v102.Position = v99.Position
    v102.P = 65000
    v102.MaxForce = Vector3.new(70000, 70000, 70000)
    v102.Parent = v99
    local v103 = v99:FindFirstChild("BodyAngularVelocity") or Instance.new("BodyAngularVelocity")
    v103.AngularVelocity = u4:NextUnitVector() * 5
    v103.MaxTorque = Vector3.new(75000, 75000, 75000)
    v103.Parent = v99
    if not p89 then
        local v104 = v95.Instance.Color
        local v105 = nil or 0.8
        local v106 = Color3.new(v104.R * v105, v104.G * v105, v104.B * v105)
        for _, v107 in v99:GetChildren() do
            if v107:IsA("Attachment") then
                local v108 = (v107.Name == "Left" and -1 or 1) * v96.X / 2
                v107.Position = Vector3.new(v108, 0, 0)
            elseif v107:IsA("Trail") then
                v107.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v106), ColorSequenceKeypoint.new(1, v106) })
            end
        end
    end
    v99.Parent = workspace.Effects
    u2:Create(v99, TweenInfo.new(0.1), {
        ["Size"] = v96
    }):Play()
    local v109 = u4:NextNumber(0.65, 0.85)
    local v110 = u5.Rocks
    local v111 = {
        ["Rock"] = v99,
        ["Base"] = p88,
        ["Pos"] = v102,
        ["AngularVelocity"] = v103,
        ["Time"] = v109,
        ["Clock"] = workspace:GetServerTimeNow(),
        ["YMod"] = 0,
        ["YSpeed"] = u4:NextNumber(0.5, 1),
        ["Angle"] = v91,
        ["Radius"] = v90,
        ["FireMode"] = p89
    }
    table.insert(v110, v111)
    u7 = u7 + 1
    if not u6 then
        StartMainLoop()
    end
end
function CreateTornado(p112, p113, p114, p115)
    --[[
    Upvalues:
        [1] = u4
        [2] = u8
        [3] = u5
        [4] = u7
        [5] = u6
    --]]
    local v116, v117
    if p113 then
        v116 = "FireTatsumaki"
        v117 = "FireOuter"
    else
        v116 = "TatsumakiCenter"
        v117 = "Outer"
    end
    local v118 = script[v116]:Clone()
    v118:PivotTo(p112)
    local v119 = script[v117]:Clone()
    v119:PivotTo(p112 * CFrame.new(0, v119.Size.Y / 2, 0))
    local v120 = p114.EndAngle
    local v121 = p112 * CFrame.new(0, 0, -(p114.Radius + 1))
    local v122 = u4:NextNumber(0, 0.1)
    local v123 = Color3.fromRGB(98, 83, 71)
    local v124 = workspace:Raycast(v119.Position, Vector3.new(0, -250, 0), u8)
    if not p113 and (v124 and v124.Instance) then
        local v125 = v124.Instance.Color
        local v126 = nil or 0.8
        v123 = Color3.new(v125.R * v126, v125.G * v126, v125.B * v126)
        local v127 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v123), ColorSequenceKeypoint.new(1, v123) })
        for _, v128 in v118:GetDescendants() do
            if v128:IsA("ParticleEmitter") and not v128:GetAttribute("Fire") then
                v128.Color = v127
            end
        end
        for _, v129 in v119:GetDescendants() do
            if v129:IsA("ParticleEmitter") and not v129:GetAttribute("Fire") then
                v129.Color = v127
            end
        end
    end
    local v130 = script.SFX.Normal
    if p113 ~= nil then
        v130 = script.SFX.Fire
    end
    v118.Parent = workspace.Effects
    v119.Parent = workspace.Effects
    local v131 = v130:GetChildren()[math.random(1, 3)]:Clone()
    v131.Name = "TwisterSFX"
    v131.Parent = v118
    v131:Play()
    local v132 = p114.LocalSpeed
    local v133 = u5.Tornados
    local v134 = {
        ["Emitter"] = v118,
        ["Outer"] = v119,
        ["FireMode"] = p113,
        ["HitColor"] = v123,
        ["StartAngle"] = 90,
        ["EndAngle"] = v120,
        ["RotationAngle"] = 0,
        ["Center"] = v121,
        ["LocalSpeed"] = v132,
        ["Clock"] = p115,
        ["MeshRate"] = p115,
        ["RockRate"] = p115,
        ["NextMesh"] = v122,
        ["TornadoSpeed"] = p114.TornadoSpeed,
        ["TornadoData"] = p114
    }
    table.insert(v133, v134)
    u7 = u7 + 1
    if not u6 then
        StartMainLoop()
    end
end
function v3.start(_, _, p135, p136, p137, p138) --[[ Line: 507 ]]
    CreateTornado(p135, p138, p136, p137)
end
return v3