 

local u1 = require(script.Parent.loader).load(script)("Promise")
return {
    ["any"] = function(p2) --[[ Name: any, Line 17 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = u1.new()
        local function v4(...) --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3:Resolve(...)
        end
        local function v5(...) --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3:Reject(...)
        end
        for _, v6 in pairs(p2) do
            v6:Then(v4, v5)
        end
        return u3
    end,
    ["all"] = function(u7) --[[ Name: all, Line 46 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if #u7 == 0 then
            return u1.resolved()
        end
        if #u7 == 1 then
            return u7[1]
        end
        local v8 = #u7
        local u9 = u1.new()
        local u10 = {}
        local v11 = true
        local u12 = v8
        local u13 = v11
        for u14, v15 in pairs(u7) do
            local u16 = true
            local u17 = false
            v15:Then(function(p18) --[[ Line: 59 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                    [3] = u10
                    [4] = u14
                    [5] = u12
                    [6] = u9
                    [7] = u7
                --]]
                local v19 = u13
                if v19 then
                    v19 = u16
                end
                u13 = v19
                u10[u14] = p18
                u12 = u12 - 1
                if u12 == 0 then
                    local v20 = u9[u13 and "Resolve" or "Reject"]
                    local v21 = u9
                    local v22 = u10
                    local v23 = #u7
                    v20(v21, unpack(v22, 1, v23))
                end
            end, function(p24) --[[ Line: 59 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                    [3] = u10
                    [4] = u14
                    [5] = u12
                    [6] = u9
                    [7] = u7
                --]]
                local v25 = u13
                if v25 then
                    v25 = u17
                end
                u13 = v25
                u10[u14] = p24
                u12 = u12 - 1
                if u12 == 0 then
                    local v26 = u9[u13 and "Resolve" or "Reject"]
                    local v27 = u9
                    local v28 = u10
                    local v29 = #u7
                    v26(v27, unpack(v28, 1, v29))
                end
            end)
        end
        return u9
    end,
    ["invert"] = function(p30) --[[ Name: invert, Line 84 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p30:IsPending() then
            return p30:Then(function(...) --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return u1.rejected(...)
            end, function(...) --[[ Line: 88 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return u1.resolved(...)
            end)
        else
            local v31 = { p30:GetResults() }
            if v31[1] then
                return u1.rejected(unpack(v31, 2))
            else
                return u1.resolved(unpack(v31, 2))
            end
        end
    end,
    ["fromSignal"] = function(p32) --[[ Name: fromSignal, Line 107 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u33 = u1.new()
        local u34 = nil
        u33:Finally(function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u34
            --]]
            u34:Disconnect()
            u34 = nil
        end)
        u34 = p32:Connect(function(...) --[[ Line: 116 ]]
            --[[
            Upvalues:
                [1] = u33
            --]]
            u33:Resolve(...)
        end)
        return u33
    end,
    ["timeout"] = function(p35, p36) --[[ Name: timeout, Line 131 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v37 = type(p35) == "number"
        assert(v37, "Bad timeoutTime")
        assert(p36, "Bad fromPromise")
        if not p36:IsPending() then
            return p36
        end
        local u38 = u1.new()
        u38:Resolve(p36)
        task.delay(p35, function() --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u38
            --]]
            u38:Reject()
        end)
        return u38
    end
}