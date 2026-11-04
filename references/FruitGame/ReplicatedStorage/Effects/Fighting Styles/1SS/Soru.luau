 

local v1 = {}
local u2 = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]
function v1.start(_, p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) then
        u2:start({
            ["char"] = p3
        })
    end
end
return v1