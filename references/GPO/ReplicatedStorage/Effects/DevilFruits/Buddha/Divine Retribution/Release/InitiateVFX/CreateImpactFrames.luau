 

local u1 = game:GetService("Lighting").BlurF
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
return {
    ["Release"] = function(p2) --[[ Name: Release, Line 9 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = game:GetService("Lighting").ColorCorrection:Clone()
        u3.Parent = workspace.CurrentCamera
        local v4 = 1 - p2 / 200
        local v5 = math.clamp(v4, 0, 1)
        TweenCreate(u1, TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = v5 * 0.5
        })
        TweenCreate(u3, TweenInfo.new(0.01, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Saturation"] = -1,
            ["TintColor"] = Color3.new(1, 1, 1):Lerp(Color3.new(1, 0.839216, 0.258824), v5),
            ["Contrast"] = v5 * 15
        })
        TweenCreate(u3, TweenInfo.new(0.01, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Brightness"] = 0
        })
        task.delay(0.05, function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            TweenCreate(u3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["TintColor"] = Color3.new(1, 1, 1)
            })
        end)
        task.delay(0.16, function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u1
            --]]
            TweenCreate(u3, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Contrast"] = 0
            })
            task.wait(0.2)
            TweenCreate(u1, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Size"] = 0
            })
            TweenCreate(u3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Saturation"] = 0,
                ["TintColor"] = Color3.fromRGB(255, 255, 255)
            })
            _G.destroy(u3, 0.5)
        end)
    end
}