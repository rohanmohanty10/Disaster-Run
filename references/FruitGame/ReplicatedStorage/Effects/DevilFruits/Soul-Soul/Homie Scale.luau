 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local u3 = {}
return {
    ["start"] = function(u4, u5) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        local u6 = u5.Homie
        local u7 = u5.Time
        local u8 = u6:GetScale()
        local u9 = u5.Scale
        local u10 = u5.Reverses
        local u11 = nil
        local v12 = (workspace.CurrentCamera.CFrame.Position - u6.PrimaryPart.Position).Magnitude
        if u5.Interval == nil then
            u5.Interval = 0.016666666666666666
            if _G.mobile == true then
                u5.Interval = 0.03333333333333333
            end
        end
        if u5.Interval and u5.Interval <= 0 then
            u5.Interval = nil
        end
        if v12 >= 1000 then
            u5.Interval = 0.1
        end
        if u3[u6] then
            u3[u6]:Disconnect()
            u3[u6] = nil
        end
        if u11 then
            u11:Disconnect()
            u11 = nil
        end
        local u13 = 0
        local u14 = 0
        local u15 = 0
        u3[u6] = u2.Heartbeat:Connect(function(p16) --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u7
                [3] = u5
                [4] = u15
                [5] = u13
                [6] = u1
                [7] = u6
                [8] = u3
                [9] = u11
                [10] = u8
                [11] = u9
                [12] = u10
                [13] = u4
            --]]
            local v17 = u14 + p16 / u7
            u14 = math.min(v17, 1)
            if u5.Interval then
                if tick() - u15 < u5.Interval then
                    return
                end
                u15 = tick()
            end
            u13 = u1:GetValue(u14, u5.EasingStyle or Enum.EasingStyle.Linear, u5.EasingDirection or Enum.EasingDirection.Out)
            if u6.Parent and u14 < 1 then
                local v18 = u6
                local v19 = u8 + (u9 - u8) * u13
                v18:ScaleTo((math.max(0.01, v19)))
            else
                local v20 = u6
                if u3[v20] then
                    u3[v20]:Disconnect()
                    u3[v20] = nil
                end
                if u11 then
                    u11:Disconnect()
                    u11 = nil
                end
                local v21 = u6
                local v22 = u8 + (u9 - u8) * u13
                v21:ScaleTo((math.max(0.01, v22)))
                if u10 and u14 == 1 then
                    u5.Scale = 1
                    u5.Reverses = nil
                    u4:start(u5)
                end
            end
        end)
        u11 = u6.Destroying:Connect(function() --[[ Line: 84 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u11
            --]]
            local v23 = u6
            if u3[v23] then
                u3[v23]:Disconnect()
                u3[v23] = nil
            end
            if u11 then
                u11:Disconnect()
                u11 = nil
            end
        end)
    end
}