 

local v1 = game.ReplicatedStorage.Modules
local u2 = require(v1.OceanModule)
u2.NoRender = true
u2.OceanMeshes:ClearAllChildren()
u2.OceanMeshes:Destroy()
function _G.getWavePosition(p3) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2.HeightLookup(p3.x, p3.z)
end