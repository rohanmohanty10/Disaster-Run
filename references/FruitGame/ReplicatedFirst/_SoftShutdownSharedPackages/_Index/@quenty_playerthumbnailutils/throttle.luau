 

local u1 = require(script.Parent.loader).load(script)("ThrottledFunction")
return function(p2, p3, p4) --[[ Name: throttle, Line 21 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = type(p2) == "number"
    assert(v5, "timeoutInSeconds is not a number")
    local v6 = type(p3) == "function"
    assert(v6, "func is not a function")
    local u7 = u1.new(p2, p3, p4)
    return function(...) --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7:Call(...)
    end
end