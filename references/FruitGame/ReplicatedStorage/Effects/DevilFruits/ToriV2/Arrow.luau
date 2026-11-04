 

local u1 = game:GetService("RunService")
local u2 = _G.Ess
Emit = _G.Emit
Tween = _G.Ess.Tween
BeamToggle = _G.Ess.BeamToggle
local u3 = require(script.Bezier)
return {
    ["start"] = function(_, p4, _) --[[ Name: start, Line 24 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u1
        --]]
        if _G.checkRenderDistance(p4.PrimaryPart.Position) ~= false then
            local u5 = {}
            local v6 = Random.new()
            local u7 = p4.PrimaryPart
            local u8 = script.Folder
            local u9 = u7.CFrame
            local u10 = script.arrow:Clone()
            table.insert(u5, u10)
            u10.CFrame = u9 * CFrame.new(0, 0, -2)
            local v11 = script.fire:Clone()
            table.insert(u5, v11)
            v11.CFrame = u9 * CFrame.new(0, 0, -3)
            v11.Parent = workspace.Effects
            for _, v12 in pairs(v11:GetDescendants()) do
                if v12:IsA("ParticleEmitter") then
                    local v13 = v12:GetAttribute("EmitDelay")
                    if v13 and v13 ~= 0 then
                        local v14 = v13 * 1.1 / v13
                        if v12.Name == "flareDissapate" then
                            v12:SetAttribute("EmitDelay", v14 - 0.01)
                        else
                            v12:SetAttribute("EmitDelay", v14)
                        end
                    end
                    if v12.Name == "sec" then
                        v12.Lifetime = NumberRange.new(1.1)
                    elseif v12.Name == "flare" then
                        v12.Lifetime = NumberRange.new(1.25)
                    end
                end
            end
            Emit(v11:GetDescendants(), true)
            task.delay(1.1, function() --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u2
                    [3] = u5
                    [4] = u7
                    [5] = u8
                    [6] = u9
                --]]
                u10.Parent = workspace.Effects
                Tween(u10, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["CFrame"] = u10.CFrame * CFrame.new(0, 0, -120)
                })
                task.delay(0.75, function() --[[ Line: 97 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u2
                        [3] = u5
                    --]]
                    for _, v15 in pairs(u10:GetDescendants()) do
                        if v15:IsA("Trail") or (v15:IsA("Beam") or v15:IsA("ParticleEmitter")) then
                            v15.Enabled = false
                        end
                    end
                    task.wait(1)
                    u2.Destroy(u5, 0)
                end)
                _G.PlaySound(u7, u8["Fire Burst 4 (SFX)"], {
                    ["TimePosition"] = 1.5
                }, true)
                _G.PlaySound(u7, u8["Whoosh Explosion 7 (SFX)"], {
                    ["TimePosition"] = 0.6
                }, true)
                local v16 = script.backDust:Clone()
                local v17 = u5
                table.insert(v17, v16)
                v16.CFrame = u9 * CFrame.new(0, -2, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                v16.Parent = workspace.Effects
                Emit(v16:GetDescendants(), true)
                local v18 = script.frontDust:Clone()
                local v19 = u5
                table.insert(v19, v18)
                v18.CFrame = u9 * CFrame.new(0, -2, 0)
                v18.Parent = workspace.Effects
                Emit(v18:GetDescendants(), true)
            end)
            local u20 = script.arrowCharge:Clone()
            table.insert(u5, u20)
            local v21 = script.diamondCharge:Clone()
            v21.CFrame = u9 * CFrame.new(0, 0, -3) + Vector3.new(0, -2.15, 0)
            u20.CFrame = v21.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
            u20.Parent = workspace.Effects
            v21.Parent = u20
            task.delay(1.1, function() --[[ Line: 215 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                local v22 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                Tween(u20.Attachment.second, v22, {
                    ["Brightness"] = 0,
                    ["Range"] = 4
                })
                Tween(u20.Attachment.first, v22, {
                    ["Brightness"] = 0,
                    ["Range"] = 15
                })
                Emit(u20:GetDescendants(), false)
            end)
            _G.PlaySound(u7, u8["Magic Whooshes Growly Magic Whooshes Airy Gu (SFX)"], nil, true)
            _G.PlaySound(u7, u8["Magic Transformation 3 (SFX)"], nil, true)
            _G.PlaySound(u7, u8["Magic Rumbling Decay 2 (SFX)"], nil, true)
            local v23 = {
                CFrame.new(),
                CFrame.new(0, 0, -10),
                CFrame.new(7, 5, -20),
                CFrame.new(0, 0, -60)
            }
            for _ = 1, 10 do
                local u24 = {}
                local u25 = script.Feather:Clone()
                table.insert(u24, u25)
                BeamToggle(u25:GetChildren(), false)
                local v26 = u9 * CFrame.new(0, 0, -3)
                local v27 = CFrame.new
                local v28 = v26 * CFrame.Angles(0, 6.283185307179586 * math.random(), 0)
                local v29 = CFrame.Angles
                local v30 = v6:NextNumber(0, 90)
                local v31 = v27((v28 * v29(math.rad(v30), 0, 0) * CFrame.new(0, 30, 0)).Position, v26.Position) * CFrame.Angles(0, 0, 3.141592653589793 * math.random())
                local v32 = v31 * v23[2]
                local v33 = v31 * v23[3]
                local u34 = tick()
                u25.CFrame = v31
                u25.Parent = workspace.Effects
                BeamToggle(u25:GetChildren(), true)
                local u35 = v31.Position
                local u36 = nil
                local u37 = u3.new(v31.Position, v32.Position, v33.Position, v26.Position)
                local u38 = #u24 + 1
                u24[u38] = u1.RenderStepped:Connect(function() --[[ Line: 273 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                        [2] = u36
                        [3] = u37
                        [4] = u25
                        [5] = u35
                        [6] = u2
                        [7] = u24
                        [8] = u38
                    --]]
                    local v39 = (tick() - u34) / 0.55
                    u36 = u37:Get(v39, 1)
                    u25.CFrame = CFrame.new(u35, u36)
                    if v39 >= 1 then
                        u2.Destroy(u24[u38], 0)
                        u2.Destroy(u24, 0.45)
                    end
                    u35 = u36
                end)
                task.wait(0.035)
            end
        end
    end
}