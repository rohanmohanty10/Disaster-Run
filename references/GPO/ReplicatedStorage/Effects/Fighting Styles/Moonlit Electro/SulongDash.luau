 

return {
    ["start"] = function(_, p1, p2, _) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            local v3 = (p1.Position - p2.Position).Magnitude
            local v4 = script.SulongDash:Clone()
            local v5 = v4.Dash
            local v6 = v4.Dash.Size.X
            local v7 = v4.Dash.Size.Z
            v5.Size = Vector3.new(v6, v3, v7)
            v4:SetPrimaryPartCFrame(CFrame.new(p1.Position, p2.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, v3 / 2, 0))
            v4.CharacterEmit.CFrame = p2
            v4.Parent = workspace.Effects
            _G.tween(v4.CharacterEmit.PointLight, {
                0.1,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 15,
                ["Brightness"] = 0
            })
            _G.customEmit(v4)
            _G.PlaySound(v4.Dash, script.TpDash, {
                ["Pitch"] = math.random(90, 110) / 100
            })
            _G.destroy(v4, 4)
        end
    end
}