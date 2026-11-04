 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
return {
    ["start"] = function(_, p2, u3, p4, p5, p6, p7, _, p8) --[[ Name: start, Line 10 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        Random.new()
        local u9 = OverlapParams.new()
        u9.FilterType = Enum.RaycastFilterType.Whitelist
        u9.FilterDescendantsInstances = Ess.RaycastParams.FilterDescendantsInstances
        local v10 = table.clone(Ess.RaycastParams.FilterDescendantsInstances)
        local v11 = _G.getTargets(p2)
        for v12 = 1, #v11 do
            local v13 = v11[v12]
            table.insert(v10, v13)
        end
        u9.FilterDescendantsInstances = v10
        p2:FindFirstChild("Humanoid")
        local u14 = p2.PrimaryPart
        p2:FindFirstChild("PhoenixFullForm")
        if p6 == nil then
            if not p5 then
                local v15 = u14.CFrame * CFrame.new(0, 2.5, -9)
                local u16 = script.Parent.Charge:Clone()
                u16.CFrame = v15
                u16.Parent = workspace.Effects
                _G.destroy(u16, 10)
                Emit(u16:GetDescendants(), false)
                local u17 = tick()
                tick()
                local u18 = tick()
                local u20 = u1.RenderStepped:Connect(function() --[[ Line: 47 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u16
                        [3] = u14
                        [4] = u18
                    --]]
                    local v19 = tick()
                    local _ = tick() - u17
                    u16.CFrame = u14.CFrame * CFrame.new(0, 2.5, -9)
                    if v19 - u18 > 10 then
                        _G.PlaySound(u14:FindFirstChild("RootRigAttachment"), script.Parent.Parent.Sound.Bluebird.BlueBirdLoop, {})
                    end
                end)
                p2:GetAttributeChangedSignal("HoldingR"):Once(function() --[[ Line: 59 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u3
                        [3] = u16
                    --]]
                    u20:Disconnect()
                    u20 = nil
                    task.wait(u3)
                    Ess.Destroy(u16, 1.5)
                    for _, v21 in u16:GetDescendants() do
                        if v21:IsA("ParticleEmitter") then
                            v21.Enabled = false
                        end
                    end
                end)
                repeat
                    task.wait()
                until u20 == nil
                return
            end
        else
            local u22 = RaycastParams.new()
            u22.FilterType = Enum.RaycastFilterType.Whitelist
            u22.FilterDescendantsInstances = v10
            local v23 = p7 * p4 * CFrame.new(0, 1.5, -5)
            local u24 = v23 * CFrame.new(0, 0, -120)
            local v25 = workspace:Raycast(v23.Position, v23.LookVector * (v23.Position - u24.Position).Magnitude, u22)
            if v25 then
                u24 = CFrame.new(v25.Position, v23.Position) * CFrame.Angles(0, 3.141592653589793, 0)
            end
            local u26 = (u24.Position - v23.Position).Magnitude
            local u27 = u26 / p8
            local u28 = script.Bluebird:Clone()
            u28.Parent = workspace.Effects
            local u29 = u28.Model
            Emit(u28:GetDescendants(), true)
            u28:PivotTo(v23)
            Ess.Destroy(u28, 3.25)
            _G.PlaySound(u29.Part, script.Parent.Parent.Sound.Bluebird.BlueBirdShoot, {})
            for _, u30 in u29:GetChildren() do
                TweenCreate(u30, TweenInfo.new(u27, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["Size"] = u30.Size * Vector3.new(1.5, 0.7, 0.7),
                    ["Color"] = Color3.new(0.074403, 0.434699, 0.998413)
                })
                task.delay(u27 / 2, function() --[[ Line: 119 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u27
                    --]]
                    TweenCreate(u30, TweenInfo.new(u27 / 2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        ["Transparency"] = 1
                    })
                end)
            end
            for _, v31 in u29.Part:GetChildren() do
                if v31:IsA("Attachment") then
                    TweenCreate(v31, TweenInfo.new(u27, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                        ["Position"] = v31.Position * Vector3.new(-1.5, 0, 1)
                    })
                end
            end
            task.delay(u27 - 0.1, function() --[[ Line: 137 ]]
                --[[
                Upvalues:
                    [1] = u29
                --]]
                Emit(u29.Part:GetDescendants(), false)
            end)
            local u32 = u29:GetPivot()
            local u33 = 0
            local u34 = tick()
            local u35 = tick()
            local u36 = tick()
            local u37 = nil
            u37 = u1.Stepped:Connect(function(_, p38) --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u36
                    [3] = u27
                    [4] = u29
                    [5] = u32
                    [6] = u26
                    [7] = u22
                    [8] = u28
                    [9] = u9
                    [10] = u37
                    [11] = u35
                    [12] = u24
                    [13] = u33
                --]]
                u34 = u34 + p38
                local v39 = u34 - u36
                local v40 = u27
                local v41 = math.clamp(v39, 0, v40)
                local v42 = u29
                local v43 = u32:Lerp(u32 * CFrame.new(0, 0, -u26 * 2.45), v41 / u27)
                local v44 = CFrame.Angles
                local v45 = v41 * 1500 % 360
                local v46 = math.ceil(v45)
                local v47 = math.abs(v46)
                v42:PivotTo(v43 * v44(0, 0, -math.rad(v47)))
                local v48 = u29:GetPivot()
                workspace:Raycast(v48.Position, Vector3.new(0, -8, 0), Ess.RaycastParams)
                local v49 = workspace:Raycast(v48.Position, v48.LookVector * 8, u22)
                if v49 or #workspace:GetPartsInPart(u28.RootPart, u9) > 0 then
                    local v50 = v49 == nil and {
                        ["Position"] = u29:GetPivot().Position,
                        ["Normal"] = Vector3.new(0, 1, 0)
                    } or v49
                    u37:Disconnect()
                    local u51 = script.Parent.BluebirdHit:Clone()
                    local v52 = v50.Position
                    local v53 = v50.Normal
                    u51.CFrame = CFrame.new(v52, v52 + v53) * CFrame.Angles(-1.5707963267948966, math.random() * 3.141592653589793, 0)
                    u51.Parent = workspace.Effects
                    local v54 = u51.Glow
                    Emit(u51.Attachment, true)
                    Ess.Destroy(u51, 3)
                    _G.PlaySound(u29.Part, script.Parent.Parent.Sound.Bluebird.BlueBirdHit)
                    v54.Brightness = 30
                    v54.Color = Color3.new(0.153811, 0.864652, 0.998871)
                    TweenCreate(v54, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                        ["Brightness"] = 0,
                        ["Range"] = 50
                    })
                    task.delay(0.15, function() --[[ Line: 211 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                        --]]
                        for _, v55 in u51:GetChildren() do
                            if v55:IsA("Decal") then
                                local v56 = v55.Name:match("Shape") and 0.5 or 0.8
                                TweenCreate(v55, TweenInfo.new(v56, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                                    ["Color3"] = Color3.new(0, 0, 0),
                                    ["Transparency"] = 1
                                })
                            end
                        end
                    end)
                end
                local v57 = tick()
                local v58 = v41 / u27
                if v57 - u35 > 0.1 and v58 < 1 then
                    local v59 = script.Parent.Swirl.Swirl1:Clone()
                    v59.Mesh.Scale = v59.Mesh.Scale * (2 - v58)
                    local v60 = CFrame.new(u29:GetPivot().Position, u29:GetPivot().Position + u24.LookVector * 5) * CFrame.new(0, 0, -(u33 - 35))
                    local v61 = CFrame.Angles
                    local v62 = v58 * -240
                    v59.CFrame = v60 * v61(1.5707963267948966, math.rad(v62) + -0.7853981633974483, 0)
                    v59.Parent = workspace.Effects
                    TweenCreate(v59, TweenInfo.new(u27 + 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["CFrame"] = v59.CFrame * CFrame.new(0, -40, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                    })
                    TweenCreate(v59.Mesh, TweenInfo.new(u27, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Scale"] = v59.Mesh.Scale * Vector3.new(2, 8.5, 2)
                    })
                    TweenCreate(v59.Decal, TweenInfo.new(u27, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                        ["Transparency"] = 1,
                        ["Color3"] = Color3.fromRGB(248, 246, 239)
                    })
                    Ess.Destroy(v59, u27)
                    u33 = u33 + 12
                    u35 = tick()
                end
            end)
            Ess.Destroy(u37, u27)
        end
    end
}