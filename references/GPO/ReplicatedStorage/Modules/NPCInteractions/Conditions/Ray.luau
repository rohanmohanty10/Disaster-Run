 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        return game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name).Stats.Peli.Value < 25000 and {
            {
                ["talkname"] = "Talk5",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        } or nil
    end
}