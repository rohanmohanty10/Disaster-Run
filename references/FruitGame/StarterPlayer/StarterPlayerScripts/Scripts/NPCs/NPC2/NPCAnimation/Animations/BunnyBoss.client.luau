 

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
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("BunnyBoss")
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
            u7.Run.Priority = Enum.AnimationPriority.Idle
            u7.Jump.Priority = Enum.AnimationPriority.Movement
            u7.Fall.Priority = Enum.AnimationPriority.Movement
            u7.Walk:GetMarkerReachedSignal("bounce"):Connect(function() --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                local v8 = script.bounce:Clone()
                v8.Parent = u1.PrimaryPart
                v8:Play()
                _G.destroy(v8, 1)
            end)
            local u9 = "Idle"
            u3.Running:Connect(function(p10) --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u9
                    [3] = u7
                --]]
                if u6 + 5 < p10 then
                    if u9 ~= "Running" then
                        u9 = "Running"
                        for _, v11 in u7 do
                            v11:Stop()
                        end
                        u7.Run:Play()
                        u7.Run:AdjustSpeed(2)
                        return
                    end
                elseif p10 > 0.749 then
                    if u9 ~= "Walking" then
                        u9 = "Walking"
                        for _, v12 in u7 do
                            v12:Stop()
                        end
                        u7.Walk:Play()
                        return
                    end
                elseif u9 ~= "Idle" then
                    u9 = "Idle"
                    for _, v13 in u7 do
                        v13:Stop()
                    end
                    u7.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u7
                --]]
                if u9 ~= "Jump" then
                    u9 = "Jump"
                    for _, v14 in u7 do
                        v14:Stop()
                    end
                    u7.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p15) --[[ Line: 80 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u9
                    [3] = u7
                --]]
                if p15 and (u3.FloorMaterial == Enum.Material.Air and u9 ~= "Fall") then
                    u9 = "Fall"
                    for _, v16 in u7 do
                        v16:Stop()
                    end
                    u7.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p17) --[[ Line: 89 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u9
                    [3] = u7
                --]]
                if p17 and (u3.FloorMaterial == Enum.Material.Air and u9 ~= "Fall") then
                    u9 = "Fall"
                    for _, v18 in u7 do
                        v18:Stop()
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