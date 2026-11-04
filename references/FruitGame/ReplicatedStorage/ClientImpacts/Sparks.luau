 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        local v2 = p1.rep
        local v3 = p1.vel
        local v4 = p1.cf
        if _G.checkRenderDistance(v4.p) ~= false then
            local v5, v6, v7 = unpack(v3)
            local v8 = math.random(20, 75) / 100
            local u9 = Instance.new("NumberValue", game.ReplicatedStorage)
            u9.Value = v8
            local v10 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(u9, v10, {
                ["Value"] = 0
            }):Play()
            _G.destroy(u9, 2)
            for _ = 1, v2 do
                local u11 = script.Spark:Clone()
                u11.Parent = workspace.Effects
                u11.CFrame = v4
                local v12 = math.random(-v5, v5)
                local v13 = math.random(v6 / 1.25, v6)
                local v14 = math.random
                local v15 = -v7
                u11.Velocity = Vector3.new(v12, v13, v14(v15, v7))
                u11.Size = u11.Size * v8
                u11.Trail.WidthScale = NumberSequence.new(v8, 0)
                u9.Changed:Connect(function() --[[ Line: 32 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                        [2] = u9
                    --]]
                    u11.Trail.WidthScale = NumberSequence.new(u9.Value, 0)
                end)
                _G.destroy(u11, 2)
            end
        end
    end
}