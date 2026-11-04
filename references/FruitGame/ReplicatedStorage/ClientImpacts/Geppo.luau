 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs]
function v1.start(_, ...) --[[ Line: 4 ]]
    _G.PlayEffect("Geppo", nil, ...)
end
return v1