 

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
ApplyRig = require(script.Parent.ApplyRig)
local u8 = require(script.Parent.ConeVFX)
require(script.Parent.LightningVFX)
local u9 = require(script.Parent.ImpactFrames)
local u10 = require(script.Crater)
local u11 = require(script.SecondCrater)
local u12 = require(game.ReplicatedStorage.Modules.LightningBoltHighlight)
local v13 = {}
local function u18(p14, p15) --[[ Line: 41 ]]
    local v16 = p14:GetChildren()
    for v17 = 1, #v16 do
        v16[v17].Color = ColorSequence.new(p15)
    end
end
local u19 = {
    ["White"] = {
        ["Lifetime"] = 0.7,
        ["SizeMultiplier"] = Vector3.new(2, 0.5, 2),
        ["CFrameOffset"] = CFrame.new(0, 5, 0) * CFrame.Angles(0, 3.141592653589793, 0)
    },
    ["Back"] = {
        ["Lifetime"] = 1.1,
        ["SizeMultiplier"] = Vector3.new(2.5, 1.5, 2.5),
        ["CFrameOffset"] = CFrame.new(0, -5, 0) * CFrame.Angles(0, 2.1666156231653746, 0)
    },
    ["Shock"] = {
        ["Lifetime"] = 0.9,
        ["SizeMultiplier"] = Vector3.new(2.4, 2, 2.4),
        ["CFrameOffset"] = CFrame.new(0, 5, 0) * CFrame.Angles(0, 2.0943951023931953, 0)
    },
    ["Middle"] = {
        ["Lifetime"] = 1.3,
        ["SizeMultiplier"] = Vector3.new(4, 1.5, 4),
        ["CFrameOffset"] = CFrame.new(0, 9, 0) * CFrame.Angles(0, -0.7853981633974483, 0)
    },
    ["Front"] = {
        ["Lifetime"] = 1.1,
        ["SizeMultiplier"] = Vector3.new(4, 1.5, 4),
        ["CFrameOffset"] = CFrame.new(0, -16, 0) * CFrame.Angles(0, -2.0943951023931953, 0)
    },
    ["Shock4"] = {
        ["EaseDir"] = Enum.EasingDirection.Out,
        ["Lifetime"] = 0.9,
        ["SizeMultiplier"] = Vector3.new(2, 0.6, 2),
        ["CFrameOffset"] = CFrame.new(0, 6, 0) * CFrame.Angles(0, 2.5132741228718345, 0)
    }
}
local u20 = {
    ["BigArm"] = {
        [true] = { Enum.EasingStyle.Elastic, Enum.EasingDirection.Out },
        [false] = { Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut }
    },
    ["Bone"] = {
        [true] = { Enum.EasingStyle.Elastic, Enum.EasingDirection.Out },
        [false] = { Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }
    }
}
function v13.start(_, u21, p22, u23, p24, u25, p26) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u20
        [3] = u8
        [4] = u9
        [5] = u12
        [6] = u10
        [7] = u11
        [8] = u19
    --]]
    if not _G.checkRenderDistance(u21.PrimaryPart.Position) then
        return
    end
    local u27 = Random.new()
    local v28 = script.AlignPosition:Clone()
    local v29 = script.AlignOrientation:Clone()
    v28.Attachment0 = u21.PrimaryPart.RootRigAttachment
    v29.Attachment0 = u21.PrimaryPart.RootRigAttachment
    v29.Parent = u21
    v28.Parent = u21
    local u30 = workspace.CurrentCamera
    local v31 = u21.Humanoid
    local v32 = v31.RootPart
    local u33 = Color3.fromRGB(255, 0, 0)
    local v34 = game.ReplicatedStorage:FindFirstChild("Stats" .. u21.Name)
    if v34 then
        u33 = v34.Customization.BusoColor.Value
    end
    local u35 = CFrame.new(0, 0, 10)
    local v36 = v32.Position
    local v37 = (p22 * CFrame.new(0, 0, 10)).Position + Vector3.new(0, 35, 0)
    local v38 = p22.Position
    local v39 = (v38 - v37).Magnitude
    local u40 = math.clamp(v39, 5, 130)
    local v41 = (v32.Position - v37).Magnitude
    local u42 = CFrame.new(v37, v38) * CFrame.new(0, 0, 0)
    local u43 = workspace:Raycast(v37, u42.LookVector * u40 * 1.25, _G.Ess.RaycastParams)
    if u43 then
        u40 = u43.Distance
    end
    local u44 = u42 * CFrame.new(0, 0, -u40)
    local v45 = v41 / 400
    local u46 = (workspace.CurrentCamera.CFrame.Position - u42.Position).Magnitude < 500
    local v47 = u21.Humanoid:LoadAnimation(script.Parent.Anims.dash)
    v47:Play()
    _G.PlaySound(u21.PrimaryPart, script["Audio/GumGiantPistolStart"]).Parent = u21.PrimaryPart
    v28.Enabled = false
    v29.Enabled = false
    local v48 = script.JumpWind:Clone()
    v48.CFrame = CFrame.new(v32.Position, v37) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v48.Parent = workspace.Effects
    _G.PlaySound(u21.PrimaryPart, script.GiantPistolTp).Parent = u21.PrimaryPart
    local v49 = v41 / 130 + 0.5
    local v50 = math.clamp(v49, 1, 3) ^ 1.2
    for _, v51 in v48:GetDescendants() do
        if v51:IsA("ParticleEmitter") then
            local v52 = {}
            for v53, v54 in v51.Size.Keypoints do
                v52[v53] = NumberSequenceKeypoint.new(v54.Time, v54.Value * v50, v54.Envelope)
            end
            v51.Size = NumberSequence.new(v52)
            v51.Speed = NumberRange.new(v51.Speed.Min * v50 / 2, v51.Speed.Max * v50)
        end
    end
    v48.Line.Speed = NumberRange.new(v41 * 2, v41 * 7 + 30)
    Emit(v48:GetDescendants(), true)
    _G.destroy(v48, 1.2)
    task.wait(v45)
    v47:Stop()
    local u55 = ApplyRig:start(u21, "RightLowerArm", "Gear3")
    local u56 = u55.aRM2
    local u57 = u55.aRM2Light
    u57.Color = u33
    u56.Color = u21.Head.Color
    u56.Size = Vector3.new(0, 0, 0)
    u56.Transparency = 1
    local v58 = nil
    local v59 = v58 == nil and "Palm" or v58
    local v60 = u55:GetDescendants()
    local u61 = nil
    for v62 = 1, #v60 do
        if v60[v62].Name == v59 then
            u61 = v60[v62]
            break
        end
    end
    local v63 = v31.Animator:LoadAnimation(script.Parent.Anims.ElephantGun)
    v63.Priority = Enum.AnimationPriority.Action4
    local v64 = u55.AnimationController:LoadAnimation(script.Parent.Anims.ElephantGun)
    v64.Priority = Enum.AnimationPriority.Action4
    for _, v65 in u55.PrimaryPart.Center:GetDescendants() do
        v65.CFrame = CFrame.new()
    end
    local u66 = script.HandVFX:Clone()
    u66.Parent = workspace.Effects
    u66.CFrame = u61.TransformedCFrame
    u18(u66.AttachmentColor, u33)
    u18(u66.Emit, u33)
    v63:Play(0)
    v64:Play(0)
    u56.Transparency = 0
    local function v89(p67) --[[ Line: 236 ]]
        --[[
        Upvalues:
            [1] = u55
            [2] = u20
            [3] = u56
            [4] = u57
            [5] = u33
            [6] = u66
            [7] = u21
        --]]
        local v68 = {
            [true] = 0.6,
            [false] = 0.6
        }
        for _, v69 in u55.PrimaryPart.Center:GetDescendants() do
            local v70 = (v69.Name:match("Right") or v69.Name:match("Palm")) and 0.25 or 0
            local v71 = v68[p67] + (p67 ~= true and 0 or v70)
            local v72 = {
                [true] = CFrame.new(),
                [false] = v69:GetAttribute("OriginalCFrame")
            }
            v69.CFrame = v72[p67]
            local v73 = TweenCreate
            local v74 = TweenInfo.new
            local v75 = u20.Bone[p67]
            v73(v69, v74(v71, unpack(v75)), {
                ["CFrame"] = v72[not p67]
            })
        end
        local v76 = TweenCreate
        local v77 = u56
        local v78 = TweenInfo.new
        local v79 = v68[p67]
        local v80 = u20.BigArm[p67]
        local v81 = v76(v77, v78(v79, unpack(v80)), {
            ["Size"] = not p67 and Vector3.new(0, 0, 0) or u56:GetAttribute("OriginalSize")
        })
        local v82 = TweenCreate
        local v83 = u57
        local v84 = TweenInfo.new
        local v85 = v68[p67]
        local v86 = u20.BigArm[p67]
        v82(v83, v84(v85, unpack(v86)), {
            ["Size"] = not p67 and Vector3.new(0, 0, 0) or u57:GetAttribute("OriginalSize")
        })
        if p67 == false then
            v81.Completed:Once(function() --[[ Line: 273 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u57
                --]]
                u56.Color = u56:GetAttribute("OriginalColour")
                u56.Transparency = 1
                u57.Transparency = 1
            end)
        else
            local v87 = script.InflateLines:Clone()
            for _, v88 in v87:GetDescendants() do
                if v88:IsA("ParticleEmitter") and v88:GetAttribute("Customizable") == true then
                    v88.Color = ColorSequence.new(u33)
                end
            end
            task.wait(0.15)
            u56.Color = u33
            u56.Material = Enum.Material.Neon
            task.delay(0.1, function() --[[ Line: 297 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u56
                --]]
                u57.Transparency = 0
                u56.Material = Enum.Material.SmoothPlastic
                TweenCreate(u56, TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Color"] = Color3.fromRGB(0, 0, 0)
                })
            end)
            _G.customEmit(u66.Emit)
            _G.particleEnabled(u66.Attachment, true)
            _G.particleEnabled(u66.AttachmentColor, true)
            _G.PlaySound(u21.PrimaryPart, script.BusoHakiV3).Parent = u21.PrimaryPart
            v87.CFrame = u56.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(5, 0, 14)
            v87.Parent = workspace.Effects
            Emit(v87:GetDescendants(), true)
            _G.destroy(v87, 1.1)
        end
    end
    local u90 = true
    local u91 = u21 == game.Players.LocalPlayer.Character
    local _ = u30.CameraType
    local _ = u30.CameraSubject
    if u91 == true then
        u30.FieldOfView = 70
        u30.CameraType = Enum.CameraType.Scriptable
    end
    local u92 = tick()
    local u94 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 344 ]]
        --[[
        Upvalues:
            [1] = u66
            [2] = u61
            [3] = u92
            [4] = u90
            [5] = u8
            [6] = u42
            [7] = u91
            [8] = u30
            [9] = u23
            [10] = u35
            [11] = u21
        --]]
        u66.CFrame = u61.TransformedWorldCFrame * CFrame.new(0, 5, 5)
        if tick() - u92 >= 0.05 and u90 == false then
            local v93 = { 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }
            u8:start(u66.CFrame, u42, -6, 90, 4, { 1.4, 3, Vector3.new(0.5714286, 0.14285715, 0.5714286) }, v93, { 0.5, 0.75 })
            u92 = tick()
        end
        if u91 == true then
            u30.CFrame = u30.CFrame:Lerp(u23.CFrame * u35, 0.5)
            if u21.PrimaryPart.Anchored == true then
                u21.Humanoid.AutoRotate = false
            end
        end
    end)
    task.delay(2.69, function() --[[ Line: 361 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u94
            [3] = u91
            [4] = u30
        --]]
        if u23 then
            u23:Destroy()
        end
        u94:Disconnect()
        if u91 == true then
            u30.FieldOfView = 70
            u30.CameraType = Enum.CameraType.Custom
        end
    end)
    task.wait(0.59)
    v89(true)
    if u46 == true then
        TweenCreate(u30, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["FieldOfView"] = 90
        })
    end
    task.spawn(function() --[[ Line: 384 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u42
        --]]
        local v95 = { 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }
        u8:start(u42, u42 * CFrame.new(0, 0, 50), -6, 90, 2, { 1.4, 2.4, Vector3.new(0.5714286, 0.14285715, 0.5714286) }, v95, { 0.5, 0.75 })
    end)
    task.delay(0.3, function() --[[ Line: 393 ]]
        --[[
        Upvalues:
            [1] = u21
        --]]
        _G.PlaySound(u21.PrimaryPart, script.GiantPistolWhoosh)
    end)
    task.delay(0.75, function() --[[ Line: 396 ]]
        --[[
        Upvalues:
            [1] = u90
        --]]
        u90 = false
    end)
    task.wait(0.93)
    v63:AdjustSpeed(0.75)
    v64:AdjustSpeed(0.75)
    local _ = CFrame.new(0, 0, 60)
    if u46 == true then
        TweenCreate(u30, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["FieldOfView"] = 65
        })
    end
    local _ = true
    _G.particleEnabled(u66, false)
    _G.destroy(u66, 15)
    if p24 then
        task.delay(0.015, function() --[[ Line: 421 ]]
            --[[
            Upvalues:
                [1] = u46
                [2] = u9
                [3] = u33
                [4] = u25
                [5] = u12
            --]]
            if u46 == true then
                u9:start(2.45, -20, -1, u33:Lerp(Color3.new(1, 1, 1), 0.15), 0.135)
            end
            local v96 = CFrame.new(u25)
            local v97 = {}
            local v98 = v96.Position + Vector3.new(0, 1, 0)
            local v99 = v96.upVector
            v97.WorldPosition = v98
            v97.WorldAxis = v99
            local v100 = 0
            for v101 = 1, 9 do
                for v102 = 0, 6.2, 1.25 do
                    local v103 = {}
                    local v104 = v96 * CFrame.Angles(0, v102, 0) * CFrame.new(v102 * 25 + 10 + v100, v102 * 8 + 85, 0)
                    local v105 = v104.Position
                    local v106 = v104.upVector
                    v103.WorldPosition = v105
                    v103.WorldAxis = v106
                    local v107 = u12.new(v97, v103, 5)
                    local v108 = (v101 >= 7 and 4 or 1) * 12.1
                    v107.MinRadius = 4.7
                    v107.MaxRadius = v108
                    v107.Frequency = 25
                    v107.AnimationSpeed = 0
                    v107.Thickness = math.random(300, 600) / 100
                    v107.MinThicknessMultiplier = 0.25
                    v107.MaxThicknessMultiplier = 1
                    v107.ContractFrom = 0.52
                    v107.PulseSpeed = Random.new():NextNumber(7.5, 12)
                    v107.PulseLength = 1
                    v107.FadeLength = 0.46
                    v107.Color = Color3.new(0, 0, 0)
                    v107.ColorOffsetSpeed = 16
                    v107.OuterColor = u33
                end
                if v101 >= 4 then
                    v100 = v100 + 25
                end
                task.wait(0.12)
            end
        end)
        local v109 = CFrame.new
        local v110 = v36.X
        local v111 = u25.Y
        local v112 = v36.Z
        local v113 = v109(u25, (Vector3.new(v110, v111, v112))) * CFrame.Angles(0, -1.5707963267948966, 0)
        local v114 = script.Impact:Clone()
        v114:PivotTo(CFrame.new(u25, u25 + p26) * CFrame.Angles(-1.5707963267948966, 0, 0) * v113.Rotation + Vector3.new(0, 0.05, 0))
        v114.Parent = workspace.Effects
        u10:start(v114:GetPivot() * CFrame.Angles(-0.10471975511965978, 0, 0) + Vector3.new(0, 2, 0), 12, u43)
        Emit(v114:GetDescendants(), true)
        _G.destroy(v114, 3.2)
        for _, u115 in v114:GetDescendants() do
            if u115:IsA("BasePart") then
                local v116 = u115.Size
                u115.Size = u115.Size * 0.1
                TweenCreate(u115, TweenInfo.new(0.01, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Size"] = v116
                })
            elseif u115:IsA("Decal") then
                task.delay(0.25, function() --[[ Line: 513 ]]
                    --[[
                    Upvalues:
                        [1] = u115
                    --]]
                    TweenCreate(u115, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, u115:GetAttribute("DelayTime")), {
                        ["Transparency"] = 1
                    })
                end)
            end
        end
        local v117 = script.Explosion:Clone()
        v117.CFrame = v114:GetPivot()
        v117.Parent = workspace.Effects
        u18(v117.AttachmentColor, u33)
        _G.customEmit(v117)
        _G.destroy(v117, 7)
        _G.PlaySound(v117, script.GumGiantPistolBoomLightning)
        task.delay(0.15, function() --[[ Line: 533 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u27
                [3] = u11
                [4] = u43
            --]]
            local v118 = script.ExtraMeshes.Shockwave:Clone()
            v118.CFrame = CFrame.new(u25 + Vector3.new(0, 7, 0)) * CFrame.Angles(0, u27:NextNumber(), 1.5707963267948966)
            v118.Parent = workspace.Effects
            local v119 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenCreate(v118, v119, {
                ["CFrame"] = v118.CFrame * CFrame.Angles(0, 0, 0) + Vector3.new(0, 12, 0)
            })
            TweenCreate(v118.Mesh, v119, {
                ["Scale"] = v118.Mesh.Scale * 2.35
            })
            TweenCreate(v118.Decal, TweenInfo.new(v119.Time, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                ["Transparency"] = 1
            })
            _G.destroy(v118, v119.Time)
            for v120 = 1, 10 do
                local v121 = v120 / 10 * 360
                local u122 = script.Dust:Clone()
                u122.CFrame = CFrame.new(u25) * CFrame.Angles(0, math.rad(v121), 0) * CFrame.new(0, 0, -10)
                local v123, _, _ = _G.getRayFloor(u122.CFrame, 15)
                u122.Parent = workspace.Effects
                if v123 then
                    local v124 = u122:GetChildren()
                    for v125 = 1, #v124 do
                        v124[v125].Color = ColorSequence.new(v123.Color)
                    end
                end
                local v126 = TweenCreate
                local v127 = TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0.1)
                local v128 = {
                    ["CFrame"] = u122.CFrame * CFrame.new(0, 0, -math.random(15, 55))
                }
                local v129 = u122.Size
                local v130 = math.random
                v128.Size = v129 + Vector3.new(0, 0, v130(20, 50))
                v126(u122, v127, v128)
                task.delay(0.1, function() --[[ Line: 582 ]]
                    --[[
                    Upvalues:
                        [1] = u122
                    --]]
                    Emit(u122, false, 0.12)
                    _G.destroy(u122, 5)
                end)
            end
            task.wait(0.1)
            for v131 = 1, 12 do
                local v132 = CFrame.new
                local v133 = u25
                local v134 = ((9 - v131) / 2) ^ 2 / 1.4
                u11:start(v132(v133 + Vector3.new(0, v134, 0)) * CFrame.Angles(0, u27:NextNumber(0, 3), 0), (v131 - 1) * 6 + 20, u43, 20)
                task.wait()
            end
        end)
    end
    task.delay(0.175, function() --[[ Line: 604 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u42
            [3] = u44
            [4] = u40
            [5] = u19
        --]]
        local v135 = { 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out }
        u8:start(u42 * CFrame.new(0, 0, -5), u44, -6, 90, 4, { 1.8, 2, Vector3.new(0.5714286, 0.4, 0.5714286) }, v135, { 0.15, 0.45 }, 0.02)
        local v136 = script.WindMeshes:Clone()
        v136:PivotTo(u42 * CFrame.new(0, 0, -u40) * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0))
        v136.Parent = workspace.Effects
        _G.destroy(v136, 1)
        for _, v137 in pairs(v136:GetChildren()) do
            local v138 = u19[v137.Name]
            if v138 then
                local v139 = Enum.EasingDirection.Out
                if v138.EaseDir then
                    v139 = v138.EaseDir
                end
                local _ = v137.Mesh.Scale
                local v140 = v137.Mesh
                v140.Scale = v140.Scale / 2
                TweenCreate(v137, TweenInfo.new(v138.Lifetime, Enum.EasingStyle.Quad, v139), {
                    ["CFrame"] = v137.CFrame * v138.CFrameOffset
                })
                TweenCreate(v137.Mesh, TweenInfo.new(v138.Lifetime, Enum.EasingStyle.Quad, v139), {
                    ["Scale"] = v137.Mesh.Scale * v138.SizeMultiplier
                })
                TweenCreate(v137.Decal, TweenInfo.new(v138.Lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["Transparency"] = 1
                })
            end
        end
    end)
    task.wait(0.6)
    v89(false)
    task.wait(0.6)
    u55:Destroy()
    v29:Destroy()
    v28:Destroy()
end
return v13