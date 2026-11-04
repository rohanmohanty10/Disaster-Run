 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.ModelResize)
function v1.start(_, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2:TweenResize(unpack(p3))
end
return v1