 

local u1 = script
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("RunService")
local u4 = workspace.Effects
game:GetService("Debris")
local u5 = game:GetService("TweenService")
local u6 = require(v2.Modules.EffectsUtil)
local u7 = require(script.Parent.WindEmitter)
local u8 = {
    ["startCharge"] = 0.6666666666666666,
    ["crackHead"] = 1.5,
    ["igniteHand"] = 2.3666666666666667,
    ["punch"] = 2.95,
    ["windEmitter"] = 3.783333333333333,
    ["punchRelease"] = 3.816666666666667,
    ["victimShockwaveAttach"] = 3.8333333333333335,
    ["trails"] = 3.7666666666666666,
    ["impactFrame"] = 3.5,
    ["stopCamera"] = 4.5
}
local u9 = Random.new()
function impact()
    local v10 = {
        ["Brightness"] = -2,
        ["Contrast"] = 5,
        ["Saturation"] = -1
    }
    local v11 = {
        ["Brightness"] = 0,
        ["Contrast"] = -4,
        ["Saturation"] = -2
    }
    local v12 = Instance.new("ColorCorrectionEffect")
    v12.Parent = game.Lighting
    _G.tween(v12, { 0.03333333333333333, "Linear", Enum.EasingDirection.Out }, v10)
    task.wait(0.06666666666666667)
    _G.tween(v12, { 0.06666666666666667, "Linear", Enum.EasingDirection.Out }, v11)
    task.wait(0.15)
    _G.tween(v12, { 0.06666666666666667, "Quad", Enum.EasingDirection.Out }, v10)
    task.wait(0.1)
    _G.tween(v12, { 0.03333333333333333, "Quad", Enum.EasingDirection.Out }, v11)
    task.wait(0.016666666666666666)
    _G.tween(v12, { 0.06666666666666667, "Quad", Enum.EasingDirection.Out }, {
        ["Brightness"] = 1,
        ["Contrast"] = 8,
        ["Saturation"] = -1.3
    })
    task.wait(0.06666666666666667)
    _G.tween(v12, { 0.4166666666666667, "Quad", Enum.EasingDirection.InOut }, {
        ["Brightness"] = 0,
        ["Contrast"] = 0,
        ["Saturation"] = 0
    })
    _G.destroy(v12, 1)
end
local u13 = {
    {
        40,
        70,
        "Sine",
        "Out"
    },
    {
        90,
        50,
        "Back",
        "Out"
    },
    {
        150,
        100,
        "Quad",
        "In"
    },
    {
        170,
        67,
        "Back",
        "Out"
    },
    {
        190,
        50,
        "Back",
        "In"
    },
    {
        213,
        90,
        "Sine",
        "InOut"
    },
    {
        233,
        70,
        "Back",
        "Out"
    },
    {
        246,
        80,
        "Sine",
        "InOut"
    },
    { 272, 70 }
}
return {
    ["start"] = function(_, u14, u15, u16) --[[ Name: start, Line 86 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u5
            [3] = u13
            [4] = u8
            [5] = u1
            [6] = u6
            [7] = u9
            [8] = u4
            [9] = u7
        --]]
        if _G.checkRenderDistance(u14.PrimaryPart.Position) ~= false then
            _G.PlaySound(u14.HumanoidRootPart, script.DragonUlt)
            local u17 = u14.HumanoidRootPart
            local u18 = u15.HumanoidRootPart
            local _ = u14.Humanoid
            local _ = u15.Humanoid
            u15:WaitForChild("camra", 2)
            u15.camra.Transparency = 1
            local u19 = { u15:findFirstChild("Head"), u15:findFirstChild("Hair1"), u15:findFirstChild("Hair2") }
            for v20 = 1, #u19 do
                if u19[v20] then
                    u19[v20].Transparency = 0.75
                end
            end
            local v21 = game.Players:GetPlayerFromCharacter(u14)
            local v22 = game.Players:GetPlayerFromCharacter(u15)
            local u23 = game.Players.LocalPlayer == v21 or game.Players.LocalPlayer == v22
            local u24 = nil
            task.spawn(function() --[[ Line: 124 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u24
                    [3] = u3
                    [4] = u5
                    [5] = u15
                --]]
                if u23 ~= false then
                    local u25 = tick()
                    local u26 = workspace.CurrentCamera.CFrame
                    u24 = u3.RenderStepped:Connect(function() --[[ Line: 131 ]]
                        --[[
                        Upvalues:
                            [1] = u25
                            [2] = u5
                            [3] = u15
                            [4] = u24
                            [5] = u26
                        --]]
                        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                        local v27 = u5:GetValue((tick() - u25) / 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                        if u15:findFirstChild("camra") == nil then
                            u24:Disconnect()
                            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                            u24:Disconnect()
                            return
                        elseif v27 < 1 then
                            workspace.CurrentCamera.CFrame = u26:Lerp(u15.camra.CFrame, v27)
                        else
                            workspace.CurrentCamera.CFrame = u15.camra.CFrame
                        end
                    end)
                end
            end)
            task.spawn(function() --[[ Line: 151 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u13
                    [3] = u5
                --]]
                if u23 ~= false then
                    workspace.CurrentCamera.FieldOfView = 70
                    for u28, u29 in u13 do
                        task.delay(u29[1] / 60, function() --[[ Line: 157 ]]
                            --[[
                            Upvalues:
                                [1] = u13
                                [2] = u28
                                [3] = u5
                                [4] = u29
                            --]]
                            local v30 = u13[u28 + 1]
                            if v30 then
                                u5:Create(workspace.CurrentCamera, TweenInfo.new((v30[1] - u29[1]) / 60, Enum.EasingStyle[u29[3]], Enum.EasingDirection[u29[4]]), {
                                    ["FieldOfView"] = v30[2]
                                }):Play()
                            end
                        end)
                    end
                end
            end)
            local u31 = nil
            task.delay(u8.startCharge, function() --[[ Line: 168 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u1
                    [3] = u15
                    [4] = u6
                    [5] = u31
                --]]
                local v32 = u16 and u1.Particles.charge:Clone() or u1.Particles.chargenoMera:Clone()
                v32.Parent = u15.Head
                v32.Name = "charge"
                u6:ToggleEnabled(v32, true)
                u31 = u1.Skull:Clone()
                local v33 = Instance.new("Highlight")
                v33.DepthMode = Enum.HighlightDepthMode.Occluded
                v33.FillTransparency = 1
                v33.FillColor = Color3.fromRGB(255, 255, 255)
                v33.Parent = u31
                local v34 = Instance.new("Highlight")
                v34.DepthMode = Enum.HighlightDepthMode.Occluded
                v34.FillTransparency = 1
                v34.FillColor = Color3.fromRGB(255, 255, 255)
                v34.Parent = u31.Mouth
                u31.Parent = u15.Head
                local v35 = Instance.new("Weld")
                v35.Part0 = u31.Root
                v35.Part1 = u15.Head
                v35.C0 = CFrame.new(0, -0.1, 0)
                v35.Parent = u31.Root
                _G.tween(u15.Head, { 0.2, "Quad", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 0.5
                })
                _G.destroy(u31, 4)
            end)
            task.delay(u8.crackHead, function() --[[ Line: 198 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u6
                    [3] = u16
                    [4] = u1
                    [5] = u17
                    [6] = u9
                    [7] = u31
                --]]
                if u15:findFirstChild("Head") and u15.Head:findFirstChild("charge") then
                    local v36 = u15.Head.charge
                    u6:ToggleEnabled(v36, false)
                    _G.destroy(v36, 1)
                end
                if u15:findFirstChild("Head") ~= nil and (not u15:findFirstChild("Head") or u15:findFirstChild("Head"):findFirstChild("charge") ~= nil) then
                    local v37 = u16 and u1.Particles.crack:Clone() or u1.Particles.cracknoMera:Clone()
                    v37.Parent = u15.Head
                    u6:Emit(v37)
                    _G.destroy(v37, 2)
                    local v38 = u1.BlackWind:Clone()
                    v38.Parent = workspace.Effects
                    local v39 = u17.CFrame * CFrame.new(0, -2.5, 0)
                    local v40 = CFrame.Angles
                    local v41 = u9:NextNumber(0, 360)
                    v38.CFrame = v39 * v40(0, math.rad(v41), 0)
                    _G.tween(v38.Mesh, { 1, "Quart", Enum.EasingDirection.Out }, {
                        ["Scale"] = v38.Mesh.Scale * Vector3.new(1.5, 1, 1.5)
                    })
                    _G.tween(v38, { 1, "Quad", Enum.EasingDirection.Out }, {
                        ["CFrame"] = v38.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(0, -2.0943951023931953, 0)
                    })
                    _G.tween(v38.Decal, { 1, "Quad", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v38, 1)
                    for _, v42 in u31.Root:GetChildren() do
                        local v43 = v42.C0
                        local v44 = CFrame.Angles
                        local v45 = u9:NextNumber(-20, 20)
                        local v46 = math.rad(v45)
                        local v47 = u9:NextNumber(-20, 20)
                        local v48 = math.rad(v47)
                        local v49 = u9:NextNumber(-20, 20)
                        v42.C0 = v43 * v44(v46, v48, (math.rad(v49)))
                    end
                end
            end)
            task.delay(u8.igniteHand, function() --[[ Line: 227 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u16
                    [3] = u14
                --]]
                local v50 = u1.Flare:Clone()
                if not u16 then
                    v50.Color = ColorSequence.new(Color3.new(1, 1, 1))
                end
                v50.Parent = u14.LeftHand
                v50:Emit(25)
                local v51 = u16 and u1.HandFire:Clone() or u1.Shockwave:Clone()
                v51.Parent = u14.LeftHand
                v51.Name = "HandFire"
                v51:Emit(5)
                task.wait(2)
                v51.Enabled = false
                _G.destroy(v51, 2)
                _G.destroy(v50, 2)
            end)
            task.delay(u8.punch, function() --[[ Line: 244 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u16
                    [3] = u4
                    [4] = u18
                    [5] = u17
                    [6] = u14
                --]]
                local v52 = u1.Impact1:Clone()
                if not u16 then
                    v52.Decal.Color3 = Color3.new(5000, 5000, 5000)
                end
                v52.Parent = u4
                v52.CFrame = u18.CFrame * CFrame.new(-0.205001831, 0.407987356, -3.83898544, -0.707106769, 2.51214789e-15, 0.707106769, -0.707106769, -2.51214789e-15, -0.707106769, 0, -1, -3.55271368e-15)
                v52.CFrame = v52.CFrame * CFrame.new(0, -3, 0)
                _G.tween(v52.Mesh, { 1, "Cubic", Enum.EasingDirection.In }, {
                    ["Scale"] = Vector3.new(0, 25, 0)
                })
                _G.tween(v52, { 1, "Cubic", Enum.EasingDirection.In }, {
                    ["CFrame"] = v52.CFrame * CFrame.new(0, -2, 0)
                })
                _G.destroy(v52, 1)
                local v53 = u1.RoundWind:Clone()
                v53.Parent = u4
                v53.CFrame = u18.CFrame * CFrame.new(-0.205001831, 0.407990217, 1.16101456, 9.93152464e-21, 0, 1, -1, 0, -9.93152464e-21, -0, -1, -0)
                _G.tween(v53.Mesh, { 1.5, "Sine", Enum.EasingDirection.Out }, {
                    ["Scale"] = Vector3.new(1.5, 9, 1.5)
                })
                _G.tween(v53, { 1.5, "Sine", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v53.CFrame * CFrame.new(0, -2, 0)
                })
                _G.tween(v53.Decal, { 0.75, "Sine", Enum.EasingDirection.In }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v53, 2)
                local v54 = u1.Particles.dust:Clone()
                v54.Parent = u17
                v54.Position = Vector3.new(0, -2.5, 0)
                v54.Dust:Emit(5)
                _G.destroy(v54, 2)
                u14.LeftHand.HandFire.TimeScale = 0.5
            end)
            task.delay(u8.trails, function() --[[ Line: 276 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u3
                    [3] = u5
                    [4] = u16
                    [5] = u17
                --]]
                local function u72(p55, u56) --[[ Line: 277 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u3
                        [3] = u5
                    --]]
                    local u57 = u1.TrailPart:Clone()
                    local v58 = u57.Attachment1
                    v58.Position = v58.Position + Vector3.new(10, 0, 0)
                    local v59 = u57.Attachment2
                    v59.Position = v59.Position + Vector3.new(10, 0, 0)
                    u57.Trail.Color = ColorSequence.new(p55)
                    u57.CFrame = u56
                    local u60 = 0
                    local u61 = u56 * CFrame.new(0, 0, -10)
                    local u62 = nil
                    u62 = u3.Heartbeat:Connect(function(p63) --[[ Line: 287 ]]
                        --[[
                        Upvalues:
                            [1] = u60
                            [2] = u5
                            [3] = u57
                            [4] = u56
                            [5] = u61
                            [6] = u62
                        --]]
                        u60 = u60 + p63
                        local v64 = u5
                        local v65 = u60 / 0.75
                        local v66 = v64:GetValue(math.clamp(v65, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local v67 = u57
                        local v68 = u56:Lerp(u61, v66)
                        local v69 = CFrame.Angles
                        local v70 = 360 * v66
                        v67.CFrame = v68 * v69(0, 0, (math.rad(v70)))
                        if u60 >= 0.75 then
                            u62:Disconnect()
                        end
                    end)
                    local v71 = { 0.5, "Quad", Enum.EasingDirection.In }
                    u57.Parent = workspace.Effects
                    _G.tween(u57.Attachment1, v71, {
                        ["Position"] = u57.Attachment1.Position - Vector3.new(10, 0, 0)
                    })
                    _G.tween(u57.Attachment2, v71, {
                        ["Position"] = u57.Attachment2.Position - Vector3.new(10, 0, 0)
                    })
                end
                task.spawn(function() --[[ Line: 303 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u17
                        [3] = u72
                    --]]
                    for v73 = 1, 6 do
                        local v74 = v73 / 6 * 360
                        local v75
                        if v73 % 2 == 0 then
                            v75 = u16 and Color3.fromRGB(255, 54, 28) or Color3.fromRGB(255, 255, 255)
                        else
                            v75 = Color3.fromRGB(0, 0, 0)
                        end
                        u72(v75, u17.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 0, (math.rad(v74))))
                    end
                end)
            end)
            task.delay(u8.victimShockwaveAttach, function() --[[ Line: 318 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u1
                    [3] = u18
                    [4] = u16
                --]]
                local u76 = {
                    ["Shockwave1"] = CFrame.new(0, 0, -2.14361763),
                    ["Shockwave3"] = CFrame.new(0, 0, -3.15401459),
                    ["Shockwave2"] = CFrame.new(0, 0, -3.26227379),
                    ["Shockwave4"] = CFrame.new(0, 0, -2)
                }
                for u77 = 1, 4 do
                    task.spawn(function() --[[ Line: 326 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                            [2] = u1
                            [3] = u77
                            [4] = u76
                            [5] = u18
                            [6] = u16
                        --]]
                        if u15:findFirstChild("LowerTorso") ~= nil then
                            local v78 = u77
                            local v79 = u1["Shockwave" .. tostring(v78)]:Clone()
                            local v80 = u76[v79.Name]
                            v79.Parent = workspace.Effects
                            local v81 = math.random(0, 180)
                            local v82 = math.random(-25, 25)
                            local v83 = u18.Position - u15.LowerTorso.Position
                            local v84 = (u18.CFrame - v83) * v80 * CFrame.new(0, 0, 1) * CFrame.Angles(-1.5707963267948966, 0, 0)
                            local v85 = CFrame.Angles
                            local v86 = v81 + 0 * v82
                            v79.CFrame = v84 * v85(0, math.rad(v86), 0)
                            v79.Decal.Transparency = 1
                            if u77 == 4 then
                                _G.tween(v79.Decal, { 0.1, "Quad", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 0.7
                                })
                                _G.tween(v79.Mesh, { 1, "Quad", Enum.EasingDirection.Out }, {
                                    ["Scale"] = v79.Mesh.Scale + Vector3.new(0.25, 3, 0.25),
                                    ["Offset"] = Vector3.new(0, -2, 0)
                                })
                                task.wait(0.1)
                                _G.tween(v79.Decal, { 0.4, "Quad", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 1
                                })
                            else
                                if not u16 then
                                    v79.Decal.Color3 = Color3.fromRGB(1000, 1000, 1000)
                                end
                                _G.tween(v79.Decal, { 0.2, "Quad", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 0
                                })
                                _G.tween(v79.Mesh, { 1, "Quad", Enum.EasingDirection.Out }, {
                                    ["Scale"] = v79.Mesh.Scale + Vector3.new(0, 4, 0),
                                    ["Offset"] = Vector3.new(0, 0.5, 0)
                                })
                                task.wait(0.2)
                                _G.tween(v79.Decal, { u77 / 4 + 0.4, "Quad", Enum.EasingDirection.In }, {
                                    ["Transparency"] = 1
                                })
                            end
                            task.wait(2)
                            v79:Destroy()
                        end
                    end)
                end
            end)
            task.delay(u8.punchRelease, function() --[[ Line: 370 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u1
                    [3] = u18
                    [4] = u17
                    [5] = u16
                    [6] = u9
                --]]
                u14.LeftHand.HandFire.TimeScale = 1
                local v87 = CFrame.new(0.549957275, -0.150016069, 5.33802223, -3.38810594e-21, -0.499998391, 0.866026342, 1.42108547e-14, 0.866026342, 0.499998391, -1, 0, 7.10542736e-15)
                local v88 = u1.Ring:Clone()
                v88.Parent = workspace.Effects
                v88.CFrame = u18.CFrame * CFrame.new(0, 0, -2) * v87
                local v89 = v88.Mesh
                v89.Scale = v89.Scale * 1.5
                _G.tween(v88.Mesh, { 0.6, "Quint", Enum.EasingDirection.Out }, {
                    ["Scale"] = v88.Mesh.Scale * 1.5
                })
                _G.tween(v88.Decal, { 0.5, "Sine", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v88, 1)
                local v90 = u1.FireParticles:Clone()
                v90.Parent = workspace.Effects
                v90.CFrame = u17.CFrame * CFrame.new(0, 0, -3)
                for _, v91 in pairs(v90:GetDescendants()) do
                    if v91:IsA("ParticleEmitter") then
                        if v91.Name ~= "Black" and not u16 then
                            v91.Color = ColorSequence.new(Color3.new(1, 1, 1))
                        end
                        _G.customEmit(v91)
                    end
                end
                _G.destroy(v90, 2)
                task.spawn(function() --[[ Line: 397 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u1
                        [3] = u17
                    --]]
                    for _ = 1, 3 do
                        local v92 = u9:NextNumber(0.5, 1)
                        local v93 = u1.WindSide:Clone()
                        v93.Parent = workspace.Effects
                        local v94 = v93.Mesh
                        local v95 = v94.Scale
                        local v96 = v92 * 1.5
                        local v97 = u9
                        v94.Scale = v95 * Vector3.new(v92, v96, v97:NextNumber(0.5, 1.25))
                        v93.CFrame = u17.CFrame * CFrame.new(0, v92 * -1, u9:NextNumber(-4, 2)) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                        _G.tween(v93.Mesh, { u9:NextNumber(1, 1.5), "Quart", Enum.EasingDirection.Out }, {
                            ["Scale"] = v93.Mesh.Scale * Vector3.new(2, 1, 1.25)
                        })
                        _G.tween(v93, { u9:NextNumber(1, 2), "Quart", Enum.EasingDirection.Out }, {
                            ["CFrame"] = v93.CFrame * CFrame.new(v93.Mesh.Scale.X * 1, 0, 0)
                        })
                        _G.tween(v93.Decal, { u9:NextNumber(0.7, 1.5), "Sine", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        _G.destroy(v93, 2)
                        if u9:NextInteger(0, 1) == 1 then
                            task.wait(0.016666666666666666)
                        end
                    end
                end)
                task.spawn(function() --[[ Line: 414 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u1
                        [3] = u17
                    --]]
                    for _ = 1, 12 do
                        local v98 = u9:NextNumber(0.5, 1)
                        local v99 = u1.WindSide:Clone()
                        v99.Parent = workspace.Effects
                        local v100 = v99.Mesh
                        local v101 = v100.Scale
                        local v102 = v98 * 1.5
                        local v103 = u9
                        v100.Scale = v101 * (Vector3.new(1.75, 1.5, 1.5) * Vector3.new(v98, v102, v103:NextNumber(0.5, 1.25)))
                        v99.CFrame = u17.CFrame * CFrame.new(0, v98 * -1, u9:NextNumber(-14, -10)) * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                        _G.tween(v99.Mesh, { u9:NextNumber(1, 1.5), "Quart", Enum.EasingDirection.Out }, {
                            ["Scale"] = v99.Mesh.Scale * Vector3.new(2, 1, 1.25)
                        })
                        _G.tween(v99, { u9:NextNumber(1, 2), "Quart", Enum.EasingDirection.Out }, {
                            ["CFrame"] = v99.CFrame * CFrame.new(v99.Mesh.Scale.X * 0.75, 0, 0)
                        })
                        _G.tween(v99.Decal, { u9:NextNumber(0.7, 1.5), "Sine", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        _G.destroy(v99, 2)
                        if u9:NextInteger(0, 1) == 1 then
                            task.wait(0.016666666666666666)
                        end
                    end
                end)
            end)
            task.delay(u8.windEmitter, function() --[[ Line: 433 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u4
                    [3] = u18
                    [4] = u5
                    [5] = u16
                    [6] = u7
                    [7] = u3
                --]]
                local v104 = u1.Wind:Clone()
                local v105 = v104.Root
                v104.Parent = u4
                v105.CFrame = u18.CFrame * CFrame.new(-0.205001831, 0.407990217, 1.16101456, 9.93152464e-21, 0, 1, -1, 0, -9.93152464e-21, -0, -1, -0) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0, 3)
                u5:Create(v105, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CFrame"] = v105.CFrame * CFrame.new(0, 0, -14)
                }):Play()
                _G.destroy(v104, 2)
                local u106 = {}
                for _, v107 in pairs(v104:GetChildren()) do
                    if v107.Name == "3" and not u16 then
                        v107.Decal.Color3 = Color3.fromRGB(1000, 1000, 1000)
                    end
                    if v107.Name ~= "Root" then
                        u106[v107] = u7.new(v107, v107, {
                            ["lifetime"] = NumberRange.new(0.5, 1),
                            ["rate"] = 0.016666666666666666,
                            ["scale"] = 0.25,
                            ["acceleration"] = Vector3.new(0, -3, 0),
                            ["accelerationEnvelope"] = Vector3.new(0, 1, 0),
                            ["goalTransparency"] = v107.Decal.Transparency
                        })
                        v107.Decal.Transparency = 1
                        u106[v107]:Enable()
                    end
                end
                local u108 = 0
                local v111 = u3.Heartbeat:Connect(function(p109) --[[ Line: 463 ]]
                    --[[
                    Upvalues:
                        [1] = u106
                        [2] = u5
                        [3] = u108
                    --]]
                    for _, v110 in pairs(u106) do
                        v110.scale = u5:GetValue(u108 / 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 0.5 + 1.5
                    end
                    u108 = u108 + p109
                end)
                task.wait(0.2)
                for v112, v113 in pairs(u106) do
                    v113:Destroy()
                    u106[v112] = nil
                    v111:Disconnect()
                end
            end)
            task.delay(u8.stopCamera, function() --[[ Line: 479 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u23
                    [3] = u24
                --]]
                for v114 = 1, #u19 do
                    if u19[v114] then
                        u19[v114].Transparency = 0
                    end
                end
                if u23 ~= false then
                    u24:Disconnect()
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                end
            end)
            task.delay(u8.impactFrame, function() --[[ Line: 492 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u15
                --]]
                local v115 = game.Players:GetPlayerFromCharacter(u14)
                local v116 = game.Players:GetPlayerFromCharacter(u15)
                if game.Players.LocalPlayer == v115 or game.Players.LocalPlayer == v116 then
                    impact()
                end
            end)
        end
    end
}