 

return {
    ["impact"] = function(p1, p2, p3, p4) --[[ Line: 4 ]]
        if p1 then
            _G.destroy(p1, 1)
            p1.Parent:Destroy()
        end
        if p2 then
            _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Cannon]:start({
                ["cf"] = CFrame.new(p3),
                ["hit"] = p2,
                ["normal"] = p4
            })
        end
    end,
    ["splash"] = function(p5, p6) --[[ Line: 15 ]]
        p5.Whis:Stop()
        _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
            ["obj"] = p5,
            ["Strength"] = 100,
            ["Size"] = 20,
            ["cf"] = p6
        })
    end,
    ["Fire"] = function(_, _, p7) --[[ Name: Fire, Line 21 ]]
        local v8 = BrickColor.Random()
        p7.Color = v8.Color
        p7.Trail.Color = ColorSequence.new(v8.Color)
        p7.PointLight.Color = v8.Color
        p7.Whis:Play()
    end
}