 

return {
    ["start"] = function(_) --[[ Name: start, Line 2 ]]
        local v1 = script.ColorCorrection:Clone()
        v1.TintColor = Color3.fromRGB(255, 255, 255)
        v1.Parent = workspace.CurrentCamera
        _G.tween(v1, {
            0.5,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out,
            1,
            true,
            0
        }, {
            ["TintColor"] = script.ColorCorrection.TintColor
        })
        _G.destroy(v1, 1)
    end
}