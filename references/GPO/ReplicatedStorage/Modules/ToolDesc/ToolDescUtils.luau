 

local u1 = require(script.Parent)
local v2 = {}
local u3 = nil
function v2.GetAllFishes() --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    if u3 ~= nil then
        return u3
    end
    u3 = {}
    local v4 = {
        ["Common Fish"] = true,
        ["Rare Fish"] = true,
        ["Legendary Fish"] = true
    }
    for v5, v6 in pairs(u1) do
        if v6.BaseItem ~= nil and v4[v6.BaseItem] == true then
            u3[v5] = v6
        end
    end
    return u3
end
return v2