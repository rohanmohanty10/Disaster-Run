 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Promise")
local u3 = v1("Signal")
local u4 = {
    ["ClassName"] = "CancelToken"
}
u4.__index = u4
function u4.new(p5) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
    --]]
    local v6 = u4
    local u7 = setmetatable({}, v6)
    local v8 = type(p5) == "function"
    assert(v8, "Bad executor")
    u7.PromiseCancelled = u2.new()
    u7.Cancelled = u3.new()
    u7.PromiseCancelled:Then(function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7.Cancelled:Fire()
        u7.Cancelled:Destroy()
    end)
    p5(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7:_cancel()
    end)
    return u7
end
local function u9() --[[ Line: 42 ]] end
function u4.fromMaid(u10) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u9
    --]]
    local u11 = u4.new(u9)
    local u12 = u10:GiveTask(function() --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        u11:_cancel()
    end)
    u11.PromiseCancelled:Then(function() --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u12
        --]]
        u10[u12] = nil
    end)
    return u11
end
function u4.ErrorIfCancelled(p13) --[[ Line: 67 ]]
    if not p13.PromiseCancelled:IsPending() then
        error("[CancelToken.ErrorIfCancelled] - Cancelled")
    end
end
function u4.IsCancelled(p14) --[[ Line: 77 ]]
    return p14.PromiseCancelled:IsFulfilled()
end
function u4._cancel(p15) --[[ Line: 81 ]]
    p15.PromiseCancelled:Resolve()
end
return u4