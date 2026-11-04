 

local v1 = {}
local u2 = workspace.Effects
local _ = game["Run Service"]
local u3 = game:GetService("TweenService")
local u4 = script.BurningMochiPunch
local u5 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u6 = {}
local function u10(p7) --[[ Line: 11 ]]
    local v8 = p7:GetDescendants()
    for v9 = 1, #v8 do
        if v8[v9]:IsA("BasePart") then
            v8[v9].Transparency = 1
        end
    end
end
function v1.start(_, p11, u12, u13) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u6
        [4] = u3
        [5] = u2
        [6] = u10
    --]]
    local u14 = Random.new()
    local u15 = u14:NextNumber(0.75, 1.25)
    if p11 == "start" then
        local u16 = u4.Burning_Mochi:Clone()
        u5.apply(u16, u12)
        local _ = u12.RightLowerArm
        local v17 = script.RootPart:Clone()
        v17.Part0 = u12.RightLowerArm
        v17.Part1 = u16.PrimaryPart
        v17.Parent = u12.RightLowerArm
        u16:ScaleTo(0.001)
        u16.Parent = workspace.Effects
        _G.PlayEffect("TweenModel", nil, u16, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 1)
        u16.AnimationController:LoadAnimation(script.fistAnim):Play(0)
        task.delay(0.1, function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u14
                [3] = u12
                [4] = u5
            --]]
            _G.PlayEffect("MochiImpactDroplet", nil, CFrame.new(u16.DoughBall.Position + Vector3.new(0, 1, 0)), u14:NextInteger(4, 6), 1.5, 10, 0.3, 0.5, nil, u12)
            local v18 = script.DoughVFX:Clone()
            u5.apply(v18, u12)
            v18.CFrame = u16.DoughBall.CFrame
            v18.Parent = workspace.Effects
            _G.customEmit(v18)
            _G.destroy(v18, 4)
        end)
        _G.PlaySound(u12.PrimaryPart, script.MochiV2ExplodingMochiFistStart)
        u6[u12] = u16
        return
    else
        local u19 = u6[u12]
        if u19 == nil then
            return
        else
            local u20 = u19:WaitForChild("DoughBall", 3)
            if u20 then
                local u21 = nil
                local _ = u12.PrimaryPart
                local u22 = u13.goalCFrame
                local u23 = u13.FistTimeToArrive
                local u24 = u13.startPosition
                local v25 = u13.fireTime - workspace:GetServerTimeNow()
                task.spawn(function() --[[ Line: 82 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u12
                        [3] = u12
                        [4] = u3
                        [5] = u4
                        [6] = u20
                        [7] = u2
                        [8] = u21
                        [9] = u19
                    --]]
                    local u26 = script.RocketHighlight:Clone()
                    u5.apply(u26, u12)
                    u26.Parent = u12
                    u3:Create(u26, TweenInfo.new(0.15), {
                        ["OutlineTransparency"] = 0.35,
                        ["FillTransparency"] = 0.3
                    }):Play()
                    task.delay(0.1, function() --[[ Line: 89 ]]
                        --[[
                        Upvalues:
                            [1] = u3
                            [2] = u26
                        --]]
                        u3:Create(u26, TweenInfo.new(0.15), {
                            ["OutlineTransparency"] = 1,
                            ["FillTransparency"] = 1
                        }):Play()
                        task.wait(0.2)
                        u26:Destroy()
                    end)
                    local v27 = u4:WaitForChild("FatDoughExplodeVFX"):Clone()
                    u5.apply(v27, u12)
                    v27.CFrame = u20.CFrame
                    v27.Parent = u2
                    _G.customEmit(v27)
                    _G.destroy(v27, 4)
                    task.wait(0.075)
                    u21 = script.PointLight:Clone()
                    u5.apply(u21, u12)
                    u21.Parent = u20
                    u21.Brightness = 8
                    task.wait(0.05)
                    if u19.PrimaryPart then
                        local v28 = u19.PrimaryPart:GetDescendants()
                        for v29 = 1, #v28 do
                            if v28[v29]:IsA("Bone") then
                                local v30 = script.Projectile:FindFirstChild(v28[v29].Name, true)
                                if v30 and v28[v29].Name ~= "Dough_Arm" then
                                    u3:Create(v28[v29], TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                                        ["CFrame"] = v30.CFrame
                                    }):Play()
                                end
                            end
                        end
                    end
                    u3:Create(u21, TweenInfo.new(0.2, Enum.EasingStyle.Cubic), {
                        ["Brightness"] = 0,
                        ["Range"] = 20
                    }):Play()
                    local v31 = Enum.EasingStyle.Cubic
                    u3:Create(u20, TweenInfo.new(0.3, v31), {
                        ["Transparency"] = 1
                    }):Play()
                    u3:Create(u19.Dough_Inverted, TweenInfo.new(0.3, v31), {
                        ["Transparency"] = 1
                    }):Play()
                    u3:Create(u19.Dough_Holee, TweenInfo.new(0.6, v31), {
                        ["Transparency"] = 1
                    }):Play()
                end)
                local u32 = _G.PlaySound(u20, script.MochiV2ExplodingMochiFistShoot)
                u32.Parent = u20
                task.delay(v25, function() --[[ Line: 159 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u19
                        [3] = u10
                        [4] = u5
                        [5] = u12
                        [6] = u24
                        [7] = u22
                        [8] = u2
                        [9] = u32
                        [10] = u4
                        [11] = u15
                        [12] = u3
                        [13] = u14
                        [14] = u23
                        [15] = u13
                    --]]
                    _G.destroy(u20, 0.55)
                    _G.destroy(u19, 0.1)
                    u10(u19)
                    local u33 = script.Projectile:Clone()
                    u5.apply(u33, u12)
                    u33:SetPrimaryPartCFrame(CFrame.new(u24, u22.Position) * CFrame.Angles(0, 1.5707963267948966, 0))
                    local u34 = u33.Fist
                    u33.Parent = u2
                    u32.Parent = u34
                    local v35 = CFrame.new(u24, u22.Position) * CFrame.new(0, 0, -5)
                    local v36 = u4:WaitForChild("FatDoughShotVFX"):Clone()
                    u5.apply(v36, u12)
                    v36.Parent = u2
                    v36.CFrame = v35
                    _G.customEmit(v36)
                    _G.destroy(v36, 4)
                    local v37 = u4.SwirlWind:Clone()
                    u5.apply(v37, u12)
                    v37.CFrame = v35 * CFrame.new(0, 0, -5 * u15) * CFrame.Angles(0, 1.5707963267948966, 0)
                    v37.Parent = u2
                    local v38 = u3
                    local v39 = TweenInfo.new(1.5 * u15, Enum.EasingStyle.Exponential)
                    local v40 = {
                        ["Transparency"] = 1,
                        ["Size"] = Vector3.new(9.271, 6.404, 5.7) * u15 * 2.5
                    }
                    local v41 = v37.Orientation
                    local v42 = 100 * u15
                    v40.Orientation = v41 + Vector3.new(v42, 0, 0)
                    v40.Position = v37.Position + v37.CFrame.RightVector * 7.5
                    v38:Create(v37, v39, v40):Play()
                    _G.destroy(v37, 2.25)
                    local v43 = u4.FireFistWind2:Clone()
                    u5.apply(v43, u12)
                    local v44 = v35 * CFrame.new(0, 0, -5 * u15)
                    local v45 = CFrame.Angles
                    local v46 = u14:NextNumber(-360, 360)
                    v43.CFrame = v44 * v45(-1.5707963267948966, math.rad(v46), 0)
                    v43.Parent = u2
                    u3:Create(v43, TweenInfo.new(0.55 * u15, Enum.EasingStyle.Cubic), {
                        ["Transparency"] = 1,
                        ["Size"] = Vector3.new(14.321, 1.242, 13.92) * u15 * 1.25,
                        ["Position"] = v37.Position + v37.CFrame.RightVector * 7.5
                    }):Play()
                    _G.destroy(v43, 1.5)
                    local v47 = u4.FireFistWind3:Clone()
                    u5.apply(v47, u12)
                    local v48 = v35 * CFrame.new(0, 0, 5 * u15)
                    local v49 = CFrame.Angles
                    local v50 = u14:NextNumber(-360, 360)
                    v47.CFrame = v48 * v49(-1.5707963267948966, math.rad(v50), 0)
                    v47.Parent = u2
                    u3:Create(v47, TweenInfo.new(0.55 * u15, Enum.EasingStyle.Cubic), {
                        ["Transparency"] = 1,
                        ["Size"] = Vector3.new(5.989, 2.798, 6.373) * u15 * 2,
                        ["Position"] = v37.Position + v37.CFrame.RightVector * -10
                    }):Play()
                    _G.destroy(v47, 1.5)
                    local v51 = (u24 - u22.Position).Magnitude
                    u3:Create(u33.PrimaryPart, TweenInfo.new(u23, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ["CFrame"] = u33.PrimaryPart.CFrame * CFrame.new(v51, 0, 0)
                    }):Play()
                    local u52 = false
                    task.spawn(function() --[[ Line: 221 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                            [2] = u14
                            [3] = u4
                            [4] = u5
                            [5] = u12
                            [6] = u34
                            [7] = u15
                            [8] = u2
                            [9] = u3
                        --]]
                        for _ = 1, 15 do
                            if u52 then
                                break
                            end
                            local v53 = u14:NextInteger(1, 2) == 1 and "FistFlyingWind" or "FistFlyingWind2"
                            local v54 = u4[v53]:Clone()
                            u5.apply(v54, u12)
                            local v55 = u34:GetPivot() * CFrame.new(0, 0, -1 * u15)
                            local v56 = CFrame.Angles
                            local v57 = u14:NextNumber(-360, 360)
                            v54.CFrame = v55 * v56(-1.5707963267948966, math.rad(v57), 0)
                            v54.Parent = u2
                            local v58 = v53 == "FistFlyingWind" and Vector3.new(1.537, 3.628, 1.537) * u15 * 2.25 or Vector3.new(3.159, 14.1, 3.159) * u15
                            u3:Create(v54, TweenInfo.new(0.65 * u15, Enum.EasingStyle.Cubic), {
                                ["Position"] = u34.Position + v54.CFrame.LookVector * 1.5 * u15
                            }):Play()
                            u3:Create(v54.Mesh, TweenInfo.new(0.65 * u15, Enum.EasingStyle.Exponential), {
                                ["Scale"] = v58
                            }):Play()
                            u3:Create(v54.Decal, TweenInfo.new(0.65 * u15, Enum.EasingStyle.Exponential), {
                                ["Transparency"] = 1
                            }):Play()
                            _G.destroy(v54, 1.5)
                            task.wait(0.05 * u15)
                        end
                    end)
                    local _ = u34.Position
                    local u59 = u4.GroundFireTrail:Clone()
                    u5.apply(u59, u12)
                    _G.particleEnabled(u59, false)
                    u59.Parent = workspace.Effects
                    local u62 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 248 ]]
                        --[[
                        Upvalues:
                            [1] = u34
                            [2] = u59
                        --]]
                        local v60, v61, _ = _G.getRayFloor(CFrame.new(u34.CFrame.Position), 16)
                        if v60 then
                            if u59.Impact.Enabled == false then
                                _G.particleEnabled(u59, true)
                            end
                            u59.CFrame = CFrame.new(v61)
                        elseif u59.Impact.Enabled == true then
                            _G.particleEnabled(u59, false)
                        end
                    end)
                    task.delay(u23 * 0.5, function() --[[ Line: 262 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u5
                            [3] = u12
                            [4] = u23
                            [5] = u15
                            [6] = u33
                            [7] = u2
                            [8] = u14
                            [9] = u34
                        --]]
                        local u63 = u23 * 0.5
                        for _ = 1, 5 do
                            task.wait(0.01 * u15)
                            local v64 = u33:GetPivot()
                            local v65 = u2
                            local u66 = Instance.new("Part")
                            u66.Transparency = 1
                            u66.Anchored = true
                            u66.CanTouch = false
                            u66.CanCollide = false
                            u66.CFrame = v64
                            u66.Position = v64.Position
                            u66.Parent = v65
                            local v67 = u2
                            local v68 = u66.Position
                            local u69 = u14:NextInteger(1, 2) == 2 and u4.BezierP:Clone() or u4.BezierP2:Clone()
                            u5.apply(u69, u12)
                            u69.Position = v68
                            u69.Parent = v67
                            task.spawn(function() --[[ Line: 295 ]]
                                --[[
                                Upvalues:
                                    [1] = u15
                                    [2] = u66
                                    [3] = u63
                                    [4] = u69
                                    [5] = u34
                                --]]
                                local v70 = 20 * u15
                                local v71 = math.random(-math.random(4, 7), math.random(4, 7))
                                local v72 = u66.Position
                                local v73 = math.random(-v70, v70)
                                local v74 = math.random(-v70, v70)
                                local v75 = math.random
                                local v76 = -v70
                                local v77 = v72 + Vector3.new(v73, v74, v75(v76, v70))
                                local v78 = (v77 - u66.Position).Magnitude
                                local v79 = (u66.CFrame * CFrame.new(-v78 / v71, v78 / v71, -v78 / v71)).Position
                                local v80 = 0
                                while v80 < u63 do
                                    v80 = v80 + task.wait()
                                    local v81 = v80 / u63
                                    local v82 = math.clamp(v81, 0, 1)
                                    local v83 = u69
                                    local v84 = u34.Position
                                    v83.Position = v77:Lerp(v79, v82):Lerp(v79:Lerp(v84, v82), v82)
                                end
                                _G.destroy(u69, 5)
                            end)
                            _G.destroy(u66, 3)
                        end
                    end)
                    task.delay(u23, function() --[[ Line: 323 ]]
                        --[[
                        Upvalues:
                            [1] = u62
                            [2] = u59
                            [3] = u52
                            [4] = u10
                            [5] = u33
                            [6] = u4
                            [7] = u5
                            [8] = u12
                            [9] = u22
                            [10] = u3
                            [11] = u24
                            [12] = u13
                        --]]
                        u62:Disconnect()
                        _G.particleEnabled(u59, false)
                        _G.destroy(u59, 3)
                        u52 = true
                        u10(u33)
                        _G.particleEnabled(u33, false)
                        local v85 = u4:WaitForChild("FireFistExplodeVFX"):Clone()
                        u5.apply(v85, u12)
                        v85.CFrame = u22
                        v85.Parent = workspace.Effects
                        u3:Create(v85.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                            ["Range"] = 40,
                            ["Brightness"] = 0
                        }):Play()
                        _G.customEmit(v85)
                        _G.destroy(v85, 3)
                        _G.destroy(u33, 3)
                        _G.shakenear(v85.CFrame.Position, 125, 100, 100, -1)
                        _G.PlaySound(v85, script.MochiV2ExplodingMochiFistBoom, {
                            ["RandomPitch"] = true
                        })
                        local v86 = CFrame.new(u24)
                        if u13.partHit == true then
                            local v87 = u13.Position + u13.Normal * 0.01
                            _G.PlayEffect("GroundRocks4", nil, {
                                ["Segments"] = 14,
                                ["Position"] = v87,
                                ["DistanceRandomness"] = Vector2.new(0.3, 1),
                                ["Duration"] = 3,
                                ["TweenDuration"] = 1,
                                ["Radius"] = 10,
                                ["Direction"] = -u13.Normal * 15
                            })
                            _G.PlayEffect("RockDebris", nil, {
                                ["PartCount"] = 5,
                                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                                ["Position"] = v87,
                                ["Direction"] = CFrame.new(v87, v86.Position).LookVector * 55 + Vector3.new(0, 25, 0),
                                ["RaycastDirection"] = -u13.Normal * 15,
                                ["Size"] = Vector3.new(0.6, 0.6, 0.6),
                                ["TrailEnabled"] = true
                            })
                            _G.PlayEffect("MochiImpactDroplet", nil, CFrame.new(v87), 6, 1.5, 25, 0.25, 0.7, CFrame.new(v87, v86.Position).LookVector * 25 + Vector3.new(0, 15, 0), u12)
                        end
                    end)
                end)
            elseif u19 then
                u19:Destroy()
            end
        end
    end
end
return v1