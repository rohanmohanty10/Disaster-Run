 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
local u2 = workspace.CurrentCamera
Random.new()
require(script.Parent.Shared)
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 17 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v4 = p3.Position
        if not v4 or (u2.CFrame.Position - v4).Magnitude < 100 then
            local v5 = Instance.new("ColorCorrectionEffect")
            v5.Enabled = true
            v5.Parent = game.Lighting
            task.delay(2, v5.Destroy, v5)
            v5.Contrast = 2
            v5.Saturation = -1
            task.wait(0.03)
            v5.Contrast = -2
            v5.Brightness = 0.5
            task.wait(0.007)
            v5.Contrast = 2
            v5.Saturation = 1
            v5.TintColor = p3.Color
            u1:Create(v5, TweenInfo.new(0.35), {
                ["Contrast"] = 0,
                ["Saturation"] = 0,
                ["Brightness"] = 0,
                ["TintColor"] = Color3.new(1, 1, 1)
            }):Play()
        end
    end
}