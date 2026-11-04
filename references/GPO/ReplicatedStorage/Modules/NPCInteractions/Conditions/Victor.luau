 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        local v3
        if v2:FindFirstChild("ragcarry") then
            v3 = v2:FindFirstChild("ragcarry").Value
        else
            v3 = nil
        end
        if v2:FindFirstChild("ragcarry") == nil then
            return nil
        end
        if not (v2:FindFirstChild("ragcarry") and (v3 and (v2:FindFirstChild(v3.Name .. "\'s Poster") or v1.Backpack:FindFirstChild(v3.Name .. "\'s Poster")))) then
            return nil
        end
        local _ = v2.ragcarry.Value
        return {
            {
                ["talkname"] = "TalkStart",
                ["talknumber"] = 1,
                ["talkend"] = 2
            }
        }
    end
}