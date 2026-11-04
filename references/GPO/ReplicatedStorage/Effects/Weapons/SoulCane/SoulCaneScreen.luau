 

local v1 = {}
local function u3() --[[ Line: 2 ]]
    local u2 = script.ScreenGui:Clone()
    u2.Frame.Size = UDim2.new(0, 0, 0, 0)
    u2.Frame.Rotation = math.random(-360, 360)
    u2.Frame.Position = UDim2.new(math.random(100, 800) / 1000, 0, 0.5, 0)
    u2.Frame.Size = UDim2.new(0.1, 0, 4, 0)
    u2.Parent = game.Players.LocalPlayer.PlayerGui
    _G.tween(u2.Frame, {
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = UDim2.new(0.15, 0, 4, 0),
        ["SliceScale"] = -45
    })
    task.spawn(function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        task.wait(0.5)
        _G.destroy(u2, 0.1)
    end)
end
function v1.start(_) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v4 = script.ColorCorrection:Clone()
    v4.TintColor = Color3.fromRGB(255, 255, 255)
    v4.Contrast = 0
    v4.Saturation = 0
    v4.Parent = workspace.CurrentCamera
    _G.tween(v4, {
        0.17999999999999994,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Saturation"] = script.ColorCorrection.Saturation,
        ["TintColor"] = script.ColorCorrection.TintColor,
        ["Contrast"] = script.ColorCorrection.Contrast
    })
    task.wait(0.17999999999999994)
    u3()
    task.wait(0.1)
    u3()
    task.wait(0.1)
    u3()
    task.wait(0.1)
    _G.tween(v4, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Saturation"] = 0,
        ["TintColor"] = Color3.fromRGB(255, 255, 255),
        ["Contrast"] = 0
    })
    _G.destroy(v4, 0.25)
end
return v1