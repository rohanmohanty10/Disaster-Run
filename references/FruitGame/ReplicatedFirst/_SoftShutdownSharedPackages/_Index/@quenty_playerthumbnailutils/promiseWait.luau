 

local u1 = require(script.Parent.loader).load(script)("Promise")
return function(u2) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.new(function(u3, _) --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        task.delay(u2, function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3()
        end)
    end)
end