 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local _ = workspace.Effects
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local u4 = p3.Heart
        local u5 = u4.CFrame
        local u6 = 1
        local u7 = nil
        u7 = u1.PostSimulation:Connect(function(p8) --[[ Line: 17 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u4
                [3] = u5
                [4] = u7
                [5] = u2
            --]]
            u6 = u6 + p8 * 2
            u4.CFrame = u5 * CFrame.Angles(0, -u6, 0)
            if u4:GetAttribute("Done") then
                u7:Disconnect()
                u7 = nil
                u2:Create(u4, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }):Play()
            end
        end)
    end
}