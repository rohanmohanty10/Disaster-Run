 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if p1 then
            local v2 = script.SulongAwakenEyes:Clone()
            v2.Parent = game.Players.LocalPlayer.PlayerGui
            v2.LocalScript.Disabled = false
        else
            local v3 = script.SulongAwaken:Clone()
            v3.Parent = game.Players.LocalPlayer.PlayerGui
            v3.LocalScript.Disabled = false
            script.heartbeat:Play()
        end
    end
}