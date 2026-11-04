 

local u6 = {
    ["Instance"] = function(p1) --[[ Name: Instance, Line 8 ]]
        if p1.Parent then
            p1:Destroy()
        end
    end,
    ["table"] = function(p2) --[[ Name: table, Line 13 ]]
        if p2.Destroy then
            p2:Destroy()
        end
    end,
    ["RBXScriptConnection"] = function(p3) --[[ Name: RBXScriptConnection, Line 18 ]]
        p3:Disconnect()
    end,
    ["thread"] = function(p4) --[[ Name: thread, Line 21 ]]
        if coroutine.status(p4) ~= "dead" then
            task.defer(task.cancel, p4)
        end
    end,
    ["function"] = function(p5) --[[ Line: 26 ]]
        p5()
    end
}
local u30 = {
    ["__newindex"] = function(p7, p8, p9) --[[ Name: AddDisposable, Line 45 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        if typeof(p9) == "table" and not p9.Destroy then
            warn("\226\157\140 [Cleaner]: Table does not have a cleanup method")
        else
            local v10 = p7._disposables
            local v11 = p7._disposables[p8] and v10[p8]
            if v11 then
                local v12 = u6[typeof(v11)]
                if v12 then
                    v12(v11)
                else
                    warn((("\226\157\140 [Cleaner]: %* does not have a cleaning callback (internal)"):format(v11)))
                end
            end
            v10[p8] = p9
        end
    end,
    ["__index"] = function(p13, p14) --[[ Name: __index, Line 64 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        return u30[p14] or (rawget(p13, p14) or p13._disposables[p14])
    end,
    ["new"] = function() --[[ Name: new, Line 71 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        local v15 = u30
        return setmetatable({
            ["_disposables"] = {},
            ["_bindedConnection"] = nil
        }, v15)
    end,
    ["BindToInstance"] = function(u16, p17) --[[ Name: BindToInstance, Line 78 ]]
        if u16._bindedConnection then
            u16._bindedConnection:Disconnect()
            u16._bindedConnection = nil
        end
        if p17 then
            p17 = p17.Destroying:Connect(function() --[[ Line: 84 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                u16:Destroy()
                u16._bindedConnection = nil
            end)
        end
        u16._bindedConnection = p17
        return u16
    end,
    ["Add"] = function(p18, ...) --[[ Name: Add, Line 92 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        local v19 = p18._disposables
        for _, v20 in { ... } do
            local v21 = #v19 + 1
            if typeof(v20) == "table" and not v20.Destroy then
                warn("\226\157\140 [Cleaner]: Table does not have a cleanup method")
            else
                local v22 = p18._disposables
                local v23 = p18._disposables[v21] and v22[v21]
                if v23 then
                    local v24 = u6[typeof(v23)]
                    if v24 then
                        v24(v23)
                    else
                        warn((("\226\157\140 [Cleaner]: %* does not have a cleaning callback (internal)"):format(v23)))
                    end
                end
                v22[v21] = v20
            end
        end
        return ...
    end,
    ["Destroy"] = function(p25) --[[ Name: Destroy, Line 100 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        local v26 = p25._disposables
        for v27 in v26 do
            local v28 = v26[v27]
            if v28 then
                local v29 = u6[typeof(v28)]
                if v29 then
                    v29(v28)
                else
                    warn((("\226\157\140 [Cleaner]: %* does not have a cleaning callback (internal)"):format(v28)))
                end
            end
            v26[v27] = nil
        end
    end
}
return u30