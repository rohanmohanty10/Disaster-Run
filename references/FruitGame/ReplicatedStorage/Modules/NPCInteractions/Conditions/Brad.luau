 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        return game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name).Stats.Peli.Value < 2000 and {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        } or (v2:FindFirstChild("coatBubble") and {
            {
                ["talkname"] = "already",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        } or nil)
    end
}