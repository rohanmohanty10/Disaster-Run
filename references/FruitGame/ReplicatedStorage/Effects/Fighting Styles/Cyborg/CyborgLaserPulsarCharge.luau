 

local u1 = require(script.Bezier)
local u2 = game:GetService("RunService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v4 = {}
local function u10(p5, p6) --[[ Line: 6 ]]
    local v7 = { p5 }
    for _, v8 in p5:GetDescendants() do
        table.insert(v7, v8)
    end
    for _, v9 in v7 do
        if (v9:IsA("ParticleEmitter") or (v9:IsA("BasePart") or (v9:IsA("PointLight") or (v9:IsA("Trail") or v9:IsA("Highlight"))))) and v9:GetAttribute("recolorable") then
            if v9:IsA("Trail") or v9:IsA("ParticleEmitter") then
                v9.Color = ColorSequence.new(p6)
            elseif v9:IsA("Highlight") then
                v9.FillColor = p6
                v9.OutlineColor = Color3.new(1, 1, 1)
            else
                v9.Color = p6
            end
        end
    end
    table.clear(v7)
end
function v4.start(_, u11, u12) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u1
        [4] = u2
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) ~= false then
        local u13 = script.charge:Clone()
        u10(u13, u12)
        u3.apply(u13, u11)
        u13.Parent = workspace.Effects
        local v14 = tick()
        local v15 = u11:FindFirstChild("RepulsorCharging")
        _G.customWeld(u13, u11.PrimaryPart, CFrame.new(0, 0.5, -5), v15)
        _G.PlaySound(u11.PrimaryPart, script.CyBlastStart)
        u13.CyBlastLoop:Play()
        local u16 = 1
        while u11:IsDescendantOf(workspace) and u11:FindFirstChild("RepulsorCharging") do
            local u17 = u11.PrimaryPart.CFrame * CFrame.new(0, 0.5, -5)
            if tick() - v14 > 0.3 then
                v14 = tick()
                task.spawn(function() --[[ Line: 50 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u17
                        [3] = u10
                        [4] = u12
                        [5] = u3
                        [6] = u11
                    --]]
                    u16 = u16 == 1 and 2 or 1
                    local v18 = u17
                    local v19 = CFrame.Angles
                    local v20 = math.random(0, 360)
                    local v21 = math.rad(v20)
                    local v22 = math.random(0, 360)
                    local v23 = math.rad(v22)
                    local v24 = math.random(0, 360)
                    local v25 = v18 * v19(v21, v23, (math.rad(v24)))
                    local v26 = script.trail:Clone()
                    u10(v26, u12)
                    u3.apply(v26, u11)
                    v26.CFrame = v25 * CFrame.new(0, 0, -10)
                    v26.Parent = workspace.Effects
                    for v27 = 0, 1000, 10 do
                        local v28 = (u16 == 1 and 12 or 13) - v27 / 100
                        local v29 = u16 == 1 and v27 and v27 or -v27
                        local v30 = CFrame.new
                        local v31 = math.rad(v27)
                        local v32 = v28 * math.cos(v31)
                        local v33 = math.rad(v29)
                        v26.CFrame = v25 * v30(v32, v28 * math.sin(v33), 0)
                        task.wait()
                    end
                    _G.destroy(v26, 1)
                end)
                task.spawn(function() --[[ Line: 72 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u17
                        [3] = u10
                        [4] = u12
                        [5] = u3
                        [6] = u11
                        [7] = u1
                        [8] = u2
                    --]]
                    u13.CFrame = u17
                    local v34 = script.ChargeTrail:Clone()
                    u10(v34, u12)
                    u3.apply(v34, u11)
                    local v35 = u17.Position
                    local v36 = math.random(-400, 400) / 35
                    local v37 = math.random(-300, 300) / 25
                    local v38 = math.random(-400, 400) / 35
                    v34.Position = v35 + Vector3.new(v36, v37, v38)
                    v34.Parent = workspace.Effects
                    local v39 = v34.CFrame
                    local v40 = u17.Position
                    local v41 = (v39.Position - v40).Magnitude
                    local v42 = math.random(-v41 / 12.2, v41 / 8.2)
                    local v43 = math.random(-v41 / 8, v41 / 4.6)
                    local v44 = -math.random(v41 / 8, v41)
                    local v45 = Vector3.new(v42, v43, v44)
                    local v46 = v39.Position + v39.LookVector * v41 / 12 + v45
                    local v47 = math.random(-v41 / 4.2, v41 / 8.2)
                    local v48 = math.random(-v41 / 3, v41)
                    local v49 = math.random
                    local v50 = -v41 / 7.6
                    local v51 = v41 / 4.6
                    local v52 = Vector3.new(v47, v48, v49(v50, v51))
                    local v53 = v39.Position + v39.LookVector * v41 / 7 + v52
                    local v54 = u1.new(v39.Position, v46, v53, v40)
                    local v55 = 1
                    while v55 ~= v41 do
                        local _ = v34.Position
                        local v56 = u2.Heartbeat:Wait()
                        local v57 = v55 / v41
                        local v58 = v54:Get(v57)
                        if v57 >= 1 or v34 == nil then
                            break
                        end
                        v34.CFrame = CFrame.new(v58, v54:Get(v55 + 120 * v56 / v41))
                        v55 = v55 + 120 * v56
                    end
                    v34.CFrame = u17
                    _G.destroy(v34, 0.4)
                end)
                task.wait(0.05)
            end
            task.spawn(function() --[[ Line: 116 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                    [3] = u10
                    [4] = u12
                    [5] = u3
                    [6] = u11
                    [7] = u1
                    [8] = u2
                --]]
                u13.CFrame = u17
                local v59 = script.ChargeTrail:Clone()
                u10(v59, u12)
                u3.apply(v59, u11)
                local v60 = u17.Position
                local v61 = math.random(-400, 400) / 35
                local v62 = math.random(-300, 300) / 25
                local v63 = math.random(-400, 400) / 35
                v59.Position = v60 + Vector3.new(v61, v62, v63)
                v59.Parent = workspace.Effects
                local v64 = v59.CFrame
                local v65 = u17.Position
                local v66 = (v64.Position - v65).Magnitude
                local v67 = math.random(-v66 / 12.2, v66 / 8.2)
                local v68 = math.random(-v66 / 8, v66 / 4.6)
                local v69 = -math.random(v66 / 8, v66)
                local v70 = Vector3.new(v67, v68, v69)
                local v71 = v64.Position + v64.LookVector * v66 / 12 + v70
                local v72 = math.random(-v66 / 4.2, v66 / 8.2)
                local v73 = math.random(-v66 / 3, v66)
                local v74 = math.random
                local v75 = -v66 / 7.6
                local v76 = v66 / 4.6
                local v77 = Vector3.new(v72, v73, v74(v75, v76))
                local v78 = v64.Position + v64.LookVector * v66 / 7 + v77
                local v79 = u1.new(v64.Position, v71, v78, v65)
                local v80 = 1
                while v80 ~= v66 do
                    local _ = v59.Position
                    local v81 = u2.Heartbeat:Wait()
                    local v82 = v80 / v66
                    local v83 = v79:Get(v82)
                    if v82 >= 1 or v59 == nil then
                        break
                    end
                    v59.CFrame = CFrame.new(v83, v79:Get(v80 + 120 * v81 / v66))
                    v80 = v80 + 120 * v81
                end
                v59.CFrame = u17
                _G.destroy(v59, 0.4)
            end)
            task.wait(0.025)
        end
        for _, v84 in ipairs(u13:GetDescendants()) do
            if v84:IsA("ParticleEmitter") then
                v84.Enabled = false
            end
        end
        u13.CyBlastLoop:Stop()
        _G.destroy(u13, 3)
    end
end
return v4