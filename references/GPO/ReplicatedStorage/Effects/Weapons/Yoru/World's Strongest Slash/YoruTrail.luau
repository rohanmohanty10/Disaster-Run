 

local u1 = game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return function(p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v4 = p3.Position
    local u5 = p3.Direction
    local u6 = p3.Duration or math.random(50, 100) / 100
    local u7 = p3.Speed or math.random(40, 150)
    local u8 = p3.Width or 1
    local u9 = script.trail:Clone()
    u9.Position = v4
    if p3.Color then
        u9.Trail.Color = ColorSequence.new(p3.Color)
        u2.apply(u9, p3.Character)
    end
    u9.Parent = workspace
    local u10 = 0
    local u11 = p3.Amplitude or Random.new():NextNumber(-5, 5)
    local u12 = { math.random(3, 5), math.random(3, 5), math.random(3, 5) }
    local u13 = { 6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random() }
    local u25 = u1.Heartbeat:Connect(function(p14) --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u6
            [3] = u9
            [4] = u8
            [5] = u5
            [6] = u7
            [7] = u12
            [8] = u13
            [9] = u11
        --]]
        u10 = u10 + p14
        local v15 = 1 - u10 / u6
        u9.Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.5, v15 * 0.5 * u8, 0), NumberSequenceKeypoint.new(1, 0, 0) })
        u9.Trail.Lifetime = v15 * 0.25
        local v16 = u9
        local v17 = v16.Position
        local v18 = u5 * u7 * v15 * p14
        local v19 = u10 * u12[1] + u13[1]
        local v20 = math.sin(v19)
        local v21 = u10 * u12[2] + u13[2]
        local v22 = math.sin(v21)
        local v23 = u10 * u12[3] + u13[3]
        local v24 = math.sin(v23)
        v16.Position = v17 + (v18 + Vector3.new(v20, v22, v24) * u11 * p14)
    end)
    task.delay(u6, function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u9
        --]]
        u25:Disconnect()
        u25 = nil
        u9:Destroy()
    end)
end