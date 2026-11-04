 

local v1 = {}
local u2 = workspace.Effects
local _ = game["Run Service"]
local u3 = game:GetService("TweenService")
local _ = script.PowerMochi
game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local function u10(p5, p6) --[[ Line: 21 ]]
    local v7 = p5:GetDescendants()
    for v8 = 1, #v7 do
        if v7[v8]:IsA("ParticleEmitter") then
            local v9 = v7[v8]:GetAttribute("EmitCount")
            if v9 then
                v7[v8]:SetAttribute("EmitCount", v9 * p6)
            end
        end
    end
end
function v1.start(_, p11) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u10
        [3] = u2
        [4] = u3
    --]]
    local u12 = p11.Character or game.Players.LocalPlayer.Character
    local v13 = p11.startCFrame
    local v14 = p11.FistTimeToArrive
    local v15 = p11.Distance
    local v16 = p11.modelScale
    local v17 = p11.instant
    local u18 = p11.hitCFrame
    local v19 = p11.hakiColor
    local u20 = v14 or 1
    local v21 = v15 or 48.252
    local v22 = v16 or 2.5
    local u23 = v22 >= 2
    local v24 = Random.new()
    local u25 = v24:NextNumber(0.75, 1.25)
    v24:NextNumber(100, 150)
    local u26 = { "Left_Base", "Right_Base" }
    local u27 = { "Left_Palm_Extender", "Right_Palm_Extender" }
    local u28 = p11.HandSide == "Left" and 2 or 1
    local u29 = v22 / 2.5
    if u29 ~= 1 then
        u29 = u29 + 0.1
    end
    local u30 = script.PowerMochi:Clone()
    u4.apply(u30, u12)
    u10(u30.DoughVFX, (math.clamp(u29, 0, 1)))
    _G.destroy(u30, 10)
    local u31
    if u28 == 1 then
        u31 = script.RightFist:Clone()
    else
        u31 = script.LeftFist:Clone()
    end
    u4.apply(u31, u12)
    local u32 = u31.Fist
    local u33 = u31.Dough
    local v34 = u31.Haki
    u31.Parent = u30
    u31:PivotTo(v13)
    local _ = v34.Size / u31.Fist.Size
    u32.Transparency = 1
    u31.Haki.Transparency = 1
    local v35 = u33:GetPivot()
    local v36 = CFrame.Angles
    local v37 = math.random(0, 360)
    u33:PivotTo(v35 * v36(0, 0, (math.rad(v37))))
    if v17 == nil then
        u31:ScaleTo(0.01)
        _G.PlayEffect("TweenModel", nil, u31, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), v22)
    else
        u31:ScaleTo(v22)
    end
    u31.Parent = u2
    u31.AnimationController:LoadAnimation(u31.loopedFist):Play(0)
    _G.destroy(u30, u20 + 2)
    u30:ScaleTo(u29)
    local v38 = u30.DoughVFX:Clone()
    u4.apply(v38, u12)
    v38.CFrame = u33:GetPivot()
    v38.Parent = u2
    _G.customEmit(v38)
    _G.destroy(v38, 1)
    task.delay(0.1, function() --[[ Line: 127 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u33
            [3] = u32
            [4] = u12
        --]]
        if u29 > 1 then
            _G.PlayEffect("MochiImpactDroplet", nil, u33.CFrame, 5 * u29, 1.5 * u29, 25 * u29, 0.4 * u29, 0.7 * u29, (u32.CFrame.LookVector * 35 + Vector3.new(0, 15, 0)) * u29, u12)
        end
    end)
    _G.particleEnabled(u31, false)
    if v17 == nil then
        if u23 == true then
            _G.PlaySound(u32, script.RingSFX.Power["MochiV2AirSlamRingCreate" .. math.random(1, 2)], {
                ["RandomPitch"] = true
            })
        else
            _G.PlaySound(u32, script.RingSFX.Regular["MochiV2SPCircle" .. math.random(1, 5)], {
                ["RandomPitch"] = true
            })
        end
    elseif u23 == false then
        _G.PlaySound(u32, script.ShootSFX.Regular["MochiV2SPSwish" .. math.random(1, 5)], {
            ["RandomPitch"] = true
        })
    else
        _G.PlaySound(u32, script.ShootSFX.Power["MochiV2AirSlamFistShoot" .. math.random(1, 2)], {
            ["RandomPitch"] = true
        })
    end
    if v17 == nil then
        task.wait(0.2)
        if u23 == false then
            _G.PlaySound(u32, script.ShootSFX.Regular["MochiV2SPSwish" .. math.random(1, 5)], {
                ["RandomPitch"] = true
            })
        else
            _G.PlaySound(u32, script.ShootSFX.Power["MochiV2AirSlamFistShoot" .. math.random(1, 2)], {
                ["RandomPitch"] = true
            })
        end
    end
    u32.Transparency = 0
    if v19 then
        u31.Haki.Color = v19
        u31.Haki.Transparency = 0
        u4.apply(u31.Haki, u12)
    end
    local u39 = v21 - (u31.PrimaryPart[u26[u28]].Position - u31.PrimaryPart[u26[u28]][u27[u28]].Position).Magnitude / 2
    _G.tween(u31.PrimaryPart[u26[u28]][u27[u28]], {
        u20,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = u31.PrimaryPart[u26[u28]][u27[u28]].CFrame * CFrame.new(0, u39 * 0.9, 0)
    })
    _G.particleEnabled(u31, true)
    u32.Beam.Enabled = true
    u32.Beam2.Enabled = true
    local v40 = u30.DoughShotVFX
    v40.CFrame = v13
    if u29 == 1 then
        u10(v40, 5)
    end
    v40.Parent = u2
    _G.customEmit(v40)
    _G.destroy(v40, 2)
    local u41 = u33:GetPivot() * CFrame.Angles(1.5707963267948966, 0, 0)
    local v42 = u30.FistWind1:Clone()
    u4.apply(v42, u12)
    v42.CFrame = u41 * CFrame.new(0, -7.5 * u25 * u29, 0)
    v42.Parent = u2
    local v43 = u3
    local v44 = v42.Mesh
    local v45 = TweenInfo.new(1.1 * u25 * u29, Enum.EasingStyle.Exponential)
    local v46 = {}
    local v47 = 7.179 * u25
    local v48 = 60.066 * u25
    local v49 = 7.179 * u25
    v46.Scale = Vector3.new(v47, v48, v49) * u29
    v43:Create(v44, v45, v46):Play()
    u3:Create(v42.Decal, TweenInfo.new(1.1 * u25 * u29, Enum.EasingStyle.Exponential), {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v42, 2)
    local v50 = u30.FistWind2:Clone()
    u4.apply(v50, u12)
    v50.CFrame = u41 * CFrame.new(0, -10 * u25 * u29, 0)
    v50.Parent = u2
    local v51 = u3
    local v52 = v50.Mesh
    local v53 = TweenInfo.new(1.25 * u25 * u29, Enum.EasingStyle.Exponential)
    local v54 = {}
    local v55 = 5.241 * u25
    local v56 = 5.436 * u25
    local v57 = 5.241 * u25
    v54.Scale = Vector3.new(v55, v56, v57) * u29
    v51:Create(v52, v53, v54):Play()
    u3:Create(v50.Decal, TweenInfo.new(1.25 * u25 * u29, Enum.EasingStyle.Exponential), {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v50, 2)
    task.delay(u20 * 0.8, function() --[[ Line: 209 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u41
            [3] = u39
            [4] = u29
            [5] = u25
            [6] = u30
            [7] = u2
            [8] = u3
            [9] = u4
            [10] = u12
            [11] = u31
            [12] = u26
            [13] = u28
            [14] = u27
        --]]
        if u23 ~= false then
            local v58 = u41 * CFrame.new(0, -u39 - 5 * u29 * u25, 0)
            local v59 = u30.FistImpact4
            v59.CFrame = v58
            v59.Parent = u2
            local v60 = u3
            local v61 = v59.Mesh
            local v62 = TweenInfo.new(0.6 * u25 * u29, Enum.EasingStyle.Exponential)
            local v63 = {}
            local v64 = 5.233 * u25
            local v65 = 20.28 * u25
            local v66 = 5.233 * u25
            v63.Scale = Vector3.new(v64, v65, v66) * u29
            v60:Create(v61, v62, v63):Play()
            u3:Create(v59.Decal, TweenInfo.new(0.6 * u25 * u29, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v59, 1.5)
            local v67 = u30.FistImpact5
            v67.CFrame = v58
            v67.Parent = u2
            local v68 = u3
            local v69 = v67.Mesh
            local v70 = TweenInfo.new(0.65 * u25 * u29, Enum.EasingStyle.Exponential)
            local v71 = {}
            local v72 = 4.381 * u25
            local v73 = 6.3 * u25
            local v74 = 4.381 * u25
            v71.Scale = Vector3.new(v72, v73, v74) * u29
            v68:Create(v69, v70, v71):Play()
            u3:Create(v67.Decal, TweenInfo.new(0.65 * u25 * u29, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v67, 1.5)
            local v75 = u30.FistWind1:Clone()
            u4.apply(v75, u12)
            v75.CFrame = u41 * CFrame.new(0, -(15 * u29) * u25, 0)
            v75.Parent = u2
            local v76 = u3
            local v77 = v75.Mesh
            local v78 = TweenInfo.new(1 * u25 * u29, Enum.EasingStyle.Exponential)
            local v79 = {}
            local v80 = 7.179 * u25 * 0.8
            local v81 = 47.066 * u25 * 0.8
            local v82 = 7.179 * u25 * 0.8
            v79.Scale = Vector3.new(v80, v81, v82) * u29
            v76:Create(v77, v78, v79):Play()
            u3:Create(v75.Decal, TweenInfo.new(1 * u25 * u29, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v75, 2)
            local v83 = u30.FistWind2
            v83.CFrame = u41 * CFrame.new(0, -(10 * u29) * u25, 0)
            v83.Parent = u2
            local v84 = u3
            local v85 = v83.Mesh
            local v86 = TweenInfo.new(0.75 * u25 * u29, Enum.EasingStyle.Exponential)
            local v87 = {}
            local v88 = 5.241 * u25 * 0.8
            local v89 = 5.436 * u25 * 0.8
            local v90 = 5.241 * u25 * 0.8
            v87.Scale = Vector3.new(v88, v89, v90) * u29
            v84:Create(v85, v86, v87):Play()
            u3:Create(v83.Decal, TweenInfo.new(0.75 * u25 * u29, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v83, 2)
            local v91 = u30.AirImpactVFX
            v91.CFrame = u31.PrimaryPart[u26[u28]][u27[u28]].WorldCFrame
            v91.Parent = u2
            _G.customEmit(v91)
            _G.destroy(v91, 2)
        end
    end)
    task.delay(u20, function() --[[ Line: 251 ]]
        --[[
        Upvalues:
            [1] = u32
            [2] = u23
            [3] = u30
            [4] = u4
            [5] = u12
            [6] = u31
            [7] = u26
            [8] = u28
            [9] = u27
            [10] = u2
            [11] = u3
            [12] = u25
        --]]
        u32.Beam.Enabled = false
        u32.Beam2.Enabled = false
        if u23 == false then
            local v92 = u30.FistWind1:Clone()
            u4.apply(v92, u12)
            v92.CFrame = u31.PrimaryPart[u26[u28]][u27[u28]].WorldCFrame
            v92.Parent = u2
            local v93 = u3
            local v94 = v92.Mesh
            local v95 = TweenInfo.new(0.5 * u25, Enum.EasingStyle.Exponential)
            local v96 = {}
            local v97 = v92.Mesh.Scale.X * 3 * u25
            local v98 = v92.Mesh.Scale.Y * 3 * u25
            local v99 = v92.Mesh.Scale.Z * 3 * u25
            v96.Scale = Vector3.new(v97, v98, v99)
            v93:Create(v94, v95, v96):Play()
            u3:Create(v92.Decal, TweenInfo.new(0.5 * u25, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v92, 2)
        end
    end)
    task.delay(u20 * 1.2, function() --[[ Line: 270 ]]
        --[[
        Upvalues:
            [1] = u31
        --]]
        _G.particleEnabled(u31, false)
    end)
    task.delay(u20 + 0.025, function() --[[ Line: 274 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u4
            [3] = u12
            [4] = u29
            [5] = u23
            [6] = u31
            [7] = u26
            [8] = u28
            [9] = u27
            [10] = u20
            [11] = u31
            [12] = u33
            [13] = u32
            [14] = u30
            [15] = u2
        --]]
        if u18 then
            if u18.hitHumanoid == nil then
                local v100 = script.FistImpactVFX:Clone()
                u4.apply(v100, u12)
                v100.CFrame = u18.CFrame
                v100.Parent = workspace.Effects
                _G.customEmit(v100)
                _G.destroy(v100, 4)
                _G.PlaySound(v100, script["Audio/MochiV2BarrageGroundHit" .. math.random(1, 3)], {
                    ["RandomPitch"] = true
                })
            else
                local v101 = script.FistImpactHumanoidsVFX:Clone()
                u4.apply(v101, u12)
                v101.CFrame = u18.CFrame
                v101.Parent = workspace.Effects
                _G.customEmit(v101)
                _G.destroy(v101, 4)
            end
            _G.PlayEffect("MochiImpactDroplet", nil, u18.CFrame, 5 * u29, 1.5, 25 * u29, 0.4 * u29, 0.7 * u29, (u18.CFrame.UpVector * 35 + Vector3.new(0, 15, 0)) * u29, u12)
            local v102 = u18.CFrame.Position
            if u23 == true then
                _G.shakenear(v102, 75, 35, 45, -0.5)
            else
                _G.shakenear(v102, 30, 35, 25, -0.5)
            end
        end
        _G.tween(u31.PrimaryPart[u26[u28]][u27[u28]], {
            u20,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["CFrame"] = u31.PrimaryPart[u26[u28]][u27[u28]].CFrame
        })
        local u103 = u33
        local u104 = u20 + 0.125
        local u105 = tick()
        local u106 = nil
        local u107 = 1000
        u106 = game["Run Service"].Heartbeat:Connect(function(p108) --[[ Line: 12 ]]
            --[[
            Upvalues:
                [1] = u103
                [2] = u107
                [3] = u105
                [4] = u104
                [5] = u106
            --]]
            local v109 = u103
            local v110 = u103:GetPivot()
            local v111 = CFrame.Angles
            local v112 = -u107 * p108
            v109:PivotTo(v110 * v111(0, 0, (math.rad(v112))))
            if u104 <= tick() - u105 then
                u106:Disconnect()
                u106 = nil
            end
        end)
        task.wait(u20)
        u31.Haki:Destroy()
        u32.Transparency = 1
        _G.PlayEffect("TweenModel", nil, u31, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0.01)
        _G.destroy(u33, 0.25)
        task.wait(0.125)
        local v113 = u30.DoughVFX
        v113.CFrame = u33:GetPivot() * CFrame.Angles(0, 0, 0)
        v113.Parent = u2
        _G.customEmit(v113)
        _G.destroy(v113, 1)
        _G.destroy(u31, 4)
    end)
end
return v1