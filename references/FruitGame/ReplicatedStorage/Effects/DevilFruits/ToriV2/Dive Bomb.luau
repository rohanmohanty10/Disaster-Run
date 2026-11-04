 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
local u3 = require(script.Bezier)
require(script.ModuleScript)
local u4 = require(script.crater)
return {
    ["start"] = function(_, p5, p6, p7, p8) --[[ Name: start, Line 26 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
            [4] = u4
        --]]
        if _G.checkRenderDistance(p5.PrimaryPart.Position) == false then
            return
        else
            Random.new()
            local _ = workspace.CurrentCamera
            p5:GetAttribute("Transformed")
            p5:FindFirstChild("CharacterEffects")
            local v9 = p5:FindFirstChild("PhoenixFullForm")
            local u10 = p5.PrimaryPart
            local v11 = p5:FindFirstChild("Humanoid")
            p5:FindFirstChild("UpperTorso")
            local v12 = u10.CFrame
            local v13 = v12 * CFrame.new(0, -2.3, 0)
            local v14 = p5 == game.Players.LocalPlayer.Character
            local v15 = v9.Body.Transparency == 0
            local v16
            if v14 then
                v16 = Instance.new("ObjectValue")
                v16.Parent = p5
            else
                v16 = nil
            end
            local u17, u18, v19
            if v15 then
                u17 = v9.AnimationController.Animator:LoadAnimation(script.Parent.Anims.Full.DiveTravel)
                u18 = v9.AnimationController.Animator:LoadAnimation(script.Parent.Anims.Full.DiveSuccess)
                v19 = v9.AnimationController.Animator:LoadAnimation(script.Parent.Anims.Full.DiveSuccessCamera)
            else
                u17 = v11.Animator:LoadAnimation(script.Parent.Anims.Hybrid.DiveTravel)
                u18 = v11.Animator:LoadAnimation(script.Parent.Anims.Hybrid.DiveSuccess)
                v19 = v11.Animator:LoadAnimation(script.Parent.Anims.Hybrid.DiveSuccessCamera)
            end
            u17:AdjustWeight(5)
            u18:AdjustWeight(5)
            v19:AdjustWeight(5)
            local u20 = script["Ground Trail"]:Clone()
            u20.CFrame = v13
            u20.Parent = workspace.Effects
            local v21 = CFrame.new(u10.Position, p8)
            local v22 = CFrame.new
            local v23 = (p8 - u10.Position).Magnitude
            local v24 = v21 * v22(0, 0, -math.clamp(v23, 30, p7))
            local v25 = CFrame.new(v12.Position, v24.Position)
            local v26 = (v24.Position - v25.Position).Magnitude
            local u27 = v26 / (v15 and 255 or 150)
            local v28 = v25:Lerp(v24, 0.5) * CFrame.new(v26 / 2, 0, 0)
            local u29 = u3.new(v25.Position, v28.Position, v24.Position)
            local u30 = v25.Position
            local u31 = nil
            u17:Play()
            local u32 = v15 == false and 1 or 1.04
            task.delay(u32, function() --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u32
                --]]
                u17:AdjustSpeed(0)
                u17.TimePosition = u32
            end)
            task.wait(0.5)
            _G.PlaySound(u10, script.DiveSFX.DiveBombWhoosh, {
                ["PlaybackSpeed"] = 1
            }, true).Parent = u10
            v11.PlatformStand = false
            u10.CFrame = v25
            local u33 = tick()
            local u34 = nil
            local u35 = false
            u34 = u1.Stepped:Connect(function() --[[ Line: 134 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u33
                    [3] = u27
                    [4] = u2
                    [5] = u31
                    [6] = u29
                    [7] = u30
                    [8] = u35
                    [9] = u34
                    [10] = u20
                --]]
                local v36 = workspace:Raycast(u10.Position, Vector3.new(0, -15, 0), Ess.RaycastParams)
                local v37 = tick() - u33
                u31 = u29:Get(u2:GetValue(v37 / u27, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), 1)
                local v38 = CFrame.new(u30, u31)
                local v39 = workspace:Raycast(v38.Position, v38.LookVector * 10, Ess.RaycastParams)
                u10.CFrame = v38
                if v39 then
                    u35 = true
                    u34:Disconnect()
                    u34 = nil
                else
                    if v37 < u27 then
                        if v36 then
                            u20.CFrame = CFrame.new(v36.Position, v36.Position + u10.CFrame.LookVector)
                            u20.Debris.Color = ColorSequence.new(v36.Instance.Color)
                            if not u20.Blue.Enabled then
                                for _, v40 in u20:GetChildren() do
                                    if v40:IsA("ParticleEmitter") then
                                        v40.Enabled = true
                                    end
                                end
                            end
                        elseif u20.Blue.Enabled then
                            for _, v41 in u20:GetChildren() do
                                if v41:IsA("ParticleEmitter") then
                                    v41.Enabled = false
                                end
                            end
                        end
                    else
                        for _, v42 in u20:GetChildren() do
                            if v42:IsA("ParticleEmitter") then
                                v42.Enabled = false
                            end
                        end
                        u34:Disconnect()
                        u34 = nil
                        u35 = true
                    end
                    u30 = u31
                end
            end)
            repeat
                task.wait()
            until u35 == true
            u17:Stop()
            u10.CFrame = CFrame.new(u10.Position)
            for _, v43 in u20:GetChildren() do
                if v43:IsA("ParticleEmitter") then
                    v43.Enabled = false
                end
            end
            _G.PlaySound(u10, script.DiveSFX.DiveBombFlyUp).Parent = u10
            local _, v44, _ = _G.getRayFloor(u10.CFrame, -100)
            local u45 = (v44 - u10.Position).Magnitude - 3
            u18:Play(0.1, 1, 0.7)
            task.delay(1.52, function() --[[ Line: 227 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                u18:AdjustSpeed(0)
            end)
            local v46 = TweenCreate
            local v47 = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            local v48 = {}
            local v49 = u45
            v48.CFrame = u10.CFrame + Vector3.new(0, v49, 0)
            v46(u10, v47, v48)
            local u50 = script.DashUp:Clone()
            local v51 = CFrame.new(u10.CFrame.Position)
            local v52 = u45 / 5
            u50.CFrame = v51 + Vector3.new(0, v52, 0)
            u50.Parent = workspace.Effects
            task.delay(0.12, function() --[[ Line: 243 ]]
                --[[
                Upvalues:
                    [1] = u50
                    [2] = u20
                    [3] = u45
                --]]
                local v53 = { u50, u20 }
                Ess.Destroy(v53, 1)
                Emit(u50:GetDescendants(), true)
                TweenCreate(u50, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["CFrame"] = u50.CFrame * CFrame.new(0, u45 / 1.5, 0)
                })
            end)
            if p6 and game.Players.LocalPlayer.Character == p5 then
                p6:FireServer(CFrame.new(u10.CFrame.Position), true)
            end
            task.wait(1.2)
            v19:Stop(0.5)
            _G.PlaySound(u10, script.DiveSFX.DiveBombWhoosh, {
                ["PlaybackSpeed"] = 0.75,
                ["Volume"] = 1
            }, true).Parent = u10
            v11.PlatformStand = true
            local u54 = workspace:Raycast(v24.Position + Vector3.new(0, 1, 0), Vector3.new(0, -100, 0), Ess.RaycastParams)
            local u55 = nil
            local u56 = script.OldExplosionGroundMarks:Clone()
            local u57 = script.BeanWind:Clone()
            local v58 = script.Bomb:Clone()
            v58.CFrame = v24
            v58.Parent = workspace.Effects
            local u59 = v58.PointLight
            local u60 = script.Dive:Clone()
            u60.CFrame = CFrame.new(v58.Position) * CFrame.new(0, u45, 0)
            u60.Parent = workspace.Effects
            local u61 = script.Trail:Clone()
            Ess.BeamToggle(u61:GetDescendants(), false)
            u61.CFrame = u60.CFrame
            u61.Parent = workspace.Effects
            Emit(u60.Emit:GetChildren(), true)
            Emit(u60.Rings2:GetDescendants(), true)
            local u62 = u10.CFrame
            local u63 = tick()
            local u64 = tick()
            local u65 = tick()
            local u66 = v15 and 25 or 10
            local u67 = nil
            u67 = u1.Stepped:Connect(function(_, p68) --[[ Line: 307 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u10
                    [3] = u64
                    [4] = u63
                    [5] = u65
                    [6] = u62
                    [7] = u2
                    [8] = u18
                    [9] = u54
                    [10] = u67
                    [11] = u61
                    [12] = u66
                    [13] = u60
                --]]
                u55 = workspace:Raycast(u10.Position, Vector3.new(0, -15, 0), Ess.RaycastParams)
                u64 = u64 + p68
                local v69 = u64 - u63
                local v70 = math.clamp(v69, 0, 2)
                local _ = tick() - u65 > 0.15
                local v71 = u62.Y - u10.CFrame.Y
                local v72 = math.abs(v71)
                local v73 = math.clamp(v72, 0, 400)
                local v74 = u2:GetValue(v70 / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                local v75 = math.clamp(v74, 0, 1)
                if u55 then
                    u18:Stop(0.3)
                    u54 = u55
                    u55 = true
                    u67:Disconnect()
                    return
                elseif v70 >= 2 or v73 >= 400 then
                    u18:Stop(0.3)
                    u55 = false
                    u67:Disconnect()
                else
                    local v76 = -400 * v75 * 1.35
                    u10.CFrame = u62 + Vector3.new(0, v76, 0)
                    local v77 = u61
                    local v78 = CFrame.new(u10.Position) * CFrame.new(0, -u66, 0)
                    local v79 = CFrame.Angles
                    local v80 = v70 * 2000 % 360
                    local v81 = math.ceil(v80)
                    local v82 = math.abs(v81)
                    v77.CFrame = v78 * v79(0, math.rad(v82), 0)
                    u60.Position = u61.Position
                end
            end)
            for _, v83 in u61:GetChildren() do
                local v84 = v83.Position
                v83.Position = v84 * 0
                TweenCreate(v83, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ["Position"] = v84 * 2
                })
            end
            Ess.BeamToggle(u61:GetDescendants(), true)
            repeat
                task.wait()
                local v85 = u55
            until typeof(v85) ~= "RaycastResult" and u55 ~= nil
            if u55 == false then
                Emit(u61:GetDescendants(), false)
                Emit(u60:GetDescendants(), false)
                Ess.Destroy({ v58, u60, u61 }, 1.3)
                p6:FireServer("end", true)
                if v16 then
                    v16:Destroy()
                end
            else
                Ess.Destroy({ v58, u60, u61 }, 5)
                _G.PlaySound(u10, script.DiveSFX.DiveBombBoom, {
                    ["PlaybackSpeed"] = 1
                }, true)
                if u54 then
                    v24 = CFrame.new(u54.Position)
                end
                local v86 = v24 + Vector3.new(0, 0.15, 0)
                v58.CFrame = v86
                local v87, _, _ = _G.getRayFloor(u10.CFrame, 35)
                if v87 then
                    v58.Attachment["Ground Shards"].Color = ColorSequence.new(v87.Color)
                else
                    v58.Attachment["Ground Shards"]:Destroy()
                end
                Emit(v58:GetDescendants(), true)
                Emit(u60:GetDescendants(), false)
                Emit(u61:GetDescendants(), false)
                if v16 then
                    v16:Destroy()
                end
                u4:start(v86 - Vector3.new(0, 5, 0), 23, u54)
                local u88 = tick()
                local u89 = v86 + Vector3.new(0, 10, 0)
                u57.CFrame = u89
                u57.Parent = workspace.Effects
                TweenCreate(u57.Mesh, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {
                    ["Scale"] = u57.Mesh.Scale * Vector3.new(2.5, 3, 2.5)
                })
                TweenCreate(u57.Decal, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                })
                local u96 = u1.Heartbeat:Connect(function() --[[ Line: 423 ]]
                    --[[
                    Upvalues:
                        [1] = u88
                        [2] = u57
                        [3] = u89
                    --]]
                    local v90 = tick() - u88
                    local v91 = u57
                    local v92 = u89:Lerp(u89 - Vector3.new(0, 20, 0), v90 / 0.55)
                    local v93 = CFrame.Angles
                    local v94 = v90 * 700 % 360
                    local v95 = math.ceil(v94)
                    v91.CFrame = v92 * v93(0, math.rad(v95), 0)
                end)
                task.delay(0.55, function() --[[ Line: 430 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u96
                    --]]
                    local v97 = { u57, u96 }
                    Ess.Destroy(v97, 0)
                end)
                u56.CFrame = v86
                u56.Size = Vector3.new(0, 0, 0)
                u56.Parent = workspace.Effects
                if p6 and game.Players.LocalPlayer.Character == p5 then
                    p6:FireServer(v86)
                end
                TweenCreate(u56, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                    ["Size"] = script.ExplosionGroundMarks.Size
                })
                task.delay(0.5, function() --[[ Line: 451 ]]
                    --[[
                    Upvalues:
                        [1] = u56
                    --]]
                    for _, v98 in pairs(u56:GetChildren()) do
                        local v99 = v98:GetAttribute("Time") or 1.2
                        TweenCreate(v98, TweenInfo.new(v99, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                            ["Color3"] = Color3.new(0, 0, 0),
                            ["Transparency"] = 1
                        })
                    end
                end)
                Ess.Destroy(u56, 2)
                TweenCreate(u59, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                    ["Brightness"] = 40,
                    ["Range"] = 60,
                    ["Color"] = Color3.new(0.153811, 0.864652, 0.998871)
                })
                task.delay(0.1, function() --[[ Line: 479 ]]
                    --[[
                    Upvalues:
                        [1] = u59
                    --]]
                    TweenCreate(u59, TweenInfo.new(0.05, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false), {
                        ["Brightness"] = 0,
                        ["Range"] = 0
                    })
                end)
            end
        end
    end
}