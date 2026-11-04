 

repeat
    task.wait()
until game.Players.LocalPlayer
local u1 = game.Players.LocalPlayer
local u2 = {}
local u3 = u1:GetMouse()
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    for _, v4 in u2 do
        local v5 = v4.UIObj
        local v6 = u3.X
        local v7 = u3.Y
        if v5.AbsolutePosition.X < v6 and (v5.AbsolutePosition.Y < v7 and (v6 < v5.AbsolutePosition.X + v5.AbsoluteSize.X and v7 < v5.AbsolutePosition.Y + v5.AbsoluteSize.Y)) then
            if not v4.MouseIn and (not v4.UIObj.Parent or (not v4.UIObj.Parent:IsA("Frame") or v4.UIObj.Parent.Visible ~= false)) then
                v4.MouseIn = true
                v4.EnteredEvent:Fire()
            end
        elseif v4.MouseIn then
            v4.MouseIn = false
            v4.LeaveEvent:Fire()
        end
    end
end)
return {
    ["MouseEnterLeaveEvent"] = function(u8) --[[ Name: MouseEnterLeaveEvent, Line 6 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        if u2[u8] then
            return u2[u8].EnterEvent, u2[u8].LeaveEvent
        end
        local u9 = {
            ["UIObj"] = u8
        }
        local u10 = Instance.new("BindableEvent")
        local u11 = Instance.new("BindableEvent")
        u9.EnteredEvent = u10
        u9.MouseIn = false
        u9.LeaveEvent = u11
        u9.ParentScreenUI = u8:FindFirstAncestorWhichIsA("ScreenGui")
        u2[u8] = u9
        u8.Destroying:Connect(function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u11
                [3] = u2
                [4] = u8
            --]]
            u10:Destroy()
            u11:Destroy()
            u2[u8] = nil
        end)
        task.spawn(function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u9
            --]]
            game["Run Service"].Heartbeat:Wait()
            local v12 = u1:GetMouse()
            local v13 = v12.X
            local v14 = v12.Y
            if u9.UIObj.AbsolutePosition.X < v13 and (u9.UIObj.AbsolutePosition.Y < v14 and (v13 < u9.UIObj.AbsolutePosition.X + u9.UIObj.AbsoluteSize.X and (v14 < u9.UIObj.AbsolutePosition.Y + u9.UIObj.AbsoluteSize.Y and u9.MouseIn ~= true))) then
                u9.MouseIn = true
                if u9.EnteredEvent then
                    u9.EnteredEvent:Fire()
                end
            end
        end)
        return u10.Event, u11.Event
    end
}