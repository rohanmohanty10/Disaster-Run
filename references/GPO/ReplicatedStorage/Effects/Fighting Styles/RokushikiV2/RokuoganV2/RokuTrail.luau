 

local u1 = game:GetService("RunService")
return function(p2) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = p2.Position
    local u4 = p2.Direction
    local u5 = p2.Duration or math.random(50, 100) / 100
    local u6 = p2.Speed or math.random(40, 150)
    local u7 = p2.Width or 1
    local u8 = script.trail:Clone()
    u8.Position = v3
    if p2.Color then
        u8.Trail.Color = p2.Color
    end
    u8.Parent = workspace
    local u9 = 0
    local u10 = p2.Amplitude or Random.new():NextNumber(-5, 5)
    local u11 = { math.random(3, 5), math.random(3, 5), math.random(3, 5) }
    local u12 = { 6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random() }
    local u24 = u1.Heartbeat:Connect(function(p13) --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u5
            [3] = u8
            [4] = u7
            [5] = u4
            [6] = u6
            [7] = u11
            [8] = u12
            [9] = u10
        --]]
        u9 = u9 + p13
        local v14 = 1 - u9 / u5
        u8.Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.5, v14 * 0.5 * u7, 0), NumberSequenceKeypoint.new(1, 0, 0) })
        u8.Trail.Lifetime = v14 * 0.25
        local v15 = u8
        local v16 = v15.Position
        local v17 = u4 * u6 * v14 * p13
        local v18 = u9 * u11[1] + u12[1]
        local v19 = math.sin(v18)
        local v20 = u9 * u11[2] + u12[2]
        local v21 = math.sin(v20)
        local v22 = u9 * u11[3] + u12[3]
        local v23 = math.sin(v22)
        v15.Position = v16 + (v17 + Vector3.new(v19, v21, v23) * u10 * p13)
    end)
    task.delay(u5, function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u8
        --]]
        u24:Disconnect()
        u24 = nil
        u8:Destroy()
    end)
end