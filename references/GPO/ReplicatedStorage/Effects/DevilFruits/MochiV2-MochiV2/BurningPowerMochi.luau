 

local v1 = {}
local u2 = workspace.Effects
local _ = game["Run Service"]
local u3 = game:GetService("TweenService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4.Modules.Client.WeaponVFXRecolor)
local u6 = 0
local u7 = script.PowerMochi
function v1.start(_, u8, p9, p10, _, _, u11, u12, u13) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u5
        [4] = u2
        [5] = u3
    --]]
    local u14 = game.Players.LocalPlayer.Character
    local u15 = p9 or 1
    local u16 = p10 or 48.252
    local v17 = Random.new()
    local u18 = v17:NextNumber(0.75, 1.25)
    v17:NextNumber(100, 150)
    local u19 = { "Left_Base", "LeftRoot" }
    local u20 = { "Left_Palm_Extender", "LeftExtend" }
    u6 = 1
    local u21 = u7.RightFist:Clone()
    u5.apply(u21, u14)
    local u22 = u21.Fist
    local u23 = u21.Haki
    local u24 = u21.Dough
    u21:PivotTo(u8)
    local u25 = u23.Size / u21.Fist.Size
    if u13 ~= nil then
        u21.Fist:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u21
                [3] = u25
            --]]
            task.defer(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u21
                    [3] = u25
                --]]
                u23.Size = u21.Fist.Size * u25
            end)
        end)
    end
    u21:ScaleTo(0.001)
    u22.Transparency = 1
    u21.Parent = u2
    u21.AnimationController:LoadAnimation(u21.loopedFist):Play(0)
    _G.PlayEffect("TweenModel", nil, u21, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), 2.5)
    local v26 = u7.DoughVFX:Clone()
    u5.apply(v26, u14)
    v26.CFrame = u24:GetPivot() * CFrame.Angles(0, 0, 0)
    v26.Parent = u2
    _G.customEmit(v26)
    _G.destroy(v26, 1)
    task.delay(0.1, function() --[[ Line: 95 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u22
            [3] = u14
        --]]
        _G.PlayEffect("MochiImpactDroplet", nil, u24.CFrame, 10, 1.5, 25, 0.4, 0.7, u22.CFrame.LookVector * 35 + Vector3.new(0, 15, 0), u14)
    end)
    _G.particleEnabled(u21, false)
    _G.PlaySound(u8, script.MochiV2FirePowerMochiCircleAppear)
    task.delay(0.2, function() --[[ Line: 101 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u21
            [3] = u22
            [4] = u13
            [5] = u5
            [6] = u14
            [7] = u16
            [8] = u3
            [9] = u19
            [10] = u6
            [11] = u20
            [12] = u15
            [13] = u7
            [14] = u2
            [15] = u18
            [16] = u24
            [17] = u11
            [18] = u12
        --]]
        _G.shakenear(u8.Position, 75, 75, 80, -0.5)
        _G.PlayEffect("TweenModel", nil, u21, TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), 2.75)
        _G.PlaySound(u22, script.MochiV2FirePowerMochiFistShoot)
        u22.PointLight.Brightness = 4
        u22.Transparency = 0
        if u13 then
            u21.Haki.Color = u13
            u21.Haki.Transparency = 0
            u5.apply(u21.Haki, u14)
        end
        u16 = u16 - (u21.PrimaryPart.Left_Base.Position - u21.PrimaryPart.Left_Base.Left_Palm_Extender.Position).Magnitude
        u3:Create(u21.PrimaryPart[u19[u6]][u20[u6]], TweenInfo.new(u15 * 0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ["CFrame"] = u21.PrimaryPart[u19[u6]][u20[u6]].CFrame * CFrame.new(0, u16 * 0.9, 0)
        }):Play()
        u3:Create(u22, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Size"] = u22.Size * 1.1
        }):Play()
        _G.particleEnabled(u21, true)
        u3:Create(u21.Fist.SmokeLeft, TweenInfo.new(u15 * 1.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ["CFrame"] = u22.SmokeLeft.CFrame * CFrame.new(0, 0, -u16 * 0.9)
        }):Play()
        u3:Create(u21.Fist.SmokeRight, TweenInfo.new(u15 * 1.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ["CFrame"] = u22.SmokeRight.CFrame * CFrame.new(0, 0, -u16 * 0.9)
        }):Play()
        u22.Beam.Enabled = true
        u22.Beam2.Enabled = true
        local v27 = u7.FistShotVFX:Clone()
        u5.apply(v27, u14)
        v27.CFrame = u8
        v27.Parent = u2
        _G.customEmit(v27)
        _G.destroy(v27, 2)
        u3:Create(u22.PointLight, TweenInfo.new(0.75 * u18, Enum.EasingStyle.Cubic), {
            ["Brightness"] = 0
        }):Play()
        local v28 = u7.FistWind1:Clone()
        u5.apply(v28, u14)
        v28.CFrame = u24:GetPivot() * CFrame.new(0, -7.5 * u18, 0)
        v28.Parent = u2
        local v29 = u3
        local v30 = v28.Mesh
        local v31 = TweenInfo.new(1.1 * u18, Enum.EasingStyle.Exponential)
        local v32 = {}
        local v33 = 7.179 * u18
        local v34 = 60.066 * u18
        local v35 = 7.179 * u18
        v32.Scale = Vector3.new(v33, v34, v35)
        v29:Create(v30, v31, v32):Play()
        u3:Create(v28.Decal, TweenInfo.new(1.1 * u18, Enum.EasingStyle.Exponential), {
            ["Transparency"] = 1
        }):Play()
        _G.destroy(v28, 2)
        local v36 = u7.FistWind2:Clone()
        u5.apply(v36, u14)
        v36.CFrame = u24:GetPivot() * CFrame.new(0, -10 * u18, 0)
        v36.Parent = u2
        local v37 = u3
        local v38 = v36.Mesh
        local v39 = TweenInfo.new(1.25 * u18, Enum.EasingStyle.Exponential)
        local v40 = {}
        local v41 = 5.241 * u18
        local v42 = 5.436 * u18
        local v43 = 5.241 * u18
        v40.Scale = Vector3.new(v41, v42, v43)
        v37:Create(v38, v39, v40):Play()
        u3:Create(v36.Decal, TweenInfo.new(1.25 * u18, Enum.EasingStyle.Exponential), {
            ["Transparency"] = 1
        }):Play()
        _G.destroy(v36, 2)
        task.delay(u15 * 0.8, function() --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u22
                [3] = u15
                [4] = u21
                [5] = u19
                [6] = u6
                [7] = u20
                [8] = u16
                [9] = u24
                [10] = u18
                [11] = u7
                [12] = u5
                [13] = u14
                [14] = u2
                [15] = u11
                [16] = u12
                [17] = u8
            --]]
            u3:Create(u22, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                ["Size"] = u22.Size * 0.8
            }):Play()
            task.delay(u15 * 0.1, function() --[[ Line: 164 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u21
                    [3] = u19
                    [4] = u6
                    [5] = u20
                    [6] = u15
                    [7] = u16
                --]]
                u3:Create(u21.PrimaryPart[u19[u6]][u20[u6]], TweenInfo.new(u15 * 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    ["CFrame"] = u21.PrimaryPart[u19[u6]][u20[u6]].CFrame * CFrame.new(0, u16 * 0.1, 0)
                }):Play()
            end)
            local v44 = u24:GetPivot() * CFrame.new(0, -u16 - 5 * u18, 0)
            local v45 = u7.FistImpact4:Clone()
            u5.apply(v45, u14)
            v45.CFrame = v44
            v45.Parent = u2
            local v46 = u3
            local v47 = v45.Mesh
            local v48 = TweenInfo.new(0.6 * u18, Enum.EasingStyle.Exponential)
            local v49 = {}
            local v50 = 5.233 * u18
            local v51 = 20.28 * u18
            local v52 = 5.233 * u18
            v49.Scale = Vector3.new(v50, v51, v52)
            v46:Create(v47, v48, v49):Play()
            u3:Create(v45.Decal, TweenInfo.new(0.6 * u18, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v45, 1.5)
            local v53 = u7.FistImpact5:Clone()
            u5.apply(v53, u14)
            v53.CFrame = v44
            v53.Parent = u2
            local v54 = u3
            local v55 = v53.Mesh
            local v56 = TweenInfo.new(0.65 * u18, Enum.EasingStyle.Exponential)
            local v57 = {}
            local v58 = 4.381 * u18
            local v59 = 6.3 * u18
            local v60 = 4.381 * u18
            v57.Scale = Vector3.new(v58, v59, v60)
            v54:Create(v55, v56, v57):Play()
            u3:Create(v53.Decal, TweenInfo.new(0.65 * u18, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v53, 1.5)
            local v61 = u7.FistWind1:Clone()
            u5.apply(v61, u14)
            v61.CFrame = u24:GetPivot() * CFrame.new(0, -15 * u18, 0)
            v61.Parent = u2
            local v62 = u3
            local v63 = v61.Mesh
            local v64 = TweenInfo.new(1 * u18, Enum.EasingStyle.Exponential)
            local v65 = {}
            local v66 = 7.179 * u18 * 0.8
            local v67 = 47.066 * u18 * 0.8
            local v68 = 7.179 * u18 * 0.8
            v65.Scale = Vector3.new(v66, v67, v68)
            v62:Create(v63, v64, v65):Play()
            u3:Create(v61.Decal, TweenInfo.new(1 * u18, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v61, 2)
            local v69 = u7.FistWind2:Clone()
            u5.apply(v69, u14)
            v69.CFrame = u24:GetPivot() * CFrame.new(0, -10 * u18, 0)
            v69.Parent = u2
            local v70 = u3
            local v71 = v69.Mesh
            local v72 = TweenInfo.new(0.75 * u18, Enum.EasingStyle.Exponential)
            local v73 = {}
            local v74 = 5.241 * u18 * 0.8
            local v75 = 5.436 * u18 * 0.8
            local v76 = 5.241 * u18 * 0.8
            v73.Scale = Vector3.new(v74, v75, v76)
            v70:Create(v71, v72, v73):Play()
            u3:Create(v69.Decal, TweenInfo.new(0.75 * u18, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v69, 2)
            local v77 = u7.AirImpactVFX:Clone()
            u5.apply(v77, u14)
            v77.CFrame = v44
            v77.Parent = u2
            _G.customEmit(v77)
            _G.destroy(v77, 2)
            u22.Beam.TextureSpeed = -u22.Beam.TextureSpeed
            u22.Beam2.TextureSpeed = -u22.Beam2.TextureSpeed
            u22.Beam.Enabled = false
            u22.Beam2.Enabled = false
            if u11 then
                local v78 = u7.FistImpactVFX:Clone()
                u5.apply(v78, u14)
                v78.CFrame = u11
                v78.Parent = workspace.Effects
                _G.customEmit(v78)
                _G.destroy(v78, 4)
                local v79 = u12.Position + u12.Normal * 0.01
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 14,
                    ["Position"] = v79,
                    ["DistanceRandomness"] = Vector2.new(0.3, 1),
                    ["Duration"] = 3,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 14,
                    ["Direction"] = -u12.Normal * 15,
                    ["Angle"] = 0.4363323129985824
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 6,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                    ["Position"] = v79,
                    ["Direction"] = CFrame.new(v79, u8.Position).LookVector * 55 + Vector3.new(0, 25, 0),
                    ["RaycastDirection"] = -u12.Normal * 15,
                    ["Size"] = Vector3.new(0.8, 0.8, 0.8),
                    ["TrailEnabled"] = true
                })
                _G.PlayEffect("MochiImpactDroplet", nil, CFrame.new(v79), 10, 1.5, 25, 0.4, 0.7, CFrame.new(v79, u8.Position).LookVector * 25 + Vector3.new(0, 15, 0), u14)
                u3:Create(v78.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    ["Range"] = 40,
                    ["Brightness"] = 0
                }):Play()
                _G.PlaySound(v78, script.MochiV2FirePowerMochiWallHit, {
                    ["RandomPitch"] = true
                })
            end
        end)
        task.delay(u15 * 1.2, function() --[[ Line: 254 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            _G.particleEnabled(u21, false)
        end)
        task.delay(u15 * 2.15, function() --[[ Line: 258 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u21
                [3] = u19
                [4] = u6
                [5] = u20
                [6] = u15
                [7] = u7
                [8] = u24
                [9] = u5
                [10] = u14
                [11] = u2
            --]]
            u3:Create(u21.PrimaryPart[u19[u6]][u20[u6]], TweenInfo.new(u15 * 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["CFrame"] = u7.RightFist.PrimaryPart.Left_Base.Left_Palm_Extender.CFrame
            }):Play()
            game:GetService("TweenService")
            game:GetService("RunService")
            local u80 = u24
            local u81 = tick()
            local u82 = nil
            local u83 = 1000
            local u84 = 0.75
            u82 = game["Run Service"].Heartbeat:Connect(function(p85) --[[ Line: 13 ]]
                --[[
                Upvalues:
                    [1] = u80
                    [2] = u83
                    [3] = u81
                    [4] = u84
                    [5] = u82
                --]]
                local v86 = u80
                local v87 = u80:GetPivot()
                local v88 = CFrame.Angles
                local v89 = -u83 * p85
                v86:PivotTo(v87 * v88(0, math.rad(v89), 0))
                if u84 <= tick() - u81 then
                    u82:Disconnect()
                    u82 = nil
                end
            end)
            task.wait(0.2)
            _G.PlayEffect("TweenModel", nil, u21, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0.001)
            u3:Create(u21.Dough, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["CFrame"] = u21.Dough.CFrame * CFrame.new(0, 0, u21.Dough.Size.Z)
            }):Play()
            local v90 = u7.DoughVFX:Clone()
            u5.apply(v90, u14)
            v90.CFrame = u24:GetPivot() * CFrame.Angles(0, 0, 0)
            v90.Parent = u2
            _G.customEmit(v90)
            _G.destroy(v90, 1)
            _G.destroy(u21, 0.4)
            _G.destroy(u24, 0.3)
        end)
    end)
end
return v1