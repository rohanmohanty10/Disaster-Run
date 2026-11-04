 

local v1 = {}
local function u4(p2, p3) --[[ Line: 3 ]]
    if p2:IsA("BasePart") and (p2.Color == Color3.fromRGB(85, 0, 255) or p2.Color == Color3.fromRGB(98, 37, 209)) then
        p2.Color = p3
        return
    elseif p2:IsA("Decal") then
        p2.Color3 = Color3.new(p3.r * 5, p3.g * 5, p3.b * 5)
    elseif p2:IsA("ParticleEmitter") then
        p2.Color = ColorSequence.new(p3)
    end
end
function v1.applyColors(_, u5, u6) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return pcall(function() --[[ Line: 14 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u6
        --]]
        local v7 = game.Players:GetPlayerFromCharacter(u5)
        Color3.fromRGB(85, 85, 255)
        if v7 and (u5 ~= nil and u5:FindFirstChild("BusoMelee")) then
            local v8 = game.ReplicatedStorage:FindFirstChild("Stats" .. v7.Name)
            if not v8 or v8.Stats.BusoV2.Value ~= true then
                return
            end
            local v9 = v8.Customization.BusoColor.Value
            u4(u6, v9)
            local v10 = u6:GetDescendants()
            for v11 = 1, #v10 do
                u4(v10[v11], v9)
            end
        end
    end)
end
function v1.getColor(_, p12) --[[ Line: 37 ]]
    local v13 = game.Players:GetPlayerFromCharacter(p12)
    local v14 = Color3.fromRGB(85, 85, 255)
    if v13 and (p12 and p12:FindFirstChild("BusoMelee")) then
        local v15 = game.ReplicatedStorage:FindFirstChild("Stats" .. v13.Name)
        if v15 and v15.Stats.BusoV2.Value == false or v15 == nil then
            return v14
        end
        v14 = v15.Customization.BusoColor.Value
    end
    return v14
end
return v1