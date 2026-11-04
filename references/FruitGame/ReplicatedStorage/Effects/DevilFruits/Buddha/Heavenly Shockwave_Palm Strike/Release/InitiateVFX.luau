 

local u1 = _G.Ess.Tween
local u2 = _G.Emit
local u3 = require(script.GroundSideRocks)
return {
    ["CreateWind"] = function(p4, p5) --[[ Name: CreateWind, Line 8 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v6, v7, _ = _G.getRayFloor(CFrame.new(p4.Position), 15)
        local v8 = p5.PunchMeshes:Clone()
        v8:PivotTo(p4 * CFrame.new(0, 0, -2))
        v8.Parent = workspace.Effects
        local v9 = v8.wave
        local v10 = v8.After
        local v11 = v8.shockinner
        local v12 = p5.Shoot:Clone()
        v12:PivotTo(p4 * CFrame.new(0, 0, -2))
        v12.Parent = workspace.Effects
        u2(v12:GetDescendants(), true)
        task.delay(1.6, v8.Destroy, v8)
        task.delay(1.6, v12.Destroy, v12)
        if v6 then
            local v13 = p5.Wind:Clone()
            v13.CFrame = CFrame.new(v7, v7 + p4.LookVector * Vector3.new(1, 0, 1))
            v13.Parent = workspace.Effects
            u2(v13:GetDescendants(), true)
            task.delay(0.9, v13.Destroy, v13)
        end
        u1(v9.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
            ["Offset"] = Vector3.new(0, 5, 0),
            ["Scale"] = v9.Mesh.Scale + Vector3.new(5, 1, 5)
        })
        u1(v10.Mesh, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
            ["Offset"] = Vector3.new(0, -2, 0),
            ["Scale"] = v10.Mesh.Scale + Vector3.new(0.5, -3, 0.5)
        })
        u1(v11.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
            ["Offset"] = Vector3.new(0, -1.5, 0),
            ["Scale"] = v11.Mesh.Scale + Vector3.new(1.25, 1, 1.25)
        })
        u1(v9.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.1), {
            ["Transparency"] = 1
        })
        u1(v10.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0.15), {
            ["Transparency"] = 1
        })
        u1(v11.Decal, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0.1), {
            ["Transparency"] = 1
        })
    end,
    ["CreateBall"] = function(p14, p15, p16, p17, p18, p19) --[[ Name: CreateBall, Line 65 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        local u20 = Random.new()
        tick()
        local u21 = tick()
        tick()
        local u22 = tick()
        local u23 = tick()
        local u24 = u3[p17]
        if p17 then
            u24 = u24[p18]
        end
        local u25 = nil
        local u26 = p19.Ball:Clone()
        local u27 = p19.Debris:Clone()
        local u28 = u27:GetChildren()
        u27:PivotTo(p14)
        u27.Parent = workspace.Effects
        u26:PivotTo(p14)
        u26.Parent = workspace.Effects
        u2(u26:GetDescendants(), false, p16 * 0.8)
        u1(u26, TweenInfo.new(p16, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CFrame"] = p14 * CFrame.new(0, 0, -p15 * p16)
        })
        local u29 = u27:GetChildren()
        u25 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 103 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u24
                [3] = u27
                [4] = u25
                [5] = u29
                [6] = u22
                [7] = u23
                [8] = u3
                [9] = u20
                [10] = u28
                [11] = u21
            --]]
            local v30 = workspace
            local v31 = u26.Position
            local v32 = -u24.Height
            local v33 = v30:Raycast(v31, Vector3.new(0, v32, 0), _G.RaycastParams)
            local v34
            if v33 then
                local v35 = v33.Distance
                v34 = Vector3.new(0, v35, 0)
            else
                v34 = Vector3.new(0, 0, 0)
            end
            u27.CFrame = u26.CFrame - v34
            if u25 and v33 then
                if v33.Instance ~= nil then
                    for v36 = 1, #u29 do
                        if u29[v36]:IsA("ParticleEmitter") then
                            u29[v36].Color = ColorSequence.new(v33.Instance.Color)
                        end
                    end
                end
                if u22 - u23 > u24.Rate and u24.Rate ~= 0.013333333333333334 then
                    u3.Create(u27.CFrame * CFrame.new(0, -3.4, 0), u24.Offset, CFrame.fromEulerAnglesYXZ(u20:NextNumber(0.1, 0.25), u20:NextNumber(-0.1, 0.1), u20:NextNumber(0.25, 0.35) * 0), u20:NextNumber(1.8, 2.1) * u24.ScaleMult, 0.7)
                    u23 = tick()
                end
            end
            for _, v37 in u28 do
                v37.Enabled = u25 and v33
            end
            u21 = tick()
            u22 = u21
        end)
        local u38 = u25
        for _, v39 in u26:GetChildren() do
            if v39:IsA("BasePart") then
                u1(v39, TweenInfo.new(p16 - 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.25), {
                    ["Transparency"] = 1
                })
            end
        end
        task.delay(p16 * 0.9, function() --[[ Line: 166 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u26
            --]]
            local v40 = u38
            task.defer(v40.Disconnect, v40)
            u38 = false
            local v41 = u26:FindFirstChild("PointLight")
            if v41 then
                _G.tween(v41, {
                    0.25,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Brightness"] = 0
                })
                _G.destroy(v41, 0.25)
            end
        end)
        task.delay(p16 + 1, u26.Destroy, u26)
        task.delay(p16 + 1, u27.Destroy, u27)
    end
}