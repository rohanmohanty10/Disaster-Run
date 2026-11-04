 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
require(game.ReplicatedStorage.Modules.GLightning)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
local function u7(p4, p5) --[[ Line: 10 ]]
    local v6 = Instance.new("Attachment")
    _G.destroy(v6, 5)
    v6.Parent = workspace.Terrain
    if p5 then
        v6.Parent = p5
    elseif typeof(p4) == "CFrame" then
        v6.WorldCFrame = p4
    end
    if typeof(p4) == "Vector3" then
        v6.Position = p4
    end
    if typeof(p4) ~= "CFrame" then
        v6.Parent = p4
    end
    return v6
end
function v1.start(_, p8, p9, p10, p11, p12) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
        [3] = u3
    --]]
    local v13 = u7(p8)
    local v14 = u7(p9)
    local _ = math.random(250, 750) / 1000
    local v15 = u2.new(v13, v14, p11)
    for v16, v17 in p10 do
        v15[v16] = v17
    end
    local v18 = u3.new(v15)
    for v19, v20 in p12 do
        v18[v19] = v20
    end
end
return v1