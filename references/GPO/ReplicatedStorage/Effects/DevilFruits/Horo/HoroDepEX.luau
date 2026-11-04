 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v2 = script["mini explode"]:Clone()
            v2.CFrame = p1
            v2.Parent = workspace.Effects
            _G.PlaySound(v2, script.boom, {
                ["RandomPitch"] = true
            })
            _G.customEmit(v2)
            _G.tween(v2.Lighting.PointLight, {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 20,
                ["Brightness"] = 0
            })
            _G.destroy(v2, 5)
            _G.shakenear(p1.Position, 75, 125, 35, -0.5)
        end
    end
}