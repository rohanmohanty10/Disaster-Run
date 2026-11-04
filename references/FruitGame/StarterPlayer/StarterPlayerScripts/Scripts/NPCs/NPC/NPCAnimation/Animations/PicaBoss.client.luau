 

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
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Pica")
            local _ = script:WaitForChild("Walkspeed").Value
            local u6 = {
                ["Idle"] = v4:LoadAnimation(v5.Idle),
                ["Walk"] = v4:LoadAnimation(v5.Walk),
                ["Run"] = v4:LoadAnimation(v5.Walk),
                ["Fall"] = v4:LoadAnimation(v5.Fall),
                ["Jump"] = v4:LoadAnimation(v5.Jump)
            }
            u6.Idle.Priority = Enum.AnimationPriority.Idle
            u6.Jump.Priority = Enum.AnimationPriority.Core
            u6.Fall.Priority = Enum.AnimationPriority.Core
            local u7 = {}
            local function u10(p8) --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u7
                --]]
                for _, v9 in u6 do
                    if v9.IsPlaying == true and v9 ~= p8 then
                        u7[v9] = v9.TimePosition
                        v9:Stop()
                    end
                end
            end
            u6.Walk:GetMarkerReachedSignal("stomp"):Connect(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u3
                --]]
                if u1.PrimaryPart.Anchored ~= true and u3.WalkSpeed > 0 then
                    _G.PlaySound(u1.PrimaryPart, script.Stomps:GetChildren()[math.random(1, 3)])
                end
            end)
            u3:GetPropertyChangedSignal("WalkToPoint"):Connect(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u10
                    [3] = u6
                    [4] = u7
                --]]
                local v11 = u3:GetState()
                if v11 == Enum.HumanoidStateType.Running then
                    u10(u6.Walk)
                    local v12 = u6.Walk
                    if v12 and v12.IsPlaying == false then
                        v12:Play()
                        if u7[v12] then
                            v12.TimePosition = u7[v12]
                            return
                        end
                    end
                elseif v11 == Enum.HumanoidStateType.None then
                    u10(u6.Idle)
                    local v13 = u6.Idle
                    if v13 and v13.IsPlaying == false then
                        v13:Play()
                        if u7[v13] then
                            v13.TimePosition = u7[v13]
                        end
                    end
                end
            end)
            local u14 = u1:WaitForChild("Info", 3)
            if u14 then
                u14.Target.Changed:Connect(function() --[[ Line: 79 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u10
                        [3] = u6
                        [4] = u7
                    --]]
                    if u14.Target.Value == nil then
                        u10(u6.Idle)
                        local v15 = u6.Idle
                        if v15 and v15.IsPlaying == false then
                            v15:Play()
                            if u7[v15] then
                                v15.TimePosition = u7[v15]
                            end
                        end
                    end
                end)
            end
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