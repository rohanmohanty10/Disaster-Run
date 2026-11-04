 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 6 ]]
        local v2 = script.ColorCorrection:Clone()
        v2.TintColor = Color3.fromRGB(255, 255, 255)
        v2.Parent = workspace.CurrentCamera
        _G.destroy(v2, p1 + 0.25)
        _G.tween(v2, {
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 0, 0)
        })
        task.wait(p1)
        _G.tween(v2, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
    end
}