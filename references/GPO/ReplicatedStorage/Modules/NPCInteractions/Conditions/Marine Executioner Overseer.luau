 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        if game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name).Stats.Team.Value ~= "Marine" then
            return {
                {
                    ["talkname"] = "PIRATE",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        local v3 = false
        if v2:FindFirstChild("ragcarry") then
            local v4 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2:FindFirstChild("ragcarry").Value.Name)
            v3 = v4 and v4.Stats.Team.Value == "Marine" and true or v3
        end
        return v2:FindFirstChild("ragcarry") == nil and {
            {
                ["talkname"] = "NoCarry",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or (v3 == true and {
            {
                ["talkname"] = "IsMarine",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or nil)
    end
}