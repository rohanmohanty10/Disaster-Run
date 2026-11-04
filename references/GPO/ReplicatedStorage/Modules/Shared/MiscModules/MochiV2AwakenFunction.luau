 

return function(p1) --[[ Line: 1 ]]
    local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    if _G.BattleRoyale == nil then
        if not v2 then
            return
        end
        if v2.FruitsAwakened.MochiV2.Value < 4 then
            return
        end
        game.ReplicatedStorage.Events.note:FireClient(p1, "<Color=White>You have awakened MOCHI!")
        if v2.Stats.DF.Value == "Mochi-Mochi" then
            _G.setFruit(p1, "MochiV2")
        end
        _G.saveQuestComplete(p1, "MochiV2")
    end
    local v3 = p1.Character
    if v3 and v3.PrimaryPart then
        local v4 = script.HitVFX:Clone()
        v4.CFrame = v3.PrimaryPart.CFrame
        v4.Parent = workspace.Effects
        _G.customEmit(v4)
        _G.destroy(v4, 3)
        _G.PlaySound(v3.PrimaryPart, script.unlockSFX).Parent = v3.PrimaryPart
    end
end