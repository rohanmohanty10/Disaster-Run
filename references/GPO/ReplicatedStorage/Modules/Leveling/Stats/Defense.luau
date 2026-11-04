 

local v1 = {}
local u2 = {
    ["Vampire"] = 0.1
}
function v1.Apply(_, p3) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = game.ReplicatedStorage:FindFirstChild("Stats" .. p3.Name)
    local v5 = p3.Character
    if v5 and v5:FindFirstChild("Humanoid") then
        local v6 = v4.Stats.Level.Value * 1
        local v7 = math.clamp(v6, 0, 100)
        local v8 = 100 + v4.Stats.Defense.Value * script.stat.Value + v7
        local v9 = v5.Humanoid
        local v10 = v5.Humanoid.Health / v5.Humanoid.MaxHealth
        local v11 = v9.Health ~= 0 and v9.Health >= v9.MaxHealth
        local v12 = 1 + require(game.ReplicatedStorage.Modules.Leveling):GetBountyDefenseBuff(p3)
        local v13 = v4.Customization.Race.Value:gsub("%d", "")
        if _G.BattleRoyale == nil then
            if v13 == "Cyborg" then
                if v4.Skills.CyborgUpgrade.Value == "Defense" then
                    v12 = v12 + 0.1
                end
            elseif v13 == "Fishman" then
                v12 = v12 + 0.1
            end
            if u2[v13] then
                v12 = v12 + u2[v13]
            end
        end
        local v14 = v8 * v12 + v5.Boosts.HP.Value
        v9.MaxHealth = v14
        if v11 == true then
            v9.Health = v14
        end
        v9.Health = v9.MaxHealth * v10
    end
end
return v1