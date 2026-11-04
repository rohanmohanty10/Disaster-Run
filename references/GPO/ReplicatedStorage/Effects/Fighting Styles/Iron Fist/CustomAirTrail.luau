 

local u1 = game:GetService("RunService")
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.Position
        local u4 = p2.Direction
        local u5 = p2.Duration or math.random(50, 100) / 100
        local u6 = p2.Speed or math.random(40, 150)
        local u7 = p2.Width or 1
        local v8 = p2.Color
        if typeof(v8) == "Color3" then
            p2.Color = ColorSequence.new(p2.Color)
        end
        local u9 = script.trail:Clone()
        u9.Trail.Brightness = p2.Brightness or 100
        u9.Trail.Color = p2.Color
        if p2.Texture then
            u9.Trail.Texture = p2.Texture
        end
        u9.Position = v3
        local v10 = p2.Color
        if typeof(v10) == "Color3" then
            u9.Trail.Color = ColorSequence.new(p2.Color)
        else
            local v11 = p2.Color
            if typeof(v11) == "ColorSequence" then
                u9.Trail.Color = p2.Color
            end
        end
        if p2.LightEmission then
            u9.Trail.LightEmission = p2.LightEmission
        end
        u9.Parent = workspace.Effects
        local u12 = not p2.startSmallPercent and 0.5 or p2.startSmallPercent
        local u13 = 0
        local u14 = p2.Amplitude or Random.new():NextNumber(-5, 5)
        local u15 = { math.random(3, 5), math.random(3, 5), math.random(3, 5) }
        local u16 = { 6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random() }
        local u28 = u1.Heartbeat:Connect(function(p17) --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u5
                [3] = u9
                [4] = u12
                [5] = u7
                [6] = u4
                [7] = u6
                [8] = u15
                [9] = u16
                [10] = u14
            --]]
            u13 = u13 + p17
            local v18 = 1 - u13 / u5
            u9.Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(u12, v18 * 0.5 * u7, 0), NumberSequenceKeypoint.new(1, 0, 0) })
            u9.Trail.Lifetime = v18 * 0.25
            local v19 = u9
            local v20 = v19.Position
            local v21 = u4 * u6 * v18 * p17
            local v22 = u13 * u15[1] + u16[1]
            local v23 = math.sin(v22)
            local v24 = u13 * u15[2] + u16[2]
            local v25 = math.sin(v24)
            local v26 = u13 * u15[3] + u16[3]
            local v27 = math.sin(v26)
            v19.Position = v20 + (v21 + Vector3.new(v23, v25, v27) * u14 * p17)
        end)
        task.delay(u5, function() --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u9
            --]]
            u28:Disconnect()
            u28 = nil
            u9:Destroy()
        end)
    end
}