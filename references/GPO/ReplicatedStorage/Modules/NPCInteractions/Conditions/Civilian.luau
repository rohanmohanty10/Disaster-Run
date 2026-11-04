 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 4 ]]
    local v2 = game.Players.LocalPlayer
    local _ = v2.Character
    game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    return {
        {
            ["talkname"] = "Talk" .. math.random(1, 98),
            ["talknumber"] = 1,
            ["talkend"] = 1
        }
    }
end
return v1