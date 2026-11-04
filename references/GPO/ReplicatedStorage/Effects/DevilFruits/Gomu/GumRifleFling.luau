 

local v1 = {}
local u2 = game:GetService("RunService").Heartbeat
function v1.start(_, p3, p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.HumanoidRootPart.Position) ~= false then
        local v5 = p3.HumanoidRootPart.CFrame
        _G.PlaySound(p3.HumanoidRootPart, script.Bazooka)
        _G.PlaySound(p3.HumanoidRootPart, script.Woosh)
        local u6 = script.bazooka:Clone()
        u6:PivotTo(v5)
        u6.Parent = workspace.Effects
        _G.tween(u6.WaveLeft, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(30.6, 0.1, 5.3),
            ["CFrame"] = u6.WaveLeft.CFrame * CFrame.new(-7, 0, 1),
            ["Transparency"] = 1
        })
        _G.tween(u6.WaveRight, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(30.6, 0.1, 5.3),
            ["CFrame"] = u6.WaveRight.CFrame * CFrame.new(-7, 0, 1),
            ["Transparency"] = 1
        })
        _G.tween(u6.Ring, {
            0.8,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u6.Ring.CFrame * CFrame.new(0, 11, 0),
            ["Size"] = Vector3.new(25, 0.25, 25),
            ["Transparency"] = 1
        })
        _G.tween(u6.Ring2, {
            0.9,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u6.Ring2.CFrame * CFrame.new(0, -11, 0),
            ["Size"] = Vector3.new(17, 0.15, 17),
            ["Transparency"] = 1
        })
        _G.tween(u6.Sharp, {
            0.5,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u6.Sharp.CFrame * CFrame.new(0, -25, 0),
            ["Size"] = Vector3.new(6, 60, 6),
            ["Transparency"] = 1
        })
        _G.tween(u6.SwirlLinger, {
            1.8,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u6.SwirlLinger.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, -1.51, 0),
            ["Size"] = Vector3.new(15, 40, 15),
            ["Transparency"] = 1
        })
        _G.destroy(u6, 4)
        local v7 = Ray.new(p3.HumanoidRootPart.CFrame.Position, p3.HumanoidRootPart.CFrame.upVector * -10)
        local v8, _, _ = _G.raycastWhitelist(v7, { workspace.Islands, workspace.Ships, workspace.Env })
        if v8 then
            u6.root.Attachment.sm2.Color = ColorSequence.new(v8.Color)
            _G.customEmit(u6.root)
        end
        spawn(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u2
            --]]
            local v9 = u6.SwooshA
            local v10 = u6.SwooshB
            for v11 = 0, 1.2, 0.1 do
                v9.Mesh.Scale = v9.Mesh.Scale + Vector3.new(0.2, 0.2, 0.2)
                v10.Mesh.Scale = v9.Mesh.Scale + Vector3.new(1, 1, 1)
                v9.Decal.Transparency = v11 - 0.15
                v10.Decal.Transparency = v11 - 0.15
                v9.CFrame = v9.CFrame * CFrame.Angles(0, -0.6, 0)
                v10.CFrame = v10.CFrame * CFrame.Angles(0, 0.4, 0)
                u2:Wait()
            end
        end)
        local v12 = script.Model:Clone()
        v12:PivotTo(v5 * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v12.Center.Size.Y / 2 - 3, 0))
        v12.Parent = workspace.Effects
        local v13 = Enum.EasingStyle.Sine
        _G.tween(v12.Center.Mesh, {
            0.25,
            v13,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(0, 2, 0),
            ["Offset"] = Vector3.new(0, -20, 0)
        })
        _G.customEmit(v12.Part)
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
                    0.25,
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
                    0.25,
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
                    0.25,
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
        _G.destroy(v12, 0.25)
        local u28 = v5 * CFrame.Angles(1.5707963267948966, 0, 0)
        task.spawn(function() --[[ Line: 88 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u2
            --]]
            local u29 = script.pistol:Clone()
            u29:PivotTo(u28 * CFrame.Angles(-1.5707963267948966, 0, 0))
            u29.Parent = workspace.Effects
            _G.tween(u29.Ring, {
                0.4,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u29.Ring.CFrame * CFrame.new(0, -9, 0),
                ["Size"] = Vector3.new(14, 0, 14),
                ["Transparency"] = 1
            })
            _G.tween(u29.Sharp, {
                0.2,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u29.Sharp.CFrame * CFrame.new(-75, 0, 0),
                ["Size"] = Vector3.new(150, 0, 0),
                ["Transparency"] = 1
            })
            _G.tween(u29.Shock, {
                0.1,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u29.Shock.CFrame * CFrame.new(75, 0, 0),
                ["Size"] = Vector3.new(150, 9, 9),
                ["Transparency"] = 1
            })
            _G.destroy(u29, 5)
            spawn(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u2
                --]]
                local v30 = u29.SwooshA
                local v31 = u29.SwooshB
                for v32 = 0, 1, 0.1 do
                    v30.Mesh.Scale = v30.Mesh.Scale + Vector3.new(0.2, 0.2, 0.2)
                    v31.Mesh.Scale = v30.Mesh.Scale + Vector3.new(1, 1, 1)
                    v30.Decal.Transparency = v32
                    v31.Decal.Transparency = v32
                    v30.CFrame = v30.CFrame * CFrame.Angles(0, 0.6, 0)
                    v31.CFrame = v31.CFrame * CFrame.Angles(0, -0.4, 0)
                    u2:Wait()
                end
            end)
        end)
        local v33 = u28
        for v34 = 1, 7.5 do
            local v35 = v33 * CFrame.new(0, v34 * -3.75, 0)
            local v36 = 1 - v34 / 7.5
            _G.PlayEffect("Shockwave2", nil, v35 * CFrame.new(0, v34 * 4.75, 0), v35, BrickColor.new("White"), Vector3.new(25, 1, 25) * v36, Vector3.new(6.25, 1, 6.25) * v36, 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(110, 153, 202), Enum.Material.Neon, "Rings")
            u28 = v33 * CFrame.new(0, v34 * -7.5, 0)
            v33 = u28
        end
        _G.PlayEffect("meshShock", nil, v5, 25, 0.5)
        local v37 = script.Part:Clone()
        v37.CFrame = v5 * CFrame.new(0, 0, -3.5)
        v37.Parent = workspace.Effects
        _G.customEmit(v37)
        _G.PlayEffect("RockFollow", nil, v37, 1.75, 2.25)
        _G.destroy(v37, 3)
        local v38 = tick()
        repeat
            game["Run Service"].RenderStepped:Wait()
            v37.CFrame = CFrame.new(p4.Position, v5.Position) * CFrame.Angles(3.141592653589793, 0, 0)
        until tick() - v38 >= 0.75
    end
end
return v1