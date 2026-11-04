 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v2 = script["mini explode"]:Clone()
            v2.CFrame = p1
            v2.Parent = workspace.Effects
            _G.PlaySound(v2, script.boom)
            _G.customEmit(v2.Attachment)
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
        end
    end
}