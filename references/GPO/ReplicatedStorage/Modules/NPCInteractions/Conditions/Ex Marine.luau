 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return v2:FindFirstChild("Cuffed") ~= nil and {
            {
                ["talkname"] = "TalkStart",
                ["talknumber"] = 1,
                ["talkend"] = 2
            }
        } or nil
    end
}