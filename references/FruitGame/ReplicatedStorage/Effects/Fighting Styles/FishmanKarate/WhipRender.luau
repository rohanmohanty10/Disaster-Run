 

local u1 = require(game.ReplicatedStorage.Refrences.Fishman.Modules.Whip)
return {
    ["start"] = function(_, p2, p3) --[[ Name: start, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            u1.new(p2, nil, p3)
        end
    end
}