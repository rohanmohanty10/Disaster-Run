 

local u1 = require(script.Parent.loader).load(script)("promiseChild")
return {
    ["Add"] = function(p2, p3, p4) --[[ Name: Add, Line 40 ]]
        local v5 = type(p3) == "table"
        assert(v5, "Bad class")
        local v6 = type(p4) == "string"
        assert(v6, "Bad remoteEventName")
        local v7 = not p3.PromiseRemoteEventMixin
        assert(v7, "Class already has PromiseRemoteEventMixin defined")
        local v8 = not p3._remoteEventName
        assert(v8, "Class already has _remoteEventName defined")
        p3.PromiseRemoteEvent = p2.PromiseRemoteEvent
        p3._remoteEventName = p4
    end,
    ["PromiseRemoteEvent"] = function(p9) --[[ Name: PromiseRemoteEvent, Line 54 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return p9._maid:GivePromise(u1(p9._obj, p9._remoteEventName))
    end
}