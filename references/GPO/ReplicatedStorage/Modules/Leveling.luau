 

local u3 = {
    ["MaxLevel"] = 675,
    ["MaxPeli"] = 1000000,
    ["LowLevel"] = 20,
    ["pointsPerLvl"] = 3,
    ["MaxBounty"] = 2000000,
    ["statValues"] = {
        ["Strength"] = true,
        ["Defense"] = true,
        ["Stamina"] = true,
        ["GunMastery"] = true,
        ["SwordMastery"] = true,
        ["RokushikiMastery"] = true,
        ["BlackLegMastery"] = true,
        ["ElectroMastery"] = true,
        ["DevilFruitMastery"] = true,
        ["FishmanKarateMastery"] = true,
        ["DragonClawMastery"] = true,
        ["CyborgMastery"] = true,
        ["FightingStyleMastery"] = true
    },
    ["maxexp"] = function(_, p1) --[[ Name: maxexp, Line 29 ]]
        local v2 = 10 * game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name).Stats.Level.Value ^ 0.95
        return math.floor(v2)
    end
}
local function u8(p4) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v5 = p4.Stats.SkillPoints.Value
    local v6 = p4.Stats:GetChildren()
    for v7 = 1, #v6 do
        if u3.statValues[v6[v7].Name] ~= nil then
            v5 = v5 + v6[v7].Value
        end
    end
    return v5
end
function u3.checkBoosted(_, p9) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u8
    --]]
    local v10 = u3
    local v11 = game.ReplicatedStorage:FindFirstChild("Stats" .. p9.Name)
    if v11 then
        return u8(v11) > v10.MaxLevel * v10.pointsPerLvl
    end
end
function u3.lvlup(_, p12, p13) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v14 = game.ReplicatedStorage:FindFirstChild("Stats" .. p12.Name)
    local v15 = p12.Character
    local v16 = 10 * v14.Stats.Level.Value ^ 0.95
    if math.floor(v16) <= v14.Stats.EXP.Value and v14.Stats.Level.Value < u3.MaxLevel then
        local v17 = v14.Stats.EXP
        local v18 = v14.Stats.EXP.Value
        local v19 = 10 * v14.Stats.Level.Value ^ 0.95
        v17.Value = v18 - math.floor(v19)
        v14.Stats.Level.Value = v14.Stats.Level.Value + 1
        v14.Stats.SkillPoints.Value = v14.Stats.SkillPoints.Value + u3.pointsPerLvl
        if v15:FindFirstChild("Head") and v15.Head.Transparency ~= 1 then
            local u20 = script.Core:Clone()
            local v21 = Instance.new("Weld", v15.HumanoidRootPart)
            v21.Part0 = v21.Parent
            v21.Part1 = u20
            u20.Parent = workspace.Effects
            _G.destroy(u20, 3)
            v15.Humanoid:LoadAnimation(script.cheer):Play()
            _G.PlaySound(v15.PrimaryPart, script.Level_up).Parent = v15.PrimaryPart
            task.spawn(function() --[[ Line: 80 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                u20.Attachment.Glow:Emit(1)
                u20.Attachment.Rays:Emit(1)
                task.wait(0.3)
                u20.Attachment.Rays2:Emit(10)
                u20.Attachment.Circles:Emit(25)
                u20.Attachment.Sparkles:Emit(10)
            end)
        end
        if v15.Humanoid.Health < v15.Humanoid.MaxHealth then
            _G.healPlayer(v15, v15.Humanoid.MaxHealth * 1, true, true)
            _G.PlayEffect("ImpelHealEffect", nil, {
                ["Character"] = v15
            })
        end
        local v22 = script.Stats:GetChildren()
        for v23 = 1, #v22 do
            require(v22[v23]):Apply(p12)
        end
        if p13 == nil then
            u3:lvlup(p12)
        end
    end
end
function u3.UpdateAll(_, p24) --[[ Line: 107 ]]
    local v25 = script.Stats:GetChildren()
    for v26 = 1, #v25 do
        require(v25[v26]):Apply(p24)
    end
end
function u3.GetBountyDMGBuff(_, p27) --[[ Line: 116 ]]
    local v28 = game.ReplicatedStorage:FindFirstChild("Stats" .. p27.Name)
    return (not v28 or _G.arena and not _G.raidMode) and 0 or v28.Stats.Bounty.Value / 100000 * 0.01
end
function u3.GetBountyDefenseBuff(_, p29) --[[ Line: 128 ]]
    local v30 = game.ReplicatedStorage:FindFirstChild("Stats" .. p29.Name)
    return (not v30 or _G.arena and not _G.raidMode) and 0 or v30.Stats.Bounty.Value / 100000 * 0.0125
end
return u3