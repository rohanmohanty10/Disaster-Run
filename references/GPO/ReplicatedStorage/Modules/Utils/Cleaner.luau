 

game:GetService("HttpService")
local u1 = {}
for _, v2 in script.Types:GetChildren() do
    u1[v2.Name] = require(v2)
end
local u22 = {
    ["__index"] = function(p3, p4) --[[ Name: __index, Line 16 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        return u22[p4] or p3._tasks[p4]
    end,
    ["__newindex"] = function(p5, p6, p7) --[[ Name: __newindex, Line 22 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        if u22[p6] then
            warn((("[Cleaner]: %* is an existing method of class"):format(p6)))
            return
        elseif p5._tasks[p6] ~= p7 then
            p5:_cleanTask(p6)
            p5:_addTaskWithID(p7, p6)
        end
    end,
    ["new"] = function() --[[ Name: new, Line 37 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        local v8 = u22
        return setmetatable({
            ["_tasks"] = {},
            ["_length"] = 0
        }, v8)
    end,
    ["_addTaskWithID"] = function(p9, p10, p11) --[[ Name: _addTaskWithID, Line 44 ]]
        p9._tasks[p11] = p10
    end,
    ["AddTask"] = function(p12, ...) --[[ Name: AddTask, Line 48 ]]
        for _, v13 in { ... } do
            p12._length = p12._length + 1
            p12:_addTaskWithID(v13, p12._length)
        end
    end,
    ["_cleanTask"] = function(p14, p15) --[[ Name: _cleanTask, Line 56 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v16 = p14._tasks
        local v17 = v16[p15]
        if v17 then
            local v18 = typeof(v17)
            local v19 = u1[v18]
            v16[p15] = nil
            if v19 then
                v19(v17)
            else
                warn((("[Cleaner]: Unable to clean %*"):format(v18)))
            end
        else
            return
        end
    end,
    ["Destroy"] = function(p20) --[[ Name: Destroy, Line 75 ]]
        for v21 in p20._tasks do
            p20:_cleanTask(v21)
        end
        p20._length = 0
    end
}
return u22