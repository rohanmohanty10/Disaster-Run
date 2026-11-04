 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = _G.customEmit
function CreateMesh(p5, p6)
    local v7 = script:WaitForChild("MeshImage"):Clone()
    v7.CFrame = p6 * CFrame.Angles(0, -1.5707963267948966, 0)
    v7.Parent = workspace.Effects
    v7.Decal.Texture = "rbxassetid://" .. p5
    return v7
end
function CubicBezier(p8, p9, p10, p11, p12)
    local v13 = (1 - p8) ^ 3 * p9 + 3 * (1 - p8) ^ 2 * p8 * p10 + 3 * (1 - p8) * p8 ^ 2 * p11 + p8 ^ 3 * p12
    local v14 = p8 + 0.006944444444444444
    local v15 = (1 - v14) ^ 3 * p9 + 3 * (1 - v14) ^ 2 * v14 * p10 + 3 * (1 - v14) * v14 ^ 2 * p11 + v14 ^ 3 * p12
    return CFrame.new(v13, v15)
end
function v1.start(_, p16) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u4
    --]]
    if _G.checkRenderDistance(p16.PrimaryPart.Position) ~= false then
        _G.PlaySound(p16.PrimaryPart, script.YomiReviveSFX)
        local v17 = Random.new()
        for _ = 1, 6 do
            local u18 = (p16:GetPrimaryPartCFrame() * CFrame.new(v17:NextNumber(-8, 8), v17:NextNumber(2, 8), v17:NextNumber(-8, 8))).Position
            local u19 = p16:GetPrimaryPartCFrame().Position
            local u20 = script.TrailPart:Clone()
            u20.Position = u18
            u20.Parent = workspace.Effects
            local v21 = (u18 - u19).Magnitude
            local v22 = CFrame.new(u18, u19)
            local u23 = (v22 * CFrame.new(v17:NextNumber(-12.5, 12.5), v17:NextNumber(-16, 16), -v21 / 2.5)).Position
            local u24 = (v22 * CFrame.new(v17:NextNumber(-12.5, 12.5), v17:NextNumber(-16, 16), -v21 / 1.75)).Position
            local u25 = nil
            local u26 = 0
            u25 = u3.Heartbeat:Connect(function(p27) --[[ Line: 47 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u20
                    [3] = u25
                    [4] = u18
                    [5] = u23
                    [6] = u24
                    [7] = u19
                --]]
                if u26 >= 1 then
                    _G.destroy(u20, 0.5)
                    u25:Disconnect()
                else
                    u26 = u26 + p27 / 0.5
                    u20.Position = CubicBezier(u26, u18, u23, u24, u19).Position
                end
            end)
            task.wait(0.03333333333333333)
        end
        task.wait(0.5)
        for _ = 1, 5 do
            local v28 = script.Wind:Clone()
            v28.CFrame = p16:GetPrimaryPartCFrame() * CFrame.Angles(0, v17:NextNumber(-3.141592653589793, 3.141592653589793), 0)
            v28.Parent = workspace.Effects
            local v29 = v17:NextNumber(-3.141592653589793, 3.141592653589793)
            local v30 = v17:NextNumber(-3.141592653589793, 3.141592653589793)
            local v31 = v17:NextNumber(-3.141592653589793, 3.141592653589793)
            v28.Decal.Transparency = 0.75
            v28.Mesh.Scale = Vector3.new(0, 0, 0)
            u2:Create(v28.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(v28, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = p16:GetPrimaryPartCFrame() * CFrame.Angles(v29, v30, v31)
            }):Play()
            u2:Create(v28.Mesh, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(6, 8, 6)
            }):Play()
            _G.destroy(v28, 0.5)
        end
        local v32 = script.Effect.Revive:Clone()
        v32.WorldCFrame = p16.PrimaryPart.CFrame
        v32.Parent = workspace.Terrain
        u4(v32)
        _G.destroy(v32, 1.6)
        local v33 = Instance.new("Highlight")
        v33.OutlineTransparency = 1
        v33.DepthMode = Enum.HighlightDepthMode.Occluded
        v33.FillTransparency = 0
        v33.OutlineColor = Color3.fromRGB(0, 0, 0)
        v33.FillColor = Color3.fromRGB(170, 255, 0)
        v33.Parent = p16
        _G.tween(v33, { 3, "Quad", Enum.EasingDirection.Out }, {
            ["FillTransparency"] = 1
        })
        _G.destroy(v33, 3)
        local v34 = next
        local v35, v36 = p16:GetChildren()
        for _, v37 in v34, v35, v36 do
            if v37:IsA("BasePart") and v37.Name ~= "HumanoidRootPart" then
                local v38 = script:WaitForChild("Effect").ReviveAura:Clone()
                v38.Parent = v37
                v38:Emit(8)
                _G.destroy(v38, 1)
            end
        end
        if p16 == game.Players.LocalPlayer.Character then
            local v39 = Instance.new("ColorCorrectionEffect")
            v39.Saturation = -1
            v39.Brightness = 0.5
            v39.Contrast = 3
            local v40 = Color3.fromRGB(137, 255, 135)
            local v41 = workspace.CurrentCamera
            v39.TintColor = v40
            v39.Parent = v41
            u2:Create(v39, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Saturation"] = 0,
                ["Brightness"] = 0,
                ["Contrast"] = 0,
                ["TintColor"] = Color3.new(1, 1, 1)
            }):Play()
            _G.destroy(v39, 0.5)
        end
        local v42 = CreateMesh("9572542664", CFrame.new(p16:GetPrimaryPartCFrame().Position, p16:GetPrimaryPartCFrame().Position - Vector3.new(0, 2, 0)))
        v42.Mesh.Scale = Vector3.new(0.225, 0.578, 0.541)
        v42.Decal.Color3 = Color3.fromRGB(400, 2555, 100)
        _G.tween(v42.Mesh, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(1.036, 0, 0)
        })
        _G.tween(v42, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v42.CFrame * CFrame.new(14, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        })
        _G.destroy(v42, 0.25)
    end
end
return v1