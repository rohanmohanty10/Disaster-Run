 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        for _, v4 in p1 do
            v4.Enabled = p2
        end
        p3.ActionText = p2 and "Carry" or "Drop"
        if not p2 then
            local v5 = os.clock()
            repeat
                task.wait()
            until not game.Players.LocalPlayer.Character:GetAttribute("WholeCakeCarrying") or os.clock() - v5 > 10
            if os.clock() - v5 > 10 then
                warn("TIMEOUT: WholeCakeCarrying yield expired")
            end
            for _, v6 in p1 do
                v6.Enabled = true
            end
        end
    end
}