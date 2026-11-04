 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 4 ]]
        if p3 and game.Players.LocalPlayer == p3 then
            return
        elseif _G.checkRenderDistance(p2.Position) ~= false then
            local v4 = script.StartEff:Clone()
            v4.Parent = workspace.Effects
            v4.CFrame = CFrame.new(p1.Position, p2.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
            local v5 = _G.getRayFloor(p1, 10)
            if v5 == nil then
                v4.Attachment2:Destroy()
            else
                v4.Attachment2.Dust.Color = ColorSequence.new(v5.Color)
                v4.Attachment2.Debris.Color = v4.Attachment2.Dust.Color
            end
            _G.customEmit(v4)
            _G.destroy(v4, 1)
            _G.PlaySound(v4, script.dash, {
                ["Pitch"] = math.random(90, 110) / 100
            })
            local v6 = script.Paw2:Clone()
            v6.CFrame = CFrame.new(p1.Position, p2.Position)
            v6.Parent = workspace.Effects
            local v7 = v6.Size * 3
            v6.Size = v7 / 2
            _G.tween(v6, { 0.25, "Quad", "Out" }, {
                ["Transparency"] = 1,
                ["Size"] = v7
            })
            _G.destroy(v6, 0.25)
            local v8 = script.Paw2:Clone()
            v8.CFrame = CFrame.new(p1.Position, p2.Position)
            v8.Parent = workspace.Effects
            v8.Material = Enum.Material.Neon
            v8.Transparency = 0.75
            local v9 = v8.Size * 3.2
            v8.Size = v9 / 2
            _G.tween(v8, { 0.3, "Quad", "Out" }, {
                ["Transparency"] = 1,
                ["Size"] = v9
            })
            _G.destroy(v8, 0.3)
        end
    end
}