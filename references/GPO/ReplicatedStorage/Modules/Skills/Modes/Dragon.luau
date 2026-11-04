 

return function(p1) --[[ Line: 1 ]]
    local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    local v3 = 900
    if v2 then
        v3 = v3 + v2.Stats.DevilFruitMastery.Value * 1.3
    end
    return v3
end