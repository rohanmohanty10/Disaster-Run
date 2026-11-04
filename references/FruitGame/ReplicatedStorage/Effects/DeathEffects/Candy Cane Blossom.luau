 

local v1 = {}
local u2 = {
    "",
    "rbxassetid://13430521309",
    "rbxassetid://13430523967",
    "rbxassetid://13430527336",
    "rbxassetid://13430530583",
    "rbxassetid://13430532884",
    "rbxassetid://13430534907",
    "rbxassetid://13430536833",
    "rbxassetid://13430539214",
    "rbxassetid://13430541350",
    "rbxassetid://13430544026",
    "rbxassetid://13430547403",
    "rbxassetid://13430551532",
    "rbxassetid://13430554563",
    "rbxassetid://13430557397",
    "rbxassetid://13430560078",
    "rbxassetid://13430562951",
    "rbxassetid://13430126014"
}
local function u6(p3, p4) --[[ Line: 4 ]]
    for _, v5 in p3:GetDescendants() do
        if v5:IsA("ParticleEmitter") then
            v5.Enabled = p4
        end
    end
end
local _ = _G.tween
local function u22(p7, p8, p9) --[[ Line: 17 ]]
    local v10 = 3.141592653589793 / (2 * p9)
    local v11 = {}
    local v12 = 1
    for v13 = 0, p9 - 1 do
        local v14 = v10 * v13
        local v15 = p9 * math.sin(v14)
        local v16 = math.ceil(v15)
        for v17 = 0, v16 - 1 do
            local v18 = v17 / v16 * 3.141592653589793 * 2
            local v19 = p8 * math.sin(v14) * math.cos(v18)
            local v20 = p8 * math.cos(v14)
            local v21 = p8 * math.sin(v14) * math.sin(v18)
            v11[v12] = p7.Position + Vector3.new(v19, v20, v21)
            v12 = v12 + 1
        end
    end
    return v11
end
local function u35(p23, p24) --[[ Line: 42 ]]
    for _, v25 in p23:GetDescendants() do
        if v25:IsA("ParticleEmitter") then
            if v25.Speed then
                v25.Speed = NumberRange.new(v25.Speed.Min * p24, v25.Speed.Max * p24)
            end
            if v25.Drag then
                v25.Drag = v25.Drag * p24
            end
            if v25.Size then
                local v26 = {}
                for _, v27 in ipairs(v25.Size.Keypoints) do
                    local v28 = NumberSequenceKeypoint.new
                    local v29 = v27.Time
                    local v30 = v27.Value * p24
                    local v31 = v27.Envelope * p24
                    table.insert(v26, v28(v29, v30, v31))
                end
                v25.Size = NumberSequence.new(v26)
            end
            if v25.Acceleration then
                local v32 = v25.Acceleration.X * p24
                local v33 = v25.Acceleration.Y * p24
                local v34 = v25.Acceleration.Z * p24
                v25.Acceleration = Vector3.new(v32, v33, v34)
            end
        end
    end
end
local u36 = RaycastParams.new()
u36.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u36.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, u37) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u36
        [3] = u6
        [4] = u35
        [5] = u2
    --]]
    local v38 = u22(u37, 20, 5)
    _G.PlaySound(u37, script.IceFlowerGrip)
    for _, v39 in v38 do
        local u40 = script.Spawn:Clone()
        u40.Parent = workspace.Effects
        u40.CFrame = CFrame.new(v39)
        _G.customEmit(u40)
        _G.destroy(u40, 3)
        local u41 = CFrame.lookAt(u40.Position, u37.Position).LookVector
        local u42 = script.Portal:Clone()
        u42:PivotTo(CFrame.lookAt(u40.Position, u37.Position))
        u42.Parent = workspace.Effects
        local u43 = workspace:Raycast(u40.Position, u41 * 200, u36)
        if u43 then
            u42.Glass.Transparency = 1
            for _, v44 in u42["Candy Cane"]:GetChildren() do
                v44.Transparency = 1
            end
            u6(u42["Candy Cane"], false)
            task.delay(0.8, function() --[[ Line: 110 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u41
                    [3] = u43
                    [4] = u6
                    [5] = u37
                    [6] = u35
                    [7] = u40
                --]]
                u42.Glass.Transparency = 1
                for _, v45 in u42["Candy Cane"]:GetChildren() do
                    v45.Transparency = 0.05
                end
                game.TweenService:Create(u42["Candy Cane"].Blade, TweenInfo.new(0.2), {
                    ["CFrame"] = u42["Candy Cane"].Blade.CFrame + u41 * u43.Distance
                }):Play()
                game.TweenService:Create(u42.Glass, TweenInfo.new(0.1), {
                    ["Transparency"] = 1
                }):Play()
                u6(u42["Candy Cane"], true)
                task.wait(0.15)
                local v46 = script.Hit:Clone()
                v46.Parent = workspace.Effects
                v46.CFrame = CFrame.new(u37.Position) * CFrame.new(math.random(-200, 200) / 100, math.random(-100, 100) / 100, math.random(-200, 200) / 100)
                u35(v46, math.random(70, 130) / 100)
                _G.customEmit(v46)
                _G.destroy(v46, 3)
                _G.destroy(u42, 3)
                u6(u42, false)
                u42["Candy Cane"]:Destroy()
                task.wait(0.2)
                local v47 = script.End:Clone()
                v47.Parent = workspace.Effects
                v47.CFrame = CFrame.new(u40.Position)
                _G.customEmit(v47)
                _G.destroy(v47, 8)
                _G.destroy(u42, 8)
            end)
            task.wait(0.08)
        else
            u42:Destroy()
            u40:Destroy()
        end
    end
    task.wait(0.75)
    local v48 = script.FinalImpact:Clone()
    v48.Parent = workspace.Effects
    v48.CFrame = CFrame.new(u37.Position) * CFrame.new(0, -2.3, 0)
    local v49 = script.Rain:Clone()
    v49.Parent = workspace.Effects
    v49.CFrame = CFrame.new(u37.Position) * CFrame.new(0, 22, 0)
    local v50 = workspace:Raycast(u37.Position, Vector3.new(0, -100, 0), u36)
    if v50 then
        u37 = CFrame.new(v50.Position) or u37
    end
    local v51 = script.RainGround:Clone()
    v51.Parent = workspace.Effects
    v51.CFrame = u37
    local v52 = script.Flower:Clone()
    v52.Parent = workspace.Effects
    v52.CFrame = u37 * CFrame.new(0, 3.5, 0)
    if game.Lighting.ClockTime <= 17.8 and game.Lighting.ClockTime >= 6.2 then
        v52.Decal.Color3 = Color3.fromRGB(270, 400, 2000)
    else
        v52.Decal.Color3 = Color3.fromRGB(500, 700, 1000)
    end
    game.TweenService:Create(v52, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["CFrame"] = v52.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
    }):Play()
    _G.customEmit(v48)
    game.TweenService:Create(v48.Point.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Brightness"] = 0
    }):Play()
    game.Debris:AddItem(v48, 6)
    for v53 = 1, #u2 do
        v52.Decal.Texture = u2[v53]
        task.wait(0.035)
    end
    task.wait(2)
    u6(v49.Glow, false)
    _G.destroy(v49, 6)
    game.TweenService:Create(v52, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Size"] = Vector3.new(3.765, 2.143, 1.659)
    }):Play()
    for v54 = #u2, 1, -1 do
        v52.Decal.Texture = u2[v54]
        task.wait(0.035)
    end
    v52:Destroy()
    task.wait(0.5)
    u6(v49, false)
    _G.destroy(v49, 7)
    u6(v51, false)
    _G.destroy(v51, 7)
end
return v1