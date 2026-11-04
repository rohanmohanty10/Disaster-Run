 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
return {
    ["start"] = function(_, p2, p3) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            Random.new()
            p2:GetAttribute("Transformed")
            local u4 = p2.PrimaryPart
            local v5 = p2:FindFirstChild("PhoenixFullForm")
            local v6 = p2:FindFirstChild("Humanoid")
            p2:FindFirstChild("UpperTorso")
            local v7 = p2:FindFirstChild("CharacterEffects")
            local v8 = u4.CFrame * CFrame.new(0, -2.5, 0)
            local v9 = v5.Body.Transparency == 0
            local v10 = v9 and 1 or 0.5
            if p3 then
                local v11
                if v9 then
                    v11 = v5.AnimationController.Animator:LoadAnimation(script.Parent.Anims.Full.Pyre)
                else
                    v11 = v6.Animator:LoadAnimation(script.Parent.Anims.Hybrid.Pyre)
                end
                v11:Play()
                local u12 = script.PyreappleWindup:Clone()
                u12.CFrame = v8 * CFrame.Angles(0, -1.5707963267948966, 0)
                u12.Size = u12.Size * v10
                u12.Parent = workspace.Effects
                task.delay(0.01, function() --[[ Line: 73 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                    --]]
                    local v13 = u12.CFrame
                    TweenCreate(u12, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["CFrame"] = v13 * CFrame.Angles(0, -3.141592653589793, 0)
                    })
                    task.wait(0.5)
                    TweenCreate(u12, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["CFrame"] = v13
                    })
                end)
                if not v9 then
                    for _, v14 in u12:GetDescendants() do
                        if v14:IsA("ParticleEmitter") then
                            local v15 = v14.Size
                            local v16 = v14.Speed
                            local v17 = {}
                            for _, v18 in v15.Keypoints do
                                local v19 = NumberSequenceKeypoint.new
                                local v20 = v18.Time
                                local v21 = v18.Value * 0.5
                                local v22 = v18.Envelope
                                table.insert(v17, v19(v20, v21, v22))
                            end
                            v14.Speed = NumberRange.new(v16.Min * 0.5 / 1.25, v16.Max * 0.5 / 1.25)
                            v14.Size = NumberSequence.new(v17)
                            v14.Acceleration = v14.Acceleration * 0.35714285714285715
                        elseif v14:IsA("Attachment") then
                            v14.Position = v14.Position * v10
                        end
                    end
                end
                task.delay(0.8, function() --[[ Line: 113 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                    --]]
                    Emit(u12:GetDescendants(), false)
                    Ess.Destroy(u12, 1.25)
                end)
                task.wait(0.65)
                local u23 = script.Pyreapple:Clone()
                local u24 = u23.PrimaryPart
                local _ = u23.Secondary
                u23:PivotTo(v8)
                local u25 = {}
                for _, v26 in u23:GetChildren() do
                    if v26:IsA("BasePart") then
                        v26.Size = v26.Size * v10
                    end
                end
                u23.Parent = v7
                Emit(u24:GetDescendants(), false)
                Emit(u23.Secondary.Middle:GetDescendants(), false)
                Emit(u23.Secondary:GetDescendants(), true)
                local u27 = tick()
                local u34 = u1.Heartbeat:Connect(function() --[[ Line: 156 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                        [2] = u4
                        [3] = u24
                        [4] = u23
                    --]]
                    local v28 = tick() - u27
                    local v29 = u4.CFrame * CFrame.new(0, -3.3, 0)
                    local v30 = u24
                    local v31 = CFrame.Angles
                    local v32 = v28 * -90 % 360
                    local v33 = math.ceil(v32)
                    v30.CFrame = v29 * v31(0, math.rad(v33), 0)
                    u23.Secondary.CFrame = v29 * CFrame.Angles(-1.5707963267948966, 0, 0)
                end)
                u23.AncestryChanged:Once(function() --[[ Line: 166 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u34
                    --]]
                    for _, v35 in u25 do
                        Emit(v35, false)
                        Ess.Destroy(v35, 0.3)
                    end
                    u34:Disconnect()
                end)
                if not v9 then
                    for _, v36 in u23:GetDescendants() do
                        if v36:IsA("ParticleEmitter") then
                            local v37 = v36.Size
                            local v38 = v36.Speed
                            local v39 = v36.Lifetime
                            local v40 = {}
                            for _, v41 in v37.Keypoints do
                                local v42 = NumberSequenceKeypoint.new
                                local v43 = v41.Time
                                local v44 = v41.Value * 0.5
                                local v45 = v41.Envelope
                                table.insert(v40, v42(v43, v44, v45))
                            end
                            v36.Lifetime = NumberRange.new(v39.Min * 0.5 * 1.5, v39.Max * 0.5 * 1.5)
                            v36.Speed = NumberRange.new(v38.Min * 0.5 / 1.25, v38.Max * 0.5 / 1.25)
                            v36.Size = NumberSequence.new(v40)
                            v36.Acceleration = v36.Acceleration * 0.35714285714285715
                        end
                    end
                    return
                end
            else
                local v46 = v7:FindFirstChild("Pyreapple")
                if v46 == nil then
                    return
                end
                v46.Parent = workspace.Effects
                local v47 = v46:FindFirstChild("PyreappleLoop")
                if v47 then
                    v47:Stop()
                    v47:Destroy()
                end
                TweenCreate(v46.PrimaryPart.Attachment.PointLight, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["Brightness"] = 0,
                    ["Range"] = 24
                })
                Emit(v46.PrimaryPart:GetDescendants(), false)
                Emit(v46.Secondary.Middle:GetDescendants(), false)
                Ess.Destroy(v46, 1.5)
            end
        end
    end
}