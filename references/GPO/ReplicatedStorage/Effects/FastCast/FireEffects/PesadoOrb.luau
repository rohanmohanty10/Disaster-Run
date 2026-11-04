
local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
require(game.ReplicatedStorage.Modules.sBeat)
local function u7(p3, u4) --[[ Line: 7 ]]
    local u5 = p3:GetDescendants()
    for u6 = 1, #u5 do
        pcall(function() --[[ Line: 10 ]]
           
            u5[u6].Enabled = u4
        end)
    end
end
function v1.impact(p8, p9, u10, p11, _) 
    
    _G.destroy(p8, 2)
    u7(p8, false)
    local u12 = script.Explosion:Clone()
    u12.CFrame = CFrame.new(u10, u10 + p11)
    u12.Parent = workspace.Effects
    _G.destroy(u12, 10)
    _G.customEmit(u12.partone)
    task.wait(0.02)
    _G.customEmit(u12.parttwo)
    task.spawn(function() --[[ Line: 43 ]]
        
        _G.shakenear(u10, 150, 75, 100, -2)
    end)
    _G.PlaySound(u12, script.ex1)
    task.wait(0.4)
    _G.customEmit(u12.partthree)
    task.wait(0.1)
    task.wait(0.65)
    _G.PlaySound(u12, script.ex2)
    task.spawn(function() --[[ Line: 55 ]]
        
        local v13 = game.Players.LocalPlayer.Character
        if v13 and (v13:FindFirstChild("HumanoidRootPart") and ((u12.Position - v13.HumanoidRootPart.Position).Magnitude <= 75 and (u12.CFrame:inverse() * v13.HumanoidRootPart.CFrame).Z < 0)) then
            local v14 = script.Lighting.PesadoCC:Clone()
            local v15 = script.Lighting.pesadoblur:Clone()
            v14.Parent = game.Lighting
            v15.Parent = game.Lighting
            _G.destroy(v14, 3)
            _G.destroy(v15, 3)
            _G.tween(v14, {
                0.2,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0.2,
                ["Contrast"] = 1,
                ["Saturation"] = -1
            })
            _G.tween(v15, {
                0.3,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = 9
            })
            task.wait(0.2)
            _G.tween(v14, {
                0.3,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Contrast"] = -0.45
            })
            task.wait(1)
            _G.tween(v14, {
                1,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0,
                ["Contrast"] = 0,
                ["Saturation"] = 0
            })
            _G.tween(v15, {
                1,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = 0
            })
        end
    end)
    _G.tween(u12.PointLight, {
        0.25,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Range"] = 120,
        ["Brightness"] = 0
    })
    task.spawn(function() --[[ Line: 77 ]]
        
        for _ = 1, 20 do
            local v16 = math.random(0, 360)
            local _ = math.random(100, 200) / 100
            local v17 = u12.CFrame
            local v18 = CFrame.Angles
            local v19 = math.random(-360, 360)
            local v20 = math.rad(v19)
            local v21 = math.random(-360, 360)
            local v22 = math.rad(v21)
            local v23 = math.random(-360, 360)
            local v24 = v17 * v18(v20, v22, (math.rad(v23))) * CFrame.new(0, 0, math.random(10, 15))
            local v25 = Instance.new("Attachment", workspace.Terrain)
            _G.destroy(v25, 5)
            if typeof(v24) == "CFrame" then
                v25.WorldCFrame = v24
            end
            if typeof(v24) == "Vector3" then
                v25.Position = v24
            end
            local v26 = v24 * CFrame.Angles(math.rad(v16), math.rad(v16), (math.rad(v16)))
            local v27 = v24 * CFrame.Angles(math.rad(v16), math.rad(v16), (math.rad(v16)))
            local v28 = Instance.new("Attachment", workspace.Terrain)
            _G.destroy(v28, 5)
            if typeof(v27) == "CFrame" then
                v28.WorldCFrame = v27
            end
            if typeof(v27) == "Vector3" then
                v28.Position = v27
            end
            local _ = math.random(250, 750) / 1000
            local v29 = math.random(750, 1100) / 10
            _G.tween(v28, {
                math.random(200, 1000) / 1000,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["WorldCFrame"] = v26 * CFrame.new(0, v29, 0)
            })
            local v30 = u2.new(v25, v28, 15)
            local v31 = math.random(-50, 50)
            v30.CurveSize0 = 0
            v30.CurveSize1 = v31
            v30.PulseSpeed = math.random(4, 10)
            v30.AnimationSpeed = math.random(6, 20)
            v30.PulseLength = math.random(3, 8)
            v30.FadeLength = math.random(100, 500) / 1000
            v30.Thickness = math.random(100, 400) / 100
            v30.Color = Color3.fromRGB(148, 121, 255)
            v30.Frequency = math.random(1, 25) / 50
            v30.MinThicknessMultiplier = 0.1
            v30.MaxThicknessMultiplier = 1
            v30.MinRadius = 0
            v30.MaxRadius = math.random(30, 70)
            v30.ContractFrom = 0.1
        end
    end)
    u12.final["35"].Color = ColorSequence.new(p9.Color)
    _G.customEmit(u12.final)
    _G.PlayEffect("GroundRocks2", nil, CFrame.new(u12.CFrame.p), 35, 65, 6, 0.1, 5)
    local v32 = script.Part:Clone()
    v32.Material = Enum.Material.ForceField
    v32.Anchored = true
    v32.Color = Color3.fromRGB(0, 0, 0)
    v32.CFrame = u12.CFrame
    v32.Parent = workspace.Effects
    v32.Mesh.Scale = Vector3.new(75, 75, 75)
    _G.tween(v32.Mesh, {
        0.3,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = Vector3.new(150, 150, 150)
    })
    _G.tween(v32, {
        0.3,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.destroy(v32, 0.3)
    local v33 = script.invert:Clone()
    v33.CFrame = u12.CFrame
    v33.Size = Vector3.new(100, 100, 100)
    v33.Parent = workspace.Effects
    _G.tween(v33, {
        0.35,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = Vector3.new(200, 200, 200),
        ["Transparency"] = 1
    })
    _G.destroy(v33, 0.35)
    local v34 = u12.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 5, 0)
    _G.PlayEffect("Shockwave2", nil, v34 * CFrame.new(0, -5, 0), v34, BrickColor.new("White"), Vector3.new(187.5, 7.5, 187.5), Vector3.new(62.5, 2.5, 62.5), 0.5, 0, Enum.EasingStyle.Quad, Color3.fromRGB(0, 0, 0), Enum.Material.Neon, "Rings")
    _G.PlayEffect("meshShock", nil, u12.CFrame, 175, 2)
    _G.shakenear(v33.Position, 175, 120, 175, -0.8)
end
local u35 = {}
function v1.move(p36, p37) --[[ Line: 162 ]]
    --[[
    Upvalues:
        [1] = u35
        [2] = u2
    --]]
    if _G.checkRenderDistance(p37.Position) == false then
        return
    else
        if u35[p36] == nil then
            u35[p36] = { p37, CFrame.new() }
        end
        local v38 = u35[p36][1]
        if (v38.p - p37.p).magnitude > 5 then
            local _ = math.random(100, 200) / 100
            local v39 = p36.CFrame
            local v40 = Instance.new("Attachment", workspace.Terrain)
            _G.destroy(v40, 5)
            if p36 then
                v40.Parent = p36
            elseif typeof(v39) == "CFrame" then
                v40.WorldCFrame = v39
            end
            if typeof(v39) == "Vector3" then
                v40.Position = v39
            end
            local v41 = s
            local v42 = Instance.new("Attachment", workspace.Terrain)
            _G.destroy(v42, 5)
            if typeof(v41) == "CFrame" then
                v42.WorldCFrame = v41
            end
            if typeof(v41) == "Vector3" then
                v42.Position = v41
            end
            local _ = math.random(250, 750) / 1000
            v42.WorldCFrame = v39 * CFrame.new(math.random(-300, 300) / 100, math.random(-200, 200) / 100, 0)
            local v43 = u2.new(v40, v42, 25)
            v43.CurveSize0 = 0
            v43.CurveSize1 = 0
            v43.PulseSpeed = math.random(15, 50)
            v43.AnimationSpeed = math.random(15, 20)
            v43.PulseLength = math.random(1, 3)
            v43.FadeLength = 0.1
            v43.Thickness = math.random(100, 400) / 500
            v43.Color = Color3.fromRGB(148, 121, 255)
            v43.Frequency = math.random(10, 50) / 100
            v43.MinThicknessMultiplier = 0.1
            v43.MaxThicknessMultiplier = 1
            v43.MinRadius = 0
            v43.MaxRadius = math.random(5, 10)
            v43.ContractFrom = 0.5
            if (u35[p36][2].p - p37.p).magnitude >= 60 then
                local v44 = p37 * CFrame.Angles(0, 0, 1.5707963267948966)
                u35[p36][2] = v44
            end
            local v45 = script.Part2:Clone()
            local v46 = (v38.p - p37.p).magnitude
            v45.Mesh.Scale = Vector3.new(0, v46, 0)
            v45.CFrame = CFrame.new(v38.p, p37.p) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v46 / 2, 0)
            v45.Mesh.Scale = Vector3.new(1, v46, 1)
            v45.Parent = workspace.Effects
            _G.tween(v45.Mesh, {
                0.25,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, v46, 0)
            })
            _G.destroy(v45, 0.25)
            u35[p36][1] = p37
        end
    end
end
function v1.splash(p47, _) --[[ Line: 226 ]]
    local v48 = p47:GetDescendants()
    for v49 = 1, #v48 do
        if v48[v49]:IsA("ParticleEmitter") then
            v48[v49].Enabled = false
        end
    end
    _G.destroy(p47, 2)
    p47.Parent = workspace.Effects
    Instance.new("BoolValue", p47).Name = "FinishHit"
end
function v1.Fire(_, _, p50) --[[ Line: 240 ]]
    p50.throw:Play()
    _G.PlayEffect("FloorTrail", nil, p50, nil, Color3.fromRGB(213, 104, 14), Color3.fromRGB(0, 0, 0), 1, 0.25, 15)
end
return v1