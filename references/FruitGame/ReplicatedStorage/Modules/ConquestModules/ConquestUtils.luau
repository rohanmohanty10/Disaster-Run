 

return {
    ["GetCrewFromPlayer"] = function(p1) --[[ Name: GetCrewFromPlayer, Line 3 ]]
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
        return not v2 and "????" or v2.Stats.Crew.Value
    end,
    ["GetCrewLogo"] = function(p3) --[[ Name: GetCrewLogo, Line 12 ]]
        if game["Run Service"]:IsServer() == true then
            return "rbxthumb://type=Asset&w=420&h=420&id=" .. _G.CrewsService:GetCrewImage(p3)
        else
            return "rbxthumb://type=Asset&w=420&h=420&id=" .. game.ReplicatedStorage.CrewRemote:InvokeServer({
                ["Method"] = "GetImage",
                ["CrewName"] = p3
            })
        end
    end
}