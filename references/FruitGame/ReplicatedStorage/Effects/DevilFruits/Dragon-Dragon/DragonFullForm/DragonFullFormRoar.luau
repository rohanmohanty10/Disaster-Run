 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local v3 = {}
require(script.Parent.Parent.SharedForms.DragonLightningStrikeEffect)
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4.Modules.BezierFormula)
local u6 = CFrame.new(0, 0, -0)
local u7 = CFrame.new(0, 0, -0)
function v3.start(_, p8, p9, u10, p11) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u2
        [4] = u1
        [5] = u5
    --]]
    local u12 = Random.new()
    local v13 = workspace:GetServerTimeNow() - p11
    local u14 = p9:FindFirstChild("LowerJaw_3", true)
    local v15 = u14.WorldCFrame * u6
    local u16 = p9.AnimationController:LoadAnimation(script.Animation)
    u16:Play()
    task.delay(4, function() --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        u16:Stop()
    end)
    local u17
    if u10 == true then
        u17 = script.InhaleFire:Clone()
    else
        u17 = script.Inhale:Clone()
    end
    u17.CFrame = u14.WorldCFrame * u7
    u17.Parent = workspace.Effects
    if u10 == true then
        _G.PlaySound(p8.PrimaryPart, script.Normal.DragonFlameFullRoarStart).Parent = p8.PrimaryPart
    else
        _G.PlaySound(p8.PrimaryPart, script.Normal.DragonFullRoarStart).Parent = p8.PrimaryPart
    end
    local v18 = u2.RenderStepped:Connect(function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u14
            [3] = u7
        --]]
        u17.CFrame = u14.WorldCFrame * u7
    end)
    for _, u19 in u17:GetDescendants() do
        if u19:IsA("Beam") then
            local u20 = Instance.new("NumberValue")
            u20.Value = 1
            u1:Create(u20, TweenInfo.new(0.5), {
                ["Value"] = 0.75
            }):Play()
            u20.Changed:Connect(function() --[[ Line: 61 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u20
                --]]
                u19.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, u20.Value), NumberSequenceKeypoint.new(1, 1) })
            end)
        end
    end
    task.spawn(function() --[[ Line: 71 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u7
            [3] = u12
            [4] = u10
            [5] = u2
            [6] = u5
        --]]
        local v21 = os.clock()
        local v22 = 0
        while os.clock() - v21 < 0.785 do
            local v23 = task.wait(0.016666666666666666)
            local v24 = (os.clock() - v21) / 0.785
            v22 = v22 + v23 * (math.clamp(v24, 0, 1) * 21 + 24)
            while v22 >= 1 do
                v22 = v22 - 1
                local v25 = CFrame.new(u14.WorldPosition) * u7
                local v26 = CFrame.Angles
                local v27 = u12:NextNumber(-360, 360)
                local v28 = math.rad(v27)
                local v29 = u12:NextNumber(-360, 360)
                local v30 = math.rad(v29)
                local v31 = u12:NextNumber(-360, 360)
                local u32 = v25 * v26(v28, v30, (math.rad(v31))) * CFrame.new(0, 0, -u12:NextNumber(40, 75))
                local u33 = (CFrame.lookAt(u32.Position:Lerp(v25.Position, 0.25), v25.Position) * CFrame.new(u12:NextNumber(-70, 70), u12:NextNumber(-70, 70), u12:NextNumber(-70, 70))).Position
                local u34 = 0
                local u35 = u12:NextNumber(4, 8)
                local u36
                if u10 == true then
                    u36 = script.WindFire:Clone()
                    u36.CFrame = u32
                    u36.Parent = workspace.Effects
                else
                    u36 = script.WindLightning:Clone()
                    u36.CFrame = u32
                    u36.Parent = workspace.Effects
                end
                local u37 = nil
                u37 = u2.RenderStepped:Connect(function(p38) --[[ Line: 105 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                        [2] = u35
                        [3] = u14
                        [4] = u7
                        [5] = u32
                        [6] = u33
                        [7] = u5
                        [8] = u36
                        [9] = u37
                    --]]
                    u34 = u34 + p38 * u35
                    local v39 = (CFrame.new(u14.WorldPosition) * u7).Position
                    local v40 = u32.Position
                    local v41 = u33
                    local v42 = u34
                    local v43 = math.clamp(v42, 0, 1)
                    local v44 = u34 + 0.008333333333333333
                    local v45 = math.clamp(v44, 0, 1)
                    local v46 = u5.QuadBezier(v43, v40, v41, v39)
                    if u34 >= 1 then
                        _G.destroy(u36, 2)
                        u37:Disconnect()
                        u37 = nil
                    else
                        local v47 = u5.QuadBezier(v45, v40, v41, v39)
                        u36.CFrame = CFrame.new(v46, v47)
                    end
                end)
            end
        end
    end)
    task.spawn(function() --[[ Line: 130 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u7
            [3] = u12
            [4] = u2
        --]]
        local v48 = os.clock()
        while os.clock() - v48 < 0.785 do
            local v49 = (CFrame.new(u14.WorldPosition) * u7).Position
            local v50 = u12:NextNumber(-75, 75)
            local v51 = u12:NextNumber(-75, 75)
            local v52 = u12
            local u53 = Vector3.new(v50, v51, v52:NextNumber(-75, 75))
            local u54 = script.Wind:Clone()
            u54.CFrame = CFrame.new(u53 + v49, v49)
            u54.Parent = workspace.Effects
            local u55 = nil
            local v56 = u12:NextNumber(-15, 15)
            local v57 = u12:NextNumber(-15, 15)
            local u58 = Vector3.new(v56, v57, 0)
            local u59 = u12:NextNumber(0.1, 0.2)
            local u60 = 0
            u55 = u2.RenderStepped:Connect(function(p61) --[[ Line: 147 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u55
                    [3] = u54
                    [4] = u59
                    [5] = u14
                    [6] = u7
                    [7] = u53
                    [8] = u58
                --]]
                if u60 >= 1 then
                    u55:Disconnect()
                    u55 = nil
                    _G.destroy(u54, 2)
                else
                    u60 = u60 + p61 / u59
                    local v62 = (CFrame.new(u14.WorldPosition) * u7).Position
                    local v63 = u53 + v62
                    local v64 = (CFrame.new(v63, v62) * CFrame.new(u58.X, u58.Y, -(v63 - v62).Magnitude / 2)).Position
                    local v65 = u60
                    local v66 = (1 - v65) ^ 2 * v63 + 2 * (1 - v65) * v65 * v64 + v65 ^ 2 * v62
                    local v67 = u60 + 0.01
                    local v68 = (1 - v67) ^ 2 * v63 + 2 * (1 - v67) * v67 * v64 + v67 ^ 2 * v62
                    u54.CFrame = CFrame.new(v66, v68)
                end
            end)
            task.wait(0.016666666666666666)
        end
    end)
    task.delay(0.65, function() --[[ Line: 173 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u1
        --]]
        for _, u69 in u17:GetDescendants() do
            if u69:IsA("ParticleEmitter") then
                u69.Enabled = false
            elseif u69:IsA("Beam") then
                local u70 = Instance.new("NumberValue")
                u70.Value = 0.75
                u1:Create(u70, TweenInfo.new(0.45), {
                    ["Value"] = 1
                }):Play()
                u70.Changed:Connect(function() --[[ Line: 183 ]]
                    --[[
                    Upvalues:
                        [1] = u69
                        [2] = u70
                    --]]
                    u69.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, u70.Value), NumberSequenceKeypoint.new(1, 1) })
                end)
            end
        end
        _G.destroy(u17, 3)
    end)
    task.delay(0.65, v18.Disconnect, v18)
    task.wait(1.3 - v13)
    if u10 == true then
        _G.PlaySound(p8.PrimaryPart, script.Normal.DragonFlameFullRoar).Parent = p8.PrimaryPart
    else
        _G.PlaySound(p8.PrimaryPart, script.Normal.DragonFullRoar).Parent = p8.PrimaryPart
    end
    local v71 = script[u10 and "FireRoar" or "Roar"]:Clone()
    v71.CFrame = v15
    v71.Parent = workspace.Effects
    local v72 = os.clock()
    os.clock()
    local v73
    if (workspace.CurrentCamera.CFrame.Position - p8.PrimaryPart.Position).Magnitude <= 400 or p8 == game.Players.LocalPlayer then
        v73 = Instance.new("ColorCorrectionEffect")
        v73.Parent = workspace.CurrentCamera
    else
        v73 = nil
    end
    if v73 then
        u1:Create(v73, TweenInfo.new(0.85), {
            ["Brightness"] = -0.125,
            ["Contrast"] = 0.25,
            ["Saturation"] = -0.15
        }):Play()
    end
    u6 = CFrame.new(0, -2, 5)
    local v74 = 0
    while os.clock() - v72 <= 2.5 do
        v71.CFrame = u14.WorldCFrame * u6
        if tick() - v74 >= 0.025 then
            local v75 = v71.CFrame
            local v76 = CFrame.Angles
            local v77 = math.random(0, 360)
            local v78 = math.rad(v77)
            local v79 = math.random(0, 360)
            local v80 = math.rad(v79)
            local v81 = math.random(0, 360)
            local v82 = v75 * v76(v78, v80, (math.rad(v81)))
            _G.PlayEffect("CustomAirTrail", nil, {
                ["Direction"] = v82.LookVector,
                ["Position"] = v82.Position,
                ["Color"] = u10 == true and script.WindFire.Trail.Color or script.WindLightning.Trail.Color,
                ["Brightness"] = u10 == true and 5 or 4,
                ["Speed"] = math.random(100, 200),
                ["Width"] = math.random(500, 1000) / 10,
                ["Texture"] = "rbxassetid://9169424761",
                ["Duration"] = u12:NextNumber(0.25, 0.5),
                ["Amplitude"] = u12:NextNumber(50, 100),
                ["LightEmission"] = 1,
                ["startSmallPercent"] = 0.1
            })
            v74 = tick()
        end
        u2.RenderStepped:Wait()
    end
    if v73 then
        u1:Create(v73, TweenInfo.new(0.5), {
            ["Brightness"] = 0,
            ["Saturation"] = 0,
            ["Contrast"] = 0
        }):Play()
        _G.destroy(v73, 0.5)
    end
    _G.particleEnabled(v71, false)
    _G.destroy(v71, 2.5)
end
return v3