 

local v1 = script.Parent.Parent.Signals
local u2 = require(v1:WaitForChild("GoodSignal"))
local u3 = {}
u3.__index = u3
function u3.new() --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v4 = {
        ["Queues"] = {},
        ["OnQueueAdded"] = u2.new(),
        ["OnQueueRemoved"] = u2.new()
    }
    local v5 = u3
    return setmetatable(v4, v5)
end
function u3.IsInQueue(p6, p7) --[[ Line: 22 ]]
    return p6.Queues[p7]
end
function u3.AddQueue(p8, p9) --[[ Line: 26 ]]
    if p8:IsInQueue(p9) == nil then
        p8.Queues[p9] = true
        p8.OnQueueAdded:Fire(p9)
    else
        warn(p9, "Already in queue!")
    end
end
function u3.RemoveQueue(p10, p11) --[[ Line: 32 ]]
    if p10:IsInQueue(p11) == nil then
        warn(p11, "Queue not found!")
    else
        p10.Queues[p11] = nil
        p10.OnQueueRemoved:Fire(p11)
    end
end
return u3