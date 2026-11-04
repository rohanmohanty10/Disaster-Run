 

local u1 = script:WaitForChild("Character").Value
if u1 then
    local v2 = workspace
    local v3 = u1:WaitForChild("Humanoid", 5)
    if v3:IsA("Humanoid") == false then
        script:Destroy()
        return
    elseif v3 and v3.Health > 0 then
        local v4 = v3:WaitForChild("Animator", 3) or v3
        if v3.Parent and (v3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2))) then
            local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("MoriaBoss")
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
            local u8 = "Idle"
            v3.Running:Connect(function(p9) --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u8
                    [3] = u7
                --]]
                if u6 + 5 < p9 then
                    if u8 ~= "Running" then
                        u8 = "Running"
                        for _, v10 in u7 do
                            v10:Stop()
                        end
                        u7.Run:Play()
                        u7.Run:AdjustSpeed(1.5)
                        return
                    end
                elseif p9 > 0.749 then
                    if u8 ~= "Walking" then
                        u8 = "Walking"
                        for _, v11 in u7 do
                            v11:Stop()
                        end
                        u7.Walk:Play()
                        return
                    end
                elseif u8 ~= "Idle" then
                    u8 = "Idle"
                    for _, v12 in u7 do
                        v12:Stop()
                    end
                    u7.Idle:Play()
                end
            end)
            u7.Idle:Play()
            if u1:FindFirstChild("Overhead") == nil then
                local v13 = script.Overhead:Clone()
                v13.Adornee = u1.Head
                v13.Health.Frame.Script.char.Value = u1
                v13.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
                v13.Health.Frame.Script.Disabled = false
                if u1.Name ~= "Moria" then
                    v13.NameT.Text = "Moria\'s Sillhouette"
                end
            end
            u7.Run:GetMarkerReachedSignal("step1"):Connect(function(_) --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                _G.PlaySound(u1.PrimaryPart, script.MoriaStep1)
            end)
            u7.Run:GetMarkerReachedSignal("step2"):Connect(function(_) --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                _G.PlaySound(u1.PrimaryPart, script.MoriaStep2)
            end)
            while true do
                task.wait(math.random(10, 20))
                _G.PlaySound(u1.Head, script["MoriaLaugh" .. math.random(1, 5)]).Parent = u1.PrimaryPart
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