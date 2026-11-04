 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v3 = game.Players.LocalPlayer
    local _ = v3.Character
    local v4 = game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name)
    local v5 = u2.GetM("Gear 2 Transformation")
    return (v4.Stats.Gear2.Value < v5.statreq.Gear2 - 1 or v4.Stats.DF.Value ~= "Gomu-Gomu") and {
        {
            ["talkname"] = "noTalk",
            ["talknumber"] = 1,
            ["talkend"] = 1
        }
    } or nil
end
return v1