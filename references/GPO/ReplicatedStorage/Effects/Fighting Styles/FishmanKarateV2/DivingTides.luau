 

local v1 = {}
local u2 = script.Parent.Assets
local _ = u2.Z
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local u4 = game:GetService("TweenService")
local u5 = game["Run Service"]
local u6 = RaycastParams.new()
u6.FilterType = Enum.RaycastFilterType.Include
u6.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
function v1.start(_, u7, p8, _, u9) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u5
        [4] = u6
        [5] = u4
    --]]
    if _G.checkRenderDistance(u7.PrimaryPart.Position) ~= false then
        local u10 = u7 == game.Players.LocalPlayer.Character
        local u11 = u7.PrimaryPart
        local u12 = u7.Humanoid
        local v13 = u12.Animator
        local u14 = u2.R
        local v15 = u3.new()
        tick()
        local u16 = 0
        local u17 = {}
        local u18 = {}
        local u19 = nil
        local u20 = nil
        local u21 = nil
        local u22 = nil
        local u23 = Instance.new("Folder")
        u23.Parent = workspace.Effects
        local u24 = u14.Soar.Attachment:Clone()
        u24.Parent = workspace.Terrain
        _G.destroy(u24, 6)
        local u25 = u14.SwimTrail:Clone()
        u25.Anchored = true
        u25.Parent = workspace.Effects
        _G.destroy(u25, 6)
        _G.PlaySound(u11, script["Audio/FishKSwimStart"]).Parent = u11
        if u10 == true then
            _G.canuse = false
        end
        task.delay(0.1, function() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u25
            --]]
            for _, v26 in u25:GetDescendants() do
                if (v26:IsA("ParticleEmitter") or v26:IsA("Trail")) and not (v26:IsDescendantOf(u25.Core.Under) or v26:IsDescendantOf(u25.Core.WindUp)) then
                    v26.Enabled = true
                end
            end
        end)
        local u27 = u14.Splash:Clone()
        u27.Parent = workspace.Effects
        v15:AddTask(u27)
        local function u29(p28) --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            _G.transparentCharacter(u7)
            if p28 then
                task.wait(p28 or 0.2)
                _G.transparentCharacter(u7, "forceShow")
            end
        end
        local u30 = v13:LoadAnimation(script.Anim)
        u30.Priority = Enum.AnimationPriority.Action4
        tick()
        v15:AddTask(u30.KeyframeReached:Connect(function(p31) --[[ Line: 100 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u20
                [3] = u30
                [4] = u29
                [5] = u24
                [6] = u27
                [7] = u7
                [8] = u10
                [9] = u9
            --]]
            if p31 == "Splash" then
                if u22 ~= nil and not u20 then
                    u20 = true
                    u30:Stop(0.1)
                    u30:Destroy()
                    task.delay(0.1, u29)
                end
                local _, v32, _ = _G.getRayFloor(u24.WorldCFrame * CFrame.new(0, 2, 0), 3)
                local v33 = u27
                local v34 = CFrame.new
                local v35 = u7.UpperTorso.Position.X
                local v36 = v32.Y
                local v37 = u7.UpperTorso.Position.Z
                v33.CFrame = v34((Vector3.new(v35, v36, v37))) * CFrame.new(0, 0.5, 0)
                u27.CFrame = CFrame.new(u27.Position, u27.Position + u24.WorldCFrame.LookVector)
                _G.PlaySound(u27, script:FindFirstChild("DiveSplash" .. math.random(1, 3)), {
                    ["Pitch"] = math.random(90, 110) / 100
                })
                _G.customEmit(u27)
                if u10 == true and u9 ~= nil then
                    u9:FireServer("Splash", u7.PrimaryPart.CFrame)
                end
            end
        end))
        u30:Play(0.5)
        u30:AdjustSpeed(0)
        local v38 = u7:GetPivot().Position
        local v39 = (v38 - p8).Magnitude
        local v40 = 1 / (v39 / 90)
        local v41 = math.clamp(v40, 0.65, 3.5)
        local v42 = CFrame.new(v38, p8).Position
        local v43 = v39 / 2
        local v44 = v42 + Vector3.new(0, v43, 0)
        local _ = CFrame.new(v38, p8) * CFrame.new(0, 0, -1000)
        local u45 = u12.HipHeight
        local v46 = u14.Jump:Clone()
        v46.CFrame = u11.CFrame * CFrame.new(0, -3, 0)
        v46.Parent = u23
        _G.customEmit(v46)
        _G.particleEnabled(v46, false)
        u7.Humanoid.AutoRotate = false
        local u47 = 0
        local v48 = 0
        while v48 < 1 do
            local _, v49 = game["Run Service"].Stepped:Wait()
            local v50 = v48 + v49 * v41
            v48 = math.clamp(v50, 0, 1)
            local v51 = v48
            local v52 = (1 - v51) * (1 - v51) * v38 + 2 * (1 - v51) * v51 * v44 + v51 * v51 * p8
            local v53 = v48 + 0.01
            local v54 = (1 - v53) * (1 - v53) * v38 + 2 * (1 - v53) * v53 * v44 + v53 * v53 * p8
            local v55 = v54 * Vector3.new(1, 0, 1)
            local v56 = v52.Y
            local v57 = v55 + Vector3.new(0, v56)
            if u10 == true then
                u7.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                u7:PivotTo(CFrame.new(v52, v57))
                u7.PrimaryPart.Velocity = Vector3.new()
            end
            u25.CFrame = CFrame.new(u7.PrimaryPart.Position, v54)
        end
        u7.Humanoid.AutoRotate = true
        u30:AdjustSpeed(1.9)
        _G.PlaySound(u11, script["Audio/FishKSwimDive"]).Parent = u11
        local u58
        if u10 then
            u58 = Instance.new("BodyVelocity")
            u58.MaxForce = Vector3.new(80000, 0, 80000)
            u58.Velocity = Vector3.new(0, 0, 0)
            u58.Parent = u11
        else
            u58 = nil
        end
        if u10 then
            u7.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        end
        local v59 = u7.PrimaryPart.CollisionGroup
        for _, v60 in u7:GetDescendants() do
            if v60:IsA("BasePart") and v60 ~= u7.PrimaryPart then
                v60.CollisionGroup = "noclip"
            end
        end
        local u61 = u11.Position
        local u62 = u11.Position
        v15:AddTask(u5.Heartbeat:Connect(function(p63) --[[ Line: 203 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u17
                [3] = u18
                [4] = u11
                [5] = u22
                [6] = u12
                [7] = u61
                [8] = u6
                [9] = u62
                [10] = u58
                [11] = u45
                [12] = u24
                [13] = u19
                [14] = u25
                [15] = u7
                [16] = u20
                [17] = u21
                [18] = u16
            --]]
            u47 = u47 + 1 * p63
            for _, v64 in u17 do
                local v65 = v64:GetAttribute("Direction") == 1 and 150 * p63 or -150 * p63
                if v64.Name == "Vortex" then
                    v65 = v65 * 4
                end
                v64.CFrame = v64.CFrame * CFrame.Angles(0, math.rad(v65), 0)
            end
            for v66, v67 in u18 do
                local v68 = CFrame.new(u11.Position)
                local v69 = CFrame.Angles
                local v70 = v66 * 120 - u47 * 750
                v67.CFrame = v68 * v69(0, math.rad(v70), 0) * CFrame.new(0, 25 * ((tick() - u22) * 0.4), -14 - 25 * ((tick() - u22) * 3))
            end
            local v71 = u12.MoveDirection
            if v71.Magnitude <= 0 then
                v71 = u11.CFrame.LookVector
            end
            local v72 = u11.Position - u61
            local v73 = false
            if v72.Magnitude > 0.5 then
                local v74 = workspace:Raycast(u61, v72, u6)
                if v74 and (v74.Position - u61).Magnitude < v72.Magnitude - 1 then
                    v73 = true
                    local v75 = u11
                    local v76 = CFrame.new(u62)
                    local v77 = CFrame.Angles
                    local v78 = u11.Orientation.Y
                    v75.CFrame = v76 * v77(0, math.rad(v78), 0)
                    if u58 then
                        u58.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
            if not v73 then
                u62 = u11.Position
            end
            u61 = u11.Position
            local v79 = u11.CFrame * CFrame.new(0, 0, 2).Position
            local v80 = workspace:Raycast(v79, CFrame.lookAt(v79, v79 + u11.CFrame.LookVector, v71).LookVector * (u11.Size.Z + 3), u6)
            local v81
            if v80 then
                v81 = CFrame.lookAt(u11.Position, v80.Position + v80.Normal, v71) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, u45, 0)
            else
                v81 = CFrame.new(u11.Position, u11.Position + v71) * CFrame.new(0, 0, -75 * p63 - 6)
            end
            local v82 = workspace:Raycast(v81.Position + Vector3.new(0, 12, 0), Vector3.new(0, -22, 0), u6)
            if v82 or v80 then
                if v80 then
                    u24.WorldCFrame = v81
                else
                    u24.WorldCFrame = CFrame.new(v82.Position, v82.Position + v82.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                end
                local v83 = workspace:Raycast(u24.WorldPosition, u24.WorldCFrame.LookVector * (75 * p63), u6)
                if v83 then
                    local _ = CFrame.lookAt(v83.Position, v83.Position + v83.Normal, v71) * CFrame.Angles(-1.5707963267948966, 0, 0)
                end
            else
                if workspace:Raycast(u24.WorldPosition, v71 * 75 * p63, u6) then
                    local v84 = u24
                    local v85 = CFrame.lookAt
                    local v86 = u11.Position
                    local v87 = -75 * p63
                    v84.WorldCFrame = v85(v86 + Vector3.new(0, v87, 0), v71)
                else
                    local v88 = u24
                    local v89 = CFrame.lookAt
                    local v90 = u11.Position
                    local v91 = -75 * p63
                    v88.WorldCFrame = v89(v90 + Vector3.new(0, v91, 0) + v71 * 75 * p63, v71)
                end
                local _ = u24.WorldCFrame
            end
            if not (u19 or v73) then
                if u22 then
                    if v82 then
                        local v92 = u25
                        local v93 = u25.CFrame
                        local v94 = CFrame.lookAt(v82.Position, v82.Position + v82.Normal, v71) * CFrame.Angles(-1.5707963267948966, 0, 0)
                        local v95 = CFrame.new
                        local v96 = tick() * 12
                        local v97 = v94 * v95(math.cos(v96) * 6, 0.1, 0)
                        local v98 = (tick() - u22) * 1
                        v92.CFrame = v93:Lerp(v97, (math.min(1, v98)))
                        u24.WorldCFrame = u25.CFrame
                    else
                        local v99 = u25
                        local v100 = u25.CFrame
                        local v101 = CFrame.new(u7.UpperTorso.Position, u7.UpperTorso.Position + v71)
                        local v102 = CFrame.new
                        local v103 = tick() * 12
                        local v104 = v101 * v102(math.cos(v103) * 6, -(u11.Size.Y / 2 + u12.HipHeight), 0)
                        local v105 = (tick() - u22) * 1
                        v99.CFrame = v100:Lerp(v104, (math.min(1, v105)))
                        u24.WorldCFrame = u25.CFrame
                    end
                else
                    u25.CFrame = CFrame.new(u7.UpperTorso.Position, u7.UpperTorso.Position + v71)
                end
                if u58 then
                    if v80 then
                        u58.MaxForce = Vector3.new(80000, 80000, 80000)
                    else
                        u58.MaxForce = Vector3.new(80000, 0, 80000)
                    end
                    u58.Velocity = v71 * 75 + Vector3.new(0, v80 and 75 or 0, 0)
                end
                if u12:GetState() == Enum.HumanoidStateType.Freefall or u22 and u20 then
                    if not u21 then
                        u21 = true
                        _G.transparentCharacter(u7)
                    end
                elseif u21 then
                    u21 = nil
                    _G.transparentCharacter(u7, "forceShow")
                end
                local _ = tick() - u16 >= 0.12
            end
        end))
        task.wait(1.2)
        local v106 = tick()
        for _, v107 in u25:GetDescendants() do
            if (v107:IsA("ParticleEmitter") or v107:IsA("Trail")) and not v107:IsDescendantOf(u25.Core.WindUp) then
                v107.Enabled = true
            end
        end
        task.delay(0.7, function() --[[ Line: 359 ]]
            --[[
            Upvalues:
                [1] = u25
            --]]
            for _, v108 in u25:GetDescendants() do
                if (v108:IsA("ParticleEmitter") or v108:IsA("Trail")) and v108:IsDescendantOf(u25.Core.WindUp) then
                    _G.customEmit(v108)
                end
            end
        end)
        task.wait(1)
        if u7:GetAttribute("DivingTidesSwim") then
            u7:GetAttributeChangedSignal("DivingTidesSwim"):Wait()
        end
        v106 = tick()
        if u58 then
            u58:Destroy()
        end
        local _ = true
        _G.transparentCharacter(u7, "forceShow")
        local v109 = u11.Position + Vector3.new(0, 45, 0)
        local v110 = workspace:Raycast(u11.Position, Vector3.new(0, 45, 0), u6)
        if v110 then
            v109 = v110.Position
        end
        local v111 = u7:GetPivot().Position
        local v112 = (v111 - v109).Magnitude
        local _ = CFrame.new(v111, v109).Position
        local _ = CFrame.new(v111, v109) * CFrame.new(0, 0, -1000)
        local u113 = tick()
        local _ = v112 / 165
        u7.Humanoid.AutoRotate = false
        local u114 = 0
        local u115 = 0
        for _ = 1, 3 do
            local v116 = u14.CurveCharge_Soar:Clone()
            v116.CFrame = u11.CFrame
            v116.Parent = u23
            table.insert(u18, v116)
        end
        task.delay(0.4, function() --[[ Line: 418 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            for _, v117 in u18 do
                _G.particleEnabled(v117, false, true)
            end
        end)
        local v118 = u14.Gyser:Clone()
        v118.CFrame = u11.CFrame
        v118.Parent = u23
        _G.PlaySound(u11, script["Audio/FishKSwimSurface"])
        _G.particleEnabled(v118, false)
        task.spawn(function() --[[ Line: 437 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u11
                [3] = u23
                [4] = u4
            --]]
            for _ = 1, 2 do
                for _, v119 in u14:GetChildren() do
                    if string.find(v119.Name, "Swirl") then
                        local v120 = v119:Clone()
                        v120.CFrame = u11.CFrame * CFrame.new(0, 2, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
                        v120.Parent = u23
                        u4:Create(v120, TweenInfo.new(0.65), {
                            ["CFrame"] = v120.CFrame * CFrame.new(0, 0, 14) * CFrame.Angles(0, 0, -2.356194490192345),
                            ["Size"] = v120.Size * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    end
                end
                task.wait(0.1)
            end
        end)
        task.delay(0.01, function() --[[ Line: 457 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u11
                [3] = u23
                [4] = u4
            --]]
            local v121 = u14.tornado:Clone()
            v121:PivotTo(u11.CFrame)
            v121.Parent = u23
            for _, u122 in v121:GetChildren() do
                if u122.Name ~= "root" then
                    local u123 = u122.Size
                    u122.Size = Vector3.new(0, 0, 0)
                    if u122.Name == "Shock" then
                        u4:Create(u122, TweenInfo.new(0.6), {
                            ["CFrame"] = u122.CFrame * CFrame.new(0, 0, 14) * CFrame.Angles(3.141592653589793, 0, 0),
                            ["Size"] = u123 * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    elseif u122.Name == "SwirlLinger" then
                        u4:Create(u122, TweenInfo.new(0.5), {
                            ["CFrame"] = u122.CFrame * CFrame.Angles(3.141592653589793, 0, 0),
                            ["Size"] = u123 * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    elseif u122.Name == "slashswirl" or u122.Name == "Multi" then
                        u4:Create(u122, TweenInfo.new(0.675), {
                            ["CFrame"] = u122.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                            ["Size"] = u123 * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    elseif u122.Name == "tornado1" or u122.Name == "tornado2" then
                        u4:Create(u122, TweenInfo.new(0.6), {
                            ["CFrame"] = u122.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                            ["Size"] = u123 * 1.3,
                            ["Transparency"] = 1
                        }):Play()
                    elseif u122.Name == "FirstSwoosh" then
                        local u124 = u122.Mesh.Scale
                        u122.Mesh.Scale = Vector3.new(0, 0, 0)
                        task.delay(0.2, function() --[[ Line: 498 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u122
                                [3] = u123
                                [4] = u124
                            --]]
                            u4:Create(u122, TweenInfo.new(0.3), {
                                ["CFrame"] = u122.CFrame * CFrame.new(5, 0, 5) * CFrame.Angles(0, -0.6108652381980153, 0),
                                ["Size"] = u123 * 1.3
                            }):Play()
                            u4:Create(u122.Mesh, TweenInfo.new(0.3), {
                                ["Scale"] = u124 * 1.25
                            }):Play()
                            u4:Create(u122.Decal, TweenInfo.new(0.4), {
                                ["Transparency"] = 1
                            }):Play()
                        end)
                    end
                end
            end
        end)
        local v125 = v112 / 165
        if u10 == true then
            u11.Anchored = true
        end
        u30:Stop()
        u7.Humanoid:LoadAnimation(script.Jump):Play()
        if u10 == true and u9 ~= nil then
            u9:FireServer("Jump", u7.PrimaryPart.CFrame)
        end
        task.spawn(function() --[[ Line: 527 ]]
            --[[
            Upvalues:
                [1] = u114
                [2] = u115
                [3] = u113
                [4] = u14
                [5] = u11
                [6] = u23
                [7] = u4
            --]]
            while u114 < 1 do
                u114 = u114 + task.wait() * 2.8
                local v126 = u114
                u114 = math.clamp(v126, 0, 1)
                if tick() - u115 >= 0.4 and tick() - u113 >= 0.2 then
                    u115 = tick()
                    local v127 = u14.Tornado:Clone()
                    v127.CFrame = u11.CFrame * CFrame.new(0, 6, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                    v127.Parent = u23
                    u4:Create(v127, TweenInfo.new(0.5), {
                        ["CFrame"] = v127.CFrame * CFrame.Angles(0, -2.356194490192345, 0),
                        ["Size"] = v127.Size * 1.3,
                        ["Transparency"] = 1
                    }):Play()
                    local v128 = u14.Tornado2:Clone()
                    v128.CFrame = u11.CFrame * CFrame.new(0, 4, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                    v128.Parent = u23
                    u4:Create(v128, TweenInfo.new(0.5), {
                        ["CFrame"] = v128.CFrame * CFrame.Angles(0, -3.141592653589793, 0),
                        ["Size"] = v128.Size * 1.3,
                        ["Transparency"] = 1
                    }):Play()
                end
            end
        end)
        task.wait(v125)
        if u10 == true then
            u11.Anchored = false
            local v129 = Instance.new("BodyVelocity")
            v129.MaxForce = Vector3.new(80000, 80000, 80000)
            v129.Velocity = Vector3.new(0, 3, 0)
            v129.Parent = u11
            _G.destroy(v129, 0.4)
            task.delay(0.2, function() --[[ Line: 574 ]]
                _G.canuse = true
            end)
            u7.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
        u7.Humanoid.AutoRotate = true
        _G.destroy(u23, 3)
        _G.particleEnabled(u24, false)
        _G.particleEnabled(u25, false)
        for _, v130 in u7:GetDescendants() do
            if v130:IsA("BasePart") then
                v130.CollisionGroup = v59
            end
        end
        task.wait(2)
        v15:Destroy()
    end
end
return v1