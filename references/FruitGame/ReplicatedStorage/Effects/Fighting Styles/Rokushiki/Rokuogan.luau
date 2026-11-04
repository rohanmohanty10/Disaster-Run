 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local u2 = _G.getEffect("Shockwave2")
local u3 = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.BeamRing]
function v1.start(_, p4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local u5 = p4.cf1
    local v6 = p4.cf
    if _G.checkRenderDistance(v6.Position) ~= false then
        local u7 = v6 * CFrame.new(0, 0, -1.5)
        local u8 = script.Part:Clone()
        u8.Parent = workspace.Effects
        u8.CFrame = u7
        u8.Mesh.Scale = Vector3.new(0, 0, 0)
        u8.sfx:Play()
        u8.Attachment.ParticleEmitter.Enabled = true
        u8.Color = BrickColor.new("Medium blue").Color
        u8.PointLight.Enabled = true
        _G.tween(u8.PointLight, {
            0.2,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            -1,
            true,
            0
        }, {
            ["Color"] = Color3.fromRGB(6, 222, 255)
        })
        _G.tween(u8, {
            0.1,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            -1,
            true,
            0
        }, {
            ["Color"] = script.Model.Center.Color
        })
        task.spawn(function() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
            --]]
            for _ = 1, 20 do
                game["Run Service"].RenderStepped:Wait()
                if u8.Parent == nil then
                    break
                end
                local v9 = script.Part:Clone()
                v9.Parent = workspace.Effects
                v9.CFrame = u7 * CFrame.new(math.random(-700, 700) / 100, math.random(-700, 700) / 100, math.random(-700, 700) / 100)
                v9.CFrame = CFrame.new(v9.Position, u7.Position)
                local v10 = math.random(50, 100) / 100
                v9.Mesh.Scale = Vector3.new(v10, v10, v10)
                _G.destroy(v9, 0.25)
                local v11 = script.Model.Center.Color
                v9.Color = script.Model.Center.Color
                if math.random(1, 2) == 1 then
                    v11 = BrickColor.new("Bright blue").Color
                end
                u8.Mesh.Scale = u8.Mesh.Scale + Vector3.new(0.015, 0.015, 0.015)
                _G.tween(v9, {
                    0.25,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = v11,
                    ["CFrame"] = CFrame.new(u7.Position, v9.Position)
                })
                _G.tween(v9.Mesh, {
                    0.25,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
            end
        end)
        task.wait(0.65)
        _G.tween(u8.PointLight, {
            0.25,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 0
        })
        _G.tween(u8.Mesh, {
            0.25,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u8, 0.25)
        task.wait(0.25)
        local v12 = script.Model:Clone()
        v12.Parent = workspace.Effects
        v12:PivotTo(u5 * CFrame.new(0, -v12.Center.Size.Y / 2 - 3, 0) * CFrame.Angles(3.141592653589793, 0, 0))
        local v13 = Enum.EasingStyle.Sine
        _G.tween(v12.Center.Mesh, {
            0.5,
            v13,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(0, 1, 0)
        })
        v12.Part.Attachment.ParticleEmitter:Emit(50)
        local v14 = v12:GetChildren()
        local v15 = v12.Center.Size.X
        for v16 = 1, #v14 do
            if v14[v16]:FindFirstChild("Beam") then
                v14[v16].Beam.LightEmission = 0.5
                v14[v16].Beam.ZOffset = 0.15
                v14[v16].Beam.TextureSpeed = 15
                v14[v16].Beam.TextureLength = 5
                v14[v16].Beam.Color = ColorSequence.new(Color3.fromRGB(6, 222, 255))
                v14[v16].Beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.5, 0, 0), NumberSequenceKeypoint.new(1, 0, 0) })
                _G.tween(v14[v16].Beam, {
                    0.5,
                    v13,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
                local v17 = _G.tween
                local v18 = v14[v16].A1
                local v19 = {
                    0.5,
                    v13,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v20 = {}
                local v21 = -v15 / 2
                v20.Position = Vector3.new(0, v21, 0)
                v17(v18, v19, v20)
                local v22 = _G.tween
                local v23 = v14[v16].Attachment
                local v24 = {
                    0.5,
                    v13,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v25 = {}
                local v26 = -v15 / 2
                local v27 = v14[v16].Attachment.Position.Z
                v25.Position = Vector3.new(0, v26, v27)
                v22(v23, v24, v25)
            end
        end
        local u28 = Instance.new("NumberValue")
        u28.Value = 0
        u28.Parent = game.ReplicatedStorage
        for v29 = 1, 3 do
            local v30 = 6 - v29 * 15
            local u31 = script.BeamRing:Clone()
            u31.Parent = workspace.Effects
            local v32 = math.random(50, 100) / 100
            local v33 = v30 / 2 * 1.3333333333333333 * 0.41421356237309503
            local v34 = v30 / 2
            local v35 = Vector3.new(0, 0, v34)
            local v36 = -v30 / 2
            local v37 = Vector3.new(v36, 0, 0)
            local v38 = -v30 / 2
            local v39 = Vector3.new(0, 0, v38)
            u31.Beam.CurveSize0 = 0
            u31.Beam.CurveSize1 = 0
            u31.Beam.Width0 = v32
            u31.Beam.Width1 = v32
            u31.Beam2.CurveSize0 = 0
            u31.Beam2.CurveSize1 = 0
            u31.Beam2.Width0 = v32
            u31.Beam2.Width1 = v32
            u31.CFrame = v6 * CFrame.new(0, (3 - v29) * 4, 0)
            local v40 = math.random(-360, 360)
            u31.Orientation = Vector3.new(0, v40, 0)
            _G.tween(u31.A1, {
                0.25,
                v13,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v35
            })
            _G.tween(u31.A2, {
                0.25,
                v13,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v37
            })
            _G.tween(u31.A3, {
                0.25,
                v13,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v39
            })
            _G.tween(u31.Beam, {
                0.25,
                v13,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v33,
                ["CurveSize1"] = v33
            })
            _G.tween(u31.Beam2, {
                0.25,
                v13,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v33,
                ["CurveSize1"] = v33
            })
            _G.tween(u31, {
                2,
                v13,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Orientation"] = u31.Orientation + Vector3.new(0, 360, 0)
            })
            u28.Changed:Connect(function() --[[ Line: 114 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u31
                --]]
                pcall(function() --[[ Line: 115 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u31
                    --]]
                    local v41 = u28.Value
                    u31.Beam.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1, 0),
                        NumberSequenceKeypoint.new(0.2, 1, 0),
                        NumberSequenceKeypoint.new(0.3, v41, 0),
                        NumberSequenceKeypoint.new(1, v41, 0)
                    })
                    u31.Beam2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, v41, 0), NumberSequenceKeypoint.new(0.75, 1, 0), NumberSequenceKeypoint.new(1, 1, 0) })
                end)
            end)
            _G.destroy(u31, 2)
        end
        _G.tween(u28, {
            2,
            v13,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Value"] = 1
        })
        _G.destroy(u28, 2)
        _G.destroy(v12, 2)
        u2:start(CFrame.new(v6.Position), CFrame.new(v6.Position), BrickColor.new("White"), Vector3.new(75, 0, 75), Vector3.new(0, 1, 0), 0.2, -1, Enum.EasingStyle.Quad, Color3.fromRGB(0, 0, 0), Enum.Material.Neon, "Rings")
        task.spawn(function() --[[ Line: 128 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u3
                [3] = u2
            --]]
            for v42 = 1, 10 do
                local v43 = u5 * CFrame.new(0, -(v42 * 5) - 3, 0)
                local v44 = CFrame.Angles
                local v45 = math.random(-360, 360)
                local v46 = v43 * v44(math.rad(v45), 0, 0)
                local v47 = v42 / 5 * 10
                local v48 = u3
                local v49 = {
                    ["le"] = 1,
                    ["color"] = ColorSequence.new(Color3.fromRGB(6, 222, 255)),
                    ["rot"] = "x"
                }
                local v50 = u5 * CFrame.new(0, -(v42 * 5) - 3, 0)
                local v51 = CFrame.Angles
                local v52 = math.random(-360, 360)
                v49.cf = v50 * v51(0, math.rad(v52), 0)
                v49.ti = 0
                v49.ti2 = 0.5
                v49.dam = v47 * 1.5
                v48:start(v49)
                local v53 = u2
                local v54 = CFrame.Angles
                local v55 = math.random(-360, 360)
                v53:start(v46, v46 * v54(0, math.rad(v55), 0), BrickColor.new("White"), Vector3.new(v47, 0, v47), Vector3.new(0, 10, 0), 0.25, -1, Enum.EasingStyle.Quad, Color3.fromRGB(140, 91, 159), Enum.Material.Neon, "shockwave")
            end
        end)
    end
end
return v1