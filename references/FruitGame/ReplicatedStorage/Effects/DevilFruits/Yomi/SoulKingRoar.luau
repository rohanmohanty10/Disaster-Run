 

local v1 = {}
local u2 = script:WaitForChild("Animations")
local u3 = game:GetService("TweenService")
game:GetService("RunService")
function PlayAnim(p4, p5)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = (p4:FindFirstChild("Humanoid") or p4:FindFirstChild("AnimationController")).Animator:LoadAnimation(u2[p5])
    v6:Play(0, 1, 1.5)
    return v6
end
local u7 = _G.customEmit
function Hitbox(p8, p9)
    local v10 = OverlapParams.new()
    local v11 = Enum.RaycastFilterType.Blacklist
    v10.FilterDescendantsInstances = { p8 }
    v10.FilterType = v11
    local v12 = workspace:GetPartBoundsInRadius(p8.PrimaryPart.Position, 40, v10)
    local v13 = {}
    for _, v14 in next, v12 do
        local v15 = v14.Parent:FindFirstChild("Humanoid") or v14.Parent.Parent:FindFirstChild("Humanoid")
        if v15 and not v13[v15] then
            task.spawn(p9, v15.Parent)
        end
    end
end
function v1.start(_, p16) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u7
    --]]
    if _G.checkRenderDistance(p16.PrimaryPart.Position) ~= false then
        local u17 = p16:GetPrimaryPartCFrame()
        local u18 = script:WaitForChild("Ball"):Clone()
        u18:PivotTo(u17 * CFrame.new(0, 12, 6))
        u18.Parent = workspace.Effects
        u18.PrimaryPart.Transparency = 1
        u3:Create(u18.PrimaryPart, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Transparency"] = 0
        }):Play()
        PlayAnim(u18, "Squish")
        u7(u18)
        local u19 = Random.new()
        task.delay(0.5, function() --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u3
                [3] = u17
                [4] = u7
                [5] = u19
            --]]
            u18.PrimaryPart.Fast.Enabled = true
            u3:Create(u18.PrimaryPart, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["CFrame"] = u17 * CFrame.new(0, -3, 6)
            }):Play()
            task.wait(0.5)
            _G.destroy(u18, 1.25)
            local u20 = script:WaitForChild("Sphere"):Clone()
            u20.CFrame = u17 * CFrame.new(0, -3, 5)
            u20.Parent = workspace.Effects
            u3:Create(u20, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(12.158, 0.05, 12.158)
            }):Play()
            local u21 = script:WaitForChild("SoulKing"):Clone()
            u21.Parent = workspace.Effects
            u21:PivotTo(u17 * CFrame.new(0, -3, 5))
            task.spawn(function() --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u7
                    [3] = u17
                    [4] = u19
                    [5] = u20
                --]]
                local v22 = next
                local v23, v24 = u21:GetChildren()
                for _, v25 in v22, v23, v24 do
                    if v25:IsA("BasePart") and v25.Name ~= "RootPart" then
                        v25.Transparency = 1
                        _G.tween(v25, { 0.25, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0
                        })
                    end
                end
                task.delay(1.33, function() --[[ Line: 76 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u7
                        [3] = u17
                        [4] = u19
                    --]]
                    local u26 = script:WaitForChild("Scream").Attachment:Clone()
                    u26.Parent = u21["Body.001"]
                    u7(u26)
                    _G.destroy(u26, 2)
                    task.spawn(function() --[[ Line: 85 ]]
                        --[[
                        Upvalues:
                            [1] = u17
                            [2] = u19
                            [3] = u7
                            [4] = u26
                        --]]
                        for _ = 1, 14 do
                            local v27 = script:WaitForChild("Wind"):Clone()
                            v27.CFrame = u17 * CFrame.new(0, 12, 0) * CFrame.Angles(0, u19:NextNumber(-3.141592653589793, 3.141592653589793), 0)
                            v27.Parent = workspace.Effects
                            local v28 = u19:NextNumber(-3.141592653589793, 3.141592653589793)
                            local v29 = u19:NextNumber(-3.141592653589793, 3.141592653589793)
                            local v30 = u19:NextNumber(-3.141592653589793, 3.141592653589793)
                            v27.Decal.Color3 = Color3.fromRGB(400, 2555, 100)
                            v27.Decal.Transparency = -1
                            v27.Decal.Texture = "rbxassetid://9697798256"
                            _G.tween(v27.Decal, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 1
                            })
                            _G.tween(v27, { 0.45, "EntranceExpressive", Enum.EasingDirection.Out }, {
                                ["CFrame"] = u17 * CFrame.Angles(v28, v29, v30) * CFrame.new(0, -8, 0)
                            })
                            _G.tween(v27.Mesh, { 0.35, "EntranceExpressive", Enum.EasingDirection.Out }, {
                                ["Scale"] = Vector3.new(15, 8, 15)
                            })
                            _G.destroy(v27, 0.5)
                            u7(u26)
                            task.wait(0.07142857142857142)
                        end
                    end)
                    for _ = 1, 7 do
                        local v31 = script:WaitForChild("Wind"):Clone()
                        v31.CFrame = u17 * CFrame.new(0, 3, 0) * CFrame.Angles(0, u19:NextNumber(-3.141592653589793, 3.141592653589793), 0)
                        v31.Parent = workspace.Effects
                        v31.Decal.Transparency = 0.75
                        _G.tween(v31.Decal, { 0.75, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        _G.tween(v31, { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["CFrame"] = u17 * CFrame.Angles(0, u19:NextNumber(-3.141592653589793, 3.141592653589793), 0) * CFrame.new(0, -8, 0)
                        })
                        _G.tween(v31.Mesh, { 0.5, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(15, 25, 15)
                        })
                        _G.destroy(v31, 1)
                        task.wait(0.14285714285714285)
                    end
                end)
                task.delay(2.25, function() --[[ Line: 123 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u20
                    --]]
                    local v32 = next
                    local v33, v34 = u21:GetDescendants()
                    for _, v35 in v32, v33, v34 do
                        if v35:IsA("BasePart") then
                            _G.tween(v35, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 1
                            })
                        elseif v35:IsA("ParticleEmitter") then
                            v35.Enabled = false
                        end
                    end
                    _G.destroy(u21, 0.45)
                    _G.destroy(u20, 0.75)
                    _G.tween(u20, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                end)
            end)
            PlayAnim(u21, "Roar")
        end)
    end
end
return v1