 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 4 ]]
        if p3 and game.Players.LocalPlayer == p3 then
            return
        elseif _G.checkRenderDistance(p2.Position) ~= false then
            local v4 = script.Part:Clone()
            v4.Parent = workspace.Effects
            v4.CFrame = p2
            _G.customEmit(v4.Attachment)
            _G.tween(v4.PointLight, {
                0.2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 10,
                ["Brightness"] = 0
            })
            _G.destroy(v4, 1)
            local v5 = (p1.Position - p2.Position).Magnitude
            local v6 = script.cyn:Clone()
            v6.Parent = workspace.Effects
            v6.CFrame = CFrame.new(p1.Position, p2.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v5 / 2, 0)
            v6.Mesh.Scale = Vector3.new(1, v5, 1)
            local v7 = _G.tween
            local v8 = v6.Mesh
            local v9 = {
                0.2,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v10 = {
                ["Scale"] = Vector3.new(0, 0, 0)
            }
            local v11 = -v5 / 2
            v10.Offset = Vector3.new(0, v11, 0)
            v7(v8, v9, v10)
            _G.destroy(v6, 0.2)
            _G.PlaySound(p2, script.LightTp2)
        end
    end
}