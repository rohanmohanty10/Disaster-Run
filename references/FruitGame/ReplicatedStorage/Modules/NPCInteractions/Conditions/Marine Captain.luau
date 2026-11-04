 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return v1.Team ~= game.Teams.Marine and {
            {
                ["talkname"] = "notMarine",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or nil
    end
}