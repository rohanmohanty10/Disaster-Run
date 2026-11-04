 

local u10 = {
    ["isValidTask"] = function(p1) --[[ Name: isValidTask, Line 25 ]]
        local v2
        if type(p1) == "function" or typeof(p1) == "RBXScriptConnection" then
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
    ["doTask"] = function(p4) --[[ Name: doTask, Line 37 ]]
        if type(p4) == "function" then
            p4()
            return
        elseif typeof(p4) == "RBXScriptConnection" then
            p4:Disconnect()
            return
        else
            if type(p4) == "table" then
                local v5 = p4.Destroy
                if type(v5) == "function" then
                    p4:Destroy()
                    return
                end
            end
            if typeof(p4) == "Instance" then
                p4:Destroy()
            else
                error("Bad job")
            end
        end
    end,
    ["delayed"] = function(u6, u7) --[[ Name: delayed, Line 64 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v8 = type(u6) == "number"
        assert(v8, "Bad time")
        local v9 = u10.isValidTask(u7)
        assert(v9, "Bad job")
        return function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u10
                [3] = u7
            --]]
            task.delay(u6, function() --[[ Line: 69 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u7
                --]]
                u10.doTask(u7)
            end)
        end
    end
}
return u10