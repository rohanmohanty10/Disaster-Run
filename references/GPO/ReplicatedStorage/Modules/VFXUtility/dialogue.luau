 

local u1 = game:GetService("CollectionService")
local u2 = game:GetService("TextService")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("Players").LocalPlayer
local v5 = {}
function getColor(p6, p7)
    local v8 = p7[1]
    local _ = p7[#p7]
    local v9 = v8.Value
    for v10 = 1, #p7 - 1 do
        if p7[v10].Time <= p6 and p6 <= p7[v10 + 1].Time then
            local v11 = p7[v10]
            local v12 = p7[v10 + 1]
            local v13 = (p6 - v11.Time) / (v12.Time - v11.Time)
            return v11.Value:lerp(v12.Value, v13)
        end
    end
    return v9
end
local function u16(p14) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    for _, v15 in p14:GetChildren() do
        if v15.Name == "letter" then
            v15:SetAttribute("Ending", true)
            u3:Create(v15, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Position"] = v15.Position + UDim2.new(0, 0, 0, 50),
                ["TextTransparency"] = 1,
                ["TextStrokeTransparency"] = 1
            }):Play()
            game.Debris:AddItem(v15, 0.5)
        end
    end
end
local function u56(p17, p18, p19, u20) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u3
        [4] = u16
        [5] = u2
    --]]
    local v21 = p18 or u4
    local u22 = game.StarterGui:FindFirstChild(v21 .. "CUSTOM_DIALOGUE") or script.CUSTOM_DIALOGUE:Clone()
    local v23 = ""
    local u24 = 0
    local u25 = 0
    local v26 = 0
    if p19 then
        u22.Holder.Template:FindFirstChild("Name").TextColor3 = p19.Color or Color3.new(1, 1, 1)
        u22.Holder.Template:FindFirstChild("Name").TextStrokeColor3 = p19.StrokeColor or Color3.new(0, 0, 0)
    end
    if u22:GetAttribute("Created") then
        u22:SetAttribute("Created", os.clock())
    else
        local u27 = u22:WaitForChild("Holder"):WaitForChild("Template")
        local v28 = u22.Holder
        v28.Position = v28.Position - UDim2.new(0, 0, 0, #u1:GetTagged("CUSTOM_DIALOGUE") * 100)
        local v29 = u27:WaitForChild("ImageLabel")
        v29.Position = v29.Position - UDim2.new(0, 0, 0, 100)
        u27:WaitForChild("ImageLabel").ImageTransparency = 1
        local v30 = u27:WaitForChild("Name")
        v30.Position = v30.Position - UDim2.new(0, 0, 0, 100)
        u27:WaitForChild("Name").TextColor3 = Color3.new(0.2, 0.988235, 1)
        u27:WaitForChild("Name").TextTransparency = 1
        u27:WaitForChild("Name").TextStrokeTransparency = 1
        u3:Create(u27:WaitForChild("ImageLabel"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Position"] = u27:WaitForChild("ImageLabel").Position + UDim2.new(0, 0, 0, 100),
            ["ImageTransparency"] = 0
        }):Play()
        u3:Create(u27:WaitForChild("Name"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Position"] = u27:WaitForChild("Name").Position + UDim2.new(0, 0, 0, 100),
            ["TextTransparency"] = 0,
            ["TextStrokeTransparency"] = 0
        }):Play()
        task.spawn(function() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u20
                [3] = u16
                [4] = u3
                [5] = u27
            --]]
            u22:SetAttribute("Created", os.clock())
            repeat
                task.wait()
            until (u20 or 3) < os.clock() - u22:GetAttribute("Created") or not u22.Parent
            u22.Name = "deleting"
            u16(u22.Holder.Template)
            u3:Create(u27:WaitForChild("ImageLabel"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Position"] = u27:WaitForChild("ImageLabel").Position - UDim2.new(0, 0, 0, 100),
                ["ImageTransparency"] = 1
            }):Play()
            u3:Create(u27:WaitForChild("Name"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Position"] = u27:WaitForChild("Name").Position - UDim2.new(0, 0, 0, 100),
                ["TextTransparency"] = 1,
                ["TextStrokeTransparency"] = 1
            }):Play()
            task.delay(1, function() --[[ Line: 102 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                u22:Destroy()
            end)
        end)
    end
    u22.Parent = game.StarterGui
    u22.Enabled = true
    u22.Name = v21 .. "CUSTOM_DIALOGUE"
    u22:AddTag("CUSTOM_DIALOGUE")
    u22:WaitForChild("Holder"):WaitForChild("Template"):WaitForChild("Name").Text = v21
    for _, v31 in p17 do
        print(v31)
        v23 = v23 .. v31.Text
    end
    local v32 = false
    for _, v33 in p17 do
        if v33.HigherUp then
            game:GetService("TweenService"):Create(u22.Holder, TweenInfo.new(0.2), {
                ["Position"] = UDim2.new(0.5, 0, 0.935, 0)
            }):Play()
            v32 = true
        end
    end
    if not v32 and u22.Holder.Position ~= UDim2.new(0.5, 0, 1, 0) then
        game:GetService("TweenService"):Create(u22.Holder, TweenInfo.new(1), {
            ["Position"] = UDim2.new(0.5, 0, 1, 0)
        }):Play()
    end
    u16(u22.Holder.Template)
    for _, v34 in p17 do
        local v35 = string.split(v34.Text, "")
        local v36 = v34.Bold and Enum.Font.SourceSansBold or (v34.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans)
        for _, v37 in v35 do
            u24 = u24 + u2:GetTextSize(v37, 25, v36, Vector2.new(100, 100)).X
        end
    end
    for _, u38 in p17 do
        local v39 = string.split(u38.Text, "")
        local v40 = u38.Bold and Enum.Font.SourceSansBold or (u38.Italic and Enum.Font.SourceSansItalic or Enum.Font.SourceSans)
        for _, v41 in v39 do
            local v42 = u2:GetTextSize(v41, 25, v40, Vector2.new(100, 100))
            local u43 = Instance.new("TextLabel")
            u43.AnchorPoint = Vector2.new(0, 0.5)
            u43.Position = UDim2.new(0.5, u25 - u24 / 2 // 1, 0.5, 10)
            u43.Size = UDim2.new(0, v42.X, 0, v42.Y)
            u43.Text = v41
            u43.Name = "letter"
            u43.Font = v40
            u43.TextSize = 25
            u43.Parent = u22.Holder.Template
            u43.BackgroundTransparency = 1
            u43.TextStrokeColor3 = u38.TextStrokeColor
            u43.TextStrokeTransparency = 0
            u43.TextStrokeTransparency = 1
            u43.TextTransparency = 1
            task.delay(v26, function() --[[ Line: 174 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u43
                    [3] = u25
                    [4] = u24
                    [5] = u22
                --]]
                local v44 = os.clock()
                repeat
                    local v45 = (os.clock() - v44) / 0.35
                    local v46 = math.min(v45, 1)
                    local v47 = (os.clock() - v44) / u38.Shake.Lifetime
                    local v48 = math.min(v47, 1)
                    local v49 = not u38.Shake.Enabled and UDim2.new(0, 0, 0, 0) or UDim2.new(0, math.random(-u38.Shake.Intensity, u38.Shake.Intensity) * (1 - v48), 0, math.random(-u38.Shake.Intensity, u38.Shake.Intensity) * (1 - v48))
                    local v50 = v46 - 1
                    local v51 = math.pow(v50, 3) * 2.70158 + 1
                    local v52 = v46 - 1
                    local v53 = 1 - (v51 + math.pow(v52, 2) * 1.70158)
                    u43.TextStrokeTransparency = (1 - v46) ^ 10
                    u43.TextTransparency = v53
                    u43.TextSize = v53 * 25 + 25
                    u43.TextColor3 = getColor(v46, u38.Color.Keypoints)
                    u43.Position = UDim2.new(0.5, u25 - u24 / 2 // 1, 0.5, 0) + v49
                    task.wait()
                    local v54 = os.clock() - v44
                    local v55 = u38.Shake.Lifetime
                until math.max(0.35, v55) < v54 or (not u43 or (not u43:IsDescendantOf(u22) or u43:GetAttribute("Ending")))
                if u43 then
                    u43.TextStrokeTransparency = 0
                    u43.TextTransparency = 0
                    u43.TextSize = 25
                    u43.TextColor3 = u38.Color.Keypoints[#u38.Color.Keypoints].Value
                    u43.Position = UDim2.new(0.5, u25 - u24 / 2 // 1, 0.5, 0)
                end
            end)
            v26 = v26 + u38.TypeSpeed
            u25 = u25 + v42.X
        end
    end
end
function v5.Speak(p57, p58, p59) --[[ Line: 208 ]]
    --[[
    Upvalues:
        [1] = u56
    --]]
    u56(p58, p57, p59)
end
return v5