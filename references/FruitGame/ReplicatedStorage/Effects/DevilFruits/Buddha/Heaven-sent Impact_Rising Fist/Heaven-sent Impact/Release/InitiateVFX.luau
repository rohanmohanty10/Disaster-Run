 

local u1 = _G.Ess.Tween
local u2 = _G.Emit
local u3 = require(script.Bezier)
require(script.CreateGroundRock)
local u4 = game:GetService("RunService")
local u74 = {
    ["CreateTravel"] = function(u5, p6, p7, u8, u9, _, u10, u11) --[[ Name: CreateTravel, Line 11 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u4
            [4] = u74
        --]]
        local u12 = u5.PrimaryPart
        local u13 = u5.Humanoid.Animator
        local u14 = u5.RightHand
        local v15 = p6.Position
        local v16 = p7.Position
        local v17 = CFrame.new
        local v18 = v16.X
        local v19 = v15.Y
        local v20 = v16.Z
        local v21 = v17(v15, (Vector3.new(v18, v19, v20)))
        local u22, u23 = _G.Apply:Align(u5)
        u22.Enabled = false
        u23.CFrame = v21 * CFrame.Angles(-0.4363323129985824, 0, 0)
        local _ = u23.CFrame
        local u24 = tick()
        local v25 = p6:Lerp(p7, 0.5) + Vector3.new(0, 50, 0)
        local u26 = u3.new(v15, v25.Position, v16)
        local u27 = p6.Position
        local u28 = p6.Position
        local v29 = workspace:Raycast(u27, Vector3.new(0, -5, 0), _G.RaycastParams)
        if v29 then
            local v30 = CFrame.new(v15, v25.Position).LookVector
            local v31 = u11.Jump:Clone()
            v31.CFrame = CFrame.new(v29.Position) * v21.Rotation
            local v32 = v31.Main
            local v33 = v30.Y
            local v34 = -math.acos(v33)
            v32.Orientation = Vector3.new(v34, 0, 0)
            v31.Parent = workspace.Effects
            if v29.Instance then
                v31.Main.Rock.Color = ColorSequence.new(v29.Instance.Color)
            end
            u2(v31:GetDescendants(), true)
            task.delay(1.8, v31.Destroy, v31)
        end
        u5:SetAttribute("impactLeapLand", nil)
        local u35 = nil
        u35 = u4.Stepped:Connect(function() --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u8
                [3] = u9
                [4] = u27
                [5] = u26
                [6] = u12
                [7] = u23
                [8] = u28
                [9] = u35
                [10] = u22
                [11] = u14
                [12] = u5
                [13] = u13
                [14] = u74
                [15] = u11
                [16] = u10
            --]]
            local v36 = (tick() - u24) / u8
            game.TweenService:GetValue(v36, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local _ = u9 * v36
            u27 = u26:Get(v36)
            u12.Velocity = Vector3.new()
            u12:PivotTo(CFrame.new(u27) * u23.CFrame.Rotation)
            local v37 = workspace:Raycast(u12.Position, (u23.CFrame * CFrame.Angles(-0.7853981633974483, 0, 0)).LookVector * 18, _G.RaycastParams)
            u28 = u27
            if v37 and v36 > 0.35 then
                u35:Disconnect()
                u35 = nil
                u22.Enabled = true
                u22.Position = u27
                local v38 = CFrame.new(u14.Position, u14.Position + u12.CFrame.LookVector)
                u5:SetAttribute("impactLeapLand", true)
                u13:LoadAnimation(script.Anims.shockwave):Play()
                _G.PlaySound(v38, script.SFX["Audio/BuddhaHalfHeavenImpactLand"])
                u74.Wave(u5, v38, CFrame.new(v37.Position), v37, u11)
                if u10 then
                    u10:FireServer(CFrame.new(v37.Position))
                end
                task.wait(1)
                u23:Destroy()
                u22:Destroy()
            end
        end)
    end,
    ["Wave"] = function(_, p39, p40, u41, p42) --[[ Name: Wave, Line 104 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v43
        if p42 then
            v43 = u41
            u41 = p42
        else
            v43 = nil
        end
        local u44 = u41.DaiBall:Clone()
        u44:PivotTo(CFrame.new(p40.Position))
        u44.Parent = workspace.Effects
        local u45 = u41.Crack:Clone()
        u45.Position = p40.Position
        local v46 = u45.Attachment
        v46.Position = v46.Position + Vector3.new(0, 2, 0)
        u45.Parent = workspace.Effects
        local u47 = u41.Light:Clone()
        u47.Position = u45.Position + Vector3.new(0, 2, 0)
        u47.Parent = workspace.Effects
        local v48 = u41.PunchWind:Clone()
        v48:PivotTo(p39 * CFrame.Angles(-0.2617993877991494, 0, 0))
        local v49 = v48.Mesh
        v49.Scale = v49.Scale * 0.5
        v48.Parent = workspace.Effects
        local u50, u51, v52
        if v43 then
            u50 = v43.Instance
            u51 = v43.Position
            v52 = v43.Normal
        else
            u50 = nil
            u51 = nil
            v52 = nil
        end
        if u50 == nil then
            u50, u51, v52 = _G.getRayFloor(CFrame.new(u44:GetPivot().p), 150)
        end
        if u50 then
            u2(u44.Ball.Raycast, false)
            u45:PivotTo(CFrame.new(u51, u51 + v52) * CFrame.Angles(-1.5707963267948966, 0, 0))
        else
            u44.Ball.Raycast:Destroy()
            u45.Decal.Transparency = 1
        end
        u2(v48.Attachment, true)
        u2(u44.Ball:GetDescendants(), true)
        local u53 = u45.Size
        _G.tween(u44.ForceField.Mesh, {
            0.025,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            12,
            true,
            0.02
        }, {
            ["Scale"] = Vector3.new(1.3, 1.3, 1.3)
        })
        local u54 = _G.tween(u45, {
            0.025,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            12,
            true,
            0.02
        }, {
            ["Size"] = u45.Size * 1.25
        })
        if u50 then
            task.spawn(function() --[[ Line: 161 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u51
                    [3] = u1
                --]]
                for _ = 1, 6 do
                    task.wait(0.09)
                    local v55 = u41.Wave:Clone()
                    v55.Position = u51 + Vector3.new(0, 5, 0)
                    local v56 = v55.Orientation
                    local v57 = math.random(0, 360)
                    v55.Orientation = v56 + Vector3.new(0, v57, 0)
                    v55.Parent = workspace.Effects
                    u1(v55.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Scale"] = v55.Mesh.Scale + Vector3.new(12, 2, 12),
                        ["Offset"] = Vector3.new(0, -2, 0)
                    })
                    u1(v55.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0.2), {
                        ["Transparency"] = 1
                    })
                    task.delay(0.9, v55.Destroy, v55)
                end
            end)
        end
        u1(v48.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Scale"] = v48.Mesh.Scale * Vector3.new(3, 1, 3),
            ["Offset"] = Vector3.new(0, 2, 0)
        })
        u1(v48.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.1), {
            ["Transparency"] = 1
        })
        task.delay(0.8, function() --[[ Line: 210 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u54
                [3] = u45
                [4] = u53
                [5] = u1
                [6] = u47
                [7] = u50
                [8] = u2
                [9] = u41
                [10] = u51
            --]]
            u44.outterBall.Trails.Enabled = false
            if u54 and u54.Stop ~= nil then
                u54:Stop()
            end
            u45.Size = u53
            u1(u44.ForceField, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Transparency"] = 1,
                ["Size"] = u44.ForceField.Size * 3
            })
            u1(u44.Ball, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Transparency"] = 1,
                ["Size"] = u44.Ball.Size + Vector3.new(2, 2, 2)
            })
            u1(u45.Decal, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 1), {
                ["Transparency"] = 1
            })
            u1(u47.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 50
            })
            if u50 then
                u45.Attachment.Rock.Color = ColorSequence.new(u50.Color)
                u2(u45.Raycast, true)
                u2(u44.Ball.Raycast, false)
                local v58 = u41.Wave:Clone()
                v58.Decal.Transparency = 0.05
                v58.Position = u51 + Vector3.new(0, 15, 0)
                local v59 = v58.Mesh
                v59.Scale = v59.Scale + Vector3.new(0, 6, 0)
                local v60 = v58.Orientation
                local v61 = math.random(0, 360)
                v58.Orientation = v60 + Vector3.new(0, v61, 0)
                v58.Parent = workspace.Effects
                local v62 = u1
                local v63 = v58.Mesh
                local v64 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v65 = {
                    ["Scale"] = v58.Mesh.Scale + Vector3.new(18, 6, 18)
                }
                local v66 = -(v58.Mesh.Scale.Y + 8)
                v65.Offset = Vector3.new(0, v66, 0)
                v62(v63, v64, v65)
                u1(v58.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.15), {
                    ["Transparency"] = 1
                })
                u1(u45, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    ["Size"] = u45.Size * Vector3.new(2, 1, 2)
                })
                task.delay(0.9, v58.Destroy, v58)
                task.spawn(function() --[[ Line: 262 ]]
                    --[[
                    Upvalues:
                        [1] = u44
                    --]]
                    local v67 = (u44:GetScale() + 1) / 2
                    local v68 = v67 * 2.5
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 25,
                        ["Position"] = u44:GetPivot().Position + Vector3.new(0, 5, 0),
                        ["DistanceRandomness"] = Vector2.new(0.5, 1),
                        ["Duration"] = 3,
                        ["TweenDuration"] = 1,
                        ["Radius"] = 15 * v68,
                        ["Direction"] = Vector3.new(0, -35, 0)
                    })
                    for v69 = 1.5, 4 do
                        local v70 = v67 * (v69 / 5 + 0.75) ^ 1.25
                        local v71 = v67 ^ 2 / v70 / 1.5
                        math.clamp(v71, 0.7, 200)
                        local _ = 15 * v70 + v70
                        local v72 = task.wait
                        local v73 = v67 / 4
                        v72(math.clamp(v73, 0.15, 1) * 0.045)
                    end
                end)
            end
            u2(u45.Attachment, true)
            u2(u44.Ball.Attachment, false)
            task.delay(2, u44.Destroy, u44)
            task.delay(2.5, u45.Destroy, u45)
            task.delay(2, u47.Destroy, u47)
        end)
    end
}
return u74