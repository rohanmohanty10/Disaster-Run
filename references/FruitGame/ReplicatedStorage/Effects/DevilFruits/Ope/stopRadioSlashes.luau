 

local v1 = {}
require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p2, _, _) --[[ Line: 5 ]]
    local _ = script
    p2.PrimaryPart:FindFirstChild("holdingRadioKnife"):Destroy()
end
return v1