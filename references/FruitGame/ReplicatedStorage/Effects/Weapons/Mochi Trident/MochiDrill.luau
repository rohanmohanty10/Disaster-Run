 

local v1 = {}
game:GetService("Debris")
game:GetService("TweenService")
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.BoatTween)
Random.new()
local function u6(p3, p4) --[[ Line: 11 ]]
    for _, v5 in ipairs(p3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            v5.Enabled = p4
        end
    end
end
function v1.start(_, u7, p8, p9) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
    --]]
    local v10 = p9.isMochiFruit == true
    local u11 = script
    local u12 = p9.hakiColor
    if p8 == "Startup" then
        local v13, v14, v15 = _G.getRayFloor(u7.PrimaryPart.CFrame, 6)
        local v16
        if v10 then
            v16 = u11.StartupDough:Clone()
        else
            v16 = u11.Startup:Clone()
        end
        v16.CFrame = u7.PrimaryPart.CFrame
        _G.PlayEffect("3SSRecolor", nil, v16, u12, "isRed", Color3.fromRGB(255, 0, 0))
        if v13 == nil then
            v16.groundVFX:Destroy()
        else
            _G.recolorParticles(v16.groundVFX, v13.Color)
            v16.groundVFX.WorldCFrame = CFrame.new(v14, v14 + v15) * CFrame.Angles(-1.5725416560468908, 0, 0) * CFrame.new(0, 0.1, 0)
        end
        v16.Parent = workspace.Effects
        _G.customEmit(v16)
        _G.destroy(v16, 3)
        _G.PlaySound(u7.PrimaryPart, script.skill1_cast).Parent = u7.PrimaryPart
    end
    if p8 ~= "Start" then
        if p8 == "Bash" then
            local u17 = u7.PrimaryPart
            if u17 ~= nil then
                local u18, _, _ = _G.getRayFloor(u7.PrimaryPart.CFrame, 6)
                task.delay(p9.BashTime - workspace:GetServerTimeNow(), function() --[[ Line: 162 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                        [2] = u17
                        [3] = u12
                        [4] = u18
                    --]]
                    local v19 = u11.Bash:Clone()
                    v19.CFrame = u17.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(4.71238898038469, 0, 0)
                    _G.PlayEffect("3SSRecolor", nil, v19, u12, "isRed", Color3.fromRGB(255, 0, 0))
                    if u18 == nil then
                        v19.Smoke:Destroy()
                    else
                        local v20, v21, v22 = _G.getRayFloor(v19.Smoke.WorldCFrame + Vector3.new(0, 1, 0), 6)
                        if v20 then
                            v19.Smoke.WorldCFrame = CFrame.new(v21, v21 + v22) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                        end
                        _G.recolorParticles(v19.Smoke, u18.Color)
                    end
                    v19.Parent = workspace.Effects
                    _G.customEmit(v19)
                    _G.destroy(v19, 3)
                    _G.PlaySound(u17, script.skill1_punchfollowup)
                end)
                task.delay(p9.HeavyBashTime - workspace:GetServerTimeNow(), function() --[[ Line: 185 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                        [2] = u17
                        [3] = u12
                        [4] = u18
                        [5] = u2
                    --]]
                    local v23 = u11.HeavyBash:Clone()
                    v23.CFrame = u17.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(4.71238898038469, 0, 0)
                    _G.PlayEffect("3SSRecolor", nil, v23, u12, "isRed", Color3.fromRGB(255, 0, 0))
                    if u18 == nil then
                        v23.Smoke:Destroy()
                    else
                        local v24, v25, v26 = _G.getRayFloor(v23.Smoke.WorldCFrame + Vector3.new(0, 1, 0), 6)
                        if v24 then
                            v23.Smoke.WorldCFrame = CFrame.new(v25, v25 + v26) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                        end
                        _G.recolorParticles(v23.Smoke, u18.Color)
                    end
                    v23.Parent = workspace.Effects
                    _G.customEmit(v23)
                    _G.destroy(v23, 3)
                    local v27 = u11.Circle:Clone()
                    local v28 = v23.CFrame
                    local v29 = CFrame.Angles
                    local v30 = math.random(-360, 360)
                    v27.CFrame = v28 * v29(0, math.rad(v30), 0)
                    v27.Parent = workspace.Effects
                    u2:Create(v27, {
                        ["EasingStyle"] = "Circular",
                        ["EasingDirection"] = "Out",
                        ["Time"] = 0.8,
                        ["Goal"] = {
                            ["Size"] = Vector3.new(17, 30, 17),
                            ["Transparency"] = 1,
                            ["CFrame"] = v27.CFrame * CFrame.new(0, 6, 0) * CFrame.Angles(0, 1.2217304763960306, 0)
                        }
                    }):Play()
                    _G.destroy(v27, 0.8)
                end)
            end
        else
            if p8 == "Swing" then
                local v31 = u7.PrimaryPart
                if not v31 then
                    return
                end
                local v32 = u7:FindFirstChild(script.Parent.Name .. "Sword")
                if v32 then
                    local v33 = script.BladeAura:GetChildren()
                    for v34 = 1, #v33 do
                        local v35 = v33[v34]:Clone()
                        _G.PlayEffect("3SSRecolor", nil, v35, u12, "isRed", Color3.fromRGB(255, 0, 0))
                        v35.Parent = v32.Blade
                        _G.customEmit(v35)
                        _G.destroy(v35, 3)
                    end
                end
                local v36 = u11.Pierce:Clone()
                v36.CFrame = v31.CFrame * CFrame.new(0, 0, -7) * CFrame.Angles(0, 4.71238898038469, 0)
                v36.Parent = workspace.Effects
                u2:Create(v36, {
                    ["EasingStyle"] = "Sharp",
                    ["EasingDirection"] = "Out",
                    ["Time"] = 0.1,
                    ["Goal"] = {
                        ["Size"] = Vector3.new(20, 0, 0)
                    }
                }):Play()
                _G.destroy(v36, 0.1)
                local v37 = u11.PierceVFX:Clone()
                v37.CFrame = v31.CFrame * CFrame.new(0.5, 0, -3)
                v37.Parent = workspace.Effects
                _G.customEmit(v37)
                _G.destroy(v37, 3)
                _G.PlaySound(u7.PrimaryPart, script.skill1_swing).Parent = u7.PrimaryPart
            end
            return
        end
    end
    local v38 = Instance.new("Folder")
    v38.Parent = workspace.Effects
    local u39 = u7:WaitForChild("HumanoidRootPart")
    u7:WaitForChild("Humanoid")
    local v40
    if v10 then
        v40 = u11.ArmVFXDough:Clone()
    else
        v40 = u11.ArmVFX:Clone()
    end
    v40.Weld.Part1 = u7:WaitForChild("RightLowerArm")
    v40.Parent = v38
    local v41
    if v10 then
        v41 = u11.BarrageDough:Clone()
    else
        v41 = u11.Barrage:Clone()
    end
    v41.CFrame = u39.CFrame * CFrame.new(0, 0, -8)
    v41.Parent = v38
    u6(v41, true)
    u6(v40, true)
    _G.PlayEffect("3SSRecolor", nil, v40, u12, "isRed", Color3.fromRGB(255, 0, 0))
    _G.PlayEffect("3SSRecolor", nil, v41, u12, "isRed", Color3.fromRGB(255, 0, 0))
    local v42 = tick()
    local v43 = u11.Wind:Clone()
    v43.CFrame = u39.CFrame * CFrame.new(0, -3, 0)
    local v44, v45, _ = _G.getRayFloor(u39.CFrame, 6)
    if v44 then
        local v46 = v43.Position.X
        local v47 = v45.Y + 0.5
        local v48 = v43.Position.Z
        v43.Position = Vector3.new(v46, v47, v48)
    end
    v43.Parent = v38
    task.delay(p9.BarrageEnd - workspace:GetServerTimeNow() + 0.06, function() --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u7
            [3] = u12
            [4] = u39
        --]]
        local v49 = u11.HakiEnchant:Clone()
        v49.CFrame = u7.LeftLowerArm.CFrame
        v49.Weld.Part1 = u7.LeftLowerArm
        _G.PlayEffect("3SSRecolor", nil, v49, u12, "isRed", Color3.fromRGB(255, 0, 0))
        v49.Parent = workspace.Effects
        _G.customEmit(v49)
        _G.destroy(v49, 3)
        _G.PlaySound(u39, script.skill1_haki)
    end)
    while true do
        if tick() - v42 >= 0.1 then
            local v50 = u11.mesh2:Clone()
            v41.CFrame = u39.CFrame * CFrame.new(0, 0, -8)
            v50.Parent = v38
            v50.CFrame = u39.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
            u2:Create(v50.Mesh, {
                ["EasingStyle"] = "Sine",
                ["EasingDirection"] = "Out",
                ["Time"] = 0.12,
                ["Goal"] = {
                    ["Scale"] = Vector3.new(0, 25, 0)
                }
            }):Play()
            _G.destroy(v50, 0.14)
            v42 = tick()
        end
        if p9.BarrageEnd - workspace:GetServerTimeNow() <= 0 then
            u6(v41, false)
            u6(v40, false)
            u6(v43, false)
            _G.destroy(v38, 5)
            return
        end
        task.wait()
    end
end
return v1