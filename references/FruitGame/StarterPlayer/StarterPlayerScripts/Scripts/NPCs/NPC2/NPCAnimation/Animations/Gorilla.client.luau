 

local u1 = script:WaitForChild("Character").Value
if u1 then
    local v2 = workspace
    local v3 = u1:WaitForChild("Humanoid", 5)
    if v3 and v3.Health > 0 then
        local v4 = v3:WaitForChild("Animator", 3) or v3
        if v3.Parent and (v3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2))) then
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Gorilla")
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
            local function u9(p8) --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                if p8:match("step") and (p8 ~= "step" and (_G.footstep and (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.p).magnitude <= 150)) then
                    _G.footstep(p8, nil, u1)
                end
            end
            u7.Walk.KeyframeReached:Connect(function(p10) --[[ Line: 38 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9(p10)
            end)
            if u7.Run ~= nil then
                u7.Run.KeyframeReached:Connect(function(p11) --[[ Line: 42 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                    --]]
                    u9(p11)
                end)
            end
            local u12 = "Idle"
            v3.Running:Connect(function(p13) --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u12
                    [3] = u7
                --]]
                if u6 + 5 < p13 then
                    if u12 ~= "Running" then
                        u12 = "Running"
                        for _, v14 in u7 do
                            v14:Stop()
                        end
                        u7.Run:Play()
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
            v3.Jumping:Connect(function() --[[ Line: 73 ]]
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
            v3.FreeFalling:Connect(function(p18) --[[ Line: 80 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u7
                --]]
                if p18 and u12 ~= "Fall" then
                    u12 = "Fall"
                    for _, v19 in u7 do
                        v19:Stop()
                    end
                    u7.Fall:Play()
                end
            end)
            v3.FallingDown:Connect(function(p20) --[[ Line: 89 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u7
                --]]
                if p20 and u12 ~= "Fall" then
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