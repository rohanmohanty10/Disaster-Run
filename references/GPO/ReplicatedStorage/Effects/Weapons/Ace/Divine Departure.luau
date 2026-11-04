 

local v1 = {}
local u2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local function u6(p4) --[[ Line: 7 ]]
    for _, u5 in p4:GetDescendants() do
        if u5:IsA("ParticleEmitter") then
            task.delay(u5:GetAttribute("EmitDelay"), function() --[[ Line: 10 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                _G.customEmit(u5)
            end)
        end
    end
end
function v1.start(_, u7) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u3
        [3] = u2
    --]]
    if _G.checkRenderDistance(u7.PrimaryPart.Position) == false then
        return
    end
    u7:GetPivot()
    local u8 = Random.new()
    local v9 = u7:FindFirstChild("Roger\'s AceSword")
    local v10 = script.Sword:Clone()
    v10.CFrame = u7.Sword.CFrame
    v10.Parent = workspace.Effects
    if v9 then
        local v11 = Instance.new("WeldConstraint")
        local v12 = v9.Blade
        v11.Parent = v10
        v11.Part0 = v10
        v11.Part1 = v12
    end
    task.wait(0.45)
    v10:Destroy()
    local v13, _, _ = _G.getRayFloor(u7:GetPivot(), 12)
    local v14 = script.Shoot:Clone()
    v14.CFrame = u7:GetPivot()
    if v13 then
        v14.Attachment2.Smoke.Color = ColorSequence.new(v13.Color)
        v14.Attachment2.SmokeDetail.Color = ColorSequence.new(v13.Color)
    end
    v14.Parent = workspace.Effects
    u6(v14)
    _G.destroy(v14, 2.5)
    _G.camShake:Shake(_G.camShake.Presets.WindBreak)
    local v15 = script.SlashModel:Clone()
    v15:PivotTo(u7:GetPivot() * CFrame.new(0, 1.5, -2) * CFrame.Angles(0, 0, -0.5235987755982988))
    local v16 = Instance.new("Highlight")
    v16.DepthMode = Enum.HighlightDepthMode.Occluded
    v16.FillTransparency = 0
    v16.OutlineColor = Color3.fromRGB(255, 0, 0)
    v16.FillColor = Color3.fromRGB(0, 0, 0)
    v16.Parent = v15
    v15.Parent = workspace.Effects
    local v17 = os.time()
    local v18 = OverlapParams.new()
    v18.FilterType = Enum.RaycastFilterType.Exclude
    v18.FilterDescendantsInstances = { v15, u7 }
    while os.time() - v17 < 3 do
        local v19 = task.wait()
        v15:PivotTo(v15:GetPivot() * CFrame.new(0, 0, -v19 * 120))
        local v20 = false
        for _, v21 in workspace:GetPartsInPart(v15.Main, v18) do
            local v22 = v21.Parent:FindFirstChild("Humanoid") or v21.Parent.Parent:FindFirstChild("Humanoid")
            if v22 then
                v20 = true
                local u23 = v22.Parent
                u23:PivotTo(CFrame.new(u23:GetPivot().Position, u7:GetPivot().Position))
                local v24 = v18.FilterDescendantsInstances
                table.insert(v24, u23)
                local v25 = RaycastParams.new()
                local v26 = v18.FilterType
                local v27 = v18.FilterDescendantsInstances
                v25.FilterType = v26
                v25.FilterDescendantsInstances = v27
                local u28 = workspace:Raycast(u23:GetPivot().Position + Vector3.new(0, 2.5, 0), u7:GetPivot().LookVector * 45, v25)
                if u28 then
                    local u29 = CFrame.new(u28.Position, u28.Position + u28.Normal)
                    local v30 = u28.Distance / 200
                    u3:Create(u23.PrimaryPart, TweenInfo.new(v30, Enum.EasingStyle.Linear), {
                        ["CFrame"] = u29 * CFrame.new(0, 0, -0.5)
                    }):Play()
                    task.delay(v30, function() --[[ Line: 112 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u28
                            [3] = u7
                            [4] = u23
                            [5] = u29
                            [6] = u6
                            [7] = u3
                            [8] = u8
                        --]]
                        local v31 = u2.LocalPlayer.Character
                        local v32 = (v31:GetPivot().Position - u28.Position).Magnitude
                        if u7 == v31 or (u23 == v31 or v32 < 120) then
                            task.delay(0.06, function() --[[ Line: 116 ]]
                                _G.camShake:Shake(_G.camShake.Presets.AceBlowUp)
                                local v33 = Instance.new("ColorCorrectionEffect")
                                v33.Parent = game.Lighting
                                v33.Contrast = 100
                                v33.Saturation = -1
                                _G.destroy(v33, 0.06666666666666667)
                            end)
                        end
                        local v34 = Instance.new("BodyPosition")
                        v34.P = 50000
                        local v35 = u23:GetPivot().Position
                        local v36 = u23.PrimaryPart
                        v34.Position = v35
                        v34.MaxForce = Vector3.new(500000, 500000, 500000)
                        v34.Parent = v36
                        local u37 = script.WallHitModel:Clone()
                        u37:PivotTo(u29)
                        u37.Parent = workspace.Effects
                        u6(u37)
                        u3:Create(u37.Main.Attachment.PointLight, TweenInfo.new(u8:NextNumber(0.6, 0.8)), {
                            ["Brightness"] = 0
                        }):Play()
                        for _, v38 in u37:GetDescendants() do
                            if v38.Name == "GroundRocks" and v38:IsA("BasePart") then
                                local v39 = u28.Material
                                local v40 = u28.Instance.Color
                                v38.Material = v39
                                v38.Color = v40
                            end
                        end
                        task.delay(2.5, function() --[[ Line: 140 ]]
                            --[[
                            Upvalues:
                                [1] = u37
                                [2] = u3
                                [3] = u8
                            --]]
                            for _, v41 in u37:GetDescendants() do
                                if v41.Name == "GroundRocks" and v41:IsA("BasePart") then
                                    u3:Create(v41, TweenInfo.new(u8:NextNumber(0.5, 0.65)), {
                                        ["Size"] = Vector3.new(0, 0, 0)
                                    }):Play()
                                elseif v41:IsA("Decal") then
                                    u3:Create(v41, TweenInfo.new(u8:NextNumber(0.6, 0.8)), {
                                        ["Transparency"] = 1
                                    }):Play()
                                end
                            end
                        end)
                        _G.destroy(v34, 2.8)
                        _G.destroy(u37, 6)
                    end)
                else
                    local v42 = Instance.new("BodyVelocity")
                    local v43 = u23:GetPivot().LookVector * -80
                    local v44 = u23.PrimaryPart
                    v42.Velocity = v43
                    v42.MaxForce = Vector3.new(500000, 500000, 500000)
                    v42.Parent = v44
                    _G.destroy(v42, 0.45)
                    u3:Create(v42, TweenInfo.new(0.45), {
                        ["Velocity"] = Vector3.new(0, 0, 0)
                    }):Play()
                end
                local v45 = script.InitialHit:Clone()
                v45.CFrame = u23:GetPivot()
                v45.Parent = workspace.Effects
                u6(v45)
                _G.destroy(v45, 3.5)
                break
            end
        end
        if v20 then
            break
        end
    end
    for _, v46 in v15:GetDescendants() do
        if v46:IsA("Trail") then
            v46:Destroy()
        end
        if v46:IsA("ParticleEmitter") then
            v46.Enabled = false
        elseif v46:IsA("BasePart") then
            u3:Create(v46, TweenInfo.new(0.125), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
            if v46.Name == "Slash" then
                u3:Create(v46, TweenInfo.new(0.2), {
                    ["CFrame"] = v46.CFrame * CFrame.new(0, 0, 16)
                }):Play()
            end
        end
    end
    _G.destroy(v15, 1)
end
return v1