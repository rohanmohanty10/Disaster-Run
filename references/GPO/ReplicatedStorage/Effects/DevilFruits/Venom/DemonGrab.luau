 

local v1 = {}
game:GetService("RunService")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
local _ = script.Parent.Puddles.Red
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
function v1.start(_, p11) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p11.PrimaryPart.Position) then
        if p11 then
            if p11:FindFirstChild("VenomDemonModel") then
                local u12 = p11:FindFirstChild("VenomDemonModel")
                _G.PlaySound(u12.PrimaryPart, script.start)
                task.delay(0.75, function() --[[ Line: 104 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u2
                    --]]
                    task.delay(0.6, function() --[[ Line: 105 ]]
                        --[[
                        Upvalues:
                            [1] = u12
                        --]]
                        _G.PlaySound(u12.PrimaryPart, script.boom)
                    end)
                    task.wait(0.45)
                    task.wait(0.5)
                    local u13 = script.RedDemonGrab:Clone()
                    u13.Parent = workspace.Effects
                    u13.CFrame = u12.PrimaryPart.CFrame * CFrame.new(0, -5, -4)
                    _G.customEmit(u13.Attachment)
                    _G.PlaySound(u12.PrimaryPart, script.absorb)
                    task.spawn(function() --[[ Line: 118 ]]
                        --[[
                        Upvalues:
                            [1] = u13
                        --]]
                        task.wait(0.45999999999999996)
                        for _, v14 in u13.Attachment:GetChildren() do
                            v14.Enabled = false
                        end
                    end)
                    task.wait(0.6599999999999999)
                    local u15 = u13.Emitter2
                    coroutine.wrap(function() --[[ Line: 85 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                        --]]
                        for _, v16 in pairs(u15:GetChildren()) do
                            if v16:IsA("ParticleEmitter") then
                                _G.customEmit(v16)
                            end
                        end
                    end)()
                    task.wait(0.3)
                    coroutine.wrap(function() --[[ Line: 85 ]]
                        --[[
                        Upvalues:
                            [1] = u13
                        --]]
                        for _, v17 in pairs(u13:GetChildren()) do
                            if v17:IsA("ParticleEmitter") then
                                _G.customEmit(v17)
                            end
                        end
                    end)()
                    local u18 = u13.Emitters
                    coroutine.wrap(function() --[[ Line: 85 ]]
                        --[[
                        Upvalues:
                            [1] = u18
                        --]]
                        for _, v19 in pairs(u18:GetChildren()) do
                            if v19:IsA("ParticleEmitter") then
                                _G.customEmit(v19)
                            end
                        end
                    end)()
                    _G.destroy(u13, 5)
                    for v20 = 1, 16 do
                        local v21 = script.Slash:Clone()
                        v21.CFrame = u12.PrimaryPart.CFrame * CFrame.new(0, -5, -5 - v20 * 2.25) * CFrame.Angles(1.5707963267948966, 0, 0)
                        v21.Parent = workspace.Effects
                        v21.Mesh.Scale = Vector3.new(0, 0, 0)
                        u2:Create(v21, TweenInfo.new(0.6), {
                            ["CFrame"] = v21.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
                        }):Play()
                        u2:Create(v21.Mesh, TweenInfo.new(0.55), {
                            ["Scale"] = Vector3.new(8, 8, 8) * (v20 / 20 + 1)
                        }):Play()
                        u2:Create(v21.Glow, TweenInfo.new(0.5), {
                            ["Transparency"] = 1
                        }):Play()
                        _G.destroy(v21, 0.5)
                        task.wait()
                    end
                end)
            end
        else
            return
        end
    else
        return
    end
end
return v1