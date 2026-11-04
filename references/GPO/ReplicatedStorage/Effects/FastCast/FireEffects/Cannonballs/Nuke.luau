 

return {
    ["impact"] = function(p1, p2, p3, p4, p5) --[[ Line: 4 ]]
        _G.destroy(p1, 1)
        p1.Parent:Destroy()
        if p2 then
            if p5.remote and p5.ply == game.Players.LocalPlayer then
                p5.remote:FireServer(p3, p2, p5.delta)
            end
            _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.NukeExplosion]:start({
                ["cf"] = CFrame.new(p3),
                ["hit"] = p2,
                ["normal"] = p4
            })
        end
    end,
    ["splash"] = function(p6, p7) --[[ Line: 18 ]]
        _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
            ["obj"] = p6,
            ["Strength"] = 50,
            ["Size"] = 20,
            ["cf"] = p7
        })
    end,
    ["Fire"] = function(_, _, p8) --[[ Name: Fire, Line 24 ]]
        p8.Parent.back.sfx:Play()
        _G.PlayEffect("SurfaceTrail", nil, p8.Parent.Tip, nil, nil, 30, true, 500)
    end
}