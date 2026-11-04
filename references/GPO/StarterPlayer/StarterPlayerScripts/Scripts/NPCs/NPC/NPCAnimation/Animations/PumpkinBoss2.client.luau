 

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
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Human")
            local u6 = script:WaitForChild("Walkspeed").Value
            local u7 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Run),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump)
            }
            if v1.Info:FindFirstChild("Weapon") then
                local v8 = v1.Info:FindFirstChild("Weapon").Value
                if game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v8) and game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v8):FindFirstChild("runAnim") then
                    u7.Run = v4:LoadAnimation(game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v8):FindFirstChild("runAnim"))
                    warn("going run")
                end
            end
            u7.Idle.Priority = Enum.AnimationPriority.Idle
            u7.Walk.Priority = Enum.AnimationPriority.Idle
            u7.Run.Priority = Enum.AnimationPriority.Movement
            u7.Jump.Priority = Enum.AnimationPriority.Movement
            u7.Fall.Priority = Enum.AnimationPriority.Movement
            local u9 = {}
            local u10 = "Idle"
            u3.Running:Connect(function(p11) --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u10
                    [3] = u7
                    [4] = u9
                --]]
                if u6 + 5 < p11 then
                    if u10 ~= "Running" then
                        u10 = "Running"
                        for v12, _ in u7 do
                            if u7[v12].IsPlaying ~= false then
                                u9[v12] = u7[v12].TimePosition
                                u7[v12]:Stop()
                            end
                        end
                        if u9.Run == nil then
                            u9.Run = 0
                        end
                        u7.Run:Play()
                        u7.Run.TimePosition = u9.Run
                        u7.Run:AdjustSpeed(2)
                        return
                    end
                elseif p11 > 0.749 then
                    if u10 ~= "Walking" then
                        u10 = "Walking"
                        for v13, _ in u7 do
                            if u7[v13].IsPlaying ~= false then
                                u9[v13] = u7[v13].TimePosition
                                u7[v13]:Stop()
                            end
                        end
                        if u9.Walk == nil then
                            u9.Walk = 0
                        end
                        u7.Walk:Play()
                        u7.Walk.TimePosition = u9.Walk
                        return
                    end
                elseif u10 ~= "Idle" then
                    u10 = "Idle"
                    for v14, _ in u7 do
                        if u7[v14].IsPlaying ~= false then
                            u9[v14] = u7[v14].TimePosition
                            u7[v14]:Stop()
                        end
                    end
                    u7.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 96 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u7
                    [3] = u9
                --]]
                if u10 ~= "Jump" then
                    u10 = "Jump"
                    for v15, _ in u7 do
                        if u7[v15].IsPlaying ~= false then
                            u9[v15] = u7[v15].TimePosition
                            u7[v15]:Stop()
                        end
                    end
                    u7.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p16) --[[ Line: 103 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u10
                    [3] = u7
                    [4] = u9
                --]]
                if p16 and (u3.FloorMaterial == Enum.Material.Air and u10 ~= "Fall") then
                    u10 = "Fall"
                    for v17, _ in u7 do
                        if u7[v17].IsPlaying ~= false then
                            u9[v17] = u7[v17].TimePosition
                            u7[v17]:Stop()
                        end
                    end
                    u7.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p18) --[[ Line: 112 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u10
                    [3] = u7
                    [4] = u9
                --]]
                if p18 and (u3.FloorMaterial == Enum.Material.Air and u10 ~= "Fall") then
                    u10 = "Fall"
                    for v19, _ in u7 do
                        if u7[v19].IsPlaying ~= false then
                            u9[v19] = u7[v19].TimePosition
                            u7[v19]:Stop()
                        end
                    end
                    u7.Fall:Play()
                end
            end)
            u7.Idle:Play()
            local v20 = 1
            while true do
                task.wait(math.random(5, 10))
                _G.PlaySound(v1.Head, script["H" .. v20]).Parent = v1.Head
                local v21 = v20 + 1
                v20 = v21 > 5 and 1 or v21
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