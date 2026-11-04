 

local u1 = _G.Ess.Tween
local u2 = _G.Emit
local u3 = require(script.CreateGroundSideRocks)
local u4 = require(script.CreateImpactFrames)
require(script.CreateGroundRock)
local u5 = game:GetService("RunService")
local u57 = {
    ["SendProjectile"] = function(p6, u7, p8, u9, u10) --[[ Name: SendProjectile, Line 12 ]]
        --[[
        Upvalues:
            [1] = u57
            [2] = u3
            [3] = u5
        --]]
        local u11 = Random.new()
        local u12 = p6.PrimaryPart
        local _ = p6.Humanoid
        local u13 = p8 / 200
        local u14 = u7 * CFrame.new(0, 0, -p8)
        local u15 = u10.UltWave:Clone()
        for _, v16 in u15.Attachment:GetChildren() do
            v16.Acceleration = u7.LookVector * -v16.Acceleration.Z
        end
        u15.CFrame = u7 * CFrame.new(0, 0, -4)
        u15.Parent = workspace.Effects
        _G.PlaySound(u15, script["Audio/BuddhaDivineRetributionShoot"]).Parent = u15
        u57.PunchWave(u7, u10)
        tick()
        local u17 = tick()
        local u18 = tick()
        local u19 = 0
        local u20 = u3.Settings
        local u21 = u15.Position
        local u22 = nil
        u22 = u5.Heartbeat:Connect(function(p23) --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u20
                [3] = u22
                [4] = u19
                [5] = u13
                [6] = u7
                [7] = u14
                [8] = u21
                [9] = u9
                [10] = u57
                [11] = u12
                [12] = u10
                [13] = u17
                [14] = u18
                [15] = u3
                [16] = u11
            --]]
            local v24 = workspace
            local v25 = u15.Position
            local v26 = -u20.Height
            local v27 = v24:Raycast(v25, Vector3.new(0, v26, 0), _G.RaycastParams)
            local v28
            if v27 then
                local v29 = v27.Distance
                v28 = Vector3.new(0, v29, 0)
            else
                v28 = Vector3.new(0, 0, 0)
            end
            if u22 and u15 then
                u19 = u19 + p23
                local v30 = u19 / u13
                local v31 = math.min(v30, 1)
                local v32 = u7:Lerp(u14, v31)
                u15.CFrame = v32 * CFrame.fromEulerAnglesXYZ(0, 0, v31 * 10)
                local v33 = Ray.new(u21, (u15.Position - u21).Unit * (u21 - u15.Position).Magnitude)
                local v34, _, _ = _G.raycastWhitelist(v33, u9)
                if v34 then
                    u22:Disconnect()
                    u15:Destroy()
                    u57.Explode(u15.CFrame, (u12.Position - u15.Position).Magnitude, u10)
                    return
                end
                u21 = u15.Position
                if v27 and u17 - u18 > u20.Rate then
                    u3.Create(v32 * CFrame.new(0, -(v28.Y + 3.4), 0), u20.Offset, CFrame.fromEulerAnglesYXZ(u11:NextNumber(0.1, 0.25), u11:NextNumber(-0.1, 0.1), u11:NextNumber(0.25, 0.35) * 0), u11:NextNumber(1.8, 2.1) * u20.ScaleMult, 0.7)
                    u18 = tick()
                end
            end
            u17 = tick()
        end)
        task.delay(u13, function() --[[ Line: 92 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u15
                [3] = u57
                [4] = u12
                [5] = u10
            --]]
            if u22 and u22.Connected then
                u22:Disconnect()
                u15:Destroy()
                u57.Explode(CFrame.new(u15.Position), (u12.Position - u15.Position).Magnitude, u10)
            end
        end)
    end,
    ["PunchWave"] = function(p35, p36) --[[ Name: PunchWave, Line 104 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v37 = p36.PunchWind:Clone()
        v37:PivotTo(p35 * CFrame.new(0, 0, -12))
        local v38 = v37.Mesh
        v38.Scale = v38.Scale * 0.5
        v37.Parent = workspace.Effects
        u2(v37.Attachment, true)
        u1(v37.Mesh, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Scale"] = v37.Mesh.Scale * 3,
            ["Offset"] = Vector3.new(0, 12, 0)
        })
        u1(v37.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {
            ["Transparency"] = 1
        })
        task.delay(1.5, v37.Destroy, v37)
        local v39 = p36.Punch2:Clone()
        v39:PivotTo(p35)
        v39.Parent = workspace.Effects
        u1(v39.Smoke.Mesh, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
            ["Scale"] = Vector3.new(45, -25, 45)
        })
        u1(v39.Smoke.Mesh, TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
            ["Offset"] = Vector3.new(0, 35, 0)
        })
        u1(v39.Smoke.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
            ["Transparency"] = 1
        })
        u1(v39.wave.Mesh, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
            ["Scale"] = Vector3.new(45, -75, 45)
        })
        u1(v39.wave.Mesh, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
            ["Offset"] = Vector3.new(0, 40, 0)
        })
        u1(v39.wave.Decal, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), {
            ["Transparency"] = 1
        })
        task.delay(1, v39.Destroy, v39)
    end,
    ["Explode"] = function(p40, p41, p42) --[[ Name: Explode, Line 168 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u2
        --]]
        local v43 = p42.PT2:Clone()
        local v44 = p42.Crack:Clone()
        local v45 = { v44.impact2, v44.impact1 }
        local v46 = CFrame.new(p40.Position)
        local v47 = p42.FF:Clone()
        v47:PivotTo(v46)
        v47.Parent = workspace.Effects
        local u48 = v43.FF
        v43.Parent = workspace.Effects
        u48:PivotTo(v46)
        u48.Parent = workspace.Effects
        _G.PlaySound(u48.PrimaryPart, script["Audio/BuddhaDivineRetributionBoom"])
        if (workspace.CurrentCamera.CFrame.Position - v46.Position).Magnitude <= 700 then
            u4.Release(p41)
        end
        local v49 = workspace:Raycast(u48.PrimaryPart.Position + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), _G.RaycastParams)
        if v49 then
            local v50 = CFrame.new(v49.Position, v49.Position + v49.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
            for _, v51 in v45 do
                v51.Transparency = 0
                task.delay(3, u1, v51, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                })
            end
            v44.Parent = workspace.Effects
            v44:PivotTo(v50 + Vector3.new(0, 1, 0))
            _G.destroy(v44, 6)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 45,
                ["Position"] = v50.Position + Vector3.new(0, 15, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 3,
                ["TweenDuration"] = 2,
                ["Radius"] = 85,
                ["Direction"] = Vector3.new(0, -125, 0)
            })
            u48.Explosion.Explosion.Rock.Color = ColorSequence.new(v49.Instance.Color)
        end
        u2(u48.Shines:GetDescendants(), true)
        u2(u48.Explosion:GetDescendants(), true)
        u1(v47.Ball, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
            ["Transparency"] = 1,
            ["Size"] = v47.Ball.Size * 15
        })
        u1(v47.ForceField, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
            ["Transparency"] = 1,
            ["Size"] = v47.ForceField.Size * 25
        })
        u1(u48.Explosion.PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
            ["Brightness"] = 0
        })
        task.spawn(function() --[[ Line: 242 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u48
            --]]
            for _ = 1, 3 do
                u2(u48.Shines:GetDescendants(), true)
                task.wait(0.012)
            end
        end)
        for _, v52 in v43:GetChildren() do
            if v52:IsA("BasePart") and v52:FindFirstChild("Mesh") then
                local v53 = v52:Clone()
                local v54 = v53.Mesh.Scale + Vector3.new(35, 15, 35)
                local v55 = v53.Mesh
                local v56 = v53.Mesh.Scale.Y
                v55.Scale = Vector3.new(0, v56, 0)
                v53:PivotTo(v46)
                v53.Parent = workspace.Effects
                if v53.Name == "Glow" then
                    u1(v53.Mesh, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                        ["Scale"] = v54 + Vector3.new(15, 0, 15)
                    })
                    u1(v53.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {
                        ["Transparency"] = 1
                    })
                elseif v53.Name == "Ring2" then
                    u1(v53.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                        ["Scale"] = v54
                    })
                    u1(v53.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.1), {
                        ["Transparency"] = 1
                    })
                elseif v53.Name == "Cone" then
                    u1(v53.Mesh, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {
                        ["Scale"] = v54
                    })
                    u1(v53.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), {
                        ["Transparency"] = 1
                    })
                else
                    u1(v53.Mesh, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
                        ["Scale"] = v54
                    })
                    u1(v53.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
                        ["Transparency"] = 1
                    })
                end
                task.delay(1.5, v53.Destroy, v53)
            end
        end
        task.wait(0.5)
        task.delay(0.4, v47.Destroy, v47)
        task.delay(8, u48.Destroy, u48)
        task.delay(8, v43.Destroy, v43)
    end
}
return u57