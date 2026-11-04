 

return function(p1) --[[ Line: 1 ]]
    if _G.BattleRoyale == nil then
        local v2 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
        if not v2 then
            return
        end
        if v2.FruitsAwakened.PikaV2.Value < 5 then
            return
        end
        game.ReplicatedStorage.Events.note:FireClient(p1, "<Color=Yellow>You have awakened PIKA!")
        if v2.Stats.DF.Value == "Pika-Pika" then
            _G.setFruit(p1, "PikaV2")
        end
        _G.saveQuestComplete(p1, "PikaV2")
    end
    local v3 = p1.Character
    if v3 and v3.PrimaryPart then
        local v4 = script.reflect:Clone()
        v4.CFrame = v3.PrimaryPart.CFrame
        v4.Parent = workspace.Effects
        _G.customEmit(v4)
        _G.tween(v4.PointLight, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 15,
            ["Brightness"] = 0
        })
        _G.destroy(v4, 3)
        _G.PlaySound(v3.PrimaryPart, script.PikaV2Unlock).Parent = v3.PrimaryPart
    end
end