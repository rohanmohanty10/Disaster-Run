 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = script:WaitForChild("Rocks")
local u4 = Random.new()
function v1.start(_, u5, _) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    local u6 = script.Pica:Clone()
    local u7 = u5.HumanoidRootPart.CFrame * CFrame.new(0.5, 0, 7)
    u6:SetPrimaryPartCFrame(u7 * CFrame.new(0, -10, 0))
    _G.PlaySound(u5.PrimaryPart, script["Audio/PicaGrip"])
    local v8 = next
    local v9, v10 = u5:GetDescendants()
    for _, u11 in v8, v9, v10 do
        if u11:IsA("BasePart") and (u11.Name ~= "HumanoidRootPart" and u11.Transparency ~= 1) then
            u11.CanCollide = false
            local u12 = u11:Clone()
            u12.Anchored = false
            u12.CanCollide = false
            u12.Massless = true
            u12.Size = u12.Size + Vector3.new(0.1, 0.1, 0.1)
            u12.Color = Color3.fromRGB(113, 113, 113)
            u12.Transparency = 1
            u12.Material = Enum.Material.Slate
            u12:ClearAllChildren()
            u12.Parent = workspace.Effects
            local v13 = Instance.new("WeldConstraint")
            v13.Part0 = u12
            v13.Part1 = u11
            v13.Parent = u12
            u2:Create(u12, TweenInfo.new(0.5), {
                ["Transparency"] = 0.015
            }):Play()
            task.delay(6.73, function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u11
                    [3] = u3
                    [4] = u4
                    [5] = u6
                    [6] = u5
                    [7] = u2
                --]]
                local v14 = script.Smoke:Clone()
                v14.Parent = u12
                _G.customEmit(v14)
                u12.Transparency = 1
                u11.Transparency = 1
                for _ = 1, math.random(1, 3) do
                    local u15 = u3:GetChildren()[math.random(1, #u3:GetChildren())]:Clone()
                    u15.Position = u12.Position
                    local v16 = u4:NextNumber(-0.5, 0.5)
                    u15.Size = u15.Size + Vector3.new(v16, v16, v16)
                    local v17 = u4:NextNumber(0, 360)
                    local v18 = u4:NextNumber(0, 360)
                    local v19 = u4
                    u15.Orientation = Vector3.new(v17, v18, v19:NextNumber(0, 360))
                    u15.Anchored = false
                    u15.CanCollide = false
                    local u20 = Instance.new("BodyVelocity")
                    u20.MaxForce = Vector3.new(inf, inf, inf)
                    local v21 = CFrame.new(u6.HumanoidRootPart.Position, u5.HumanoidRootPart.Position).LookVector
                    local v22 = u4:NextNumber(-1, 1)
                    local v23 = u4:NextNumber(0, 0.75)
                    local v24 = u4
                    u20.Velocity = (v21 + Vector3.new(v22, v23, v24:NextNumber(-1, 1))) * u4:NextNumber(13.5, 32.5)
                    u20.Parent = u15
                    task.delay(0.1, function() --[[ Line: 76 ]]
                        --[[
                        Upvalues:
                            [1] = u20
                            [2] = u15
                        --]]
                        u20:Destroy()
                        u15.CanCollide = true
                    end)
                    u15.Color = u12.Color
                    u15.Material = u12.Material
                    u15.Parent = workspace.Effects
                    task.delay(math.random(100, 200) / 100, function() --[[ Line: 86 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u15
                        --]]
                        u2:Create(u15, TweenInfo.new(1), {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                        _G.destroy(u15, 1)
                    end)
                end
                task.wait(5)
                u12:Destroy()
            end)
        end
    end
    task.wait(0.9)
    u6.Parent = workspace.Effects
    u6.Humanoid:LoadAnimation(script.Jump):Play()
    u2:Create(u6.HumanoidRootPart, TweenInfo.new(2.5), {
        ["CFrame"] = u6.HumanoidRootPart.CFrame * CFrame.new(0, 12.8, 0)
    }):Play()
    local u25 = true
    local v26 = script.Floor:Clone()
    v26.Position = u7.Position
    v26.Parent = workspace.Effects
    task.spawn(function() --[[ Line: 114 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u3
            [3] = u7
            [4] = u4
            [5] = u2
        --]]
        while u25 do
            local u27 = u3:GetChildren()[math.random(1, #u3:GetChildren())]:Clone()
            local v28 = u7.Position
            local v29 = u4:NextNumber(-5, 5)
            local v30 = u4
            u27.Position = v28 + Vector3.new(v29, -2, v30:NextNumber(-5, 5))
            local v31 = u4:NextNumber(-0.5, 0.5)
            u27.Size = u27.Size + Vector3.new(v31, v31, v31)
            local v32 = u4:NextNumber(0, 360)
            local v33 = u4:NextNumber(0, 360)
            local v34 = u4
            u27.Orientation = Vector3.new(v32, v33, v34:NextNumber(0, 360))
            u27.Anchored = false
            u27.CanCollide = false
            local u35 = Instance.new("BodyVelocity")
            u35.MaxForce = Vector3.new(inf, inf, inf)
            local v36 = u4:NextNumber(-7.5, 7.5)
            local v37 = u4:NextNumber(1.5, 3)
            local v38 = u4
            u35.Velocity = Vector3.new(v36, v37, v38:NextNumber(-7.5, 7.5)) * 2
            u35.Parent = u27
            task.delay(0.1, function() --[[ Line: 130 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u27
                --]]
                u35:Destroy()
                u27.CanCollide = true
            end)
            u27.Color = Color3.fromRGB(91, 91, 91)
            u27.Material = Enum.Material.Slate
            u27.Parent = workspace.Effects
            task.delay(math.random(100, 200) / 100, function() --[[ Line: 140 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u27
                --]]
                u2:Create(u27, TweenInfo.new(1), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }):Play()
                _G.destroy(u27, 1)
            end)
            task.wait(0.02)
        end
    end)
    task.wait(2)
    v26.Smoke.Enabled = false
    u25 = false
    task.wait(1.5)
    u6.Humanoid:LoadAnimation(script.Punch):Play()
    task.wait(2.31)
    local v39 = script.Impact:Clone()
    v39.CFrame = u5.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, -1) * CFrame.Angles(0, 0, 0)
    v39.Parent = workspace.Effects
    _G.customEmit(v39)
    task.wait(1.3)
    u6.Humanoid:LoadAnimation(script.dive):Play()
    u2:Create(u6.HumanoidRootPart, TweenInfo.new(1), {
        ["CFrame"] = u6.HumanoidRootPart.CFrame * CFrame.new(0, -12.8, 0)
    }):Play()
    task.wait(1)
    v39:Destroy()
    v26:Destroy()
    u6:Destroy()
end
return v1