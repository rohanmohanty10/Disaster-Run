 

game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("Workspace")
local u1 = script.Move6
local u2 = u1.Anims
local u3 = 10.5
local v4 = {}
local function u8(p5, p6) --[[ Line: 30 ]]
    for _, v7 in ipairs(p5:GetDescendants()) do
        if v7:IsA("ParticleEmitter") then
            v7.Enabled = p6
        end
    end
end
local function u12(p9, p10) --[[ Line: 50 ]]
    for _, v11 in ipairs(p9:GetDescendants()) do
        if v11:IsA("ParticleEmitter") then
            _G.tween(v11, {
                0.45,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["TimeScale"] = p10
            })
        end
    end
end
function GetTopAndBottomTrailAttachments(p13)
    local v14 = p13.Size
    local v15 = p13.CFrame
    local v16 = {
        {
            ["axis"] = "X",
            ["size"] = v14.X
        },
        {
            ["axis"] = "Y",
            ["size"] = v14.Y
        },
        {
            ["axis"] = "Z",
            ["size"] = v14.Z
        }
    }
    table.sort(v16, function(p17, p18) --[[ Line: 85 ]]
        return p17.size > p18.size
    end)
    local v19 = v16[1].axis
    local v20 = v16[1].size
    local v21 = nil
    local v22 = nil
    if v19 == "X" then
        local v23 = -v20 / 2
        v21 = Vector3.new(v23, 0, 0)
        local v24 = v20 / 2
        v22 = Vector3.new(v24, 0, 0)
    elseif v19 == "Y" then
        local v25 = -v20 / 2
        v21 = Vector3.new(0, v25, 0)
        local v26 = v20 / 2
        v22 = Vector3.new(0, v26, 0)
    elseif v19 == "Z" then
        local v27 = -v20 / 2
        v21 = Vector3.new(0, 0, v27)
        local v28 = v20 / 2
        v22 = Vector3.new(0, 0, v28)
    end
    local v29 = v15:PointToWorldSpace(v21)
    local v30 = v15:PointToWorldSpace(v22)
    local v31 = (1 / 0)
    local v32 = (1 / 0)
    local v33 = nil
    local v34 = nil
    for _, v35 in ipairs(p13:GetChildren()) do
        if v35:IsA("Trail") and v35.Name ~= "notTrail" then
            local v36 = v35.Attachment0
            local v37 = v35.Attachment1
            if v36 and v37 then
                local v38 = (v36.WorldPosition - v30).Magnitude
                local v39 = (v37.WorldPosition - v29).Magnitude
                if v38 >= v31 then
                    v36 = v33
                    v38 = v31
                end
                if v39 < v32 then
                    v34 = v37
                    v33 = v36
                    v32 = v39
                    v31 = v38
                else
                    v33 = v36
                    v31 = v38
                end
            end
        end
    end
    return v33, v34
end
function PositionInnerEdgeAttachments2(p40, p41)
    local v42, v43 = GetTopAndBottomTrailAttachments(p40)
    if v42 and v43 then
        local v44 = v43.WorldPosition
        local v45 = v42.WorldPosition
        local v46 = {
            ["InnerEdge1"] = v44,
            ["InnerEdge2"] = v45 + (v44 - v45).Unit * (0.05 * (v44 - v45).Magnitude),
            ["InnerEdge3"] = v45
        }
        for v47, v48 in pairs(v46) do
            local v49 = p41[v47]
            if v49 and v49:IsA("Attachment") then
                v49.WorldPosition = v48
            else
                warn(v47 .. " attachment not found or is not an Attachment!")
            end
        end
    else
        warn("Top or bottom attachment not found!")
    end
end
local function u56(p50, p51, _) --[[ Line: 177 ]]
    local v52 = p50.Position
    local v53 = p50.LookVector:Cross(p51).Unit
    local v54 = (v53.Magnitude > 0.001 and v53 and v53 or p50.RightVector).Unit
    local v55 = v54:Cross(p51).Unit.Unit
    return CFrame.fromMatrix(v52, v54, p51, v55)
end
local function u60(p57, p58) --[[ Line: 191 ]]
    local v59 = script.Move6.DashTP:Clone()
    v59.CFrame = p57
    if p58 then
        _G.PlayEffect("3SSRecolor", nil, v59, p58, "isBlue", Color3.fromRGB(74, 156, 255))
    end
    v59.Parent = workspace.Effects
    _G.customEmit(v59)
    _G.destroy(v59, 3)
end
local function u66(p61, p62, p63, u64) --[[ Line: 213 ]]
    local u65 = false
    p61:GetMarkerReachedSignal(p62):Connect(function() --[[ Line: 215 ]]
        --[[
        Upvalues:
            [1] = u65
            [2] = u64
        --]]
        if u65 == false then
            u65 = true
            u64()
        end
    end)
    task.delay(p63, function() --[[ Line: 222 ]]
        --[[
        Upvalues:
            [1] = u65
            [2] = u64
        --]]
        if u65 ~= true then
            u65 = true
            u64()
        end
    end)
end
function v4.start(_, p67) --[[ Line: 233 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u60
        [3] = u8
        [4] = u2
        [5] = u12
        [6] = u66
        [7] = u56
        [8] = u3
    --]]
    local u68 = p67.Character
    local u69 = p67.CutsceneHit
    if u68 ~= nil then
        local v70
        if u68 then
            v70 = u68.PrimaryPart
        else
            v70 = u68
        end
        if v70 ~= nil then
            if _G.checkRenderDistance(u68.PrimaryPart.Position) == false then
                return
            else
                local u71 = Instance.new("Folder")
                u71.Parent = workspace.Effects
                local u72 = u68:WaitForChild("HumanoidRootPart")
                local u73 = u68:WaitForChild("Humanoid")
                local u74 = p67.Enemy
                local u75 = p67.remote
                local u76 = u68 == game.Players.LocalPlayer.Character
                local u77 = p67.hakiColor
                if p67.slashCFrame == nil then
                    local u78 = {}
                    local function u87(p79) --[[ Line: 302 ]]
                        --[[
                        Upvalues:
                            [1] = u78
                            [2] = u77
                        --]]
                        local v80 = script.Blade:GetChildren()
                        local v81 = {}
                        local v82 = {}
                        for v83 = 1, #v80 do
                            local v84 = v80[v83]:Clone()
                            if v84:IsA("Trail") then
                                v84.Name = "notTrail"
                                table.insert(v81, v84)
                            else
                                v82[v84.Name] = v84
                            end
                            v84.Parent = p79
                            local v85 = u78
                            table.insert(v85, v84)
                        end
                        for v86 = 1, #v81 do
                            v81[v86].Attachment0 = v82[v81[v86].Attachment0.Name]
                            v81[v86].Attachment1 = v82[v81[v86].Attachment1.Name]
                        end
                        if u77 then
                            _G.PlayEffect("3SSRecolor", nil, v81, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                        end
                        PositionInnerEdgeAttachments2(p79, v82)
                    end
                    local function u90() --[[ Line: 328 ]]
                        --[[
                        Upvalues:
                            [1] = u68
                            [2] = u87
                        --]]
                        local v88 = u68:GetChildren()
                        for v89 = 1, #v88 do
                            if v88[v89]:FindFirstChild("Blade") then
                                u87(v88[v89].Blade)
                            end
                        end
                    end
                    local function u92() --[[ Line: 337 ]]
                        --[[
                        Upvalues:
                            [1] = u78
                        --]]
                        for v91 = 1, #u78 do
                            if u78[v91]:IsA("Trail") then
                                u78[v91].Enabled = false
                            end
                            _G.destroy(u78[v91], 3)
                        end
                    end
                    if u69 == true then
                        local u93 = p67.exucuted
                        local u94 = (u68 == game.Players.LocalPlayer.Character and true or u74 == game.Players.LocalPlayer.Character) == true
                        local u95 = u1.Drag:Clone()
                        u95.CFrame = u72.CFrame * CFrame.new(0, 0, -2)
                        if u77 then
                            _G.PlayEffect("3SSRecolor", nil, u95, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                        end
                        u95.Attachment2.Lines.Acceleration = u72.CFrame.LookVector * -800
                        u95.Parent = u71
                        u8(u95, true)
                        if u94 == true then
                            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                            _G.PlayEffect("CameraHideUI", nil, true)
                        end
                        local u96 = u74.Humanoid
                        u73.AutoRotate = false
                        u73.AutomaticScalingEnabled = false
                        u96.AutomaticScalingEnabled = false
                        local u97 = u73:LoadAnimation(u2.Cutscene)
                        u97:Play(0)
                        u97.Looped = (nil or {}).Looped or false
                        local u98 = u74.Humanoid:LoadAnimation(u93 == true and u2.VictimCutscene or u2.VictimCutsceneNormal)
                        u98:Play(0)
                        u98.Looped = (nil or {}).Looped or false
                        local v99 = u74.PrimaryPart
                        if u74:FindFirstChild("LowerTorso") then
                            v99 = u74.LowerTorso
                        end
                        _G.PlaySound(v99.CFrame, script["Audio/3ssDaisenSekaiHit"])
                        tick()
                        local u100 = u1.NormalCam:Clone()
                        local v101 = u1.CutsceneVictimVFX
                        local u102 = v101.SlashesEnable:Clone()
                        if u77 then
                            _G.PlayEffect("3SSRecolor", nil, u102, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                        end
                        local u103 = tick()
                        task.spawn(function() --[[ Line: 391 ]]
                            --[[
                            Upvalues:
                                [1] = u77
                                [2] = u103
                                [3] = u1
                                [4] = u74
                                [5] = u71
                            --]]
                            local v104 = Instance.new("Model")
                            v104.Parent = workspace.Effects
                            local v105 = Instance.new("Highlight")
                            v105.FillColor = Color3.fromRGB(90, 156, 255)
                            if u77 then
                                v105.FillColor = u77
                            end
                            v105.DepthMode = Enum.HighlightDepthMode.Occluded
                            v105.OutlineTransparency = 1
                            v105.FillTransparency = 0.8
                            v105.Parent = v104
                            while tick() - u103 < 2 do
                                local v106 = u1.BeamSlashes:Clone()
                                local v107 = u1.Glass:Clone()
                                v106.CFrame = u74.HumanoidRootPart.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                                v107.CFrame = v106.CFrame
                                if u77 then
                                    _G.PlayEffect("3SSRecolor", nil, v106, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                                end
                                v106.Parent = u71
                                v107.Parent = v104
                                for _, v108 in ipairs(v106:GetDescendants()) do
                                    if v108:IsA("Beam") then
                                        _G.tween(v108, {
                                            0.11,
                                            "Quad",
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
                                _G.tween(v107, {
                                    0.1,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Size"] = Vector3.new(23, 0, 0)
                                })
                                _G.destroy(v107, 0.3)
                                _G.destroy(v106, 0.3)
                                task.wait(0.12)
                            end
                        end)
                        u90()
                        if u94 == true then
                            workspace.CurrentCamera.FieldOfView = 50
                        end
                        if u77 then
                            _G.PlayEffect("3SSRecolor", nil, u100, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                        end
                        u100.Parent = u71
                        u102.Parent = u74.UpperTorso
                        u100:PivotTo(u72.CFrame * CFrame.new(0, 0, -2))
                        local v109 = u100.AnimationController.Animator:LoadAnimation(u93 == true and u2.CameraCutscene or u2.CameraCutsceneNormal)
                        v109:Play(0)
                        v109.Looped = (nil or {}).Looped or false
                        local u110 = nil
                        if u94 == true then
                            local _ = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 463 ]]
                                --[[
                                Upvalues:
                                    [1] = u100
                                    [2] = u110
                                --]]
                                if u100 and u100:IsDescendantOf(workspace) then
                                    workspace.CurrentCamera.CFrame = u100.Cam.CFrame
                                else
                                    u110:Disconnect()
                                end
                            end)
                        end
                        task.spawn(function() --[[ Line: 59 ]]
                            --[[
                            Upvalues:
                                [1] = u8
                                [2] = u102
                                [3] = u12
                            --]]
                            u8(u102, true)
                            task.delay(0.35, function() --[[ Line: 62 ]]
                                --[[
                                Upvalues:
                                    [1] = u12
                                    [2] = u102
                                --]]
                                u12(u102, 0)
                            end)
                            task.delay(0.9, function() --[[ Line: 66 ]]
                                --[[
                                Upvalues:
                                    [1] = u12
                                    [2] = u102
                                --]]
                                u12(u102, 1)
                            end)
                            task.wait(1.55)
                            u8(u102, false)
                        end)
                        u66(u98, "CamEffect", 1.633, function() --[[ Line: 476 ]]
                            --[[
                            Upvalues:
                                [1] = u94
                                [2] = u100
                                [3] = u8
                                [4] = u95
                            --]]
                            if u94 == true then
                                _G.customEmit(u100)
                                workspace.CurrentCamera.FieldOfView = 40
                            end
                            u8(u95, false)
                        end)
                        local u111 = v101.CutBlood:Clone()
                        local u112 = v101.EnableBleeding:Clone()
                        local u113 = {}
                        u66(u98, "Split", 2.233, function() --[[ Line: 490 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u68
                                [3] = u94
                                [4] = u77
                                [5] = u111
                                [6] = u74
                                [7] = u112
                                [8] = u71
                                [9] = u72
                                [10] = u8
                                [11] = u113
                                [12] = u93
                            --]]
                            local v114 = u1.Air:Clone()
                            local v115, _, _ = _G.getRayFloor(u68.PrimaryPart.CFrame, 8)
                            if v115 then
                                _G.recolorParticles(v114, v115.Color)
                            else
                                _G.removeParticles(v114)
                            end
                            if u94 == true then
                                _G.tween(workspace.CurrentCamera, {
                                    0.19,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["FieldOfView"] = 35
                                })
                            end
                            if u77 then
                                _G.PlayEffect("3SSRecolor", nil, { v114 }, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                            end
                            u111.Parent = u74.UpperTorso
                            u112.Parent = u74.UpperTorso
                            v114.Parent = u71
                            v114.CFrame = u72.CFrame * CFrame.new(0, 4, -9)
                            _G.customEmit(u111)
                            u8(v114, true)
                            u8(u112, true)
                            local function v121(p116) --[[ Line: 525 ]]
                                --[[
                                Upvalues:
                                    [1] = u113
                                --]]
                                local v117 = script.Particles:GetChildren()
                                for v118 = 1, #v117 do
                                    local v119 = v117[v118]:Clone()
                                    v119.Enabled = true
                                    v119.Name = "notTrail"
                                    v119.Rate = v119.Rate / 2
                                    v119.Parent = p116.Blade
                                    local v120 = u113
                                    table.insert(v120, v119)
                                end
                            end
                            local v122 = u68:GetChildren()
                            for v123 = 1, #v122 do
                                if v122[v123].Name:match("Sword") and v122[v123]:FindFirstChild("Blade") then
                                    v121(v122[v123])
                                end
                            end
                            if u77 then
                                _G.PlayEffect("3SSRecolor", nil, u113, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                            end
                            if u93 == true then
                                _G.PlaySound(u74.UpperTorso, script.excu)
                            end
                            task.wait(1.7)
                            u8(v114, false)
                            task.wait(2.2)
                            if u94 == true then
                                _G.tween(workspace.CurrentCamera, {
                                    0.4,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["FieldOfView"] = 45
                                })
                            end
                        end)
                        u66(u97, "Swing", 6.617, function() --[[ Line: 562 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u68
                                [3] = u71
                                [4] = u77
                                [5] = u111
                                [6] = u112
                                [7] = u113
                                [8] = u92
                                [9] = u97
                                [10] = u98
                                [11] = u100
                                [12] = u73
                                [13] = u96
                                [14] = u94
                                [15] = u74
                            --]]
                            local v124 = u1.Sweep:Clone()
                            local v125, _, _ = _G.getRayFloor(u68.PrimaryPart.CFrame, 8)
                            if v125 then
                                _G.recolorParticles(v124, v125.Color)
                            else
                                _G.removeParticles(v124)
                            end
                            v124.CFrame = CFrame.new(u68.UpperTorso.Position - Vector3.new(0, 0.3, 0))
                            v124.Parent = u71
                            if u77 then
                                _G.PlayEffect("3SSRecolor", nil, v124, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                            end
                            local v126 = u1.Mesh:Clone()
                            v126.CFrame = v124.CFrame * CFrame.new(0, -3.2, 0)
                            local v127 = Instance.new("Highlight")
                            v127.OutlineTransparency = 1
                            v127.DepthMode = Enum.HighlightDepthMode.Occluded
                            v127.FillTransparency = 1
                            v127.Parent = v126
                            v126.Parent = u71
                            _G.tween(v126, {
                                0.4,
                                "Quad",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Size"] = Vector3.new(26, 0, 26)
                            })
                            _G.destroy(v126, 0.4)
                            _G.customEmit(v124)
                            _G.particleEnabled(u111, false)
                            _G.particleEnabled(u112, false)
                            local v128 = { u111, u112 }
                            _G.destroy(v128, 5)
                            for v129 = 1, #u113 do
                                u113[v129].Enabled = false
                                _G.destroy(u113[v129], 3)
                            end
                            u92()
                            task.wait(1)
                            u97:Stop(0)
                            u98:Stop(0)
                            u100:Destroy()
                            u73.AutomaticScalingEnabled = true
                            u96.AutomaticScalingEnabled = true
                            if u94 == true then
                                workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                                workspace.CurrentCamera.FieldOfView = 70
                                _G.PlayEffect("CameraHideUI", nil, false)
                            end
                            u68.PrimaryPart.Velocity = Vector3.new()
                            u74.PrimaryPart.Velocity = Vector3.new()
                            u73.AutoRotate = true
                            _G.destroy(u71, 2)
                        end)
                    else
                        local u130 = u73:LoadAnimation(u2.Startup)
                        u130:Play(0)
                        u130.Looped = (nil or {}).Looped or false
                        local u131 = _G.PlaySound(u72, script["Audio/3ssDaisenSekaiStart"])
                        u131.Parent = u72
                        u130:AdjustSpeed(2)
                        tick()
                        if u76 == true then
                            _G.FaceMouse = true
                        end
                        local u157 = u130:GetMarkerReachedSignal("SpinStart"):Connect(function() --[[ Line: 637 ]]
                            --[[
                            Upvalues:
                                [1] = u131
                                [2] = u130
                                [3] = u68
                                [4] = u72
                                [5] = u1
                                [6] = u77
                                [7] = u71
                                [8] = u8
                                [9] = u90
                                [10] = u76
                                [11] = u56
                                [12] = u60
                                [13] = u75
                                [14] = u92
                                [15] = u69
                                [16] = u3
                            --]]
                            _G.tween(u131, {
                                0.5,
                                "Sine",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Volume"] = 0
                            })
                            _G.destroy(u131, 0.5)
                            u130:AdjustSpeed(1)
                            local v132, v133, v134 = _G.getRayFloor(u68.PrimaryPart.CFrame, 8)
                            local v135 = CFrame.new(v133, v133 + v134)
                            local v136 = CFrame.Angles
                            local v137 = math.random(0, 360)
                            local v138 = v135 * v136(-1.5707963267948966, math.rad(v137), 0)
                            local u139 = _G.PlaySound(u72, script["Audio/3ssDaisenSekaiChargeLoop"])
                            u139.Parent = u72
                            local v140 = u68.PrimaryPart.Position.X
                            local v141 = u68.PrimaryPart.Position.Z
                            local v142 = Vector3.new(v140, 0, v141)
                            local v143 = u68.RightHand.Position.X
                            local v144 = u68.RightHand.Position.Z
                            local _ = -(v142 - Vector3.new(v143, 0, v144)).Magnitude
                            local u145 = u1.Spinning.VFX2:Clone()
                            local v146 = -u68.PrimaryPart.Size.Y / 6.5
                            local v147 = -u68.PrimaryPart.Size.Y
                            u145.Position = Vector3.new(0, v146, v147)
                            u145.Parent = u68.PrimaryPart
                            if u77 then
                                _G.PlayEffect("3SSRecolor", nil, u145, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                            end
                            local u148 = u1.SpinningSmoke:Clone()
                            u148.CFrame = v138
                            u148.Parent = u71
                            if u77 then
                                _G.PlayEffect("3SSRecolor", nil, u148, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                            end
                            if v132 then
                                _G.recolorParticles(u148, v132.Color)
                            else
                                _G.removeParticles(u148)
                                u148.CFrame = u68.PrimaryPart.CFrame - Vector3.new(0, 2.8, 0)
                            end
                            u8(u145, true)
                            u8(u148, true)
                            u90()
                            u130:GetMarkerReachedSignal("SpinStop"):Connect(function() --[[ Line: 676 ]]
                                --[[
                                Upvalues:
                                    [1] = u8
                                    [2] = u145
                                    [3] = u148
                                    [4] = u139
                                    [5] = u1
                                    [6] = u72
                                    [7] = u77
                                    [8] = u71
                                    [9] = u130
                                    [10] = u76
                                    [11] = u56
                                    [12] = u60
                                    [13] = u68
                                    [14] = u75
                                    [15] = u92
                                    [16] = u69
                                    [17] = u3
                                --]]
                                u8(u145, false)
                                u8(u148, false)
                                _G.destroy(u145, 1)
                                _G.tween(u139, {
                                    0.25,
                                    "Sine",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Volume"] = 0
                                })
                                _G.destroy(u139, 0.25)
                                local v149 = u1.Charge:Clone()
                                v149.CFrame = u72.CFrame
                                if u77 then
                                    _G.PlayEffect("3SSRecolor", nil, v149, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                                end
                                v149.Parent = u71
                                _G.customEmit(v149)
                                u130:GetMarkerReachedSignal("Hit"):Connect(function() --[[ Line: 694 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u76
                                        [2] = u72
                                        [3] = u1
                                        [4] = u56
                                        [5] = u77
                                        [6] = u71
                                        [7] = u60
                                        [8] = u68
                                        [9] = u75
                                        [10] = u92
                                        [11] = u130
                                        [12] = u69
                                        [13] = u3
                                    --]]
                                    if u76 == true then
                                        _G.FaceMouse = false
                                    end
                                    local v150, v151, v152 = _G.getRayFloor(u72.CFrame, 8)
                                    local _ = CFrame.new(v151, v151 + v152) * CFrame.Angles(-1.5707963267948966, 0, 0)
                                    local v153 = u1.DashSection:Clone()
                                    v153.CFrame = u72.CFrame * CFrame.new(0, -2, 0)
                                    if v150 then
                                        v153.CFrame = u56(CFrame.new(Vector3.new(), u72.CFrame.LookVector) + v151, v152) * CFrame.new(0, 0, -10)
                                    end
                                    if u77 then
                                        _G.PlayEffect("3SSRecolor", nil, v153, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                                    end
                                    v153.Parent = u71
                                    _G.customEmit(v153)
                                    u60(u68.PrimaryPart.CFrame, u77)
                                    if u75 and u76 == true then
                                        u72.Anchored = true
                                        u75:FireServer(u72.CFrame)
                                        _G.tween(workspace.CurrentCamera, {
                                            0.05,
                                            "Quad",
                                            Enum.EasingDirection.Out,
                                            0,
                                            true,
                                            0
                                        }, {
                                            ["FieldOfView"] = 90
                                        })
                                        local u154 = script.Move6.cameraZoom:Clone()
                                        u154.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.75)
                                        u154.Parent = workspace.Effects
                                        local u155 = tick()
                                        local u156 = nil
                                        u156 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 725 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u154
                                                [2] = u155
                                                [3] = u156
                                            --]]
                                            u154.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.75)
                                            if tick() - u155 >= 3 then
                                                u156:Disconnect()
                                                u156 = nil
                                                _G.destroy(u154, 3)
                                            end
                                        end)
                                        _G.customEmit(u154)
                                    end
                                    _G.PlaySound(u68.PrimaryPart, script["Audio/3ssDaisenSekaiDash"]).Parent = u68.PrimaryPart
                                    task.wait(0.1)
                                    task.delay(0.7, function() --[[ Line: 738 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u92
                                            [2] = u130
                                        --]]
                                        u92()
                                        u130:Stop()
                                    end)
                                    if u76 == true then
                                        task.wait(0.7)
                                        if u68:FindFirstChild("GrabTag") == nil then
                                            u72.Anchored = false
                                        end
                                    end
                                    if u69 == false then
                                        u3 = 4
                                    end
                                end)
                            end)
                        end)
                        task.delay(u3, function() --[[ Line: 758 ]]
                            --[[
                            Upvalues:
                                [1] = u157
                                [2] = u71
                            --]]
                            u157:Disconnect()
                            _G.destroy(u71, 2)
                        end)
                    end
                else
                    local v158, v159, v160 = _G.getRayFloor(p67.slashCFrame, 8)
                    local v161 = CFrame.new(v159, v159 + v160)
                    local v162 = CFrame.Angles
                    local v163 = math.random(0, 360)
                    local v164 = v161 * v162(-1.5707963267948966, math.rad(v163), 0)
                    local v165 = u1.Slash:Clone()
                    local v166 = p67.slashCFrame
                    v165.CFrame = v166
                    if v158 then
                        v165.VFX.WorldCFrame = v164
                        _G.recolorParticles(v165, v158.Color)
                    else
                        _G.removeParticles(v165)
                    end
                    if u77 then
                        _G.PlayEffect("3SSRecolor", nil, v165, u77, "isBlue", Color3.fromRGB(74, 156, 255))
                    end
                    v165.Parent = workspace.Effects
                    local v167 = p67.startCFrame
                    local v168 = (v167.Position - v166.Position).Magnitude
                    local v169 = u1.Pierce:Clone()
                    v169.CFrame = CFrame.new(v167.Position, v166.Position) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(-v168 / 2, 0, 0)
                    v169.Size = Vector3.new(v168, 20, 20)
                    local v170 = Instance.new("Highlight")
                    v170.DepthMode = Enum.HighlightDepthMode.Occluded
                    v170.FillTransparency = 0
                    v170.OutlineColor = Color3.fromRGB(87, 168, 255)
                    if u77 then
                        v170.OutlineColor = u77
                    end
                    v170.FillColor = Color3.fromRGB(0, 0, 0)
                    v170.Parent = v169
                    v169.Parent = workspace.Effects
                    _G.tween(v169, {
                        0.1,
                        "Sine",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = Vector3.new(v168, 0, 0)
                    })
                    _G.destroy(v169, 0.1)
                    _G.customEmit(v165)
                    _G.destroy(v165, 5)
                    u60(CFrame.new(u68.UpperTorso.Position), u77)
                    return
                end
            end
        end
    end
end
return v4