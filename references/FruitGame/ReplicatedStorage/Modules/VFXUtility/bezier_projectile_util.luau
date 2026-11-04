 

return {
    ["SpawnProjectiles"] = function(p1) --[[ Name: SpawnProjectiles, Line 46 ]]
        local v2 = p1.root
        local u3 = p1.projectile
        local u4 = p1.onHit or function() --[[ Line: 49 ]] end
        local v5 = p1.count or 1
        local v6 = p1.spreadRadius or 5
        local v7 = p1.startHeight or 5
        local u8 = p1.duration or 1
        local u9 = p1.arcHeight or 10
        local v10 = p1.evenlySpaced or false
        local u11 = p1.rotate or false
        local v12 = p1.spawnDelay or 0
        local u13 = p1.lifetime or 1
        local u14 = v2.Position + Vector3.new(0, v7, 0)
        for v15 = 1, v5 do
            local v16
            if v10 then
                local v17 = v15 / v5 * 3.141592653589793 * 2
                local v18 = math.cos(v17) * v6
                local v19 = math.sin(v17) * v6
                v16 = Vector3.new(v18, 0, v19)
            else
                local v20 = math.random(-v6, v6)
                local v21 = math.random
                local v22 = -v6
                v16 = Vector3.new(v20, 0, v21(v22, v6))
            end
            local u23 = v2.Position + v16
            local v24 = math.random() * v12
            task.delay(v24, function() --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u14
                    [3] = u23
                    [4] = u9
                    [5] = u8
                    [6] = u4
                    [7] = u13
                    [8] = u11
                --]]
                local u25 = u3:Clone()
                u25.CFrame = CFrame.new(u14)
                u25.Parent = workspace.Effects
                local v26 = u9
                local u27 = (u14 + u23) / 2 + Vector3.new(0, v26, 0)
                local u28 = u8 / 30
                local u29 = 0
                local u30 = nil
                u30 = game:GetService("RunService").Heartbeat:Connect(function(p31) --[[ Line: 98 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u28
                        [3] = u30
                        [4] = u25
                        [5] = u4
                        [6] = u13
                        [7] = u14
                        [8] = u27
                        [9] = u23
                        [10] = u11
                    --]]
                    u29 = u29 + p31 / u28
                    if u29 >= 30 then
                        u30:Disconnect()
                        if u25 and u25.Parent then
                            for _, v32 in ipairs(u25:GetChildren()) do
                                if v32:IsA("ParticleEmitter") then
                                    v32:Emit(v32:GetAttribute("EmitCount") or 30)
                                end
                            end
                            u4(u25.Position, u25)
                            task.delay(u13, function() --[[ Line: 110 ]]
                                --[[
                                Upvalues:
                                    [1] = u25
                                --]]
                                if u25 and u25.Parent then
                                    u25:Destroy()
                                end
                            end)
                            return
                        end
                    else
                        local v33 = u29 / 30
                        local v34 = u14
                        local v35 = u27
                        local v36 = u23
                        local v37 = (1 - v33) ^ 2 * v34 + 2 * (1 - v33) * v33 * v35 + v33 ^ 2 * v36
                        u25.CFrame = CFrame.new(v37)
                        if u11 then
                            local v38 = (u23 - v37).Unit
                            u25.CFrame = CFrame.new(v37, v37 + v38)
                        end
                    end
                end)
            end)
        end
    end
}