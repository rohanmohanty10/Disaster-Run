 

local u24 = {
    ["ClassName"] = "Maid",
    ["new"] = function() --[[ Name: new, Line 37 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        local v1 = u24
        return setmetatable({
            ["_tasks"] = {}
        }, v1)
    end,
    ["isMaid"] = function(p2) --[[ Name: isMaid, Line 54 ]]
        local v3
        if type(p2) == "table" then
            v3 = p2.ClassName == "Maid"
        else
            v3 = false
        end
        return v3
    end,
    ["__index"] = function(p4, p5) --[[ Name: __index, Line 73 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        if u24[p5] then
            return u24[p5]
        else
            return p4._tasks[p5]
        end
    end,
    ["__newindex"] = function(p6, p7, p8) --[[ Name: __newindex, Line 99 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        if u24[p7] ~= nil then
            error(("Cannot use \'%s\' as a Maid key"):format((tostring(p7))), 2)
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
    end,
    ["GiveTask"] = function(p11, p12) --[[ Name: GiveTask, Line 130 ]]
        if not p12 then
            error("Task cannot be false or nil", 2)
        end
        local v13 = #p11._tasks + 1
        p11[v13] = p12
        if type(p12) == "table" and not p12.Destroy then
            warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
        end
        return v13
    end,
    ["GivePromise"] = function(u14, p15) --[[ Name: GivePromise, Line 151 ]]
        if not p15:IsPending() then
            return p15
        end
        local v16 = p15.resolved(p15)
        local u17 = u14:GiveTask(v16)
        v16:Finally(function() --[[ Line: 160 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u17
            --]]
            u14[u17] = nil
        end)
        return v16
    end,
    ["DoCleaning"] = function(p18) --[[ Name: DoCleaning, Line 183 ]]
        local v19 = p18._tasks
        for v20, v21 in pairs(v19) do
            if typeof(v21) == "RBXScriptConnection" then
                v19[v20] = nil
                v21:Disconnect()
            end
        end
        local v22, v23 = next(v19)
        while v23 ~= nil do
            v19[v22] = nil
            if type(v23) == "function" then
                v23()
            elseif typeof(v23) == "RBXScriptConnection" then
                v23:Disconnect()
            elseif v23.Destroy then
                v23:Destroy()
            end
            v22, v23 = next(v19)
        end
    end
}
u24.Destroy = u24.DoCleaning
return u24