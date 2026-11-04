 

local v1 = script:WaitForChild("Character").Value
if v1 then
    local v2 = workspace
    local v3 = v1:WaitForChild("Humanoid", 5)
    if v3:IsA("Humanoid") == false then
        script:Destroy()
        return
    elseif v3 and v3.Health > 0 then
        local v4 = v3:WaitForChild("Animator", 3) or v3
        if v3.Parent and (v3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2))) then
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("CrazyWolf")
            local _ = script:WaitForChild("Walkspeed").Value
            local u6 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Run"] = v4:LoadAnimation(v5.Run)
            }
            u6.Idle.Priority = Enum.AnimationPriority.Idle
            local u7 = {}
            local u8 = "Idle"
            v3.Running:Connect(function(p9) --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u6
                    [3] = u7
                --]]
                if p9 > 0.1 then
                    if u8 ~= "Running" or u6.Run.IsPlaying == false then
                        u8 = "Running"
                        for v10, _ in u6 do
                            if u6[v10].IsPlaying ~= false then
                                u7[v10] = u6[v10].TimePosition
                                u6[v10]:Stop()
                            end
                        end
                        if u7.Run == nil then
                            u7.Run = 0
                        end
                        u6.Run:Play()
                        u6.Run.TimePosition = u7.Run
                        u6.Run:AdjustSpeed(1.25)
                        return
                    end
                elseif u8 ~= "Idle" then
                    u8 = "Idle"
                    for v11, _ in u6 do
                        if u6[v11].IsPlaying ~= false then
                            u7[v11] = u6[v11].TimePosition
                            u6[v11]:Stop()
                        end
                    end
                    u6.Idle:Play()
                end
            end)
            u6.Idle:Play()
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end