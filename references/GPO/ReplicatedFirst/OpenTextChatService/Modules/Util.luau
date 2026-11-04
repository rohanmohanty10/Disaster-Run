 

return {
    ["WaitForChildWhichIsA"] = function(p1, u2, p3) --[[ Line: 3 ]]
        local u4 = p1:FindFirstChildWhichIsA(u2)
        if u4 ~= nil then
            return u4
        end
        local u5 = Instance.new("BindableEvent")
        local v6 = nil
        local v7 = p1.Destroying:Connect(function() --[[ Line: 8 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5:Fire()
        end)
        local v9 = p1.ChildAdded:Connect(function(p8) --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u4
                [3] = u5
            --]]
            if p8:IsA(u2) then
                u4 = p8
                u5:Fire()
            end
        end)
        if p3 == (1 / 0) or tostring(p3) == "nan" then
            p3 = nil
        end
        if p3 ~= nil then
            v6 = task.delay(p3, u5.Fire, u5)
        end
        u5.Event:Wait()
        u5:Destroy()
        v7:Disconnect()
        v9:Disconnect()
        if v6 ~= nil then
            task.cancel(v6)
        end
        return u4
    end
}