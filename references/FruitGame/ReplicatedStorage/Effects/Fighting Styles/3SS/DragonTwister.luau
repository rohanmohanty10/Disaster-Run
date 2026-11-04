 

local v1 = {}
game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("Debris")
game:GetService("Workspace")
local u2 = script.Move4
local _ = u2.Anims
local function u5(p3) --[[ Line: 22 ]]
    for _, v4 in ipairs(p3:GetDescendants()) do
        if v4:IsA("ParticleEmitter") then
            v4:Emit(v4:GetAttribute("EmitCount") or 0)
        end
    end
end
local function u9(p6, p7) --[[ Line: 30 ]]
    for _, v8 in ipairs(p6:GetDescendants()) do
        if v8:IsA("ParticleEmitter") then
            v8.Enabled = p7
        end
    end
end
local function u13(p10, p11, p12) --[[ Line: 47 ]]
    _G.tween(p10, {
        0.45,
        "Quad",
        p12,
        0,
        false,
        0
    }, {
        ["Transparency"] = p11
    })
end
function v1.start(_, u14, p15) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u9
        [4] = u13
    --]]
    if u14 ~= nil then
        local v16
        if u14 then
            v16 = u14.PrimaryPart
        else
            v16 = u14
        end
        if v16 ~= nil then
            if _G.checkRenderDistance(u14.PrimaryPart.Position) ~= false then
                local u17 = Instance.new("Folder")
                u17.Parent = workspace.Effects
                local u18 = u14:WaitForChild("HumanoidRootPart")
                u14:WaitForChild("Humanoid")
                local v19 = u2.BottomVFX:Clone()
                local u20 = u2.Tornado:Clone()
                local v21 = u2.Chargup:Clone()
                task.wait(0.283 / p15)
                v19.CFrame = u18.CFrame
                v21.CFrame = u18.CFrame * CFrame.new(0, -3, 0)
                v19.Parent = u17
                v21.Parent = u17
                _G.customWeld(v19, u14.PrimaryPart, CFrame.new(), v19)
                _G.customWeld(v21, u14.PrimaryPart, CFrame.new(0, -3, 0), v21)
                u5(v19)
                u9(v21, true)
                task.wait(0.8340000000000001 / p15)
                u9(v21, false)
                u20.Parent = u17
                u13(u20.Twist, 0.5)
                for _, v22 in ipairs(u20:GetDescendants()) do
                    if v22:IsA("Decal") then
                        u13(v22, 0.65, "In")
                    end
                end
                local u23 = Instance.new("BoolValue")
                u23.Parent = u14
                task.spawn(function() --[[ Line: 97 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u23
                    --]]
                    require(script.TornadoRockModule):startTornado(u14.PrimaryPart, u23)
                end)
                u9(u20, true)
                local v24 = script["3ssTatsumakiLoop"]:Clone()
                v24.Parent = u14.PrimaryPart
                v24:Play()
                local u25 = tick()
                local u26 = 0
                task.spawn(function() --[[ Line: 109 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u14
                        [3] = u2
                        [4] = u20
                    --]]
                    while true do
                        local _ = tick() - u25
                        if u14:GetAttribute("DragonTwisterSpinning") == nil then
                            break
                        end
                        task.wait(0.3)
                        local v27 = u2.Beams:Clone()
                        v27.Parent = u20
                        v27.CFrame = u20.PrimaryPart.CFrame
                        for _, v28 in ipairs(v27.Beams:GetChildren()) do
                            if v28:IsA("Beam") then
                                local v29 = {
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                }
                                _G.tween(v28, {
                                    0.45,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, v29)
                            end
                        end
                        local v30 = _G.tween
                        local v31 = {
                            0.7,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }
                        local v32 = {
                            ["CFrame"] = v27.CFrame * CFrame.new(0, 17, 0) * CFrame.Angles(0, 2.6179938779914944, 0)
                        }
                        v30(v27, v31, v32)
                        _G.destroy(v27, 0.7)
                    end
                end)
                local u35 = game["Run Service"].RenderStepped:Connect(function(p33) --[[ Line: 135 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                        [2] = u20
                        [3] = u18
                    --]]
                    u26 = u26 + 500 * p33
                    local v34 = u26
                    u20:PivotTo(u18.CFrame * CFrame.new(0, 4.5, 0) * CFrame.Angles(0, math.rad(v34), 0))
                end)
                local v36 = _G.PlaySound(u14.PrimaryPart, script["Audio/3ssTatsumakiLaunch"])
                v36.Parent = u14.PrimaryPart
                while u14:GetAttribute("DragonTwisterSpinning") ~= nil do
                    local v37, v38, _ = _G.getRayFloor(u14.PrimaryPart.CFrame, 8)
                    if v37 then
                        u20.VFX.SmokeEnab.WorldCFrame = CFrame.new(v38)
                    else
                        local v39 = u20.VFX.SmokeEnab
                        local v40 = u14.PrimaryPart.Position
                        local v41 = u14.PrimaryPart.Size.Y
                        v39.WorldPosition = v40 - Vector3.new(0, v41, 0)
                    end
                    task.wait()
                end
                for _, v42 in ipairs(u20:GetDescendants()) do
                    if v42:IsA("Decal") or v42:IsA("Part") then
                        u13(v42, 1.25, "Out")
                    end
                end
                u9(u20, false)
                u23:Destroy()
                _G.tween(v24, {
                    0.25,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v24, 0.25)
                if v36 then
                    _G.tween(v36, {
                        0.25,
                        "EntranceProductive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Volume"] = 0
                    })
                    _G.destroy(v36, 0.25)
                end
                task.delay(1.5, function() --[[ Line: 169 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u17
                    --]]
                    u35:Disconnect()
                    u35 = nil
                    u17:Destroy()
                end)
            end
        end
    end
end
return v1