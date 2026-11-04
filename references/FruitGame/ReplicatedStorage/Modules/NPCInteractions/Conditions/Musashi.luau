 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        if _G.HasItem(v1, "Book of Nitoryu") and (v2.Skills["2SS"].Value > 0 and v2.Skills["2SS"].Value < 5) then
            return {
                {
                    ["talkname"] = "have",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        local v3 = v2.Skills["2SS"].Value >= 5
        return v2.Stats.Peli.Value < 10000 and {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 4,
                ["talkend"] = 4
            }
        } or ((v2.Skills["1SS"].Value < 5 or v2.Stats.FightingStyle.Value ~= "1SS") and (v2.Stats.FightingStyle.Value ~= "2SS" and v3 == false) and {
            {
                ["talkname"] = "notWorth",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or (v2.Skills["2SS"].Value >= 5 and v2.Stats.FightingStyle.Value == "2SS" and {
            {
                ["talkname"] = "max",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or (v2.Skills["2SS"].Value >= 5 and {
            {
                ["talkname"] = "switch1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "switch2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        } or nil)))
    end
}