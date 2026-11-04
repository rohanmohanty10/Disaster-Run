 

local u1 = script
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
game:GetService("TweenService")
require(v2.Modules.EffectsUtil)
local u4 = {
    ["victimShockwaveAttach"] = 1.2333333333333334,
    ["slash"] = 1.2333333333333334,
    ["block"] = 0.08333333333333333,
    ["shockwaveRing"] = 1.1666666666666667,
    ["boneBreak"] = 0.5833333333333334
}
function weldPosition(u5, u6, u7)
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3.Heartbeat:Connect(function(_) --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u7
            [3] = u6
        --]]
        local v8 = u5.CFrame * u7
        local v9 = u6.CFrame
        u6.CFrame = CFrame.new(v8.X, v8.Y, v8.Z, select(4, v9:components()))
    end)
end
return {
    ["start"] = function(_, p10, u11, u12) --[[ Name: start, Line 29 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u3
        --]]
        if _G.checkRenderDistance(p10.PrimaryPart.Position) ~= false then
            local u13 = p10.HumanoidRootPart
            local u14 = u11.HumanoidRootPart
            _G.PlaySound(u13, script.DragonCounterSholderThrow)
            task.delay(u4.boneBreak, function() --[[ Line: 38 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                local v15 = script.BoneParticle:Clone()
                v15.Parent = workspace.Effects
                v15.CFrame = u13.CFrame * CFrame.new(1.53529549, 1.99998856, -1.04731369, 1, 0, 3.38810594e-21, 5.78033302e-28, 1, -1.70606626e-7, -3.38810594e-21, 1.70606626e-7, 1)
                v15.Attachment.ParticleEmitter:Emit(1)
                _G.destroy(v15, 2)
            end)
            task.delay(u4.victimShockwaveAttach, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u13
                    [3] = u1
                    [4] = u3
                    [5] = u11
                    [6] = u14
                --]]
                local v16 = script.Rush:Clone()
                if not u12 then
                    v16.Decal.Color3 = Color3.fromRGB(0, 0, 0)
                end
                v16.Parent = workspace.Effects
                v16.CFrame = u13.CFrame * CFrame.new(0.550294876, -0.150001526, 4.83768463, 0, -3.38810594e-21, 1, -1, 1.70606626e-7, 5.78033302e-28, -1.70606626e-7, -1, -3.38810594e-21)
                _G.tween(v16, { 0.3, "Quad", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v16.CFrame * CFrame.new(0, -3, 0)
                })
                _G.tween(v16.Mesh, { 0.5, "Quad", Enum.EasingDirection.Out }, {
                    ["Scale"] = v16.Mesh.Scale + Vector3.new(2, 25, 2)
                })
                _G.tween(v16.Decal, { 0.15, "Quad", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v16, 1)
                local u17 = {
                    ["Shockwave1"] = CFrame.new(0, 0, 2.14361763),
                    ["Shockwave3"] = CFrame.new(0, 0, 3.15401459),
                    ["Shockwave2"] = CFrame.new(0, 0, 3.26227379),
                    ["Shockwave4"] = CFrame.new(0, 0, 2)
                }
                for u18 = 1, 4 do
                    task.spawn(function() --[[ Line: 65 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u18
                            [3] = u17
                            [4] = u3
                            [5] = u11
                            [6] = u14
                            [7] = u12
                        --]]
                        local v19 = u18
                        local u20 = u1["Shockwave" .. tostring(v19)]:Clone()
                        local u21 = u17[u20.Name]
                        u20.Parent = workspace.Effects
                        local u22 = math.random(0, 180)
                        local u23 = 0
                        local u24 = math.random(-25, 25)
                        local v32 = u3.Heartbeat:Connect(function(p25) --[[ Line: 72 ]]
                            --[[
                            Upvalues:
                                [1] = u23
                                [2] = u11
                                [3] = u14
                                [4] = u20
                                [5] = u21
                                [6] = u22
                                [7] = u24
                            --]]
                            u23 = u23 + p25
                            if u11:findFirstChild("LowerTorso") then
                                local v26 = u14.Position - u11.LowerTorso.Position
                                local v27 = u20
                                local v28 = (u14.CFrame - v26) * u21 * CFrame.Angles(1.5707963267948966, 0, 0)
                                local v29 = CFrame.Angles
                                local v30 = u23
                                local v31 = u22 + math.sin(v30) * u24
                                v27.CFrame = v28 * v29(0, math.rad(v31), 0)
                            end
                        end)
                        u20.Decal.Transparency = 1
                        if u18 == 4 then
                            _G.tween(u20.Decal, { 0.1, "Quad", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0.7
                            })
                            _G.tween(u20.Mesh, { 1, "Quad", Enum.EasingDirection.Out }, {
                                ["Scale"] = u20.Mesh.Scale + Vector3.new(0.25, 3, 0.25),
                                ["Offset"] = Vector3.new(0, -2, 0)
                            })
                            task.wait()
                            _G.tween(u20.Decal, { 0.3, "Quad", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 1
                            })
                        else
                            if not u12 then
                                u20.Decal.Color3 = Color3.fromRGB(5000, 5000, 5000)
                            end
                            _G.tween(u20.Decal, { 0.2, "Quad", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0
                            })
                            _G.tween(u20.Mesh, { 1, "Quad", Enum.EasingDirection.Out }, {
                                ["Scale"] = u20.Mesh.Scale + Vector3.new(0, 4, 0),
                                ["Offset"] = Vector3.new(0, 0.5, 0)
                            })
                            task.wait()
                            _G.tween(u20.Decal, { u18 / 4 + 0.3, "Quad", Enum.EasingDirection.In }, {
                                ["Transparency"] = 1
                            })
                        end
                        task.wait(2)
                        v32:Disconnect()
                        u20:Destroy()
                    end)
                end
            end)
            task.delay(u4.slash, function() --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u12
                    [3] = u13
                --]]
                local v33 = CFrame.Angles(0, 1.5707963267948966, 0)
                local v34 = CFrame.new(1.46191025, 0.393941402, 2.68483543, -0.704414904, -0.707107902, -0.0616285019, 0.704417109, -0.707105756, 0.0616278648, -0.0871554092, -5.84496604e-7, 0.99619472)
                local v35 = u1.Slash:Clone()
                if not u12 then
                    v35.Decal.Color3 = Color3.fromRGB(5000, 5000, 5000)
                end
                v35.Parent = workspace.Effects
                v35.CFrame = u13.CFrame * v34 * v33
                local v36 = CFrame.new(1.46195984, 0.393986702, 2.685009, 0.122778237, -0.707046747, -0.696426988, -0.122833833, -0.70716691, 0.696295142, -0.984803259, 0.000054908618, -0.173673972)
                local v37 = u1.Wind:Clone()
                v37.Parent = workspace.Effects
                v37.CFrame = u13.CFrame * v36 * v33
                _G.destroy(v37, 2)
                _G.destroy(v35, 2)
                _G.tween(v35, { 0.4, "Quint", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v35.CFrame * CFrame.Angles(0, -1.9198621771937625, 0)
                })
                _G.tween(v37, { 1, "Cubic", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v37.CFrame * CFrame.Angles(0, -2.443460952792061, 0)
                })
                _G.tween(v35.Decal, { 0.3, "Sine", Enum.EasingDirection.In }, {
                    ["Transparency"] = 1
                })
                _G.tween(v37.Decal, { 0.8, "Sine", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.tween(v35.Mesh, { 0.6, "Sine", Enum.EasingDirection.Out }, {
                    ["Scale"] = v35.Mesh.Scale + Vector3.new(0.03, 1, 0.03)
                })
                _G.tween(v37.Mesh, { 0.8, "Cubic", Enum.EasingDirection.Out }, {
                    ["Scale"] = v37.Mesh.Scale + Vector3.new(1.25, -1, 1.25)
                })
            end)
            task.delay(u4.block, function() --[[ Line: 131 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u13
                --]]
                local v38 = CFrame.new(0.335283279, 0.399985075, -1.39735508, 1, 0, 3.38810594e-21, 5.78033302e-28, 1, -1.70606626e-7, -3.38810594e-21, 1.70606626e-7, 1)
                local v39 = u1.Block:Clone()
                v39.Parent = workspace.Effects
                v39.CFrame = u13.CFrame * v38
                v39.Attachment.ParticleEmitter:Emit(5)
                _G.destroy(v39, 3)
            end)
            task.delay(u4.shockwaveRing, function() --[[ Line: 140 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u13
                --]]
                local v40 = CFrame.new(0.549957275, -0.150016069, 5.33802223, -3.38810594e-21, -0.499998391, 0.866026342, 1.42108547e-14, 0.866026342, 0.499998391, -1, 0, 7.10542736e-15)
                local v41 = u1.Ring:Clone()
                v41.Parent = workspace.Effects
                v41.CFrame = u13.CFrame * v40
                local v42 = v41.Mesh
                v42.Scale = v42.Scale * 0.3
                _G.tween(v41.Mesh, { 0.6, "Quint", Enum.EasingDirection.Out }, {
                    ["Scale"] = v41.Mesh.Scale * 3.5
                })
                _G.tween(v41.Decal, { 0.5, "Sine", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v41, 1)
            end)
        end
    end
}