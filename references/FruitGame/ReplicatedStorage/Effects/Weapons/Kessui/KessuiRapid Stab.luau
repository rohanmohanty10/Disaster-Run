 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
game:GetService("UserInputService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = workspace.Effects
local v4 = {}
local u5 = require(v2.Modules.Utility)
local u6 = {
    "rbxassetid://7051550601",
    "rbxassetid://7051550509",
    "rbxassetid://7051550382",
    "rbxassetid://7051550310",
    "rbxassetid://7051550225",
    "rbxassetid://7051644826",
    "rbxassetid://7051634906",
    "rbxassetid://7051637153",
    "rbxassetid://7051637747"
}
local u7 = Color3.fromRGB(255, 81, 0)
local u8 = Color3.new(1, 1, 1)
local function u23(p9, p10) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    for _ = 1, math.random(1, 2) do
        local v11 = CFrame.new(math.random(-3.5, 0), math.random(-2.5, 1.5), math.random(-5, -0))
        local v12 = CFrame.Angles
        local v13 = math.random(-30, 30)
        local v14 = math.rad(v13)
        local v15 = math.random(-30, 30)
        local v16 = v12(1.5707963267948966, v14, (math.rad(v15)))
        local v17 = script.Jab:Clone()
        v17.Mesh.Scale = v17.Mesh.Scale * math.random(0.25, 1)
        v17.CFrame = p10.HumanoidRootPart.CFrame * v11 * v16
        v17.Parent = u3
        if p9 then
            v17.Texture.Transparency = -20
            v17.Texture.Color3 = Color3.fromRGB(1000, 200, 50)
        end
        local v18 = TweenInfo.new(math.random(1, 3) / 10, Enum.EasingStyle.Exponential)
        _G.destroy(v17, v18.Time)
        u1:Create(v17.Texture, v18, {
            ["Transparency"] = 1
        }):Play()
        local v19 = u1
        local v20 = v17.Mesh
        local v21 = {}
        local v22 = math.random(2, 8)
        v21.Scale = Vector3.new(0, v22, 0)
        v19:Create(v20, v18, v21):Play()
        u1:Create(v17, v18, {
            ["CFrame"] = v17.CFrame * CFrame.new(0, math.random(-8, -3), 0)
        }):Play()
    end
end
local function u33(p24, p25) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u6
    --]]
    local u26 = script.MainSlash:Clone()
    u26.CFrame = p25.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(3.141592653589793, -0.7853981633974483, 0)
    u26.Parent = u3
    if p24 then
        u26.Mesh.Scale = u26.Mesh.Scale * 1.35
        u26.Texture.Color3 = Color3.fromRGB(1000, 250, 100)
        _G.customEmit(u26.SlashesIgnited)
    else
        _G.customEmit(u26.SlashesReg)
    end
    local v27 = RaycastParams.new()
    v27.FilterType = Enum.RaycastFilterType.Blacklist
    v27.FilterDescendantsInstances = { p25, u3 }
    local v28 = workspace:Raycast(p25.HumanoidRootPart.CFrame.Position, CFrame.new(0, -5, 0).Position, v27)
    if v28 then
        local v29 = CFrame.lookAt(v28.Position, v28.Position + p25.HumanoidRootPart.CFrame.LookVector, v28.Normal)
        local v30 = script.Ground2:Clone()
        v30.CFrame = v29 * CFrame.new(0, 0, -3)
        v30.Parent = u3
        v30.Dust.Color = ColorSequence.new(v28.Instance.Color)
        _G.customEmit(v30)
        _G.destroy(v30, 2.5)
    end
    local v31 = TweenInfo.new(0.3, Enum.EasingStyle.Exponential)
    _G.destroy(u26, 3)
    u1:Create(u26.Texture, v31, {
        ["Transparency"] = 1
    }):Play()
    u1:Create(u26.Mesh, v31, {
        ["Scale"] = u26.Mesh.Scale * 1.5
    }):Play()
    u1:Create(u26, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        ["CFrame"] = u26.CFrame * CFrame.Angles(0, -2.9670597283903604, 0)
    }):Play()
    task.defer(function() --[[ Line: 87 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u26
        --]]
        for _, v32 in u6 do
            if not u26:FindFirstChild("Texture") then
                break
            end
            u26.Texture.Texture = v32
            task.wait(0.05)
        end
    end)
end
function v4.start(_, u34, p35, p36) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u5
        [4] = u3
        [5] = u23
        [6] = u33
    --]]
    local v37 = u34 == game.Players.LocalPlayer.Character
    if p35 ~= nil then
        local v38 = _G.PlaySound(u34.PrimaryPart, script.DuoBladeBarrageStart)
        v38.Parent = u34.PrimaryPart
        _G.tween(v38, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        task.wait(0.1)
        local u39 = p35:GetAttribute("Ignited")
        local v40 = p35.Blade.RS1
        local v41 = p35.Blade.RS2
        if u39 then
            v40.Sparkle.Color = ColorSequence.new(u7)
            v41.Sparkle.Color = ColorSequence.new(u7)
            _G.customEmit(v40)
            _G.customEmit(v41)
        else
            v40.Sparkle.Color = ColorSequence.new(u8)
            v41.Sparkle.Color = ColorSequence.new(u8)
            v40.Sparkle:Emit(3)
            v41.Sparkle:Emit(3)
        end
        task.wait(0.55)
        local v42 = script.DuoBladeBarrageLoop:Clone()
        v42.Parent = u34.PrimaryPart
        v42:Play()
        local v43
        if u39 then
            v43 = script.JabIgnite:Clone()
        else
            v43 = script.JabNoIgnite:Clone()
        end
        u5:QuickWeld(v43, u34.HumanoidRootPart, CFrame.new(1.5, 0.25, 2))
        v43.Parent = u3
        _G.customEmit(v43.ToEmit)
        local u44 = true
        task.spawn(function() --[[ Line: 135 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u23
                [3] = u39
                [4] = u34
            --]]
            while u44 do
                u23(u39, u34)
                task.wait(math.random(1, 2) / 150)
            end
        end)
        local v45
        if v37 == true then
            v45 = Instance.new("BodyVelocity")
            v45.Velocity = u34.HumanoidRootPart.CFrame.LookVector * 2
            v45.MaxForce = Vector3.new(100000000000, 0, 100000000000)
            v45.Parent = u34.HumanoidRootPart
        else
            v45 = nil
        end
        local v46 = RaycastParams.new()
        v46.FilterType = Enum.RaycastFilterType.Whitelist
        v46.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
        local v47 = 0
        while p36:IsDescendantOf(game) do
            if v45 then
                v45.Velocity = u34.HumanoidRootPart.CFrame.LookVector * 2
            end
            local v48 = v47 % 7 == 0 and workspace:Raycast(u34.HumanoidRootPart.CFrame.Position, CFrame.new(0, -5, 0).Position, v46)
            if v48 then
                local v49 = CFrame.lookAt(v48.Position, v48.Position + u34.HumanoidRootPart.CFrame.LookVector, v48.Normal)
                local v50 = script.Ground1:Clone()
                v50.CFrame = v49 * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(0, -1, 1)
                v50.Parent = u3
                v50.Dust.Color = ColorSequence.new(v48.Instance.Color)
                _G.customEmit(v50)
                _G.destroy(v50, 1)
            end
            v47 = v47 + 1
            task.wait()
        end
        u44 = false
        _G.tween(v42, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        }, true)
        _G.destroy(v42, 0.25)
        if v45 then
            v45.Velocity = u34.HumanoidRootPart.CFrame.LookVector * 20
            _G.destroy(v45, 0.55)
        end
        if u39 then
            _G.PlaySound(u34.PrimaryPart, script.DuoBladeBarrageFireEnd).Parent = u34.PrimaryPart
        else
            _G.PlaySound(u34.PrimaryPart, script.DuoBladeBarrageEnd).Parent = u34.PrimaryPart
        end
        u5:ToggleEnabled(v43, false)
        _G.destroy(v43, 1)
        task.wait(0.5)
        u33(u39, u34)
    end
end
return v4