 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return v2:FindFirstChild("Barrel") == nil and {
            {
                ["talkname"] = "noBarrel",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        } or nil
    end
}