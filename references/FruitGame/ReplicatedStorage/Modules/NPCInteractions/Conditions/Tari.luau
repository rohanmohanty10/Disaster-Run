 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return _G.HasItem(v1, "Karoo Mount") and {
            {
                ["talkname"] = "alreadyhave",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or nil
    end
}