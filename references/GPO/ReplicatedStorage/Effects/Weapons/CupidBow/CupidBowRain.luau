 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4.Modules.Client.WeaponVFXRecolor)
Random.new()
local v6 = RaycastParams.new()
v6.FilterType = Enum.RaycastFilterType.Include
v6.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, p7) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u2
    --]]
    local v8 = p7.startCFrame
    local u9 = p7.targetPosition
    local u10 = p7.arrowData
    local v11 = p7.shootTime
    local u12 = p7.areaRadius
    local u13 = p7.height
    local v14 = p7.prestige
    local v15 = p7.isSkill
    local u16 = p7.char
    local u17 = script.Normal
    if v14 == true then
        u17 = script.Blessed
    end
    local u18 = v11 - workspace:GetServerTimeNow()
    local u19 = v8.Position
    local u20 = u9 + Vector3.new(0, u13, 0)
    local u21 = (u19 + u20) / 2 + Vector3.new(0, 40, 0)
    if v15 == true then
        local u22 = u17.Arrow:Clone()
        u5.apply(u22, u16)
        local u23 = tick()
        local u24 = nil
        u24 = u3.Heartbeat:Connect(function() --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u18
                [3] = u19
                [4] = u21
                [5] = u20
                [6] = u24
                [7] = u22
            --]]
            local v25 = (tick() - u23) / u18
            local v26 = math.clamp(v25, 0, 1)
            local u27 = (1 - v26) ^ 2 * u19 + (1 - v26) * 2 * v26 * u21 + v26 ^ 2 * u20
            if v26 >= 1 then
                u24:Disconnect()
                u24 = nil
                return
            else
                local v28 = v26 + 0.01
                local v29 = math.clamp(v28, 0, 1)
                local u30 = ((1 - v29) ^ 2 * u19 + (1 - v29) * 2 * v29 * u21 + v29 ^ 2 * u20 - u27).Unit
                local v31, _ = pcall(function() --[[ Line: 29 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                        [2] = u27
                        [3] = u30
                    --]]
                    u22.CFrame = CFrame.lookAt(u27, u27 + u30) * CFrame.Angles(4.71238898038469, 0, 0)
                    u22.Parent = workspace.Effects
                end)
                if not v31 then
                    u24:Disconnect()
                    u24 = nil
                end
            end
        end)
        _G.destroy(u22, u18)
    end
    _G.PlaySound(v8, script.ValentineBowBarrageShootArrowUp)
    task.wait(u18)
    task.spawn(function() --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u5
            [3] = u16
            [4] = u9
            [5] = u13
            [6] = u12
            [7] = u10
            [8] = u2
        --]]
        local v32 = u17.Cloud:Clone()
        u5.apply(v32, u16)
        v32.CFrame = CFrame.new(u9) * CFrame.new(0, u13, 0)
        local v33 = u12 * 2
        local v34 = u12 * 2
        v32.Size = Vector3.new(v33, 1, v34)
        v32.Parent = workspace.Effects
        _G.customEmit(v32)
        _G.PlaySound(v32, script.ValentineBowBarragetA)
        for _, u35 in ipairs(u10) do
            local v36 = math.random(-360, 360)
            local v37 = u35.Speed
            local u38 = u17.Arrow:Clone()
            u5.apply(u38, u16)
            u38.CFrame = CFrame.new(u35.StartPos.Position, u35.EndPos) * CFrame.Angles(4.71238898038469, math.rad(v36), 0)
            u38.Parent = workspace.Effects
            _G.destroy(u38, v37)
            local v39 = u2:Create(u38, TweenInfo.new(v37, Enum.EasingStyle.Linear), {
                ["CFrame"] = CFrame.new(u35.EndPos, u35.StartPos.Position) * CFrame.Angles(-4.71238898038469, math.rad(v36), 0)
            })
            v39:Play()
            _G.PlaySound(u38, script["ValentineBowArrow" .. math.random(1, 3)]).Parent = u38
            v39.Completed:Connect(function() --[[ Line: 107 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u17
                    [3] = u5
                    [4] = u16
                    [5] = u35
                --]]
                u38:Destroy()
                local v40 = u17.Fx:Clone()
                u5.apply(v40, u16)
                v40.CFrame = CFrame.new(u35.EndPos, u35.EndPos + u35.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                for _, v41 in ipairs(v40:GetChildren()) do
                    if v41:IsA("ParticleEmitter") then
                        v41.Color = ColorSequence.new(u35.Color)
                    end
                end
                v40.Parent = workspace.Effects
                _G.destroy(v40, 3)
                _G.customEmit(v40)
                local v42 = u17.Shockwave:Clone()
                u5.apply(v42, u16)
                v42.CFrame = CFrame.new(u35.EndPos, u35.EndPos + u35.Normal) * CFrame.Angles(-1.5707963267948966, math.random(-360, 360), 1.5707963267948966)
                v42.Parent = workspace.Effects
                _G.destroy(v42, 0.2)
                _G.tween(v42, {
                    0.2,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(6, 0, 0),
                    ["CFrame"] = v42.CFrame * CFrame.new(3, 0, 0),
                    ["Transparency"] = 1
                })
                local v43 = u17.Wind:Clone()
                u5.apply(v43, u16)
                v43.CFrame = CFrame.new(u35.EndPos, u35.EndPos + u35.Normal) * CFrame.Angles(-1.5707963267948966, math.random(-360, 360), 0)
                v43.Parent = workspace.Effects
                _G.destroy(v43, 0.6)
                local v44 = _G.tween
                local v45 = {
                    0.6,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v46 = {
                    ["Size"] = v43.Size * 3
                }
                local v47 = v43.Orientation
                local v48 = math.random(-700, 700)
                v46.Orientation = v47 + Vector3.new(0, v48, 0)
                v46.Transparency = 1
                v44(v43, v45, v46)
                _G.PlaySound(v43, script["ValentineBowGroundHit" .. math.random(1, 3)])
            end)
            task.wait(0.056)
        end
        _G.particleEnabled(v32, false)
        _G.destroy(v32, 3)
    end)
end
return v1