 

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
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("KingCrab")
            local u6 = script:WaitForChild("Walkspeed").Value
            local u7 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Walk),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump)
            }
            u7.Idle.Priority = Enum.AnimationPriority.Idle
            u7.Walk.Priority = Enum.AnimationPriority.Idle
            u7.Run.Priority = Enum.AnimationPriority.Idle
            u7.Jump.Priority = Enum.AnimationPriority.Movement
            u7.Fall.Priority = Enum.AnimationPriority.Movement
            u7.Run:GetMarkerReachedSignal("step1"):Connect(function() --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                local v8 = script.s1:Clone()
                v8.Parent = u1.PrimaryPart
                v8:Play()
                _G.destroy(v8, 2)
            end)
            u7.Run:GetMarkerReachedSignal("step2"):Connect(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                local v9 = script.s1:Clone()
                v9.Parent = u1.PrimaryPart
                v9:Play()
                _G.destroy(v9, 2)
            end)
            local u10 = 1
            local u11 = 0
            u7.Run:GetMarkerReachedSignal("scream"):Connect(function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u10
                    [3] = u1
                --]]
                if tick() - u11 >= 2 then
                    u11 = tick()
                    u10 = u10 + 1
                    if u10 > 4 then
                        u10 = 1
                    end
                    local v12 = script["v" .. u10]:Clone()
                    v12.Parent = u1.PrimaryPart
                    v12:Play()
                    _G.destroy(v12, 3)
                end
            end)
            local u13 = "Idle"
            u3.Running:Connect(function(p14) --[[ Line: 76 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u13
                    [3] = u7
                --]]
                if u6 + 5 < p14 then
                    if u13 ~= "Running" then
                        u13 = "Running"
                        for _, v15 in u7 do
                            v15:Stop()
                        end
                        u7.Run:Play()
                        u7.Run:AdjustSpeed(1.5)
                        return
                    end
                elseif p14 > 0.749 then
                    if u13 ~= "Walking" then
                        u13 = "Walking"
                        for _, v16 in u7 do
                            v16:Stop()
                        end
                        u7.Walk:Play()
                        return
                    end
                elseif u13 ~= "Idle" then
                    u13 = "Idle"
                    for _, v17 in u7 do
                        v17:Stop()
                    end
                    u7.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 98 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u7
                --]]
                if u13 ~= "Jump" then
                    u13 = "Jump"
                    for _, v18 in u7 do
                        v18:Stop()
                    end
                    u7.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p19) --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u13
                    [3] = u7
                --]]
                if p19 and (u3.FloorMaterial == Enum.Material.Air and u13 ~= "Fall") then
                    u13 = "Fall"
                    for _, v20 in u7 do
                        v20:Stop()
                    end
                    u7.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p21) --[[ Line: 114 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u13
                    [3] = u7
                --]]
                if p21 and (u3.FloorMaterial == Enum.Material.Air and u13 ~= "Fall") then
                    u13 = "Fall"
                    for _, v22 in u7 do
                        v22:Stop()
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