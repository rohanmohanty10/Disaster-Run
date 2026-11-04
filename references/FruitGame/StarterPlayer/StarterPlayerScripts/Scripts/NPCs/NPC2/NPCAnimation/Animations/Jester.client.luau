 

local v1 = script:WaitForChild("Character").Value
if v1 then
    local v2 = workspace
    local u3 = v1:WaitForChild("Humanoid", 5)
    if u3:IsA("Humanoid") == false then
        script:Destroy()
        return
    elseif u3 and u3.Health > 0 then
        local v4 = u3:WaitForChild("Animator", 3) or u3
        if u3.Parent and (u3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2))) then
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Jester")
            local u6 = script:WaitForChild("Walkspeed").Value
            local u7 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Run),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump)
            }
            u7.Idle.Priority = Enum.AnimationPriority.Idle
            u7.Walk.Priority = Enum.AnimationPriority.Idle
            u7.Run.Priority = Enum.AnimationPriority.Movement
            u7.Jump.Priority = Enum.AnimationPriority.Movement
            u7.Fall.Priority = Enum.AnimationPriority.Movement
            v1.Hat.AnimationController:LoadAnimation(script.Animation):Play()
            local u8 = {}
            local u9 = "Idle"
            u3.Running:Connect(function(p10) --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u9
                    [3] = u7
                    [4] = u8
                --]]
                if u6 + 5 < p10 then
                    if u9 ~= "Running" then
                        u9 = "Running"
                        for v11, _ in u7 do
                            if u7[v11].IsPlaying ~= false then
                                u8[v11] = u7[v11].TimePosition
                                u7[v11]:Stop()
                            end
                        end
                        if u8.Run == nil then
                            u8.Run = 0
                        end
                        u7.Run:Play()
                        u7.Run.TimePosition = u8.Run
                        u7.Run:AdjustSpeed(1.5)
                        return
                    end
                elseif p10 > 0.749 then
                    if u9 ~= "Walking" then
                        u9 = "Walking"
                        for v12, _ in u7 do
                            if u7[v12].IsPlaying ~= false then
                                u8[v12] = u7[v12].TimePosition
                                u7[v12]:Stop()
                            end
                        end
                        if u8.Walk == nil then
                            u8.Walk = 0
                        end
                        u7.Walk:Play()
                        u7.Walk.TimePosition = u8.Walk
                        return
                    end
                elseif u9 ~= "Idle" then
                    u9 = "Idle"
                    for v13, _ in u7 do
                        if u7[v13].IsPlaying ~= false then
                            u8[v13] = u7[v13].TimePosition
                            u7[v13]:Stop()
                        end
                    end
                    u7.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 99 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u7
                    [3] = u8
                --]]
                if u9 ~= "Jump" then
                    u9 = "Jump"
                    for v14, _ in u7 do
                        if u7[v14].IsPlaying ~= false then
                            u8[v14] = u7[v14].TimePosition
                            u7[v14]:Stop()
                        end
                    end
                    u7.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p15) --[[ Line: 106 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u9
                    [3] = u7
                    [4] = u8
                --]]
                if p15 and (u3.FloorMaterial == Enum.Material.Air and u9 ~= "Fall") then
                    u9 = "Fall"
                    for v16, _ in u7 do
                        if u7[v16].IsPlaying ~= false then
                            u8[v16] = u7[v16].TimePosition
                            u7[v16]:Stop()
                        end
                    end
                    u7.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p17) --[[ Line: 115 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u9
                    [3] = u7
                    [4] = u8
                --]]
                if p17 and (u3.FloorMaterial == Enum.Material.Air and u9 ~= "Fall") then
                    u9 = "Fall"
                    for v18, _ in u7 do
                        if u7[v18].IsPlaying ~= false then
                            u8[v18] = u7[v18].TimePosition
                            u7[v18]:Stop()
                        end
                    end
                    u7.Fall:Play()
                end
            end)
            u7.Idle:Play()
            while true do
                local v19 = script["JesterLaugh" .. math.random(1, 3)]:Clone()
                v19.Parent = v1.Head
                v19:Play()
                _G.destroy(v19, v19.TimeLength + 1)
                task.wait(10)
            end
        else
            return
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end