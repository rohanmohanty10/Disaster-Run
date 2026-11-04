 

return function(p1) --[[ Line: 1 ]]
    local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    return (not v2 and 800 or 800 + v2.Stats.FightingStyleMastery.Value * 1.5) * 0.75
end