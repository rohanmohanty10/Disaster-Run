 

local v1 = {}
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
local u4 = require(v3:WaitForChild("BoatTween"))
local u5 = Random.new()
function v1.start(_, u6, _) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u4
    --]]
    local u7 = script.ASE:Clone()
    u7:SetPrimaryPartCFrame(u6.PrimaryPart.CFrame * CFrame.new(0, -25, 0))
    u7.Parent = workspace.Effects
    local u8 = Instance.new("NumberValue")
    u8.Value = 2.264
    u8.Parent = u7
    local u9 = false
    u6.PrimaryPart.Anchored = true
    task.delay(0.5, function() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u2
            [3] = u9
            [4] = u8
        --]]
        local v10 = CFrame.new(u7.Center.Position + Vector3.new(0, 35, 0))
        local v11 = Instance.new("NumberValue")
        v11.Value = -65
        v11.Parent = u7
        u2:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Value"] = 0
        }):Play()
        local v12 = 0
        local v13 = 0.08726646259971647
        while u7 and (u7.Parent and u7.Center.Anchored) do
            local v14 = v10 * CFrame.new(0, v11.Value + math.sin(v12) / 5, 0)
            local v15 = CFrame.Angles
            local v16 = v12 * 1.5
            local v17 = v14 * v15(math.sin(v16) / 5, 3.141592653589793 + v13, 0)
            if u9 then
                v13 = v13 * 1.05
                u7:ScaleTo(u8.Value)
            end
            u7.PrimaryPart.CFrame = v17
            v12 = v12 + 0.03
            task.wait()
        end
    end)
    tick()
    _G.PlaySound(u7.PrimaryPart, script.Eye)
    task.wait(1)
    local u18 = script.StartEmit:Clone()
    u18.Position = u7.Center.Position + Vector3.new(0, 2, 0)
    u18.Parent = workspace.Effects
    _G.customEmit(u18)
    task.delay(2, function() --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u18
        --]]
        u18:Destroy()
    end)
    for _, v19 in u7:GetChildren() do
        if v19:IsA("BasePart") and v19.Name == "Shine" then
            u2:Create(v19, TweenInfo.new(0.45), {
                ["Color"] = Color3.fromRGB(161, 110, 109)
            }):Play()
        end
    end
    u2:Create(u7.Eye, TweenInfo.new(0.45), {
        ["Color"] = Color3.fromRGB(255, 89, 89)
    }):Play()
    task.wait(0.45)
    local u20 = script.BeamsHolder.Main:Clone()
    u20.Parent = u7.Center
    local u21 = Instance.new("Attachment")
    u21.Parent = u6.UpperTorso
    u21.WorldPosition = u20.WorldPosition
    for _, v22 in u20:GetChildren() do
        if v22:IsA("Beam") then
            v22.Attachment1 = u21
            local v23 = u5:NextNumber(0.1, 0.5)
            local v24 = u5:NextNumber(-1, 1) * u5:NextNumber(2, 3)
            v22.CurveSize0 = v24
            v22.CurveSize1 = v24
            u2:Create(v22, TweenInfo.new(u5:NextNumber(1.1, 1.4), Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut), {
                ["CurveSize0"] = v23,
                ["CurveSize1"] = v23
            }):Play()
        end
    end
    u2:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
        ["Position"] = Vector3.new(0, 0, 0)
    }):Play()
    task.wait(0.75)
    local u25 = Instance.new("Highlight")
    u25.FillTransparency = 1
    u25.FillColor = Color3.fromRGB(255, 41, 26)
    u25.OutlineTransparency = 1
    u25.Parent = u6
    u2:Create(u25, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["FillTransparency"] = 0
    }):Play()
    task.wait(0.385)
    local u26 = script.TouchEmit:Clone()
    u26.Position = u6.HumanoidRootPart.Position
    u26.Parent = workspace.Effects
    _G.customEmit(u26)
    task.delay(0.729, function() --[[ Line: 115 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        u26:Destroy()
    end)
    local v27 = next
    local v28, v29 = u6:GetChildren()
    for _, v30 in v27, v28, v29 do
        if v30:IsA("BasePart") then
            local v31 = next
            local v32, v33 = script.Effects:GetDescendants()
            local u34 = {}
            for _, v35 in v31, v32, v33 do
                if v35:IsA("ParticleEmitter") then
                    local v36 = v35:Clone()
                    v36.Parent = v30
                    u34[#u34 + 1] = v36
                    local v37 = {}
                    for v38 = 1, #v35.Size.Keypoints do
                        local v39 = NumberSequenceKeypoint.new
                        local v40 = v35.Size.Keypoints[v38].Time
                        table.insert(v37, v39(v40, 0, 0))
                    end
                    local v41 = u4
                    local v42 = {
                        ["Time"] = 2.5,
                        ["EasingStyle"] = "Quad",
                        ["EasingDirection"] = "In",
                        ["Goal"] = {
                            ["Size"] = NumberSequence.new(v37)
                        }
                    }
                    v41:Create(v35, v42):Play()
                end
            end
            task.delay(2.5, function() --[[ Line: 151 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                for _, u43 in u34 do
                    u43.Enabled = false
                    task.delay(1, function() --[[ Line: 154 ]]
                        --[[
                        Upvalues:
                            [1] = u43
                        --]]
                        u43:Destroy()
                    end)
                end
            end)
        end
    end
    local u44 = Instance.new("NumberValue")
    u44.Value = u6:GetScale()
    u44.Parent = u6
    u2:Create(u44, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ["Value"] = 0.001
    }):Play()
    task.spawn(function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u44
            [4] = u7
            [5] = u25
            [6] = u20
            [7] = u21
        --]]
        local v45 = tick()
        local v46 = u6.HumanoidRootPart.Position
        u6.HumanoidRootPart.Anchored = true
        local v47 = Instance.new("NumberValue")
        v47.Value = 0
        v47.Parent = u6
        u2:Create(v47, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["Value"] = 1
        }):Play()
        local v48 = 0.1
        while u6 and (u6.Parent and tick() - v45 <= 2.5) do
            u6:ScaleTo(u44.Value)
            local v49 = (v46 - u7.Center.Position).Magnitude
            local v50 = CFrame.new(v46) + CFrame.new(v46, u7.Center.Position).LookVector * (v49 * v47.Value)
            u6.PrimaryPart.CFrame = v50 * CFrame.Angles(math.rad(v48), math.rad(v48), (math.rad(v48)))
            v48 = v48 * 1.055
            if u44.Value <= 0 then
                break
            end
            task.wait()
        end
        for _, v51 in u6:GetDescendants() do
            if v51:IsA("BasePart") then
                v51.Transparency = 1
            end
        end
        u25:Destroy()
        u20:Destroy()
        u21:Destroy()
    end)
    task.wait(2.5)
    for _, v52 in u7:GetChildren() do
        if v52:IsA("BasePart") and v52.Name == "Shine" then
            u2:Create(v52, TweenInfo.new(0.45), {
                ["Color"] = Color3.fromRGB(150, 103, 102)
            }):Play()
        end
    end
    u2:Create(u7.Eye, TweenInfo.new(0.45), {
        ["Color"] = Color3.fromRGB(150, 87, 74)
    }):Play()
    local u53 = script.DoneEmit:Clone()
    u53.Position = u7.Center.Position
    u53.Parent = workspace.Effects
    _G.customEmit(u53)
    task.delay(1.12, function() --[[ Line: 219 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        u53:Destroy()
    end)
    task.wait(0.25)
    u9 = true
    local u54 = script.Rotate:Clone()
    u54.Position = u7.Center.Position
    u54.Parent = workspace.Effects
    task.delay(1.5, function() --[[ Line: 231 ]]
        --[[
        Upvalues:
            [1] = u54
        --]]
        for _, v55 in u54:GetDescendants() do
            if v55:IsA("ParticleEmitter") then
                v55.Enabled = false
            end
        end
        task.wait(1.15)
        u54:Destroy()
    end)
    task.delay(0.5, function() --[[ Line: 243 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u7
        --]]
        u2:Create(u8, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            ["Value"] = 0.001
        }):Play()
        task.wait(2)
        local v56 = script.DeleteEmit:Clone()
        v56.Position = u7.Center.Position
        v56.Parent = workspace.Effects
        _G.customEmit(v56)
        u7:Destroy()
        task.wait(1.12)
        v56:Destroy()
    end)
end
return v1