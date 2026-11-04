 

local v1 = {}
Emit = _G.Emit
function v1.start(_, p2, u3) --[[ Line: 4 ]]
    local u4 = p2:FindFirstChild("Head")
    if u4 ~= nil then
        local u5 = script.Concussion:Clone()
        u5.CFrame = u4.CFrame
        u5.Parent = workspace.Effects
        local u6 = tick()
        _G.PlaySound(u5, script["Audio/GumGiantPistolConcussionProc"])
        local u12 = game:GetService("RunService").Heartbeat:Connect(function(_) --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u5
                [4] = u4
            --]]
            local v7 = tick() - u6
            local v8 = v7 / u3 * 1440 % 360
            local v9 = math.rad(v8)
            local v10 = v7 / u3 * 10
            local v11 = math.sin(v10) / 3
            u5.CFrame = u4.CFrame * CFrame.Angles(v11, 0, 0) * CFrame.Angles(0, v9, 0)
        end)
        task.delay(u3, function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u12
            --]]
            Emit(u5:GetDescendants(), false)
            task.delay(0.5, function() --[[ Line: 32 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                u5.Tleft.Enabled = false
                u5.Tright.Enabled = false
            end)
            task.wait(1.75)
            u12:Disconnect()
            u5:Destroy()
        end)
    end
end
return v1