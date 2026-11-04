 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
return {
    ["start"] = function(_, p2, u3, p4, _, p5) --[[ Name: start, Line 10 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        Random.new()
        local u6 = OverlapParams.new()
        u6.FilterType = Enum.RaycastFilterType.Whitelist
        u6.FilterDescendantsInstances = Ess.RaycastParams.FilterDescendantsInstances
        local v7 = table.clone(Ess.RaycastParams.FilterDescendantsInstances)
        local v8 = _G.getTargets(p2)
        for v9 = 1, #v8 do
            local v10 = v8[v9]
            table.insert(v7, v10)
        end
        u6.FilterDescendantsInstances = v7
        p2:FindFirstChild("Humanoid")
        local u11 = p2.PrimaryPart
        p2:FindFirstChild("PhoenixFullForm")
        if p4 == nil then
            local v12 = u11.CFrame * CFrame.new(0, 2.5, -5)
            local u13 = script.Parent.Charge:Clone()
            u13.CFrame = v12
            u13.Parent = workspace.Effects
            _G.destroy(u13, 10)
            Emit(u13:GetDescendants(), false)
            u13.BlueBirdLoop:Play()
            local u14 = tick()
            tick()
            tick()
            local u15 = u1.RenderStepped:Connect(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u13
                    [3] = u11
                --]]
                tick()
                local _ = tick() - u14
                u13.CFrame = u11.CFrame * CFrame.new(0, 2.5, -9)
            end)
            p2:GetAttributeChangedSignal("HoldingR"):Once(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u3
                    [3] = u13
                --]]
                u15:Disconnect()
                u15 = nil
                task.wait(u3)
                if u13 and u13:FindFirstChild("BlueBirdLoop") then
                    u13.BlueBirdLoop:Stop()
                end
                Ess.Destroy(u13, 0.5)
                for _, v16 in u13:GetDescendants() do
                    if v16:IsA("ParticleEmitter") then
                        v16.Enabled = false
                    end
                end
            end)
        else
            local u17 = RaycastParams.new()
            u17.FilterType = Enum.RaycastFilterType.Whitelist
            u17.FilterDescendantsInstances = v7
            local v18 = u11.CFrame * CFrame.new(0, 1.5, -5)
            local u19 = v18 * CFrame.new(0, 0, -120)
            local v20 = workspace:Raycast(v18.Position, v18.LookVector * (v18.Position - u19.Position).Magnitude, u17)
            if v20 then
                u19 = CFrame.new(v20.Position, v18.Position) * CFrame.Angles(0, 3.141592653589793, 0)
            end
            local u21 = (u19.Position - v18.Position).Magnitude
            local u22 = u21 / p5
            local u23 = script.Bluebird:Clone()
            u23.Parent = workspace.Effects
            local u24 = u23.Model
            Emit(u23:GetDescendants(), true)
            u23:PivotTo(v18)
            Ess.Destroy(u23, 3.25)
            _G.PlaySound(u24.Part, script.Parent.Parent.Sound.Bluebird.BlueBirdShoot, {})
            for _, u25 in u24:GetChildren() do
                TweenCreate(u25, TweenInfo.new(u22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["Size"] = u25.Size * Vector3.new(1.5, 0.7, 0.7),
                    ["Color"] = Color3.new(0.074403, 0.434699, 0.998413)
                })
                task.delay(u22 / 2, function() --[[ Line: 129 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u22
                    --]]
                    TweenCreate(u25, TweenInfo.new(u22 / 2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        ["Transparency"] = 1
                    })
                end)
            end
            for _, v26 in u24.Part:GetChildren() do
                if v26:IsA("Attachment") then
                    TweenCreate(v26, TweenInfo.new(u22, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                        ["Position"] = v26.Position * Vector3.new(-1.5, 0, 1)
                    })
                end
            end
            task.delay(u22 - 0.1, function() --[[ Line: 147 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                Emit(u24.Part:GetDescendants(), false)
            end)
            local u27 = u24:GetPivot()
            local u28 = 0
            local u29 = tick()
            local u30 = tick()
            local u31 = nil
            u31 = u1.Stepped:Connect(function() --[[ Line: 166 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u24
                    [3] = u27
                    [4] = u21
                    [5] = u22
                    [6] = u6
                    [7] = u17
                    [8] = u23
                    [9] = u31
                    [10] = u30
                    [11] = u19
                    [12] = u28
                --]]
                local v32 = tick() - u29
                local v33 = u24
                local v34 = u27:Lerp(u27 * CFrame.new(0, 0, -u21 * 2.45), v32 / u22)
                local v35 = CFrame.Angles
                local v36 = v32 * 1500 % 360
                local v37 = math.ceil(v36)
                local v38 = math.abs(v37)
                v33:PivotTo(v34 * v35(0, 0, -math.rad(v38)))
                local v39 = u24:GetPivot()
                workspace:Raycast(v39.Position, Vector3.new(0, -8, 0), u6)
                local v40 = workspace:Raycast(v39.Position, v39.LookVector * 8, u17)
                if v40 or #workspace:GetPartsInPart(u23.RootPart, u6) > 0 then
                    warn("raycast coolide")
                    local v41 = v40 == nil and {
                        ["Position"] = u24:GetPivot().Position
                    } or v40
                    u31:Disconnect()
                    local u42 = script.Parent.BluebirdHit:Clone()
                    local v43 = v41.Position
                    local v44 = v41.Normal
                    u42.CFrame = CFrame.new(v43, v43 + v44)
                    u42.Parent = workspace.Effects
                    local v45 = u42.Glow
                    Emit(u42.Attachment, true)
                    Ess.Destroy(u42, 3)
                    _G.PlaySound(u24.Part, script.Parent.Parent.Sound.Bluebird.BlueBirdHit)
                    v45.Brightness = 30
                    v45.Color = Color3.new(0.153811, 0.864652, 0.998871)
                    TweenCreate(v45, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                        ["Brightness"] = 0,
                        ["Range"] = 50
                    })
                    task.delay(0.15, function() --[[ Line: 213 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                        --]]
                        for _, v46 in u42:GetChildren() do
                            if v46:IsA("Decal") then
                                local v47 = v46.Name:match("Shape") and 0.5 or 0.8
                                TweenCreate(v46, TweenInfo.new(v47, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                                    ["Color3"] = Color3.new(0, 0, 0),
                                    ["Transparency"] = 1
                                })
                            end
                        end
                    end)
                end
                local v48 = tick()
                local v49 = v32 / u22
                if v48 - u30 > 0.1 and v49 < 1 then
                    local v50 = script.Parent.Swirl.Swirl1:Clone()
                    v50.Mesh.Scale = v50.Mesh.Scale * (2 - v49)
                    local v51 = CFrame.new(u24:GetPivot().Position, u24:GetPivot().Position + u19.LookVector * 5) * CFrame.new(0, 0, -(u28 - 35))
                    local v52 = CFrame.Angles
                    local v53 = v49 * -240
                    v50.CFrame = v51 * v52(1.5707963267948966, math.rad(v53) + -1.5707963267948966, 0)
                    v50.Parent = workspace.Effects
                    TweenCreate(v50, TweenInfo.new(u22 + 0.15, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        ["CFrame"] = v50.CFrame * CFrame.new(0, -40, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                    })
                    TweenCreate(v50.Mesh, TweenInfo.new(u22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Scale"] = v50.Mesh.Scale * Vector3.new(1.2, 7.5, 1.2)
                    })
                    TweenCreate(v50.Decal, TweenInfo.new(u22, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                        ["Transparency"] = 1,
                        ["Color3"] = Color3.fromRGB(187, 65, 5)
                    })
                    Ess.Destroy(v50, u22)
                    u28 = u28 + 8
                    u30 = tick()
                end
            end)
            Ess.Destroy(u31, u22)
        end
    end
}