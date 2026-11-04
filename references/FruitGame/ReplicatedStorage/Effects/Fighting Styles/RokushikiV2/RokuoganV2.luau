 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = workspace.Env:GetDescendants()
game:GetService("RunService")
require(game.ReplicatedStorage.Modules.CameraShaker)
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u3 = script
local v4 = {}
local u5 = game:GetService("TweenService")
local u6 = Random.new()
local u7 = {
    "rbxassetid://16170849289",
    "rbxassetid://16170849135",
    "rbxassetid://16170848956",
    "rbxassetid://16170848789",
    "rbxassetid://16170848677",
    "rbxassetid://16170848524",
    "rbxassetid://16170848395",
    "rbxassetid://16170848308",
    "rbxassetid://16170848206",
    "rbxassetid://16170848114",
    "rbxassetid://16170847970",
    "rbxassetid://16170847743",
    "rbxassetid://16170847619",
    "rbxassetid://16170847394",
    "rbxassetid://16170847283",
    "rbxassetid://16170847193",
    "rbxassetid://16170847076",
    "rbxassetid://16170846944"
}
local function u12(p8, p9, p10) --[[ Line: 51 ]]
    for _, v11 in pairs(p8:GetDescendants()) do
        if p10 then
            v11.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p10), ColorSequenceKeypoint.new(1, p10) })
        end
        if v11:IsA("ParticleEmitter") then
            if p9 == nil then
                _G.customEmit(v11)
            else
                v11.Enabled = p9
            end
        end
    end
end
local u13 = nil
function v4.start(_, p14, p15, p16) --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u5
        [4] = u1
        [5] = u6
        [6] = u7
        [7] = u12
        [8] = u13
    --]]
    if p15 == nil then
        return
    end
    if _G.checkRenderDistance(p15.PrimaryPart.Position) == false then
        return
    end
    local u17 = workspace.CurrentCamera
    local v18 = p15.HumanoidRootPart
    local v19 = p15.Humanoid
    if p14 == "TP" then
        local v20 = workspace:Raycast(p15.PrimaryPart.Position, Vector3.new(0, -8, 0), u2)
        if v20 ~= nil and v20.Instance ~= nil then
            local v21 = script.KickOff:Clone()
            v21.CFrame = v20 and CFrame.new(v20.Position, v20.Position + v20.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.02, 0) or v18.CFrame * CFrame.new(0, -(v18.Size.Y / 2 - v19.HipHeight), 0)
            _G.recolorParticles(v21, v20.Instance.Color)
            v21.Parent = workspace.Effects
            _G.destroy(v21, 2)
            _G.customEmit(v21)
        end
        local v22 = u3.Soru:GetChildren()
        for _, v23 in pairs(p15:GetDescendants()) do
            if v23:IsA("BasePart") and v23.Transparency == 0 then
                for _, v24 in pairs(v22) do
                    local v25 = v24:Clone()
                    v25.Parent = v23
                    _G.customEmit(v25)
                    task.delay(v25.Lifetime.Max, v25.Destroy, v25)
                end
            end
        end
        _G.transparentCharacter(p15)
        task.wait(0.1)
        _G.transparentCharacter(p15, false)
        return
    end
    local u26 = Instance.new("Folder")
    u26.Name = "EffectsFolder"
    u26.Parent = workspace.Effects
    local u27 = p15.PrimaryPart.CFrame
    local v28 = game.Players.LocalPlayer.Character == p15 or game.Players.LocalPlayer.Character == p16
    _G.PlaySound(p15.PrimaryPart, script["Audio/RokuUltHitPrt1AppearInfrontOfTarget"])
    if p16 then
        local v29 = nil
        if v28 == true then
            u5:Create(u17, TweenInfo.new(1), {
                ["FieldOfView"] = 50
            }):Play()
        end
        local u30 = u3.Impacts:Clone()
        u30.CFrame = u27 * CFrame.Angles(0, 3.141592653589793, 0)
        u30.Parent = u26
        local v31 = script.PointLight:Clone()
        v31.Parent = p15.PrimaryPart
        _G.PlaySound(p15.PrimaryPart, script["Audio/RokuUltHitPrt2ChargeUp"])
        local v32 = os.clock()
        task.delay(0.4, function() --[[ Line: 200 ]]
            --[[
            Upvalues:
                [1] = u30
            --]]
            local v33 = u30
            for _, v34 in pairs(v33:GetDescendants()) do
                if v34:IsA("ParticleEmitter") then
                    v34.Enabled = false
                end
            end
        end)
        local v35 = workspace:Raycast(u30.Position, Vector3.new(0, -5, 0), u1)
        local v36
        if v35 then
            v36 = u3.Wind:Clone()
            v36.CFrame = CFrame.lookAt(v35.Position, v35.Normal)
            v36.Parent = u26
        else
            v36 = nil
        end
        local u37 = { p15.RightHand, p15.LeftHand }
        local u38 = false
        while true do
            for u39 = 1, 2 do
                for _ = 1, 2 do
                    task.spawn(function() --[[ Line: 227 ]]
                        --[[
                        Upvalues:
                            [1] = u3
                            [2] = u37
                            [3] = u39
                            [4] = u6
                            [5] = u38
                            [6] = u26
                        --]]
                        local v40 = u3.WindupBezier:Clone()
                        local v41 = u37[u39]
                        local v42 = v41.Position
                        local v43 = u6:NextNumber(-25, 25)
                        local v44 = u6:NextNumber(-25, 25)
                        local v45 = u6
                        local v46 = v42 + Vector3.new(v43, v44, v45:NextNumber(-25, 25))
                        local v47 = u6:NextNumber(-25, 25)
                        local v48 = u6:NextNumber(-25, 25)
                        local v49 = u6
                        local v50 = v42 + Vector3.new(v47, v48, v49:NextNumber(-25, 25))
                        if u38 == false then
                            v40.Trail.Color = ColorSequence.new(Color3.fromRGB(85, 255, 255))
                        end
                        u38 = not u38
                        v40.Position = v46
                        v40.Trail.MaxLength = math.random(3, 5)
                        v40.Parent = u26
                        local v51 = math.random(200, 400) / 1000
                        local v52 = 0
                        while v52 < v51 do
                            local v53 = v41.Position
                            v52 = v52 + task.wait()
                            local v54 = v52 / v51
                            local v55 = math.min(v54, 1)
                            local v56 = v55 * v55 * (3 - 2 * v55)
                            v46 = v46:Lerp(v42, v56)
                            v50 = v50:Lerp(v42, v56)
                            local v57 = 1 - v56
                            v40.Position = v57 * v57 * v46 + 2 * v57 * v56 * v50 + v56 * v56 * v53
                        end
                    end)
                end
            end
            task.spawn(function() --[[ Line: 266 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u27
                    [3] = u6
                    [4] = u26
                    [5] = u5
                    [6] = u7
                --]]
                local v58 = u3.MeshWind:Clone()
                v58.CFrame = u27 * CFrame.Angles(0, u6:NextNumber(0, 6.283185307179586), 0)
                local v59 = u6:NextNumber(1, 3)
                local v60 = v58.Mesh
                local v61 = u6:NextNumber(8, 15)
                v60.Scale = Vector3.new(v59, v61, v59)
                v58.Parent = u26
                u5:Create(v58.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                }):Play()
                local v62 = u6:NextNumber(1, 17)
                local v63 = u5
                local v64 = v58.Mesh
                local v65 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v66 = {}
                local v67 = v58.Mesh.Scale.Y
                local v68 = Vector3.new(v59, v67, v59)
                local v69 = u6:NextNumber(-4, -8)
                v66.Scale = v68 + Vector3.new(v62, v69, v62)
                v63:Create(v64, v65, v66):Play()
                for _, v70 in pairs(u7) do
                    v58.Decal.Texture = v70
                    task.wait(0.01)
                end
            end)
            task.wait(u6:NextNumber(0.01, 0.03))
            if os.clock() - v32 >= 0.7 then
                if v35 then
                    for _, v71 in pairs(v36:GetDescendants()) do
                        if v71:IsA("ParticleEmitter") then
                            v71.Enabled = false
                        end
                    end
                end
                task.wait(0.4)
                _G.PlaySound(p15.PrimaryPart, script["Audio/RokuUltPrt4BlastRelease"])
                _G.PlaySound(p15.PrimaryPart, script["Audio/RokuUltHitPrt3FistsInitialImpact"])
                local v72 = workspace:Raycast(p15.PrimaryPart.Position, Vector3.new(0, -4, 0), u1)
                if v72 then
                    v29 = u3.FloorWind:Clone()
                    v29.Position = v72.Position
                    v29.Orientation = p15.PrimaryPart.Orientation
                    u12(v29, nil, v72.Instance.Color)
                    local v73 = u5:Create(v29, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                        ["CFrame"] = v29.CFrame * CFrame.new(0, 0, 27.5),
                        ["Size"] = Vector3.new(0, 0, 55) + v29.Size
                    })
                    v73:Play()
                    task.delay(0.2, v73.Destroy, v73)
                    v29.Parent = workspace.Effects
                end
                local v74 = Instance.new("Model")
                v74.Parent = workspace.Effects
                local v75 = u3.BeamPart1:Clone()
                local u76 = u3.BeamPart2:Clone()
                v75.CFrame = u27 * CFrame.new(0, -0.5, -3)
                u76.CFrame = v75.CFrame * CFrame.new(0, 0, -8) * CFrame.new(0, 0, -55)
                v75.Parent = v74
                u76.Parent = v74
                for _, v77 in pairs(v75:GetDescendants()) do
                    if v77:IsA("ParticleEmitter") then
                        _G.customEmit(v77)
                    end
                end
                if v28 == true then
                    u5:Create(u17, TweenInfo.new(0.5), {
                        ["FieldOfView"] = 80
                    }):Play()
                    task.delay(0.5, function() --[[ Line: 340 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u17
                        --]]
                        u5:Create(u17, TweenInfo.new(1), {
                            ["FieldOfView"] = 95
                        }):Play()
                    end)
                end
                for _, u78 in pairs(v75:GetDescendants()) do
                    if u78:IsA("Beam") then
                        pcall(function() --[[ Line: 350 ]]
                            --[[
                            Upvalues:
                                [1] = u78
                                [2] = u76
                            --]]
                            local v79 = u78
                            local v80 = u76
                            local v81 = u78.Attachment0.Name
                            v79.Attachment1 = v80[string.sub(v81, 1, 1) .. 2]
                        end)
                    end
                end
                local v82 = u3.BeamParticles:Clone()
                v82.CFrame = v75.CFrame
                v82.Parent = u26
                local v83 = u5
                local v84 = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
                local v85 = {
                    ["CFrame"] = v82.CFrame * CFrame.new(0, 0, -27.5)
                }
                local v86 = v82.Size.X
                local v87 = v82.Size.Y
                v85.Size = Vector3.new(v86, v87, 55)
                v83:Create(v82, v84, v85):Play()
                local v88 = workspace:Raycast(p15.HumanoidRootPart.Position, Vector3.new(0, -12, 0), u2)
                local v89
                if v88 and v88.Instance then
                    v89 = script.DustShockwave:Clone()
                    v89.CFrame = v88 and CFrame.new(v88.Position, v88.Position + v88.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.02, 0) or v18.CFrame * CFrame.new(0, -(v18.Size.Y / 2 - v19.HipHeight), 0)
                    _G.recolorParticles(v89, v88.Instance.Color)
                    v89.Attachment3.WorldCFrame = CFrame.new(v89.Attachment3.WorldCFrame.Position, (u76.CFrame * CFrame.new(0, 0, -30)).Position)
                    v89.Parent = workspace.Effects
                    _G.destroy(v89, 5)
                    for _, v90 in pairs(v89:GetDescendants()) do
                        if v90:IsA("ParticleEmitter") then
                            v90.Enabled = true
                        end
                    end
                else
                    v89 = nil
                end
                local v91 = os.clock()
                _G.tween(v31, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 25,
                    ["Brightness"] = 1.25
                })
                while true do
                    for v92 = 1, 3 do
                        local v93
                        if v92 == 2 then
                            v93 = u3.mesh5:Clone()
                        elseif v92 == 3 then
                            v93 = u3.mesh5_p:Clone()
                        else
                            v93 = u3["mesh" .. math.random(1, 4)]:Clone()
                        end
                        v93.CFrame = v75.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, u6:NextNumber(0, 6.283185307179586), 0)
                        v93.Parent = u26
                        local v94 = u6:NextNumber(10, 20)
                        u5:Create(v93, TweenInfo.new(u6:NextNumber(0.1, 0.18), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Size"] = Vector3.new(v94, 70, v94),
                            ["Transparency"] = 1,
                            ["CFrame"] = v93.CFrame * CFrame.new(0, -35, 0)
                        }):Play()
                    end
                    for _ = 1, 3 do
                        local v95 = Color3.fromRGB(85, 255, 255)
                        if math.random(1, 2) == 1 then
                            v95 = Color3.fromRGB(241, 87, 255)
                        end
                        local v96 = require(script.RokuTrail)
                        local v97 = {
                            ["Width"] = math.random(100, 200) / 100,
                            ["Color"] = ColorSequence.new(v95),
                            ["Duration"] = math.random(300, 600) / 1000,
                            ["Amplitude"] = math.random(-100, 100),
                            ["Speed"] = math.random(150, 400),
                            ["Direction"] = v75.CFrame.LookVector
                        }
                        local v98 = v75.Position
                        local v99 = math.random(-40, 40) / 10
                        local v100 = math.random(-40, 40) / 10
                        local v101 = math.random(-40, 40) / 10
                        v97.Position = v98 + Vector3.new(v99, v100, v101)
                        v96(v97)
                    end
                    local v102 = script.glass:Clone()
                    v102.Size = Vector3.new(15, 15, 20)
                    v102.CFrame = v75.CFrame * CFrame.new(0, 0, -10)
                    local v103 = Instance.new("Highlight")
                    v103.Enabled = false
                    v103.Parent = v102
                    v102.Parent = workspace.Effects
                    _G.tween(v102, {
                        0.1,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1,
                        ["Size"] = Vector3.new(25, 25, 80),
                        ["CFrame"] = v75.CFrame * CFrame.new(0, 0, -40)
                    })
                    _G.destroy(v102, 0.1)
                    task.wait(u6:NextNumber(0.02, 0.05))
                    if os.clock() - v91 >= 0.8 then
                        _G.PlaySound(p15.PrimaryPart, script.blast)
                        _G.tween(v31, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Brightness"] = 0,
                            ["Range"] = v31.Range * 1.3
                        })
                        _G.destroy(v31, 0.25)
                        _G.customEmit(u76.Bp2)
                        _G.customEmit(v75.ShotParticles)
                        local v104 = script.glass:Clone()
                        v104.Size = Vector3.new(45, 45, 40)
                        v104.CFrame = v75.CFrame * CFrame.new(0, 0, -20)
                        local v105 = Instance.new("Highlight")
                        v105.Enabled = false
                        v105.Parent = v104
                        v104.Parent = workspace.Effects
                        _G.tween(v104, {
                            0.25,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1,
                            ["Size"] = Vector3.new(0, 0, 120),
                            ["CFrame"] = v75.CFrame * CFrame.new(0, 0, -60)
                        })
                        _G.destroy(v104, 0.25)
                        for _ = 1, 18 do
                            local v106 = Color3.fromRGB(85, 255, 255)
                            if math.random(1, 2) == 1 then
                                v106 = Color3.fromRGB(241, 87, 255)
                            end
                            local v107 = require(script.RokuTrail)
                            local v108 = {
                                ["Width"] = math.random(100, 200) / 100,
                                ["Color"] = ColorSequence.new(v106),
                                ["Duration"] = math.random(600, 1000) / 1000,
                                ["Amplitude"] = math.random(-150, 150),
                                ["Speed"] = math.random(300, 400),
                                ["Direction"] = v75.CFrame.LookVector
                            }
                            local v109 = v75.Position
                            local v110 = math.random(-40, 40) / 10
                            local v111 = math.random(-40, 40) / 10
                            local v112 = math.random(-40, 40) / 10
                            v108.Position = v109 + Vector3.new(v110, v111, v112)
                            v107(v108)
                        end
                        _G.PlayEffect("RockAngle", nil, {
                            ["CFrame"] = v75.CFrame,
                            ["Width"] = 2,
                            ["Angle"] = 7,
                            ["StartSize"] = Vector3.new(),
                            ["EndSize"] = Vector3.new(3, 3, 3),
                            ["Length"] = 100,
                            ["PartDuration"] = 3
                        })
                        local v113 = {}
                        for _, u114 in pairs(v75:GetDescendants()) do
                            if u114:IsA("Beam") then
                                local v115 = u5:Create(u114, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                                    ["CurveSize0"] = 0,
                                    ["CurveSize1"] = 0,
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                })
                                v115:Play()
                                pcall(function() --[[ Line: 502 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u5
                                        [2] = u114
                                    --]]
                                    u5:Create(u114.Attachment0, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                                        ["WorldCFrame"] = u114.Attachment1.WorldCFrame
                                    }):Play()
                                end)
                                table.insert(v113, v115)
                            end
                        end
                        for _, v116 in pairs(v82:GetDescendants()) do
                            if v116:IsA("ParticleEmitter") then
                                v116.Enabled = false
                            end
                        end
                        for _, v117 in pairs(v113) do
                            v117:Destroy()
                        end
                        task.wait(0.15)
                        if v89 then
                            for _, v118 in pairs(v89:GetDescendants()) do
                                if v118:IsA("ParticleEmitter") then
                                    v118.Enabled = false
                                end
                            end
                            _G.customEmit(v89.Attachment3.Smoke2)
                        end
                        for _, v119 in pairs(v75:GetDescendants()) do
                            if v119:IsA("ParticleEmitter") then
                                v119.Enabled = false
                            end
                        end
                        for _, v120 in pairs(u76:GetDescendants()) do
                            if v120:IsA("ParticleEmitter") then
                                v120.Enabled = false
                            end
                        end
                        if v29 then
                            for _, v121 in pairs(v29:GetDescendants()) do
                                if v121:IsA("ParticleEmitter") then
                                    v121.Enabled = false
                                end
                            end
                        end
                        u13 = nil
                        if v28 == true then
                            u5:Create(u17, TweenInfo.new(0.5), {
                                ["FieldOfView"] = 70
                            }):Play()
                        end
                        task.wait(5)
                        v74:Destroy()
                        u26:Destroy()
                        goto l25
                    end
                end
            end
        end
    else
        ::l25::
        return
    end
end
return v4