 

local u11 = {
    ["isValidTask"] = function(p1) --[[ Name: isValidTask, Line 25 ]]
        local v2
        if type(p1) == "function" or (type(p1) == "thread" or typeof(p1) == "RBXScriptConnection") then
            v2 = true
            ::l2::
            return v2
        else
            if type(p1) == "table" then
                local v3 = p1.Destroy
                if type(v3) == "function" then
                    v2 = true
                    goto l2
                end
            end
            v2 = typeof(p1) == "Instance"
            goto l2
        end
    end,
    ["doTask"] = function(u4) --[[ Name: doTask, Line 38 ]]
        if type(u4) == "function" then
            u4()
        elseif type(u4) == "thread" then
            local v5
            if coroutine.running() == u4 then
                v5 = nil
            else
                v5 = pcall(function() --[[ Line: 44 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                    --]]
                    task.cancel(u4)
                end)
            end
            if not v5 then
                task.defer(function() --[[ Line: 50 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                    --]]
                    task.cancel(u4)
                end)
                return
            end
        else
            if typeof(u4) == "RBXScriptConnection" then
                u4:Disconnect()
                return
            end
            if type(u4) == "table" then
                local v6 = u4.Destroy
                if type(v6) == "function" then
                    u4:Destroy()
                    return
                end
            end
            if typeof(u4) == "Instance" then
                u4:Destroy()
                return
            end
            error("Bad job")
        end
    end,
    ["delayed"] = function(u7, u8) --[[ Name: delayed, Line 78 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v9 = type(u7) == "number"
        assert(v9, "Bad time")
        local v10 = u11.isValidTask(u8)
        assert(v10, "Bad job")
        return function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u11
                [3] = u8
            --]]
            task.delay(u7, function() --[[ Line: 83 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u8
                --]]
                u11.doTask(u8)
            end)
        end
    end
}
return u11