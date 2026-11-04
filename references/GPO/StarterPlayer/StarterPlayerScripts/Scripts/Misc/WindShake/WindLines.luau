 

local u1 = game:GetService("RunService")
local u2 = workspace:FindFirstChildOfClass("Terrain")
local u3 = {}
local u35 = {
    ["UpdateQueue"] = table.create(10),
    ["Init"] = function(_, p4) --[[ Name: Init, Line 13 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u1
        --]]
        u35.Lifetime = p4.Lifetime or 3
        u35.Direction = p4.Direction or Vector3.new(1, 0, 0)
        u35.Speed = p4.Speed or 6
        if u35.UpdateConnection then
            u35.UpdateConnection:Disconnect()
            u35.UpdateConnection = nil
        end
        for _, v5 in u35.UpdateQueue do
            v5.Attachment0:Destroy()
            v5.Attachment1:Destroy()
            v5.Trail:Destroy()
        end
        table.clear(u35.UpdateQueue)
        u35.LastSpawned = tick()
        local u6 = 1 / (p4.SpawnRate or 25)
        u35.UpdateConnection = u1.Heartbeat:Connect(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u6
            --]]
            local v7 = tick()
            if u6 < v7 - u35.LastSpawned then
                u35:Create()
                u35.LastSpawned = v7
            end
            debug.profilebegin("Wind Lines")
            for v8, v9 in u35.UpdateQueue do
                local v10 = v7 - v9.StartClock
                if v9.Lifetime <= v10 then
                    v9.Attachment0:Destroy()
                    v9.Attachment1:Destroy()
                    v9.Trail:Destroy()
                    local v11 = #u35.UpdateQueue
                    u35.UpdateQueue[v8] = u35.UpdateQueue[v11]
                    u35.UpdateQueue[v11] = nil
                else
                    v9.Trail.MaxLength = 20 - 20 * (v10 / v9.Lifetime)
                    local v12 = (v7 + v9.Seed) * (v9.Speed * 0.2)
                    local v13 = v9.Position
                    local v14 = v9.Attachment0
                    local v15 = (CFrame.new(v13, v13 + v9.Direction) * CFrame.new(0, 0, v9.Speed * -v10)).Position
                    local v16 = math.sin(v12) * 0.5
                    local v17 = math.sin(v12) * 0.8
                    local v18 = math.sin(v12) * 0.5
                    v14.WorldPosition = v15 + Vector3.new(v16, v17, v18)
                    v9.Attachment1.WorldPosition = v9.Attachment0.WorldPosition + Vector3.new(0, 0.1, 0)
                end
            end
            debug.profileend()
        end)
    end,
    ["Cleanup"] = function(_) --[[ Name: Cleanup, Line 81 ]]
        --[[
        Upvalues:
            [1] = u35
        --]]
        if u35.UpdateConnection then
            u35.UpdateConnection:Disconnect()
            u35.UpdateConnection = nil
        end
        for _, v19 in u35.UpdateQueue do
            v19.Attachment0:Destroy()
            v19.Attachment1:Destroy()
            v19.Trail:Destroy()
        end
        table.clear(u35.UpdateQueue)
    end,
    ["Create"] = function(_, p20) --[[ Name: Create, Line 97 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u35
            [3] = u2
        --]]
        debug.profilebegin("Add Wind Line")
        local v21 = p20 or u3
        local v22 = v21.Lifetime or u35.Lifetime
        local v23 = v21.Position
        if not v23 then
            local v24 = workspace.CurrentCamera.CFrame
            local v25 = CFrame.Angles
            local v26 = math.random(-30, 70)
            local v27 = math.rad(v26)
            local v28 = math.random(-80, 80)
            v23 = v24 * v25(v27, math.rad(v28), 0) * CFrame.new(0, 0, math.random(200, 600) * -0.1).Position
        end
        local v29 = v21.Direction or u35.Direction
        local v30 = v21.Speed or u35.Speed
        if v30 > 0 then
            local v31 = Instance.new("Attachment")
            local v32 = Instance.new("Attachment")
            local v33 = Instance.new("Trail")
            v33.Attachment0 = v31
            v33.Attachment1 = v32
            v33.WidthScale = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.3),
                NumberSequenceKeypoint.new(0.2, 1),
                NumberSequenceKeypoint.new(0.8, 1),
                NumberSequenceKeypoint.new(1, 0)
            })
            v33.Transparency = NumberSequence.new(0.7)
            v33.FaceCamera = true
            v33.Parent = v31
            v31.WorldPosition = v23
            v32.WorldPosition = v23 + Vector3.new(0, 0.1, 0)
            local v34 = {
                ["Attachment0"] = v31,
                ["Attachment1"] = v32,
                ["Trail"] = v33,
                ["Lifetime"] = v22 + math.random(-10, 10) * 0.1,
                ["Position"] = v23,
                ["Direction"] = v29,
                ["Speed"] = v30 + math.random(-10, 10) * 0.1,
                ["StartClock"] = tick(),
                ["Seed"] = math.random(1, 1000) * 0.1
            }
            u35.UpdateQueue[#u35.UpdateQueue + 1] = v34
            v31.Parent = u2
            v32.Parent = u2
            debug.profileend()
        end
    end
}
return u35