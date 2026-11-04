 

game:GetService("RunService")
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, p2, p3, p4) --[[ Name: start, Line 6 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            local v5 = p2.PrimaryPart or p2:WaitForChild("HumanoidRootPart")
            local u6 = script.Spin:Clone()
            u1.apply(u6, p2)
            u6.CFrame = p3 * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
            u6.Parent = workspace.Effects
            _G.tween(u6, {
                0.4,
                "Circular",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = p4 * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
            })
            local u7 = script.Welded:Clone()
            u1.apply(u7, p2)
            u7.CFrame = p3
            u7.Anchored = true
            _G.scaleParticle(u7, 0.75, true)
            _G.scaleParticle(u6, 0.75, true)
            u7.Parent = workspace.Effects
            _G.tween(u7, {
                0.4,
                "Circular",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = p4 * CFrame.new(0, 0, -8)
            })
            _G.PlaySound(p2.PrimaryPart, script.IceRapierThrust).Parent = p2.PrimaryPart
            task.spawn(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u7
                --]]
                _G.customEmit(u6.Emit)
                task.wait(0.3)
                u7.Anchored = true
                for _, v8 in ipairs(u7:GetDescendants()) do
                    if v8:IsA("ParticleEmitter") or v8:IsA("Trail") then
                        v8.Enabled = false
                    elseif v8:IsA("PointLight") then
                        _G.tween(v8, {
                            0.4,
                            "Quad",
                            Enum.EasingDirection.In,
                            0,
                            false,
                            0
                        }, {
                            ["Brightness"] = 0
                        })
                    end
                end
                _G.destroy(u7, 5)
                _G.customEmit(u6.Emit)
            end)
            task.delay(0.4, function() --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                for _, v9 in ipairs(u6:GetDescendants()) do
                    if v9:IsA("ParticleEmitter") or v9:IsA("Trail") then
                        v9.Enabled = false
                    elseif v9:IsA("PointLight") then
                        _G.tween(v9, {
                            0.4,
                            "Quad",
                            Enum.EasingDirection.In,
                            0,
                            false,
                            0
                        }, {
                            ["Brightness"] = 0
                        })
                    end
                end
                _G.destroy(u6, 5)
            end)
            local v10 = script.BeanWind:Clone()
            u1.apply(v10, p2)
            v10.CFrame = v5.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
            v10.Parent = workspace.Effects
            local v11 = (p3.Position - p4.Position).Magnitude
            _G.tween(v10.Mesh, {
                0.35,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 35, 0)
            })
            _G.tween(v10.Decal, {
                0.5,
                "Exponential",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(v10, {
                0.4,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v5.CFrame * CFrame.new(0, 0, -v11) * CFrame.Angles(-1.5707963267948966, 4.886921905584122, 0)
            })
            _G.destroy(v10, 1.5)
            local v12 = script.swirltwo:Clone()
            u1.apply(v12, p2)
            local v13 = v5.CFrame * CFrame.new(0, 0, -3)
            local v14 = CFrame.Angles
            local v15 = math.random(0, 180)
            v12.CFrame = v13 * v14(1.5707963267948966, math.rad(v15), 0)
            v12.Parent = workspace.Effects
            local v16 = _G.tween
            local v17 = {
                0.3,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v18 = {
                ["Size"] = Vector3.new(20, 0.5, 20)
            }
            local v19 = v5.CFrame * CFrame.new(0, 0, -3)
            local v20 = CFrame.Angles
            local v21 = math.random(0, 180)
            v18.CFrame = v19 * v20(1.5707963267948966, math.rad(v21), 0)
            v16(v12, v17, v18)
            _G.tween(v12, {
                0.2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v12, 0.5)
            local v22 = script["Meshes/WindSwirl2"]:Clone()
            u1.apply(v22, p2)
            v22.CFrame = v5.CFrame * CFrame.new(0, 0, -6) * CFrame.Angles(1.5707963267948966, 2.111848394913139, 0)
            v22.Parent = workspace.Effects
            local v23 = _G.tween
            local v24 = {
                0.3,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v25 = {
                ["Size"] = Vector3.new(20, 0.5, 20)
            }
            local v26 = v5.CFrame * CFrame.new(0, 0, -9)
            local v27 = CFrame.Angles
            local v28 = math.random(0, 180)
            v25.CFrame = v26 * v27(1.5707963267948966, math.rad(v28), 0)
            v23(v22, v24, v25)
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
            local v29 = script["Meshes/Rasengan Shockwave_Cylinder.002"]:Clone()
            u1.apply(v29, p2)
            local v30 = v5.CFrame * CFrame.new(0, 0, -6)
            local v31 = CFrame.Angles
            local v32 = math.random(0, 180)
            v29.CFrame = v30 * v31(1.5707963267948966, math.rad(v32), 0)
            v29.Parent = workspace.Effects
            local v33 = _G.tween
            local v34 = {
                0.35,
                "Back",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v35 = {
                ["Size"] = Vector3.new(0, 0, 0),
                ["Transparency"] = 1
            }
            local v36 = v5.CFrame * CFrame.new(0, 0, -(v11 / 1.5))
            local v37 = CFrame.Angles
            local v38 = math.random(0, 180)
            v35.CFrame = v36 * v37(1.5707963267948966, math.rad(v38), 0)
            v33(v29, v34, v35)
            _G.destroy(v29, 0.5)
            local v39 = script.MeshPart:Clone()
            u1.apply(v39, p2)
            v39.CFrame = v5.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)
            v39.Parent = workspace.Effects
            _G.tween(v39, {
                0.4,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(15, 30, 15),
                ["Transparency"] = 1,
                ["CFrame"] = v5.CFrame * CFrame.new(0, 0, -(v11 / 2)) * CFrame.Angles(1.5707963267948966, 4.1887902047863905, 0)
            })
            _G.destroy(v39, 1)
        end
    end
}