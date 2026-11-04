 

return {
    ["impact"] = function(p1, p2, p3, p4) --[[ Line: 4 ]]
        _G.destroy(p1, 1)
        p1.Parent:Destroy()
        if p2 then
            _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.BazookaExplosion]:start({
                ["cf"] = CFrame.new(p3),
                ["hit"] = p2,
                ["normal"] = p4
            })
        end
    end,
    ["splash"] = function(p5, p6) --[[ Line: 13 ]]
        _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
            ["obj"] = p5,
            ["Strength"] = 50,
            ["Size"] = 20,
            ["cf"] = p6
        })
    end,
    ["Fire"] = function(_, p7, _) --[[ Name: Fire, Line 18 ]]
        p7.Hole.Attachment.Spark:Emit(5)
        p7.Hole.Attachment.Smoke:Emit(15)
    end
}