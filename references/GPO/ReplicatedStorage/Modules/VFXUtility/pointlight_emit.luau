 

local u1 = game:GetService("Debris")
local u2 = game:GetService("TweenService")
return function(p3, p4, p5, p6, p7, p8) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v9 = p5 or 1
    local v10 = Instance.new("PointLight")
    v10.Enabled = true
    v10.Color = p4 or Color3.fromRGB(105, 195, 255)
    v10.Range = p6 or 10
    v10.Brightness = p8 or 2
    v10.Shadows = false
    v10.Parent = p3
    u2:Create(v10, TweenInfo.new(v9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Brightness"] = 0,
        ["Range"] = p7 or (p6 or 10) * 1.5
    }):Play()
    u1:AddItem(v10, v9)
    return v10
end