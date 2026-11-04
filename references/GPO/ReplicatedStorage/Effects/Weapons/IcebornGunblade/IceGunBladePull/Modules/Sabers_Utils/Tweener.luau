 

local u4 = {
    ["Types"] = {},
    ["Register"] = function(_) --[[ Name: Register, Line 4 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        for _, v1 in script:GetChildren() do
            if v1:IsA("ModuleScript") then
                u4.Types[string.lower(v1.Name)] = require(v1)
            end
        end
    end,
    ["Init"] = function(_) --[[ Name: Init, Line 11 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        u4:Register()
    end,
    ["Get"] = function(_, p2) --[[ Name: Get, Line 15 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        local v3 = string.lower(p2)
        return u4.Types[v3]
    end
}
return u4