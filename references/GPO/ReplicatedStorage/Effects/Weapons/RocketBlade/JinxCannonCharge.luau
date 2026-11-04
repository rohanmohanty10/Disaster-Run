 

local u1 = require(script.Bezier)
local u2 = game:GetService("RunService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v4 = {}
local u5 = { Color3.new(1, 1, 1), Color3.new(1, 0.580392, 0.101961), Color3.new(1, 0.196078, 0.0745098) }
local u6 = { Color3.new(1, 1, 1), Color3.new(0.54902, 0.556863, 1), Color3.new(0.333333, 0.333333, 1) }
local function u12(p7, p8, p9) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
    --]]
    local v10 = u5
    if p9 == true then
        v10 = u6
    end
    p7.Color = v10[p8]
    for _, v11 in ipairs(p7:GetDescendants()) do
        if v11:GetAttribute("CanColor") == true then
            if v11:IsA("Trail") or v11:IsA("ParticleEmitter") then
                v11.Color = ColorSequence.new(v10[p8])
            else
                v11.Color = v10[p8]
            end
        end
    end
end
local function u15(p13) --[[ Line: 33 ]]
    if (p13.Position - workspace.CurrentCamera.CFrame.Position).Magnitude < 200 then
        local v14 = script.Blur:Clone()
        v14.Parent = workspace.CurrentCamera
        _G.tween(v14, {
            1,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["InFocusRadius"] = 250,
            ["FarIntensity"] = 0
        })
        _G.destroy(v14, 1)
    end
end
function v4.start(_, u16, u17) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u15
        [3] = u12
        [4] = u1
        [5] = u2
    --]]
    if _G.checkRenderDistance(u16.PrimaryPart.Position) ~= false then
        local u18 = script.JinxCannonCharge:Clone()
        local v19
        if u17 then
            v19 = script:FindFirstChild("ChargeStage1")
        else
            v19 = u17
        end
        local u20
        if u17 then
            u20 = u3.getWeaponColors(u16) ~= nil
        else
            u20 = u17
        end
        u3.apply(u18, u16, v19)
        u18.Parent = workspace.Effects
        local v21 = workspace:GetServerTimeNow()
        local v22 = workspace:GetServerTimeNow()
        local v23 = _G.PlaySound(u16.PrimaryPart, script.RocketBladeCHARGE)
        local u24 = tick()
        u18.Lightning.Rate = 10
        _G.tween(u18.PointLight, {
            0.2,
            "Quad",
            Enum.EasingDirection.Out,
            -1,
            true,
            0
        }, {
            ["Range"] = 15
        })
        local u25 = nil
        local v26 = nil
        local u27 = 0.1
        local u28 = 1
        local v29 = 1
        while u16:FindFirstChild("Charging") and (u16.Parent and (u16 and u16:FindFirstChild("HumanoidRootPart"))) do
            local u30 = u16.PrimaryPart.CFrame * CFrame.new(0, 0, -10)
            local v31 = u16:FindFirstChild("Charging").Value
            if workspace:GetServerTimeNow() - v31 < 2.5 then
                u25 = 1
            elseif workspace:GetServerTimeNow() - v31 > 2.5 and workspace:GetServerTimeNow() - v31 < 4 then
                if u25 < 2 then
                    u15(u30)
                    u25 = 2
                end
                u27 = 0.25
            elseif workspace:GetServerTimeNow() - v31 > 4 then
                if u25 < 3 then
                    u15(u30)
                    u25 = 3
                end
                u27 = 0.5
                if v26 == nil then
                    v26 = script.MaxChargeLoop:Clone()
                    v26.Parent = u16.PrimaryPart
                    v26:Play()
                end
            end
            if not u20 then
                u12(u18, u25, u17)
                u12(u18.PointLight, u25, u17)
            end
            if u25 ~= v29 then
                _G.customEmit(u18.Change)
                if u20 and script:FindFirstChild("ChargeStage" .. u25) then
                    u3.apply(u18, u16, script["ChargeStage" .. u25])
                end
            end
            local v32 = u18.Lightning
            v32.Rate = v32.Rate + u27
            local v33 = u18.Attachment.LinesMain
            v33.Rate = v33.Rate + u27 * 2
            local v34 = u18.wind
            v34.Rate = v34.Rate + u27 * 2
            local v35 = u18.wind2
            v35.Rate = v35.Rate + u27 * 2
            if workspace:GetServerTimeNow() - v22 > 0.5 / (u25 * 2) then
                local v36 = script.BeanWind:Clone()
                u3.apply(v36, u16)
                local v37 = CFrame.Angles
                local v38 = math.random(0, 180)
                local v39 = math.rad(v38)
                local v40 = math.random(0, 180)
                local v41 = math.rad(v40)
                local v42 = math.random(0, 180)
                v36.CFrame = u30 * v37(v39, v41, (math.rad(v42)))
                v36.Parent = workspace.Effects
                _G.tween(v36.Mesh, {
                    0.6,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(6, 12, 6)
                })
                _G.tween(v36.Decal, {
                    0.6,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(v36, {
                    0.6,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v36.CFrame * CFrame.Angles(0, 2.181661564992912, 0)
                })
                _G.destroy(v36, 0.6)
                v22 = workspace:GetServerTimeNow()
            end
            if workspace:GetServerTimeNow() - v21 > 0.2 then
                v21 = workspace:GetServerTimeNow()
                task.spawn(function() --[[ Line: 117 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u30
                        [3] = u20
                        [4] = u25
                        [5] = u3
                        [6] = u16
                        [7] = u12
                        [8] = u17
                    --]]
                    u28 = u28 == 1 and 2 or 1
                    local v43 = u30
                    local v44 = CFrame.Angles
                    local v45 = math.random(0, 360)
                    local v46 = math.rad(v45)
                    local v47 = math.random(0, 360)
                    local v48 = math.rad(v47)
                    local v49 = math.random(0, 360)
                    local v50 = v43 * v44(v46, v48, (math.rad(v49)))
                    local v51 = script.trail:Clone()
                    v51.CFrame = v50 * CFrame.new(0, 0, -10)
                    v51.Parent = workspace.Effects
                    if u20 then
                        local v52 = script:FindFirstChild("trailStage" .. (u25 or 1))
                        u3.apply(v51, u16, v52)
                    else
                        u12(v51, u25, u17)
                    end
                    local v53 = math.random(2, 6)
                    for v54 = 0, 1000, 10 do
                        local v55 = u16:FindFirstChild("Charging")
                        if v55 then
                            local v56 = v55.Value
                            local v57 = workspace:GetServerTimeNow() - v56 < 2.5 and 1 or (workspace:GetServerTimeNow() - v56 > 2.5 and workspace:GetServerTimeNow() - v56 < 4 and 2 or (workspace:GetServerTimeNow() - v56 > 4 and 3 or nil))
                            if u20 then
                                local v58 = script:FindFirstChild("trailStage" .. v57)
                                u3.apply(v51, u16, v58)
                            else
                                u12(v51, v57, u17)
                            end
                        end
                        local v59 = CFrame.new
                        local v60 = math.rad(v54)
                        local v61 = v53 * math.cos(v60)
                        local v62 = math.rad(v54)
                        v51.CFrame = v50 * v59(v61, v53 * math.sin(v62), 0)
                        task.wait()
                    end
                    _G.destroy(v51, 1)
                end)
            end
            task.spawn(function() --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u30
                    [3] = u24
                    [4] = u27
                    [5] = u20
                    [6] = u25
                    [7] = u3
                    [8] = u16
                    [9] = u12
                    [10] = u17
                    [11] = u1
                    [12] = u2
                --]]
                u18.CFrame = u30
                if tick() - u24 < 0.275 - u27 then
                    return
                end
                u24 = tick()
                local v63 = script.ChargeTrail:Clone()
                local v64 = u30.Position
                local v65 = math.random(-700, 700) / 35
                local v66 = math.random(-300, 300) / 25
                local v67 = math.random(-700, 700) / 35
                v63.Position = v64 + Vector3.new(v65, v66, v67)
                v63.Parent = workspace.Effects
                local v68 = v63.CFrame
                local v69 = u30.Position
                local v70 = (v68.Position - v69).Magnitude
                local v71 = math.random(-v70 / 12.2, v70 / 8.2)
                local v72 = math.random(-v70 / 8, v70 / 4.6)
                local v73 = -math.random(v70 / 8, v70)
                local v74 = Vector3.new(v71, v72, v73)
                local v75 = v68.Position + v68.LookVector * v70 / 12 + v74
                local v76 = math.random(-v70 / 4.2, v70 / 8.2)
                local v77 = math.random(-v70 / 3, v70)
                local v78 = math.random
                local v79 = -v70 / 7.6
                local v80 = v70 / 4.6
                local v81 = Vector3.new(v76, v77, v78(v79, v80))
                local v82 = v68.Position + v68.LookVector * v70 / 7 + v81
                if u20 then
                    local v83 = script:FindFirstChild("ChargeTrailStage" .. (u25 or 1))
                    u3.apply(v63, u16, v83)
                else
                    u12(v63, u25, u17)
                end
                local v84 = u1.new(v68.Position, v75, v82, v69)
                local v85 = 1
                while v85 ~= v70 do
                    local _ = v63.Position
                    local v86 = u2.Heartbeat:Wait()
                    local v87 = v85 / v70
                    local v88 = v84:Get(v87)
                    if v87 >= 1 or v63 == nil then
                        break
                    end
                    v63.CFrame = CFrame.new(v88, v84:Get(v85 + 100 * v86 / v70))
                    v85 = v85 + 100 * v86
                end
                _G.destroy(v63, 0.4)
            end)
            game["Run Service"].Heartbeat:Wait()
        end
        _G.tween(u18.PointLight, {
            0.6,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0,
            ["Range"] = 0
        }, nil, true)
        for _, v89 in ipairs(u18:GetDescendants()) do
            if v89:IsA("ParticleEmitter") then
                v89.Enabled = false
            end
        end
        _G.destroy(u18, 3)
        if v23 then
            _G.tween(v23, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
        end
        if v26 then
            _G.tween(v26, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v26, 0.25)
        end
    end
end
return v4