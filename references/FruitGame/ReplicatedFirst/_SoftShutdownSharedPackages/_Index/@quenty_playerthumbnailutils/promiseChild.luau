 

local u1 = require(script.Parent.loader).load(script)("Promise")
return function(u2, u3, u4) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = u2:FindFirstChild(u3)
    if v5 then
        return u1.resolved(v5)
    else
        return u1.spawn(function(p6, p7) --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
            --]]
            local v8 = u2:WaitForChild(u3, u4)
            if v8 then
                p6(v8)
            else
                p7("Timed out")
            end
        end)
    end
end