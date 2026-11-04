 

return {
    ["applyColors"] = function(_, u1, u2) --[[ Name: applyColors, Line 4 ]]
        return pcall(function() --[[ Line: 5 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            local v3 = game.Players:GetPlayerFromCharacter(u1)
            Color3.fromRGB(85, 85, 255)
            if v3 and (u1 ~= nil and u1:FindFirstChild("BusoMelee")) then
                local v4 = game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name)
                if not v4 or v4.Stats.BusoV2.Value ~= true then
                    return
                end
                local v5 = v4.Customization.BusoColor.Value
                local v6 = u2:GetDescendants()
                for v7 = 1, #v6 do
                    if v6[v7]:IsA("BasePart") and (v6[v7].Color == Color3.fromRGB(85, 0, 255) or v6[v7].Color == Color3.fromRGB(98, 37, 209)) then
                        v6[v7].Color = v5
                    elseif v6[v7]:IsA("Decal") then
                        v6[v7].Color3 = Color3.new(v5.r * 5, v5.g * 5, v5.b * 5)
                    elseif v6[v7]:IsA("ParticleEmitter") and v6[v7].Color == ColorSequence.new(Color3.fromRGB(85, 0, 255)) then
                        v6[v7].Color = ColorSequence.new(v5)
                    end
                end
            end
        end)
    end,
    ["getColor"] = function(_, p8) --[[ Name: getColor, Line 32 ]]
        local v9 = game.Players:GetPlayerFromCharacter(p8)
        local v10 = Color3.fromRGB(85, 85, 255)
        if v9 and (p8 and p8:FindFirstChild("BusoMelee")) then
            local v11 = game.ReplicatedStorage:FindFirstChild("Stats" .. v9.Name)
            if v11 and v11.Stats.BusoV2.Value == false or v11 == nil then
                return v10
            end
            v10 = v11.Customization.BusoColor.Value
        end
        return v10
    end
}