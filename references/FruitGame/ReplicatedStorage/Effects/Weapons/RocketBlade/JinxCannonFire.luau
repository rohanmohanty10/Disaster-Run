 

game:GetService("RunService")
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local u3 = { Color3.new(1, 1, 1), Color3.new(1, 0.580392, 0.101961), Color3.new(1, 0.196078, 0.0745098) }
local u4 = { Color3.new(1, 1, 1), Color3.new(0.54902, 0.556863, 1), Color3.new(0.333333, 0.333333, 1) }
local function u10(p5, p6, p7) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v8 = u3
    if p7 == true then
        v8 = u4
    end
    p5.Color = v8[p6]
    for _, v9 in ipairs(p5:GetDescendants()) do
        if v9:GetAttribute("CanColor") == true then
            if v9:IsA("Trail") or v9:IsA("ParticleEmitter") then
                v9.Color = ColorSequence.new(v8[p6])
            else
                v9.Color = v8[p6]
            end
        end
    end
end
function v2.start(_, p11) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u1
    --]]
    local v12 = p11.fireCFrame
    local v13 = p11.victim
    local v14 = p11.stage
    local v15 = p11.totalTime
    local v16 = p11.pres
    local v17 = p11.char
    if _G.checkRenderDistance(v12.Position, 5000) ~= false then
        if v13 then
            local v18 = script.LockonTarget:Clone()
            v18.CFrame = v13
            v18.Parent = workspace.Effects
            u10(v18, v14, v16)
            u1.apply(v18, v17)
            _G.customEmit(v18)
            _G.destroy(v18, 1)
            task.wait(0.2)
        end
        if (v12 * CFrame.new(0, 0, -5).Position - workspace.CurrentCamera.CFrame.Position).Magnitude < 50 then
            local v19 = script.Bloom:Clone()
            v19.Parent = game:GetService("Lighting")
            _G.tween(v19, {
                0.1,
                "Quad",
                Enum.EasingDirection.InOut,
                0,
                true,
                0
            }, {
                ["Intensity"] = 1.15,
                ["Size"] = 100
            })
            _G.destroy(v19, 0.5)
        end
        local v20 = (v16 and script:FindFirstChild("FireStage" .. v14) or script.Fire):Clone()
        v20.CFrame = v12 * CFrame.new(0, 0, -8)
        v20.Parent = workspace.Effects
        u10(v20, v14, v16)
        u1.apply(v20, v17)
        _G.tween(v20.SurfaceLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        _G.customEmit(v20)
        _G.destroy(v20, 5)
        local v21 = script.BeanWind:Clone()
        u1.apply(v21, v17)
        v21.CFrame = v12 * CFrame.new(0, 0, -5) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
        v21.Parent = workspace.Effects
        _G.tween(v21.Mesh, {
            1.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(4, 60, 4)
        })
        _G.tween(v21.Decal, {
            1.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(v21, {
            1.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v12 * CFrame.new(0, 0, -20) * CFrame.Angles(-1.5707963267948966, 2.181661564992912, 0)
        })
        _G.destroy(v21, 1.5)
        local v22 = script.swirltwo:Clone()
        local v23 = v12 * CFrame.new(0, 0, -3)
        local v24 = CFrame.Angles
        local v25 = math.random(0, 180)
        v22.CFrame = v23 * v24(1.5707963267948966, math.rad(v25), 0)
        v22.Parent = workspace.Effects
        u10(v22, v14, v16)
        u1.apply(v22, v17)
        local v26 = _G.tween
        local v27 = {
            0.3,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v28 = {
            ["Size"] = Vector3.new(20, 0.5, 20)
        }
        local v29 = v12 * CFrame.new(0, 0, -3)
        local v30 = CFrame.Angles
        local v31 = math.random(0, 180)
        v28.CFrame = v29 * v30(1.5707963267948966, math.rad(v31), 0)
        v26(v22, v27, v28)
        _G.tween(v22, {
            0.2,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v22, 0.5)
        local v32 = script["Meshes/WindSwirl2"]:Clone()
        local v33 = v12 * CFrame.new(0, 0, -6)
        local v34 = CFrame.Angles
        local v35 = math.random(0, 180)
        v32.CFrame = v33 * v34(1.5707963267948966, math.rad(v35), 0)
        v32.Parent = workspace.Effects
        u10(v32, v14, v16)
        u1.apply(v32, v17)
        local v36 = _G.tween
        local v37 = {
            0.3,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v38 = {
            ["Size"] = Vector3.new(20, 0.5, 20)
        }
        local v39 = v12 * CFrame.new(0, 0, -9)
        local v40 = CFrame.Angles
        local v41 = math.random(0, 180)
        v38.CFrame = v39 * v40(1.5707963267948966, math.rad(v41), 0)
        v36(v32, v37, v38)
        _G.tween(v32, {
            0.2,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v32, 0.5)
        local v42 = script["Meshes/Rasengan Shockwave_Cylinder.002"]:Clone()
        local v43 = v12 * CFrame.new(0, 0, -6)
        local v44 = CFrame.Angles
        local v45 = math.random(0, 180)
        v42.CFrame = v43 * v44(1.5707963267948966, math.rad(v45), 0)
        v42.Parent = workspace.Effects
        u10(v42, v14, v16)
        u1.apply(v42, v17)
        local v46 = _G.tween
        local v47 = {
            0.35,
            "Back",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v48 = {
            ["Size"] = Vector3.new(0, 30, 0)
        }
        local v49 = v12 * CFrame.new(0, 0, -10)
        local v50 = CFrame.Angles
        local v51 = math.random(0, 180)
        v48.CFrame = v49 * v50(1.5707963267948966, math.rad(v51), 0)
        v46(v42, v47, v48)
        _G.destroy(v42, 0.5)
        local v52 = script.MeshPart:Clone()
        v52.CFrame = v12 * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)
        v52.Parent = workspace.Effects
        u10(v52, v14, v16)
        u1.apply(v52, v17)
        _G.tween(v52, {
            1,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(15, 30, 15),
            ["Transparency"] = 1,
            ["CFrame"] = v12 * CFrame.new(0, 0, -20) * CFrame.Angles(1.5707963267948966, 2.181661564992912, 0)
        })
        _G.destroy(v52, 1)
        local v53 = (v16 and script:FindFirstChild("ProjectileStage" .. v14) or script.Projectile):Clone()
        v53.CFrame = v12 * CFrame.new(0, 0, -4)
        v53.Parent = workspace.Effects
        u10(v53, v14, v16)
        u1.apply(v53, v17)
        if v14 == 3 then
            _G.PlaySound(v12, script.RocketShootMaxCharge)
        else
            _G.PlaySound(v12, script.RocketShoot)
        end
        v53.RocketFlight:Play()
        _G.tween(v53, {
            v15,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v13
        })
        task.wait(v15)
        v53.Transparency = 1
        for _, v54 in ipairs(v53:GetDescendants()) do
            if v54:IsA("ParticleEmitter") then
                v54.Enabled = false
            end
        end
        _G.tween(v53.RocketFlight, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        v53.PointLight:Destroy()
        _G.destroy(v53, 4)
    end
end
return v2