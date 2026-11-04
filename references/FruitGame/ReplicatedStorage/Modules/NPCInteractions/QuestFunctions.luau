 

return {
    ["QuestHandle"] = function(_, p1, p2, p3) --[[ Name: QuestHandle, Line 3 ]]
        if p3 == nil then
            p3 = game.Players.LocalPlayer
        end
        local v4 = game.ReplicatedStorage:FindFirstChild("Stats" .. p3.Name)
        if v4 ~= nil then
            if p2 == "takequest" and v4.Quest.CurrentQuest.Value == "None" then
                game.ReplicatedStorage.Events.Quest:InvokeServer({ "takequest", p1 })
            end
        end
    end
}