 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local _ = game.Players.LocalPlayer.Character
        return workspace.Env.SantaSlay.ready.Value == true and {
            {
                ["talkname"] = "ready",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or nil
    end
}