 

local u1 = game:GetService("RunService")
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local _ = _G.Ess
return {
    ["start"] = function(_, p2, u3, p4) --[[ Name: start, Line 10 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            Random.new()
            local u5 = false
            local _ = p4 / 30 * 1.1
            tick()
            tick()
            tick()
            local u6 = script.StartBurst:Clone()
            u6.CFrame = p2 * CFrame.Angles(1.5707963267948966, 0, 0) - Vector3.new(0, 1.7, 0)
            u6.Parent = workspace.Effects
            Emit(u6:GetChildren(), false)
            Emit(u6.Attachment, false)
            Emit(u6.StartSpin, false, 0.25)
            _G.destroy(u6.StartSpin, 0.8)
            TweenCreate(u6.PointLight, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Range"] = 8
            })
            task.delay(0.8, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                u5 = true
            end)
            local u10 = u1.Heartbeat:Connect(function() --[[ Line: 50 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                local v7 = u3.Position
                local v8 = u3.Target.Value
                if v8 ~= nil then
                    local v9 = v8.Position
                    u3.CFrame = u3.CFrame:Lerp(CFrame.new(v7, v9), 0.1)
                end
            end)
            u3.Destroying:Connect(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u6
                --]]
                if u10 then
                    u10:Disconnect()
                    u10 = nil
                end
                Emit(u6:GetDescendants(), false)
                _G.destroy(u6, 1)
            end)
            task.delay(p4, function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u6
                --]]
                if u10 then
                    u10:Disconnect()
                    u10 = nil
                end
                TweenCreate(u6.PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ["Brightness"] = 6,
                    ["Range"] = 0
                })
                task.wait(0.25)
                Emit(u6:GetDescendants(), false)
                _G.destroy(u6, 1)
            end)
        end
    end
}