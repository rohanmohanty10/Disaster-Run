 

local u1 = require(script.Parent.Promise)
return function(u2, u3, u4) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = u2:FindFirstChild(u3)
    if v5 then
        return u1.resolved(v5)
    else
        return u1.new(function(u6, _) --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
            --]]
            task.spawn(function() --[[ Line: 29 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u3
                    [3] = u4
                    [4] = u6
                --]]
                local v7 = u2:WaitForChild(u3, u4)
                if v7 then
                    u6(v7)
                else
                    u6("Timed out")
                end
            end)
        end)
    end
end