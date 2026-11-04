 

local u1 = game:GetService("RunService")
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = p2.Bomb
        local u4 = p2.TickDuration or 1
        local u5 = Instance.new("Part")
        u5.Name = "BombHighlight"
        u5.Size = u3.Size + Vector3.new(0.5, 0.5, 0.5)
        u5.CFrame = u3.CFrame
        u5.Anchored = true
        u5.CanCollide = false
        u5.CanQuery = false
        u5.Material = Enum.Material.Neon
        u5.Color = Color3.fromRGB(248, 97, 27)
        u5.CastShadow = false
        u5.Transparency = 1
        u5.Parent = u3
        local u6 = 0
        local u7 = 0
        local u8 = false
        local u14 = u1.Heartbeat:Connect(function(p9) --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u4
                [3] = u7
                [4] = u5
                [5] = u8
                [6] = u3
            --]]
            u6 = u6 + p9
            local v10 = u6 / u4
            u7 = u7 + p9 * (math.clamp(v10, 0, 1) * 10 + 2)
            local v11 = u7 * 3.141592653589793
            local v12 = (math.sin(v11) + 1) / 2
            u5.Transparency = 1 - v12
            local v13 = v12 < 0.1
            if v13 and not u8 then
                u8 = true
                _G.PlaySound(u3, script.Beep)
            elseif not v13 then
                u8 = false
            end
        end)
        task.delay(u4 + 0.1, function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u5
            --]]
            if u14 then
                u14:Disconnect()
                u14 = nil
            end
            if u5 and u5.Parent then
                u5:Destroy()
            end
        end)
    end
}