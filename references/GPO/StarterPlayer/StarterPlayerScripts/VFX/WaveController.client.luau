 

local v1 = game:GetService("Players")
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.OceanSimulator)
local v3 = v1.LocalPlayer
local v4 = u2.LowWaveResolution
function _G.getWavePosition(p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2.GetWaveHeightAtPosition(p5)
end
function _G.getWaveNormal(p6) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2.GetWaveHeightAtPosition(p6), u2.GetWaveNormalAtPosition(p6)
end
u2.SetOceanHeight(workspace.Terrain:GetAttribute("SeaLevel"))
u2.InitializeChunkManager(v3, 3, v4)
u2.SetEnabled(true)