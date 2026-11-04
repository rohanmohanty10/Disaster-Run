 

local v1 = {}
local u2 = require(script.Explosion)
local u3 = require(script.Charge)
function v1.start(_, p4, p5, p6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    u3(p4, p5)
    u2(p4, p5, p6)
end
return v1