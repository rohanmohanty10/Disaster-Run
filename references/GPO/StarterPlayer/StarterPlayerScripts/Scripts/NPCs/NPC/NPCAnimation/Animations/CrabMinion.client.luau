 

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
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("CrabMinion")
            local u6 = script:WaitForChild("Walkspeed").Value
            local u7 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Walk),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump)
            }
            u7.Idle.Priority = Enum.AnimationPriority.Idle
            u7.Walk.Priority = Enum.AnimationPriority.Movement
            u7.Run.Priority = Enum.AnimationPriority.Movement
            u7.Jump.Priority = Enum.AnimationPriority.Movement
            u7.Fall.Priority = Enum.AnimationPriority.Movement
            local u8 = u1.HumanoidRootPart:FindFirstChild("walkLooped")
            if u8 == nil then
                u8 = script.walkLooped:Clone()
                u8.Parent = u1.HumanoidRootPart
            end
            u8.Volume = 0
            u8:Play()
            local u9 = 1
            local u10 = 0
            u7.Run:GetMarkerReachedSignal("scream"):Connect(function() --[[ Line: 48 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u9
                    [3] = u1
                --]]
                if tick() - u10 >= 2 then
                    u10 = tick()
                    u9 = u9 + 1
                    if u9 > 2 then
                        u9 = 1
                    end
                    local v11 = script["v" .. u9]:Clone()
                    v11.Parent = u1.PrimaryPart
                    v11:Play()
                    _G.destroy(v11, 3)
                end
            end)
            local u12 = "Idle"
            u3.Running:Connect(function(p13) --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u6
                    [3] = u12
                    [4] = u7
                --]]
                if p13 > 5 then
                    u8.Volume = 0.5
                else
                    u8.Volume = 0
                end
                if u6 + 5 < p13 then
                    if u12 ~= "Running" then
                        u12 = "Running"
                        for _, v14 in u7 do
                            v14:Stop()
                        end
                        u7.Run:Play()
                        u7.Run:AdjustSpeed(1.5)
                        return
                    end
                elseif p13 > 0.749 then
                    if u12 ~= "Walking" then
                        u12 = "Walking"
                        for _, v15 in u7 do
                            v15:Stop()
                        end
                        u7.Walk:Play()
                        return
                    end
                elseif u12 ~= "Idle" then
                    u12 = "Idle"
                    for _, v16 in u7 do
                        v16:Stop()
                    end
                    u7.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u7
                --]]
                if u12 ~= "Jump" then
                    u12 = "Jump"
                    for _, v17 in u7 do
                        v17:Stop()
                    end
                    u7.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p18) --[[ Line: 104 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u12
                    [3] = u7
                --]]
                if p18 and (u3.FloorMaterial == Enum.Material.Air and u12 ~= "Fall") then
                    u12 = "Fall"
                    for _, v19 in u7 do
                        v19:Stop()
                    end
                    u7.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p20) --[[ Line: 113 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u12
                    [3] = u7
                --]]
                if p20 and (u3.FloorMaterial == Enum.Material.Air and u12 ~= "Fall") then
                    u12 = "Fall"
                    for _, v21 in u7 do
                        v21:Stop()
                    end
                    u7.Fall:Play()
                end
            end)
            u7.Idle:Play()
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end