 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
game:GetService("UserInputService")
local u4 = script.Parent.Puddles.Purple
local u5 = script.Animations
game.Players.LocalPlayer:GetMouse()
function PlayAnim(p6, p7)
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v8 = (p6:FindFirstChild("Humanoid") or p6:FindFirstChild("AnimationController")).Animator:LoadAnimation(u5[p7])
    v8:Play(0, 1, 1)
    return v8
end
local function u14(p9) --[[ Line: 23 ]]
    local v10 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v11 = math.clamp(v10, 1, 10)
    for _, v12 in p9:GetDescendants() do
        if v12:IsA("ParticleEmitter") then
            local v13 = v12:GetAttribute("EmitCount") * (v11 / 10)
            v12:Emit((math.clamp(v13, 1, v12:GetAttribute("EmitCount"))))
        end
    end
end
local function u33(u15, u16, u17, _) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u14
    --]]
    local v18 = u4:GetChildren()
    local u19 = v18[math.random(1, #v18)]:Clone()
    u19:PivotTo(CFrame.new(u15, u16 + u15) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0))
    u19.Parent = workspace.Effects
    _G.scaleParticle(u19, 0.5 + u17)
    for _, v20 in u19:GetChildren() do
        local v21 = v20:FindFirstChildOfClass("MeshPart")
        local v22 = v21.Size
        v21.Size = Vector3.new()
        if v20.Name == "Out" then
            v22 = v22 * 1.02
        end
        local v23 = {
            ["Size"] = v22 * u17
        }
        u3:Create(v21, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v23):Play()
    end
    _G.PlaySound(CFrame.new(u15), script.Sounds["VenomSwipeBoom" .. math.random(1, 3)])
    task.spawn(function() --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u16
            [3] = u3
            [4] = u17
        --]]
        for _ = 1, 4 do
            local v24 = script.Slash:Clone()
            v24.CFrame = CFrame.new(u15, u16 + u15) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(Random.new():NextNumber(-0.39269908169872414, 0.39269908169872414), 0, Random.new():NextNumber(-0.39269908169872414, 0.39269908169872414))
            v24.Parent = workspace.Effects
            v24.Mesh.Scale = Vector3.new(0, 0, 0)
            v24.Glow.Transparency = -3
            local v25 = Random.new():NextNumber(0.75, 1.35)
            _G.destroy(v24, 1.5)
            u3:Create(v24, TweenInfo.new(0.65 * v25), {
                ["CFrame"] = v24.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            local v26 = u3
            local v27 = v24.Mesh
            local v28 = TweenInfo.new(0.35 * v25)
            local v29 = {}
            local v30 = u17 / 2
            v29.Scale = Vector3.new(5.494, 17.352, 5.494) * math.clamp(v30, 0.5, 8)
            v26:Create(v27, v28, v29):Play()
            u3:Create(v24.Glow, TweenInfo.new(0.45 * v25), {
                ["Transparency"] = 1
            }):Play()
            task.wait()
        end
    end)
    local v31 = script.SplashPuddle:Clone()
    v31.CFrame = CFrame.new(u15, u16 + u15) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v31.Parent = workspace.Effects
    _G.scaleParticle(v31, 0.5 + u17)
    _G.destroy(v31, 2)
    u14(v31)
    task.delay(2, function() --[[ Line: 81 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u3
        --]]
        _G.destroy(u19, 1)
        for _, v32 in u19:GetChildren() do
            u3:Create(v32:FindFirstChildOfClass("MeshPart"), TweenInfo.new(0.95, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(),
                ["Transparency"] = 1
            }):Play()
        end
    end)
end
function v1.start(_, p34, p35) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u33
    --]]
    if _G.checkRenderDistance(p34.Position) ~= false then
        for v36 = 2, -2, -1 do
            local u37 = script.Projectile:Clone()
            u37:PivotTo(p34 * CFrame.new(0, 1.25, 0) * CFrame.Angles(0, v36 * 0.3490658503988659, 0))
            u37.Parent = workspace.Effects
            local u38 = u37.PrimaryPart.CFrame.LookVector
            local u39 = u38 * 100
            local _ = u37.PrimaryPart.Position
            local v40 = { workspace.Env, workspace.Islands, workspace.Ships }
            local v41 = _G.getTargets(p35)
            for v42 = 1, #v41 do
                local v43 = v41[v42]
                table.insert(v40, v43)
            end
            local u44 = RaycastParams.new()
            u44.FilterType = Enum.RaycastFilterType.Whitelist
            u44.FilterDescendantsInstances = v40
            local u45 = 0
            local u46 = u37.PrimaryPart.CFrame
            local u47 = nil
            u47 = u2.Heartbeat:Connect(function(p48) --[[ Line: 131 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u37
                    [3] = u38
                    [4] = u45
                    [5] = u46
                    [6] = u44
                    [7] = u47
                    [8] = u33
                --]]
                local v49 = u39
                local v50 = workspace.Gravity * p48
                u39 = v49 - Vector3.new(0, v50)
                u37:PivotTo(CFrame.new(u37.PrimaryPart.Position + u39 * p48, u37.PrimaryPart.Position + u39 * p48 + u38))
                u45 = u45 + (u39 * p48).Magnitude / 1.25
                local v51 = (u46.Position - u37.PrimaryPart.Position).Magnitude
                local v52 = workspace:Raycast(u46.Position, CFrame.new(u46.Position, u37.PrimaryPart.Position).LookVector * v51, u44)
                if v52 then
                    u47:Disconnect()
                    _G.destroy(u37, 1)
                    for _, v53 in u37:GetDescendants() do
                        if v53:IsA("ParticleEmitter") then
                            v53.Enabled = false
                        end
                        if v53:IsA("BasePart") then
                            v53.Transparency = 1
                        end
                    end
                    local v54 = u39.Magnitude / 25
                    local v55 = u45 * math.clamp(v54, 1, (1 / 0)) / 40
                    u33(v52.Position, v52.Normal, (math.clamp(v55, 1, 8)))
                end
                u46 = u37.PrimaryPart.CFrame
            end)
            task.delay(7, function() --[[ Line: 156 ]]
                --[[
                Upvalues:
                    [1] = u47
                    [2] = u37
                --]]
                if u47.Connected then
                    u47:Disconnect()
                    _G.destroy(u37, 1)
                    for _, v56 in u37:GetDescendants() do
                        if v56:IsA("ParticleEmitter") then
                            v56.Enabled = false
                        end
                        if v56:IsA("BasePart") then
                            v56.Transparency = 1
                        end
                    end
                end
            end)
            task.wait(0.025)
        end
    end
end
return v1