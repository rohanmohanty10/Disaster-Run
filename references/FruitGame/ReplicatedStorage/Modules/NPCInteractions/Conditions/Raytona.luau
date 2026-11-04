 

local v3 = {
    ["Costs"] = {
        ["Normal"] = 500
    },
    ["check"] = function(_) --[[ Name: check, Line 7 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        if v2 and v2.Stats.BusoV2.Value == true then
            return {
                {
                    ["talkname"] = "alreadyTeached",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if _G.HasItem(v1, "Spirit Essence") == false then
            return {
                {
                    ["talkname"] = "donthave",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
    end
}
return v3