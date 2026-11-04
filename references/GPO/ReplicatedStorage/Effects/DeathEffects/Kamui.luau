 

local v1 = {}
local u2 = game:GetService("TweenService")
Random.new()
local u3 = game.Players.LocalPlayer
function v1.start(_, u4, p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local u6 = u4.HumanoidRootPart
    local u7 = script.Kamui:Clone()
    u7.Position = u6.Position
    u7.Parent = workspace.Effects
    if u3.Character == p5 or u3.Character == u4 then
        local v8 = script.EyeGUI:Clone()
        v8.Parent = u3.PlayerGui
        local u9 = v8.Kamui
        u9.ImageTransparency = 1
        u9.Visible = true
        local u10 = Instance.new("ColorCorrectionEffect")
        u10.Parent = game.Lighting
        u2:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Brightness"] = -0.3,
            ["Contrast"] = 0.5,
            ["Saturation"] = -1
        }):Play()
        u2:Create(u9, TweenInfo.new(0.25), {
            ["ImageTransparency"] = 0
        }):Play()
        u2:Create(u9, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Rotation"] = u9.Rotation + 810
        }):Play()
        task.delay(0.5, function() --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u10
                [3] = u9
            --]]
            u2:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Contrast"] = 0,
                ["Saturation"] = 0
            }):Play()
            u2:Create(u9, TweenInfo.new(0.5), {
                ["ImageTransparency"] = 1
            }):Play()
            task.wait(0.5)
            u10:Destroy()
            u9.Visible = false
        end)
    end
    local v11 = Instance.new("Highlight")
    v11.FillTransparency = 1
    v11.FillColor = Color3.fromRGB(0, 0, 0)
    v11.OutlineTransparency = 1
    v11.Parent = u4
    u2:Create(v11, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["FillTransparency"] = 0
    }):Play()
    local u12 = Instance.new("NumberValue")
    u12.Value = 1
    u12.Parent = u7
    u2:Create(u12, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["Value"] = 0.001
    }):Play()
    task.spawn(function() --[[ Line: 55 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u6
            [3] = u7
            [4] = u12
        --]]
        u4:ScaleTo(1)
        u6.Anchored = true
        local v13 = 0.1
        while u7 and u7.Parent do
            u4:ScaleTo(u12.Value)
            u6.CFrame = u6.CFrame * CFrame.Angles(math.rad(v13), math.rad(v13), (math.rad(v13)))
            local v14 = 5 - v13
            v13 = v13 + math.clamp(0.1, 0, v14)
            if u4:GetScale() <= 0.01 then
                break
            end
            task.wait(0.05)
        end
    end)
    task.wait(2)
    for _, v15 in u7:GetDescendants() do
        if v15:IsA("ParticleEmitter") then
            v15.Enabled = false
        end
    end
    task.wait(2)
    u7:Destroy()
end
return v1