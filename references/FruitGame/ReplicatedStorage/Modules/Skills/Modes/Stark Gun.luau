 

return function(p1) --[[ Line: 1 ]]
    local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    return not v2 and 800 or 500 + v2.Stats.GunMastery.Value * 1.25
end