 

local v1 = {}
local u2 = workspace.Effects
local _ = game["Run Service"]
local u3 = game:GetService("TweenService")
local _ = script.PowerMochi
game:GetService("TweenService")
local function u9(p4, p5) --[[ Line: 20 ]]
    local v6 = p4:GetDescendants()
    for v7 = 1, #v6 do
        if v6[v7]:IsA("ParticleEmitter") then
            local v8 = v6[v7]:GetAttribute("EmitCount")
            if v8 then
                v6[v7]:SetAttribute("EmitCount", v8 * p5)
            end
        end
    end
end
function v1.start(_, p10) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.startCFrame
    local v12 = p10.FistTimeToArrive
    local v13 = p10.Distance
    local v14 = p10.modelScale
    local v15 = p10.instant
    local u16 = p10.hitCFrame
    local v17 = p10.hakiColor
    local u18 = v12 or 1
    local v19 = v13 or 48.252
    local v20 = v14 or 2.5
    local u21 = v20 >= 2
    local v22 = Random.new()
    local u23 = v22:NextNumber(0.75, 1.25)
    v22:NextNumber(100, 150)
    local u24 = { "Left_Base", "Right_Base" }
    local u25 = { "Left_Palm_Extender", "Right_Palm_Extender" }
    local u26 = p10.HandSide == "Left" and 2 or 1
    local u27 = v20 / 2.5
    if u27 ~= 1 then
        u27 = u27 + 0.1
    end
    local u28 = script.PowerMochi:Clone()
    u9(u28.DoughVFX, (math.clamp(u27, 0, 1)))
    _G.destroy(u28, 10)
    local u29
    if u26 == 1 then
        u29 = u28.RightFist
        u28.LeftFist:Destroy()
    else
        u29 = u28.LeftFist
        u28.RightFist:Destroy()
    end
    local u30 = u29.Fist
    local u31 = u29.Dough
    local v32 = u29.Haki
    u29:PivotTo(v11)
    local _ = v32.Size / u29.Fist.Size
    u29:ScaleTo(0.01)
    u30.Transparency = 1
    u29.Haki.Transparency = 1
    local v33 = u31:GetPivot()
    local v34 = CFrame.Angles
    local v35 = math.random(0, 360)
    u31:PivotTo(v33 * v34(0, 0, (math.rad(v35))))
    if v15 == nil then
        _G.PlayEffect("TweenModel", nil, u29, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), v20)
    else
        u29:ScaleTo(v20)
    end
    u29.Parent = u2
    u29.AnimationController:LoadAnimation(u29.loopedFist):Play(0)
    _G.destroy(u28, u18 + 2)
    u28:ScaleTo(u27)
    local v36 = u28.DoughVFX:Clone()
    v36.CFrame = u31:GetPivot()
    v36.Parent = u2
    _G.customEmit(v36)
    _G.destroy(v36, 1)
    task.delay(0.1, function() --[[ Line: 123 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u31
            [3] = u30
        --]]
        if u27 > 1 then
            _G.PlayEffect("MochiImpactDroplet", nil, u31.CFrame, 5 * u27, 1.5 * u27, 25 * u27, 0.4 * u27, 0.7 * u27, (u30.CFrame.LookVector * 35 + Vector3.new(0, 15, 0)) * u27)
        end
    end)
    _G.particleEnabled(u29, false)
    if v15 == nil then
        if u21 == true then
            _G.PlaySound(u30, script.RingSFX.Power["MochiV2AirSlamRingCreate" .. math.random(1, 2)], {
                ["RandomPitch"] = true
            })
        else
            _G.PlaySound(u30, script.RingSFX.Regular["MochiV2SPCircle" .. math.random(1, 5)], {
                ["RandomPitch"] = true
            })
        end
    elseif u21 == false then
        _G.PlaySound(u30, script.ShootSFX.Regular["MochiV2SPSwish" .. math.random(1, 5)], {
            ["RandomPitch"] = true
        })
    else
        _G.PlaySound(u30, script.ShootSFX.Power["MochiV2AirSlamFistShoot" .. math.random(1, 2)], {
            ["RandomPitch"] = true
        })
    end
    if v15 == nil then
        task.wait(0.2)
        if u21 == false then
            _G.PlaySound(u30, script.ShootSFX.Regular["MochiV2SPSwish" .. math.random(1, 5)], {
                ["RandomPitch"] = true
            })
        else
            _G.PlaySound(u30, script.ShootSFX.Power["MochiV2AirSlamFistShoot" .. math.random(1, 2)], {
                ["RandomPitch"] = true
            })
        end
    end
    u30.Transparency = 0
    if v17 then
        u29.Haki.Color = v17
        u29.Haki.Transparency = 0
    end
    local u37 = v19 - (u29.PrimaryPart[u24[u26]].Position - u29.PrimaryPart[u24[u26]][u25[u26]].Position).Magnitude / 2
    _G.tween(u29.PrimaryPart[u24[u26]][u25[u26]], {
        u18,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = u29.PrimaryPart[u24[u26]][u25[u26]].CFrame * CFrame.new(0, u37 * 0.9, 0)
    })
    _G.particleEnabled(u29, true)
    u30.Beam.Enabled = true
    u30.Beam2.Enabled = true
    local v38 = u28.DoughShotVFX
    v38.CFrame = v11
    if u27 == 1 then
        u9(v38, 5)
    end
    v38.Parent = u2
    _G.customEmit(v38)
    _G.destroy(v38, 2)
    local u39 = u31:GetPivot() * CFrame.Angles(1.5707963267948966, 0, 0)
    local v40 = u28.FistWind1:Clone()
    v40.CFrame = u39 * CFrame.new(0, -7.5 * u23 * u27, 0)
    v40.Parent = u2
    local v41 = u3
    local v42 = v40.Mesh
    local v43 = TweenInfo.new(1.1 * u23 * u27, Enum.EasingStyle.Exponential)
    local v44 = {}
    local v45 = 7.179 * u23
    local v46 = 60.066 * u23
    local v47 = 7.179 * u23
    v44.Scale = Vector3.new(v45, v46, v47) * u27
    v41:Create(v42, v43, v44):Play()
    u3:Create(v40.Decal, TweenInfo.new(1.1 * u23 * u27, Enum.EasingStyle.Exponential), {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v40, 2)
    local v48 = u28.FistWind2:Clone()
    v48.CFrame = u39 * CFrame.new(0, -10 * u23 * u27, 0)
    v48.Parent = u2
    local v49 = u3
    local v50 = v48.Mesh
    local v51 = TweenInfo.new(1.25 * u23 * u27, Enum.EasingStyle.Exponential)
    local v52 = {}
    local v53 = 5.241 * u23
    local v54 = 5.436 * u23
    local v55 = 5.241 * u23
    v52.Scale = Vector3.new(v53, v54, v55) * u27
    v49:Create(v50, v51, v52):Play()
    u3:Create(v48.Decal, TweenInfo.new(1.25 * u23 * u27, Enum.EasingStyle.Exponential), {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v48, 2)
    task.delay(u18 * 0.8, function() --[[ Line: 201 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u39
            [3] = u37
            [4] = u27
            [5] = u23
            [6] = u28
            [7] = u2
            [8] = u3
            [9] = u29
            [10] = u24
            [11] = u26
            [12] = u25
        --]]
        if u21 ~= false then
            local v56 = u39 * CFrame.new(0, -u37 - 5 * u27 * u23, 0)
            local v57 = u28.FistImpact4
            v57.CFrame = v56
            v57.Parent = u2
            local v58 = u3
            local v59 = v57.Mesh
            local v60 = TweenInfo.new(0.6 * u23 * u27, Enum.EasingStyle.Exponential)
            local v61 = {}
            local v62 = 5.233 * u23
            local v63 = 20.28 * u23
            local v64 = 5.233 * u23
            v61.Scale = Vector3.new(v62, v63, v64) * u27
            v58:Create(v59, v60, v61):Play()
            u3:Create(v57.Decal, TweenInfo.new(0.6 * u23 * u27, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v57, 1.5)
            local v65 = u28.FistImpact5
            v65.CFrame = v56
            v65.Parent = u2
            local v66 = u3
            local v67 = v65.Mesh
            local v68 = TweenInfo.new(0.65 * u23 * u27, Enum.EasingStyle.Exponential)
            local v69 = {}
            local v70 = 4.381 * u23
            local v71 = 6.3 * u23
            local v72 = 4.381 * u23
            v69.Scale = Vector3.new(v70, v71, v72) * u27
            v66:Create(v67, v68, v69):Play()
            u3:Create(v65.Decal, TweenInfo.new(0.65 * u23 * u27, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v65, 1.5)
            local v73 = u28.FistWind1:Clone()
            v73.CFrame = u39 * CFrame.new(0, -(15 * u27) * u23, 0)
            v73.Parent = u2
            local v74 = u3
            local v75 = v73.Mesh
            local v76 = TweenInfo.new(1 * u23 * u27, Enum.EasingStyle.Exponential)
            local v77 = {}
            local v78 = 7.179 * u23 * 0.8
            local v79 = 47.066 * u23 * 0.8
            local v80 = 7.179 * u23 * 0.8
            v77.Scale = Vector3.new(v78, v79, v80) * u27
            v74:Create(v75, v76, v77):Play()
            u3:Create(v73.Decal, TweenInfo.new(1 * u23 * u27, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v73, 2)
            local v81 = u28.FistWind2
            v81.CFrame = u39 * CFrame.new(0, -(10 * u27) * u23, 0)
            v81.Parent = u2
            local v82 = u3
            local v83 = v81.Mesh
            local v84 = TweenInfo.new(0.75 * u23 * u27, Enum.EasingStyle.Exponential)
            local v85 = {}
            local v86 = 5.241 * u23 * 0.8
            local v87 = 5.436 * u23 * 0.8
            local v88 = 5.241 * u23 * 0.8
            v85.Scale = Vector3.new(v86, v87, v88) * u27
            v82:Create(v83, v84, v85):Play()
            u3:Create(v81.Decal, TweenInfo.new(0.75 * u23 * u27, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v81, 2)
            local v89 = u28.AirImpactVFX
            v89.CFrame = u29.PrimaryPart[u24[u26]][u25[u26]].WorldCFrame
            v89.Parent = u2
            _G.customEmit(v89)
            _G.destroy(v89, 2)
        end
    end)
    task.delay(u18, function() --[[ Line: 241 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u21
            [3] = u28
            [4] = u29
            [5] = u24
            [6] = u26
            [7] = u25
            [8] = u2
            [9] = u3
            [10] = u23
        --]]
        u30.Beam.Enabled = false
        u30.Beam2.Enabled = false
        if u21 == false then
            local v90 = u28.FistWind1:Clone()
            v90.CFrame = u29.PrimaryPart[u24[u26]][u25[u26]].WorldCFrame
            v90.Parent = u2
            local v91 = u3
            local v92 = v90.Mesh
            local v93 = TweenInfo.new(0.5 * u23, Enum.EasingStyle.Exponential)
            local v94 = {}
            local v95 = v90.Mesh.Scale.X * 3 * u23
            local v96 = v90.Mesh.Scale.Y * 3 * u23
            local v97 = v90.Mesh.Scale.Z * 3 * u23
            v94.Scale = Vector3.new(v95, v96, v97)
            v91:Create(v92, v93, v94):Play()
            u3:Create(v90.Decal, TweenInfo.new(0.5 * u23, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v90, 2)
        end
    end)
    task.delay(u18 * 1.2, function() --[[ Line: 259 ]]
        --[[
        Upvalues:
            [1] = u29
        --]]
        _G.particleEnabled(u29, false)
    end)
    task.delay(u18 + 0.025, function() --[[ Line: 263 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u27
            [3] = u21
            [4] = u29
            [5] = u24
            [6] = u26
            [7] = u25
            [8] = u18
            [9] = u29
            [10] = u31
            [11] = u30
            [12] = u28
            [13] = u2
        --]]
        if u16 then
            if u16.hitHumanoid == nil then
                local v98 = script.FistImpactVFX:Clone()
                v98.CFrame = u16.CFrame
                v98.Parent = workspace.Effects
                _G.customEmit(v98)
                _G.destroy(v98, 4)
                _G.PlaySound(v98, script["Audio/MochiV2BarrageGroundHit" .. math.random(1, 3)], {
                    ["RandomPitch"] = true
                })
            else
                local v99 = script.FistImpactHumanoidsVFX:Clone()
                v99.CFrame = u16.CFrame
                v99.Parent = workspace.Effects
                _G.customEmit(v99)
                _G.destroy(v99, 4)
            end
            _G.PlayEffect("MochiImpactDroplet", nil, u16.CFrame, 5 * u27, 1.5, 25 * u27, 0.4 * u27, 0.7 * u27, (u16.CFrame.UpVector * 35 + Vector3.new(0, 15, 0)) * u27)
            local v100 = u16.CFrame.Position
            if u21 == true then
                _G.shakenear(v100, 75, 35, 45, -0.5)
            else
                _G.shakenear(v100, 30, 35, 25, -0.5)
            end
        end
        _G.tween(u29.PrimaryPart[u24[u26]][u25[u26]], {
            u18,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["CFrame"] = u29.PrimaryPart[u24[u26]][u25[u26]].CFrame
        })
        local u101 = u31
        local u102 = u18 + 0.125
        local u103 = tick()
        local u104 = nil
        local u105 = 1000
        u104 = game["Run Service"].Heartbeat:Connect(function(p106) --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u101
                [2] = u105
                [3] = u103
                [4] = u102
                [5] = u104
            --]]
            local v107 = u101
            local v108 = u101:GetPivot()
            local v109 = CFrame.Angles
            local v110 = -u105 * p106
            v107:PivotTo(v108 * v109(0, 0, (math.rad(v110))))
            if u102 <= tick() - u103 then
                u104:Disconnect()
                u104 = nil
            end
        end)
        task.wait(u18)
        u29.Haki:Destroy()
        u30.Transparency = 1
        _G.PlayEffect("TweenModel", nil, u29, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0.01)
        _G.destroy(u31, 0.25)
        task.wait(0.125)
        local v111 = u28.DoughVFX:Clone()
        v111.CFrame = u31:GetPivot() * CFrame.Angles(0, 0, 0)
        v111.Parent = u2
        _G.customEmit(v111)
        _G.destroy(v111, 1)
        _G.destroy(u29, 4)
    end)
end
return v1