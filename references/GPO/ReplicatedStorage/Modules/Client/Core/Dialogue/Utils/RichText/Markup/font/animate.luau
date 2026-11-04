 

Random.new()
local u3 = (function() --[[ Line: 2 ]]
    local v1 = {}
    for _, v2 in script:GetChildren() do
        v1[v2.Name] = require(v2)
    end
    return v1
end)()
return {
    ["GetValue"] = function(_, p4) --[[ Name: GetValue, Line 13 ]]
        return p4
    end,
    ["Render"] = function(_, p5, p6) --[[ Name: Render, Line 17 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v7 = u3[p6]
        if v7 then
            v7 = u3[p6]:Render(p5)
        end
        return v7
    end
}