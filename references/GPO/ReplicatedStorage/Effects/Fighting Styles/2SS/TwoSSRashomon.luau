 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
local u3 = require(game:GetService("ReplicatedStorage").Modules.sBeat)
local u4 = Random.new()
game:GetService("TweenService")
TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
function v1.start(_, p5, p6, u7, u8) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    if _G.checkRenderDistance(p5.Position) == false then
        return
    else
        _G.PlaySound(u8.HumanoidRootPart, script.Dash)
        _G.PlaySound(u8.HumanoidRootPart, script.Shing)
        local u9 = u8:FindFirstChild("BusoMelee") and "Buso" or ""
        local u10 = script["rashomon" .. u9]:Clone()
        u10:PivotTo(p6)
        u10.Parent = workspace.Effects
        require(script.Parent.BusoColor):applyColors(u8, u10)
        local v11 = u7 * 1.44
        local v12 = Vector3.new(v11, 6.5, 3.5)
        local v13 = -u7 * 0.5
        _G.tween(u10.ShockwaveA, {
            0.3,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = v12,
            ["CFrame"] = u10.ShockwaveA.CFrame * CFrame.new(v13, 1, -2),
            ["Transparency"] = 1
        })
        _G.tween(u10.ShockwaveB, {
            0.3,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = v12,
            ["CFrame"] = u10.ShockwaveB.CFrame * CFrame.new(v13, 1, 2),
            ["Transparency"] = 1
        })
        local v14 = _G.tween
        local v15 = u10.ShockRiseA
        local v16 = {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v17 = {}
        local v18 = u7 * 1.75
        v17.Size = Vector3.new(v18, 6, 0.05)
        v17.CFrame = u10.ShockRiseA.CFrame * CFrame.new(11, -4, 0)
        v17.Transparency = 1
        v14(v15, v16, v17)
        local v19 = _G.tween
        local v20 = u10.ShockRiseB
        local v21 = {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v22 = {}
        local v23 = u7 * 1.75
        v22.Size = Vector3.new(v23, 6, 0.05)
        v22.CFrame = u10.ShockRiseB.CFrame * CFrame.new(11, -4, 0)
        v22.Transparency = 1
        v19(v20, v21, v22)
        _G.tween(u10.TravelSwirl, {
            1.5,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u10.TravelSwirl.CFrame * CFrame.new(-2, 0, 0) * CFrame.Angles(-3.1, 0, 0),
            ["Size"] = Vector3.new(40, 8, 8),
            ["Transparency"] = 1
        })
        for v24 = 1, 2 do
            local v25 = v24 == 2 and -1 or 1
            local u26 = script.Part:Clone()
            u26.Parent = workspace.Effects
            local v27 = CFrame.new(p5.Position, p6.Position)
            local v28 = CFrame.Angles
            local v29 = v25 * 5
            u26.CFrame = v27 * v28(0, math.rad(v29), 0)
            if u9 == "Buso" then
                u26.new3.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
                u26.new3.LightEmission = 0
            end
            _G.PlayEffect("RockFollow", nil, u26, 0.5, 1.5, true, 0.2)
            _G.tween(u26, {
                0.2,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u26.CFrame * CFrame.new(0, 0, -u7)
            })
            _G.PlayEffect("FloorTrail", nil, u26, 0.25, Color3.fromRGB(213, 104, 14), Color3.fromRGB(0, 0, 0), 1)
            spawn(function() --[[ Line: 53 ]]
                --[[
                Upvalues:
                    [1] = u26
                --]]
                task.wait(0.2)
                u26.new3.Enabled = false
            end)
            _G.destroy(u26, 0.4)
        end
        local v30 = script.TravelLine
        for v31 = 0, 10 do
            local v32 = v30:Clone()
            local v33 = u4:NextNumber(-v31, v31)
            v32.CFrame = p5 * CFrame.new(u4:NextNumber(-v31, v31), v33, v33)
            v32.Transparency = -99
            v32.Color = Color3.new(0.384314, 0.184314, 0.721569):Lerp(Color3.new(1, 1, 1), v31 * 0.13)
            v32.Parent = u10
            _G.tween(v32, {
                0.4 - v31 * 0.03,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0.2, 0.2, 5),
                ["CFrame"] = v32.CFrame * CFrame.new(0, 0, -u7),
                ["Transparency"] = 1
            })
        end
        local u34 = u7 * 0.5
        local v35 = Vector3.new(0, -2.5, u34)
        local v36 = u10.root.Attachment
        v36.Position = v35
        local u37 = v36.WorldCFrame * CFrame.new(0, 3, 0)
        local v38 = Ray.new(u37.Position, u37.upVector * -25)
        local v39, _, _ = _G.raycastWhitelist(v38, { workspace.Islands, workspace.Env, workspace.Ships })
        if v39 then
            v36.sm2.Color = ColorSequence.new(v39.Color)
            v36.sm2.Speed = NumberRange.new(u7 * 2.75, 3 * u7)
            v36.sm2.Size = NumberSequence.new(u7 / 12, u7 / 8)
            _G.customEmit(v36.sm2)
        end
        _G.destroy(u10, 5)
        if u7 < 10 then
            u10.Parent = workspace.Effects
        else
            local v40 = script.Swirl:Clone()
            v40.CFrame = u37
            v40.Size = Vector3.new(u34, 1, u34)
            v40.Parent = u10
            _G.tween(v40, {
                1.25,
                "FabricDecelerate",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v40.CFrame * CFrame.Angles(0, -3.12, 0),
                ["Size"] = Vector3.new(u7, 5, u7),
                ["Transparency"] = 1
            })
            task.delay(0.6, function() --[[ Line: 93 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u37
                    [3] = u7
                    [4] = u10
                    [5] = u8
                    [6] = u34
                    [7] = u3
                    [8] = u2
                --]]
                local u41 = script["rashomonslash" .. u9]:Clone()
                u41:PivotTo(u37)
                local v42 = u7
                local v43 = u7
                u41.Ring.Size = Vector3.new(v42, 30, v43)
                u41.Parent = u10
                require(script.Parent.BusoColor):applyColors(u8, u41)
                local v44 = _G.tween
                local v45 = u41.Ring
                local v46 = {
                    1,
                    "FabricDecelerate",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v47 = {}
                local v48 = u34
                local v49 = u34
                v47.Size = Vector3.new(v48, 0.1, v49)
                v47.CFrame = u41.Ring.CFrame * CFrame.new(0, 20, 0)
                v47.Transparency = 1
                v44(v45, v46, v47)
                local v50 = _G.tween
                local v51 = u41.Swirl
                local v52 = {
                    0.2,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v53 = {}
                local v54 = u7
                local v55 = u7
                v53.Size = Vector3.new(v54, 5, v55)
                v53.CFrame = u41.Swirl.CFrame * CFrame.new(0, -5, 0)
                v53.Transparency = 1
                v50(v51, v52, v53)
                local v56 = u7
                local v57 = u7
                u41.SwirlA.Size = Vector3.new(v56, v57, 3) * 0.6
                local v58 = u7
                local v59 = u7
                u41.SwirlB.Size = Vector3.new(v58, v59, 3) * 0.7
                _G.tween(u41.SwirlA, {
                    1.3,
                    "Quad",
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(u41.SwirlB, {
                    1.5,
                    "Quad",
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                spawn(function() --[[ Line: 106 ]]
                    --[[
                    Upvalues:
                        [1] = u41
                        [2] = u3
                    --]]
                    for v60 = 0.25, 0, -0.0035 do
                        u41.SwirlA.Size = u41.SwirlA.Size + Vector3.new(4, 4, 0.2) * v60
                        u41.SwirlB.Size = u41.SwirlA.Size * 1.2
                        u41.SwirlA.CFrame = u41.SwirlA.CFrame * CFrame.Angles(0, 0, v60)
                        u41.SwirlB.CFrame = u41.SwirlB.CFrame * CFrame.Angles(0, 0, -v60 * 0.25)
                        u3()
                    end
                end)
                local v61 = u7 * 0.245
                local v62 = u7 * 0.245
                local v63 = Vector3.new(v61, 64, v62)
                u41.SwooshA.Mesh.Scale = v63 * 0.5
                u41.SwooshB.Mesh.Scale = u10.SwooshA.Mesh.Scale
                local v64 = u41.LineA.Mesh
                local v65 = u7 + v63.X
                local v66 = v63.X
                v64.Scale = Vector3.new(v65, 0, v66)
                u41.LineB.Mesh.Scale = u41.LineA.Mesh.Scale
                u2.Do("slice_slow", u41.SwooshA)
                u2.Do("slice_slow", u41.SwooshB)
                u2.Do("slice_veryslow", u41.LineA)
                u2.Do("slice_veryslow", u41.LineB)
                local v67 = {
                    0.4,
                    "FabricDecelerate",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                _G.tween(u41.SwooshA.Mesh, v67, {
                    ["Scale"] = v63
                })
                _G.tween(u41.SwooshB.Mesh, v67, {
                    ["Scale"] = v63
                })
                _G.tween(u41.SwooshA, v67, {
                    ["CFrame"] = u41.SwooshA.CFrame * CFrame.Angles(0, -1.8, 0)
                })
                _G.tween(u41.SwooshB, v67, {
                    ["CFrame"] = u41.SwooshB.CFrame * CFrame.Angles(0, -1.8, 0)
                })
                u41.root.Attachment.Sparkles.Size = NumberSequence.new(u7 + u34, 0)
                u41.root.Attachment.Sparkles2.Size = u41.root.Attachment.Sparkles.Size
                u41.root.Attachment.Wave.Size = NumberSequence.new(u34 / 2, u34)
                u41.root.Attachment.Sparkles:Emit(5)
                u41.root.Attachment.Sparkles2:Emit(5)
                u41.root.Attachment.Wave2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, u34 / 3, u34 / 8), NumberSequenceKeypoint.new(1, u34 * 0.75, u34 / 8) })
                task.wait(0.25)
                _G.PlaySound(u41.root, script.Flurry)
                local v68 = Color3.fromRGB(161, 79, 255)
                if u9 ~= "" then
                    Color3.fromRGB(85, 0, 255)
                    v68 = require(script.Parent.BusoColor):getColor(u8)
                end
                _G.PlayEffect("Spheres", nil, {
                    ["cf"] = u37,
                    ["ti"] = 0.1,
                    ["ti2"] = 0.2,
                    ["range"] = u7 / 2,
                    ["minThick"] = u7 / 6,
                    ["maxThick"] = u7 / 3,
                    ["part"] = nil,
                    ["color"] = v68,
                    ["am"] = u7 / 2
                })
                u41.root.Attachment.Wave2:Emit(15)
                u41.root.Attachment.Wave:Emit(10)
                local v69 = script.Part2:Clone()
                v69.Parent = workspace.Effects
                v69.CFrame = u37
                v69.Color = Color3.fromRGB(0, 0, 0)
                local v70 = u7
                local v71 = u7
                local v72 = u7
                v69.Mesh.Scale = Vector3.new(v70, v71, v72) * 0.5
                local v73 = _G.tween
                local v74 = v69.Mesh
                local v75 = {
                    0.25,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v76 = {}
                local v77 = u7
                local v78 = u7
                local v79 = u7
                v76.Scale = Vector3.new(v77, v78, v79) * 1.5
                v73(v74, v75, v76)
                _G.tween(v69, {
                    0.25,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v69, 0.25)
            end)
        end
    end
end
return v1