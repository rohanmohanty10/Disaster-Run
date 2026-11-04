 

local u1 = {}
u1.__index = u1
function u1.new() --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = u1
    local v3 = setmetatable({}, v2)
    v3.pendingTasks = {}
    v3.running = false
    return v3
end
function u1.QueueTask(p4, ...) --[[ Line: 12 ]]
    local v5 = p4.pendingTasks
    table.insert(v5, { ... })
    if not p4.running then
        p4:Run()
    end
end
function u1.Run(u6) --[[ Line: 19 ]]
    u6.running = true
    task.spawn(function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        while #u6.pendingTasks > 0 do
            local v7 = table.remove(u6.pendingTasks, 1)
            v7[1](table.unpack(v7, 2))
        end
        u6.running = false
    end)
end
return u1