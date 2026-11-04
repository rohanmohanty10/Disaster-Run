 

local v1 = {}
game:GetService("RunService")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
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
function Quad(p7, p8, p9, p10)
    return (1 - p10) * (1 - p10) * p7 + 2 * (1 - p10) * p10 * p8 + p10 * p10 * p9
end
local function u13(p11) --[[ Line: 31 ]]
    for _, v12 in p11:GetDescendants() do
        if v12:IsA("ParticleEmitter") then
            _G.customEmit(v12)
        end
    end
end
function v1.start(_, p14) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u2
    --]]
    if _G.checkRenderDistance(p14.PrimaryPart.Position) then
        if p14 then
            if p14:FindFirstChild("VenomDemonModel") then
                local u15 = p14:FindFirstChild("VenomDemonModel")
                local u16 = u15.Head.Position - Vector3.new(0, 4, 0)
                task.wait(1)
                local v17 = script.Gas:Clone()
                v17.Position = u16
                v17.Parent = workspace.Effects
                u13(v17)
                _G.destroy(v17, 11)
                local u18 = script.Bubbles:Clone()
                u18.Position = u16
                u18.Parent = workspace.Effects
                _G.destroy(u18, 11.5)
                task.delay(4, function() --[[ Line: 65 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18.Bubbles.Enabled = false
                end)
                local u19 = Random.new()
                _G.PlaySound(u18, script.Sounds["VenomDemonBreath" .. u19:NextInteger(1, 2)])
                task.spawn(function() --[[ Line: 74 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u15
                        [3] = u2
                    --]]
                    for _ = 1, 4 do
                        local v20 = script.Slash:Clone()
                        local v21 = u19:NextNumber(-1.5707963267948966, 1.5707963267948966)
                        local v22 = u19:NextNumber(-1.5707963267948966, 1.5707963267948966)
                        local v23 = u19:NextNumber(-1.5707963267948966, 1.5707963267948966)
                        v20.CFrame = CFrame.new(u15.Head.Position, u15.Head.CFrame.LookVector + u15.Head.Position) * CFrame.Angles(v21, v22, v23)
                        v20.Parent = workspace.Effects
                        v20.Mesh.Scale = Vector3.new(0, 0, 0)
                        v20.Glow.Transparency = -1
                        local v24 = Random.new():NextNumber(0.75, 1.35)
                        _G.destroy(v20, 1.5)
                        u2:Create(v20, TweenInfo.new(0.7 * v24), {
                            ["CFrame"] = v20.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                        }):Play()
                        u2:Create(v20.Mesh, TweenInfo.new(0.6 * v24), {
                            ["Scale"] = Vector3.new(33.88275, 34.09175, 33.88275)
                        }):Play()
                        u2:Create(v20.Glow, TweenInfo.new(0.45 * v24), {
                            ["Transparency"] = 1
                        }):Play()
                        task.wait()
                    end
                end)
                local v25 = os.time()
                while os.time() - v25 < 10 do
                    task.spawn(function() --[[ Line: 95 ]]
                        --[[
                        Upvalues:
                            [1] = u16
                            [2] = u19
                        --]]
                        local v26 = Instance.new("Part")
                        local v27 = u16 + Vector3.new(1, 0.2, 1) * u19:NextUnitVector() * u19:NextNumber(1, 100)
                        local v28 = Color3.fromRGB(255, 87, 87)
                        v26.Size = Vector3.new(0, 0, 0)
                        v26.Position = v27
                        v26.Anchored = true
                        v26.CanCollide = false
                        v26.Color = v28
                        v26.Material = Enum.Material.ForceField
                        local v29 = Enum.PartType.Ball
                        v26.CastShadow = false
                        v26.Shape = v29
                        v26.Parent = workspace.Effects
                        v26.Transparency = -1
                        _G.tween(v26, { 0.6, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = Vector3.new(4, 4, 4),
                            ["Transparency"] = 1
                        })
                        _G.destroy(v26, 0.6)
                    end)
                    task.wait(0.05)
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