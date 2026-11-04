 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if p2 then
            local v3 = script.ColorCorrection:Clone()
            v3.Parent = workspace.CurrentCamera
            v3.Brightness = 0.2
            v3.Name = "toriHealScreen2"
            _G.tween(v3, {
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["TintColor"] = Color3.fromRGB(255, 255, 255),
                ["Brightness"] = 0
            })
            _G.destroy(v3, 1)
            return
        elseif p1 == nil then
            local v4 = script.ColorCorrection:Clone()
            v4.Parent = workspace.CurrentCamera
            v4.Name = "toriHealScreen"
            _G.tween(v4, {
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                -1,
                true,
                0
            }, {
                ["TintColor"] = Color3.fromRGB(255, 255, 255),
                ["Brightness"] = 0
            })
        else
            local v5 = workspace.CurrentCamera:FindFirstChild("toriHealScreen")
            if v5 then
                v5.Name = "done"
                _G.tween(v5, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["TintColor"] = Color3.fromRGB(255, 255, 255),
                    ["Brightness"] = 0
                }, nil, true)
                _G.destroy(v5, 0.5)
            end
        end
    end
}