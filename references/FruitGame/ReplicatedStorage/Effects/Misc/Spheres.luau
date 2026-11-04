 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.cf.Position) ~= false then
            local _ = p1.w
            local v2 = p1.cf
            local v3 = p1.part
            local v4 = p1.range
            local v5 = p1.minThick
            local v6 = p1.maxThick
            local u7 = p1.ti
            local u8 = p1.ti2
            local v9 = p1.color
            local v10 = p1.am
            local v11 = p1.startSize
            local v12 = p1.xrange
            local v13 = p1.yrange
            local v14 = p1.zrange
            local v15
            if v12 == nil then
                v12 = v4
                v14 = v12
                v13 = v14
                local v16 = v12
                v12 = v13
                v16 = v14
                v14 = v12
                v16 = v13
                v15 = nil
            else
                v15 = v13 / 10
            end
            for _ = 1, v10 do
                if v3 then
                    v2 = v3.CFrame
                end
                local u17 = script.sphere:Clone()
                u17.Color = v9
                local v18 = v2 * CFrame.new(math.random(-v12, v12), math.random(v15 or -v13, v13), math.random(-v14, v14))
                u17.CFrame = CFrame.new(v2.Position, v18.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                local v19 = math.random(v5, v6)
                local u20 = (v18.Position - v2.Position).Magnitude
                if v11 then
                    u17.Mesh.Scale = v11
                end
                u17.Parent = workspace.Effects
                _G.tween(u17, {
                    u7,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = CFrame.new(v18.Position, v2.Position) * CFrame.Angles(-1.5707963267948966, 0, 0),
                    ["Size"] = Vector3.new(0, 1, 0)
                })
                local v21 = _G.tween
                local v22 = u17.Mesh
                local v23 = {
                    u7,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v24 = {
                    ["Scale"] = Vector3.new(v19, u20, v19)
                }
                local v25 = -u20 / 2
                v24.Offset = Vector3.new(0, v25, 0)
                v21(v22, v23, v24)
                task.spawn(function() --[[ Line: 43 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u17
                        [3] = u8
                        [4] = u20
                    --]]
                    _G.fw(u7 / 2)
                    if u17:FindFirstChild("Mesh") then
                        local v26 = _G.tween
                        local v27 = u17.Mesh
                        local v28 = {
                            u8,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }
                        local v29 = {
                            ["Scale"] = Vector3.new(0, 0, 0)
                        }
                        local v30 = -u20
                        v29.Offset = Vector3.new(0, v30, 0)
                        v26(v27, v28, v29)
                    end
                end)
                _G.destroy(u17, u8 * 2 + u7)
            end
        end
    end
}