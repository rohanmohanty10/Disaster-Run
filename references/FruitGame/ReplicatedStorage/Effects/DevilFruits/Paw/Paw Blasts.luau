 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = {}
local u4 = workspace.Effects
require(v2.Modules.BoatTween)
local function u7(p5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    for _ = 1, 3 do
        local v6 = script.PawEffect:Clone()
        v6.CFrame = p5.CFrame
        v6.Color = Color3.new(1, 1, 1)
        p5.Transparency = 0
        v6.Parent = u4
        _G.tween(v6, { 0.15, "Quad", "Out" }, {
            ["Transparency"] = 1,
            ["Size"] = Vector3.new(6, 6, 4.5)
        })
        _G.destroy(v6, 0.15)
        _G.customEmit(v6)
        task.wait(0.035)
    end
end
local function u11(p8) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    local v9 = script.Shockwave:Clone()
    v9.CFrame = p8.HumanoidRootPart.CFrame * CFrame.Angles(3.141592653589793, 1.5707963267948966, 0)
    v9.Parent = u4
    _G.destroy(v9, 0.25)
    local v10 = TweenInfo.new(0.25, Enum.EasingStyle.Exponential)
    u1:Create(v9.Texture, v10, {
        ["Transparency"] = 1
    }):Play()
    u1:Create(v9.Mesh, v10, {
        ["Scale"] = Vector3.new(0.75, 0.3, 0.3)
    }):Play()
    u1:Create(v9, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        ["CFrame"] = v9.CFrame * CFrame.new(-20, 0, 0)
    }):Play()
end
local function u15(u12, p13) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u11
        [3] = u7
    --]]
    local v14 = script.StartEff:Clone()
    v14.CFrame = p13.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(1.5707963267948966, 0, 0)
    v14.Parent = u4
    _G.PlaySound(v14, script.shoot, {
        ["Pitch"] = math.random(90, 110) / 100
    })
    _G.destroy(v14, 0.25)
    _G.customEmit(v14)
    _G.tween(u12, { 0.6, "Quint", "Out" }, {
        ["CFrame"] = u12.CFrame * CFrame.new(0, 0, -35),
        ["Transparency"] = 1
    })
    _G.destroy(u12, 0.6)
    task.delay(0.3, function() --[[ Line: 54 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        u12.Lines1.Enabled = false
        u12.Lines2.Enabled = false
    end)
    u11(p13)
    task.spawn(u7, u12)
end
function v3.start(_, p16, p17) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u15
    --]]
    if _G.checkRenderDistance(p16.PrimaryPart.Position) ~= false then
        local v18 = p16:WaitForChild("HumanoidRootPart")
        local v19 = script.PawMain:Clone()
        v19.Transparency = -10
        v19.CFrame = v18.CFrame * CFrame.new(p17, 0, -5)
        v19.Parent = u4
        local v20 = script.Paw2:Clone()
        v20.CFrame = v19.CFrame
        v20.Parent = workspace.Effects
        _G.tween(v20, { 0.25, "Quad", "Out" }, {
            ["Transparency"] = 1,
            ["Size"] = v20.Size * 1.5
        })
        _G.destroy(v20, 1)
        _G.customEmit(v20)
        u15(v19, p16)
    end
end
return v3