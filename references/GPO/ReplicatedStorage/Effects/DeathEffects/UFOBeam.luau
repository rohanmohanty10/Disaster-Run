 

local v1 = {}
local u2 = game:GetService("TweenService")
local _ = _G.customEmit
function v1.start(_, u3) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    Random.new()
    local v4 = u3:GetPivot()
    local v5 = Instance.new("AlignPosition")
    local v6 = u3.PrimaryPart.RootRigAttachment
    v5.Mode = 0
    v5.Attachment0 = v6
    v5.Position = (v4 * CFrame.new(0, 15, 0)).Position
    v5.Parent = u3
    v5.MaxVelocity = 10
    local v7 = script.Beam:Clone()
    v7.CFrame = v4 * CFrame.new(0, 0.195, 0)
    v7.Parent = workspace.Effects
    for _, v8 in v7:GetChildren() do
        if v8:IsA("Beam") then
            local v9 = v8.Width0
            local v10 = v8.Width1
            v8.Width0 = 0
            v8.Width1 = 0
            u2:Create(v8, TweenInfo.new(0.125), {
                ["Width0"] = v9,
                ["Width1"] = v10
            }):Play()
        end
    end
    _G.PlaySound(u3.PrimaryPart, script.BeamGrip)
    task.wait(0.075)
    local v11 = Instance.new("Highlight")
    v11.FillColor = Color3.fromRGB(0, 255, 213)
    v11.FillTransparency = 0.35
    v11.OutlineTransparency = 1
    v11.Parent = u3
    for _, v12 in v7:GetChildren() do
        if v12:IsA("Attachment") then
            for _, v13 in v12:GetChildren() do
                v13.Enabled = true
            end
        end
    end
    task.wait(0.325)
    for _, u14 in v7:GetDescendants() do
        if u14:IsA("Beam") then
            u2:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }):Play()
        elseif u14:IsA("ParticleEmitter") then
            task.delay(0.2, function() --[[ Line: 53 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                u14.Enabled = false
            end)
        end
    end
    _G.destroy(v11, 0.1)
    _G.destroy(v5, 0.65)
    task.delay(0.1, function() --[[ Line: 62 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        for _, v15 in u3:GetDescendants() do
            if v15:IsA("BasePart") and v15.Name ~= "HumanoidRootPart" then
                local v16 = script.delete:Clone()
                for _, v17 in v16:GetChildren() do
                    v17.Parent = v15
                    _G.customEmit(v17)
                end
                v16:Destroy()
                u2:Create(v15, TweenInfo.new(0.2), {
                    ["Color"] = Color3.new(),
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Transparency"] = 1
                }):Play()
            end
        end
    end)
end
return v1