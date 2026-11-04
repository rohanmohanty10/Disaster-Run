 

local u1 = require(script.Parent.loader).load(script)("promiseChild")
return {
    ["Add"] = function(p2, p3, p4) --[[ Name: Add, Line 40 ]]
        local v5 = type(p3) == "table"
        assert(v5, "Bad class")
        local v6 = type(p4) == "string"
        assert(v6, "Bad remoteFunctionName")
        local v7 = not p3.PromiseRemoteFunctionMixin
        assert(v7, "Class already has PromiseRemoteFunctionMixin defined")
        local v8 = not p3._remoteFunctionName
        assert(v8, "Class already has _remoteFunctionName defined")
        p3.PromiseRemoteFunction = p2.PromiseRemoteFunction
        p3._remoteFunctionName = p4
    end,
    ["PromiseRemoteFunction"] = function(p9) --[[ Name: PromiseRemoteFunction, Line 54 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return p9._maid:GivePromise(u1(p9._obj, p9._remoteFunctionName))
    end
}