 

function PlayFlipbook(p1, p2, p3, p4, p5)
    for v6 = p4, p5 do
        local v7
        if p2:FindFirstChild((tostring(v6))) then
            v7 = v6
        else
            v7 = v6 + 1
        end
        p1.Texture = p2[tostring(v7)].Texture
        task.wait(p3)
    end
end
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
Apply = require(script.Parent.ApplyRig)
local u8 = game:GetService("TweenService")
local u9 = game:GetService("RunService")
require(script.Crater)
return {
    ["start"] = function(_, u10, p11, u12) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
        --]]
        if _G.checkRenderDistance(u10.PrimaryPart.Position) then
            local u13 = Random.new()
            local u14 = u10.Humanoid
            local u15 = u14.RootPart
            local u16 = {
                ["Big"] = {
                    ["Lifetime"] = 0.25,
                    ["SizeMultiplier"] = Vector3.new(1.5, 0.5, 1.5),
                    ["CFrameOffset"] = CFrame.new(0, 12, 0) * CFrame.Angles(0, -2.5132741228718345, 0)
                },
                ["Out"] = {
                    ["Lifetime"] = 0.35,
                    ["SizeMultiplier"] = Vector3.new(2.5, 2, 2.5),
                    ["CFrameOffset"] = CFrame.new(0, 16, 0) * CFrame.Angles(0, -1.8479956785822313, 0)
                },
                ["In"] = {
                    ["Lifetime"] = 0.4,
                    ["SizeMultiplier"] = Vector3.new(4, 2, 4),
                    ["CFrameOffset"] = CFrame.new(0, 16, 0) * CFrame.Angles(0, -1.8479956785822313, 0)
                },
                ["Wind1"] = {
                    ["Lifetime"] = 0.25,
                    ["SizeMultiplier"] = Vector3.new(1.5, 1, 1.5),
                    ["CFrameOffset"] = CFrame.new(0, -4, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
                },
                ["Wind2"] = {
                    ["Lifetime"] = 0.45,
                    ["SizeMultiplier"] = Vector3.new(1.5, 1.5, 1.5),
                    ["CFrameOffset"] = CFrame.new(0, -8, 0) * CFrame.Angles(0, 2.0943951023931953, 0)
                }
            }
            local u17 = u14.Animator:LoadAnimation(script.Parent.Anims.RocketLaunch)
            local u18 = u14.Animator:LoadAnimation(script.Parent.Anims.RocketEnd)
            u18.Priority = Enum.AnimationPriority.Action4
            u17.Priority = Enum.AnimationPriority.Action4
            local u19 = tick()
            local u20 = tick()
            tick()
            local v21 = u15.Position
            local v22 = (p11 - v21).Magnitude
            local v23 = math.clamp(v22, 1, 225) + 10
            local v24 = CFrame.new(v21, p11)
            local v25 = v24 * CFrame.new(0, 0, -v23)
            local v26 = Ray.new(v25.Position, CFrame.new(v25.Position).UpVector * 5)
            local v27 = {
                workspace.Env,
                workspace.Islands,
                workspace.NPCs,
                workspace.Ships
            }
            local v28 = game.Players:GetPlayers()
            local u29 = nil
            for v30 = 1, #v28 do
                if v28[v30].Character ~= u10 and v28[v30].Character ~= nil then
                    local v31 = v28[v30].Character
                    table.insert(v27, v31)
                end
            end
            local v32 = _G.getTargets(u10)
            for v33 = 1, #v32 do
                local v34 = v32[v33].Parent
                table.insert(v27, v34)
            end
            local _, u35, _ = _G.raycastWhitelist(v26, v27)
            local v36 = RaycastParams.new()
            v36.FilterType = Enum.RaycastFilterType.Whitelist
            v36.FilterDescendantsInstances = v27
            v36.IgnoreWater = true
            local u37 = workspace:Raycast(v21, v24.LookVector * (v23 + 5), v36)
            if u37 then
                local v38 = u37.Position
                local u39 = CFrame.new(v21, v38)
                u17:Play(0, 2, 1)
                u17:GetMarkerReachedSignal("Static"):Once(function() --[[ Line: 107 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                    --]]
                    u17:AdjustSpeed(0)
                end)
                local v40 = u37.Distance - 2
                local u41 = math.clamp(v40, 0, 225)
                local u42 = u39 * CFrame.new(0, 0, -u41)
                u15.CFrame = u39
                u14.PlatformStand = true
                u14.AutoRotate = false
                local u43 = u41 / 350
                local u44 = script.MissileLatch:Clone()
                local v45 = script.InitialWind:Clone()
                u44.CFrame = u42 * CFrame.new(0, 0, -4)
                v45:PivotTo(u39 * CFrame.new(0, 0, -12))
                u44.Parent = workspace.Effects
                v45.Parent = workspace.Effects
                _G.PlaySound(u42, script["Audio/JetRocketGrab"])
                local v46 = {
                    { "RightUpperArm", "GumRight" },
                    { "LeftUpperArm", "GumLeft" }
                }
                v46[1] = Apply:Rig(u10, v46[1][1], v46[1][2])
                v46[2] = Apply:Rig(u10, v46[2][1], v46[2][2])
                local u47 = { 0.25, 0.6, 0.9 }
                for v48, u49 in v46 do
                    u49.Transparency = 0
                    u49.Color = u10.Head.Color
                    local v50 = v48 == 2 and 2 or ""
                    local u51 = u49:FindFirstChild("Extend" .. tostring(v50))
                    local u52 = u51.CFrame
                    u17:GetMarkerReachedSignal("Launch"):Once(function() --[[ Line: 155 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                            [2] = u43
                            [3] = u41
                        --]]
                        TweenCreate(u51, TweenInfo.new(u43 / 3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                            ["CFrame"] = u51.CFrame * CFrame.new(0, u41 / 1.35, 0) - Vector3.new(0, 1, 0)
                        })
                    end)
                    task.delay(u43 / 1.8, function() --[[ Line: 162 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                            [2] = u43
                            [3] = u52
                            [4] = u49
                        --]]
                        local v53 = {
                            ["CFrame"] = u52
                        }
                        local _, v54 = TweenCreate(u51, TweenInfo.new(u43 / 1.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false), v53)
                        task.delay(v54.Time, function() --[[ Line: 168 ]]
                            --[[
                            Upvalues:
                                [1] = u49
                            --]]
                            u49.Transparency = 1
                            _G.destroy(u49, 0.1)
                        end)
                    end)
                end
                _G.destroy(v45, 1)
                Emit(v45:GetDescendants(), true)
                for _, v55 in pairs(v45:GetChildren()) do
                    local v56 = u16[v55.Name]
                    if v56 then
                        local v57 = Enum.EasingDirection.Out
                        if v56.EaseDir then
                            v57 = v56.EaseDir
                        end
                        local v58 = v55.Size
                        TweenCreate(v55, TweenInfo.new(v56.Lifetime, Enum.EasingStyle.Quad, v57), {
                            ["CFrame"] = v55.CFrame * v56.CFrameOffset * CFrame.new(0, -0, 0),
                            ["Size"] = v58 * v56.SizeMultiplier,
                            ["Color"] = v56.Color
                        })
                        TweenCreate(v55, TweenInfo.new(v56.Lifetime, Enum.EasingStyle.Quad, v57), {
                            ["Transparency"] = 1
                        })
                    end
                end
                task.spawn(function() --[[ Line: 206 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u39
                        [3] = u42
                        [4] = u13
                        [5] = u16
                        [6] = u15
                    --]]
                    for _, v59 in u47 do
                        local v60 = u39:Lerp(u42, v59) * CFrame.Angles(-1.5707963267948966, u13:NextNumber(0, 3.142), 0)
                        local v61 = script.ExtraMeshes.BeanWind:Clone()
                        v61:PivotTo(v60)
                        v61.Parent = workspace.Effects
                        local v62 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        TweenCreate(v61, v62, {
                            ["CFrame"] = v61.CFrame * CFrame.new(0, -4, 0) * CFrame.Angles(0, u13:NextNumber(0, 1.571), 0)
                        })
                        TweenCreate(v61.Mesh, v62, {
                            ["Scale"] = v61.Mesh.Scale * 2
                        })
                        TweenCreate(v61.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1
                        })
                        Emit(v61.Start, true)
                        _G.destroy(v61, 0.55)
                        local v63 = script.TravelWind:Clone()
                        v63:PivotTo(v60)
                        v63.Parent = workspace.Effects
                        _G.destroy(v63, 0.5)
                        for _, v64 in v63:GetChildren() do
                            local v65 = u16[v64.Name]
                            local v66 = v64.Size
                            v64.Size = v64.Size / 2
                            TweenCreate(v64, TweenInfo.new(v65.Lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["CFrame"] = v64.CFrame * v65.CFrameOffset * CFrame.Angles(0, u13:NextNumber(-1, 1), 0),
                                ["Size"] = v66 * v65.SizeMultiplier,
                                ["Color"] = v65.Color
                            })
                            TweenCreate(v64, TweenInfo.new(v65.Lifetime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            })
                        end
                        task.wait(0.01)
                    end
                    _G.PlaySound(u15, script["Audio/JetRocketShootPull"]).Parent = u15
                    local v67 = script.latch:Clone()
                    v67.CFrame = u42
                    v67.Parent = workspace.Effects
                    _G.customEmit(v67)
                    _G.destroy(v67, 3)
                end)
                local u68 = Vector3.new(0, 0, 0)
                local u69 = 1
                local _ = u9.Stepped:Connect(function() --[[ Line: 277 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u43
                        [3] = u8
                        [4] = u39
                        [5] = u42
                        [6] = u15
                        [7] = u14
                        [8] = u68
                        [9] = u10
                        [10] = u69
                        [11] = u29
                        [12] = u17
                        [13] = u18
                        [14] = u41
                        [15] = u37
                        [16] = u12
                        [17] = u35
                        [18] = u44
                        [19] = u20
                    --]]
                    local v70 = u8:GetValue((tick() - u19) / u43, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
                    local v71 = u39:Lerp(u42, v70)
                    u15.CFrame = v71
                    u15.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    u15.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    u14.AutoRotate = false
                    if v70 >= 0.1 and (u15.Position - u68).Magnitude >= 20 then
                        local v72 = script.launch:Clone()
                        v72.CFrame = u10.PrimaryPart.CFrame
                        _G.scaleParticle(v72, u69 - 0.5, true)
                        v72.Parent = workspace.Effects
                        _G.customEmit(v72)
                        _G.destroy(v72, 3)
                        u68 = u15.Position
                        u69 = u69 + 0.2
                    end
                    if v70 >= 0.99 then
                        u29:Disconnect()
                        u14.PlatformStand = false
                        u17:Stop(0.05)
                        u18:Play()
                        u14.AutoRotate = true
                        local v73 = u15.CFrame.LookVector
                        local v74 = u41 / 1.2
                        local v75 = v73 * math.clamp(v74, 1, 200000)
                        local v76 = 1.001 + v75.Magnitude * 0.01
                        local v77 = math.log(v76, 3)
                        local v78 = v75 / v77
                        local v79 = workspace.Gravity * v77 * 0.5
                        local v80 = v78 + Vector3.new(0, v79, 0)
                        if u37 and u37.Instance ~= nil then
                            local v81 = script.latch2:Clone()
                            v81.CFrame = u15.CFrame
                            v81.Parent = workspace.Effects
                            v81.Attachment.Rocks.Acceleration = u15.CFrame.LookVector * 75
                            v81.Attachment.Rocks.Color = ColorSequence.new(u37.Instance.Color)
                            _G.PlaySound(v81, script["Audio/JetRocketCrashIntoGround"])
                            _G.customEmit(v81)
                            _G.destroy(v81, 3)
                        end
                        if u10 == game.Players.LocalPlayer.Character then
                            u12:FireServer(u15.CFrame)
                        end
                        local v82 = v80 * Vector3.new(1, 0, 1)
                        local v83 = u39.UpVector + Vector3.new(0, 1, 0)
                        local v84 = u41 * 2.5
                        local v85 = u15
                        v85.CFrame = v85.CFrame * CFrame.new(0, (u35 - v71.Position).Magnitude, 0)
                        u15:ApplyImpulse((v82 + v83 * (math.sqrt(v84) * 1.5 + 5)) * 230 / Vector3.new(14, 7, 14))
                        _G.PlaySound(u15, script["Audio/JetRocketLaunchForward"]).Parent = u15
                        _G.destroy(u44, 1.5)
                    end
                    u20 = tick()
                end)
            end
        else
            return
        end
    end
}