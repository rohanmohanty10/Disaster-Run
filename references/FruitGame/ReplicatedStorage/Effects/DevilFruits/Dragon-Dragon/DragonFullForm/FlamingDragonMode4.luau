 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = {}
local u4 = Random.new()
Color3.fromRGB(197, 31, 2)
Color3.fromRGB(166, 89, 0)
Color3.fromRGB(255, 171, 97)
local u5 = _G.customEmit
local u6 = {}
local u7 = nil
function SpawnWind(p8)
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local u9 = script.Mesh:Clone()
    u9.CFrame = p8.WorldCFrame * CFrame.Angles(0, u4:NextNumber(0, -3.141592653589793, 3.141592653589793, 0), 0)
    u9.Decal.Transparency = u4:NextNumber(0.5, 0.85)
    u9.Parent = workspace.Effects
    local v10 = u4:NextNumber(0.55, 0.75)
    for _, v11 in u9:GetChildren() do
        if v11:IsA("Decal") then
            local u12 = u2:Create(v11, TweenInfo.new(v10), {
                ["Transparency"] = 1
            })
            u12:Play()
            u12.Completed:Once(function() --[[ Line: 58 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                u12:Destroy()
            end)
        end
    end
    local u13 = u2:Create(u9, TweenInfo.new(u4:NextNumber(0.452, 0.65)), {
        ["CFrame"] = u9.CFrame * CFrame.Angles(0, u4:NextNumber(-3.141592653589793, 3.141592653589793), 0)
    })
    local u14 = u2:Create(u9.Mesh, TweenInfo.new(u4:NextNumber(0.6, 0.85), Enum.EasingStyle.Quint), {
        ["Scale"] = u9.Mesh.Scale * u4:NextNumber(1.2, 1.75)
    })
    u13:Play()
    u14:Play()
    local v15 = u9.Mesh
    v15.Scale = v15.Scale * u4:NextNumber(0.15, 0.25)
    task.delay(v10, function() --[[ Line: 77 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u13
            [3] = u9
        --]]
        u14:Destroy()
        u13:Destroy()
        _G.destroy(u9, 1.5)
    end)
end
local function u27(p16, p17, p18) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u1
        [4] = u5
    --]]
    local v19 = CFrame.Angles(-1.5707963267948966, 0, 0)
    local u20 = script.Attachment:Clone()
    u20.WorldCFrame = p16.WorldCFrame * v19
    u20.Parent = workspace.Effects
    local u21 = p18.Name
    local u22 = p16.Name
    if not u6[u21] then
        u6[u21] = {}
    end
    u6[u21][u22] = {
        ["Bone"] = p16,
        ["Part"] = u20,
        ["Offset"] = v19
    }
    if not u7 then
        u7 = u1.RenderStepped:Connect(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            for v23, v24 in pairs(u6) do
                for v25, v26 in pairs(v24) do
                    if v26.Bone and (v26.Part and v26.Part.Parent) then
                        v26.Part.WorldCFrame = v26.Bone.WorldCFrame * v26.Offset
                    else
                        u6[v23][v25] = nil
                    end
                end
                if next(u6[v23]) == nil then
                    u6[v23] = nil
                end
            end
        end)
    end
    p16.Destroying:Connect(function() --[[ Line: 107 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u21
            [3] = u22
            [4] = u20
        --]]
        if u6[u21] and u6[u21][u22] then
            u6[u21][u22] = nil
            if next(u6[u21]) == nil then
                u6[u21] = nil
            end
        end
        _G.particleEnabled(u20, false)
        _G.destroy(u20, 3)
    end)
    if p17 then
        u5(u20)
    end
    return u20
end
function v3.start(_, p28, p29, p30) --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u2
    --]]
    local _ = workspace:GetServerTimeNow() - p30
    local v31 = game.Players.LocalPlayer.Character == p28
    local v32 = Instance.new("Highlight")
    v32.FillColor = Color3.new()
    v32.FillTransparency = 0
    v32.OutlineTransparency = 1
    v32.DepthMode = Enum.HighlightDepthMode.Occluded
    v32.Parent = p29
    local v33
    if v31 == true then
        v33 = Instance.new("ColorCorrectionEffect")
        v33.Brightness = 1
        v33.Parent = game.Lighting
    else
        v33 = nil
    end
    task.wait(0.0625)
    v32.FillColor = Color3.new(1, 1, 1)
    if v33 then
        v33.TintColor = Color3.new()
    end
    task.wait(0.0625)
    if v33 then
        v33:Destroy()
    end
    v32.FillTransparency = 1
    v32.OutlineTransparency = 1
    v32.OutlineColor = Color3.fromRGB(255, 81, 0)
    v32.FillColor = Color3.fromRGB(255, 81, 0)
    local v34 = {}
    for v35 = 1, 48 do
        local v36 = u27(p29.PrimaryPart:FindFirstChild("Body_" .. v35, true), v35 % 4 == 0, p28)
        table.insert(v34, v36)
        task.wait()
    end
    u2:Create(v32, TweenInfo.new(0.5), {
        ["OutlineTransparency"] = 0.25,
        ["FillTransparency"] = 0.95
    }):Play()
    repeat
        task.wait()
    until p28:GetAttribute("FireMode") == nil or p28:IsDescendantOf(workspace) == false
    v32.FillTransparency = 0
    v32.OutlineTransparency = 0
    u2:Create(v32, TweenInfo.new(0.5), {
        ["OutlineTransparency"] = 1,
        ["FillTransparency"] = 1
    }):Play()
    _G.destroy(v32, 0.5)
    if p28.PrimaryPart then
        _G.PlaySound(p28.PrimaryPart, script.DragonFlameModeOff).Parent = p28.PrimaryPart
    end
    for _, v37 in v34 do
        for _, v38 in v37:GetDescendants() do
            if v38:IsA("ParticleEmitter") then
                v38.Enabled = false
            end
        end
        _G.destroy(v37, 1.5)
    end
end
return v3