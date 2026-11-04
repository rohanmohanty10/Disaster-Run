 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
local v2 = {}
local u3 = Random.new()
Color3.fromRGB(197, 31, 2)
Color3.fromRGB(166, 89, 0)
Color3.fromRGB(255, 171, 97)
local u4 = _G.customEmit
function SpawnWind(p5)
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local u6 = script.Mesh:Clone()
    u6.CFrame = p5.WorldCFrame * CFrame.Angles(0, u3:NextNumber(0, -3.141592653589793, 3.141592653589793, 0), 0)
    u6.Decal.Transparency = u3:NextNumber(0.5, 0.85)
    u6.Parent = workspace.Effects
    local v7 = u3:NextNumber(0.55, 0.75)
    for _, v8 in u6:GetChildren() do
        if v8:IsA("Decal") then
            local u9 = u1:Create(v8, TweenInfo.new(v7), {
                ["Transparency"] = 1
            })
            u9:Play()
            u9.Completed:Once(function() --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9:Destroy()
            end)
        end
    end
    local u10 = u1:Create(u6, TweenInfo.new(u3:NextNumber(0.452, 0.65)), {
        ["CFrame"] = u6.CFrame * CFrame.Angles(0, u3:NextNumber(-3.141592653589793, 3.141592653589793), 0)
    })
    local u11 = u1:Create(u6.Mesh, TweenInfo.new(u3:NextNumber(0.6, 0.85), Enum.EasingStyle.Quint), {
        ["Scale"] = u6.Mesh.Scale * u3:NextNumber(1.2, 1.75)
    })
    u10:Play()
    u11:Play()
    local v12 = u6.Mesh
    v12.Scale = v12.Scale * u3:NextNumber(0.15, 0.25)
    task.delay(v7, function() --[[ Line: 52 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u10
            [3] = u6
        --]]
        u11:Destroy()
        u10:Destroy()
        _G.destroy(u6, 1.5)
    end)
end
local function u19(p13, p14, p15) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v16 = CFrame.Angles(-1.5707963267948966, 0, 0)
    local u17 = script.BonePart:Clone()
    u17.CFrame = p13.WorldCFrame * v16
    u17.Anchored = false
    local v18 = Instance.new("RigidConstraint")
    v18.Attachment0 = p13
    v18.Attachment1 = u17.Attachment
    v18.Parent = u17
    u17.Parent = workspace.Effects
    local _ = p15.Name
    local _ = p13.Name
    p13.Destroying:Connect(function() --[[ Line: 92 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        _G.particleEnabled(u17, false)
        _G.destroy(u17, 3)
    end)
    if p14 then
        u4(u17)
    end
    return u17
end
function v2.start(_, p20, p21, p22) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u1
    --]]
    local _ = workspace:GetServerTimeNow() - p22
    local v23 = game.Players.LocalPlayer.Character == p20
    local v24 = Instance.new("Highlight")
    v24.FillColor = Color3.new()
    v24.FillTransparency = 0
    v24.OutlineTransparency = 1
    v24.DepthMode = Enum.HighlightDepthMode.Occluded
    v24.Parent = p21
    local v25
    if v23 == true then
        v25 = Instance.new("ColorCorrectionEffect")
        v25.Brightness = 1
        v25.Parent = game.Lighting
    else
        v25 = nil
    end
    task.wait(0.0625)
    v24.FillColor = Color3.new(1, 1, 1)
    if v25 then
        v25.TintColor = Color3.new()
    end
    task.wait(0.0625)
    if v25 then
        v25:Destroy()
    end
    v24.FillTransparency = 1
    v24.OutlineTransparency = 1
    v24.OutlineColor = Color3.fromRGB(255, 81, 0)
    v24.FillColor = Color3.fromRGB(255, 81, 0)
    local v26 = {}
    for v27 = 1, 48 do
        local v28 = u19(p21.PrimaryPart:FindFirstChild("Body_" .. v27, true), v27 % 3 == 0, p20)
        table.insert(v26, v28)
        task.wait()
    end
    u1:Create(v24, TweenInfo.new(0.5), {
        ["OutlineTransparency"] = 0.25,
        ["FillTransparency"] = 0.95
    }):Play()
    repeat
        task.wait()
    until p20:GetAttribute("FireMode") == nil or p20:IsDescendantOf(workspace) == false
    v24.FillTransparency = 0
    v24.OutlineTransparency = 0
    u1:Create(v24, TweenInfo.new(0.5), {
        ["OutlineTransparency"] = 1,
        ["FillTransparency"] = 1
    }):Play()
    _G.destroy(v24, 0.5)
    if p20.PrimaryPart then
        _G.PlaySound(p20.PrimaryPart, script.DragonFlameModeOff).Parent = p20.PrimaryPart
    end
    for _, v29 in v26 do
        for _, v30 in v29:GetDescendants() do
            if v30:IsA("ParticleEmitter") then
                v30.Enabled = false
            end
        end
        _G.destroy(v29, 1.5)
    end
end
return v2