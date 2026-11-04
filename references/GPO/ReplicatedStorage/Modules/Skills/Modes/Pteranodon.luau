 

return function(p1) --[[ Line: 1 ]]
    local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    return not v2 and 800 or 800 + v2.Stats.DevilFruitMastery.Value * 1.5
end