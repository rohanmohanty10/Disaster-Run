 

local v1 = {}
local u2 = script.Parent.Assets.Z
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local u4 = game:GetService("TweenService")
local u5 = game["Run Service"]
local function u14(p6, ...) --[[ Line: 8 ]]
    local v7 = { ... }
    local v8 = #v7 - 2
    if v8 >= 0 then
        local v9 = nil
        for v10 = 1, #v7 do
            local v11 = v8 + 1
            local v12 = (v10 == 1 or v10 == #v7) and 1 or v11
            local v13 = (1 - p6) ^ (v8 + 1 - (v10 - 1)) * p6 ^ (v8 - (-v10 + v8 + 1)) * v12 * v7[v10]
            if v9 then
                v9 = v9 + v13
            else
                v9 = v13
            end
        end
        return v9
    end
    warn("Not enough Points")
end
function v1.start(_, u15, p16, p17, p18, p19) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
        [3] = u3
        [4] = u4
        [5] = u5
    --]]
    local u20 = u15.PrimaryPart
    if _G.checkRenderDistance(u15.PrimaryPart.Position) == false then
        return
    end
    if p16 ~= "hold" then
        if p16 == "shoot" then
            local u21 = u3.new()
            local u22 = u3.new()
            tick()
            local u23 = RaycastParams.new()
            u23.FilterType = Enum.RaycastFilterType.Include
            u23.FilterDescendantsInstances = p19
            u15:SetPrimaryPartCFrame(p17)
            local v24 = u2.DemonFist_Fire.Attachment:Clone()
            v24.WorldCFrame = CFrame.new(u20.Position, p18) * CFrame.new(0, 0, -5)
            v24.Parent = workspace.Terrain
            _G.destroy(v24, 5)
            _G.customEmit(v24)
            _G.particleEnabled(v24, false)
            _G.PlaySound(u20, script.FishKWaterFistShoot)
            task.wait(0.1)
            local u25 = Instance.new("Model")
            u25.Parent = workspace.Effects
            local u26 = u2.DemonFist:Clone()
            u26.CFrame = CFrame.new(u20.Position, p18)
            u26.Anchored = true
            _G.particleEnabled(u26, false)
            u26.Parent = u25
            local u27 = nil
            local u28 = 0
            local u29 = {}
            local u30 = 0
            local u31 = {}
            local u32 = 0
            local u33 = 0
            local u34 = {}
            for _, u35 in u26:GetDescendants() do
                if u35:IsA("ParticleEmitter") then
                    if string.find(u35.Name, "Ring") then
                        task.delay(0.3, function() --[[ Line: 154 ]]
                            --[[
                            Upvalues:
                                [1] = u27
                                [2] = u35
                            --]]
                            if not u27 then
                                u35.Enabled = true
                            end
                        end)
                    else
                        u35.Enabled = true
                    end
                end
            end
            local u36 = u26.GroundAttach
            u36.Parent = workspace.Terrain
            u22:AddTask(u36)
            local u37 = {
                ["Part"] = u26,
                ["Acceleration"] = Vector3.new(0, 0, 0),
                ["VelocityThreshold"] = 10,
                ["Gravity"] = Vector3.new(0, -225, 0),
                ["Duration"] = 10,
                ["Velocity"] = u26.CFrame.LookVector * 165,
                ["Size"] = 2,
                ["Length"] = 4
            }
            u26.FishKWaterFistTravelLoop:Play()
            local function u42(p38) --[[ Line: 184 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u21
                    [3] = u31
                    [4] = u26
                    [5] = u4
                    [6] = u2
                    [7] = u25
                    [8] = u36
                    [9] = u29
                    [10] = u22
                --]]
                if not u27 then
                    u27 = true
                    u21:Destroy()
                    u31 = {}
                    u26.CFrame = CFrame.new(p38.Point, u26.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                    u26.FishKWaterFistTravelLoop:Stop()
                    for _, v39 in u26:GetDescendants() do
                        if v39:IsA("ParticleEmitter") then
                            v39.Enabled = false
                        elseif v39:IsA("Sound") and not string.find(v39.Name, "Hit") then
                            u4:Create(v39, TweenInfo.new(1), {
                                ["Volume"] = 0
                            }):Play()
                        end
                    end
                    local v40 = u2.DemonFist_Explode:Clone()
                    v40.CFrame = CFrame.new(p38.Point, p38.Point + p38.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                    v40.Parent = u25
                    _G.destroy(v40, 5)
                    _G.PlaySound(v40, script.FishKWaterFistBoom)
                    _G.customEmit(v40)
                    _G.particleEnabled(v40, false)
                    _G.particleEnabled(u36, false)
                    for _, v41 in u29 do
                        _G.particleEnabled(v41, false)
                    end
                    task.wait(3)
                    u22:Destroy()
                    _G.destroy(u25, 4)
                end
            end
            local v43 = u2.CurveCharge_Soar:Clone()
            v43.Parent = u25
            table.insert(u29, v43)
            local v44 = u2.CurveCharge_Soar:Clone()
            v44.Parent = u25
            table.insert(u29, v44)
            u22:AddTask(u5.Heartbeat:Connect(function(p45) --[[ Line: 241 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u34
                    [3] = u27
                    [4] = u29
                    [5] = u26
                    [6] = u30
                    [7] = u2
                    [8] = u25
                    [9] = u4
                    [10] = u23
                    [11] = u22
                    [12] = u20
                    [13] = u32
                    [14] = u28
                    [15] = u36
                --]]
                u33 = u33 + 1 * p45
                for _, v46 in u34 do
                    local v47 = v46.CFrame
                    local v48 = CFrame.Angles
                    local v49 = 1650 * p45
                    v46.CFrame = v47 * v48(0, math.rad(v49), 0)
                end
                if not u27 then
                    for v50, v51 in u29 do
                        local v52 = u26.CFrame
                        local v53 = CFrame.Angles
                        local v54 = v50 * 180 + u33 * 450
                        v51.CFrame = v52 * v53(1.5707963267948966, math.rad(v54), 0) * CFrame.new(0, 15, -25)
                    end
                    if tick() - u30 >= 0.14 then
                        u30 = tick()
                        local v55 = u2.WindBurst:Clone()
                        v55.CFrame = u26.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0)
                        local v56 = v55.Mesh
                        v56.Scale = v56.Scale * 1.5
                        v55.Decal.Transparency = 0.5
                        v55.Parent = u25
                        local v57 = u34
                        table.insert(v57, v55)
                        u4:Create(v55.Mesh, TweenInfo.new(0.6), {
                            ["Scale"] = v55.Mesh.Scale * 1.5
                        }):Play()
                        u4:Create(v55.Decal, TweenInfo.new(0.8), {
                            ["Transparency"] = 1
                        }):Play()
                        local v58 = workspace:Raycast(u26.Position, Vector3.new(0, -35, 0), u23)
                        if v58 then
                            local v59 = u2.GroundSmokeTrail_Beam.Origin:Clone()
                            v59.Parent = workspace.Terrain
                            u22:AddTask(v59)
                            for _, u60 in v59:GetDescendants() do
                                if u60:IsA("Beam") then
                                    local v61 = u60.Width0
                                    local v62 = u60.Width1
                                    u60.Width0 = 0
                                    u60.Width1 = 0
                                    u4:Create(u60, TweenInfo.new(0.8), {
                                        ["Width0"] = v61,
                                        ["Width1"] = v62
                                    }):Play()
                                    task.spawn(function() --[[ Line: 294 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u60
                                        --]]
                                        local v63 = tick()
                                        while true do
                                            local v64 = (tick() - v63) * 2
                                            u60.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4, v64), NumberSequenceKeypoint.new(1, 1) })
                                            if v64 >= 1 then
                                                break
                                            end
                                            task.wait()
                                        end
                                    end)
                                elseif u60:IsA("Attachment") then
                                    if u60.Name == "A" or u60.Name == "B" then
                                        u4:Create(u60, TweenInfo.new(1), {
                                            ["Position"] = u60.Position * 1.25
                                        }):Play()
                                    elseif u60.Name == "L" or u60.Name == "R" then
                                        u4:Create(u60, TweenInfo.new(1), {
                                            ["Position"] = u60.Position * 1.5
                                        }):Play()
                                    end
                                end
                            end
                            local v65 = CFrame.lookAt
                            local v66 = v58.Position
                            local v67 = v58.Position + v58.Normal
                            local v68 = CFrame.new
                            local v69 = u20.Position.X
                            local v70 = u20.Position.Z
                            local v71 = Vector3.new(v69, 0, v70)
                            local v72 = u26.Position.X
                            local v73 = u26.Position.Z
                            v59.WorldCFrame = v65(v66, v67, -v68(v71, (Vector3.new(v72, 0, v73))).LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -1, 0)
                            for _, v74 in v59:GetChildren() do
                                local v75 = workspace:Raycast(v74.WorldPosition + Vector3.new(0, 4, 0), Vector3.new(0, -45, 0), u23)
                                if v75 then
                                    local v76 = v75.Position.X
                                    local v77 = v75.Position.Y
                                    local v78 = v75.Position.Z
                                    v74.WorldPosition = Vector3.new(v76, v77, v78) + Vector3.new(0, 2, 0)
                                end
                            end
                        end
                    end
                    if tick() - u32 >= 0.4 then
                        u32 = tick()
                        local v79 = u2.Shockwave:Clone()
                        v79.CFrame = u26.CFrame * CFrame.new(0, 0, -12) * CFrame.Angles(0, -1.5707963267948966, 0)
                        local v80 = v79.Mesh
                        v80.Scale = v80.Scale * 3.5
                        v79.Parent = workspace.Effects
                        _G.destroy(v79, 1)
                        u4:Create(v79.Mesh, TweenInfo.new(0.6), {
                            ["Scale"] = v79.Mesh.Scale * 1.5
                        }):Play()
                        u4:Create(v79, TweenInfo.new(1), {
                            ["CFrame"] = v79.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
                        }):Play()
                        u4:Create(v79.Decal, TweenInfo.new(0.8), {
                            ["Transparency"] = 1
                        }):Play()
                    end
                    if tick() - u28 >= 0.3 then
                        u28 = tick()
                        local v81 = u2.Shockwave2:Clone()
                        v81.CFrame = u26.CFrame * CFrame.new(0, 0, -12) * CFrame.Angles(0, 1.5707963267948966, 0)
                        v81.Size = v81.Size * 1.5
                        v81.Parent = u25
                        u4:Create(v81, TweenInfo.new(1), {
                            ["CFrame"] = v81.CFrame * CFrame.Angles(3.141592653589793, 0, 0),
                            ["Transparency"] = 1,
                            ["Size"] = v81.Size * 1.3
                        }):Play()
                    end
                    local v82 = workspace:Raycast(u26.Position, Vector3.new(0, -125, 0), u23)
                    if v82 then
                        u36.WorldCFrame = CFrame.new(v82.Position, v82.Position + v82.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                    end
                    for _, v83 in u36:GetDescendants() do
                        if v83:IsA("ParticleEmitter") then
                            v83.Enabled = v82 and true or false
                        end
                    end
                end
            end))
            u21:AddTask(u5.Heartbeat:Connect(function(p84) --[[ Line: 398 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u23
                    [3] = u15
                    [4] = u42
                --]]
                local v85 = u37
                v85.Duration = v85.Duration - p84
                local v86 = u37
                v86.Acceleration = v86.Acceleration + u37.Gravity * p84
                local v87 = u37
                v87.Velocity = v87.Velocity + u37.Acceleration * p84
                local v88 = u37.Velocity.Unit
                local v89 = u37.Velocity.Magnitude
                local v90 = u37.VelocityThreshold
                local v91 = math.max(v89, v90)
                local v92 = math.min(v91, 750) * p84
                local v93 = workspace:Blockcast(CFrame.new(u37.Part.Position), Vector3.new(6, 6, 6), v88 * v92, u23)
                if (v93 or u37.Duration <= 0) and (v93 and v93.Instance) then
                    local v94 = v93.Instance
                    if not v94:IsDescendantOf(u15) and v94.CanCollide or u37.Duration <= 0 then
                        u42({
                            ["HitPart"] = v93.Instance,
                            ["Point"] = v93.Position,
                            ["Normal"] = v93.Normal
                        })
                        return
                    end
                end
                u37.Part:PivotTo(CFrame.new(u37.Part.Position, u37.Part.Position + v88))
                local v95 = u37.Part
                v95.Position = v95.Position + v88 * v92
            end))
            task.delay(5, u42)
        end
        return
    end
    local v96 = u2.Charge:Clone()
    local v97 = Instance.new("Weld")
    v97.Part0 = u15.RightHand
    v97.Part1 = v96
    v97.Parent = v96
    _G.particleEnabled(v96, true)
    v96.Parent = workspace.Effects
    _G.PlaySound(v96, script.FishKWaterFistStart)
    local v98 = script.FishKWaterFistChargeLoop:Clone()
    v98.Parent = v96
    v98:Play()
    local v99 = tick()
    local v100 = 0
    while true do
        if tick() - v100 >= 0.03 and tick() - v99 <= 0.4 then
            v100 = tick()
            task.spawn(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u2
                    [3] = u15
                    [4] = u14
                --]]
                local v101 = u20.Position
                local v102 = Random.new():NextNumber(-2, 2)
                local v103 = Random.new():NextNumber(-3, 3)
                local v104 = Random.new()
                local v105 = v101 + Vector3.new(v102, v103, v104:NextNumber(-2, 2)) * Random.new():NextNumber(5, 7)
                local v106 = u2.CurveCharge:Clone()
                v106.CFrame = CFrame.new(v105) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                v106.Parent = workspace.Effects
                _G.destroy(v106, 1.5)
                local v107 = 0
                repeat
                    local v108 = v107 + task.wait() * 7
                    v107 = math.clamp(v108, 0, 1)
                    local v109 = {
                        [1] = v106.Position,
                        [1] = v106.CFrame * CFrame.new(1.35, 0, -1.6).Position,
                        [2] = v106.CFrame * CFrame.new(2.7, 0, -3.2).Position,
                        [3] = v106.CFrame * CFrame.new(4.050000000000001, 0, -4.800000000000001).Position,
                        [#v109 + 1] = u15.RightHand.Position
                    }
                    v106.Position = u14(v107, unpack(v109))
                until v107 == 1
                _G.particleEnabled(v106, false)
            end)
        end
        task.wait()
        if u15:GetAttribute("DemonBrickFist") == nil then
            _G.tween(v98, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.particleEnabled(v96, false)
            _G.destroy(v96, 5)
            return
        end
    end
end
return v1