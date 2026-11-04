 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return v2.Stats.KenMastery.Value <= 0 and {
            {
                ["talkname"] = "notlearn",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or (v2.Skills.KenV2.Value == true and {
            {
                ["talkname"] = "masterd",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or (v2.Stats.Peli.Value < 25000 and {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 4,
                ["talkend"] = 4
            }
        } or nil))
    end
}