 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 4 ]]
    local v2 = game.Players.LocalPlayer
    local _ = v2.Character
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    if v3.Skills.SkypianFlight.Value == true then
        return {
            {
                ["talkname"] = "got",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Customization.Race.Value:match("Skypian") == nil then
        return {
            {
                ["talkname"] = "NotWings",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Stats.Peli.Value < 10000 then
        return {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        }
    end
end
return v1