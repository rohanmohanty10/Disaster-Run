 

local u27 = {
    ["ClassName"] = "Maid",
    ["new"] = function() --[[ Name: new, Line 25 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        local v1 = u27
        return setmetatable({
            ["_tasks"] = {}
        }, v1)
    end,
    ["isMaid"] = function(p2) --[[ Name: isMaid, Line 32 ]]
        local v3
        if type(p2) == "table" then
            v3 = p2.ClassName == "Maid"
        else
            v3 = false
        end
        return v3
    end,
    ["__index"] = function(p4, p5) --[[ Name: __index, Line 38 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        if u27[p5] then
            return u27[p5]
        else
            return p4._tasks[p5]
        end
    end,
    ["__newindex"] = function(p6, p7, p8) --[[ Name: __newindex, Line 55 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        if u27[p7] ~= nil then
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
    end,
    ["GiveTask"] = function(p11, p12) --[[ Name: GiveTask, Line 83 ]]
        if p12 then
            local v13 = #p11._tasks + 1
            p11[v13] = p12
            if type(p12) == "table" and not p12.Destroy then
                warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
            end
            return v13
        end
        warn("Task cannot be false or nil", 2)
    end,
    ["GivePromise"] = function(u14, p15) --[[ Name: GivePromise, Line 99 ]]
        if not p15:IsPending() then
            return p15
        end
        local v16 = p15.resolved(p15)
        local u17 = u14:GiveTask(v16)
        v16:Finally(function() --[[ Line: 108 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u17
            --]]
            u14[u17] = nil
        end)
        return v16
    end,
    ["DoCleaning"] = function(p18) --[[ Name: DoCleaning, Line 117 ]]
        local v19 = p18._tasks
        if v19 == nil then
            warn("NO TASKS IN MAIDTASK TO DESTROY")
        else
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
    end,
    ["TagAll"] = function(_, p24) --[[ Name: TagAll, Line 147 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        for _, v25 in pairs(p24) do
            u27:GiveTask(v25)
        end
    end,
    ["AttachToInstance"] = function(_, p26) --[[ Name: AttachToInstance, Line 153 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        p26.Destroying:Connect(function() --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u27
            --]]
            u27:Destroy()
        end)
    end
}
u27.Destroy = u27.DoCleaning
return u27