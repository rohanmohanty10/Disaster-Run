 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.BLightning)
function v1.start(_, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p5) ~= false then
        local v13 = u2:Fire(p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
        _G.destroy(v13, p12)
    end
end
return v1