 

return function(p1) --[[ Line: 1 ]]
    local v2 = 700
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    if v3 then
        v2 = v2 + v3.Stats.Strength.Value * 1.1
    end
    return v2
end