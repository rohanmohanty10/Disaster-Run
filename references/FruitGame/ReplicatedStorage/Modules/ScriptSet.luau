 

local v1 = {}
local _ = game.Players.LocalPlayer
local u2 = require(script.set)
function v1.get(p3) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    task.wait(0.1)
    return u2:ready(p3)
end
return v1