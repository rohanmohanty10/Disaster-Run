 

local u1 = require(script.Parent.loader).load(script)("Promise")
return function(u2, u3) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = typeof(u2) == "Instance"
    assert(v4, "Bad instance")
    local v5 = type(u3) == "string"
    assert(v5, "Bad propertyName")
    local v6 = u2[u3]
    if v6 then
        return u1.resolved(v6)
    end
    local u7 = u1.new()
    local u8 = nil
    u7:Finally(function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if u8 then
            u8:Disconnect()
        end
    end)
    u8 = u2:GetPropertyChangedSignal(u3):Connect(function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u7
        --]]
        if u2[u3] then
            u7:Resolve(u2[u3])
        end
    end)
    return u7
end