 

local v1 = {}
game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
require(script.Parent.VenomSplash)
local u2 = script.Animations
game.Players.LocalPlayer:GetMouse()
function PlayAnim(p3, p4)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = (p3:FindFirstChild("Humanoid") or p3:FindFirstChild("AnimationController")).Animator:LoadAnimation(u2[p4])
    v5:Play(0, 1, 2)
    return v5
end
function v1.start(_, u6) --[[ Line: 61 ]]
    if _G.checkRenderDistance(u6.PrimaryPart.Position) then
        if u6 then
            if u6:FindFirstChild("VenomDemonModel") then
                local v7 = u6:FindFirstChild("VenomDemonModel")
                local u8 = Random.new()
                task.wait(0.15)
                if u6 == game.Players.LocalPlayer.Character then
                    local v9 = Instance.new("LinearVelocity")
                    v9.VectorVelocity = Vector3.new(0, 0, -120)
                    v9.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
                    v9.Attachment0 = u6.PrimaryPart.RootRigAttachment
                    v9.MaxForce = 100000
                    v9.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
                    v9.Parent = u6
                    _G.destroy(v9, 0.5)
                end
                local u10 = script.Particles:Clone()
                u10.CFrame = u6.PrimaryPart.CFrame
                u10.Parent = workspace.Effects
                local u11 = Instance.new("WeldConstraint")
                local v12 = v7.PrimaryPart
                u11.Parent = u10
                u11.Part0 = u10
                u11.Part1 = v12
                _G.destroy(u10, 1.5)
                task.delay(0.5, function() --[[ Line: 94 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u11
                    --]]
                    for _, v13 in u10:GetDescendants() do
                        if v13:IsA("ParticleEmitter") then
                            v13.Enabled = false
                        end
                    end
                    u10.Anchored = true
                    u11:Destroy()
                end)
                task.spawn(function() --[[ Line: 113 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u8
                    --]]
                    for _ = 1, 5 do
                        local v14 = script.BeanWind:Clone()
                        v14.CFrame = u6.PrimaryPart.CFrame * CFrame.new(0, u8:NextNumber(-3.141592653589793, 3.141592653589793), -10) * CFrame.Angles(1.5707963267948966, 0, 0)
                        v14.Parent = workspace.Effects
                        v14.Mesh.Scale = Vector3.new(0, 0, 0)
                        local v15 = u8:NextNumber(0.3, 0.5)
                        _G.tween(v14, { v15, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["CFrame"] = v14.CFrame * CFrame.Angles(0, u8:NextNumber(-3.141592653589793, 3.141592653589793), 0)
                        })
                        _G.tween(v14.Decal, { v15, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        _G.tween(v14.Mesh, { v15, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(12.956, 149.553, 12.956)
                        })
                        local v16 = script.RedWind:Clone()
                        v16.CFrame = u6.PrimaryPart.CFrame * CFrame.new(0, u8:NextNumber(-3.141592653589793, 3.141592653589793), -10) * CFrame.Angles(1.5707963267948966, 0, 0)
                        v16.Parent = workspace.Effects
                        v16.Mesh.Scale = Vector3.new(0, 0, 0)
                        local v17 = u8:NextNumber(0.5, 0.75)
                        _G.tween(v16, { v17, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["CFrame"] = v16.CFrame * CFrame.Angles(0, u8:NextNumber(-3.141592653589793, 3.141592653589793), 0)
                        })
                        _G.tween(v16.Decal, { v17 + 0.1, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        _G.tween(v16.Mesh, { v17, "EntranceExpressive", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(12.956, 40.553, 12.956)
                        })
                        _G.destroy(v16, v17 + 0.1)
                        _G.destroy(v14, v17)
                        task.wait(0.1)
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