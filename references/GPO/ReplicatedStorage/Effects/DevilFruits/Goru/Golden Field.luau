 

local v1 = {}
local u2 = require(script.Place)
local u3 = require(script.Trip)
function v1.start(_, p4, p5, p6) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if p4 == "cast" then
        u2(p5)
    else
        u3(p5, p6)
    end
end
return v1