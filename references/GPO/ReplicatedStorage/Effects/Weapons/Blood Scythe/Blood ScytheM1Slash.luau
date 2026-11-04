 

local _ = script
game:GetService("ReplicatedStorage")
local v1 = {}
local u2 = require(script.M1s)
function v1.start(_, p3, p4, _, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2({
        ["Root"] = p4,
        ["Count"] = p5 == true and "Dash" or p3
    })
end
return v1