 

return function(p1) --[[ Line: 1 ]]
    local v2 = 900
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    if v3 then
        v2 = v2 + v3.Stats.FightingStyleMastery.Value * 1.25
    end
    return v2
end