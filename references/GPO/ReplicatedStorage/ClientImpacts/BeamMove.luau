 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs]
function v1.start(_, p2) --[[ Line: 6 ]]
    local v3 = p2.Beam
    for v4 = p2.reps, 0, -p2.int do
        game["Run Service"].RenderStepped:Wait()
        v3:SetTextureOffset(v4)
    end
    v3.Enabled = false
end
return v1