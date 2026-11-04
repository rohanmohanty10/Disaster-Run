 

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
function v2.start(_, p11, p12, p13, p14) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u1
    --]]
    if _G.checkRenderDistance(p12.Position) ~= false then
        local v15 = (p14 and script:FindFirstChild("ExplosionStage" .. p13) or script.Explosion):Clone()
        v15.CFrame = p12
        u10(v15, p13, p14)
        u1.apply(v15, p11)
        v15.Parent = workspace.Effects
        _G.PlaySound(v15, script.LockOn)
        _G.customEmit(v15)
        if p13 == 3 then
            _G.PlaySound(v15, script.RocketBoomMaxCharge)
        else
            _G.PlaySound(v15, script.RocketBoom)
        end
        _G.destroy(v15, 10)
        task.wait(0.25)
        _G.tween(v15.PointLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.InOut,
            0,
            true,
            0
        }, {
            ["Brightness"] = 45
        })
        if (v15.CFrame * CFrame.new(0, 0, -5).Position - workspace.CurrentCamera.CFrame.Position).Magnitude < 200 then
            local v16 = script.Bloom:Clone()
            v16.Parent = game:GetService("Lighting")
            _G.tween(v16, {
                0.1,
                "Quad",
                Enum.EasingDirection.InOut,
                0,
                true,
                0
            }, {
                ["Threshold"] = 0,
                ["Intensity"] = 4,
                ["Size"] = 100
            })
            _G.destroy(v16, 0.5)
            local v17 = script.Blur:Clone()
            v17.Parent = game:GetService("Lighting")
            _G.tween(v17, {
                0.5,
                "Quad",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["Size"] = 0
            })
            _G.destroy(v17, 1)
        end
        _G.shakenear(p12.Position, 750, 175, 150, -1)
        _G.PlayEffect("GroundRocks2", nil, p12, 20, 45, 9, 0.1, 5)
        local v18 = RaycastParams.new()
        v18.FilterType = Enum.RaycastFilterType.Whitelist
        v18.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        local v19 = workspace:Raycast(p12.Position + Vector3.new(0, 4, 0), CFrame.new(p12.Position + Vector3.new(0, 4, 0)).UpVector * Vector3.new(0, -25, 0), v18)
        if v19 then
            if v19.Instance then
                v15.Launch.Rocks.Color = ColorSequence.new(v19.Instance.Color)
            else
                v15.Launch.Rocks.Transparency = NumberSequence.new(1)
            end
            local u20 = script.scorch:Clone()
            u1.apply(u20, p11)
            local v21 = CFrame.new(v19.Position, v19.Position + v19.Normal)
            local v22 = CFrame.Angles
            local v23 = math.random(0, 360)
            u20.CFrame = v21 * v22(-1.5707963267948966, math.rad(v23), 0)
            u20.Parent = workspace.Effects
            _G.tween(u20, {
                0.1,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(125, 0.15, 125)
            })
            for _, v24 in ipairs(u20:GetDescendants()) do
                if v24:IsA("Decal") then
                    _G.tween(v24, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 0.35
                    })
                end
            end
            task.delay(3, function() --[[ Line: 110 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                for _, v25 in ipairs(u20:GetDescendants()) do
                    if v25:IsA("Decal") then
                        _G.tween(v25, {
                            2,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1
                        })
                    end
                end
            end)
            _G.destroy(u20, 6)
        end
        for _ = 1, 3 do
            local v26 = script.BeanWind:Clone()
            u1.apply(v26, p11)
            local v27 = CFrame.Angles
            local v28 = math.random(0, 180)
            local v29 = math.rad(v28)
            local v30 = math.random(0, 180)
            local v31 = math.rad(v30)
            local v32 = math.random(0, 180)
            v26.CFrame = p12 * v27(v29, v31, (math.rad(v32)))
            v26.Parent = workspace.Effects
            _G.tween(v26.Mesh, {
                0.6,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(35, 28, 35)
            })
            _G.tween(v26.Decal, {
                0.6,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v26, 0.6)
        end
        local v33 = script.BeanWind:Clone()
        u1.apply(v33, p11)
        v33.CFrame = p12
        v33.Parent = workspace.Effects
        _G.tween(v33, {
            0.6,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = p12 * CFrame.Angles(0, 2.181661564992912, 0)
        })
        _G.tween(v33.Mesh, {
            0.6,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(35, 28, 35)
        })
        _G.tween(v33.Decal, {
            0.6,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v33, 0.6)
    end
end
return v2