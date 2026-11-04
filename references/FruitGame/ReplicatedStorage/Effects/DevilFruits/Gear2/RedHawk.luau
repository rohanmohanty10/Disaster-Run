 

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
local u8 = require(script.Parent.ConeVFX)
return {
    ["start"] = function(_, u9, p10) --[[ Name: start, Line 19 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if _G.checkRenderDistance(u9.PrimaryPart.Position) then
            local u11 = Random.new()
            local u12 = u9.Humanoid.RootPart
            local u13 = Color3.fromRGB(255, 85, 0)
            local u14 = {
                ["White"] = {
                    ["Lifetime"] = 0.35,
                    ["SizeMultiplier"] = Vector3.new(2, 0.5, 2),
                    ["CFrameOffset"] = CFrame.new(0, 5, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                },
                ["Back"] = {
                    ["Lifetime"] = 0.55,
                    ["SizeMultiplier"] = Vector3.new(2.5, 1, 2.5),
                    ["CFrameOffset"] = CFrame.new(0, -5, 0) * CFrame.Angles(0, 2.1666156231653746, 0)
                },
                ["Shock"] = {
                    ["Lifetime"] = 0.45,
                    ["SizeMultiplier"] = Vector3.new(2.4, 2, 2.4),
                    ["CFrameOffset"] = CFrame.new(0, 5, 0) * CFrame.Angles(0, 2.0943951023931953, 0)
                },
                ["Middle"] = {
                    ["Lifetime"] = 0.65,
                    ["SizeMultiplier"] = Vector3.new(2.5, 0.8, 2.5),
                    ["CFrameOffset"] = CFrame.new(0, 9, 0) * CFrame.Angles(0, -1.5707963267948966, 0)
                },
                ["Front"] = {
                    ["Lifetime"] = 0.55,
                    ["SizeMultiplier"] = Vector3.new(3, 0.8, 3),
                    ["CFrameOffset"] = CFrame.new(0, -16, 0) * CFrame.Angles(0, -2.0943951023931953, 0)
                },
                ["Shock4"] = {
                    ["EaseDir"] = Enum.EasingDirection.Out,
                    ["Lifetime"] = 0.45,
                    ["SizeMultiplier"] = Vector3.new(2, 0.6, 2),
                    ["CFrameOffset"] = CFrame.new(0, 6, 0) * CFrame.Angles(0, 2.5132741228718345, 0)
                }
            }
            local v15 = (u12.CFrame * CFrame.new(1, 0.7, -1)).Position
            local u16 = (u12.CFrame * CFrame.new(0, 0, -40)).Position
            local v17 = CFrame.new(u12.Position, u16)
            local u18 = Apply:Rig(u9, "RightUpperArm", "GumRight")
            local u19 = u18.GumRightOutline
            local u20 = u18.Extend
            local u21 = script.Haki:Clone()
            local u22 = script.Startup:Clone()
            local u23 = script.Firefist:Clone()
            u21.CFrame = v17 * CFrame.new(0, 0, 9)
            u23.CFrame = v17
            u22.CFrame = u23.CFrame
            _G.PlaySound(u9.PrimaryPart, script["Audio/GumRedHawkStart"])
            u9.RightLowerArm.Transparency = 1
            u9.RightHand.Transparency = 1
            task.wait(0.19)
            u21.Parent = workspace.Effects
            u23.Parent = workspace.Effects
            u22.Parent = workspace.Effects
            _G.customWeld(u21, u9.PrimaryPart, CFrame.new(), u21, function() --[[ Line: 100 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u12
                --]]
                u16 = (u12.CFrame * CFrame.new(0, 0, -40)).Position
                return CFrame.new(u12.Position, u16) * CFrame.new(0, 0, 9)
            end)
            local v24 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 106 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u12
                    [3] = u22
                --]]
                u23.CFrame = u12.CFrame
                u22.CFrame = u12.CFrame * CFrame.Angles(0, 0, 0) * CFrame.new(0, 0, 25) * CFrame.new(0, 0, -5)
            end)
            u18.Transparency = 0
            task.spawn(function() --[[ Line: 114 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u13
                    [3] = u19
                    [4] = u18
                --]]
                for _, v25 in u21:GetChildren() do
                    if v25:IsA("ParticleEmitter") and v25:GetAttribute("Customizable") == true then
                        v25.Color = ColorSequence.new(u13)
                    end
                end
                task.wait(0.015)
                u19.Color = u13
                u18.Color = u13
                u18.Material = Enum.Material.Neon
                task.delay(0.05, function() --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u18
                    --]]
                    u19.Transparency = 0
                    u18.Material = Enum.Material.SmoothPlastic
                    TweenCreate(u18, TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        ["Color"] = Color3.fromRGB(0, 0, 0)
                    })
                end)
                Emit(u21, false, 0.05)
                _G.destroy(u21, 1.1)
            end)
            local u26 = script["Audio/GumRedHawkFlamesLoop"]:Clone()
            u26.Parent = u9.PrimaryPart
            u26:Play()
            local v27 = TweenInfo.new(0.27999999999999997, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            TweenCreate(u22, v27, {
                ["Size"] = Vector3.new(1, 1, 20)
            })
            TweenCreate(u20, TweenInfo.new(v27.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["CFrame"] = u20.CFrame * CFrame.new(0, 25, 0)
            })
            task.delay(v27.Time / 1.5, function() --[[ Line: 176 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                Emit(u22, false)
            end)
            tick()
            task.wait(0.4)
            repeat
                task.wait()
            until p10 == nil or p10 and p10:IsDescendantOf(game) == false
            _G.PlaySound(u9.PrimaryPart, script["Audio/GumRedHawkShoot"])
            local v28 = (u12.CFrame * CFrame.new(0, 0, -40)).Position
            local u29 = CFrame.new(u12.Position, v28)
            TweenCreate(u20, TweenInfo.new(0.096, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                ["CFrame"] = u20:GetAttribute("OriginalCFrame")
            })
            local v30 = (v28 - v15).Magnitude
            local v31 = math.clamp(v30, 5, 35)
            local v32 = workspace:Raycast(v15, u29.LookVector * v31, _G.Ess.RaycastParams)
            if v32 then
                v31 = v32.Distance
            end
            local v33 = v31 / 240 / 1.25
            local u34 = u29 * CFrame.new(0, 0, -v31)
            TweenInfo.new(v33 / 1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
            task.wait(0.19)
            v24:Disconnect()
            task.delay(v33 / 2, function() --[[ Line: 244 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u29
                    [3] = u34
                    [4] = u14
                --]]
                task.spawn(function() --[[ Line: 248 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u29
                        [3] = u34
                    --]]
                    local v35 = { 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }
                    u8:start(u29, u34 * CFrame.new(0, 0, 12), 4, -90, 1.6, { 1.9575, 2.3625000000000003, Vector3.new(1.35, 0.675, 1.35) }, v35, { 0.35, 0.6 })
                end)
                local v36 = script.WindMeshes:Clone()
                v36:PivotTo(u29 * CFrame.new(0, 0, -14) * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0))
                v36.Parent = workspace.Effects
                _G.destroy(v36, 1)
                for _, v37 in pairs(v36:GetChildren()) do
                    local v38 = u14[v37.Name]
                    if v38 then
                        local v39 = Enum.EasingDirection.Out
                        if v38.EaseDir then
                            v39 = v38.EaseDir
                        end
                        local _ = v37.Mesh.Scale
                        local v40 = v37.Mesh
                        v40.Scale = v40.Scale / 3
                        TweenCreate(v37, TweenInfo.new(v38.Lifetime, Enum.EasingStyle.Quad, v39), {
                            ["CFrame"] = v37.CFrame * v38.CFrameOffset
                        })
                        TweenCreate(v37.Mesh, TweenInfo.new(v38.Lifetime, Enum.EasingStyle.Quad, v39), {
                            ["Scale"] = v37.Mesh.Scale * v38.SizeMultiplier
                        })
                        TweenCreate(v37.Decal, TweenInfo.new(v38.Lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            ["Transparency"] = 1
                        })
                    end
                end
            end)
            local v41 = TweenInfo.new(v33, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
            local v42 = TweenCreate
            local v43 = {}
            local v44 = v31 / 1.25
            v43.Size = Vector3.new(1, 1, v44)
            v43.CFrame = u29:Lerp(u34, 0.75)
            v42(u22, v41, v43)
            TweenCreate(u20, TweenInfo.new(v41.Time, v41.EasingStyle, v41.EasingDirection), {
                ["CFrame"] = u20:GetAttribute("OriginalCFrame") * CFrame.new(0, v31 / 1.25, 0)
            })
            task.delay(v41.Time, function() --[[ Line: 314 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u23
                    [3] = u26
                    [4] = u9
                    [5] = u20
                    [6] = u18
                    [7] = u29
                    [8] = u11
                    [9] = u34
                --]]
                _G.destroy(u22, 1)
                _G.destroy(u23, 3)
                _G.customEmit(u23)
                u26:Destroy()
                _G.PlaySound(u9.PrimaryPart, script["Audio/GumRedHawkHit"])
                TweenCreate(u20, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
                    ["CFrame"] = u20:GetAttribute("OriginalCFrame")
                })
                _G.destroy(u18, 0.4)
                u9.RightLowerArm.Transparency = 0
                u9.RightHand.Transparency = 0
                local v45 = u29.Position
                for _ = 1, 25 do
                    local v46 = math.random(100, 400) / 1000
                    local v47 = script.ExtraMeshes.Sphere:Clone()
                    v47.CFrame = CFrame.new(v45, v45 + u11:NextUnitVector() * 5 + u34.LookVector * 6)
                    local v48 = math.random(300, 600) / 100
                    local v49 = math.random(25, 75)
                    v47.Size = Vector3.new(v48, v48, v49)
                    v47.Parent = workspace.Effects
                    TweenCreate(v47, TweenInfo.new(v46, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["CFrame"] = v47.CFrame * CFrame.new(0, 0, -v49),
                        ["Size"] = v47.Size * Vector3.new(0, 0, 0)
                    })
                    _G.destroy(v47, v46)
                end
                local v50 = u23.PointLight
                TweenCreate(v50, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Brightness"] = 0,
                    ["Range"] = 60
                })
                task.wait(0.2)
                Emit(u22, false)
            end)
        end
    end
}