 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = Random.new()
function BeamFade(u5, p6, p7)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u8 = Instance.new("NumberValue")
    u8:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 10 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u8
        --]]
        u5.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u8.Value), NumberSequenceKeypoint.new(1, u8.Value) })
    end)
    if p6 then
        u8.Value = 1
        u2:Create(u8, TweenInfo.new(p7, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            ["Value"] = 0.25
        }):Play()
    else
        u8.Value = 0.25
        u2:Create(u8, TweenInfo.new(p7, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            ["Value"] = 1
        }):Play()
    end
end
function Scramble(u9)
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local u10 = Instance.new("NumberValue")
    u10.Value = u4:NextNumber(0, 360)
    u10.Parent = u9
    local u11 = Instance.new("NumberValue")
    u11.Value = 0
    u11.Parent = u9
    local u12 = Instance.new("NumberValue")
    u12.Value = 0
    u12.Parent = u9
    local u13 = u4:NextNumber(3.5, 5)
    u2:Create(u10, TweenInfo.new(u13, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["Value"] = u10.Value + 360 * u4:NextNumber(3.5, 7.5)
    }):Play()
    u2:Create(u11, TweenInfo.new(u4:NextNumber(1, 2.5), Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
        ["Value"] = u4:NextNumber(4, 8.5)
    }):Play()
    u2:Create(u12, TweenInfo.new(u13, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["Value"] = u4:NextNumber(7, 15)
    }):Play()
    local u14 = math.random(2, 5)
    local u15 = u9.Position
    local _ = u9.Orientation
    task.spawn(function() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u13
            [3] = u2
            [4] = u9
            [5] = u4
        --]]
        for v16 = 1, u14 do
            local v17 = TweenInfo.new(u13 / u14, Enum.EasingStyle.Linear)
            if v16 == 1 then
                v17 = TweenInfo.new(u13 / u14, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
            end
            local v18 = u2
            local v19 = u9
            local v20 = {}
            local v21 = u9.Orientation
            local v22 = u4:NextNumber(100, 180)
            local v23 = u4:NextNumber(100, 180)
            local v24 = u4
            v20.Orientation = v21 + Vector3.new(v22, v23, v24:NextNumber(100, 180))
            v18:Create(v19, v17, v20):Play()
            task.wait(u13 / u14)
        end
    end)
    u10:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 61 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
            [3] = u9
            [4] = u15
            [5] = u12
        --]]
        local v25 = u10.Value
        local v26 = math.rad(v25)
        local v27 = math.cos(v26) * u11.Value
        local v28 = u10.Value
        local v29 = math.rad(v28)
        local v30 = math.sin(v29) * u11.Value
        local v31 = u9
        local v32 = u15.X + v27
        local v33 = u15.Y
        local v34 = u12.Value
        local v35 = v33 + math.sin(v34)
        local v36 = u15.Z + v30
        v31.Position = Vector3.new(v32, v35, v36)
    end)
    task.delay(u13 / 3 * 2, function() --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u9
            [3] = u13
        --]]
        u2:Create(u9, TweenInfo.new(u13 / 3), {
            ["Transparency"] = 1,
            ["Size"] = Vector3.new(0, 0, 0)
        }):Play()
    end)
    return u13
end
local u37 = require(script.Parent.GetFullAvatar)
function v1.start(_, p38, _) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u37
        [3] = u3
    --]]
    _G.PlaySound(p38.PrimaryPart, script["Audio/OpeGrip"])
    local v39 = script.Room:Clone()
    v39.Position = p38.PrimaryPart.Position - Vector3.new(0, 3, 0)
    v39.Parent = workspace.Effects
    u2:Create(v39, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Size"] = Vector3.new(25, 25, 25)
    }):Play()
    u2:Create(v39.One, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Position"] = Vector3.new(-12.5, 0, 0)
    }):Play()
    u2:Create(v39.Two, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Position"] = Vector3.new(12.5, 0, 0)
    }):Play()
    u2:Create(v39.Three, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Position"] = Vector3.new(0, 0, 12.5)
    }):Play()
    u2:Create(v39.Four, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Position"] = Vector3.new(0, 0, -12.5)
    }):Play()
    local v40 = next
    local v41, v42 = v39:GetDescendants()
    for _, v43 in v40, v41, v42 do
        if v43:IsA("Beam") then
            BeamFade(v43, true, 1.1)
            if v43.Name == "First" then
                u2:Create(v43, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                    ["CurveSize0"] = 16.5,
                    ["CurveSize1"] = -16.5
                }):Play()
            elseif v43.Name == "Second" then
                u2:Create(v43, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                    ["CurveSize0"] = -16.5,
                    ["CurveSize1"] = 16.5
                }):Play()
            end
        end
    end
    task.wait(1.2)
    local v44 = next
    local v45, v46 = u37:start(p38)
    local v47 = {}
    for _, v48 in v44, v45, v46 do
        if v48:IsA("BasePart") then
            if v48.Name ~= "HumanoidRootPart" then
                local v49 = Scramble(v48)
                v47[#v47 + 1] = v49
            end
            v48.Anchored = true
        end
    end
    table.sort(v47, function(p50, p51) --[[ Line: 114 ]]
        return p51 < p50
    end)
    local u52 = script.Scramble:Clone()
    u52.Position = p38.HumanoidRootPart.Position
    u52.Parent = workspace.Effects
    local v53 = u3.Heartbeat:Connect(function() --[[ Line: 123 ]]
        --[[
        Upvalues:
            [1] = u52
        --]]
        u52.CFrame = u52.CFrame * CFrame.Angles(0, -0.02181661564992912, 0)
    end)
    task.wait(v47[1] - 0.75)
    local v54 = next
    local v55, v56 = u52:GetDescendants()
    for _, v57 in v54, v55, v56 do
        if v57:IsA("ParticleEmitter") then
            v57.Enabled = false
        end
    end
    u2:Create(v39, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Transparency"] = 1
    }):Play()
    local v58 = next
    local v59, v60 = v39:GetDescendants()
    for _, v61 in v58, v59, v60 do
        if v61:IsA("Beam") then
            BeamFade(v61, false, 1)
        elseif v61:IsA("ParticleEmitter") then
            v61.Enabled = false
        end
    end
    task.wait(1)
    v39:Destroy()
    task.wait(1)
    v53:Disconnect()
    u52:Destroy()
end
return v1