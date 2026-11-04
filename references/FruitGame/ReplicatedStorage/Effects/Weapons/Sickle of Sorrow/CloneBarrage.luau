 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local u3 = Random.new()
local u4 = v1.LocalPlayer
local u5 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v6 = {}
local _ = workspace.CurrentCamera
local u7 = RaycastParams.new()
u7.FilterType = Enum.RaycastFilterType.Include
u7.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local v8 = OverlapParams.new()
v8.FilterType = Enum.RaycastFilterType.Include
v8.FilterDescendantsInstances = { workspace }
local u9 = require(game.ReplicatedStorage.Modules.ForgeVFX)
u9.init()
local function u33(p10) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local u11 = p10.Character
    local v12 = p10.Pivot
    local v13 = p10.Animation
    u11.Archivable = true
    local u14 = u11:Clone()
    for _, v15 in u14:QueryDescendants("Script, LocalScript, BaseScript, GuiObject, BillboardGui, Sound, Tool, >[Name = \"Sickle of SorrowSword\"], ForceField") do
        if v15.Name ~= "AnimateAccessory" then
            v15:Destroy()
        end
    end
    for _, v16 in u14:QueryDescendants("BasePart") do
        v16.CanCollide = false
        v16.CastShadow = false
        v16.CanQuery = false
        v16.CollisionGroup = "noclip"
    end
    u14:PivotTo(v12)
    local v17 = u14:WaitForChild("Humanoid")
    local v18 = v17:WaitForChild("Animator")
    v17.EvaluateStateMachine = false
    v17.AutomaticScalingEnabled = false
    local u19 = {}
    local u20 = {}
    for _, v21 in u14:QueryDescendants("BasePart, Decal, Texture, ParticleEmitter") do
        u19[v21] = {
            ["Visible"] = v21.Transparency,
            ["Invisible"] = v21:IsA("ParticleEmitter") and NumberSequence.new(1) or 1
        }
        v21.Transparency = u19[v21].Invisible
    end
    for _, v22 in u14:QueryDescendants("Beam") do
        if v22.Enabled ~= false then
            u20[v22] = true
            v22.Enabled = false
        end
    end
    local v23 = Instance.new("Highlight")
    v23.FillTransparency = 1
    v23.OutlineColor = Color3.fromRGB(255, 65, 151)
    v23.OutlineTransparency = 0.5
    v23.DepthMode = Enum.HighlightDepthMode.Occluded
    v23:SetAttribute("UniqueID", "b95cd64f-8278-406d-b32f-ca860258f1fa")
    v23.Parent = u14
    u5.apply(v23, u11)
    u14.Parent = workspace.Effects
    u11.Archivable = false
    local u24 = script.CloneFX
    task.delay(p10.SpawnTime, function() --[[ Line: 89 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u20
            [3] = u24
            [4] = u5
            [5] = u11
            [6] = u14
        --]]
        for v25, v26 in u19 do
            v25.Transparency = v26.Visible
        end
        for v27, _ in u20 do
            v27.Enabled = true
        end
        local u28 = u24.SpawnFx:Clone()
        u5.apply(u28, u11)
        u28.Parent = u14.UpperTorso
        task.defer(function() --[[ Line: 103 ]]
            --[[
            Upvalues:
                [1] = u28
            --]]
            _G.customEmit(u28)
            _G.destroy(u28, 3)
        end)
        _G.PlaySound(u14.UpperTorso, script.cloneSpawn, {
            ["RandomSFX"] = true
        }).Parent = u14.UpperTorso
    end)
    local v29 = v18:LoadAnimation(v13)
    v29:Play()
    local u30 = u24.Aura:Clone()
    u5.apply(u30, u11)
    u30.Parent = u14
    _G.particleEnabled(u30, false)
    local v31 = Instance.new("Weld")
    v31.Part0 = u30
    v31.Part1 = u14.UpperTorso
    v31.Parent = u14.UpperTorso
    v29:GetMarkerReachedSignal("AuraOn"):Connect(function() --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        _G.particleEnabled(u30, true)
    end)
    v29:GetMarkerReachedSignal("AuraOff"):Connect(function() --[[ Line: 130 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        _G.particleEnabled(u30, false)
    end)
    task.delay(p10.DespawnTime, function() --[[ Line: 135 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u5
            [3] = u11
            [4] = u14
        --]]
        local v32 = u24.tp:Clone()
        u5.apply(v32, u11)
        v32:PivotTo(u14.UpperTorso:GetPivot())
        v32.Parent = workspace.Effects
        _G.customEmit(v32)
        _G.destroy(v32, 3)
        _G.PlaySound(u14.UpperTorso, script.cloneDespawn, {
            ["RandomSFX"] = true
        })
        u14:Destroy()
    end)
end
function v6.start(_, p34) --[[ Line: 149 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u33
        [3] = u5
        [4] = u7
        [5] = u2
        [6] = u9
        [7] = u3
    --]]
    local u35 = p34.Character
    local u36 = p34.Target
    local _ = p34.TimePosition
    local u37 = p34.ServerTime
    local u38 = p34.grabCFrame
    local u39 = p34.Origin
    local u40 = u4.Character == u35 and true or u4.Character == u36
    local v41 = {
        {
            ["SpawnTime"] = 0.383,
            ["DespawnTime"] = 3.65
        },
        {
            ["SpawnTime"] = 0.5,
            ["DespawnTime"] = 3.65
        },
        {
            ["SpawnTime"] = 0.683,
            ["DespawnTime"] = 2.7
        },
        {
            ["SpawnTime"] = 1.167,
            ["DespawnTime"] = 2.4
        }
    }
    for v42 = 1, 4 do
        local v43 = v41[v42]
        u33({
            ["Character"] = u35,
            ["Pivot"] = u39,
            ["Animation"] = script["Clone" .. v42],
            ["SpawnTime"] = v43.SpawnTime,
            ["DespawnTime"] = v43.DespawnTime
        })
    end
    task.delay(2.98, function() --[[ Line: 182 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u35
            [3] = u36
        --]]
        local v44 = script.GroundHit:Clone()
        u5.apply(v44, u35)
        v44.CFrame = CFrame.new(u36.UpperTorso.Position)
        v44.Parent = workspace.Effects
        _G.destroy(v44, 5)
        _G.customEmit(v44)
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 25,
            ["Position"] = (v44.CFrame * CFrame.new(0, 1, 0)).Position,
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 2,
            ["TweenDuration"] = 1,
            ["Radius"] = 8,
            ["Direction"] = v44.CFrame.UpVector * -15
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 8,
            ["RandomVelocityMagnitude"] = Vector2.new(-35, 35),
            ["Position"] = (v44.CFrame * CFrame.new(0, 1, 0)).Position,
            ["Direction"] = v44.CFrame.UpVector * 15,
            ["RaycastDirection"] = v44.CFrame.UpVector * -15,
            ["Size"] = Vector3.new(0.5, 0.5, 0.5),
            ["TrailEnabled"] = true
        }, true)
    end)
    task.delay(1.067, function() --[[ Line: 213 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        _G.PlaySound(u36.PrimaryPart, script.cloneAttackSFX)
    end)
    task.delay(0.3, function() --[[ Line: 217 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        _G.PlaySound(u36.PrimaryPart, script.startPillarSFX)
    end)
    task.delay(0.5, function() --[[ Line: 222 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u7
            [3] = u5
            [4] = u35
            [5] = u2
        --]]
        local v45 = u39.Position
        local v46 = workspace:Raycast(v45, Vector3.new(0, -10, 0), u7)
        local v47
        if v46 then
            v47 = v46.Position
        else
            v47 = v45 - Vector3.new(0, 10, 0)
        end
        local u48 = script.Pillar:Clone()
        u5.apply(u48, u35)
        u48.CFrame = CFrame.new(v47) * CFrame.new(0, -0.5, 0)
        u48.Parent = workspace.Effects
        for _, v49 in u48:QueryDescendants("Beam") do
            local v50 = v49.Width0
            local v51 = v49.Width1
            v49.Width0 = 0
            v49.Width1 = 0
            u2:Create(v49, TweenInfo.new(0.5), {
                ["Width0"] = v50,
                ["Width1"] = v51
            }):Play()
        end
        local v52 = u48.Reciever.CFrame
        u48.Reciever.CFrame = CFrame.new(0, 0, 0)
        _G.tween(u48.Reciever, {
            0.23,
            "Circular",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v52
        })
        task.delay(4.15, function() --[[ Line: 254 ]]
            --[[
            Upvalues:
                [1] = u48
            --]]
            _G.particleEnabled(u48, false)
            _G.destroy(u48, 2)
            for _, v53 in pairs(u48:GetDescendants()) do
                if v53:IsA("Beam") then
                    _G.tween(v53, {
                        v53:GetAttribute("TIME") or 0.35,
                        "Cubic",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
        end)
    end)
    task.delay(3.65, function() --[[ Line: 267 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u35
            [3] = u38
            [4] = u9
            [5] = u39
            [6] = u7
            [7] = u2
        --]]
        local v54 = script.meshes:Clone()
        u5.apply(v54, u35)
        v54:PivotTo(u38)
        v54.Parent = workspace.Effects
        u9.emit(v54)
        _G.destroy(v54, 5)
        local v55 = Instance.new("Highlight")
        v55.FillTransparency = 0
        v55.FillColor = Color3.fromRGB(0, 0, 0)
        v55.OutlineColor = Color3.fromRGB(255, 65, 151)
        v55.DepthMode = Enum.HighlightDepthMode.Occluded
        v55.Parent = u35
        local v56 = script.Frontbeam:Clone()
        u5.apply(v56, u35)
        v56.CFrame = u39 * CFrame.new(0, 0, 8)
        v56.Parent = workspace.Effects
        _G.PlaySound(u35.PrimaryPart, script.finalSlashSFX)
        _G.PlaySound(u35.PrimaryPart, script.finalSlashSFX2)
        local v57 = workspace:Raycast(u39 * CFrame.new(0, 1, -16).Position, Vector3.new(-0, -8, -0), u7)
        if v57 then
            local u58 = script.Crack:Clone()
            u5.apply(u58, u35)
            u58.CFrame = CFrame.lookAlong(v57.Position, u39.LookVector, v57.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
            u58.Parent = workspace.Effects
            task.delay(2, function() --[[ Line: 307 ]]
                --[[
                Upvalues:
                    [1] = u58
                --]]
                _G.tween(u58.Decal, {
                    1,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(u58, 1)
            end)
        end
        _G.customEmit(v56)
        local v59 = v56.Reciever.CFrame
        v56.Reciever.CFrame = v56.Sender.CFrame
        _G.tween(v56.Reciever, {
            0.06,
            "Circular",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v59
        })
        u2:Create(v55, TweenInfo.new(0.15), {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        }):Play()
        _G.destroy(v55, 0.15)
        task.wait(1)
        _G.particleEnabled(v56, false)
        _G.destroy(v56, 4)
        for _, v60 in pairs(v56:GetDescendants()) do
            if v60:IsA("Beam") then
                _G.tween(v60, {
                    v60:GetAttribute("TIME") or 0.35,
                    "Cubic",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
            end
        end
        _G.PlaySound(v56.Reciever.CFrame, script.pillarCloseSFX)
    end)
    local u61 = script.HitFx:Clone()
    u5.apply(u61, u35)
    u61.Parent = u36.UpperTorso
    local v62 = {
        1.067,
        1.3,
        1.617,
        1.7,
        2,
        2.117,
        2.333
    }
    for _, v63 in v62 do
        task.delay(v63, function() --[[ Line: 360 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u61
            --]]
            local v64 = u3:NextNumber(-1.5, 1.5)
            local v65 = u3:NextNumber(-1.5, 1.5)
            local v66 = u3:NextNumber(-1.5, 1.5)
            u61.CFrame = CFrame.new(v64, v65, v66)
            _G.customEmit(u61)
        end)
    end
    task.delay(v62[#v62], function() --[[ Line: 368 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        _G.destroy(u61, 5)
    end)
    task.spawn(function() --[[ Line: 373 ]] end)
    task.delay(2.8, function() --[[ Line: 399 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u35
            [3] = u39
        --]]
        local v67 = script.Kicks:Clone()
        u5.apply(v67, u35)
        v67.CFrame = u39 * CFrame.new(0, 11, 0)
        v67.Parent = workspace.Effects
        _G.destroy(v67, 5)
        _G.customEmit(v67)
        for _, v68 in pairs(v67:GetChildren()) do
            if v68:IsA("Attachment") then
                _G.tween(v68, {
                    0.25,
                    "Circular",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v68.CFrame * CFrame.Angles(0, 0, -2.443460952792061)
                })
            end
        end
        for _, v69 in pairs(v67:GetDescendants()) do
            if v69:IsA("Beam") then
                _G.tween(v69, {
                    0.25,
                    "Circular",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
            end
        end
    end)
    task.delay(2.1, function() --[[ Line: 422 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u35
            [3] = u40
        --]]
        local v70 = script.SpinningFx:Clone()
        u5.apply(v70, u35)
        v70.Parent = u35.RightHand
        _G.particleEnabled(v70, true)
        _G.PlaySound(u35.PrimaryPart, script.scytheSpinSFX)
        task.wait(0.6)
        _G.particleEnabled(v70, false)
        _G.destroy(v70, 5)
        if u40 then
            local v71 = script.ColorCorrection:Clone()
            v71.Parent = game.Lighting
            _G.destroy(v71, 0.1)
        end
        task.wait(0.1)
        local v72 = u35:FindFirstChild("Sickle of SorrowSword")
        if v72 then
            for _, v73 in script["Scythe FX"]:GetChildren() do
                local v74 = v73:Clone()
                u5.apply(v74, u35)
                v74.Parent = v72
                _G.destroy(v74, 5)
            end
            _G.customEmit(v72)
        end
    end)
    task.spawn(function() --[[ Line: 458 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u39
            [3] = u37
            [4] = u2
            [5] = u35
            [6] = u36
            [7] = u7
        --]]
        local v75 = u38
        local v76 = v75.Position + v75.LookVector * 1.5
        local v77 = u39.Position
        local v78 = 1.5
        repeat
            game.RunService.RenderStepped:Wait()
            local v79 = workspace:GetServerTimeNow() - u37
            local v80 = u2:GetValue(math.min(v79, v78) / v78, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local v81 = CFrame.lookAlong(Vector3.new(0, 0, 0), -u35:GetPivot().LookVector) + v76:Lerp(v77, v80)
            u36.PrimaryPart.CFrame = v81
        until v80 == 1
        local v82 = workspace:Raycast(v77, Vector3.new(0, 7.5, 0), u7)
        u37 = workspace:GetServerTimeNow()
        local v83 = v82 and v82.Position + v82.Normal or v77 + Vector3.new(0, 7.5, 0)
        local v84 = 2
        repeat
            game.RunService.RenderStepped:Wait()
            local v85 = workspace:GetServerTimeNow() - u37
            local v86 = u2:GetValue(math.min(v85, v84) / v84, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v87 = CFrame.lookAlong(Vector3.new(0, 0, 0), -u35:GetPivot().LookVector)
            local v88 = 3.141592653589793 * v86
            local v89 = v87 + v77:Lerp(v83, (math.sin(v88)))
            u36.PrimaryPart.CFrame = v89
        until v86 == 1
    end)
end
return v6