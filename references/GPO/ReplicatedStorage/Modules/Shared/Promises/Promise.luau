 

local u1 = game:GetService("RunService")
local u2 = nil
local u3 = nil
local u4 = {
    ["ClassName"] = "Promise"
}
u4.__index = u4
function u4.isPromise(p5) --[[ Line: 11 ]]
    local v6
    if type(p5) == "table" then
        v6 = p5.ClassName == "Promise"
    else
        v6 = false
    end
    return v6
end
function u4.new(p7) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v8 = u4
    local v9 = setmetatable({
        ["_pendingExecuteList"] = {},
        ["_unconsumedException"] = true,
        ["_source"] = ""
    }, v8)
    if type(p7) == "function" then
        p7(v9:_getResolveReject())
    end
    return v9
end
function u4.spawn(p10) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v11 = u4.new()
    task.spawn(p10, v11:_getResolveReject())
    return v11
end
function u4.defer(p12) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v13 = u4.new()
    task.defer(p12, v13:_getResolveReject())
    return v13
end
function u4.resolved(...) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v14 = select("#", ...)
    if v14 == 0 then
        return u3
    end
    if v14 == 1 and u4.isPromise(...) then
        local v15 = ...
        if not v15._pendingExecuteList then
            return v15
        end
    end
    local v16 = u4.new()
    v16:Resolve(...)
    return v16
end
function u4.rejected(...) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v17 = select("#", ...)
    if v17 == 0 then
        return u2
    end
    local v18 = u4.new()
    v18:_reject({ ... }, v17)
    return v18
end
function u4.IsPending(p19) --[[ Line: 73 ]]
    return p19._pendingExecuteList ~= nil
end
function u4.IsFulfilled(p20) --[[ Line: 77 ]]
    return p20._fulfilled ~= nil
end
function u4.IsRejected(p21) --[[ Line: 81 ]]
    return p21._rejected ~= nil
end
function u4.Wait(p22) --[[ Line: 85 ]]
    if p22._fulfilled then
        local v23 = p22._fulfilled
        local v24 = p22._valuesLength
        return unpack(v23, 1, v24)
    elseif p22._rejected then
        local v25 = error
        local v26 = p22._rejected[1]
        return v25(tostring(v26), 2)
    else
        local u27 = Instance.new("BindableEvent")
        p22:Then(function() --[[ Line: 93 ]]
            --[[
            Upvalues:
                [1] = u27
            --]]
            u27:Fire()
        end, function() --[[ Line: 95 ]]
            --[[
            Upvalues:
                [1] = u27
            --]]
            u27:Fire()
        end)
        u27.Event:Wait()
        u27:Destroy()
        if p22._rejected then
            local v28 = error
            local v29 = p22._rejected[1]
            return v28(tostring(v29), 2)
        else
            local v30 = p22._fulfilled
            local v31 = p22._valuesLength
            return unpack(v30, 1, v31)
        end
    end
end
function u4.Yield(p32) --[[ Line: 110 ]]
    if p32._fulfilled then
        local v33 = p32._fulfilled
        local v34 = p32._valuesLength
        return true, unpack(v33, 1, v34)
    end
    if p32._rejected then
        local v35 = p32._rejected
        local v36 = p32._valuesLength
        return false, unpack(v35, 1, v36)
    end
    local u37 = Instance.new("BindableEvent")
    p32:Then(function() --[[ Line: 118 ]]
        --[[
        Upvalues:
            [1] = u37
        --]]
        u37:Fire()
    end, function() --[[ Line: 120 ]]
        --[[
        Upvalues:
            [1] = u37
        --]]
        u37:Fire()
    end)
    u37.Event:Wait()
    u37:Destroy()
    if p32._fulfilled then
        local v38 = p32._fulfilled
        local v39 = p32._valuesLength
        return true, unpack(v38, 1, v39)
    end
    if p32._rejected then
        local v40 = p32._rejected
        local v41 = p32._valuesLength
        return false, unpack(v40, 1, v41)
    end
end
function u4.Resolve(u42, ...) --[[ Line: 135 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if u42._pendingExecuteList then
        local v43 = select("#", ...)
        if v43 == 0 then
            u42:_fulfill({}, 0)
            return
        elseif u42 == ... then
            u42:Reject("TypeError: Resolved to self")
            return
        elseif u4.isPromise(...) then
            if v43 > 1 then
                local v44 = ("When resolving a promise, extra arguments are discarded! See:\n\n%s"):format(u42._source)
                warn(v44)
            end
            local v45 = ...
            if v45._pendingExecuteList then
                v45._unconsumedException = false
                v45._pendingExecuteList[#v45._pendingExecuteList + 1] = { function(...) --[[ Line: 156 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                        --]]
                        u42:Resolve(...)
                    end, function(...) --[[ Line: 159 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                        --]]
                        if u42._pendingExecuteList then
                            u42:_reject({ ... }, select("#", ...))
                        end
                    end, nil }
                return
            elseif v45._rejected then
                v45._unconsumedException = false
                u42:_reject(v45._rejected, v45._valuesLength)
                return
            elseif v45._fulfilled then
                u42:_fulfill(v45._fulfilled, v45._valuesLength)
            else
                error("[Promise.Resolve] - Bad promise2 state")
            end
        elseif type(...) == "function" then
            if v43 > 1 then
                local v46 = ("When resolving a function, extra arguments are discarded! See:\n\n%s"):format(u42._source)
                warn(v46)
            end
            ({ ... })(u42:_getResolveReject())
        else
            u42:_fulfill({ ... }, v43)
        end
    else
        return
    end
end
function u4._fulfill(p47, p48, p49) --[[ Line: 191 ]]
    if p47._pendingExecuteList then
        p47._fulfilled = p48
        p47._valuesLength = p49
        local v50 = p47._pendingExecuteList
        p47._pendingExecuteList = nil
        for _, v51 in pairs(v50) do
            p47:_executeThen(unpack(v51))
        end
    end
end
function u4.Reject(p52, ...) --[[ Line: 206 ]]
    p52:_reject({ ... }, select("#", ...))
end
function u4._reject(u53, p54, p55) --[[ Line: 210 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u53._pendingExecuteList then
        u53._rejected = p54
        u53._valuesLength = p55
        local v56 = u53._pendingExecuteList
        u53._pendingExecuteList = nil
        for _, v57 in pairs(v56) do
            u53:_executeThen(unpack(v57))
        end
        if u53._unconsumedException and u53._valuesLength > 0 then
            coroutine.resume(coroutine.create(function() --[[ Line: 225 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u53
                --]]
                u1.Heartbeat:Wait()
                if u53._unconsumedException then
                    local v58 = warn
                    local v59 = u53._rejected[1]
                    v58(("[Promise] - Uncaught exception in promise: %q"):format((tostring(v59))))
                end
            end))
        end
    end
end
function u4.Then(p60, p61, p62) --[[ Line: 241 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if type(p62) == "function" then
        p60._unconsumedException = false
    end
    if not p60._pendingExecuteList then
        return p60:_executeThen(p61, p62, nil)
    end
    local v63 = u4.new()
    p60._pendingExecuteList[#p60._pendingExecuteList + 1] = { p61, p62, v63 }
    return v63
end
function u4.Tap(u64, p65, p66) --[[ Line: 255 ]]
    local v67 = u64:Then(p65, p66)
    if v67 == u64 then
        return v67
    end
    if v67._fulfilled then
        return u64
    end
    if v67._rejected then
        return u64
    end
    if v67._pendingExecuteList then
        local function v68() --[[ Line: 267 ]]
            --[[
            Upvalues:
                [1] = u64
            --]]
            return u64
        end
        return v67:Then(v68, v68)
    end
    error("Bad result state")
end
function u4.Finally(p69, p70) --[[ Line: 277 ]]
    return p69:Then(p70, p70)
end
function u4.Catch(p71, p72) --[[ Line: 281 ]]
    return p71:Then(nil, p72)
end
function u4.Destroy(p73) --[[ Line: 285 ]]
    p73:_reject({}, 0)
end
function u4.GetResults(p74) --[[ Line: 289 ]]
    if p74._rejected then
        local v75 = p74._rejected
        local v76 = p74._valuesLength
        return false, unpack(v75, 1, v76)
    end
    if p74._fulfilled then
        local v77 = p74._fulfilled
        local v78 = p74._valuesLength
        return true, unpack(v77, 1, v78)
    end
    error("Still pending")
end
function u4._getResolveReject(u79) --[[ Line: 299 ]]
    return function(...) --[[ Line: 300 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        u79:Resolve(...)
    end, function(...) --[[ Line: 302 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        u79:_reject({ ... }, select("#", ...))
    end
end
function u4._executeThen(p80, p81, p82, p83) --[[ Line: 307 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    if p80._fulfilled then
        if type(p81) ~= "function" then
            if not p83 then
                return p80
            end
            p83:_fulfill(p80._fulfilled, p80._valuesLength)
            return p83
        end
        if p83 then
            local v84 = p80._fulfilled
            local v85 = p80._valuesLength
            p83:Resolve(p81(unpack(v84, 1, v85)))
            return p83
        end
        local v86 = table.pack
        local v87 = p80._fulfilled
        local v88 = p80._valuesLength
        local v89 = v86(p81(unpack(v87, 1, v88)))
        if v89.n == 0 then
            return u3
        end
        if v89.n == 1 and u4.isPromise(v89[1]) then
            return v89[1]
        end
        local v90 = u4.new()
        local v91 = v89.n
        v90:Resolve(table.unpack(v89, 1, v91))
        return v90
    end
    if p80._rejected then
        if type(p82) ~= "function" then
            if not p83 then
                return p80
            end
            p83:_reject(p80._rejected, p80._valuesLength)
            return p83
        end
        if p83 then
            local v92 = p80._rejected
            local v93 = p80._valuesLength
            p83:Resolve(p82(unpack(v92, 1, v93)))
            return p83
        end
        local v94 = table.pack
        local v95 = p80._rejected
        local v96 = p80._valuesLength
        local v97 = v94(p82(unpack(v95, 1, v96)))
        if v97.n == 0 then
            return u3
        end
        if v97.n == 1 and u4.isPromise(v97[1]) then
            return v97[1]
        end
        local v98 = u4.new()
        local v99 = v97.n
        v98:Resolve(table.unpack(v97, 1, v99))
        return v98
    end
    error("Internal error: still pending")
end
u3 = u4.new()
u3:_fulfill({}, 0)
u2 = u4.new()
u2:_reject({}, 0)
return u4