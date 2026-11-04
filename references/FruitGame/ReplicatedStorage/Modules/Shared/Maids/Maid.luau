 

local u17 = {
    ["ClassName"] = "Maid",
    ["new"] = function() --[[ Name: new, Line 28 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        local v1 = u17
        return setmetatable({
            ["_tasks"] = {}
        }, v1)
    end,
    ["isMaid"] = function(p2) --[[ Name: isMaid, Line 34 ]]
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
            [1] = u17
        --]]
        if u17[p5] then
            return u17[p5]
        else
            return p4._tasks[p5]
        end
    end,
    ["__newindex"] = function(p6, p7, p8) --[[ Name: __newindex, Line 46 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        if u17[p7] ~= nil then
            error(("Cannot use \'%s\' as a Maid key"):format((tostring(p7))), 2)
        end
        local v9 = p6._tasks
        local u10 = v9[p7]
        if u10 ~= p8 then
            v9[p7] = p8
            if u10 then
                if type(u10) == "function" then
                    u10()
                    return
                end
                if type(u10) == "thread" then
                    local v11
                    if coroutine.running() == u10 then
                        v11 = nil
                    else
                        v11 = pcall(function() --[[ Line: 66 ]]
                            --[[
                            Upvalues:
                                [1] = u10
                            --]]
                            task.cancel(u10)
                        end)
                    end
                    if not v11 then
                        task.defer(function() --[[ Line: 72 ]]
                            --[[
                            Upvalues:
                                [1] = u10
                            --]]
                            task.cancel(u10)
                        end)
                        return
                    end
                else
                    if typeof(u10) == "RBXScriptConnection" then
                        u10:Disconnect()
                        return
                    end
                    if u10.Destroy then
                        u10:Destroy()
                    end
                end
            end
        end
    end,
    ["Add"] = function(p12, p13) --[[ Name: Add, Line 84 ]]
        if not p13 then
            error("Task cannot be false or nil", 2)
        end
        p12[#p12._tasks + 1] = p13
        if type(p13) == "table" and not p13.Destroy then
            warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
        end
        return p13
    end,
    ["GiveTask"] = function(p14, p15) --[[ Name: GiveTask, Line 98 ]]
        if not p15 then
            error("Task cannot be false or nil", 2)
        end
        local v16 = #p14._tasks + 1
        p14[v16] = p15
        if type(p15) == "table" and not p15.Destroy then
            warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
        end
        return v16
    end
}
u17.AddTask = u17.Add
function u17.GivePromise(u18, p19) --[[ Line: 115 ]]
    if not p19:IsPending() then
        return p19
    end
    local v20 = p19.resolved(p19)
    local u21 = u18:GiveTask(v20)
    v20:Finally(function() --[[ Line: 124 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u21
        --]]
        u18[u21] = nil
    end)
    return v20
end
function u17.DoCleaning(p22) --[[ Line: 131 ]]
    local v23 = p22._tasks
    for v24, v25 in pairs(v23) do
        if typeof(v25) == "RBXScriptConnection" then
            v23[v24] = nil
            v25:Disconnect()
        end
    end
    local v26, u27 = next(v23)
    while u27 ~= nil do
        v23[v26] = nil
        if type(u27) == "function" then
            u27()
        elseif type(u27) == "thread" then
            local v28
            if coroutine.running() == u27 then
                v28 = nil
            else
                v28 = pcall(function() --[[ Line: 151 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                    --]]
                    task.cancel(u27)
                end)
            end
            if not v28 then
                task.defer(function() --[[ Line: 158 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                    --]]
                    task.cancel(u27)
                end)
            end
        elseif typeof(u27) == "RBXScriptConnection" then
            u27:Disconnect()
        elseif u27.Destroy then
            u27:Destroy()
        end
        v26, u27 = next(v23)
    end
end
function u17.AttachToInstance(u29, u30) --[[ Line: 171 ]]
    warn("hooked ", u30)
    u29:GiveTask(u30:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 174 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u29
        --]]
        if not u30.Parent then
            print("destroyed", u30)
            u29:Destroy()
        end
    end))
end
u17.Destroy = u17.DoCleaning
return u17