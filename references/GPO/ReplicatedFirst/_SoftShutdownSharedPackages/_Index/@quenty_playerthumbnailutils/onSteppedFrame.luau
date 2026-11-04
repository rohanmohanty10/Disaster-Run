 

local u1 = game:GetService("RunService")
return function(u2) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = type(u2) == "function"
    assert(v3, "Bad func")
    local u4 = nil
    u4 = u1.Stepped:Connect(function() --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
        --]]
        u4:Disconnect()
        u2()
    end)
    return u4
end