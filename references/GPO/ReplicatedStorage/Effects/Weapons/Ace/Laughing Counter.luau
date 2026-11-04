 

local v1 = {}
game:GetService("Players")
local u2 = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local function u5(p3) --[[ Line: 7 ]]
    for _, u4 in p3:GetDescendants() do
        if u4:IsA("ParticleEmitter") then
            task.delay(u4:GetAttribute("EmitDelay"), function() --[[ Line: 10 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                _G.customEmit(u4)
            end)
        end
    end
end
local function u7() --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = Instance.new("ColorCorrectionEffect")
    v6.Parent = game.Lighting
    v6.Brightness = -0.5
    v6.Contrast = -25
    v6.Saturation = -2
    u2:Create(v6, TweenInfo.new(0.25), {
        ["Saturation"] = -1,
        ["Contrast"] = -5
    }):Play()
    _G.destroy(v6, 0.125)
end
function v1.start(_, p8, p9, p10) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u7
    --]]
    if _G.checkRenderDistance(p8.PrimaryPart.Position) ~= false then
        local u11 = Random.new()
        local v12 = script.SoruPart:Clone()
        v12.CFrame = p8:GetPivot() * CFrame.new(0, 0.125, 0)
        v12.CFrame = CFrame.new(v12.Position, (p9:GetPivot() * CFrame.new(0, 0, 2)).Position)
        v12.Parent = workspace.Effects
        u5(v12)
        _G.destroy(v12, 2)
        for _, v13 in p8:GetChildren() do
            if v13:IsA("BasePart") and v13.Name ~= "HumanoidRootPart" then
                local v14 = script.SoruParticles:Clone()
                v14.Parent = v13
                _G.customEmit(v14)
                local v15 = v13:Clone()
                v15:ClearAllChildren()
                v15.Transparency = -1
                v15.CanCollide = false
                v15.Anchored = true
                local v16 = Enum.Material.Neon
                local v17 = Color3.new()
                v15.Material = v16
                v15.Color = v17
                v15.Parent = workspace.Effects
                u2:Create(v15, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                    ["Transparency"] = 1
                }):Play()
                _G.destroy(v14, 0.75)
                _G.destroy(v15, 1)
            end
        end
        local v18 = script.StartUp:Clone()
        v18.CFrame = p9:GetPivot()
        v18.Parent = workspace.Effects
        u5(v18)
        local v19 = script.EndSorupart:Clone()
        v19.CFrame = p8:GetPivot() * CFrame.new(0, 0.125, 0)
        v19.Parent = workspace.Effects
        u5(v19)
        if game.Players.LocalPlayer.Character == (p8 or p9) then
            u7()
        end
        task.wait(0.125)
        if game.Players.LocalPlayer.Character == (p8 or p9) then
            _G.camShake:Shake(_G.camShake.Presets.AceBlowUp)
        end
        local v20 = Instance.new("Highlight")
        local v21 = Color3.new()
        local v22 = Color3.new(1)
        v20.FillColor = v21
        v20.OutlineColor = v22
        v20.FillTransparency = 0
        v20.OutlineTransparency = 0
        v20.Parent = p9
        _G.destroy(v20, 0.1)
        local v23 = script.Smash:Clone()
        v23:PivotTo(p9:GetPivot() * CFrame.new(0, 10.13, 0))
        _G.recolorParticles(v23, p10)
        v23.Parent = workspace.Effects
        local v24 = RaycastParams.new()
        local v25 = { workspace.Islands, workspace.Env, workspace.Ships }
        local v26 = Enum.RaycastFilterType.Include
        v24.FilterDescendantsInstances = v25
        v24.FilterType = v26
        local v27 = workspace:Raycast(p9:GetPivot().Position, Vector3.new(0, -10, 0), v24)
        if v27 then
            local v28 = v27.Position + Vector3.new(0, 10.13, 0)
            v23:PivotTo(CFrame.new(v28, v28 + v27.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0))
        else
            for _, v29 in v23:GetDescendants() do
                if v29.Name == "Images" or v29.Name == "Rocks" then
                    v29:Destroy()
                end
            end
        end
        for _, u30 in v23:GetDescendants() do
            if u30:IsA("Decal") then
                if v27 and v27.Normal ~= Vector3.new(0, 1, 0) then
                    u30:Destroy()
                end
                task.delay(2, function() --[[ Line: 122 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u30
                        [3] = u11
                    --]]
                    u2:Create(u30, TweenInfo.new(u11:NextNumber(0.6, 0.75)), {
                        ["Transparency"] = 1
                    }):Play()
                end)
            elseif u30:IsA("PointLight") then
                u2:Create(u30, TweenInfo.new(0.44), {
                    ["Brightness"] = 0
                }):Play()
            elseif u30:IsA("BasePart") and u30.Name == "Rocks" then
                local v31 = workspace:Raycast(u30.Position + Vector3.new(0, 3, 0), Vector3.new(0, -15, 0), v24)
                if v31 then
                    u30.Position = v31.Position
                    local v32 = v31.Instance.Material
                    local v33 = v31.Instance.Color
                    u30.Material = v32
                    u30.Color = v33
                    task.delay(u11:NextNumber(2, 2.5), function() --[[ Line: 133 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u30
                            [3] = u11
                        --]]
                        u2:Create(u30, TweenInfo.new(u11:NextNumber(0.45, 0.65)), {
                            ["Position"] = u30.Position - Vector3.new(0, 5, 0),
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                    end)
                else
                    u30:Destroy()
                end
            end
        end
        u5(v23)
        _G.destroy(v18, 2)
        _G.destroy(v19, 2)
        _G.destroy(v23, 5)
    end
end
return v1