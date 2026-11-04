 

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
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Human")
            local u6 = script:WaitForChild("Walkspeed").Value
            local u7 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Run),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump)
            }
            if u1.Info:FindFirstChild("Weapon") then
                local v8 = u1.Info:FindFirstChild("Weapon").Value
                if game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v8) and game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v8):FindFirstChild("runAnim") then
                    u7.Run = v4:LoadAnimation(game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v8):FindFirstChild("runAnim"))
                    u7.Run.Priority = Enum.AnimationPriority.Movement
                else
                    u7.Run.Priority = Enum.AnimationPriority.Idle
                end
            else
                u7.Run.Priority = Enum.AnimationPriority.Idle
            end
            u7.Idle.Priority = Enum.AnimationPriority.Core
            u7.Walk.Priority = Enum.AnimationPriority.Idle
            u7.Jump.Priority = Enum.AnimationPriority.Movement
            u7.Fall.Priority = Enum.AnimationPriority.Movement
            local function u10(p9) --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                if p9:match("step") and (p9 ~= "step" and (_G.footstep and (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.p).magnitude <= 150)) then
                    _G.footstep(p9, nil, u1)
                end
            end
            u7.Walk.KeyframeReached:Connect(function(p11) --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                u10(p11)
            end)
            if u7.Run ~= nil then
                u7.Run.KeyframeReached:Connect(function(p12) --[[ Line: 60 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                    --]]
                    u10(p12)
                end)
            end
            local u13 = {}
            local u14 = "Idle"
            u3.Running:Connect(function(p15) --[[ Line: 90 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u14
                    [3] = u7
                    [4] = u13
                --]]
                if u6 + 5 < p15 then
                    if u14 ~= "Running" or u7.Run.IsPlaying == false then
                        u14 = "Running"
                        for v16, _ in u7 do
                            if u7[v16].IsPlaying ~= false then
                                u13[v16] = u7[v16].TimePosition
                                u7[v16]:Stop()
                            end
                        end
                        if u13.Run == nil then
                            u13.Run = 0
                        end
                        u7.Run:Play()
                        u7.Run.TimePosition = u13.Run
                        u7.Run:AdjustSpeed(2)
                        return
                    end
                elseif p15 > 0.749 then
                    if u14 ~= "Walking" or u7.Walk.IsPlaying == false then
                        u14 = "Walking"
                        for v17, _ in u7 do
                            if u7[v17].IsPlaying ~= false then
                                u13[v17] = u7[v17].TimePosition
                                u7[v17]:Stop()
                            end
                        end
                        if u13.Walk == nil then
                            u13.Walk = 0
                        end
                        u7.Walk:Play()
                        u7.Walk.TimePosition = u13.Walk
                        return
                    end
                elseif u14 ~= "Idle" then
                    u14 = "Idle"
                    for v18, _ in u7 do
                        if u7[v18].IsPlaying ~= false then
                            u13[v18] = u7[v18].TimePosition
                            u7[v18]:Stop()
                        end
                    end
                    u7.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 115 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u7
                    [3] = u13
                --]]
                if u14 ~= "Jump" then
                    u14 = "Jump"
                    for v19, _ in u7 do
                        if u7[v19].IsPlaying ~= false then
                            u13[v19] = u7[v19].TimePosition
                            u7[v19]:Stop()
                        end
                    end
                    u7.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p20) --[[ Line: 122 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u14
                    [3] = u7
                    [4] = u13
                --]]
                if p20 and (u3.FloorMaterial == Enum.Material.Air and u14 ~= "Fall") then
                    u14 = "Fall"
                    for v21, _ in u7 do
                        if u7[v21].IsPlaying ~= false then
                            u13[v21] = u7[v21].TimePosition
                            u7[v21]:Stop()
                        end
                    end
                    u7.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p22) --[[ Line: 131 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u14
                    [3] = u7
                    [4] = u13
                --]]
                if p22 and (u3.FloorMaterial == Enum.Material.Air and u14 ~= "Fall") then
                    u14 = "Fall"
                    for v23, _ in u7 do
                        if u7[v23].IsPlaying ~= false then
                            u13[v23] = u7[v23].TimePosition
                            u7[v23]:Stop()
                        end
                    end
                    u7.Fall:Play()
                end
            end)
            u7.Idle:Play()
            while true do
                task.wait(math.random(5, 10))
                _G.PlaySound(u1.Head, script["RyumaVoice" .. math.random(1, 4)]).Parent = u1.Head
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