 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local _ = v1.Character
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        if v2.Stats.Crew.Value == "" then
            return {
                {
                    ["talkname"] = "noCrew",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v2.Stats.Crew.Value == "" then
            return nil
        end
        local v3, v4 = game.ReplicatedStorage.CrewRemote:InvokeServer({
            ["Method"] = "GetOwnerId"
        })
        if not v4 then
            return nil
        end
        if v3 and v3 ~= v1.UserId or v3 == nil then
            return {
                {
                    ["talkname"] = "notOwner",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
    end
}