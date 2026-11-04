 

local u3 = {
    ["Costs"] = {
        ["Normal"] = 500
    },
    ["check"] = function(_) --[[ Name: check, Line 7 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        return game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name).Stats.Peli.Value < u3.Costs.Normal and {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        } or (v2:FindFirstChild("Barrel") and {
            {
                ["talkname"] = "haveBarrel",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        } or nil)
    end
}
return u3