 

local u1 = require(script.InitiateVFX)
return function(p2, ...) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = { ... }
    local _ = v3[1].Humanoid.RootPart
    local v4 = script.Form
    table.insert(v3, v4)
    u1[p2](unpack(v3))
end