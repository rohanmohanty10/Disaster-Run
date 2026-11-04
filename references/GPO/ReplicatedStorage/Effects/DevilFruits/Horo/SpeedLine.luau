 

return {
    ["start"] = function(_, u1, _, u2, u3, p4) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(u1.Position) ~= false then
            local u5 = nil
            local u6 = 0
            local u7 = u1.CFrame.Position
            local u8 = 5
            local u9 = 50
            local u10 = 100
            local u11 = 3
            local u12 = 1
            if p4 then
                if p4.preTi then
                    u6 = p4.preTi
                end
                if p4.speed then
                    u8 = p4.speed
                end
                if p4.maxSpeed then
                    u9 = p4.maxSpeed
                end
                if p4.speedDiv then
                    u10 = p4.speedDiv
                end
                if p4.range then
                    u11 = p4.range
                end
                if p4.widthMult then
                    u12 = p4.widthMult
                end
            end
            local u13 = u1.CFrame.Position
            local u14 = false
            local u15 = tick()
            local _ = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u2
                    [3] = u5
                    [4] = u1
                    [5] = u3
                    [6] = u7
                    [7] = u14
                    [8] = u8
                    [9] = u9
                    [10] = u13
                    [11] = u6
                    [12] = u10
                    [13] = u11
                    [14] = u12
                --]]
                if u2 <= tick() - u15 then
                    u5:Disconnect()
                    u5 = nil
                end
                local v16 = CFrame.new(u1.Position, u3.Position)
                if (u7 - v16.Position).Magnitude >= 10 then
                    Color3.fromRGB(255, 255, 255)
                    if u14 == false then
                        Color3.fromRGB(0, 0, 0)
                    end
                    u7 = v16.Position
                end
                u8 = u9 / (v16.Position - u13).Magnitude
                if tick() - u6 >= u8 / u10 then
                    u6 = tick()
                    local v17 = script.Part:Clone()
                    v17.CFrame = v16 * CFrame.new(math.random(-u11 * 100, u11 * 100) / 100, math.random(-u11 * 100, u11 * 100) / 100, math.random(-u11 * 3, u11))
                    local v18 = (v16.Position - u13).Magnitude / 2 + 80
                    local v19 = math.random(v18 / 2, v18) / 10
                    local v20 = math.random(1, 5) / 10 * u12
                    v17.Mesh.Scale = Vector3.new(v20, v20, v19)
                    local v21 = v17.Mesh
                    local v22 = -v19 / 2
                    v21.Offset = Vector3.new(0, 0, v22)
                    u14 = not u14
                    if u14 == true then
                        v17.Transparency = 0.5
                        v17.Color = Color3.fromRGB(0, 0, 0)
                    end
                    v17.Parent = workspace.Effects
                    local v23 = math.random(100, 200) / 1000
                    u8 = (v16.Position - u13).Magnitude / 10
                    _G.tween(v17, {
                        v23,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        true,
                        0
                    }, {
                        ["Transparency"] = 1,
                        ["CFrame"] = v17.CFrame * CFrame.new(0, 0, math.random(u8 / 2, u8))
                    })
                    local v24 = _G.tween
                    local v25 = v17.Mesh
                    local v26 = {
                        v23,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.In,
                        0,
                        true,
                        0
                    }
                    local v27 = {
                        ["Scale"] = Vector3.new(v20, v20, 0)
                    }
                    local v28 = v19 / 2
                    v27.Offset = Vector3.new(0, 0, v28)
                    v24(v25, v26, v27)
                    _G.destroy(v17, v23)
                end
            end)
        end
    end
}