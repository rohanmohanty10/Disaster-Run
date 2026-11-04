 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return _G.HasItem(v1, "Fire Essence") and v2:FindFirstChild("Fire Essence") and {
            {
                ["talkname"] = "awaken",
                ["talknumber"] = 2,
                ["talkend"] = 3
            },
            {
                ["talkname"] = "awaken2",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        } or nil
    end
}