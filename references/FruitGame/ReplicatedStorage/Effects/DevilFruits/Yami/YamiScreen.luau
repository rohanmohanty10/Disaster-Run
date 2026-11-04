 

local v1 = {}
game:GetService("RunService")
function v1.start(_, p2) --[[ Line: 6 ]]
    local v3 = script.ColorCorrection:Clone()
    v3.Saturation = 0
    v3.TintColor = Color3.fromRGB(255, 255, 255)
    v3.Brightness = 0
    v3.Parent = workspace.CurrentCamera
    _G.tween(v3, {
        0.25,
        "Quad",
        "Out",
        0,
        false,
        0
    }, {
        ["TintColor"] = script.ColorCorrection.TintColor,
        ["Saturation"] = script.ColorCorrection.Saturation,
        ["Brightness"] = script.ColorCorrection.Brightness
    })
    _G.destroy(50, 4)
    repeat
        game["Run Service"].Heartbeat:Wait()
    until p2.Parent == nil
    _G.tween(v3, {
        2,
        "Quad",
        "Out",
        0,
        false,
        0
    }, {
        ["TintColor"] = Color3.fromRGB(255, 255, 255),
        ["Saturation"] = 0,
        ["Brightness"] = 0
    })
    _G.destroy(v3, 2)
end
return v1