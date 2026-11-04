 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        return (script:GetAttribute("req") or 2) > _G.CheckItemAmmount(v1, "Life Essence") and {
            {
                ["talkname"] = "notenough",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        } or nil
    end
}