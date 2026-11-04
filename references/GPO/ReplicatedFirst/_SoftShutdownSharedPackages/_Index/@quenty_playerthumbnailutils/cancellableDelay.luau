 

return function(u1, u2, ...) --[[ Name: cancellableDelay, Line 14 ]]
    local v3 = type(u1) == "number"
    assert(v3, "Bad timeoutInSeconds")
    local v4 = type(u2) == "function"
    assert(v4, "Bad func")
    local u5 = table.pack(...)
    local u6 = nil
    task.spawn(function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u1
            [3] = u5
            [4] = u2
        --]]
        u6 = coroutine.running()
        task.wait(u1)
        local v7 = u5
        u6 = nil
        u5 = nil
        local v8 = u2
        local v9 = v7.n
        v8(table.unpack(v7, 1, v9))
    end)
    return function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
        --]]
        if u6 then
            coroutine.close(u6)
            u6 = nil
            u5 = nil
        end
    end
end