 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("ContentProvider")
local u3 = v1("Promise")
return {
    ["promisePreload"] = function(u4) --[[ Name: promisePreload, Line 23 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v5 = type(u4) == "table"
        assert(v5, "Bad contentIdList")
        return u3.spawn(function(p6, p7) --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u4
            --]]
            local v8, v9 = pcall(function() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u4
                --]]
                u2:PreloadAsync(u4)
            end)
            if not v8 then
                return p7(v9)
            end
            p6()
        end)
    end
}