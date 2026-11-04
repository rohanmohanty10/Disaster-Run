 

local u1 = game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("Lighting")
return function(p4, p5, p6, p7, p8) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u1
    --]]
    local v9 = p8 or 0.2
    local v10 = Instance.new("ColorCorrectionEffect")
    v10.Brightness = p4
    v10.Saturation = p5
    v10.Contrast = p6
    v10.TintColor = p7 or Color3.fromRGB(255, 255, 255)
    v10.Parent = u3
    u2:Create(v10, TweenInfo.new(v9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Brightness"] = 0,
        ["Saturation"] = 0,
        ["Contrast"] = 0,
        ["TintColor"] = Color3.fromRGB(255, 255, 255)
    }):Play()
    u1:AddItem(v10, v9)
end