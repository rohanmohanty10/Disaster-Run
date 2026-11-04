 

local u1 = Instance.new("BindableEvent")
local _ = game:GetService("RunService").Heartbeat
local u2 = 0
game:GetService("RunService").Heartbeat:Connect(function(p3) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    u2 = u2 + p3
    if u2 >= 0.016666666666666666 then
        local v4 = u2 / 0.016666666666666666
        local v5 = math.floor(v4)
        for _ = 1, v5 do
            u1:Fire()
        end
        u2 = u2 - v5 * 0.016666666666666666
    end
end)
return function(p6) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p6 == 0 or p6 == nil then
        u1.Event:Wait()
    else
        for _ = 1, p6 do
            u1.Event:Wait()
        end
    end
end