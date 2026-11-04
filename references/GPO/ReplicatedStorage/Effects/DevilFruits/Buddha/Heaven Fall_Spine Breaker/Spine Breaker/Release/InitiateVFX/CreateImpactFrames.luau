 

local u1 = game:GetService("Lighting").ColorCorrection
local u2 = game:GetService("Lighting").BlurF
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
return {
    ["Self"] = function() --[[ Name: Self, Line 9 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        TweenCreate(u2, TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = 1
        })
        TweenCreate(u1, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Saturation"] = -0.2,
            ["TintColor"] = Color3.new(0.988235, 0.964706, 0.729412),
            ["Contrast"] = 0.4
        })
        TweenCreate(u1, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Brightness"] = 0.2
        })
        task.delay(0.2, function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            TweenCreate(u2, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["Size"] = 0
            })
            TweenCreate(u1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Brightness"] = u1:GetAttribute("Brightness"),
                ["Contrast"] = u1:GetAttribute("Contrast")
            })
            TweenCreate(u1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Saturation"] = u1:GetAttribute("Saturation"),
                ["TintColor"] = u1:GetAttribute("TintColor")
            })
        end)
    end,
    ["Enemy"] = function() --[[ Name: Enemy, Line 50 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        TweenCreate(u2, TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = 50
        })
        TweenCreate(u1, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Saturation"] = -0.6,
            ["TintColor"] = Color3.new(0.988235, 0.964706, 0.729412),
            ["Contrast"] = 2
        })
        TweenCreate(u1, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Brightness"] = 0.3
        })
        task.delay(0.2, function() --[[ Line: 69 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            TweenCreate(u2, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["Size"] = 0
            })
            TweenCreate(u1, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Brightness"] = u1:GetAttribute("Brightness"),
                ["Contrast"] = u1:GetAttribute("Contrast")
            })
            TweenCreate(u1, TweenInfo.new(0.84, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Saturation"] = u1:GetAttribute("Saturation"),
                ["TintColor"] = u1:GetAttribute("TintColor")
            })
        end)
    end
}