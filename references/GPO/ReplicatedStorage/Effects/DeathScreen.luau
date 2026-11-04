 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = script.Death:Clone()
        local v3 = v2.Main
        local v4 = v2.killerName
        if typeof(p1) == "Instance" then
            p1 = p1.Name
        end
        v4.Value = p1
        v2.Parent = game.Players.LocalPlayer.PlayerGui
        v2.Enabled = true
        v3.Enabled = true
    end
}