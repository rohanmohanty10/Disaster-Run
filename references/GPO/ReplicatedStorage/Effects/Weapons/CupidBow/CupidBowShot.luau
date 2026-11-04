 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = require(v3.Modules.Client.WeaponVFXRecolor)
Random.new()
local function u16(u5, p6) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u7 = Instance.new("NumberValue")
    u7.Value = 0
    local v8 = u2:Create(u7, TweenInfo.new(p6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Value"] = 1
    })
    u7.Changed:Connect(function() --[[ Line: 17 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
        --]]
        local v9 = u7.Value
        local v10 = u5.Transparency
        local v11 = {}
        for _, v12 in ipairs(v10.Keypoints) do
            local v13 = v12.Value + (1 - v12.Value) * v9
            local v14 = NumberSequenceKeypoint.new
            local v15 = v12.Time
            table.insert(v11, v14(v15, v13))
        end
        u5.Transparency = NumberSequence.new(v11)
    end)
    _G.destroy(u7, p6 + 1)
    v8:Play()
end
function v1.start(_, p17) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u16
    --]]
    local v18 = p17.startCFrame
    local v19 = p17.prestige
    local v20 = p17.char
    local v21 = script.Normal
    if v19 == true then
        v21 = script.Blessed
    end
    local v22 = v21.Fx:Clone()
    u4.apply(v22, v20)
    v22.CFrame = v18 * CFrame.new(0, 0, -6) * CFrame.Angles(3.141592653589793, 0, 0)
    v22.Parent = workspace.Effects
    _G.destroy(v22, 3)
    _G.customEmit(v22)
    local v23 = v21.Sharp:Clone()
    u4.apply(v23, v20)
    local v24 = v18 * CFrame.new(0, 0, -4)
    local v25 = CFrame.Angles
    local v26 = math.random(-360, 360)
    v23.CFrame = v24 * v25(-1.5707963267948966, math.rad(v26), -1.5707963267948966)
    v23.Parent = workspace.Effects
    _G.destroy(v23, 0.3)
    _G.tween(v23, {
        0.3,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v23.CFrame * CFrame.new(-12, 0, 0)
    })
    v23.Mesh.Scale = Vector3.new(0.75, 0.25, 0.25)
    _G.tween(v23.Mesh, {
        0.3,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = Vector3.new(1.5, 0, 0)
    })
    local u27 = v21.Shockwave:Clone()
    u4.apply(u27, v20)
    u27.Size = Vector3.new(0, 8, 8)
    local v28 = v18 * CFrame.new(0, 0, -5)
    local v29 = CFrame.Angles
    local v30 = math.random(-360, 360)
    u27.CFrame = v28 * v29(-1.5707963267948966, math.rad(v30), -1.5707963267948966)
    u27.Parent = workspace.Effects
    _G.destroy(u27, 0.3)
    _G.tween(u27, {
        0.1,
        "Linear",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = Vector3.new(30, 8, 8),
        ["CFrame"] = u27.CFrame * CFrame.Angles(math.random(-360, 360), 0, 0)
    })
    _G.PlaySound(v18, script.ValentineBowBlast)
    task.delay(0.1, function() --[[ Line: 73 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u27
        --]]
        u2:Create(u27, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            ["Size"] = Vector3.new(8, 30, 30),
            ["CFrame"] = u27.CFrame * CFrame.Angles(math.random(-360, 360), 0, 0),
            ["Transparency"] = 1
        }):Play()
    end)
    task.wait(0.4)
    for _, v31 in pairs(v22:GetDescendants()) do
        if v31:IsA("Beam") then
            u16(v31, 2)
        end
    end
end
return v1