 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
local v2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
local _ = v2.LocalPlayer
local u4 = workspace.Effects
function Flipbook(p5, u6, u7, u8)
    local u9 = p5:FindFirstChildOfClass("SpecialMesh")
    if u9 and u6 then
        task.spawn(function() --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u9
                [3] = u7
                [4] = u8
            --]]
            for v10 = 1, #u6 do
                u9.TextureId = u6[v10]
                task.wait(1 / u7)
            end
            if u8 == true then
                u9.Parent:Destroy()
            end
        end)
    end
end
local v11 = RaycastParams.new()
v11.FilterType = Enum.RaycastFilterType.Include
v11.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
local v12 = {}
local u13 = CFrame.new(0.0000152587890625, -3.000000238418579, 22.974090576171875) * CFrame.fromEulerAnglesYXZ(1.6292068494294654e-7, 3.1415927410125732, -2.220446843343701e-16)
local u14 = {}
function v12.start(_, p15, u16, u17, p18, p19) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u14
        [3] = u4
        [4] = u3
        [5] = u1
    --]]
    if p15 == "Spawn" then
        local v20 = script.IronBall:Clone()
        v20.PrimaryPart.CFrame = u16.PrimaryPart.CFrame
        local v21 = Instance.new("Weld")
        v21.Part0 = v20.PrimaryPart
        v21.Part1 = u16.PrimaryPart
        v21.C1 = u13
        v21.Name = "BallWeld"
        v21.Parent = v20.PrimaryPart
        if u17 ~= nil then
            v20.PrimaryPart.Glow.Color = u17
            v20.PrimaryPart.PointLight.Color = u17
            v20.PrimaryPart.PointLight.Enabled = true
        end
        v20.Parent = workspace.Effects
        _G.destroy(v20, 10)
        if u17 ~= nil then
            _G.tween(v20.PrimaryPart.PointLight, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 60,
                ["Brightness"] = 0
            })
            _G.tween(v20.PrimaryPart.Glow, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 0
            })
            _G.recolorParticles(v20, u17)
            _G.customEmit(v20)
        end
        if u17 ~= nil then
            _G.PlaySound(v20.PrimaryPart, script.HakiCoat).Parent = v20.PrimaryPart
        end
        v20:WaitForChild("AnimationController", 1)
        local v22 = v20.AnimationController:LoadAnimation(script.ironHold)
        v22:Play(0)
        u14[u16] = v20
        repeat
            task.wait()
        until u16:GetAttribute("OversizedIronBallHold") == nil
        v22:Stop(0)
        local v23 = v20.AnimationController:LoadAnimation(script.ironSmash)
        v23:Play(0)
        task.wait(0.633)
        v21:Destroy()
        v20.PrimaryPart.Glow:Destroy()
        v20.PrimaryPart.Anchored = true
        v23:AdjustSpeed(0)
        v23.TimePosition = 0.633
    else
        string.format("%s Meteor_Fist_Effects", u16.Name)
        if p15 == "Explosion" then
            local u24 = u14[u16]
            if u24 and u24.PrimaryPart == nil then
                u14[u16] = nil
                return
            end
            if u24 == nil then
                return
            end
            u16:FindFirstChild("HumanoidRootPart")
            u16:FindFirstChild("RightHand")
            u16:FindFirstChild("LeftHand")
            local u25 = CFrame.new(p18.Position) * CFrame.new(0, 15, 0)
            local u26, u27, v28 = _G.getRayFloor(u25, 30)
            local u29 = CFrame.new(u27, u27 + v28) * CFrame.Angles(-1.5707963267948966, 0.0017453292519943296, 0)
            local v30 = p19 - workspace:GetServerTimeNow()
            task.delay(v30 - 0.05, function() --[[ Line: 159 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u29
                    [3] = u25
                    [4] = u4
                --]]
                local v31 = script.Impact:Clone()
                if u26 then
                    v31.CFrame = u29
                else
                    v31.CFrame = u25
                end
                v31.Parent = u4
                _G.customEmit(v31)
                _G.destroy(v31, 5)
            end)
            task.delay(v30, function() --[[ Line: 171 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u29
                    [3] = u25
                    [4] = u4
                    [5] = u17
                    [6] = u3
                    [7] = u1
                    [8] = u24
                    [9] = u27
                    [10] = u14
                    [11] = u16
                --]]
                local v32 = script.CannonBallExplosion:Clone()
                if u26 then
                    v32.CFrame = u29
                else
                    v32.CFrame = u25
                end
                v32.Parent = u4
                _G.customEmit(v32)
                _G.destroy(v32, 5)
                if u17 then
                    local v33 = script.HakiExplode:Clone()
                    v33.CFrame = u29
                    _G.recolorParticles(v33, u17)
                    v33.Parent = u4
                    u3:Create(v33.PointLight, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                        ["Range"] = 60,
                        ["Brightness"] = 0
                    }):Play()
                    _G.customEmit(v33)
                    _G.destroy(v33, 5)
                end
                local u34 = script.Shockwave:Clone()
                u34:PivotTo(u29 * CFrame.new(0, 15, 0) * CFrame.Angles(3.141592653589793, 0, 0))
                u34.Parent = u4
                _G.destroy(u34, 1)
                u3:Create(u34.MiddleWind.Start.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                    ["Scale"] = u34.MiddleWind.End.Mesh.Scale
                }):Play()
                u3:Create(u34.MiddleWind.Start, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = u34.MiddleWind.Start.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play()
                u3:Create(u34.OuterWindRing.Start, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    ["Size"] = u34.OuterWindRing.End.Size
                }):Play()
                u3:Create(u34.OuterWindRing.Start, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = u34.OuterWindRing.Start.CFrame * CFrame.Angles(0, -3.141592653589793, 0)
                }):Play()
                u3:Create(u34.OuterWindRing2.Start, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                    ["Size"] = u34.OuterWindRing2.End.Size
                }):Play()
                task.spawn(function() --[[ Line: 211 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                        [2] = u1
                    --]]
                    while u34.Parent ~= nil and u34.OuterWindRing2.Parent ~= nil do
                        local v35 = u34.OuterWindRing2.Start
                        v35.CFrame = v35.CFrame * CFrame.Angles(0, 0.03490658503988659, 0)
                        u1.Heartbeat:Wait()
                    end
                end)
                task.delay(0.2, function() --[[ Line: 218 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                        [2] = u3
                    --]]
                    for _, v36 in u34.MiddleWind.Start:GetChildren() do
                        if v36:IsA("Decal") then
                            u3:Create(v36, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                                ["Transparency"] = 1
                            }):Play()
                        end
                    end
                    for _, v37 in u34.OuterWindRing.Start:GetChildren() do
                        if v37:IsA("Decal") then
                            u3:Create(v37, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
                                ["Transparency"] = 1
                            }):Play()
                        end
                    end
                    task.wait(0.1)
                    for _, v38 in u34.OuterWindRing2.Start:GetChildren() do
                        if v38:IsA("Decal") then
                            u3:Create(v38, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                                ["Transparency"] = 1
                            }):Play()
                        end
                    end
                end)
                if u26 then
                    local v39 = script.Debree:Clone()
                    v39.CFrame = u29
                    _G.recolorParticles(v39, u26.Color)
                    v39.Parent = u4
                    _G.customEmit(v39)
                    _G.destroy(v39, 4)
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 25,
                        ["Position"] = v39.Position + Vector3.new(0, 5, 0),
                        ["DistanceRandomness"] = Vector2.new(0.4, 1),
                        ["Duration"] = 3,
                        ["TweenDuration"] = 1,
                        ["Radius"] = 20,
                        ["Direction"] = Vector3.new(0, -60, 0)
                    })
                    _G.PlayEffect("RockDebris", nil, {
                        ["PartCount"] = 8,
                        ["RandomVelocityMagnitude"] = Vector2.new(-75, 75) / 2,
                        ["Position"] = v39.Position + Vector3.new(0, 5, 0),
                        ["Direction"] = Vector3.new(0, 125, 0),
                        ["RaycastDirection"] = Vector3.new(0, -30, 0),
                        ["Size"] = Vector3.new(1.4, 1.6, 1.4),
                        ["TrailEnabled"] = true
                    })
                    _G.shakenear(v39.CFrame.Position, 125, 75, 150, -1)
                    if u17 then
                        _G.PlaySound(v39, script.WreckingBallBoomH, {
                            ["RandomPitch"] = true
                        })
                    else
                        _G.PlaySound(v39, script.WreckingBallBoom, {
                            ["RandomPitch"] = true
                        })
                    end
                end
                if u24 and u24.PrimaryPart then
                    local u40 = u24.PrimaryPart.CFrame
                    if u26 then
                        u24.PrimaryPart.BallWeld.Destroying:Connect(function() --[[ Line: 279 ]]
                            --[[
                            Upvalues:
                                [1] = u24
                                [2] = u40
                                [3] = u27
                            --]]
                            task.defer(function() --[[ Line: 280 ]]
                                --[[
                                Upvalues:
                                    [1] = u24
                                    [2] = u40
                                    [3] = u27
                                --]]
                                u24:SetPrimaryPartCFrame(u40 * CFrame.new(0, -(u24.PrimaryPart.Position.Y - u27.Y), 0))
                            end)
                        end)
                    end
                    task.delay(2, function() --[[ Line: 287 ]]
                        --[[
                        Upvalues:
                            [1] = u24
                        --]]
                        _G.tween(u24.PrimaryPart, {
                            2,
                            "EntranceExpressive",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["CFrame"] = u24.PrimaryPart.CFrame * CFrame.new(0, -15, 0)
                        })
                        _G.destroy(u24, 2)
                    end)
                end
                u14[u16] = nil
            end)
        end
    end
end
return v12