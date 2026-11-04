 

local u1 = game:GetService("Workspace")
local v2 = script.Parent.Parent.Promises
local u3 = require(v2.Promise)
return {
    ["PromiseStreamAround"] = function(u4, u5, u6) --[[ Name: PromiseStreamAround, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
        --]]
        local v7 = typeof(u4) == "Instance"
        assert(v7, "Bad player")
        local v8 = typeof(u5) == "Vector3"
        assert(v8, "Bad position")
        local v9 = type(u6) == "number" and true or u6 == nil
        assert(v9, "Bad timeOut")
        if u1.StreamingEnabled then
            return u3.spawn(function(p10, p11) --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u5
                    [3] = u6
                --]]
                local v12, v13 = pcall(function() --[[ Line: 22 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u5
                        [3] = u6
                    --]]
                    u4:RequestStreamAroundAsync(u5, u6)
                end)
                if v12 then
                    return p10()
                else
                    return p11(v13)
                end
            end)
        else
            return u3.resolved()
        end
    end
}