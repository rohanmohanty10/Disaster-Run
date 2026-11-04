 

local v1 = {}
local u2 = game:GetService("TweenService")
Random.new()
local u3 = game.Players.LocalPlayer
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u4.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, u5, _) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    local v6 = u5.HumanoidRootPart
    local v7 = script.Amaterasu:Clone()
    v7.Position = v6.Position + Vector3.new(0, -3, 0)
    v7.Parent = workspace.Effects
    local v8 = workspace:Raycast(v7.Position, Vector3.new(0, -10, 0), u4)
    if v8 then
        v7.CFrame = CFrame.new(v8.Position, v8.Position + v8.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
    end
    if u3.Character == u5 then
        local v9 = script.EyeGUI:Clone()
        v9.Parent = u3.PlayerGui
        local u10 = v9.Amaterasu
        local v11 = u10.Size
        u10.Size = UDim2.new(0, 0, 0, 0)
        u10.Visible = true
        u2:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Size"] = v11
        }):Play()
        local u12 = Instance.new("ColorCorrectionEffect")
        u12.Parent = game.Lighting
        u2:Create(u12, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Brightness"] = -0.3,
            ["Contrast"] = 0.5,
            ["Saturation"] = -1
        }):Play()
        u2:Create(u10, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Rotation"] = u10.Rotation + 810
        }):Play()
        task.delay(0.5, function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u10
                [3] = u12
            --]]
            u2:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.new(0, 0, 0, 0)
            }):Play()
            u2:Create(u12, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Contrast"] = 0,
                ["Saturation"] = 0
            }):Play()
            u2:Create(u10, TweenInfo.new(0.5), {
                ["ImageTransparency"] = 1
            }):Play()
            task.wait(0.5)
            u12:Destroy()
            u10.Visible = false
        end)
    end
    _G.PlaySound(u5.PrimaryPart, script.AmaterasuGrip)
    local u13 = Instance.new("Highlight")
    u13.FillTransparency = 1
    u13.FillColor = Color3.fromRGB(0, 0, 0)
    u13.OutlineTransparency = 1
    u13.Parent = u5
    u2:Create(u13, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["FillTransparency"] = 0
    }):Play()
    task.delay(1.5, function() --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u5
        --]]
        u13:Destroy()
        for _, v14 in u5:GetDescendants() do
            if v14:IsA("BasePart") then
                v14.Transparency = 1
            end
        end
    end)
    local v15 = next
    local v16, v17 = v7:GetDescendants()
    for _, u18 in v15, v16, v17 do
        if u18:IsA("ParticleEmitter") then
            local v19 = u18:GetAttribute("EmitDuration")
            if v19 and v19 > 0 then
                u18.Enabled = true
                task.delay(v19, function() --[[ Line: 80 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18.Enabled = false
                end)
            else
                u18:Emit(u18:GetAttribute("EmitCount"))
            end
        end
    end
    task.wait(5)
    v7:Destroy()
end
return v1