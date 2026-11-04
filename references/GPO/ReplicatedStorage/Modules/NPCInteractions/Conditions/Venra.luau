 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        warn("checking queue")
        local v3 = game.ReplicatedStorage.Events.KarooRace:InvokeServer("checkQueue")
        local v4 = game.ReplicatedStorage.Events.KarooRace:InvokeServer("checkQueue", true)
        warn("chcked queue")
        if _G.HasItem(v1, "Karoo Mount") == false then
            warn("no karoo")
            return {
                {
                    ["talkname"] = "noKaroo",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v2.Stats.Peli.Value < 5000 then
            warn("no money")
            return {
                {
                    ["talkname"] = "nomoney",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v3 == false then
            warn("full")
            return {
                {
                    ["talkname"] = "full",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v4 == true then
            warn("in queue")
            return {
                {
                    ["talkname"] = "inQueue",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
    end
}