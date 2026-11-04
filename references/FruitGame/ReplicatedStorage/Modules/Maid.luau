 

local u1 = {}
u1.__index = u1
function u1.new() --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = {
        ["_tasks"] = {},
        ["Destroy"] = u1.Clean,
        ["IsMaid"] = true
    }
    local v3 = u1
    return setmetatable(v2, v3)
end
function u1.__index(p4, p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u1[p5] then
        return u1[p5]
    else
        return p4._tasks[p5]
    end
end
function u1.__newindex(p6, p7, p8) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u1[p7] ~= nil then
        error(("\'%s\' is reserved"):format((tostring(p7))), 2)
    end
    local v9 = p6._tasks
    local v10 = v9[p7]
    if v10 ~= p8 then
        v9[p7] = p8
        if v10 then
            if type(v10) == "function" then
                v10()
                return
            end
            if typeof(v10) == "RBXScriptConnection" then
                v10:Disconnect()
                return
            end
            if v10.Destroy then
                v10:Destroy()
            end
        end
    end
end
function u1.AddTask(p11, p12) --[[ Line: 41 ]]
    if not p12 then
        error("Task cannot be false or nil", 2)
    end
    local v13 = #p11._tasks + 1
    p11[v13] = p12
    if type(p12) == "table" then
        print(p12)
        if not (p12.Disconnect or p12.Destroy) then
            warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
        end
    end
    return v13
end
function u1.Clean(p14) --[[ Line: 61 ]]
    local v15 = p14._tasks
    for v16, v17 in pairs(v15) do
        if typeof(v17) == "RBXScriptConnection" then
            v15[v16] = nil
            v17:Disconnect()
        end
    end
    local v18, v19 = next(v15)
    while v19 ~= nil do
        v15[v18] = nil
        if type(v19) == "function" then
            v19()
        elseif typeof(v19) == "RBXScriptConnection" then
            v19:Disconnect()
        elseif typeof(v19) == "thread" then
            task.cancel(v19)
        elseif v19.Destroy then
            v19:Destroy()
        elseif v19.Disconnect then
            v19:Disconnect()
        end
        v18, v19 = next(v15)
    end
end
u1.Give = u1.AddTask
u1.give = u1.AddTask
return u1