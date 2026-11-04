 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = workspace.Effects
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
        --]]
        local u5 = p4.StartCFrame
        local u6 = u5 + Vector3.new(0, 20, 0)
        local u7 = script.DeathHeart:Clone()
        u7.Anchored = true
        u7.CFrame = u5
        u7.Parent = u3
        local v8 = TweenInfo.new(1.3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, false, 0)
        local u9 = 1
        local u10 = 0
        local u11 = nil
        u11 = u1.PostSimulation:Connect(function(p12) --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u9
                [3] = u7
                [4] = u5
                [5] = u6
                [6] = u11
            --]]
            u10 = u10 + p12 / 1.3
            u9 = u9 + p12 * 4
            local v13 = u10
            u7.CFrame = u5:Lerp(u6, (math.min(v13, 1))) * CFrame.Angles(0, -u9, 0)
            if u10 >= 2 and u11 then
                u11:Disconnect()
                u11 = nil
            end
        end)
        u2:Create(u7, v8, {
            ["Color"] = Color3.fromRGB(255, 255, 255)
        }):Play()
        task.wait(1.3)
        u7.Death:Play()
        task.wait(0.7)
        u7.Transparency = 1
        _G.customEmit(u7)
        task.delay(2, u7.Destroy, u7)
    end
}