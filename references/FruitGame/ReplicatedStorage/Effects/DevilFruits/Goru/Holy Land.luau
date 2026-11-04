 

local v1 = {}
local u2 = workspace.Effects
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u3.FilterType = Enum.RaycastFilterType.Include
local function u7(p4, p5) --[[ Line: 12 ]]
    for _, v6 in p4:GetDescendants() do
        if v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
    end
end
function v1.start(_, u8, p9, p10, p11) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u7
    --]]
    local u12 = {}
    local function v19(p13, p14, p15) --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u12
        --]]
        p13:PivotTo(u8[p14].CFrame)
        local v16 = Instance.new("Motor6D")
        v16.Part0 = u8[p14]
        v16.Part1 = p13:FindFirstChild("Circle.031") or p13:FindFirstChild("Circle.030") or (p13:FindFirstChild("Circle.029") or p13:FindFirstChild("Circle.032"))
        v16.C0 = p15
        v16.Parent = v16.Part1
        p13.Parent = workspace.Effects
        if p13:FindFirstChild(p14) then
            p13[p14]:Destroy()
        end
        local v17 = p13.AnimationController:LoadAnimation(script.cast)
        v17:Play(0)
        local v18 = u12
        table.insert(v18, v17)
    end
    local v20 = u8.Humanoid:LoadAnimation(script.cast)
    v20:Play(0)
    table.insert(u12, v20)
    local v21 = script.tend313:Clone()
    v19(v21, "RightLowerArm", CFrame.new(0.459, -1.315, -0.01))
    local v22 = script.tend31:Clone()
    v19(v22, "LeftLowerArm", CFrame.new(0.026, -1.315, -0.445) * CFrame.Angles(0, -1.5707963267948966, 0))
    local _, v23, v24 = _G.getRayFloor(p9, 15)
    local v25 = v23 + Vector3.new(0, 0.25, 0)
    local v26 = CFrame.new(v25, v25 + v24) * CFrame.Angles(1.5707963267948966, 0, 0)
    local v27 = script.ChargeFloor:Clone()
    v27.Parent = workspace.Effects
    v27.CFrame = v26
    _G.PlaySound(u8.PrimaryPart, script["Audio/GoldSplashStart"])
    local v28 = v26.Position
    local v29 = workspace:Raycast(v28, Vector3.new(0, -10, 0), u3)
    if v29 then
        for _, v30 in v27.color:GetChildren() do
            v30.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v29.Instance.Color), ColorSequenceKeypoint.new(1, v29.Instance.Color) })
        end
    else
        v27:Destroy()
    end
    task.delay(0.1, function() --[[ Line: 81 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        local v31 = script.Hold.Emit:Clone()
        v31.Parent = u8.RightHand
        local v32 = script.Hold.Emit:Clone()
        v32.Parent = u8.LeftHand
        task.wait(0.9)
        _G.particleEnabled(v31, false)
        _G.destroy(v31, 3)
        _G.particleEnabled(v32, false)
        _G.destroy(v32, 3)
    end)
    task.wait(0.9)
    local v33 = script["Audio/GoldSplash"]:Clone()
    v33.Parent = u8.PrimaryPart
    v33:Play()
    _G.PlaySound(u8.PrimaryPart, script.GoldSplashLaunch)
    local v34 = script.Transition:Clone()
    v34.CFrame = v26
    v34.Parent = u2
    _G.destroy(v34, 4)
    _G.customEmit(v34)
    _G.particleEnabled(v27, false)
    _G.destroy(v27, 2.3)
    v21:Destroy()
    v22:Destroy()
    local u35 = script.tend312:Clone()
    v19(u35, "RightLowerArm", CFrame.new(0.241, -2.283, 0.02) * CFrame.Angles(0, 3.141592653589793, 0))
    _G.destroy(u35, p10 + 1)
    local u36 = script.tend314:Clone()
    v19(u36, "LeftLowerArm", CFrame.new(-0.191, -2.399, -0.02) * CFrame.Angles(0, -3.141592653589793, 0))
    _G.destroy(u36, p10 + 1)
    local v37 = script.Blast:Clone()
    v37.CFrame = p9
    v37.Parent = u2
    local v38 = script.Appear:Clone()
    v38.CFrame = v26
    v38.Parent = u2
    _G.customEmit(v38)
    _G.destroy(v38, 3)
    local v39 = script.MoreWind:Clone()
    v39.CFrame = v26
    v39.Parent = u2
    _G.destroy(v39, 2.3)
    _G.tween(v39.Decal, {
        0.15,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v39.Mesh, {
        0.15,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Scale"] = v39.Mesh.Scale * 3
    })
    local v40 = script.GroundEffectsemit:Clone()
    v40.CFrame = v26
    v40.Parent = u2
    _G.destroy(v40, 4)
    _G.customEmit(v40)
    local v41 = p9.Position
    local v42 = workspace:Raycast(v41, Vector3.new(0, -45, 0), u3)
    if v42 then
        _G.recolorParticles(v38, v42.Instance.Color)
    end
    local v43 = script.Floor:Clone()
    v43.CFrame = v26 * CFrame.Angles(3.141592653589793, 0, 0)
    v43.Parent = u2
    _G.customEmit(v43)
    local v44 = 2.5 * p11
    for _, v45 in v43:GetDescendants() do
        if v45:IsA("ParticleEmitter") then
            local v46 = {}
            for _, v47 in pairs(v45.Size.Keypoints) do
                local v48 = NumberSequenceKeypoint.new
                local v49 = v47.Time
                local v50 = v47.Value * v44
                local v51 = v47.Envelope * v44
                table.insert(v46, v48(v49, v50, v51))
            end
            _G.tween(v45, {
                2.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Size"] = NumberSequence.new(v46)
            })
        end
    end
    local v52 = _G.tween
    local v53 = {
        2.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }
    local v54 = {}
    local v55 = v43.Size.X * v44
    local v56 = v43.Size.Y
    local v57 = v43.Size.Z * v44
    v54.Size = Vector3.new(v55, v56, v57)
    v52(v43, v53, v54)
    local u58 = {}
    task.delay(0.3, function() --[[ Line: 181 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u36
            [3] = u35
            [4] = u58
        --]]
        for v59 = 1, #u12 do
            u12[v59]:AdjustSpeed(0)
        end
        for _, v60 in script.FadeAura:GetChildren() do
            local v61 = v60:Clone()
            v61.Parent = u36:FindFirstChild("Circle.031")
            local v62 = v60:Clone()
            v62.Parent = u35:FindFirstChild("Circle.032")
            local v63 = u58
            table.insert(v63, v61)
            local v64 = u58
            table.insert(v64, v62)
        end
        for _, v65 in u58 do
            if v65:IsA("ParticleEmitter") then
                _G.tween(v65, {
                    2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, {
                    ["Rate"] = 35
                })
            end
        end
    end)
    task.wait(p10)
    _G.tween(u36:FindFirstChild("Circle.031"), {
        0.2,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    _G.tween(u35:FindFirstChild("Circle.032"), {
        0.2,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    for _, v66 in u58 do
        if v66:IsA("ParticleEmitter") then
            _G.tween(v66, {
                0.2,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Rate"] = 0
            })
        end
    end
    _G.tween(v33, {
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Volume"] = 0
    })
    _G.destroy(v33, 0.5)
    _G.PlaySound(u8.PrimaryPart, script["Audio/GoldSplashEnd"])
    task.wait(0.35)
    for v67 = 1, #u12 do
        u12[v67]:Stop(0.2)
    end
    _G.tween(v43.PointLight, {
        0.75,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Brightness"] = 0
    })
    u7(v43, false)
    _G.destroy(v43, 2.5)
    u7(v37, false)
    _G.destroy(v37, 2.3)
    task.wait(0.25)
    local v68 = script.MoreWind:Clone()
    v68.CFrame = v26
    v68.Parent = u2
    _G.destroy(v68, 2.3)
    _G.tween(v68.Decal, {
        0.15,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v68.Mesh, {
        0.15,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Scale"] = v68.Mesh.Scale * 3
    })
end
return v1