 

local u1 = require(script.Bezier)
local u2 = game:GetService("RunService")
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 6 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
            local u4 = script.AirCannonCharge:Clone()
            u4.Parent = workspace.Effects
            local v5 = tick()
            local v6 = tick()
            local v7 = p3:FindFirstChild("Charging")
            _G.customWeld(u4, p3.PrimaryPart, CFrame.new(0, 0.5, -5), v7)
            local u8 = 1
            while p3:FindFirstChild("Charging") do
                local u9 = p3.PrimaryPart.CFrame * CFrame.new(0, 0.5, -5)
                if tick() - v6 > 0.5 then
                    local v10 = script.swirltwo:Clone()
                    local v11 = CFrame.Angles
                    local v12 = math.random(0, 180)
                    local v13 = math.rad(v12)
                    local v14 = math.random(0, 180)
                    local v15 = math.rad(v14)
                    local v16 = math.random(0, 180)
                    v10.CFrame = u9 * v11(v13, v15, (math.rad(v16)))
                    v10.Parent = workspace.Effects
                    _G.tween(v10, {
                        0.6,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = Vector3.new(15, 0.5, 15),
                        ["Transparency"] = 1
                    })
                    _G.destroy(v10, 0.6)
                    v6 = tick()
                end
                if tick() - v5 > 0.3 then
                    v5 = tick()
                    task.spawn(function() --[[ Line: 40 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u9
                        --]]
                        u8 = u8 == 1 and 2 or 1
                        local v17 = u9
                        local v18 = CFrame.Angles
                        local v19 = math.random(0, 360)
                        local v20 = math.rad(v19)
                        local v21 = math.random(0, 360)
                        local v22 = math.rad(v21)
                        local v23 = math.random(0, 360)
                        local v24 = v17 * v18(v20, v22, (math.rad(v23)))
                        local v25 = script.trail:Clone()
                        v25.CFrame = v24 * CFrame.new(0, 0, -10)
                        v25.Parent = workspace.Effects
                        for v26 = 0, 1000, 10 do
                            local v27 = (u8 == 1 and 12 or 13) - v26 / 100
                            local v28 = u8 == 1 and v26 and v26 or -v26
                            local v29 = CFrame.new
                            local v30 = math.rad(v26)
                            local v31 = v27 * math.cos(v30)
                            local v32 = math.rad(v28)
                            v25.CFrame = v24 * v29(v31, v27 * math.sin(v32), 0)
                            task.wait()
                        end
                        _G.destroy(v25, 1)
                    end)
                    task.spawn(function() --[[ Line: 60 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u9
                            [3] = u1
                            [4] = u2
                        --]]
                        u4.CFrame = u9
                        local v33 = script.ChargeTrail:Clone()
                        local v34 = u9.Position
                        local v35 = math.random(-700, 700) / 35
                        local v36 = math.random(-300, 300) / 25
                        local v37 = math.random(-700, 700) / 35
                        v33.Position = v34 + Vector3.new(v35, v36, v37)
                        v33.Parent = workspace.Effects
                        local v38 = v33.CFrame
                        local v39 = u9.Position
                        local v40 = (v38.Position - v39).Magnitude
                        local v41 = math.random(-v40 / 12.2, v40 / 8.2)
                        local v42 = math.random(-v40 / 8, v40 / 4.6)
                        local v43 = -math.random(v40 / 8, v40)
                        local v44 = Vector3.new(v41, v42, v43)
                        local v45 = v38.Position + v38.LookVector * v40 / 12 + v44
                        local v46 = math.random(-v40 / 4.2, v40 / 8.2)
                        local v47 = math.random(-v40 / 3, v40)
                        local v48 = math.random
                        local v49 = -v40 / 7.6
                        local v50 = v40 / 4.6
                        local v51 = Vector3.new(v46, v47, v48(v49, v50))
                        local v52 = v38.Position + v38.LookVector * v40 / 7 + v51
                        local v53 = u1.new(v38.Position, v45, v52, v39)
                        local v54 = 1
                        while v54 ~= v40 do
                            local _ = v33.Position
                            local v55 = u2.Heartbeat:Wait()
                            local v56 = v54 / v40
                            local v57 = v53:Get(v56)
                            if v56 >= 1 or v33 == nil then
                                break
                            end
                            v33.CFrame = CFrame.new(v57, v53:Get(v54 + 120 * v55 / v40))
                            v54 = v54 + 120 * v55
                        end
                        _G.destroy(v33, 0.4)
                    end)
                    task.wait(0.05)
                end
                task.spawn(function() --[[ Line: 101 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u9
                        [3] = u1
                        [4] = u2
                    --]]
                    u4.CFrame = u9
                    local v58 = script.ChargeTrail:Clone()
                    local v59 = u9.Position
                    local v60 = math.random(-700, 700) / 35
                    local v61 = math.random(-300, 300) / 25
                    local v62 = math.random(-700, 700) / 35
                    v58.Position = v59 + Vector3.new(v60, v61, v62)
                    v58.Parent = workspace.Effects
                    local v63 = v58.CFrame
                    local v64 = u9.Position
                    local v65 = (v63.Position - v64).Magnitude
                    local v66 = math.random(-v65 / 12.2, v65 / 8.2)
                    local v67 = math.random(-v65 / 8, v65 / 4.6)
                    local v68 = -math.random(v65 / 8, v65)
                    local v69 = Vector3.new(v66, v67, v68)
                    local v70 = v63.Position + v63.LookVector * v65 / 12 + v69
                    local v71 = math.random(-v65 / 4.2, v65 / 8.2)
                    local v72 = math.random(-v65 / 3, v65)
                    local v73 = math.random
                    local v74 = -v65 / 7.6
                    local v75 = v65 / 4.6
                    local v76 = Vector3.new(v71, v72, v73(v74, v75))
                    local v77 = v63.Position + v63.LookVector * v65 / 7 + v76
                    local v78 = u1.new(v63.Position, v70, v77, v64)
                    local v79 = 1
                    while v79 ~= v65 do
                        local _ = v58.Position
                        local v80 = u2.Heartbeat:Wait()
                        local v81 = v79 / v65
                        local v82 = v78:Get(v81)
                        if v81 >= 1 or v58 == nil then
                            break
                        end
                        v58.CFrame = CFrame.new(v82, v78:Get(v79 + 120 * v80 / v65))
                        v79 = v79 + 120 * v80
                    end
                    _G.destroy(v58, 0.4)
                end)
                task.wait(0.025)
            end
            for _, v83 in ipairs(u4:GetDescendants()) do
                if v83:IsA("ParticleEmitter") then
                    v83.Enabled = false
                end
            end
            _G.destroy(u4, 3)
        end
    end
}