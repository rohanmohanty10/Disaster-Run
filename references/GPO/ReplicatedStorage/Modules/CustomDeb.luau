 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local u2 = Instance.new("BindableEvent")
u2.Name = "DestroyEvent"
u2.Event:Connect(function(p3, p4) --[[ Line: 9 ]]
    if p3 then
        if p4 then
            local v5 = (p4 == nil or p4 ~= p4) and 0 or p4
            if typeof(p3) == "table" then
                for _, v6 in ipairs(p3) do
                    task.delay(v5, v6.Destroy, v6)
                end
                return
            elseif typeof(p3) == "Instance" then
                task.delay(v5, p3.Destroy, p3)
            else
                warn(tostring(p3) .. " is not a instance!")
            end
        elseif typeof(p3) == "Instance" then
            p3:Destroy()
        else
            for _, v7 in ipairs(p3) do
                v7:Destroy()
            end
        end
    else
        warn("Non debris was passed!")
        return
    end
end)
u2.Parent = v1
return function(p8, p9) --[[ Name: AddItem, Line 52 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = 100
    if p9 == nil then
        if typeof(p8) == "Instance" then
            pcall(p8.Destroy, p8)
        else
            for v11 = 1, #p8 do
                if p8[v11] then
                    p8[v11]:Destroy()
                end
                v10 = v10 - 1
                if v10 <= 0 then
                    game:GetService("RunService").Heartbeat:Wait()
                    v10 = 100
                end
            end
        end
    elseif typeof(p8) == "table" then
        for v12 = 1, #p8 do
            local v13 = p8[v12]
            if typeof(v13) == "Instance" then
                u2:Fire(p8[v12], p9)
            end
        end
    elseif p8 and (p9 and typeof(p8) == "Instance") then
        u2:Fire(p8, p9)
    end
end