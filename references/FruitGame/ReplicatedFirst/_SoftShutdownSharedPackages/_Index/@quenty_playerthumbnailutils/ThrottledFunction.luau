 

local u1 = {
    ["ClassName"] = "ThrottledFunction"
}
u1.__index = u1
function u1.new(p2, p3, p4) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = u1
    local v6 = setmetatable({}, v5)
    v6._nextCallTimeStamp = 0
    v6._timeout = p2 or error("No timeoutInSeconds")
    v6._func = p3 or error("No func")
    v6._trailingValue = nil
    v6._callLeading = true
    v6._callTrailing = true
    v6:_configureOrError(p4)
    return v6
end
function u1.Call(u7, ...) --[[ Line: 27 ]]
    if u7._trailingValue then
        u7._trailingValue = table.pack(...)
        return
    elseif u7._nextCallTimeStamp <= tick() then
        if u7._callLeading or u7._callLeadingFirstTime then
            u7._callLeadingFirstTime = false
            u7._nextCallTimeStamp = tick() + u7._timeout
            u7._func(...)
            return
        elseif u7._callTrailing then
            u7._trailingValue = table.pack(...)
            task.delay(u7._timeout, function() --[[ Line: 40 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                if u7.Destroy then
                    u7:_dispatch()
                end
            end)
        else
            error("[ThrottledFunction.Cleanup] - Trailing and leading are both disabled")
        end
    else
        if u7._callLeading or (u7._callTrailing or u7._callLeadingFirstTime) then
            u7._callLeadingFirstTime = false
            local v8 = u7._nextCallTimeStamp - tick()
            u7._trailingValue = table.pack(...)
            task.delay(v8, function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                if u7.Destroy then
                    u7:_dispatch()
                end
            end)
        end
        return
    end
end
function u1._dispatch(p9) --[[ Line: 62 ]]
    p9._nextCallTimeStamp = tick() + p9._timeout
    local v10 = p9._trailingValue
    if v10 then
        p9._trailingValue = nil
        local v11 = p9._func
        local v12 = v10.n
        v11(unpack(v10, 1, v12))
    end
end
function u1._configureOrError(p13, p14) --[[ Line: 73 ]]
    if p14 ~= nil then
        local v15 = type(p14) == "table"
        assert(v15, "Bad throttleConfig")
        for v16, v17 in pairs(p14) do
            local v18 = type(v17) == "boolean"
            assert(v18, "Bad throttleConfig entry")
            if v16 == "leading" then
                p13._callLeading = v17
            elseif v16 == "trailing" then
                p13._callTrailing = v17
            elseif v16 == "leadingFirstTimeOnly" then
                p13._callLeadingFirstTime = v17
            else
                error(("Bad key %q in config"):format((tostring(v16))))
            end
        end
        local v19 = p13._callLeading or p13._callTrailing
        assert(v19, "Cannot configure both leading and trailing disabled")
    end
end
function u1.Destroy(p20) --[[ Line: 97 ]]
    p20._trailingValue = nil
    p20._func = nil
    setmetatable(p20, nil)
end
return u1