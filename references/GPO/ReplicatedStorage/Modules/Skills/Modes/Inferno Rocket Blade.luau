 

return function(p1) --[[ Line: 1 ]]
    local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    local v3
    if v2 then
        local v4 = 150 + v2.Stats.Defense.Value * 0.75 + v2.Stats.GunMastery.Value * 1.25
        v3 = math.ceil(v4)
    else
        v3 = 800
    end
    return v3
end