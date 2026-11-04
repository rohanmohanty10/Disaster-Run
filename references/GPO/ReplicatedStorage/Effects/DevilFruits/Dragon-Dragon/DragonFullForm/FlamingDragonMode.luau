 

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
            u12.Completed:Once(function() --[[ Line: 68 ]]
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
    task.delay(v10, function() --[[ Line: 87 ]]
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
local function u31(p16, p17, p18) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u1
        [4] = u5
    --]]
    local v19 = CFrame.Angles(-1.5707963267948966, 0, 0)
    local u20 = script.BonePart:Clone()
    u20.CFrame = p16.WorldCFrame * v19
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
                [2] = u7
            --]]
            local v23 = {}
            local v24 = {}
            for v25, v26 in pairs(u6) do
                for v27, v28 in pairs(v26) do
                    if v28.Bone and (v28.Part and v28.Part.Parent) then
                        local v29 = v28.Part
                        table.insert(v23, v29)
                        local v30 = v28.Bone.WorldCFrame * v28.Offset
                        table.insert(v24, v30)
                    else
                        u6[v25][v27] = nil
                    end
                end
                if next(u6[v25]) == nil then
                    u6[v25] = nil
                end
            end
            if #v23 > 0 then
                workspace:BulkMoveTo(v23, v24, Enum.BulkMoveMode.FireCFrameChanged)
            elseif next(u6) == nil then
                u7:Disconnect()
                u7 = nil
            end
        end)
    end
    p16.Destroying:Connect(function() --[[ Line: 116 ]]
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
        u5(u20.Attachment)
    end
    return u20
end
function v3.start(_, p32, p33, p34) --[[ Line: 134 ]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u2
    --]]
    local _ = workspace:GetServerTimeNow() - p34
    local v35 = game.Players.LocalPlayer.Character == p32
    local v36 = Instance.new("Highlight")
    v36.FillColor = Color3.new()
    v36.FillTransparency = 0
    v36.OutlineTransparency = 1
    v36.DepthMode = Enum.HighlightDepthMode.Occluded
    v36.Parent = p33
    local v37
    if v35 == true then
        v37 = Instance.new("ColorCorrectionEffect")
        v37.Brightness = 1
        v37.Parent = game.Lighting
    else
        v37 = nil
    end
    task.wait(0.0625)
    v36.FillColor = Color3.new(1, 1, 1)
    if v37 then
        v37.TintColor = Color3.new()
    end
    task.wait(0.0625)
    if v37 then
        v37:Destroy()
    end
    v36.FillTransparency = 1
    v36.OutlineTransparency = 1
    v36.OutlineColor = Color3.fromRGB(255, 81, 0)
    v36.FillColor = Color3.fromRGB(255, 81, 0)
    local v38 = {}
    for v39 = 1, 48 do
        local v40 = u31(p33.PrimaryPart:FindFirstChild("Body_" .. v39, true), v39 % 4 == 0, p32)
        table.insert(v38, v40)
        task.wait()
    end
    u2:Create(v36, TweenInfo.new(0.5), {
        ["OutlineTransparency"] = 0.25,
        ["FillTransparency"] = 0.95
    }):Play()
    repeat
        task.wait()
    until p32:GetAttribute("FireMode") == nil or p32:IsDescendantOf(workspace) == false
    v36.FillTransparency = 0
    v36.OutlineTransparency = 0
    u2:Create(v36, TweenInfo.new(0.5), {
        ["OutlineTransparency"] = 1,
        ["FillTransparency"] = 1
    }):Play()
    _G.destroy(v36, 0.5)
    if p32.PrimaryPart then
        _G.PlaySound(p32.PrimaryPart, script.DragonFlameModeOff).Parent = p32.PrimaryPart
    end
    for _, v41 in v38 do
        for _, v42 in v41:GetDescendants() do
            if v42:IsA("ParticleEmitter") then
                v42.Enabled = false
            end
        end
        _G.destroy(v41, 1.5)
    end
end
return v3