 

local _ = game:GetService("Lighting").ColorCorrection
local u1 = game:GetService("Lighting").BlurF
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
return {
    ["Self"] = function() --[[ Name: Self, Line 9 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u2 = game:GetService("Lighting").ColorCorrection:Clone()
        u2.Parent = workspace.CurrentCamera
        TweenCreate(u1, TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = 1
        })
        TweenCreate(u2, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Saturation"] = -0.2,
            ["TintColor"] = Color3.new(0.988235, 0.964706, 0.729412),
            ["Contrast"] = 0.4
        })
        TweenCreate(u2, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Brightness"] = 0.2
        })
        task.delay(0.2, function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            TweenCreate(u1, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["Size"] = 0
            })
            TweenCreate(u2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Brightness"] = u2:GetAttribute("Brightness"),
                ["Contrast"] = u2:GetAttribute("Contrast")
            })
            TweenCreate(u2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Saturation"] = u2:GetAttribute("Saturation"),
                ["TintColor"] = u2:GetAttribute("TintColor")
            })
            _G.destroy(u2, 1)
        end)
    end,
    ["Enemy"] = function() --[[ Name: Enemy, Line 51 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = game:GetService("Lighting").ColorCorrection:Clone()
        u3.Parent = workspace.CurrentCamera
        TweenCreate(u1, TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = 50
        })
        TweenCreate(u3, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Saturation"] = -0.6,
            ["TintColor"] = Color3.new(0.988235, 0.964706, 0.729412),
            ["Contrast"] = 2
        })
        TweenCreate(u3, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Brightness"] = 0.3
        })
        task.delay(0.2, function() --[[ Line: 71 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
            --]]
            TweenCreate(u1, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["Size"] = 0
            })
            TweenCreate(u3, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Brightness"] = u3:GetAttribute("Brightness"),
                ["Contrast"] = u3:GetAttribute("Contrast")
            })
            TweenCreate(u3, TweenInfo.new(0.84, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Saturation"] = u3:GetAttribute("Saturation"),
                ["TintColor"] = u3:GetAttribute("TintColor")
            })
            _G.destroy(u3, 1)
        end)
    end
}