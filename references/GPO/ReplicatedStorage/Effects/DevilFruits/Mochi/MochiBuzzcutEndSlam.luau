 

local v1 = {}
local u2 = require(script.LightningBolt)
function v1.start(_, u3, u4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u4.Position) then
        if (workspace.CurrentCamera.CFrame.Position - u4.Position).Magnitude < 250 then
            local v5 = script.ColorCorrection:Clone()
            v5.Parent = workspace.CurrentCamera
            _G.destroy(v5, 1)
            _G.tween(v5, {
                0.1255,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["Contrast"] = 0,
                ["Enabled"] = false
            })
        end
        _G.PlaySound(u3.HumanoidRootPart, script.ExplodeA)
        _G.PlaySound(u3.HumanoidRootPart, script.PhoExplode)
        local v6 = script.MoSlam:Clone()
        v6:PivotTo(u4)
        v6.Parent = workspace.Effects
        _G.destroy(v6, 5)
        local v7 = {
            0.32,
            "Linear",
            Enum.EasingDirection.InOut,
            0,
            false,
            0
        }
        local v8 = {
            0.923,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v9 = {
            0.235,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        _G.tween(v6.SwirlA, {
            1.8,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
            ["Size"] = Vector3.new(110, 110, 16),
            ["Transparency"] = 1
        })
        _G.tween(v6.SwirlB, {
            1.5,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.SwirlB.CFrame * CFrame.Angles(0, 0, 3.13),
            ["Size"] = Vector3.new(115, 115, 12),
            ["Transparency"] = 1
        })
        _G.tween(v6.TravelSwirl, {
            1.1,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(60, 14, 12),
            ["Transparency"] = 1,
            ["CFrame"] = v6.TravelSwirl.CFrame * CFrame.new(-28, 0, 0) * CFrame.Angles(-3.13, 0, 0)
        })
        _G.tween(v6.SwirlLinger, {
            1.1,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(75, 25, 75),
            ["Transparency"] = 1,
            ["CFrame"] = v6.SwirlLinger.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 3.13, 0)
        })
        _G.tween(v6.Ring, v9, {
            ["Size"] = Vector3.new(90, 0, 90),
            ["Transparency"] = 1,
            ["CFrame"] = v6.Ring.CFrame * CFrame.new(0, 20, 0)
        })
        _G.tween(v6.tornado1, v8, {
            ["Size"] = Vector3.new(20, 30, 20),
            ["Transparency"] = 1,
            ["CFrame"] = v6.tornado1.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, 3.13, 0)
        })
        _G.tween(v6.Spike, {
            0.29,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(1, 100, 1),
            ["Transparency"] = 1,
            ["CFrame"] = v6.Spike.CFrame * CFrame.new(0, 55, 0)
        })
        _G.tween(v6.Tornado, v7, {
            ["Size"] = Vector3.new(130, 20, 130),
            ["Transparency"] = 1,
            ["CFrame"] = v6.Tornado.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(0, 3.13, 0)
        })
        _G.tween(v6.AirLines, v9, {
            ["Size"] = Vector3.new(2, 85, 100),
            ["Transparency"] = 1,
            ["CFrame"] = v6.AirLines.CFrame * CFrame.new(-25, 0, 0),
            ["Color"] = Color3.new(1, 0.298039, 0.309804)
        })
        _G.tween(v6.SwooshA.Mesh, v9, {
            ["Scale"] = Vector3.new(25, 123, 26)
        })
        _G.tween(v6.SwooshA, {
            0.2,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.SwooshA.CFrame * CFrame.Angles(0, 3.13, 0)
        })
        _G.tween(v6.SwooshA.Decal, {
            0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(v6.Radius.Mesh, v9, {
            ["Scale"] = Vector3.new(150, 0, 150)
        })
        _G.tween(v6.Radius.Decal, v9, {
            ["Transparency"] = 1
        })
        _G.tween(v6.root.Attachment.PointLight, {
            0.25,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 60,
            ["Brightness"] = 0
        })
        local v10 = script.invert:Clone()
        v10.CFrame = CFrame.new(v6.root.CFrame.Position)
        v10.Parent = workspace.Effects
        _G.tween(v10, {
            0.5,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(150, 150, 150),
            ["Transparency"] = 1
        })
        _G.destroy(v10, 0.5)
        local v11 = RaycastParams.new()
        v11.FilterType = Enum.RaycastFilterType.Whitelist
        v11.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        local v12 = workspace:Raycast(u4.Position + Vector3.new(0, 5, 0), Vector3.new(0, -25, 0), v11)
        if v12 then
            v6.root.Attachment.Rocks.Color = ColorSequence.new(v12.Instance.Color)
            v6.root.Attachment.sm2.Color = v6.root.Attachment.Rocks.Color
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 25,
                ["Position"] = v6.PrimaryPart.Position + Vector3.new(0, 5, 0),
                ["DistanceRandomness"] = Vector2.new(0.3, 1),
                ["Duration"] = 6,
                ["TweenDuration"] = 3,
                ["Radius"] = 45,
                ["Direction"] = Vector3.new(0, -35, 0)
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 16,
                ["RandomVelocityMagnitude"] = Vector2.new(-55, 55),
                ["Position"] = v6.PrimaryPart.Position,
                ["Direction"] = Vector3.new(0, 125, 0),
                ["RaycastDirection"] = Vector3.new(0, -5, 0),
                ["Size"] = Vector3.new(3.3000002, 4.4, 3.3000002),
                ["TrailEnabled"] = true
            })
        else
            v6.root.Attachment.Rocks:Destroy()
            v6.root.Attachment.sm2:Destroy()
        end
        local u13 = v6.LightningParticles:GetChildren()
        v6.LightningParticles.Size = Vector3.new(65, 16, 65)
        for _, v14 in u13 do
            v14:Emit(4)
        end
        local u15 = {}
        local v16 = u4.Position + Vector3.new(0, 1, 0)
        local v17 = u4.upVector
        u15.WorldPosition = v16
        u15.WorldAxis = v17
        task.delay(0.39, function() --[[ Line: 150 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u4
                [3] = u2
                [4] = u15
                [5] = u3
            --]]
            for _ = 1, 2 do
                for _, v18 in u13 do
                    v18:Emit(1)
                end
                for v19 = 0, 6.2, 1.25 do
                    local v20 = {}
                    local v21 = u4 * CFrame.Angles(0, v19, 0) * CFrame.new(v19 * 16 + 65, v19 * 8 + 65, 0)
                    local v22 = v21.Position
                    local v23 = v21.upVector
                    v20.WorldPosition = v22
                    v20.WorldAxis = v23
                    local v24 = u2.new(u15, v20, 5)
                    v24.MinRadius = 4.7
                    v24.MaxRadius = 12.1
                    v24.Frequency = 14
                    v24.AnimationSpeed = 6
                    v24.Thickness = 5
                    v24.MinThicknessMultiplier = 0.4
                    v24.MaxThicknessMultiplier = 1
                    v24.ContractFrom = 0.52
                    v24.PulseSpeed = Random.new():NextNumber(7.5, 12)
                    v24.PulseLength = 1
                    v24.FadeLength = 0.46
                    v24.Color = Color3.new(0.164706, 0, 0)
                    v24.ColorOffsetSpeed = 16
                    v24.OuterColor = Color3.new(1, 0, 0.0156863)
                end
                _G.PlaySound(u3.HumanoidRootPart, script.Lightning)
                task.wait(0.18)
            end
        end)
        _G.customEmit(v6.root)
        if u3:FindFirstChild("MochiArmNew") then
            _G.destroy(u3.MochiArmNew, 1)
        end
        local v25 = u3:FindFirstChild("mArm")
        if v25 then
            v25:Destroy()
        end
    end
end
return v1