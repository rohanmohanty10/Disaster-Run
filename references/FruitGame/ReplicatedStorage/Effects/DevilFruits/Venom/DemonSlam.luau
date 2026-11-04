 

local v1 = {}
game:GetService("RunService")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
require(script.Parent.VenomSplash)
local u3 = script.Animations
game.Players.LocalPlayer:GetMouse()
function PlayAnim(p4, p5)
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v6 = (p4:FindFirstChild("Humanoid") or p4:FindFirstChild("AnimationController")).Animator:LoadAnimation(u3[p5])
    v6:Play(0, 1, 1)
    return v6
end
local function u12(p7) --[[ Line: 35 ]]
    local v8 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v9 = math.clamp(v8, 1, 10)
    for _, v10 in p7:GetDescendants() do
        if v10:IsA("ParticleEmitter") then
            local v11 = v10:GetAttribute("EmitCount") * (v9 / 10)
            v10:Emit((math.clamp(v11, 1, v10:GetAttribute("EmitCount"))))
        end
    end
end
function v1.start(_, p13, p14, p15) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u2
    --]]
    if _G.checkRenderDistance(p13.PrimaryPart.Position) then
        if p13 then
            if p13:FindFirstChild("VenomDemonModel") then
                p13:FindFirstChild("VenomDemonModel")
                Random.new()
                local v16 = RaycastParams.new()
                local v17 = Enum.RaycastFilterType.Whitelist
                local v18 = { workspace.Ships, workspace.Islands, workspace.Env }
                v16.FilterType = v17
                v16.FilterDescendantsInstances = v18
                local v19 = workspace:Raycast((p15 * CFrame.new(0, 0, -35)).Position, Vector3.new(0, -35, 0), v16)
                if v19 then
                    local u20 = v19.Position
                    local u21 = v19.Normal
                    local v22 = script.Splash:Clone()
                    v22.Position = u20 + u21 * 4
                    v22.Parent = workspace.Effects
                    u12(v22)
                    _G.destroy(v22, 2)
                    _G.PlaySound(v22, script.Sounds["VenomDemonSmash" .. p14])
                    task.spawn(function() --[[ Line: 73 ]]
                        --[[
                        Upvalues:
                            [1] = u20
                            [2] = u21
                            [3] = u2
                        --]]
                        for _ = 1, 3 do
                            local v23 = script.Slash:Clone()
                            v23.CFrame = CFrame.new(u20, u21 + u20) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(Random.new():NextNumber(-0.2617993877991494, 0.2617993877991494), 0, Random.new():NextNumber(-0.2617993877991494, 0.2617993877991494))
                            v23.Parent = workspace.Effects
                            v23.Mesh.Scale = Vector3.new(0, 0, 0)
                            v23.Glow.Transparency = -1
                            local v24 = Random.new():NextNumber(0.75, 1.35)
                            _G.destroy(v23, 1.5)
                            u2:Create(v23, TweenInfo.new(0.65 * v24), {
                                ["CFrame"] = v23.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                            }):Play()
                            u2:Create(v23.Mesh, TweenInfo.new(0.35 * v24), {
                                ["Scale"] = Vector3.new(36.963, 37.191, 36.963)
                            }):Play()
                            u2:Create(v23.Glow, TweenInfo.new(0.45 * v24), {
                                ["Transparency"] = 1
                            }):Play()
                            task.wait()
                        end
                    end)
                    local v25 = CFrame.new(u20 + u21 * 3, u20 - u21 * 2)
                    local v26 = script.MeshImage:Clone()
                    v26.CFrame = v25 * CFrame.Angles(0, -1.5707963267948966, 0)
                    v26.Parent = workspace.Effects
                    v26.Decal.Texture = "rbxassetid://9572542664"
                    v26.Mesh.Scale = Vector3.new(0.45, 1.156, 1.082)
                    _G.tween(v26.Mesh, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                        ["Scale"] = Vector3.new(2.036, 0, 0)
                    })
                    _G.tween(v26, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                        ["CFrame"] = v26.CFrame * CFrame.new(28, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                    })
                    _G.destroy(v26, 0.2)
                    local v27 = CFrame.new(u20 + u21 * 8, u20 - u21 * 8)
                    local v28 = script.MeshImage:Clone()
                    v28.CFrame = v27 * CFrame.Angles(0, -1.5707963267948966, 0)
                    v28.Parent = workspace.Effects
                    v28.Decal.Texture = "rbxassetid://9622414579"
                    v28.Mesh.Scale = Vector3.new(0, 0, 0)
                    v28.Decal.Transparency = -1
                    _G.tween(v28, { 0.55, "Quad", Enum.EasingDirection.Out }, {
                        ["CFrame"] = v28.CFrame * CFrame.new(-7, 0, 0)
                    })
                    _G.tween(v28.Mesh, { 0.55, "Cubic", Enum.EasingDirection.Out }, {
                        ["Scale"] = Vector3.new(0.322, 2.022, 1.976)
                    })
                    _G.tween(v28.Decal, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v28, 0.6)
                    for v29 = 1, 2 do
                        local v30 = Random.new()
                        local v31 = v30:NextInteger(8, 12)
                        local v32 = v29 / 1.33
                        local v33 = math.clamp(v32, 1, 3)
                        for v34 = 1, v31 do
                            local v35 = 360 / v31 * v34
                            local v36 = math.rad(v35)
                            local v37 = v33 * 15
                            local v38 = (CFrame.new(u20, u20 + u21) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.cos(v36) * v37, 0, math.sin(v36) * v37)).Position
                            local v39 = RaycastParams.new()
                            local v40 = { workspace.Ships, workspace.Islands, workspace.Env }
                            local v41 = Enum.RaycastFilterType.Whitelist
                            v39.FilterDescendantsInstances = v40
                            v39.FilterType = v41
                            local v42 = workspace:Raycast(v38 + Vector3.new(0, 1, 0), u21 * -5, v39)
                            if v42 then
                                local v43 = Vector3.new(0, v30:NextNumber(0, 1))
                                local v44 = CFrame.Angles(0, v30:NextNumber(-0.5235987755982988, 0.5235987755982988), 0)
                                local v45 = CFrame.new(v38 + v43, u20) * v44
                                local u46 = script:WaitForChild("Debris"):Clone()
                                u46.Size = u46.Size * (v30:NextNumber(1.2, 1.5) * v33)
                                u46.CFrame = CFrame.new(u20, u20 - u21 * 10) * v44
                                u46.Parent = workspace.Effects
                                _G.matchMaterial(u46, v42.Instance)
                                _G.tween(u46, { 0.3, "Quint", Enum.EasingDirection.Out }, {
                                    ["CFrame"] = v45
                                })
                                task.delay(0.016666666666666666 * v30:NextInteger(1, 12) + 0.5, function() --[[ Line: 141 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u46
                                    --]]
                                    _G.tween(u46, { 0.75, "Back", Enum.EasingDirection.In }, {
                                        ["Size"] = Vector3.new(),
                                        ["CFrame"] = u46.CFrame * CFrame.new(0, -1.25, 0)
                                    })
                                    _G.destroy(u46, 0.75)
                                end)
                            end
                        end
                    end
                    local u47 = script.ImageFloor:Clone()
                    u47.CFrame = CFrame.new(u20, u20 + u21) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
                    u47.Parent = workspace.Effects
                    u47.Size = Vector3.new(0, 0, 0)
                    u2:Create(u47, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Size"] = Vector3.new(55.693, 0.003, 57.924)
                    }):Play()
                    task.delay(1.75, function() --[[ Line: 156 ]]
                        --[[
                        Upvalues:
                            [1] = u47
                            [2] = u2
                        --]]
                        _G.destroy(u47, 1.25)
                        local v48 = next
                        local v49, v50 = u47:GetChildren()
                        for _, v51 in v48, v49, v50 do
                            u2:Create(v51, TweenInfo.new(Random.new():NextNumber(0.6, 1.25), Enum.EasingStyle.Cubic), {
                                ["Transparency"] = 1
                            }):Play()
                        end
                    end)
                end
            end
        else
            return
        end
    else
        return
    end
end
return v1