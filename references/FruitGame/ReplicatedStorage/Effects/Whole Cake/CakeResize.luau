 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
return {
    ["start"] = function(_, u3) --[[ Name: start, Line 6 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        warn("tick", u3)
        task.wait(1)
        for _, v4 in ipairs(u3.Cakes) do
            v4:ScaleTo(0.01)
        end
        local u5 = 0
        local u6 = nil
        u6 = u1.Heartbeat:Connect(function(p7) --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u2
                [3] = u3
                [4] = u6
            --]]
            u5 = u5 + p7
            local v8 = u2
            local v9 = u5 / 3
            local v10 = v8:GetValue(math.min(v9, 1), Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
            for _, v11 in ipairs(u3.Cakes) do
                v11:ScaleTo(0.01 + (v11:GetAttribute("OriginalSize") - 0.01) * v10)
            end
            if u5 >= 3 then
                u6:Disconnect()
                u6 = nil
            end
        end)
    end
}