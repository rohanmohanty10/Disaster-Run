 

local v1 = {}
local u2 = false
function v1.start(_, p3, p4, p5, p6, p7) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2 ~= true then
        u2 = true
        local u8 = game:GetService("Lighting").ColorCorrection:Clone()
        u8.Parent = workspace.CurrentCamera
        game:GetService("Lighting").ColorCorrection.Enabled = false
        u8.Enabled = true
        local _ = u8.Brightness
        local _ = u8.Contrast
        local _ = u8.Saturation
        local _ = u8.TintColor
        _G.tween(u8, { 0.01, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
            ["Brightness"] = p3,
            ["Contrast"] = p4,
            ["Saturation"] = p5,
            ["TintColor"] = p6
        })
        task.delay(p7 + 0.03, function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u2
            --]]
            u8:Destroy()
            game:GetService("Lighting").ColorCorrection.Enabled = true
            u2 = false
        end)
    end
end
return v1