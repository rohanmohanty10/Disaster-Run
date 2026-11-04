 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 4 ]]
    local v2 = game.Players.LocalPlayer
    local _ = v2.Character
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    return v3.Stats.Peli.Value < 50000 and v3.Skills.skyWalk.Value == false and {
        {
            ["talkname"] = "nomoney",
            ["talknumber"] = 3,
            ["talkend"] = 3
        }
    } or (v3.Skills.skyWalk.Value == true and {
        {
            ["talkname"] = "have",
            ["talknumber"] = 1,
            ["talkend"] = 1
        }
    } or nil)
end
return v1