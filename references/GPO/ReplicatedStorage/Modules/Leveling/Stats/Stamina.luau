 

local v10 = {
    ["Apply"] = function(_, p1) --[[ Name: Apply, Line 14 ]]
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
        local v3 = p1.Character
        if v3 and v3:FindFirstChild("Humanoid") then
            local v4 = v2.Stats.Level.Value
            local v5 = math.clamp(v4, 0, 100)
            local v6 = 100 + v2.Stats.Stamina.Value * script.stat.Value + v5
            local v7 = v2.Stamina.Value >= v2.Stamina.MaxValue
            local v8 = v2.Customization.Race.Value:gsub("%d", "")
            if _G.BattleRoyale == nil then
                if v2 and v8 == "Mink" then
                    v6 = v6 * 1.1
                end
                if v8 == "Cyborg" and v2.Skills.CyborgUpgrade.Value == "Stamina" then
                    v6 = v6 * 1.1
                end
                if v8 == "Dullahan" then
                    v6 = v6 * 1.15
                end
            end
            local v9 = v6 + v3.Boosts.MaxStam.Value
            v2.Stamina.MaxValue = v9
            if v7 == true then
                v2.Stamina.Value = v9
            end
        end
    end
}
return v10