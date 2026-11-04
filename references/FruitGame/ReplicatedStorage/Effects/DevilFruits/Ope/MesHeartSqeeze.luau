 

local v1 = {}
local u2 = script.Parent.MesHeartbeat
local function u5(p3) --[[ Line: 4 ]]
    local v4 = script.Part:Clone()
    v4.CFrame = p3.PrimaryPart.CFrame
    v4.Parent = workspace.Effects
    _G.customEmit(v4)
    _G.scaleParticle(v4.squeezeAttach, 0.75)
    _G.destroy(v4, 4)
end
function v1.start(_, p6, p7) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
    --]]
    if _G.checkRenderDistance(p6:GetPivot().Position) then
        local u8 = p6.opeHeart
        if p7 == false then
            _G.PlaySound(u8["Heart3.001"], u8["Heart3.001"].OpeMesHeartSmallCrush)
            local u9 = u2.heartbeatPart:Clone()
            for _, v10 in pairs(u9.centerAttach:GetChildren()) do
                v10.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
                v10.LightEmission = 0.5
            end
            _G.customEmit(u9.centerAttach, true)
            u9.centerAttach.cameraWave.Rate = 12
            u9.centerAttach.cameraWave:Emit(30)
            game:GetService("TweenService"):Create(u9.centerAttach.cameraWave, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Rate"] = 0
            }, true):Play()
            local v11 = p6.target.Value
            task.spawn(function() --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                for v12 = 1, 8 do
                    if v12 ~= 8 then
                        local v13 = u9["attach" .. v12 + 1]
                        local v14 = v13.Position
                        v13.Position = u9["attach" .. v12].Position
                        if v12 == 1 or v12 == 7 then
                            game:GetService("TweenService"):Create(v13, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ["Position"] = v14
                            }, true):Play()
                        else
                            game:GetService("TweenService"):Create(v13, TweenInfo.new(0.02, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ["Position"] = v14
                            }, true):Play()
                        end
                    end
                    local u15 = u9["beam" .. v12]
                    u15.Color = ColorSequence.new(Color3.fromRGB(120, 0, 0))
                    if v12 == 1 or v12 == 8 then
                        if v12 == 1 then
                            game:GetService("TweenService"):Create(u15, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ["Width0"] = 0,
                                ["Width1"] = 0.2
                            }, true):Play()
                            task.delay(0.05, function() --[[ Line: 87 ]]
                                --[[
                                Upvalues:
                                    [1] = u15
                                --]]
                                game:GetService("TweenService"):Create(u15, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                }, true):Play()
                            end)
                            task.wait(0.05)
                        elseif v12 == 8 then
                            game:GetService("TweenService"):Create(u15, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ["Width0"] = 0.2,
                                ["Width1"] = 0
                            }, true):Play()
                            task.delay(0.05, function() --[[ Line: 101 ]]
                                --[[
                                Upvalues:
                                    [1] = u15
                                --]]
                                game:GetService("TweenService"):Create(u15, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                }, true):Play()
                            end)
                            task.wait(0.05)
                        end
                    else
                        game:GetService("TweenService"):Create(u15, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ["Width0"] = 0.2,
                            ["Width1"] = 0.2
                        }, true):Play()
                        task.delay(0.05, function() --[[ Line: 73 ]]
                            --[[
                            Upvalues:
                                [1] = u15
                            --]]
                            game:GetService("TweenService"):Create(u15, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }, true):Play()
                        end)
                        task.wait(0.02)
                    end
                end
            end)
            u5(v11)
            u8.Glass.squeezeAttach.waveBurst:Emit(30)
            u8.Glass.squeezeAttach.innerSpurts.Enabled = true
            u8.Glass.squeezeAttach.mistFill.Enabled = true
            u8.Glass.squeezeAttach.orbDrops.Enabled = true
            u8.Glass.squeezeAttach.spurtDrops.Enabled = true
            u8.Glass.squeezeAttach.erraticBursts.Enabled = true
            u8.Glass.squeezeAttach.erraticBursts2.Enabled = true
            local u16 = nil
            u16 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 141 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u16
                --]]
                if u9 == nil then
                    u16:Disconnect()
                    u16 = nil
                else
                    u9.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 1.5707963267948966, 0)
                end
            end)
            task.wait(0.15)
            task.wait(0.25)
            u5(v11)
            _G.PlaySound(u8["Heart3.001"], u8["Heart3.001"].OpeMesHeartLargeCrush)
            game:GetService("TweenService"):Create(u8.Glass, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(0.95, 0.95, 0.95)
            }, true):Play()
            game:GetService("TweenService"):Create(u8["Heart3.001"], TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(0.924, 0.935, 0.935)
            }, true):Play()
            for _, v17 in pairs(u8.Glass.squeezeAttach:GetChildren()) do
                v17.Enabled = false
            end
            u8.Glass.squeezeAttach.releaseBurst1:Emit(50)
            u8.Glass.squeezeAttach.releaseBurst2:Emit(100)
            u8.Glass.squeezeAttach.releaseBurst3:Emit(20)
            u8.Glass.squeezeAttach.releaseBurst4:Emit(20)
            u8.Glass.squeezeAttach.releaseBurst5:Emit(30)
            u8.Glass.orbDrop.Rate = 30
            u8.Glass.orbDrop.Enabled = true
            game:GetService("TweenService"):Create(u8.Glass.orbDrop, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Rate"] = 0
            }, true):Play()
            task.wait(0.5)
            u8:SetAttribute("squeezeActive", false)
        else
            game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["TintColor"] = Color3.fromRGB(255, 120, 120),
                ["Brightness"] = -0.1
            }, true):Play()
            game:GetService("TweenService"):Create(game.Lighting.DepthOfFieldF, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["FarIntensity"] = 1,
                ["InFocusRadius"] = 10
            }, true):Play()
            local u18 = u2.renderHeart:Clone()
            u18.Glass.electricitySurround:Destroy()
            u18.Parent = workspace.Effects
            _G.destroy(u18, 6)
            script["OpeMesHeartCrush (1)"]:Play()
            local u19 = {}
            local u20 = u18.AnimationController:LoadAnimation(u2.beat)
            local u21 = nil
            local u22 = 2
            u20:AdjustSpeed(u22)
            task.delay(0.2, function() --[[ Line: 228 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u2
                    [3] = u19
                    [4] = u22
                    [5] = u8
                    [6] = u18
                    [7] = u21
                --]]
                u20:Play()
                u20:GetMarkerReachedSignal("heartbeatStart"):Connect(function() --[[ Line: 232 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u19
                        [3] = u22
                    --]]
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, true), {
                        ["TintColor"] = Color3.fromRGB(255, 120, 120)
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["FieldOfView"] = 65
                    }, true):Play()
                    task.delay(0.15, function() --[[ Line: 242 ]]
                        game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            ["FieldOfView"] = 70
                        }, true):Play()
                    end)
                    local u23 = u2.heartbeatPart:Clone()
                    u23.centerAttach.cameraWave2.Rate = 90
                    u23.Parent = workspace.Effects
                    _G.destroy(u23, 1.5)
                    local v24 = u19
                    table.insert(v24, u23)
                    for _, v25 in pairs(u23.centerAttach:GetChildren()) do
                        v25.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
                        v25.LightEmission = 0.5
                    end
                    _G.customEmit(u23.centerAttach, true)
                    u23.centerAttach.cameraWave.Rate = 12
                    u23.centerAttach.cameraWave:Emit(30)
                    game:GetService("TweenService"):Create(u23.centerAttach.cameraWave, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["Rate"] = 0
                    }, true):Play()
                    task.spawn(function() --[[ Line: 269 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u22
                        --]]
                        for v26 = 1, 8 do
                            if u23.Parent ~= nil then
                                if v26 ~= 8 then
                                    local v27 = u23["attach" .. v26 + 1]
                                    local v28 = v27.Position
                                    v27.Position = u23["attach" .. v26].Position
                                    if v26 == 1 or v26 == 7 then
                                        game:GetService("TweenService"):Create(v27, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Position"] = v28
                                        }, true):Play()
                                    else
                                        game:GetService("TweenService"):Create(v27, TweenInfo.new(0.02, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Position"] = v28
                                        }, true):Play()
                                    end
                                end
                                local u29 = u23["beam" .. v26]
                                u29.Color = ColorSequence.new(Color3.fromRGB(120, 0, 0))
                                if v26 == 1 or v26 == 8 then
                                    if v26 == 1 then
                                        game:GetService("TweenService"):Create(u29, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Width0"] = 0,
                                            ["Width1"] = 0.2
                                        }, true):Play()
                                        task.delay(0.05, function() --[[ Line: 318 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u29
                                                [2] = u22
                                            --]]
                                            game:GetService("TweenService"):Create(u29, TweenInfo.new(0.6 - u22 * 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                ["Width0"] = 0,
                                                ["Width1"] = 0
                                            }, true):Play()
                                        end)
                                        task.wait(0.05)
                                    elseif v26 == 8 then
                                        game:GetService("TweenService"):Create(u29, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                            ["Width0"] = 0.2,
                                            ["Width1"] = 0
                                        }, true):Play()
                                        task.delay(0.05, function() --[[ Line: 332 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u29
                                                [2] = u22
                                            --]]
                                            game:GetService("TweenService"):Create(u29, TweenInfo.new(0.6 - u22 * 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                ["Width0"] = 0,
                                                ["Width1"] = 0
                                            }, true):Play()
                                        end)
                                        task.wait(0.05)
                                    end
                                else
                                    game:GetService("TweenService"):Create(u29, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        ["Width0"] = 0.2,
                                        ["Width1"] = 0.2
                                    }, true):Play()
                                    task.delay(0.05, function() --[[ Line: 304 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u29
                                            [2] = u22
                                        --]]
                                        game:GetService("TweenService"):Create(u29, TweenInfo.new(0.6 - u22 * 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                            ["Width0"] = 0,
                                            ["Width1"] = 0
                                        }, true):Play()
                                    end)
                                    task.wait(0.02)
                                end
                            end
                        end
                    end)
                end)
                task.wait(2)
                u8["Heart3.001"].OpeMesHeartLargeCrush.Playing = true
                u8.Glass.Transparency = 1
                u8["Heart3.001"].Transparency = 1
                u8.Glass.squeezeAttach.releaseBurst1:Emit(50)
                u8.Glass.squeezeAttach.releaseBurst2:Emit(100)
                u8.Glass.squeezeAttach.releaseBurst3:Emit(20)
                u8.Glass.squeezeAttach.releaseBurst4:Emit(20)
                u8.Glass.squeezeAttach.releaseBurst5:Emit(30)
                u8.Glass.orbDrop.Rate = 30
                u8.Glass.orbDrop.Enabled = true
                game:GetService("TweenService"):Create(u8.Glass.orbDrop, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Rate"] = 0
                }, true):Play()
                u18.Glass.Transparency = 1
                u18["Heart3.001"].Transparency = 1
                for _, v30 in pairs(u18.Glass.crushAttach:GetChildren()) do
                    v30:Emit(v30.Rate)
                end
                for _, v31 in pairs(u19) do
                    v31:Destroy()
                end
                u18.Glass.crushAttach.largeOrbBurst:Emit(30)
                u22 = 0
                game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["TintColor"] = Color3.fromRGB(255, 255, 255),
                    ["Brightness"] = -0.2,
                    ["Saturation"] = -1,
                    ["Contrast"] = 5
                }, true):Play()
                game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["FieldOfView"] = 90
                }, true):Play()
                game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Size"] = 20
                }, true):Play()
                task.delay(0.1, function() --[[ Line: 392 ]]
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["TintColor"] = Color3.fromRGB(255, 30, 30),
                        ["Brightness"] = -0.2,
                        ["Saturation"] = -4,
                        ["Contrast"] = 0
                    }, true):Play()
                    task.wait(0.1)
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["TintColor"] = Color3.fromRGB(255, 255, 255),
                        ["Brightness"] = 0
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["Saturation"] = 0
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["FieldOfView"] = 70
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Size"] = 0
                    }, true):Play()
                    game:GetService("TweenService"):Create(game.Lighting.DepthOfFieldF, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        ["FarIntensity"] = 0,
                        ["InFocusRadius"] = 30
                    }, true):Play()
                end)
                task.wait(1)
                u21:Disconnect()
            end)
            local u32 = 0.75
            local u33 = Instance.new("NumberValue")
            u33.Value = -4
            local v34 = {
                ["Value"] = u32
            }
            game:GetService("TweenService"):Create(u33, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), v34, true):Play()
            _G.destroy(u33, 6)
            local u35 = Instance.new("CFrameValue")
            u35.Value = CFrame.new(Random.new():NextNumber(-u32, u32), Random.new():NextNumber(-u32, u32), Random.new():NextNumber(-u32, u32))
            game:GetService("TweenService"):Create(u35, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Value"] = CFrame.new(Random.new():NextNumber(-u32, u32) / 2, Random.new():NextNumber(-u32, u32) / 2, Random.new():NextNumber(-u32, u32) / 2)
            }, true):Play()
            _G.destroy(u35, 6)
            local u36 = CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
            local u37 = CFrame.Angles(Random.new():NextNumber(-0.03490658503988659, 0.03490658503988659), Random.new():NextNumber(-0.03490658503988659, 0.03490658503988659), Random.new():NextNumber(-0.03490658503988659, 0.03490658503988659))
            local u38 = tick()
            u21 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 446 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u21
                    [3] = u33
                    [4] = u35
                    [5] = u36
                    [6] = u22
                    [7] = u37
                    [8] = u20
                    [9] = u19
                    [10] = u38
                    [11] = u32
                --]]
                if u18 == nil or u18 and u18:IsDescendantOf(workspace) == false then
                    u21:Disconnect()
                    u21 = nil
                else
                    if u18 and u18.PrimaryPart then
                        u18.PrimaryPart.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, u33.Value, -3) * u35.Value * u36
                        if u18.Glass.Transparency < 0.9 then
                            u22 = u22 + 0.03
                        end
                    end
                    u36 = u36 * u37
                    u20:AdjustSpeed(u22)
                    for _, v39 in pairs(u19) do
                        v39.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 1.5707963267948966, 0)
                    end
                    if tick() - u38 > 0.4 and u18["Heart3.001"].Transparency == 0 then
                        if u32 > 0.1 then
                            u32 = u32 * -0.3
                        else
                            u32 = u32 * -1
                        end
                        local v40 = {
                            ["Value"] = u32
                        }
                        game:GetService("TweenService"):Create(u33, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), v40, true):Play()
                        game:GetService("TweenService"):Create(u35, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            ["Value"] = CFrame.new(Random.new():NextNumber(-u32, u32) / 2, Random.new():NextNumber(-u32, u32) / 2, Random.new():NextNumber(-u32, u32) / 2)
                        }, true):Play()
                        u38 = tick()
                    end
                end
            end)
        end
    else
        return
    end
end
return v1