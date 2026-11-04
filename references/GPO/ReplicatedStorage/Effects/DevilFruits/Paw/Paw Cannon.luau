 

local u1 = game:GetService("TweenService")
game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = workspace.Effects
local function u6(p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    for _ = 1, 8 do
        local v5 = script.PawEffect:Clone()
        v5.CFrame = p4.CFrame
        v5.Color = Color3.new(1, 1, 1)
        p4.Transparency = -50
        v5.Parent = u3
        _G.tween(v5, { 0.65, "MozillaCurve", "Out" }, {
            ["Transparency"] = 1,
            ["Size"] = Vector3.new(8, 8, 4.5)
        })
        _G.destroy(v5, 0.65)
        _G.customEmit(v5)
        task.wait(0.005)
    end
end
local function u14(p7, p8) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v9 = script.PawEffect:Clone()
    v9.CFrame = p7.CFrame * CFrame.new(0, 0, 5)
    v9.Transparency = -25
    v9.Parent = u3
    local v10 = {
        ["Size"] = Vector3.new(15, 15, 12),
        ["CFrame"] = v9.CFrame * CFrame.new(0, 0, -10),
        ["Transparency"] = 1
    }
    _G.tween(v9, { 0.65, "MozillaCurve", "Out" }, v10)
    _G.destroy(v9, 0.65)
    local v11 = script.Shockwaves:Clone()
    v11.CFrame = p8.HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
    v11.Parent = u3
    _G.destroy(v11, 0.25)
    _G.customEmit(v11)
    local v12 = _G.getRayFloor(p8.PrimaryPart.CFrame, 15)
    if v12 ~= nil then
        local v13 = script.Dust:Clone()
        v13.CFrame = p8.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
        v13.Debris.Color = ColorSequence.new(v12.Color)
        v13.Dust.Color = v13.Debris.Color
        v13.Parent = u3
        _G.destroy(v13, 1.2)
        _G.customEmit(v13)
    end
end
local function u18(p15) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v16 = script.WhiteSwirl:Clone()
    v16.CFrame = p15.HumanoidRootPart.CFrame * CFrame.Angles(3.141592653589793, 1.5707963267948966, 0)
    v16.Parent = u3
    _G.destroy(v16, 0.3)
    local v17 = TweenInfo.new(0.3, Enum.EasingStyle.Exponential)
    u1:Create(v16.Texture, v17, {
        ["Transparency"] = 1
    }):Play()
    u1:Create(v16.Mesh, v17, {
        ["Scale"] = Vector3.new(1, 0.45, 0.45)
    }):Play()
    u1:Create(v16, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        ["CFrame"] = v16.CFrame * CFrame.Angles(-4.71238898038469, 0, 0) * CFrame.new(-25, 0, 0)
    }):Play()
    task.wait(0.1)
    u1:Create(v16, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
        ["CFrame"] = v16.CFrame * CFrame.Angles(-4.71238898038469, 0, 0) * CFrame.new(-13, 0, 0)
    }):Play()
end
local function u21(p19, p20) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u18
        [3] = u6
    --]]
    _G.tween(p19, { 0.45, "Exponential", "Out" }, {
        ["CFrame"] = p19.CFrame * CFrame.new(0, 0, -50),
        ["Transparency"] = 1
    })
    _G.destroy(p19, 0.45)
    u14(p19, p20)
    u18(p20)
    task.spawn(u6, p19)
end
function v2.start(_, p22) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u21
    --]]
    if _G.checkRenderDistance(p22.PrimaryPart.Position) ~= false then
        local v23 = p22:WaitForChild("HumanoidRootPart")
        local v24 = script.PawMain:Clone()
        v24.Transparency = -10
        v24.CFrame = v23.CFrame * CFrame.new(0, 0, -5)
        v24.Parent = u3
        _G.PlaySound(p22.PrimaryPart, script.PawCannonShoot)
        u21(v24, p22)
    end
end
return v2