 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return v2.Stats.Crew.Value ~= "" and v2.Stats.Team.Value ~= "Marine" and {
            {
                ["talkname"] = "InCrew",
                ["talknumber"] = 4,
                ["talkend"] = 4
            }
        } or nil
    end
}