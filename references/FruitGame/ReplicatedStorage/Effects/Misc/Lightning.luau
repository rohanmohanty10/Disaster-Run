 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningModule)
function v1.start(_, p3, p4, p5) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p4) ~= false then
        if _G.fastmode then
            p5.bends = 2
            p5.fork_chance = 0
        end
        u2.new(p3, p4, p5):Draw(workspace.Effects)
    end
end
return v1