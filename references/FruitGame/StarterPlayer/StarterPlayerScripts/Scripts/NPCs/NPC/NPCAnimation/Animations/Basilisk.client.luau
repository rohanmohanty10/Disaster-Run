 

local u1 = script:WaitForChild("Character").Value
if u1 then
    local v2 = workspace
    local u3 = u1:WaitForChild("Humanoid", 5)
    if u3:IsA("Humanoid") == false then
        script:Destroy()
        return
    elseif u3 and u3.Health > 0 then
        local v4 = u3:WaitForChild("Animator", 3) or u3
        if u3.Parent and (u3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2))) then
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Basilisk")
            local _ = script:WaitForChild("Walkspeed").Value
            local u6 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Run),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump),
                ["Land"] = v4:LoadAnimation(v5.Land)
            }
            u6.Idle.Priority = Enum.AnimationPriority.Idle
            u6.Walk.Priority = Enum.AnimationPriority.Movement
            u6.Run.Priority = Enum.AnimationPriority.Movement
            u6.Jump.Priority = Enum.AnimationPriority.Movement
            u6.Fall.Priority = Enum.AnimationPriority.Movement
            u6.Land.Priority = Enum.AnimationPriority.Movement
            local function u8(p7) --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                if p7:match("step") and (p7 ~= "step" and (_G.footstep and (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).magnitude <= 150)) then
                    _G.footstep(p7, nil, u1)
                end
            end
            u6.Walk.KeyframeReached:Connect(function(p9) --[[ Line: 47 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8(p9)
            end)
            if u6.Run ~= nil then
                u6.Run.KeyframeReached:Connect(function(p10) --[[ Line: 52 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    u8(p10)
                end)
            end
            local u11 = {}
            local u12 = "Idle"
            u3.Running:Connect(function(p13) --[[ Line: 85 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u6
                    [3] = u11
                --]]
                if p13 > 20 then
                    if u12 ~= "Running" then
                        u12 = "Running"
                        for v14, _ in u6 do
                            if u6[v14].IsPlaying ~= false then
                                u11[v14] = u6[v14].TimePosition
                                u6[v14]:Stop()
                            end
                        end
                        if u11.Run == nil then
                            u11.Run = 0
                        end
                        u6.Run:Play()
                        u6.Run.TimePosition = u11.Run
                        u6.Run:AdjustSpeed(2)
                        return
                    end
                elseif p13 > 0.749 then
                    if u12 ~= "Walking" then
                        u12 = "Walking"
                        for v15, _ in u6 do
                            if u6[v15].IsPlaying ~= false then
                                u11[v15] = u6[v15].TimePosition
                                u6[v15]:Stop()
                            end
                        end
                        if u11.Walk == nil then
                            u11.Walk = 0
                        end
                        u6.Walk:Play()
                        u6.Walk.TimePosition = u11.Walk
                        return
                    end
                elseif u12 ~= "Idle" then
                    u12 = "Idle"
                    for v16, _ in u6 do
                        if u6[v16].IsPlaying ~= false then
                            u11[v16] = u6[v16].TimePosition
                            u6[v16]:Stop()
                        end
                    end
                    u6.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 110 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u6
                    [3] = u11
                --]]
                if u12 ~= "Jump" then
                    u12 = "Jump"
                    for v17, _ in u6 do
                        if u6[v17].IsPlaying ~= false then
                            u11[v17] = u6[v17].TimePosition
                            u6[v17]:Stop()
                        end
                    end
                    u6.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p18) --[[ Line: 117 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u12
                    [3] = u6
                    [4] = u11
                --]]
                if p18 and (u3.FloorMaterial == Enum.Material.Air and u12 ~= "Fall") then
                    u12 = "Fall"
                    for v19, _ in u6 do
                        if u6[v19].IsPlaying ~= false then
                            u11[v19] = u6[v19].TimePosition
                            u6[v19]:Stop()
                        end
                    end
                    u6.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p20) --[[ Line: 126 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u12
                    [3] = u6
                    [4] = u11
                --]]
                if p20 and (u3.FloorMaterial == Enum.Material.Air and u12 ~= "Fall") then
                    u12 = "Fall"
                    for v21, _ in u6 do
                        if u6[v21].IsPlaying ~= false then
                            u11[v21] = u6[v21].TimePosition
                            u6[v21]:Stop()
                        end
                    end
                    u6.Fall:Play()
                end
            end)
            u6.Idle:Play()
            u3:GetPropertyChangedSignal("FloorMaterial"):Connect(function() --[[ Line: 136 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u6
                --]]
                if u3.FloorMaterial ~= Enum.Material.Air then
                    u6.Land:Play()
                end
            end)
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end