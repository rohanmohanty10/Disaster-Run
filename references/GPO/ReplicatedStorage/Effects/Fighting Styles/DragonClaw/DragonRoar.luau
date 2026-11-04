 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = require(script.Parent.WindEmitter)
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
local _ = workspace.CurrentCamera
local _ = Enum.RenderPriority.Camera.Value + 1
Random.new()
return {
    ["start"] = function(_, p4, u5) --[[ Name: start, Line 18 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
        --]]
        if _G.checkRenderDistance(p4.PrimaryPart.Position) ~= false then
            local u6 = p4.HumanoidRootPart
            local _ = u6.CFrame * CFrame.new(0, 0, 0)
            _G.PlaySound(u6, script.DragonPunchStart)
            task.wait(0.08333333333333333)
            local v7 = require(script.Parent.ChargeEffect)(p4.RightHand, u5, 3, 15, 8)
            task.wait(0.25)
            v7.flash:Emit(3)
            v7.flash2:Emit(3)
            task.wait(0.3333333333333333)
            local u8 = u6.CFrame
            _G.PlaySound(u6, script.DragonPunchA)
            _G.PlaySound(u6, script.DragonPunchHit)
            local u9 = script.Shockwave:Clone()
            u9.CFrame = u8 * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
            local u10 = u3.new(u9, u9, {
                ["lifetime"] = NumberRange.new(0.4, 0.6),
                ["rate"] = 0,
                ["scale"] = 2,
                ["scaleEnvelope"] = 1,
                ["acceleration"] = Vector3.new(0, 3, 0),
                ["accelerationEnvelope"] = Vector3.new(0, 3, 0),
                ["goalTransparency"] = u9.Decal.Transparency
            })
            u10:Emit(6)
            task.delay(0.2, function() --[[ Line: 47 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u10
                --]]
                local v11 = u9
                v11.CFrame = v11.CFrame * CFrame.new(0, -10, 0)
                u10.acceleration = Vector3.new(0, -3, 0)
                u10.scale = 1.5
                u10:Emit(5)
                u9:Destroy()
            end)
            local v12 = script.HeadNeon:Clone()
            local v13 = script.HeadForcefield:Clone()
            v12.Parent = workspace.Effects
            v13.Parent = workspace.Effects
            if not u5 then
                v12.Color = Color3.fromRGB(255, 255, 255)
            end
            local v14 = u8 * CFrame.new(0, 0, -10)
            local v15 = v12.Size * 1.75
            v12.CFrame = u8
            v13.CFrame = u8
            local v16 = { 0.6, "Quint", Enum.EasingDirection.Out }
            _G.tween(v12, v16, {
                ["CFrame"] = v14,
                ["Size"] = v15
            })
            _G.tween(v13, v16, {
                ["CFrame"] = v14,
                ["Size"] = v15 + Vector3.new(1, 1, 1)
            })
            _G.tween(v12, { 0.4, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.tween(v13, { 0.6, "Quad", Enum.EasingDirection.InOut }, {
                ["Transparency"] = 1
            })
            _G.destroy(v12, 1)
            _G.destroy(v13, 1)
            local v17 = script.Rush:Clone()
            if not u5 then
                v17.Decal.Color3 = Color3.new(500, 500, 500)
            end
            v17.Parent = workspace.Effects
            v17.CFrame = u8 * CFrame.new(0, -1, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
            _G.tween(v17, { 0.6, "Quint", Enum.EasingDirection.Out }, {
                ["CFrame"] = v14 * CFrame.new(0, -1, -4) * CFrame.Angles(1.5707963267948966, 0, 0)
            })
            _G.tween(v17.Mesh, { 0.6, "Quint", Enum.EasingDirection.Out }, {
                ["Scale"] = v17.Mesh.Scale * Vector3.new(2, 1, 2)
            })
            _G.tween(v17.Decal, { 0.4, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.destroy(v17, 1)
            local function u35(p18, u19) --[[ Line: 93 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u2
                --]]
                local u20 = script.TrailPart:Clone()
                local v21 = u20.Attachment1
                v21.Position = v21.Position + Vector3.new(10, 0, 0)
                local v22 = u20.Attachment2
                v22.Position = v22.Position + Vector3.new(10, 0, 0)
                u20.Trail.Color = ColorSequence.new(p18)
                u20.CFrame = u19
                local u23 = 0
                local u24 = u19 * CFrame.new(0, 0, -20)
                local u25 = nil
                u25 = u1.Heartbeat:Connect(function(p26) --[[ Line: 103 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u2
                        [3] = u20
                        [4] = u19
                        [5] = u24
                        [6] = u25
                    --]]
                    u23 = u23 + p26
                    local v27 = u2
                    local v28 = u23 / 0.5
                    local v29 = v27:GetValue(math.clamp(v28, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v30 = u20
                    local v31 = u19:Lerp(u24, v29)
                    local v32 = CFrame.Angles
                    local v33 = 360 * v29
                    v30.CFrame = v31 * v32(0, 0, (math.rad(v33)))
                    if u23 >= 0.5 then
                        u25:Disconnect()
                    end
                end)
                local v34 = { 0.5, "Quad", Enum.EasingDirection.In }
                u20.Parent = workspace.Effects
                _G.tween(u20.Attachment1, v34, {
                    ["Position"] = u20.Attachment1.Position - Vector3.new(10, 0, 0)
                })
                _G.tween(u20.Attachment2, v34, {
                    ["Position"] = u20.Attachment2.Position - Vector3.new(10, 0, 0)
                })
            end
            task.spawn(function() --[[ Line: 118 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u8
                    [3] = u35
                --]]
                for v36 = 1, 6 do
                    local v37 = v36 / 6 * 360
                    local v38
                    if v36 % 2 == 0 then
                        v38 = Color3.fromRGB(0, 0, 0)
                    else
                        v38 = u5 and Color3.fromRGB(255, 54, 28) or Color3.fromRGB(255, 255, 255)
                    end
                    u35(v38, u8 * CFrame.Angles(0, 0, (math.rad(v37))))
                end
            end)
            task.spawn(function() --[[ Line: 132 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u2
                    [3] = u6
                    [4] = u5
                    [5] = u3
                    [6] = u1
                --]]
                local v39 = script.Wind:Clone()
                local v40 = v39.Root
                v39.Parent = workspace.Effects
                v40.CFrame = u8
                u2:Create(v40, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ["CFrame"] = v40.CFrame * CFrame.new(0, 0, -12)
                }):Play()
                local v41 = script.FireParticles:Clone()
                v41.Parent = workspace.Effects
                v41.CFrame = u6.CFrame * CFrame.new(1, 0, 0)
                for _, v42 in pairs(v41:GetDescendants()) do
                    if v42:IsA("ParticleEmitter") then
                        if v42.Name ~= "Black" and not u5 then
                            v42.Color = ColorSequence.new(Color3.new(1, 1, 1))
                        end
                        _G.customEmit(v42)
                    end
                end
                _G.destroy(v41, 2)
                local u43 = {}
                for _, v44 in pairs(v39:GetChildren()) do
                    if v44.Name == "3" and not u5 then
                        v44.Decal.Color3 = Color3.fromRGB(1000, 1000, 1000)
                    end
                    if v44.Name ~= "Root" then
                        u43[v44] = u3.new(v44, v44, {
                            ["lifetime"] = NumberRange.new(0.4, 0.6),
                            ["rate"] = 0.02,
                            ["scale"] = 0.25,
                            ["acceleration"] = Vector3.new(0, -3, 0),
                            ["accelerationEnvelope"] = Vector3.new(0, 1, 0),
                            ["goalTransparency"] = v44.Decal.Transparency
                        })
                        v44.Decal.Transparency = 1
                        u43[v44]:Enable()
                    end
                end
                local u45 = 0
                local v48 = u1.Heartbeat:Connect(function(p46) --[[ Line: 177 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u2
                        [3] = u45
                    --]]
                    for _, v47 in pairs(u43) do
                        v47.scale = u2:GetValue(u45 / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 1 + 1
                    end
                    u45 = u45 + p46
                end)
                task.wait(0.1)
                for v49, v50 in pairs(u43) do
                    v50:Destroy()
                    u43[v49] = nil
                    v48:Disconnect()
                end
            end)
        end
    end
}