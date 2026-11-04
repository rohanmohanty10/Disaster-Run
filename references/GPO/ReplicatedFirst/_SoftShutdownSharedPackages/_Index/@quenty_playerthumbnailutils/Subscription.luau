 

local u1 = require(script.Parent.loader).load(script)("MaidTaskUtils")
local u2 = {
    ["ClassName"] = "Subscription"
}
u2.__index = u2
local u3 = {
    ["PENDING"] = "pending",
    ["FAILED"] = "failed",
    ["COMPLETE"] = "complete",
    ["CANCELLED"] = "cancelled"
}
function u2.new(p4, p5, p6, p7) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v8 = type(p4) == "function" and true or p4 == nil
    assert(v8, "Bad fireCallback")
    local v9 = type(p5) == "function" and true or p5 == nil
    assert(v9, "Bad failCallback")
    local v10 = type(p6) == "function" and true or p6 == nil
    assert(v10, "Bad completeCallback")
    local v11 = {
        ["_state"] = u3.PENDING,
        ["_source"] = "",
        ["_fireCallback"] = p4,
        ["_failCallback"] = p5,
        ["_completeCallback"] = p6,
        ["_onSubscribe"] = p7
    }
    local v12 = u2
    return setmetatable(v11, v12)
end
function u2.Fire(p13, ...) --[[ Line: 63 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p13._state == u3.PENDING then
        if p13._fireCallback then
            p13._fireCallback(...)
            return
        end
    elseif p13._state == u3.CANCELLED then
        warn("[Subscription.Fire] - We are cancelled, but events are still being pushed")
    end
end
function u2.Fail(p14) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p14._state == u3.PENDING then
        p14._state = u3.FAILED
        if p14._failCallback then
            p14._failCallback()
        end
        p14:_doCleanup()
    end
end
function u2.GetFireFailComplete(u15) --[[ Line: 114 ]]
    return function(...) --[[ Line: 115 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        u15:Fire(...)
    end, function(...) --[[ Line: 117 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        u15:Fail(...)
    end, function(...) --[[ Line: 119 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        u15:Complete(...)
    end
end
function u2.GetFailComplete(u16) --[[ Line: 141 ]]
    return function(...) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        u16:Fail(...)
    end, function(...) --[[ Line: 144 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        u16:Complete(...)
    end
end
function u2.Complete(p17) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p17._state == u3.PENDING then
        p17._state = u3.COMPLETE
        if p17._completeCallback then
            p17._completeCallback()
        end
        p17:_doCleanup()
    end
end
function u2.IsPending(p18) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return p18._state == u3.PENDING
end
function u2._giveCleanup(p19, p20) --[[ Line: 174 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    assert(p20, "Bad task")
    local v21 = not p19._cleanupTask
    assert(v21, "Already have _cleanupTask")
    if p19._state == u3.PENDING then
        p19._cleanupTask = p20
    else
        u1.doTask(p20)
    end
end
function u2._doCleanup(p22) --[[ Line: 186 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p22._cleanupTask then
        local v23 = p22._cleanupTask
        p22._cleanupTask = nil
        u1.doTask(v23)
    end
end
function u2.Destroy(p24) --[[ Line: 202 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p24._state == u3.PENDING then
        p24._state = u3.CANCELLED
    end
    p24:_doCleanup()
end
function u2.Disconnect(p25) --[[ Line: 213 ]]
    p25:Destroy()
end
return u2