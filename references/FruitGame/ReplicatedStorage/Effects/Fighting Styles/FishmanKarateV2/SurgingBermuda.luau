 

local v1 = {}
local u2 = script.Parent.Assets
local _ = u2.Z
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local u4 = game:GetService("TweenService")
local u5 = game["Run Service"]
local v6 = RaycastParams.new()
v6.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
v6.FilterType = Enum.RaycastFilterType.Include
local function u15(p7, ...) --[[ Line: 12 ]]
    local v8 = { ... }
    local v9 = #v8 - 2
    if v9 >= 0 then
        local v10 = nil
        for v11 = 1, #v8 do
            local v12 = v9 + 1
            local v13 = (v11 == 1 or v11 == #v8) and 1 or v12
            local v14 = (1 - p7) ^ (v9 + 1 - (v11 - 1)) * p7 ^ (v9 - (-v11 + v9 + 1)) * v13 * v8[v11]
            if v10 then
                v10 = v10 + v14
            else
                v10 = v14
            end
        end
        return v10
    end
    warn("Not enough Points")
end
local u16 = RaycastParams.new()
u16.FilterType = Enum.RaycastFilterType.Include
u16.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
function v1.start(_, u17, p18, p19, p20, _) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u15
        [3] = u3
        [4] = u5
        [5] = u16
        [6] = u4
    --]]
    local u21 = u17.PrimaryPart
    local _ = u17.Humanoid
    local _ = u2.C
    if _G.checkRenderDistance(u17.PrimaryPart.Position) == false then
        return
    end
    if p18 == "hold" then
        local u22 = u2.V
        local _ = u21.CFrame * CFrame.new(0, 0, -3).Position
        local v23 = tick()
        local v24 = 0
        while true do
            if tick() - v24 >= 0.03 and tick() - v23 <= 0.4 then
                v24 = tick()
                task.spawn(function() --[[ Line: 68 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u22
                        [3] = u15
                    --]]
                    local v25 = u21.Position
                    local v26 = Random.new():NextNumber(-2, 2)
                    local v27 = Random.new():NextNumber(-3, 3)
                    local v28 = Random.new()
                    local v29 = v25 + Vector3.new(v26, v27, v28:NextNumber(-2, 2)) * Random.new():NextNumber(5, 7)
                    local v30 = u22.CurveCharge:Clone()
                    v30.CFrame = CFrame.new(v29) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                    v30.Parent = workspace.Effects
                    _G.destroy(v30, 1.5)
                    local v31 = 0
                    repeat
                        local v32 = v31 + task.wait() * 7
                        v31 = math.clamp(v32, 0, 1)
                        local v33 = {
                            [1] = v30.Position,
                            [1] = v30.CFrame * CFrame.new(1.35, 0, -1.6).Position,
                            [2] = v30.CFrame * CFrame.new(2.7, 0, -3.2).Position,
                            [3] = v30.CFrame * CFrame.new(4.050000000000001, 0, -4.800000000000001).Position,
                            [#v33 + 1] = u21.Position
                        }
                        v30.Position = u15(v31, unpack(v33))
                    until v31 == 1
                    _G.particleEnabled(v30, false)
                end)
            end
            task.wait()
            if not u17:GetAttribute("SurgingBermuda") then
                ::l9::
                return
            end
        end
    else
        if p18 == "dash" then
            local u34 = u2.V
            local u35 = Instance.new("Model")
            u35.Parent = workspace.Effects
            local u36 = u3.new()
            local u37 = u34.GroundPart:Clone()
            u37.Parent = u35
            local u38 = 0
            local u39 = 0
            local u40 = 0
            local u41 = 0
            local u42 = 0
            local _ = u21.CFrame * CFrame.new(0, 0, -3).Position
            local u43 = tick()
            local u44 = true
            local u45 = p19.Position
            local v46 = u34.WindParticles:Clone()
            v46.Parent = u35
            _G.PlaySound(u17.PrimaryPart, script["Audio/FishKDash"]).Parent = u17.PrimaryPart
            u36:AddTask(u5.Heartbeat:Connect(function(_) --[[ Line: 124 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u16
                    [3] = u43
                    [4] = u44
                    [5] = u38
                    [6] = u34
                    [7] = u36
                    [8] = u4
                    [9] = u45
                    [10] = u39
                    [11] = u35
                    [12] = u40
                    [13] = u42
                    [14] = u15
                    [15] = u37
                    [16] = u41
                --]]
                local v47 = workspace:Raycast(u21.Position, Vector3.new(0, -40, 0), u16)
                local _ = tick() - u43
                if u44 then
                    if tick() - u38 >= 0.05 and (v47 and tick() - u43 >= 0.4) then
                        u38 = tick()
                        local v48 = u34.GroundSmokeTrail_Beam.Origin:Clone()
                        v48.Parent = workspace.Terrain
                        u36:AddTask(v48)
                        for _, u49 in v48:GetDescendants() do
                            if u49:IsA("Beam") then
                                local v50 = u49.Width0
                                local v51 = u49.Width1
                                u49.Width0 = 0
                                u49.Width1 = 0
                                u4:Create(u49, TweenInfo.new(Random.new():NextNumber(0.4, 0.8)), {
                                    ["Width0"] = v50,
                                    ["Width1"] = v51
                                }):Play()
                                task.spawn(function() --[[ Line: 148 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u49
                                    --]]
                                    local v52 = tick()
                                    while true do
                                        local v53 = (tick() - v52) * 2
                                        u49.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4, v53), NumberSequenceKeypoint.new(1, 1) })
                                        if v53 >= 1 then
                                            break
                                        end
                                        task.wait()
                                    end
                                end)
                            elseif u49:IsA("Attachment") then
                                if u49.Name == "A" or u49.Name == "B" then
                                    u4:Create(u49, TweenInfo.new(1), {
                                        ["Position"] = u49.Position * 1.25
                                    }):Play()
                                elseif u49.Name == "L" or u49.Name == "R" then
                                    u4:Create(u49, TweenInfo.new(1), {
                                        ["Position"] = u49.Position * 2.5
                                    }):Play()
                                end
                            end
                        end
                        local v54 = CFrame.lookAt
                        local v55 = v47.Position
                        local v56 = v47.Position + v47.Normal
                        local v57 = CFrame.new
                        local v58 = u21.Position.X
                        local v59 = u21.Position.Z
                        local v60 = Vector3.new(v58, 0, v59)
                        local v61 = u45.X
                        local v62 = u45.Z
                        v48.WorldCFrame = v54(v55, v56, -v57(v60, (Vector3.new(v61, 0, v62))).LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -1, 0)
                        for _, v63 in v48:GetChildren() do
                            local v64 = workspace:Raycast(v63.WorldPosition + Vector3.new(0, 4, 0), Vector3.new(0, -45, 0), u16)
                            if v64 then
                                local v65 = v64.Position.X
                                local v66 = v64.Position.Y
                                local v67 = v64.Position.Z
                                v63.WorldPosition = Vector3.new(v65, v66, v67) + Vector3.new(0, 2, 0)
                            end
                        end
                    end
                    if tick() - u39 >= 0.3 and tick() - u43 >= 0.4 then
                        u39 = tick()
                        local v68 = u34.Tornado2:Clone()
                        v68.CFrame = u21.CFrame * CFrame.new(0, 2, -11) * CFrame.Angles(1.5707963267948966, 0, 0)
                        v68.Parent = u35
                        u4:Create(v68, TweenInfo.new(0.5), {
                            ["CFrame"] = v68.CFrame * CFrame.Angles(0, -3.141592653589793, 0),
                            ["Size"] = v68.Size * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    end
                    if tick() - u40 >= 0.4 then
                        u40 = tick()
                        for _, v69 in u34:GetChildren() do
                            if string.find(v69.Name, "WindBurst") then
                                if v69.Name == "WindBurst4" then
                                    local v70 = v69:Clone()
                                    v70.CFrame = u21.CFrame * CFrame.new(0, 2, -8) * CFrame.Angles(1.5707963267948966, 0, 0)
                                    v70.Parent = u35
                                    u4:Create(v70, TweenInfo.new(0.7), {
                                        ["CFrame"] = v70.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                                    }):Play()
                                    u4:Create(v70.Mesh, TweenInfo.new(0.75), {
                                        ["Scale"] = v70.Mesh.Scale * 1.3
                                    }):Play()
                                    u4:Create(v70.Decal, TweenInfo.new(0.75), {
                                        ["Transparency"] = 1
                                    }):Play()
                                else
                                    local v71 = v69:Clone()
                                    v71.CFrame = u21.CFrame * CFrame.new(0, 2, v69.Name == "WindBurst2" and 4 or -10) * CFrame.Angles(0, -1.5707963267948966, 0)
                                    v71.Parent = u35
                                    u4:Create(v71, TweenInfo.new(0.7), {
                                        ["CFrame"] = v71.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
                                    }):Play()
                                    u4:Create(v71.Mesh, TweenInfo.new(0.75), {
                                        ["Scale"] = v71.Mesh.Scale * 1.3
                                    }):Play()
                                    u4:Create(v71.Decal, TweenInfo.new(0.75), {
                                        ["Transparency"] = 1
                                    }):Play()
                                end
                            end
                        end
                    end
                    if tick() - u42 >= 0.05 then
                        u42 = tick()
                        task.spawn(function() --[[ Line: 246 ]]
                            --[[
                            Upvalues:
                                [1] = u21
                                [2] = u34
                                [3] = u15
                            --]]
                            local v72 = u21.Position
                            local v73 = Random.new():NextNumber(-2, 2)
                            local v74 = Random.new():NextNumber(-3, 3)
                            local v75 = Random.new()
                            local v76 = v72 + Vector3.new(v73, v74, v75:NextNumber(-2, 2)) * Random.new():NextNumber(5, 7)
                            local v77 = u34.CurveCharge:Clone()
                            v77.CFrame = CFrame.new(v76) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                            v77.Parent = workspace.Effects
                            _G.destroy(v77, 1.5)
                            local v78 = 0
                            repeat
                                local v79 = v78 + task.wait() * 4
                                v78 = math.clamp(v79, 0, 1)
                                local v80 = {
                                    [1] = v77.Position,
                                    [1] = v77.CFrame * CFrame.new(1.35, 0, -1.6).Position,
                                    [2] = v77.CFrame * CFrame.new(2.7, 0, -3.2).Position,
                                    [3] = v77.CFrame * CFrame.new(4.050000000000001, 0, -4.800000000000001).Position,
                                    [#v80 + 1] = u21.CFrame * CFrame.new(0, 0, -10).Position
                                }
                                v77.Position = u15(v78, unpack(v80))
                            until v78 >= 0.81
                            _G.particleEnabled(v77, false)
                        end)
                    end
                    for _, v81 in u37:GetDescendants() do
                        if v81:IsA("ParticleEmitter") then
                            v81.Enabled = v47 and true or false
                        end
                    end
                    if v47 then
                        u37.CFrame = CFrame.new(v47.Position, v47.Position + v47.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                        if tick() - u41 >= 0.02 and tick() - u43 >= 0.2 then
                            u41 = tick()
                            local v82 = u21.CFrame * CFrame.new(0, 0, -15).Position
                            local v83 = workspace
                            local v84 = u21.Position
                            local v85 = CFrame.new
                            local v86 = u21.Position
                            local v87 = v82.X
                            local v88 = u21.Position.Y
                            local v89 = v82.Z
                            local v90 = v83:Raycast(v84, v85(v86, (Vector3.new(v87, v88, v89))).LookVector * 35, u16)
                            if v90 then
                                local _ = v90.Position
                            end
                        end
                    end
                end
            end))
            task.delay(0.2, function() --[[ Line: 301 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u21
                    [3] = u35
                    [4] = u4
                --]]
                for _, v91 in u34:GetChildren() do
                    if string.find(v91.Name, "Swirl") then
                        local v92 = v91:Clone()
                        v92.CFrame = u21.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(0, v91.Name == "SwirlB" and 3.141592653589793 or 0, 0)
                        v92.Parent = u35
                        u4:Create(v92, TweenInfo.new(0.4), {
                            ["CFrame"] = v92.CFrame * CFrame.new(0, 0, v91.Name == "SwirlB" and -14 or 14) * CFrame.Angles(0, 0, -2.356194490192345),
                            ["Size"] = v92.Size * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    end
                end
            end)
            local _ = u17:GetPivot().Position
            v46.Anchored = false
            v46.CFrame = CFrame.new(u21.Position, p19.Position) * CFrame.new(0, 0, -4)
            local v93 = Instance.new("WeldConstraint")
            v93.Part0 = u21
            v93.Part1 = v46
            v93.Parent = v46
            task.delay(p20 * 0.75, function() --[[ Line: 327 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u34
                    [3] = u35
                    [4] = u4
                --]]
                task.delay(0.19999999999999998, function() --[[ Line: 328 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u34
                        [3] = u35
                        [4] = u4
                    --]]
                    local v94, v95, _ = _G.getRayFloor(u17.PrimaryPart.CFrame, 5)
                    local v96 = u34.Explode:Clone()
                    v96.Position = v95
                    if v94 then
                        _G.recolorParticles(v96, v94.Color)
                    end
                    v96.Parent = u35
                    _G.destroy(v96, 5)
                    _G.PlaySound(v96, script["Audio/FishKDashBoom"])
                    _G.customEmit(v96)
                    _G.particleEnabled(v96, false)
                    local v97 = u34.Hit_Wall.Fire:Clone()
                    v97.Position = v95 + Vector3.new(0, 0.1, 0)
                    v97.Parent = workspace.Terrain
                    _G.destroy(v97, 5)
                    _G.customEmit(v97)
                    _G.particleEnabled(v97, false)
                    if v94 then
                        _G.PlaySound(v97, script["Audio/WallCrash"])
                    end
                    for _, v98 in u34:GetChildren() do
                        if string.find(v98.Name, "Swirl") then
                            local v99 = v98:Clone()
                            v99.CFrame = v97.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                            v99.Parent = u35
                            local v100 = v99.Size.X
                            local v101 = v99.Size.Y
                            local v102 = v99.Size.Z / 2
                            v99.Size = Vector3.new(v100, v101, v102)
                            u4:Create(v99, TweenInfo.new(0.4), {
                                ["CFrame"] = v99.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, -2.356194490192345),
                                ["Size"] = v99.Size * 1.5,
                                ["Transparency"] = 1
                            }):Play()
                        end
                    end
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 25,
                        ["Position"] = v95 + Vector3.new(0, 5, 0),
                        ["DistanceRandomness"] = Vector2.new(0.5, 1),
                        ["Duration"] = 2,
                        ["TweenDuration"] = 1,
                        ["Radius"] = 15,
                        ["Direction"] = Vector3.new(0, -35, 0)
                    })
                end)
            end)
            task.wait(p20)
            u44 = false
            _G.particleEnabled(u37, false)
            for _, v103 in v46:GetDescendants() do
                if v103:IsA("ParticleEmitter") then
                    v103.Enabled = false
                elseif v103:IsA("Beam") then
                    u4:Create(v103, TweenInfo.new(0.6), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end
            end
            task.wait(3)
            u36:Destroy()
            _G.destroy(u35, 4)
            task.wait(3)
            u35:Destroy()
            u36:Destroy()
        end
        goto l9
    end
end
return v1